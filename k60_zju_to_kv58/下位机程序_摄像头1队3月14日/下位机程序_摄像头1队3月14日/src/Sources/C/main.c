/******************************************************************************
1、程序继承于12级侯佳佐学长的程序，图像部分加了补丁，但是补丁的参数都是写死的，不一定
适合所有的车。如果补丁出现问题，可以换用侯佳佐学长的程序，然后按照我在报告中提到的补丁
思路把补丁加上。

2、前期不会用到OLED、编码器、陀螺仪，可以关闭的功能我都用“（开始阶段可以先关闭）”备注
了

3、建议进阶顺序为：蓝牙工作---摄像头采图---舵机打角---电机运行---OLED调参---编码器--
-陀螺仪

4、注意，如果不关闭OLED调参功能的话，参数都是从Flash中读取的，必须保证Flash中已经设置
好了参数。建议前期关闭OLED调参功能，这些参数我都设置了默认值，关闭OLED调参功能后会以默
认参数运行。

5、图像程序，建议结合上位机来理解图像程序。在智能车报告中我用了大篇幅专门阐述了图像处理
的思路和我在侯佳佐学长图像的基础上增加的几个补丁，可以向涛哥要往届学长的报告，但愿这些
内容会对做图像的同学在开始阶段理解图像程序有所帮助。

6、停车线、十字的二重判定、堵转停车、跑出赛道停车等功能关闭了，停车线的函数是ImagePro.c
中的StopLineCheck()，十字二重判定的函数是ImagePro.c中的ShiZhiCheck()，均通过ImagePro.c
中的PathJudgeNew()调用。堵转停车和跑出赛道，可以通过搜索DuZhuanFlag和RunOutFlag找到
相关的代码。之所以关闭这些功能，是为了避免在你们还不熟悉图像程序的时候，调试中出现突然
停车的情况。

7、电机PWM的控制，1、2口被我们用来控制电机驱动板的使能了，3、4口才是控制电机转速的，使
用的时候特别注意

8、组员之间分工明确，既然决定做智能车了，就要做好以后没有课余时间的准备。控制部分多调试
积累经验，图像部分结合上位机理解不要逃避，硬件部分先用往届的板子尽早做出自己的板子，
祝愿你们取得好成绩！

******************************************************************************/
/******************************************************************************/
/*********************************
【dev.env.】IAR EWARM 6.30.1.3142
【Target  】MK60-DN512-VLQ10
【Crystal 】50.000  MHz
【busclock】75.000  MHz
【pllclock】150.000 MHz
*********************************/

// 硬件外设有：电机，舵机，编码器，OLED, 摄像头

/************************************************************/
#define MAIN_PROGRAM           //主程序测试
//#define PINREAD_DEBUG        //引脚输入测试
//#define CLOCK_DEBUG          //时钟引脚测试
//#define CAMERA_DEBUG_7725  //OV7725摄像头测试
//#define CAMERA_DEBUG_7620    //OV7620摄像头测试
//#define C_DEBUG            //C语言语法测试
//#define DAQ_DEBUG          //DAQ测试
//#define DMA_DEBUG          //DMA测试
//#define BLUETOOTH_DEBUG    //蓝牙测试
//#define SD_DEBUG            //SD卡测试
//#define MOTOR_DEBUG           //电机测试
//#define SERVO_DEBUG           //舵机测试
//#define QUAD_DEBUG            //编码器测试
//#define DIFF_DEBUG             //差速测试
//#define VIRTURL_DEBUG         //虚拟示波器测试
//#define DEBUG_DEBUG             //原来的主程序测试
//#define OLED_DEBUG               //OLED专门测试
//#define FLASH_DEBUG               //FLASH测试
//#define GYRO_DEBUG                //陀螺仪测试
//#define LIGHTHOUSE_DEBUG                //灯塔测试

/************************************************************/
//#define ERROR_PIC

//=================================主函数================================
//引脚分配：
//PORT     FUNCTION
//  A0     TCLK
//  A1     TDI
//  A2     TDO
//  A3     TMS
//  A8     编码器FTM1_QD_PHA
//  A9     编码器FTM1_QD_PHB
//  A10    编码器FTM2_QD_PHA
//  A11    编码器FTM2_QD_PHB
//  A12    舵机FTM1_CH0
//  A25    SCCB_SDA
//  A26    SCCB_SCL
//  B0~B7  摄像头数据
//  B9     PCLK
//  B16    UART0_RX
//  B17    UART0_TX
//  C8     HREF
//  C16    OLED_D0
//  C17    OLED_D1
//  C18    OLED_RST
//  C19    OLED_DC
//  D1     VSYNC
//  D4     电机FTM0_CH4左正
//  D5     电机FTM0_CH5左反
//  D6     电机FTM0_CH6右正
//  D7     电机FTM0_CH7右反
//  E0~E5  按钮（核心板上的那种小按钮）
//  E6~E9  拨码开头
//  E26    工作指示灯

#ifdef MAIN_PROGRAM

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Debug.h"
#include "Flash.h"
#include "LQ12864.h"
#include "adc.h"
#include "Fuzzy.h"
#include "BatteryCheck.h"

