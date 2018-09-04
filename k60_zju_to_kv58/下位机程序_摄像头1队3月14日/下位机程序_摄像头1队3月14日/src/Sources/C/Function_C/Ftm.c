/******************************************************************************/
/*******************************************************************************
  文件名：FTM模块C文件Ftm.c
  功  能：电机、舵机的PWM输出，编码器的输入捕捉。
  日  期：2014.11.04
  作  者：HJZ
  备  注：
*******************************************************************************/
/******************************************************************************/
#include "Ftm.h"

uint16 speedOfCar = 150;


//------------------------------------------------------------------------------
//函数名：MotorInit_SYJ
//功  能：电机驱动PWM初始化
//参  数：无
//返  回：无
//说  明：1. 苏宜靖学长的电机初始化函数，最大值1000.
//------------------------------------------------------------------------------
void MotorInit_SYJ(void)
{      	
      //SIM_SOPT4|=SIM_SOPT4_FTM1FLT0_MASK;        
      /* Turn on all port clocks */
      //SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK ;                    //////////////不同，注释掉的是SYJ的，不用开这个。
        
      PORTD_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH4
      PORTD_PCR5 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH5
      PORTD_PCR6 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH6
      PORTD_PCR7 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH7
      
      
      /* Enable the function on PTA8 */
//      PORTC_PCR1 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK; // FTM is alt4 function for this pin         
//      PORTC_PCR2 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;
//      
//      PORTC_PCR3 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;
//      PORTC_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;       //////////////不同，注释掉的SYJ的，I/O口不一样。
      
      SIM_SCGC6|=SIM_SCGC6_FTM0_MASK;         //使能FTM0时钟      
            
      FTM0_C4SC |= FTM_CnSC_ELSB_MASK;
      FTM0_C4SC &= ~FTM_CnSC_ELSA_MASK;
      FTM0_C4SC |= FTM_CnSC_MSB_MASK;
    
      FTM0_C5SC |= FTM_CnSC_ELSB_MASK;
      FTM0_C5SC &= ~FTM_CnSC_ELSA_MASK;
      FTM0_C5SC |= FTM_CnSC_MSB_MASK;
    
      FTM0_C6SC |= FTM_CnSC_ELSB_MASK;
      FTM0_C6SC &= ~FTM_CnSC_ELSA_MASK;
      FTM0_C6SC |= FTM_CnSC_MSB_MASK;
    
      FTM0_C7SC |= FTM_CnSC_ELSB_MASK;
      FTM0_C7SC &= ~FTM_CnSC_ELSA_MASK;
      FTM0_C7SC |= FTM_CnSC_MSB_MASK;
      
      //change MSnB = 1  
//      FTM0_C0SC |= FTM_CnSC_ELSB_MASK;
//      FTM0_C0SC &= ~FTM_CnSC_ELSA_MASK;
//      FTM0_C0SC |= FTM_CnSC_MSB_MASK;     
//      
//      FTM0_C1SC |= FTM_CnSC_ELSB_MASK;
//      FTM0_C1SC &= ~FTM_CnSC_ELSA_MASK;
//      FTM0_C1SC |= FTM_CnSC_MSB_MASK; 
//      
//      FTM0_C2SC |= FTM_CnSC_ELSB_MASK;
//      FTM0_C2SC &= ~FTM_CnSC_ELSA_MASK;
//      FTM0_C2SC |= FTM_CnSC_MSB_MASK; 
//      
//      FTM0_C3SC |= FTM_CnSC_ELSB_MASK;
//      FTM0_C3SC &= ~FTM_CnSC_ELSA_MASK;
//      FTM0_C3SC |= FTM_CnSC_MSB_MASK;           //////////////不同，注释掉的是SYJ的，他是FTM0_C0~FTMC3，我们是FTM0_C4~C7
      
      //FTM1_SC = FTM_SC_PS(0) | FTM_SC_CLKS(1);
      //FTM1_SC=0X0F;     
      //FTM0_SC = 0x2d; //not enable the interrupt mask   FTM_SC_PS(5) | FTM_SC_CLKS(1);
      
      FTM0_SC = FTM_SC_PS(4) | FTM_SC_CLKS(1);                      
      //////////////不同，未注释的是SYJ的，JYB的是FTM0_SC = 0x08; 
      //也就是说，两人选用的CLKS都是"System clock"，但JYB的PS=000, 也就是"1分频"，SYJ的PS=100，也就是"16分频"。
      
      //FTM1_SC=0X1F;       //BIT5  0 FTM counter operates in up counting mode.
                            //1 FTM counter operates in up-down counting mode.      
      //BIT43 FTM1_SC|=FTM1_SC_CLKS_MASK;
                            //00 No clock selected (This in effect disables the FTM counter.)
                            //01 System clock
                            //10 Fixed frequency clock
                            //11 External clock
      //BIT210 FTM1_SC|=FTM1_SC_PS_MASK; 
                            //100M          MOD=2000;     MOD=4000;   MOD=1000; 
                            //000 Divide by 1---12KHZ     6K          24k
                            //001 Divide by 2--- 6KHZ
                            //010 Divide by 4--- 3K
                            //011 Divide by 8--- 1.5K
                            //100 Divide by 16---750
                            //101 Divide by 32---375
                            //110 Divide by 64---187.5HZ
                            //111 Divide by 128--93.75hz             
      
      FTM0_MODE |= FTM_MODE_WPDIS_MASK;      
       //BIT1   Initialize the Channels Output
      //FTMEN is bit 0, need to set to zero so DECAPEN can be set to 0
      FTM0_MODE &=0XF0;           ////////////////不同，JYB的是FTM0_MODE &= ~1;
       //BIT0   FTM Enable
       //0 Only the TPM-compatible registers (first set of registers) can be used without any restriction. Do not use the FTM-specific registers.
       //1 All registers including the FTM-specific registers (second set of registers) are available for use with no restrictions.
      
      FTM0_OUTMASK=0X0F;  //FTM0_OUTMASK&=0XF0;    ////////////不同，注释掉的是SYJ的，因为我们是C4~C7，SYJ是C0~C3  
                           //0 Channel output is not masked. It continues to operate normally.
                           //1 Channel output is masked. It is forced to its inactive state.
      
      FTM0_COMBINE=0;      //Function for Linked Channels (FTMx_COMBINE)
      FTM0_OUTINIT=0;
      FTM0_EXTTRIG=0;      //FTM External Trigger (FTMx_EXTTRIG)
      FTM0_POL=0;          //Channels Polarity (FTMx_POL)
                           //0 The channel polarity is active high.
                           //1 The channel polarity is active low.     
      //Set Edge Aligned PWM
      FTM0_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;//使用A相B相编码模式
      //QUADEN is Bit 1, Set Quadrature Decoder Mode (QUADEN) Enable to 0,   (disabled)
      //FTM0_SC = 0x16; //Center Aligned PWM Select = 0, sets FTM Counter to operate in up counting mode,
      //it is field 5 of FTMx_SC (status control) - also setting the pre-scale bits here
      
      FTM0_INVCTRL=0;     //反转控制
      FTM0_SWOCTRL=0;     //软件输出控制F TM Software Output Control (FTMx_SWOCTRL)
      FTM0_PWMLOAD=0;     //FTM PWM Load
                          //BIT9: 0 Loading updated values is disabled.
                          //1 Loading updated values is enabled.
      FTM0_CNTIN=0;        //Counter Initial Value      
      FTM0_MOD=1000;       //Modulo value,The EPWM period is determined by (MOD - CNTIN + 0x0001) 
                           //采用龙丘时钟初始化函数，可以得到4分频的频率，系统60M频率时，PWM频率是15M,以此类推
                           //PMW频率=X系统频率/4/(2^FTM1_SC_PS)/FTM1_MOD
      
                          /////////////////不同，没注释的是SYJ的，JYB的是FTM0_MOD=7500-1;
      
      FTM0_C4V = 100;
      //FTM0_C4V = 0;         //设置 the pulse width(duty cycle) is determined by (CnV - CNTIN).
      FTM0_C5V = 100;
      FTM0_C6V = 100;
      FTM0_C7V = 100;
      //FTM0_C7V = 0;            
//      FTM0_C0V=0;        //设置 the pulse width(duty cycle) is determined by (CnV - CNTIN).
//      FTM0_C1V=0;
//      
//      FTM0_C2V=0;
//      FTM0_C3V=0;           /////////////////////不同，注释掉的是SYJ，因为他是C4~C7，我们是C0~C3
      
      FTM0_CNT=0;          //只有低16位可用
}



