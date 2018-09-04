//-------------------------------------------------------------------------*
// 文件名: isr.c                                                           *
// 说  明: 中断处理例程                                                    *
//---------------苏州大学飞思卡尔嵌入式系统实验室2011年--------------------*

#include "includes.h"
#include "common.h"
#include "DMA.h"
#include "ImageGet.h"
#include "Pit.h"
#include "RunControl.h"
#include "Debug.h"

uint32 ErrorCountNow9 = 0;

uint8 QuadChangeFlag = 0;       //左右编码器切换标志位 
uint32 QuadLeftCount = 0;       //左编码器计数值，越大表示速度越快。
uint32 QuadRightCount = 0;      //右编码器计数值，越大表示速度越快。
uint8 PIT0Count = 0;            //PIT0计数值

uint16 DiffCountL = 0;        //用于差速测量时，左轮脉冲数的总计数。
uint16 DiffCountR = 0;        //用于差速测量时，右轮脉冲数的总计数。

uint8 PIT2_Isr_Change = 0;    //PIT2的功能复用选择。0表示用于发车时的5秒计数，1表示用于定时停车。
uint8 LightHouseWaitStartTooLongFlag = 0;   //灯塔等久标志位置位
volatile uint8 QuadDoneFlag = 0;         //编码器速度值采集完成标志，0未完成，1完成。

//串口相关
uint8 ch0;
uint8 ch1;
uint8 ch2;
uint8 ch3;
uint8 ch4;
uint8 ch5;
uint8 ch6;
uint8 cnt = 0;

//-------------------------------------------------------------------------*
//函数名: uart3_isr                                                        *
//功  能: 串口3数据接收中断例程                                            *
//说  明: 无                                                               *
//-------------------------------------------------------------------------*
void uart0_isr(void)
{
    uint8 ch;
    DisableInterrupts;		//关总中断
    
    if(cnt == 0){uart_re1 (UART0,&ch0);cnt++;}
    if(cnt == 1){uart_re1 (UART0,&ch1);cnt++;}
    if(cnt == 2){uart_re1 (UART0,&ch2);cnt++;}
    if(cnt == 3){uart_re1 (UART0,&ch3);cnt++;}
    if(cnt == 4){uart_re1 (UART0,&ch4);cnt++;}
    if(cnt == 5){uart_re1 (UART0,&ch5);cnt++;}
    if(cnt == 6)
    {
        uart_re1 (UART0,&ch6);cnt=0;
        if(ch0==0xFF && ch1==0x55 && ch2==0xAA && ch3==0x77 && ch4==0x01 && ch5==0x06 && ch6==0x7C)
        {
            uart_sendN(UART0, (uint8 *)"\nCar Start!", 11);
            StopRealFlag = 0;
            light_control(PORTE, 26, Light_ON);
        }
        if(ch0==0xFF && ch1==0x55 && ch2==0xAA && ch3==0x77 && ch4==0x01 && ch5==0x07 && ch6==0x7D)
        {
            uart_sendN(UART0, (uint8 *)"\nCar Stop!", 10);
            StopRealFlag = 1;
            light_control(PORTE, 26, Light_OFF);
        }
    }
    
	EnableInterrupts;		//开总中断
}

//------------------------------------------------------------------------------
//函数名：PIT0_Isr
//功  能：周期中断定时器PIT0中断服务函数
//参  数：无
//返  回：无
//说  明：
    //暂定5ms进一次中断，进两次采集完两个编码器的值。
    //图像采集完成后、图像处理前，开启这个中断，与图像处理并行。
    //第2次进来时关掉这个中断。