//延时函数
void DLY_ms(word ms)
{                         
  word a;
  while(ms)
  {
    a=13350;
    while(a--);
    ms--;
  }
  return;
}
//主程序
  void main(void)
{
    uint8 flag;  //如果有用OLED修改参数的话，参数flag会被置位
    uint32 tic1;
    uint32 tic2,tic3,tic4,tic5,tic6,tic7,tic8,tic9,tic10,tic11; //这里一堆tic是调试时用来计时的
    gpio_init(PORTD, 4, 1, 0);                                  //这四个是电机输出的引脚
    gpio_init(PORTD, 5, 1, 0);
    gpio_init(PORTD, 6, 1, 0);
    gpio_init(PORTD, 7, 1, 0);
    
    DebugInit();            //OLED,FLASH,button,switch初始化，这里会显示“Hello AE86”，（开始阶段可以先关闭）
    
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    //enableuartreint(UART0, 45);
    
    DisableInterrupts;                                    //关闭所有中断
    
    
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    light_control(PORTE, 26, Light_OFF);
    light_init(PORTD, 15, Light_ON);                      //单片机工作指示灯
    light_control(PORTD, 15, Light_OFF);
    
    pit_init(PIT0, 75000 * 5);                              //75000即为1ms，这里是5ms用于编码器
    //enable_pit_interrupt(PIT0);                         //开PIT0中断
    
    VariablesInit();      //各种变量的初始化赋值
    ServoInit();          // 初始化舵机
    
    QuadInit3();           //初始化编码器（开始阶段可以先关闭）
    
    //ADC初始化用于电池电压测量（开始阶段可以先关闭）
    hw_adc_init(0);
    //电池电压测量初始化（开始阶段可以先关闭）
    BatteryCheckInit();
    //陀螺仪初始化，包括初始温漂求取。（开始阶段可以先关闭）
    GyroInit();
    
    
    while(!CameraInit())         //初始化摄像头
    {
      uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
    }
    
    //DMA通道0， DMA触发源为PORTB， DMA源地址为B0~B7, DMA目的地址为ImgStore1数组
    while(!DMAInit(DMACH00, DMASOURCE_PORTB, CameraWidth, GPIOB_DIR_ADDR, (uint32)(ImgStore1[0])))
    {
      uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
    }
    
    
    //这儿的优先级设置的正确性有待验证============================
    //set_irq_priority(FIELD_IRQ, 2);
    //set_irq_priority(LINE_IRQ, 1);
    //set_irq_priority(DMA0_IRQ, 0);
    
    PORTD_ISFR = PORT_ISFR_ISF_MASK;       //清场所在PORT的标志位
    PORTC_ISFR = PORT_ISFR_ISF_MASK;       //清行所在PORT的标志位
    PORTB_ISFR = PORT_ISFR_ISF_MASK;       //清PCLK所在PORT的标志位
    disable_irq(LINE_IRQ);                 //关行中断IRQ
    disable_irq(DMA0_IRQ);                 //关DMA传输完成中断IRQ
    enable_irq(FIELD_IRQ);                //开场中断IRQ
    
    ImgStatus = ImgGetStart;        //图像采集标志位置为开始
    
    //初始化扫描拨码开关。
    DebugSwitchScan();
    
    EnableInterrupts;                                     //打开所有中断 
    flag = 0;                           //当用OLED修改参数后，参数flag会置位

    //拨码开关打开传图像的模式
    while(DebugSwitchFlag[3] == 1)
    {
      LCD_P8x16Str(12,3,"Send Image");
      while(ImgStatus != ImgGetFinish); //如果图像采集未结束，则一直等待。
      disable_irq(LINE_IRQ);                 //关行中断IRQ
      disable_irq(DMA0_IRQ);                 //关DMA传输完成中断IRQ
      disable_irq(FIELD_IRQ);                //关场中断IRQ
      ImageSend();
      
      PORTD_ISFR = PORT_ISFR_ISF_MASK;       //清场所在PORT的标志位
      PORTC_ISFR = PORT_ISFR_ISF_MASK;       //清行所在PORT的标志位
      PORTB_ISFR = PORT_ISFR_ISF_MASK;       //清PCLK所在PORT的标志位
      disable_irq(LINE_IRQ);                 //关行中断IRQ
      disable_irq(DMA0_IRQ);                 //关DMA传输完成中断IRQ
      enable_irq(FIELD_IRQ);                //开场中断IRQ
      ImgStatus = ImgGetStart;              //图像采集标志位置为开始
    }
    //若拨码开关1拨在1的位置，则一直用OLED调参，否则跳出while循环，正常跑车。
    while(DebugSwitchFlag[1] == 1)
    {
      flag = 1;
      //16.64ms的终点。16.64ms是OV7620采集一张图片的时间
      //tic1 = temptic2;
      //temptic2 = PIT_CVAL(1);
      
      while(ImgStatus != ImgGetFinish); //如果图像采集未结束，则一直等待。
      
      //16.64ms的起点。            
      ImgStatus = ImgGetStart;        //图像采集标志位置为开始        
  
      //使用OLED时，不能使用编码器采集，时间不够。
      
      //tic2 = PIT_CVAL(1);
      //若图像处理成功（即偏差获取成功），则进行舵机和电机的控制，否则保持原状。
      //若已经经过直角弯特殊处理，也可以进行舵机和电机的控制。
      if(ImagePro() == 1 || AngleSpeDealFlag == 1)          //图像处理  
      {
       
      }
      else
      {
        
      }

      
      ServoPID();         //舵机控制

      //tic3 = PIT_CVAL(1);
      //Debug调试，有1.拨码开关扫描，2。按键扫描，3。按键信息处理，4。OLED屏刷新。（开始阶段可以先关闭）
      DebugDebug();                 
      //toc3 = PIT_CVAL(1);
      
      //电池电压测量
      BatteryCheckUpdate();
      
      //toc1 = PIT_CVAL(1);
    }
    
    
    //若是由A0模式进入到A1模式，则执行下列操作。否则跳过。
    if(flag == 1)
    {
      //从A0模式进入A1模式。
      //A1模式标志。
      //关掉OLED。
      LCD_CLS();     
      //将更改后的最新的值写入FLASH。
      FlashFinalWrite();
      LCD_P8x16Str(12,3,"Debug Succeed");
    }
    else
    {
      LCD_P8x16Str(12,3,"Start");
    }
    
    
 

    GyroInit();                 //初始化陀螺仪（开始阶段可以先关闭）
    
    
    MotorInit_SYJ();          //初始化电机，注意电机1，2口后来是用来控制驱动板的使能的，3，4口才是控制电机速度的PWM

    while(1)
    {
      //16.64ms的终点。
//      tic1 = PIT_CVAL(1)/75000;
      while(ImgStatus != ImgGetFinish) ; //如果图像采集未结束，则一直等待。
//      tic2 = PIT_CVAL(1)/75000;
      
      //16.64ms的起点。            
      ImgStatus = ImgGetStart;        //图像采集标志位置为开始        
      
      FTM2_CNT = 0;                            //计数器清零。准备开启10ms的编码器速度值采集。
      QuadDoneFlag = 0;                        //提前将该标志位置0，以防ImagePro()用时少于5ms的情况。
      
      
      PIT_TCTRL(PIT0) |= PIT_TCTRL_TEN_MASK;       //使能pit模块运行,此时PIT计数器开始倒数。用于编码器（开始阶段可以先关闭）
      enable_pit_interrupt(PIT0);                         //开PIT0中断，用于编码器（开始阶段可以先关闭）
      
//      tic3 = PIT_CVAL(1)/75000; 
      //若图像处理成功（即偏差获取成功），则进行舵机和电机的控制，否则保持原状。
      //若已经经过直角弯特殊处理，也可以进行舵机和电机的控制。
      if(ImagePro() == 1 || AngleSpeDealFlag == 1)          //图像处理  
      {
        GPIO_PDOR_REG(PORTC) |= (1<<0);
//        tic4 = PIT_CVAL(1)/75000; 
        while(QuadDoneFlag == 0) ;  //若编码器速度采集未完成，则一直等待。    
        
//        tic5 = PIT_CVAL(1)/75000; 
      }
      else
      {
//        tic6 = PIT_CVAL(1)/75000; 
        GPIO_PDOR_REG(PORTC) &= ~(1<<0);
        //就算图像处理失败，也必须等10ms以后，再去做后面的电机控制。
        while(QuadDoneFlag == 0) ;  //若编码器速度采集未完成，则一直等待。
//        tic7 = PIT_CVAL(1)/75000; 
      }
      
      //toc4 = PIT_CVAL(1);
      
      
      //实时速度获取（开始阶段可以先关闭）
      SpeedRealTimeGet();
        
//       tic8 = PIT_CVAL(1)/75000; 
       ServoPID();         //舵机控制 
       //tic7 = PIT_CVAL(1);
//       tic9 = PIT_CVAL(1)/75000; 
       MotorPID();         //电机控制
//       tic10 = PIT_CVAL(1)/75000; 
       //toc7 = PIT_CVAL(1);
       
      //陀螺仪处理。AD采集，标志位处理。（开始阶段可以先关闭）
      GryoDeal();
      
      //电池电压测量
      //BatteryCheckUpdate();
      
      //tic5 = temptic1;
      //temptic1 = PIT_CVAL(1);
      
      //虚拟示波器（用的是FreeCars）
      Virtual2SendData();
//      tic11 = PIT_CVAL(1)/75000; 
      //toc5 = PIT_CVAL(1);
      
      //toc1 = PIT_CVAL(1);
      
    }  // end of while(1)



}      // end of main()
#endif // end of MAIN_PROGRAM