//------------------------------------------------------------------------------
//函数名：MotorInit_JYB
//功  能：电机驱动PWM初始化
//参  数：无
//返  回：无
//说  明：1. 江艺宝学长的电机初始化函数，最大值7500.
//------------------------------------------------------------------------------
void MotorInit_JYB(void)
{
  //SIM_SOPT4|=SIM_SOPT4_FTM1FLT0_MASK;
  /* Turn on all port clocks */
  //SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;

  /* Enable the function on PTA8 */
  // FTM is alt4 function for this pin
  PORTD_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH4
  PORTD_PCR5 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH5
  PORTD_PCR6 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH6
  PORTD_PCR7 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH7

  SIM_SCGC6|=SIM_SCGC6_FTM0_MASK;   //使能FTM0时钟

  //change MSnB = 1
  FTM0_C4SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C4SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C4SC |= FTM_CnSC_MSB_MASK;

  FTM0_C5SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C5SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C5SC |= FTM_CnSC_MSB_MASK;

  FTM0_C6SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C6SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C6SC |= FTM_CnSC_MSB_MASK;

  FTM0_C7SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C7SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C7SC |= FTM_CnSC_MSB_MASK;

  //FTM1_SC = FTM_SC_PS(0) | FTM_SC_CLKS(1);
  //FTM1_SC = 0X0F;
  FTM0_SC = 0x08;//???not enable the interrupt mask
  //系统时钟sys_clk，且为32分频，频率为2343.7Hz
  //FTM1_SC = 0X1F;     //BIT5
                        //0 FTM counter operates in up counting mode.
                        //1 FTM counter operates in up-down counting mode.
                        //BIT43 FTM1_SC|=FTM1_SC_CLKS_MASK;
                        //00 No clock selected (This in effect disables the FTM counter.)
                        //01 System clock
                        //10 Fixed frequency clock
                        //11 External clock
                        //BIT210 FTM1_SC|=FTM1_SC_PS_MASK;
                        //100M          MOD=2000;     MOD=4000;   MOD=1000;
                        //000 Divide by 1---12KHZ     6K          24k
                        //001 Divide by 2--- 6KHZ
                        //010 Divide by 4--- 3K
                        //011 Divide by 8--- 1.5K
                        //100 Divide by 16---750
                        //101 Divide by 32---375
                        //110 Divide by 64---187.5HZ
                        //111 Divide by 128--93.75hz

  FTM0_MODE |= FTM_MODE_WPDIS_MASK;
  //BIT1   Initialize the Channels Output
  //FTMEN is bit 0, need to set to zero so DECAPEN can be set to 0
  FTM0_MODE &= ~1;
  //BIT0   FTM Enable
  //0 Only the TPM-compatible registers (first set of registers) can be used without any restriction. Do not use the FTM-specific registers.
  //1 All registers including the FTM-specific registers (second set of registers) are available for use with no restrictions.

  FTM0_OUTMASK=0X0F;   //0 Channel output is not masked. It continues to operate normally.
                       //1 Channel output is masked. It is forced to its inactive state.

  FTM0_COMBINE=0;      //Function for Linked Channels (FTMx_COMBINE)
  FTM0_OUTINIT=0;
  FTM0_EXTTRIG=0;      //FTM External Trigger (FTMx_EXTTRIG)
  FTM0_POL=0;          //Channels Polarity (FTMx_POL)
                       //0 The channel polarity is active high.
                       //1 The channel polarity is active low.
  //Set Edge Aligned PWM
  FTM0_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;
  //QUADEN is Bit 1, Set Quadrature Decoder Mode (QUADEN) Enable to 0,   (disabled)
  //FTM0_SC = 0x16; //Center Aligned PWM Select = 0, sets FTM Counter to operate in up counting mode,
  //it is field 5 of FTMx_SC (status control) - also setting the pre-scale bits here

  FTM0_INVCTRL=0;     //反转控制
  FTM0_SWOCTRL=0;     //软件输出控制F TM Software Output Control (FTMx_SWOCTRL)
  FTM0_PWMLOAD=0;     //FTM PWM Load
                      //BIT9:
                      //0 Loading updated values is disabled.
                      //1 Loading updated values is enabled.
  FTM0_CNTIN=0;       //Counter Initial Value
  FTM0_MOD=7500-1;      //Modulo value,The EPWM period is determined by (MOD - CNTIN + 0x0001)
                      //采用龙丘时钟初始化函数，可以得到4分频的频率，系统60M频率时，PWM频率是15M,以此类推
                      //PMW频率=X系统频率/4/(2^FTM1_SC_PS)/FTM1_MOD
  FTM0_C4V=0;         //设置 the pulse width(duty cycle) is determined by (CnV - CNTIN).
  FTM0_C5V=0;
  FTM0_C6V=0; 
  FTM0_C7V=0;             ///此处CnV写0是为了使占空比为0，暂时不输出PWM波。   --HJZ
  FTM0_CNT=0;         //只有低16位可用    
                    
}