//------------------------------------------------------------------------------
void PIT0_Isr(void)
{       
    if((PIT_TFLG(0)&PIT_TFLG_TIF_MASK)!=0)
    {
      PIT_TFLG(0) |= PIT_TFLG_TIF_MASK;  //清中断标志
    }
    
    //gpio_reverse(PORTE, 26);
    
    //计数值加1。
    //PIT0Count++;
    //编码器速度值采集完成标志，0未完成，1完成。
    //QuadDoneFlag = 0;    
    QuadLeftCount = FTM2_CNT;    //记录记数器的值。
    FTM2_CNT = 0; 
    
    //禁止PIT。很关键的一步，使得下一次从头开始倒数。
    PIT_TCTRL(PIT0) &= ~(PIT_TCTRL_TEN_MASK);       //禁止pit模块运行
    //关掉中断。
    disable_pit_interrupt(PIT0);
    //编码器速度值采集完成标志，0未完成，1完成。
    QuadDoneFlag = 1; 
}
/*
void PIT0_Isr(void)
{       
    if((PIT_TFLG(0)&PIT_TFLG_TIF_MASK)!=0)
    {
      PIT_TFLG(0) |= PIT_TFLG_TIF_MASK;  //清中断标志
    }
    
    //gpio_reverse(PORTE, 26);
    
    //计数值加1。
    PIT0Count++;
    //编码器速度值采集完成标志，0未完成，1完成。
    QuadDoneFlag = 0;         

    if(QuadChangeFlag == 0)
    {
      QuadChangeFlag = 1;          //切换至右编码器的标志。
      QuadLeftCount = FTM2_CNT;    //记录记数器的值。
      
      DiffCountL += QuadLeftCount;
      
      FTM2_CNT = 0;                //计数器清零。
      //右路A相 A10, B相 A11。打开。
      PORTA_PCR10 = PORT_PCR_MUX(6); // 设置引脚A10为FTM2_PHA功能  
      PORTA_PCR11 = PORT_PCR_MUX(6); // 设置引脚A11为FTM2_PHB功能   
      //左路A相 B18, B相 B19。置为无效复用。
      PORTB_PCR18 = PORT_PCR_MUX(5); // 设置引脚B18为无效复用。
      PORTB_PCR19 = PORT_PCR_MUX(5); // 设置引脚B19为无效复用。   
    }
    else
    {
      QuadChangeFlag = 0;          //切换至左编码器的标志。
      QuadRightCount = FTM2_CNT;   //记录记数器的值。
      
      DiffCountR += QuadRightCount;
      
      FTM2_CNT = 0;                //计数器清零。
      //左路A相 B18, B相 B19。打开。
      PORTB_PCR18 = PORT_PCR_MUX(6); // 设置引脚B18为FTM2_PHA功能  
      PORTB_PCR19 = PORT_PCR_MUX(6); // 设置引脚B19为FTM2_PHB功能   
      //右路A相 A10, B相 A11。置为无效复用。
      PORTA_PCR10 = PORT_PCR_MUX(5); // 设置引脚A10为无效复用。
      PORTA_PCR11 = PORT_PCR_MUX(5); // 设置引脚A11为无效复用。 
      
      //禁止PIT。很关键的一步，使得下一次从头开始倒数。
      PIT_TCTRL(PIT0) &= ~(PIT_TCTRL_TEN_MASK);       //禁止pit模块运行
      //关掉中断。
      disable_pit_interrupt(PIT0);
      //编码器速度值采集完成标志，0未完成，1完成。
      QuadDoneFlag = 1; 
      
      
      
    }
    
     
}
*/
void PIT1_Isr(void)
{       
    if((PIT_TFLG(1)&PIT_TFLG_TIF_MASK)!=0)
    {
      PIT_TFLG(1) |= PIT_TFLG_TIF_MASK;  //清中断标志
    }
    //FTM0_C7V = 0;
    TimeOutFlag = 1;
}
//------------------------------------------------------------------------------
//函数名：PIT2_Isr
//功  能：周期中断定时器PIT2中断服务函数
//参  数：无
//返  回：无
//说  明：1. 用来定时跑车计数
//
//------------------------------------------------------------------------------
void PIT2_Isr(void)
{
  if((PIT_TFLG(2)&PIT_TFLG_TIF_MASK)!=0)
  {
    PIT_TFLG(2) |= PIT_TFLG_TIF_MASK;  //清中断标志
  }
  
  //第一种功能是灯塔发车的5秒计时。
  if(PIT2_Isr_Change == 0)
  {
    //改用第二种功能。
    PIT2_Isr_Change = 1;
    
    //灯塔等久标志位置位
    LightHouseWaitStartTooLongFlag = 1;    
    //进来一次后就不用再进来了。如果需要定时停车，需要重新给计数值后，再enable一次。
    disable_pit_interrupt(PIT2);
  }
  //第二种功能是定时停车计时。
  else
  {
    //定时跑标志置1。表示定时跑完成，应该马上停车。
    TimeRealRunFlag = 1;
    //进来一次后就不用再进来了。一辈子只进来一次。
    disable_pit_interrupt(PIT2);
  }
  

  
}