//==========================外设时钟测试===========================
/*
外设时钟测试成功，2014.10.09
用myDAQ测PORTA10的引脚频率就行，PIT设成1ms一次中断，测得频率为500Hz
*/
#ifdef CLOCK_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"

void main(void)
{
    DisableInterrupts;                                    //关闭所有中断
    
    gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
    enable_pit_interrupt(PIT0);                         //开PIT1中断
    
    EnableInterrupts;                                     //打开所有中断

    
    
    
    while(1)
    { 
      
      
    }  // end of while(1) 
}      // end of main()
#endif // end of CLOCK_DEBUG










//=======================================蓝牙串口测试===========================

//蓝牙串口测试成功。2014.10.10
//注意TX,RX对应的端口即可，龙丘板上的丝印容易看错位。


#ifdef  BLUETOOTH_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"

volatile uint8 BUFF[11] = {0};


void main(void)
{/*
    uint8 ch;
    
    uint8 first[] = {"\nDMA触发后 BUFF[10]={"};
    uint8 last[] = {"10}"};
    uint8 DMA_error[] = {"DMA初始化失败"};
    uint8 helloworld[] = {"Hello World!"};
   */ 
    //float a1 = 60000;
    //float a2 = 60000.3;
    //float a3 = 
    uint32 runcount;
    DisableInterrupts;                                    //关闭所有中断
    
    gpio_init(PORTA,6,1,0);                              //时间测试引脚初始化
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART4, periph_clk_khz, 115200);             //串口初始化
    //pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
    //enable_pit_interrupt(PIT0);                         //开PIT1中断
    uart_sendN(UART4,(uint8*)"\nHello World!",13);
    EnableInterrupts;


    while(1)
    {
      //if(uart_re1(UART0, &ch))//此处应把uart_re1函数中的计数错误检测去掉
      //{
        runcount++;
        if(runcount>=1000000)
        {
            light_change(PORTE, 26);//指示灯的亮、暗状态切换
            uart_sendN(UART4,(uint8*)"\nHello World!",13);
            uart_sendN(UART4,(uint8*)"\n001",13);
            uart_sendN(UART4,(uint8*)"\n002",13);
            uart_sendN(UART4,(uint8*)"\n003",13);
            runcount=0;
        }
       //}// end of if接收成功
    }  // end of while(1) 
}      // end of main()
#endif // end of BLUETOOTH_DEBUG























//============================DMA测试=============================
/*
DMA测试成功。2014.10.10
引脚连接：PTA8用于产生边沿来触发PTA7上的DMA触发，将3V3连接到B0至B7任意引脚，
          连接好串口蓝牙后，用串口调试助手发单个字符到MCU上，就可以发现BUFF数组里的数在一个个地变化。
关键配置：关闭DREQ时，DMA0的中断服务函数中不需要再打开ERQ。
          打开DREQ时，DMA0的中断服务函数中需要手动打开ERQ.
          DLAST配成-10，用于数组循环查看。
          BITER和CITER以及BUFF长度都配成10。
          PTA7做为DMA触发源，GPIO输入，下拉电阻(默认输入为0)，下降沿触发DMA。
          PTB0~PTB7均设置为摄像头数据输入，下拉电阻。
          PTA8配成GPIO输出。
*/
#ifdef DMA_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"

uint8 BUFF[11] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b};




void main(void)
{
    uint8 ch, chh;
    uint32 i;
    uint8 first[] = {"\nDMA触发后 BUFF[10]={"};
    uint8 last[] = {"10}"};
    uint8 DMA_error[] = {"DMA初始化失败"};
    
    DisableInterrupts;                                    //关闭所有中断
    
    gpio_init(PORTA,6,1,0);                              //时间测试引脚初始化
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 9600);             //串口初始化
    //pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
    //enable_pit_interrupt(PIT0);                         //开PIT1中断
    
    
    
    //DMA触发引脚 和 数据输入引脚 设置
    DMAPORTInit();
    
    if(!DMAInit(DMACH00, DMASOURCE_PORTA, GPIOB_DIR_ADDR, (uint32)BUFF))
    {
      while(1)
      {
      uart_sendN(UART0, DMA_error, sizeof(DMA_error));     
      }
    }
    
    enable_DMA_irq(DMACH00);              //开启DMA通道0的IRQ中断
    
    EnableInterrupts;                                     //打开所有中断
    
    DMA_ERQ |= (1 << 0);                            //打开DMA硬件触发使能


    while(1)
    {
      if(uart_re1(UART0, &ch))            //此处应把uart_re1函数中的计数错误检测去掉
      {
      gpio_reverse(PORTA, 8);
      for(i=0;i<150000;i++)
      {
        asm("nop");  
      }
      gpio_reverse(PORTA, 8);
      
      uart_sendN(UART0, (uint8 *)"Hello World!", 12);
      for(i = 0; i <= 10; i++)
      {
        chh = BUFF[i];
        uart_send1(UART0, chh);
      }
  
      

      
      
      
      }// end of if接收成功
    }  // end of while(1) 
}      // end of main()
#endif // end of DMA_DEBUG





//=======================引脚输入读取测试==============================
//GPIO引脚输入测试成功。2014.10.12
//1. 该测试以PA15为输入引脚，PA17和PC0为输出引脚（连接到龙丘板上的两个灯）。
//   当PA15检测到低电平时，PA17灭，PC0亮。PA15检测到高电平，相反。
//2. 实际测试时发现，如果不使能上下拉电阻（漏极开路无影响），则GPIO输入模式时，默认检测到的是低电平。
//   且给输入引脚外部置高或置低时，该引脚状态会一直保持到下一次外部改变。
//3. 实际测试时发现，如果使能了上拉电阻（漏极开路无影响），则GPIO输入模式时，默认检测到的是低电平。
//   且如果输入引脚外部置高后把杜邦线拿掉，该引脚状态会自动变为低电平，经单一变量检测，的确是上拉电阻的作用。
//   也就是说，无外部输入时，GPIO输入的上拉电阻会把该引脚状态置低。
//3. PORTPCR寄存器需在GPIO寄存器前设置成MUX(1)，即设置成GPIO模式（此时默认为GPIO输入）。
//4. GPIO的方向、输出值、输入值就按下面的例子来写，简单易懂。
//                                                         --HJZ
#ifdef PINREAD_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"