//------------------------------------------------------------------------------
//函数名：QuadInit3
//功  能：3线正交编码器初始化
//参  数：无
//返  回：无
//说  明：1. 3线仍用正交编码器模式，QUADMODE=1, A相用以计数，B相用以指示计数方向，悬空或者接高电平。
//------------------------------------------------------------------------------
void QuadInit3(void)
{
  //默认先打开左路，关闭右路。
  //左路A相 B18, B相 B19。打开。
  PORTB_PCR18 = PORT_PCR_MUX(6); // 设置引脚B18为FTM2_PHA功能  
  PORTB_PCR19 = PORT_PCR_MUX(6); // 设置引脚B19为FTM2_PHB功能   
  //右路A相 A10, B相 A11。置为无效复用。
  PORTA_PCR10 = PORT_PCR_MUX(5); // 设置引脚A10为无效复用。
  PORTA_PCR11 = PORT_PCR_MUX(5); // 设置引脚A11为无效复用。 
          
  SIM_SCGC3 |= SIM_SCGC3_FTM2_MASK;         //使能FTM2时钟  
  FTM2_MODE |= FTM_MODE_WPDIS_MASK;         //写保护禁止  
  FTM2_QDCTRL |= FTM_QDCTRL_QUADMODE_MASK;  //AB相同时确定方向和计数值，即QUADMODE = 1
  FTM2_CNTIN = 0;                           //FTM0计数器初始值为0  
  FTM2_MOD = 65535;                         //结束值  
  FTM2_QDCTRL |= FTM_QDCTRL_QUADEN_MASK;    //启用FTM2正交解码模式，即QUADEN = 1  
  FTM2_MODE |= FTM_MODE_FTMEN_MASK;         //FTM2EN = 1    
  FTM2_CNT = 0;                             //计数器清零。
}