//DMA0传输结束函数，由PCLK触发，B9
//这些处理放在这里，而不是放在LineIsr的原因是LineIsr进入后要马上开始采数据，来不及
void DMA0_Isr(void)
{
  
    uint8 DMACHno = 0;
  
    ErrorCountNow9++;
    
    
    DMA_INT |= (1 << DMACHno);    //清DMA0通道传输完成中断标志位
    LineCount++;              //采集行计数值加1
    
    if(LineCount >= CameraHight)   //如果采集完成
    {
        ImgStatus = ImgGetFinish;    //图像采集结束标志位
           
        if(ImgPresent == ImgNO1)  
        //如果当前采集的是第1幅图像，那么第1幅图像就采集完了，准备采集第2幅图像
        {
            ImgPresent = ImgNO2;  
        }
        else if(ImgPresent == ImgNO2)
        //如果当前采集的是第2幅图像，那么第2幅图像就采集完了，准备采集第1幅图像
        {
            ImgPresent = ImgNO1;
        }
        else
        {
            //uart_sendN(UART0, (uint8 *)"\nError In DMA0_Isr()!", 21);  //错误警告 
        }
                
        //disable_irq(FIELD_IRQ);   //场中断IRQ禁用，等待下一次ImgGet()函数再开启
        disable_irq(LINE_IRQ);    //行中断IRQ禁用
        enable_irq(DMA0_IRQ);    //DMA0的IRQ禁用   
         
    }   
    
  /*
    uint8 DMACHno = 0;
    DMA_INT |= (1 << DMACHno);    //清DMA0通道传输完成中断标志位
    LineCount++;              //采集行计数值加1
    
    if(LineCount >= CameraHight)   //如果采集完成
    {
        ImgStatus = ImgGetFinish;    //图像采集结束标志位
        disable_irq(FIELD_IRQ);   //场中断IRQ禁用，等待下一次ImgGet()函数再开启
        disable_irq(LINE_IRQ);    //行中断IRQ禁用
        disable_irq(DMA0_IRQ);    //DMA0的IRQ禁用          
    }
    */
}
 

//PORTA中断服务函数
//这个的IRQ不会打开，正常情况不会进来。
void PORTA_Isr(void)  
{
    PORTA_ISFR = ~0;
    uart_sendN(UART0, (uint8 *)"\nError In PORTA_Isr()!", 22); //错误警告
}


//PORTB中断服务函数，含PCLK引发的DMA，B9
//这个的IRQ不会打开，正常情况不会进来。
void PORTB_Isr(void)  
{
    PORTB_ISFR = ~0;
    uart_sendN(UART0, (uint8 *)"\nError In PORTB_Isr()!", 22);  //错误警告
}


//PORTC中断服务函数，含行中断，C8
void PORTC_Isr(void)  
{
    uint32 FlagTmp = PORTC_ISFR;  
    PORTC_ISFR =  ~0;             //清除PORTC的所有中断标志位
    
    if(FlagTmp & (1 << PIN_LINE))   //如果确认是行中断的
    {
        LineIsr();                    //进行中断处理函数
    }
}



//PORTD中断服务函数，含场中断，D1
void PORTD_Isr(void)  
{
    uint32 FlagTmp = PORTD_ISFR;  
    PORTD_ISFR =  ~0;             //清除PORTD的所有中断标志位
    
    if(FlagTmp & (1 << PIN_FIELD))   //如果确认是场中断的
    {
        FieldIsr();                    //进场中断处理函数
    }

}



//PORTE中断服务函数
//这个的IRQ不会打开，正常情况不会进来。
void PORTE_Isr(void)  
{
    PORTE_ISFR = ~0;
    uart_sendN(UART0, (uint8 *)"\nError In PORTE_Isr()!", 22);   //错误警告
}



  

/*
void porta_isr(void)//场中断，A24，下降沿中断
{
  
	PORTA_PCR24 |= PORT_PCR_ISF_MASK;//清除中断标志
	DMA0_Init();
	enable_irq(0);//使能DMA通道0完成中断
	row=0;//初始化行
	imagerow=0;//初始化采集行
	enable_irq (88);//使能B口中断 ，B10行中断

}
*/