void main(void)
{	
	//开启各个GPIO口的转换时钟
	SIM_SCGC5 = SIM_SCGC5_PORTA_MASK | SIM_SCGC5_PORTB_MASK | SIM_SCGC5_PORTC_MASK | SIM_SCGC5_PORTD_MASK | SIM_SCGC5_PORTE_MASK;
	
        //输入引脚PA15的初始化，GPIO输入，漏极开路，上拉电阻
        PORT_PCR_REG(PORTA_BASE_PTR, 15) |= ( 0
                                  |  PORT_PCR_MUX(0x01) 
                                  | PORT_PCR_PE_MASK 
                                  | PORT_PCR_ODE_MASK
                                  );
        GPIO_PDDR_REG(PTA_BASE_PTR) |= (1 << 15);
        GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
        GPIO_PDDR_REG(PTA_BASE_PTR) &= ~(1 << 15);

        //输入引脚PA17和PC0的初始化，GPIO输出
	PORTA_PCR17 |= (0 | PORT_PCR_MUX(1));         
        PORTC_PCR0 |= (0 | PORT_PCR_MUX(1));
        
        GPIO_PDDR_REG(PTC_BASE_PTR) |= (1 << 0);
        GPIO_PDOR_REG(PTC_BASE_PTR) &= ~(1 << 0);
	
	GPIO_PDDR_REG(PTA_BASE_PTR) |= (1 << 17);
	GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 17);   
        
	for(;;)  
	{	//检测到高电平，PA17亮，PC0灭   	
		if( GPIO_PDIR_REG(PTA_BASE_PTR) & (1 << 15) )
		{
		    GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 17);
                    GPIO_PDOR_REG(PTC_BASE_PTR) |= (1 << 0);	
		}
                //检测到低电平，PA17灭，PC0亮   
		else
                {		
                    GPIO_PDOR_REG(PTC_BASE_PTR) &= ~(1 << 0);
                    GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 17);		
		}	 
	}
	
}

#endif // end of PINREAD_DEBUG








//=========================DAQ的边沿捕捉测试============================
#ifdef DAQ_DEBUG

#include "MK60N512VMD100.h"
#include "gpio.h"

void Delay(volatile uint16 time)
{
    while(time)
    {
        time--;  
    }
}


void main(void)
{
  
  SIM_SCGC5 |= (SIM_SCGC5_PORTA_MASK | SIM_SCGC5_PORTB_MASK | SIM_SCGC5_PORTC_MASK | SIM_SCGC5_PORTD_MASK | SIM_SCGC5_PORTE_MASK);
  
  gpio_init(PORTA, 14, 1, 1);
  gpio_init(PORTA, 15, 1, 1);
  //PORTA_PCR15 |= (0 | PORT_PCR_MUX(1));
  
  
  //PORTA_PCR14 |= PORT_PCR_DSE_MASK;
 //PORTA_PCR15 |= PORT_PCR_DSE_MASK;
  
  

  GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 14); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 15); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 14);   
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
  Delay(1000);
  
    GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 14); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 15); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 14);   
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
  Delay(1000);

  
    GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 14); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 15); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 14);   
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
  Delay(1000);


  
  while(1) ; 

}

#endif // end of DAQ_DEBUG



//=======================蓝牙波特率设置==================================
#ifdef BT_SET

#include "sysinit.h"
#include "common.h"
#include "gpio.h"
#include "uart.h"
#include "light.h"

void main(void)
{
    //uint8 cmd[] = {"AT+BAUD8\r"};
    uint8 cmd[] = {"\nHello World!"};
    uint32 runcount = 0;
    DisableInterrupts;                                    //关闭所有中断
    
    gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 9600);             //串口初始化

    EnableInterrupts;
    while(1)
    {

        runcount++;
        if(runcount>=1000000)
        {
            light_change(PORTE, 26);//指示灯的亮、暗状态切换
            uart_sendN(UART0, cmd, sizeof(cmd));
            runcount=0;
        }
      
    }



} // end of main

#endif // end of BT_SET







//========================OV7725摄像头测试================================
#ifdef CAMERA_DEBUG_7725

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"

void main(void)
{
    DisableInterrupts;                                    //关闭所有中断
    
    gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
    //enable_pit_interrupt(PIT0);                         //开PIT1中断

    while(!CameraInit())         //初始化摄像头
    {
      uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
    }
    
    while(!DMAInit(DMACH00, DMASOURCE_PORTA, CameraDMACount, GPIOB_DIR_ADDR, (uint32)ImgStore))
    {
      uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
    }
    
    //禁止硬件请求ERQ
    DMA_ERQ &= ~(1 << 0);
    //关PTA中断
    disable_irq(PORTA_IRQ);
    //清DMAINT标志位
    DMA_INT |= (1 << 0);
    //开DMA的IRQ
    enable_irq(DMA0_IRQ);

    EnableInterrupts;                                     //打开所有中断
    while(1)
    {
      ImageGet();        //图像获取
      ImagePro();        //图像处理
      //SendImg();  
      
    }  // end of while(1)
}      // end of main()



#endif  //end of CAMERA_DEBUG_7725









//==========================OV7620摄像头测试==================================
//引脚分配：
//PORT     FUNCTION
//  A0     TCLK
//  A1     TDI
//  A2     TDO
//  A3     TMS
//  A8     编码器FTM1_QD_PHA
//  A9     编码器FTM1_QD_PHB
//  A10    编码器FTM2_QD_PHA
//  A11    编码器FTM2_QD_PHB
//  A12    舵机FTM1_CH0
//  A25    SCCB_SDA
//  A26    SCCB_SCL
//  B0~B7  摄像头数据
//  B9     PCLK
//  B16    UART0_RX
//  B17    UART0_TX
//  C8     HREF
//  C16    OLED_D0
//  C17    OLED_D1
//  C18    OLED_RST
//  C19    OLED_DC
//  D1     VSYNC
//  D4     电机FTM0_CH4左正
//  D5     电机FTM0_CH5左反
//  D6     电机FTM0_CH6右正
//  D7     电机FTM0_CH7右反
//  E0~E5  按钮（核心板上的那种小按钮）
//  E6~E9  拨码开头
//  E26    工作指示灯

#ifdef CAMERA_DEBUG_7620

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"

void main(void)
{
    DisableInterrupts;                                    //关闭所有中断
    
    gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
    //enable_pit_interrupt(PIT0);                         //开PIT1中断

    while(!CameraInit())         //初始化摄像头
    {
      uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
    }
    
    //DMA通道0， DMA触发源为PORTB， DMA源地址为B0~B7, DMA目的地址为ImgStore1数组
    while(!DMAInit(DMACH00, DMASOURCE_PORTB, CameraWidth, GPIOB_DIR_ADDR, (uint32)(ImgStore1[0])))
    {
      uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
    }
    
    //这儿的优先级设置的正确性有待验证============================
    //set_irq_priority(FIELD_IRQ, 2);
    //set_irq_priority(LINE_IRQ, 1);
    //set_irq_priority(DMA0_IRQ, 0);
    
    PORTD_ISFR = PORT_ISFR_ISF_MASK;       //清场所在PORT的标志位
    PORTC_ISFR = PORT_ISFR_ISF_MASK;       //清行所在PORT的标志位
    PORTB_ISFR = PORT_ISFR_ISF_MASK;       //清PCLK所在PORT的标志位
    disable_irq(LINE_IRQ);                 //关行中断IRQ
    disable_irq(DMA0_IRQ);                 //关DMA传输完成中断IRQ
    enable_irq(FIELD_IRQ);                //开场中断IRQ
    
    EnableInterrupts;                                     //打开所有中断
    ImgStatus = ImgGetStart;        //图像采集标志位置为开始


    while(1)
    {
      while(ImgStatus != ImgGetFinish) ; //如果图像采集未结束，则一直等待。
      ImgStatus = ImgGetStart;        //图像采集标志位置为开始
      
      
      ImageProSend();        //图像处理
      //SendImg();  
      
    }  // end of while(1)
}      // end of main()