//江学长的编码器初始化函数，估计是四线编码器的。
/*

//------------------------------------------------------------------------------
//函数名：QuadInit
//功  能：正交编码器初始化
//参  数：无
//返  回：无
//说  明：
//------------------------------------------------------------------------------
void QuadInit(void)
{
  //开启端口时钟
  //SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;
  //选择管脚复用功能
  PORTB_PCR0 = PORT_PCR_MUX(6);
  PORTB_PCR1 = PORT_PCR_MUX(6);
  PORTB_PCR18 = PORT_PCR_MUX(6);
  PORTB_PCR19 = PORT_PCR_MUX(6);
  //使能FTM1、FTM2时钟
  SIM_SCGC6|=SIM_SCGC6_FTM1_MASK;
  SIM_SCGC3|=SIM_SCGC3_FTM2_MASK;

  FTM1_MOD = 20000;                 //可根据需要设置
  FTM2_MOD = 20000;

  FTM1_CNTIN = 0;
  FTM2_CNTIN = 0;

  FTM1_MODE |= FTM_MODE_WPDIS_MASK; //禁止写保护
  FTM2_MODE |= FTM_MODE_WPDIS_MASK; //禁止写保护
  FTM1_MODE |= FTM_MODE_FTMEN_MASK; //FTMEN=1,关闭TPM兼容模式，开启FTM所有功能
  FTM2_MODE |= FTM_MODE_FTMEN_MASK; //FTMEN=1,关闭TPM兼容模式，开启FTM所有功能

  FTM1_QDCTRL &= ~FTM_QDCTRL_QUADMODE_MASK;  //选定编码模式为A相与B相编码模式
  FTM1_QDCTRL |= FTM_QDCTRL_QUADEN_MASK;     //使能正交解码模式
  FTM2_QDCTRL &= ~FTM_QDCTRL_QUADMODE_MASK;  //选定编码模式为A相与B相编码模式
  FTM2_QDCTRL |= FTM_QDCTRL_QUADEN_MASK;     //使能正交解码模式

  FTM1_SC |= FTM_SC_CLKS(3);         //选择外部时钟
  //FTM1_CONF |=FTM_CONF_BDMMODE(3); //可根据需要选择
  FTM2_SC |= FTM_SC_CLKS(3);
  //FTM2_CONF |=FTM_CONF_BDMMODE(3);
}

*/