#endif // end of CAMERA_DEBUG_7620



//==========================C语言语法测试==================================
#ifdef C_DEBUG

#include "common.h"
#include "sysinit.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "math.h"

void main(void)
{
    uint8 i, j, k;
    uint8 x, y;
    uint8 temp1, temp2, temp3, temp4, temp5, temp6, temp7;
    int8 x1;
    int8 x2;
    int16 x3;
   
    
    i = 200;
    j = 100;
    k = 250;
    if((i + j) > k)
    {
      temp1 = 1;  
    }
    else
    {
      temp1 = 0;  
    }
    
    if((j - i) < 0)
    {
      temp2 = 1; 
    }
    else
    {
      temp2 = 0;  
    }
    
    x = i + j;
    if(x > k)
    {
      temp3 = 1;
    }
    else
    {
      temp3 = 0;
    }
    
    y = j - i;
    if(y < 0)
    {
      temp4 = 1;
    }
    else
    {
      temp4 = 0;  
    }
    
    
    
    x1 = (int8)(j - i);
    if(x1 < 0)
    {
      temp5 = 1;
    }
    else
    {
      temp5 = 0;  
    } 
    
    x2 = -1;
    if(x2 < 0)
      temp6 = 1;
    else
      temp6 = 0;
    
    x3 = -1;
    if(x3 < 0)
      temp7 = 1;
    else
      temp7 = 0;    
   
    
    while(1)
    {
    }
}

#endif // end of C_DEBUG
//==========================================================================






//==============================SD卡测试====================================
#ifdef SD_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"

#include "diskio.h"
#include "ff.h"
#include "ffconf.h"
#include "integer.h"
#include "myprintp.h"
#include "sd_driver.h"
#include "spi.h"
#include "SD.h"
#include "sdhc.h"

#include "ctype.h"
#include "stdarg.h"
#include "ycheck.h"
#include "yvals.h"


#define BUFF_SIZE   100
void main()
{   
 FIL fdst;  //文件
    FATFS fs;  //文件系统

    uint32 size, sizetmp;
    int res;
    char *str = "感谢您选用 野火Kinetis开发板 ！^_^ ";
    uint8 buff[BUFF_SIZE];

    for(size = 0; size < BUFF_SIZE; size++)buff[size] = 0;

    f_mount(0, &fs);		                                                       //SD卡系统初始化

    res = f_open(&fdst, "0:/FireDemo.txt", FA_OPEN_ALWAYS | FA_WRITE | FA_READ);  //打开文件，如果没有就创建，带读写打开

    if( res == FR_DISK_ERR)
    {
        printf( "\n没插入SD卡？？\n" );
        return;
    }
    else if ( res == FR_OK )
    {
        printf( "\n文件打开成功 \n" );
    }
    else
    {
        printf("\n返回值异常");
    }


    f_puts(str, &fdst);                     //往文件里写入字符串

    size = f_size(&fdst);                   //获取文件的大小

    printf( "\n文件大小为：%d \n" , size);  //串口打印文件的大小

    if(size > BUFF_SIZE)size = BUFF_SIZE;   //防止溢出

    f_lseek(&fdst, 0);                      //把指针指向文件顶部
    f_read (&fdst, buff, size, (UINT *)&sizetmp);   //读取


    printf("文件内容为：%s", (char const *)buff);

    f_close(&fdst);                         //关闭文件
     
  
    
}


/*
struct WSNSTATE  //??,???????
{
unsigned diskok:1; //???????????????BIT0    0:??????????   1:???????
unsigned fileok:1; //?????????BIT1                0:??????????? 1:??????
unsigned record:1; //
unsigned position:1; //
};

volatile struct WSNSTATE state; //????
FATFS fs;            // Work area (file system object) for logical drive
FRESULT res;         // FatFs function common result code
UINT br,bw;         // File Write count

FIL testdata;  //???????
FILINFO* sfil;

unsigned char filebuff[720]={0}; //????
volatile unsigned int filebuffoffset=0;
unsigned char read_buff[512];
unsigned char receivebuff[512];
unsigned char test_buff[64];

void init_disk_fatfs(void)   //??????????,???state.diskok==1;
{
	if(state.diskok==0)  //???????? 
	{
		if(disk_initialize(0))
		{
			state.diskok=0;
		}
		else
		{	
			res = f_mount(0,&fs);      // ?????????for logical drive 0
//			SCI0_putchar(res);
			state.diskok=1;
		}
	}
}

void uart0_send1 (int8 ch)
{
    //等待发送缓冲区空
    while(!(UART_S1_REG(UART0) & UART_S1_TDRE_MASK));
    //发送数据
    UART_D_REG(UART0) = (int8)ch;
}


void main(void)
{
    unsigned char r;
    unsigned int i,n;
    unsigned char kkk;
    signed char namebuf[7];
    unsigned char tmp0,tmp1;
    FRESULT rc; 
    
    PRINT_T Print;
    
    uart_init(UART0, periph_clk_khz, 115200);
    Print.m_printf = uart0_send1;	
    Print_Init(&Print);
    
    SPI_Configuration();
    printp("\nUartInit is ok!\n");
   
    
    init_disk_fatfs();
    if(state.diskok)printp("\ninit_disk is ok!\n");
 
    //EnableInterrupts;
    for(i=0;i<=256;i++)
    {
        filebuffoffset++;
        filebuff[i]='s';
    }
    
        rc =f_open(&testdata,"0:/data1.txt",FA_CREATE_ALWAYS|FA_WRITE);
     if(FR_OK == rc)printp("\nf_open is ok\n");
    
    rc = f_write(&testdata,filebuff,filebuffoffset,&bw);
    if(FR_OK == rc)printp("\nf_write is ok!\n");
    rc = f_close(&testdata);  
    if(FR_OK == rc)
    printp("\ncreat single file is ok\n");
    printp("%dbytes",f_size(&testdata));
  
  while(1)
  {
    
    
  }    // end of while(1)  
}      // end of main()
*/



#endif // end of SD_DEBUG
//==========================================================================





//==========================电机测试==================================
//引脚分配：
//PORT     FUNCTION
//  A0     TCLK
//  A1     TDI
//  A2     TDO
//  A3     TMS
//  A8     编码器FTM1_QD_PHA
//  A9     编码器FTM1_QD_PHB
//  A10    编码器FTM2_QD_PHA
//  A11    编码器FTM2_QD_PHB
//  A12    舵机FTM1_CH0
//  A25    SCCB_SDA
//  A26    SCCB_SCL
//  B0~B7  摄像头数据
//  B9     PCLK
//  B16    UART0_RX
//  B17    UART0_TX
//  C8     HREF
//  C16    OLED_D0
//  C17    OLED_D1
//  C18    OLED_RST
//  C19    OLED_DC
//  D1     VSYNC
//  D4     电机FTM0_CH4左正
//  D5     电机FTM0_CH5左反
//  D6     电机FTM0_CH6右正
//  D7     电机FTM0_CH7右反
//  E0~E5  按钮（核心板上的那种小按钮）
//  E6~E9  拨码开头
//  E26    工作指示灯

#ifdef MOTOR_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "VirtualScope.h"

void main(void)
{
    DisableInterrupts;                                    //关闭所有中断
    
    gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
    //enable_pit_interrupt(PIT0);                         //开PIT1中断
    
    EnableInterrupts;
    
    MotorInit_SYJ();
     FTM0_C4V = 0;         //设置 the pulse width(duty cycle) is determined by (CnV - CNTIN).
     FTM0_C5V = 100;
      FTM0_C6V = 100;    
      FTM0_C7V = 0;
    while(1)
    {
      Virtual2SendData();
      //uart_sendN(UART0, (uint8 *)"\nHello Motor!", 13);
    }  // end of while(1) 
        
}      // end of main()
#endif // end of MOTOR_DEBUG




//==========================舵机测试==================================
//引脚分配：
//PORT     FUNCTION
//  A0     TCLK
//  A1     TDI
//  A2     TDO
//  A3     TMS
//  A8     编码器FTM1_QD_PHA
//  A9     编码器FTM1_QD_PHB
//  A10    编码器FTM2_QD_PHA
//  A11    编码器FTM2_QD_PHB
//  A12    舵机FTM1_CH0
//  A25    SCCB_SDA
//  A26    SCCB_SCL
//  B0~B7  摄像头数据
//  B9     PCLK
//  B16    UART0_RX
//  B17    UART0_TX
//  C8     HREF
//  C16    OLED_D0
//  C17    OLED_D1
//  C18    OLED_RST
//  C19    OLED_DC
//  D1     VSYNC
//  D4     电机FTM0_CH4左正
//  D5     电机FTM0_CH5左反
//  D6     电机FTM0_CH6右正
//  D7     电机FTM0_CH7右反
//  E0~E5  按钮（核心板上的那种小按钮）
//  E6~E9  拨码开头
//  E26    工作指示灯

#ifdef SERVO_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"


void main(void)
{
    //int i, j;
    DisableInterrupts;                                    //关闭所有中断
    
    gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
    //enable_pit_interrupt(PIT0);                         //开PIT1中断
    
    EnableInterrupts;
    
    ServoInit();
    while(1)
    {
      
      FTM1_C0V = 1350;
      //FTM1_C0V = 1310;
      /*for(i = 0; i < 10000; i++)
        for(j = 0; j < 10000; j++)
        {}
      FTM1_C0V = 1810;
      for(i = 0; i < 10000; i++)
        for(j = 0; j < 10000; j++)
        {}
      FTM1_C0V = 2039;
      for(i = 0; i < 10000; i++)
        for(j = 0; j < 10000; j++)
        {}
      */
      uart_sendN(UART0, (uint8 *)"\nHello Servo!", 13);
    }  // end of while(1)   
}      // end of main()
#endif // end of SERVO_DEBUG
  
 
  
//==========================虚拟示波器测试===========================
#ifdef VIRTURL_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"  
#include "VirtualScope.h"


void main(void)
{
    uint8 t1 = 0;
    uint8 t2 = 125;
    DisableInterrupts;                                    //关闭所有中断
    
    gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
    //enable_pit_interrupt(PIT0);                         //开PIT1中断
    
    EnableInterrupts;
    
    
    while(1)
    {
      t1++;
      t2++;
      Virtual2DataPush(0, t1);
      Virtual2DataPush(1, t2);
      Virtual2DataPush(15, t1);
      Virtual2Send();
      //VirtualScopeSend();     
    }  // end of while(1) 
}      // end of main
#endif // end of VIRTURL_DEBUG




//================================编码器测试=================================
#ifdef QUAD_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"  
#include "Ftm.h"
#include "VirtualScope.h"

void main(void)
{
    DisableInterrupts;                                    //关闭所有中断
    
    gpio_init(PORTA,17,1,0);                              //时间测试引脚初始化
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT0,75000*5);                                   //初始化PIT0周期,75000是1ms.
    enable_pit_interrupt(PIT0);                         //开PIT0中断
    
    EnableInterrupts;
    
    MotorInit();                //电机初始化函数
    QuadInit3();                //3线编码器初始化函数
    while(1)
    {
      Virtual2SendData();
      //VirtualScopeSend();     
    }  // end of while(1) 
}      // end of main
#endif // end of QUAD_DEBUG



//================================差速测试=================================
#ifdef DIFF_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"  
#include "Ftm.h"
#include "VirtualScope.h"

void main(void)
{
    uint32 temptic1;
  
    DisableInterrupts;                                    //关闭所有中断
    
    //gpio_init(PORTA,17,1,0);                              //时间测试引脚初始化
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT0,75000*5);                                   //初始化PIT0周期,75000是1ms.
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
    enable_pit_interrupt(PIT0);                         //开PIT0中断
    
    //MotorInit();                //电机初始化函数
    QuadInit3();                //3线编码器初始化函数
    ServoInit();
    //MotorInit();
    
    EnableInterrupts;
    

    while(1)
    {
      tic1 = temptic1;
      temptic1 = PIT_CVAL(1);
      
      FTM2_CNT = 0;                            //计数器清零。准备开启10ms的编码器速度值采集。
      QuadDoneFlag = 0;                        //提前将该标志位置0，以防ImagePro()用时少于5ms的情况。
      
      PIT_TCTRL(PIT0) |= PIT_TCTRL_TEN_MASK;       //使能pit模块运行,此时PIT计数器开始倒数。
      enable_pit_interrupt(PIT0);                         //开PIT0中断
      
      while(QuadDoneFlag == 0) ;  //若编码器速度采集未完成，则一直等待。
      
      
      gpio_init(PORTA,17,1,0);
      
      Virtual2SendData();
      
      toc1 = PIT_CVAL(1);
    }  // end of while(1) 
}      // end of main
#endif // end of DIFF_DEBUG


//================================DEBUG测试================================
#ifdef DEBUG_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Flash.h"
#include "LQ12864.h"
#include "Debug.h"