/*

//------------------------------------------------------------------------------
//函数名：Ftm0Init
//功  能：电机驱动PWM初始化
//参  数：无
//返  回：无
//说  明：
//------------------------------------------------------------------------------
void Ftm0Init(void)
{
  //打开PORTD模块门控时钟
  SIM_SCGC5 |= SIM_SCGC5_PORTD_MASK;

  //将PORTD4设置为FTM0_ch4，将PORTD5设置为FTM0_ch5，数字输出高驱动能力
  PORTD_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK; //D4为FTM0_ch4，电机左
  PORTD_PCR5 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK; //D5为FTM0_ch5，电机右

  //使能FTM0时钟
  SIM_SCGC6 |= SIM_SCGC6_FTM0_MASK;

  //配置FTM0_ch4为边沿对齐PWM，正极性
  FTM0_C4SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C4SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C4SC |= FTM_CnSC_MSB_MASK;

  //配置FTM0_ch5为边沿对齐PWM，正极性
  FTM0_C5SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C5SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C5SC |= FTM_CnSC_MSB_MASK;

  //时钟源选择sys_clk，对FTM计数器预分频16倍
  FTM0_SC = FTM_SC_PS(4) | FTM_SC_CLKS(1);

  FTM0_MODE &= ~FTM_MODE_FTMEN_MASK;         //禁止FTM模块
  //一旦禁止FTMEN，则FTM特定寄存器不能写入，即下述语句无效
  FTM0_OUTMASK = 0xCF;                       //通道4、5禁止掩码，继续正常运行

  FTM0_COMBINE = 0;                          //用于已连接通道,全部禁止
  FTM0_OUTINIT = 0;                          //外部输出初始化为0
  FTM0_EXTTRIG = 0;                          //外部触发设置，全部禁止
  FTM0_POL = 0;                              //输出极性设置，全部为正极性

  FTM0_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;     //正交解码器不使能，EPWM或者CPWM的条件

  FTM0_INVCTRL = 0;       //FTM倒置功能禁止
  FTM0_SWOCTRL = 0;       //软件输出控制禁止
  FTM0_PWMLOAD = 0;       //PWM加载控制禁止

  //下面设置PWM波的周期、占空比等参数
  //PWM计算方法：CnV/MOD，MOD已知，通过调整CnV控制占空比
  FTM0_CNTIN = 0;         //FTM计数初始值设置为0
  FTM0_MOD = 1000;        //FTM计数器模数值为1000
                          //采用LQ的时钟初始化函数，得到二分频的PWM，如sys_clk为100M，则PWM为50M
                          //PWM频率f=sys_clk/2/(2^FTM0_SC_PS)/FTM0_MOD=150M/2/16/1000=4687.5Hz，周期0.213ms
  FTM0_C4V = 0;           //脉宽设置为CnV - CNTIN，占空比为20%
  FTM0_C5V = 0;
  FTM0_CNT = 0;           //FTM计数器寄存器，低16位可以用，写入任何值将使其回到CNTIN
}
*/
//------------------------------------------------------------------------------
//函数名：ServoInit
//功  能：舵机驱动PWM初始化
//参  数：无
//返  回：无
//说  明：
//------------------------------------------------------------------------------
void ServoInit(void)
{
  //打开PORTA模块门控时钟
  SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;

  //将PORTB0设置为FTM1_ch0，数字输出高驱动能力
  PORTA_PCR12 = PORT_PCR_MUX(0x3)| PORT_PCR_DSE_MASK;

  //使能FTM1模块门控时钟
  SIM_SCGC6|=SIM_SCGC6_FTM1_MASK;

  //配置FTM1_ch0为边沿对齐PWM，正极性
  FTM1_C0SC |= FTM_CnSC_ELSB_MASK;
  FTM1_C0SC &= ~FTM_CnSC_ELSA_MASK;
  FTM1_C0SC |= FTM_CnSC_MSB_MASK;

  //时钟源选择sys_clk，对FTM计数器预分频128倍
  FTM1_SC = FTM_SC_PS(6) | FTM_SC_CLKS(1);

  FTM1_MODE &= ~FTM_MODE_FTMEN_MASK;         //禁止FTM模块
  FTM1_OUTMASK &= ~1;                        //通道0禁止掩码，继续正常运行

  FTM1_COMBINE = 0;                          //用于已连接通道,全部禁止
  FTM1_OUTINIT = 0;                          //外部输出初始化为0
  FTM1_EXTTRIG = 0;                          //外部触发设置，全部禁止
  FTM1_POL = 0;                              //输出极性设置，全部为正极性

  FTM1_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;     //正交解码器不使能，EPWM或者CPWM的条件

  FTM1_INVCTRL = 0;     //FTM倒置功能禁止
  FTM1_SWOCTRL = 0;     //软件输出控制禁止
  FTM1_PWMLOAD = 0;     //PWM加载控制禁止

  //下面设置PWM波的周期、占空比等参数
  //PWM计算方法：CnV/MOD，MOD已知，通过调整CnV控制占空比
  FTM1_CNTIN = 0;         //FTM计数初始值设置为0
  FTM1_MOD = 23437 - 1;        //FTM计数器模数值为2000
                          //采用LQ的时钟初始化函数，得到二分频的PWM，如sys_clk为100M，则PWM为50M
                          //PWM频率f=sys_clk/2/(2^FTM1_SC_PS)/FTM1_MOD=150M/2/128/1953=300.02Hz，周期3.33ms
  FTM1_C0V = 1750;      //脉宽设置为CnV - CNTIN，占空比为20%
  //4.3% 4.4%(L) 4.5% 5.0% 5.5% 6.0% 6.5% 7.0% 7.15%(C) 7.5% 8.0% 8.5% 9.0% 9.5% 9.9%(R) 10.0% 10.3% 10.5%
  //1008 1031    1055 1172 1289 1406 1523 1640 1676     1758 1875 1992 2109 2226 2320    2344  2414  4922
  
  //6.3% 1476
  //6.55% 1535
  //6.6% 1547
  //6.8% 1594
  //6.9% 1617
  //7.45% 1746
  //7.9% 1851
  //8.45% 1980
  //8.7% 2039
  //8.9% 2086
  //9.3% 2180
  // 1965   1765   1580
  FTM1_CNT = 0;           //FTM计数器寄存器，低16位可以用，写入任何值将使其回到CNTIN
}