void main(void)
{
    //uint8 flag;
    DisableInterrupts;                                    //关闭所有中断
    
    gpio_init(PORTA,17,1,1);                              //时间测试引脚初始化
    gpio_init(PORTC, 0,1,1);
    gpio_init(PORTD,15,1,1);
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
    pit_init(PIT0, 75000*5);                              //75000即为1ms
    //enable_pit_interrupt(PIT0);                         //开PIT0中断
    
    MotorInit();          //初始化电机
    ServoInit();          // 初始化舵机
    QuadInit3();           //初始化编码器
    //OLEDInit();           //初始化OLED
    //CameraInit();         //初始化摄像头
    
    while(!CameraInit())         //初始化摄像头
    {
      uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
    }
    
    //DMA通道0， DMA触发源为PORTB， DMA源地址为B0~B7, DMA目的地址为ImgStore1数组
    while(!DMAInit(DMACH00, DMASOURCE_PORTB, CameraWidth, GPIOB_DIR_ADDR, (uint32)(ImgStore1[0])))
    {
      uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
    }
    
    //这儿的优先级设置的正确性有待验证============================
    //set_irq_priority(FIELD_IRQ, 2);
    //set_irq_priority(LINE_IRQ, 1);
    //set_irq_priority(DMA0_IRQ, 0);
    
    PORTD_ISFR = PORT_ISFR_ISF_MASK;       //清场所在PORT的标志位
    PORTC_ISFR = PORT_ISFR_ISF_MASK;       //清行所在PORT的标志位
    PORTB_ISFR = PORT_ISFR_ISF_MASK;       //清PCLK所在PORT的标志位
    disable_irq(LINE_IRQ);                 //关行中断IRQ
    disable_irq(DMA0_IRQ);                 //关DMA传输完成中断IRQ
    enable_irq(FIELD_IRQ);                //开场中断IRQ
    
    ImgStatus = ImgGetStart;        //图像采集标志位置为开始
    EnableInterrupts;                                     //打开所有中断
    
    while(1)
    {
      //16.64ms的终点。
      tic1 = PIT_CVAL(1);
      while(ImgStatus != ImgGetFinish) ; //如果图像采集未结束，则一直等待。
      
      //16.64ms的起点。            
      ImgStatus = ImgGetStart;        //图像采集标志位置为开始        

      FTM2_CNT = 0;                            //计数器清零。准备开启10ms的编码器速度值采集。
      QuadDoneFlag = 0;                        //提前将该标志位置0，以防ImagePro()用时少于5ms的情况。
      
      PIT_TCTRL(PIT0) |= PIT_TCTRL_TEN_MASK;       //使能pit模块运行,此时PIT计数器开始倒数。
      enable_pit_interrupt(PIT0);                         //开PIT0中断
      
      tic2 = PIT_CVAL(1);
      //若图像处理成功（即偏差获取成功），则进行舵机和电机的控制，否则保持原状。
      //若已经经过直角弯特殊处理，也可以进行舵机和电机的控制。
      if(ImagePro() == 1 || AngleSpeDealFlag == 1)          //图像处理  
      {
        //QuadInit3();           //初始化编码器
        toc2 = PIT_CVAL(1);
        while(QuadDoneFlag == 0) ;  //若编码器速度采集未完成，则一直等待。
        
        
        tic3 = PIT_CVAL(1); 
        ServoPID();         //舵机控制
        MotorPID();         //电机控制
        toc3 = PIT_CVAL(1);
      }
      
      toc1 = PIT_CVAL(1);
      //VirtualScopeSend();
      Virtual2SendData();
      
      
      
    }  // end of while(1)
}      // end of main()
#endif // end of DEBUG_DEBUG


//=================================OLED测试================================
#ifdef OLED_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Debug.h"
#include "Flash.h"
#include "LQ12864.h"

void main(void)
{
    uint16 temp = 359;
    uint8 temp1[4] = {0, 0, 0, 0};
    uint32 tempcount = 0;
  
    DisableInterrupts;                                    //关闭所有中断
        
    gpio_init(PORTA,17,1,1);                              
    gpio_init(PORTC, 0,1,1);
    gpio_init(PORTD,15,1,1);
    gpio_init(PORTE,26,1,1);
    //light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
    pit_init(PIT0, 75000);                              //75000即为1ms
    enable_pit_interrupt(PIT0);
    
    //这里给一个编码器初始化是为了把FTM2模块初始化一下，因为PIT0_ISR中有取FTM2_CNT寄存器的值。
    //如果不初始化，取值的时候会过不去，一直卡在那儿。
    QuadInit3();
    
    DebugInit();
    
    //需要把PIT0_ISR函数简化。不然会跳不出来。
    
    temp1[0] = temp / 100 + 48;
    temp1[1] = (temp % 100) / 10 + 48;
    temp1[2] = (temp % 10) / 1 + 48;
    LCD_P6x8Str(0, 0, "S0");
    LCD_P6x8Str(0, 1, "S1");
    LCD_P6x8Str(0, 2, "S2");
    LCD_P6x8Str(0, 3, "S3");
    
    LCD_P6x8Str(64, 0, "B0");
    LCD_P6x8Str(64, 1, "B1");
    LCD_P6x8Str(64, 2, "B2");
    LCD_P6x8Str(64, 3, "B3");
    LCD_P6x8Str(64, 4, "B4");
    LCD_P6x8Str(64, 5, "B5");    
    
    //gpio_ctrl(PORTC, 0,0);
    //gpio_ctrl(PORTD, 15,0);
    gpio_ctrl(PORTA, 17,0);
    EnableInterrupts;                                     //打开所有中断  
    
    while(1)
    {
      gpio_ctrl(PORTD, 15,0);
      tempcount++;
      if(tempcount > 1000)
      {
        tempcount = 0;
        //DisableInterrupts;
        
        //////////实现按下某个键或者拨一下某个拨码开关，则某个灯亮。
        //中断函数会不会对LCD函数有影响？
        DebugSwitchScan();
        
         
        //拨码开关值显示。
        if(DebugSwitchFlag[0] == 1)
        {
          LCD_P6x8Str(18, 0, "1");
        }
        else
        {
          LCD_P6x8Str(18, 0, "0");
        }
        
        if(DebugSwitchFlag[1] == 1)
        {
          LCD_P6x8Str(18, 1, "1");
        }
        else
        {
          LCD_P6x8Str(18, 1, "0");
        }      
        
        if(DebugSwitchFlag[2] == 1)
        {
          LCD_P6x8Str(18, 2, "1");
        }
        else
        {
          LCD_P6x8Str(18, 2, "0");
        }
        
        if(DebugSwitchFlag[3] == 1)
        {
          LCD_P6x8Str(18, 3, "1");
        }
        else
        {
          LCD_P6x8Str(18, 3, "0");
        }
        
        
        if(DebugButtonScan() == 1)
        {
        //按键值显示。
        if(DebugButtonFlag[0] == 1)
        {
            LCD_P6x8Str(82, 0, "1");
          }
          else
          {
            LCD_P6x8Str(82, 0, "0");
          }      
    
          if(DebugButtonFlag[1] == 1)
          {
            LCD_P6x8Str(82, 1, "1");
          }
          else
          {
            LCD_P6x8Str(82, 1, "0");
          }            
          
          if(DebugButtonFlag[2] == 1)
          {
            LCD_P6x8Str(82, 2, "1");
          }
          else
          {
            LCD_P6x8Str(82, 2, "0");
          }      
          
          if(DebugButtonFlag[3] == 1)
          {
            LCD_P6x8Str(82, 3, "1");
          }
          else
          {
            LCD_P6x8Str(82, 3, "0");
          }            
          
          if(DebugButtonFlag[4] == 1)
          {
            LCD_P6x8Str(82, 4, "1");
          }
          else
          {
            LCD_P6x8Str(82, 4, "0");
          }      
    
          if(DebugButtonFlag[5] == 1)
          {
            LCD_P6x8Str(82, 5, "1");
          }
          else
          {
            LCD_P6x8Str(82, 5, "0");
          }      
        }
        
        //EnableInterrupts;
      }
      
    }  // end of while(1)
}      // end of main()
#endif // end of OLED_DEBUG



//=================================FLASH测试================================
#ifdef FLASH_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Debug.h"
#include "Flash.h"
#include "LQ12864.h"

void main(void)
{
    uint8 *pointeruint8;         //uint8型数据的指针。
  
    uint8 i;
  /* uint32 temp[60] = {//0,10,20, 30, 40, 50, 60, 70, 80, 90,150
                       0,165,180,205,215,235,240,229,225,211,211,   //11个舵机P值。
                       130,140,110,120,   //4个图像关键阈值。
                       10, 20, 25, 20, //多行第0列-0
                       20, 25, 22, 15, //多行第1列-10
                       24, 30, 19, 11, //多行第2列-20
                       29, 38, 17, 8, //多行第3列-30
                       32, 38, 15, 7,  //多行第4列-40
                       35, 45, 13, 5, //多行第5列-50
                       37, 55, 12, 3, //多行第6列-60
                       40, 60, 12, 0,  //多行第7列-60+
                        480,             //定时跑时间，0.1s为单位。
                        35,         //电机P
                        80         //电机D
                      };*/
      uint32 temp[60] = {//0,10,20, 30, 40, 50, 60, 70, 80, 90,150
                       50,       //LightHouseWaitStartMaxTime发车最多时间
                       6,        //SpeedStrategyChosen速度策略
                       300,      //MotorTakeOffQuadCountLimit起飞速度
                       3,2,3,5, //AngleZoneConfirmMatLimit, AngleConfirmMatLimit, BrickConfirmMatLimit, BrickConfirmFinalColCom
                       20,10,    //LightHouseWaitStopDelayCountLimit, LightHouseWaitStopGapCountLimit
                       75,90,90,140,80,110,   //6个图像关键阈值。WBi, WBa, Win, Wax, Bin, Bax
                       10, 20, 25, 25, //多行第0列-0
                       20, 25, 25, 20, //多行第1列-10
                       24, 30, 20, 15, //多行第2列-20
                       29, 38, 17, 8, //多行第3列-30
                       32, 38, 15, 7,  //多行第4列-40
                       35, 45, 13, 5, //多行第5列-50
                       37, 55, 12, 3, //多行第6列-60
                       40, 60, 12, 0,  //多行第7列-60+
                        480,             //定时跑时间，0.1s为单位。
                        20,         //电机P
                        15,         //电机D
                        30,         //坡道的给定速度
                        21,         //直角弯的给定速度
                        35,         //长直道的给定速度
                        20,         //坡道禁止赛道类型判断倒计数载入值
                        8,          //连续直道计数阈值
                        5,          //停车计数阈值，1个单位是0.1s
                        0,          //灯塔不停车标志，1启用这种模式，0不使用
                        5,          //直角弯线头差阈值，如果有误检测，则调大
                        25,         //灯塔等待停车速度
                        25          //上坡速度
                      };
       
         
    DisableInterrupts;                                    //关闭所有中断

    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
    pit_init(PIT0, 75000);                              //75000即为1ms
    //enable_pit_interrupt(PIT0);

    
    FlashInit();

    //EnableInterrupts;                                     //打开所有中断  
    
    //先擦除整个扇区。
    FlashEraseSector(FlashSectorIndex);
  
    
    for(i = 0; i < 60; i++)
    {
      pointeruint8 = (uint8 *)&temp[i];
      FlashWriteNow(FlashSectorIndex, i, FlashElementSize, pointeruint8);  
    }
    
    while(1)
    {

      gpio_init(PORTD,15,1,0); 
    }  // end of while(1)
}      // end of main()
#endif // end of FLASH_DEBUG


//=================================陀螺仪测试================================
#ifdef GYRO_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Debug.h"
#include "Flash.h"
#include "LQ12864.h"
#include "adc.h"

void main(void)
{

    DisableInterrupts;                                    //关闭所有中断
    
    light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
    //pit_init(PIT0,75000*5);                                   //初始化PIT0周期,75000是1ms.
    //enable_pit_interrupt(PIT0);                         //开PIT0中断
    
    //ADC初始化
    hw_adc_init(0);
    
    //陀螺仪初始化
    GyroInit();
    
    
    //EnableInterrupts;  

    while(1)
    {
      
      tic2 = PIT_CVAL(1);
      //ADResult0 = (ADResult0 * 90 + (hw_ad_once(0, 10, 16) - ADResultCom) * 10) / 100;
      //ADResult1 = (ADResult1 * 90 + (hw_ad_once(0, 17, 16) - ADResultCom) * 10) / 100;
      //ADResult2 = (ADResult2 * 90 + (hw_ad_once(0, 18, 16) - ADResultCom) * 10) / 100;
      ADResult0 = hw_ad_once(0, 10, 16) - ADResultCom;
      toc2 = PIT_CVAL(1);
      
      tic3 = PIT_CVAL(1);
      //ADResult3 = (ADResult3 * 90 + (hw_ad_mid(0, 10, 16) - ADResultCom) * 10) / 100;
      //ADResult4 = (ADResult4 * 90 + (hw_ad_mid(0, 17, 16) - ADResultCom) * 10) / 100;
      //ADResult5 = (ADResult5 * 90 + (hw_ad_mid(0, 18, 16) - ADResultCom) * 10) / 100;
      ADResult3 = hw_ad_mid(0, 10, 16) - ADResultCom;
      toc3 = PIT_CVAL(1);    
      
      Virtual2SendData();
      
    }  // end of while(1)
}      // end of main()
#endif // end of GYRO_DEBUG

//=================================灯塔测试================================
#ifdef LIGHTHOUSE_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Debug.h"
#include "Flash.h"
#include "LQ12864.h"
#include "adc.h"

void main(void)
{

    DisableInterrupts;                                    //关闭所有中断
    
    //light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
    uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
    //pit_init(PIT0,75000*5);                                   //初始化PIT0周期,75000是1ms.
    //enable_pit_interrupt(PIT0);                         //开PIT0中断
    
    //灯塔初始化
    LightHouseInit();
    
    gpio_init(PORTE, 26, 1, 1);   //最后一个1表示熄灭
    gpio_init(PORTA, 17, 1, 1);
    
    
    //EnableInterrupts;  

    while(1)
    {
      
      LightHouseStateUpdate();
      
      if(LightHouseStateR0 == 1)
      {
        GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 17);   //输出低电平表示点亮
      }
      else
      {
        GPIO_PDOR_REG(PTA_BASE_PTR) |=  (1 << 17);   //输出高电平表示熄灭
      }
 
      if(LightHouseStateR1 == 1)
      {
        GPIO_PDOR_REG(PTE_BASE_PTR) &= ~(1 << 26);   //输出低电平表示点亮
      }
      else
      {
        GPIO_PDOR_REG(PTE_BASE_PTR) |=  (1 << 26);   //输出高电平表示熄灭
      }
      
      Virtual2SendData();
      
    }  // end of while(1)
}      // end of main()
#endif // end of LIGHTHOUSE_DEBUG


//标准C文件头

/******************************************************************************/
/*******************************************************************************
  文件名：图像处理程序文件ImagePro.c
  功  能：图像处理
  日  期：2014.10.09
  作  者：HJZ
  备  注：
*******************************************************************************/
/******************************************************************************/


//标准H文件头

/******************************************************************************/
/*******************************************************************************
  文件名：图像处理程序头文件IamgePro.h
  功  能：图像处理
  日  期：2014.10.09
  作  者：HJZ
  备  注：
*******************************************************************************/
/******************************************************************************/
//1. 头文件
//2. 宏定义
//3. 变量类型定义
//4. 变量声明
//5. 函数声明


//标准函数头

//======================================================================
//函数名：
//功  能：
//参  数：
//返  回：
//影  响：
//说  明：
//      
//             
//======================================================================