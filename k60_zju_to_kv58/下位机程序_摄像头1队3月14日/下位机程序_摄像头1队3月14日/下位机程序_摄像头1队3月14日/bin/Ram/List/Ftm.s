///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.10.1.12857/W32 for ARM      30/Aug/2018  15:15:51
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Function_C\Ftm.c
//    Command line =  
//        -f C:\Users\Lenovo\AppData\Local\Temp\EW94FF.tmp
//        (C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Function_C\Ftm.c
//        -D IAR -D TWR_K60N512 --preprocess
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\bin\Ram\List
//        -lCN
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\bin\Ram\List
//        -lB
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\bin\Ram\List
//        -o
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\bin\Ram\Obj
//        --no_cse --no_unroll --no_inline --no_code_motion --no_tbaa
//        --no_clustering --no_scheduling --debug --endian=little
//        --cpu=Cortex-M4 -e --fpu=None --dlib_config "C:\Program Files
//        (x86)\IAR Systems\Embedded Workbench
//        8.0\arm\INC\c\DLib_Config_Full.h" -I
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\H\
//        -I
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\H\Component_H\
//        -I
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\H\Frame_H\
//        -I
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\H\Function_H\
//        -I
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\H\SD_H\
//        -I D:\quartus\quartus\cusp\80\synthinclude\ -Ol --use_c++_inline -I
//        "C:\Program Files (x86)\IAR Systems\Embedded Workbench
//        8.0\arm\CMSIS\Include\" -D ARM_MATH_CM4)
//    Locale       =  C
//    List file    =  
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\bin\Ram\List\Ftm.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC MotorInit_JYB
        PUBLIC MotorInit_SYJ
        PUBLIC QuadInit3
        PUBLIC ServoInit
        PUBLIC speedOfCar

// C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Function_C\Ftm.c
//    1 /******************************************************************************/
//    2 /*******************************************************************************
//    3   文件名：FTM模块C文件Ftm.c
//    4   功  能：电机、舵机的PWM输出，编码器的输入捕捉。
//    5   日  期：2014.11.04
//    6   作  者：HJZ
//    7   备  注：
//    8 *******************************************************************************/
//    9 /******************************************************************************/
//   10 #include "Ftm.h"
//   11 

        SECTION `.data`:DATA:REORDER:NOROOT(1)
        DATA
//   12 uint16 speedOfCar = 150;
speedOfCar:
        DC16 150
//   13 
//   14 
//   15 //------------------------------------------------------------------------------
//   16 //函数名：MotorInit_SYJ
//   17 //功  能：电机驱动PWM初始化
//   18 //参  数：无
//   19 //返  回：无
//   20 //说  明：1. 苏宜靖学长的电机初始化函数，最大值1000.
//   21 //------------------------------------------------------------------------------

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   22 void MotorInit_SYJ(void)
//   23 {      	
//   24       //SIM_SOPT4|=SIM_SOPT4_FTM1FLT0_MASK;        
//   25       /* Turn on all port clocks */
//   26       //SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK ;                    //////////////不同，注释掉的是SYJ的，不用开这个。
//   27         
//   28       PORTD_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH4
MotorInit_SYJ:
        MOV      R0,#+1088
        LDR.W    R1,??DataTable3  ;; 0x4004c010
        STR      R0,[R1, #+0]
//   29       PORTD_PCR5 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH5
        MOV      R0,#+1088
        LDR.W    R1,??DataTable3_1  ;; 0x4004c014
        STR      R0,[R1, #+0]
//   30       PORTD_PCR6 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH6
        MOV      R0,#+1088
        LDR.W    R1,??DataTable3_2  ;; 0x4004c018
        STR      R0,[R1, #+0]
//   31       PORTD_PCR7 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH7
        MOV      R0,#+1088
        LDR.W    R1,??DataTable3_3  ;; 0x4004c01c
        STR      R0,[R1, #+0]
//   32       
//   33       
//   34       /* Enable the function on PTA8 */
//   35 //      PORTC_PCR1 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK; // FTM is alt4 function for this pin         
//   36 //      PORTC_PCR2 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;
//   37 //      
//   38 //      PORTC_PCR3 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;
//   39 //      PORTC_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;       //////////////不同，注释掉的SYJ的，I/O口不一样。
//   40       
//   41       SIM_SCGC6|=SIM_SCGC6_FTM0_MASK;         //使能FTM0时钟      
        LDR.W    R0,??DataTable3_4  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000000
        LDR.W    R1,??DataTable3_4  ;; 0x4004803c
        STR      R0,[R1, #+0]
//   42             
//   43       FTM0_C4SC |= FTM_CnSC_ELSB_MASK;
        LDR.W    R0,??DataTable3_5  ;; 0x4003802c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable3_5  ;; 0x4003802c
        STR      R0,[R1, #+0]
//   44       FTM0_C4SC &= ~FTM_CnSC_ELSA_MASK;
        LDR.W    R0,??DataTable3_5  ;; 0x4003802c
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4
        LDR.W    R1,??DataTable3_5  ;; 0x4003802c
        STR      R0,[R1, #+0]
//   45       FTM0_C4SC |= FTM_CnSC_MSB_MASK;
        LDR.W    R0,??DataTable3_5  ;; 0x4003802c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable3_5  ;; 0x4003802c
        STR      R0,[R1, #+0]
//   46     
//   47       FTM0_C5SC |= FTM_CnSC_ELSB_MASK;
        LDR.W    R0,??DataTable3_6  ;; 0x40038034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable3_6  ;; 0x40038034
        STR      R0,[R1, #+0]
//   48       FTM0_C5SC &= ~FTM_CnSC_ELSA_MASK;
        LDR.W    R0,??DataTable3_6  ;; 0x40038034
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4
        LDR.W    R1,??DataTable3_6  ;; 0x40038034
        STR      R0,[R1, #+0]
//   49       FTM0_C5SC |= FTM_CnSC_MSB_MASK;
        LDR.W    R0,??DataTable3_6  ;; 0x40038034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable3_6  ;; 0x40038034
        STR      R0,[R1, #+0]
//   50     
//   51       FTM0_C6SC |= FTM_CnSC_ELSB_MASK;
        LDR.W    R0,??DataTable3_7  ;; 0x4003803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable3_7  ;; 0x4003803c
        STR      R0,[R1, #+0]
//   52       FTM0_C6SC &= ~FTM_CnSC_ELSA_MASK;
        LDR.W    R0,??DataTable3_7  ;; 0x4003803c
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4
        LDR.W    R1,??DataTable3_7  ;; 0x4003803c
        STR      R0,[R1, #+0]
//   53       FTM0_C6SC |= FTM_CnSC_MSB_MASK;
        LDR.W    R0,??DataTable3_7  ;; 0x4003803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable3_7  ;; 0x4003803c
        STR      R0,[R1, #+0]
//   54     
//   55       FTM0_C7SC |= FTM_CnSC_ELSB_MASK;
        LDR.W    R0,??DataTable3_8  ;; 0x40038044
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable3_8  ;; 0x40038044
        STR      R0,[R1, #+0]
//   56       FTM0_C7SC &= ~FTM_CnSC_ELSA_MASK;
        LDR.W    R0,??DataTable3_8  ;; 0x40038044
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4
        LDR.W    R1,??DataTable3_8  ;; 0x40038044
        STR      R0,[R1, #+0]
//   57       FTM0_C7SC |= FTM_CnSC_MSB_MASK;
        LDR.W    R0,??DataTable3_8  ;; 0x40038044
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable3_8  ;; 0x40038044
        STR      R0,[R1, #+0]
//   58       
//   59       //change MSnB = 1  
//   60 //      FTM0_C0SC |= FTM_CnSC_ELSB_MASK;
//   61 //      FTM0_C0SC &= ~FTM_CnSC_ELSA_MASK;
//   62 //      FTM0_C0SC |= FTM_CnSC_MSB_MASK;     
//   63 //      
//   64 //      FTM0_C1SC |= FTM_CnSC_ELSB_MASK;
//   65 //      FTM0_C1SC &= ~FTM_CnSC_ELSA_MASK;
//   66 //      FTM0_C1SC |= FTM_CnSC_MSB_MASK; 
//   67 //      
//   68 //      FTM0_C2SC |= FTM_CnSC_ELSB_MASK;
//   69 //      FTM0_C2SC &= ~FTM_CnSC_ELSA_MASK;
//   70 //      FTM0_C2SC |= FTM_CnSC_MSB_MASK; 
//   71 //      
//   72 //      FTM0_C3SC |= FTM_CnSC_ELSB_MASK;
//   73 //      FTM0_C3SC &= ~FTM_CnSC_ELSA_MASK;
//   74 //      FTM0_C3SC |= FTM_CnSC_MSB_MASK;           //////////////不同，注释掉的是SYJ的，他是FTM0_C0~FTMC3，我们是FTM0_C4~C7
//   75       
//   76       //FTM1_SC = FTM_SC_PS(0) | FTM_SC_CLKS(1);
//   77       //FTM1_SC=0X0F;     
//   78       //FTM0_SC = 0x2d; //not enable the interrupt mask   FTM_SC_PS(5) | FTM_SC_CLKS(1);
//   79       
//   80       FTM0_SC = FTM_SC_PS(4) | FTM_SC_CLKS(1);                      
        MOVS     R0,#+12
        LDR.W    R1,??DataTable3_9  ;; 0x40038000
        STR      R0,[R1, #+0]
//   81       //////////////不同，未注释的是SYJ的，JYB的是FTM0_SC = 0x08; 
//   82       //也就是说，两人选用的CLKS都是"System clock"，但JYB的PS=000, 也就是"1分频"，SYJ的PS=100，也就是"16分频"。
//   83       
//   84       //FTM1_SC=0X1F;       //BIT5  0 FTM counter operates in up counting mode.
//   85                             //1 FTM counter operates in up-down counting mode.      
//   86       //BIT43 FTM1_SC|=FTM1_SC_CLKS_MASK;
//   87                             //00 No clock selected (This in effect disables the FTM counter.)
//   88                             //01 System clock
//   89                             //10 Fixed frequency clock
//   90                             //11 External clock
//   91       //BIT210 FTM1_SC|=FTM1_SC_PS_MASK; 
//   92                             //100M          MOD=2000;     MOD=4000;   MOD=1000; 
//   93                             //000 Divide by 1---12KHZ     6K          24k
//   94                             //001 Divide by 2--- 6KHZ
//   95                             //010 Divide by 4--- 3K
//   96                             //011 Divide by 8--- 1.5K
//   97                             //100 Divide by 16---750
//   98                             //101 Divide by 32---375
//   99                             //110 Divide by 64---187.5HZ
//  100                             //111 Divide by 128--93.75hz             
//  101       
//  102       FTM0_MODE |= FTM_MODE_WPDIS_MASK;      
        LDR.W    R0,??DataTable3_10  ;; 0x40038054
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.W    R1,??DataTable3_10  ;; 0x40038054
        STR      R0,[R1, #+0]
//  103        //BIT1   Initialize the Channels Output
//  104       //FTMEN is bit 0, need to set to zero so DECAPEN can be set to 0
//  105       FTM0_MODE &=0XF0;           ////////////////不同，JYB的是FTM0_MODE &= ~1;
        LDR.W    R0,??DataTable3_10  ;; 0x40038054
        LDR      R0,[R0, #+0]
        ANDS     R0,R0,#0xF0
        LDR.N    R1,??DataTable3_10  ;; 0x40038054
        STR      R0,[R1, #+0]
//  106        //BIT0   FTM Enable
//  107        //0 Only the TPM-compatible registers (first set of registers) can be used without any restriction. Do not use the FTM-specific registers.
//  108        //1 All registers including the FTM-specific registers (second set of registers) are available for use with no restrictions.
//  109       
//  110       FTM0_OUTMASK=0X0F;  //FTM0_OUTMASK&=0XF0;    ////////////不同，注释掉的是SYJ的，因为我们是C4~C7，SYJ是C0~C3  
        MOVS     R0,#+15
        LDR.N    R1,??DataTable3_11  ;; 0x40038060
        STR      R0,[R1, #+0]
//  111                            //0 Channel output is not masked. It continues to operate normally.
//  112                            //1 Channel output is masked. It is forced to its inactive state.
//  113       
//  114       FTM0_COMBINE=0;      //Function for Linked Channels (FTMx_COMBINE)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_12  ;; 0x40038064
        STR      R0,[R1, #+0]
//  115       FTM0_OUTINIT=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_13  ;; 0x4003805c
        STR      R0,[R1, #+0]
//  116       FTM0_EXTTRIG=0;      //FTM External Trigger (FTMx_EXTTRIG)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_14  ;; 0x4003806c
        STR      R0,[R1, #+0]
//  117       FTM0_POL=0;          //Channels Polarity (FTMx_POL)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_15  ;; 0x40038070
        STR      R0,[R1, #+0]
//  118                            //0 The channel polarity is active high.
//  119                            //1 The channel polarity is active low.     
//  120       //Set Edge Aligned PWM
//  121       FTM0_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;//使用A相B相编码模式
        LDR.N    R0,??DataTable3_16  ;; 0x40038080
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable3_16  ;; 0x40038080
        STR      R0,[R1, #+0]
//  122       //QUADEN is Bit 1, Set Quadrature Decoder Mode (QUADEN) Enable to 0,   (disabled)
//  123       //FTM0_SC = 0x16; //Center Aligned PWM Select = 0, sets FTM Counter to operate in up counting mode,
//  124       //it is field 5 of FTMx_SC (status control) - also setting the pre-scale bits here
//  125       
//  126       FTM0_INVCTRL=0;     //反转控制
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_17  ;; 0x40038090
        STR      R0,[R1, #+0]
//  127       FTM0_SWOCTRL=0;     //软件输出控制F TM Software Output Control (FTMx_SWOCTRL)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_18  ;; 0x40038094
        STR      R0,[R1, #+0]
//  128       FTM0_PWMLOAD=0;     //FTM PWM Load
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_19  ;; 0x40038098
        STR      R0,[R1, #+0]
//  129                           //BIT9: 0 Loading updated values is disabled.
//  130                           //1 Loading updated values is enabled.
//  131       FTM0_CNTIN=0;        //Counter Initial Value      
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_20  ;; 0x4003804c
        STR      R0,[R1, #+0]
//  132       FTM0_MOD=1000;       //Modulo value,The EPWM period is determined by (MOD - CNTIN + 0x0001) 
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_21  ;; 0x40038008
        STR      R0,[R1, #+0]
//  133                            //采用龙丘时钟初始化函数，可以得到4分频的频率，系统60M频率时，PWM频率是15M,以此类推
//  134                            //PMW频率=X系统频率/4/(2^FTM1_SC_PS)/FTM1_MOD
//  135       
//  136                           /////////////////不同，没注释的是SYJ的，JYB的是FTM0_MOD=7500-1;
//  137       
//  138       FTM0_C4V = 100;
        MOVS     R0,#+100
        LDR.N    R1,??DataTable3_22  ;; 0x40038030
        STR      R0,[R1, #+0]
//  139       //FTM0_C4V = 0;         //设置 the pulse width(duty cycle) is determined by (CnV - CNTIN).
//  140       FTM0_C5V = 100;
        MOVS     R0,#+100
        LDR.N    R1,??DataTable3_23  ;; 0x40038038
        STR      R0,[R1, #+0]
//  141       FTM0_C6V = 100;
        MOVS     R0,#+100
        LDR.N    R1,??DataTable3_24  ;; 0x40038040
        STR      R0,[R1, #+0]
//  142       FTM0_C7V = 100;
        MOVS     R0,#+100
        LDR.N    R1,??DataTable3_25  ;; 0x40038048
        STR      R0,[R1, #+0]
//  143       //FTM0_C7V = 0;            
//  144 //      FTM0_C0V=0;        //设置 the pulse width(duty cycle) is determined by (CnV - CNTIN).
//  145 //      FTM0_C1V=0;
//  146 //      
//  147 //      FTM0_C2V=0;
//  148 //      FTM0_C3V=0;           /////////////////////不同，注释掉的是SYJ，因为他是C4~C7，我们是C0~C3
//  149       
//  150       FTM0_CNT=0;          //只有低16位可用
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_26  ;; 0x40038004
        STR      R0,[R1, #+0]
//  151 }
        BX       LR               ;; return
//  152 
//  153 
//  154 
//  155 //------------------------------------------------------------------------------
//  156 //函数名：MotorInit_JYB
//  157 //功  能：电机驱动PWM初始化
//  158 //参  数：无
//  159 //返  回：无
//  160 //说  明：1. 江艺宝学长的电机初始化函数，最大值7500.
//  161 //------------------------------------------------------------------------------

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  162 void MotorInit_JYB(void)
//  163 {
//  164   //SIM_SOPT4|=SIM_SOPT4_FTM1FLT0_MASK;
//  165   /* Turn on all port clocks */
//  166   //SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;
//  167 
//  168   /* Enable the function on PTA8 */
//  169   // FTM is alt4 function for this pin
//  170   PORTD_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH4
MotorInit_JYB:
        MOV      R0,#+1088
        LDR.N    R1,??DataTable3  ;; 0x4004c010
        STR      R0,[R1, #+0]
//  171   PORTD_PCR5 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH5
        MOV      R0,#+1088
        LDR.N    R1,??DataTable3_1  ;; 0x4004c014
        STR      R0,[R1, #+0]
//  172   PORTD_PCR6 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH6
        MOV      R0,#+1088
        LDR.N    R1,??DataTable3_2  ;; 0x4004c018
        STR      R0,[R1, #+0]
//  173   PORTD_PCR7 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH7
        MOV      R0,#+1088
        LDR.N    R1,??DataTable3_3  ;; 0x4004c01c
        STR      R0,[R1, #+0]
//  174 
//  175   SIM_SCGC6|=SIM_SCGC6_FTM0_MASK;   //使能FTM0时钟
        LDR.N    R0,??DataTable3_4  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000000
        LDR.N    R1,??DataTable3_4  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  176 
//  177   //change MSnB = 1
//  178   FTM0_C4SC |= FTM_CnSC_ELSB_MASK;
        LDR.N    R0,??DataTable3_5  ;; 0x4003802c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable3_5  ;; 0x4003802c
        STR      R0,[R1, #+0]
//  179   FTM0_C4SC &= ~FTM_CnSC_ELSA_MASK;
        LDR.N    R0,??DataTable3_5  ;; 0x4003802c
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4
        LDR.N    R1,??DataTable3_5  ;; 0x4003802c
        STR      R0,[R1, #+0]
//  180   FTM0_C4SC |= FTM_CnSC_MSB_MASK;
        LDR.N    R0,??DataTable3_5  ;; 0x4003802c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable3_5  ;; 0x4003802c
        STR      R0,[R1, #+0]
//  181 
//  182   FTM0_C5SC |= FTM_CnSC_ELSB_MASK;
        LDR.N    R0,??DataTable3_6  ;; 0x40038034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable3_6  ;; 0x40038034
        STR      R0,[R1, #+0]
//  183   FTM0_C5SC &= ~FTM_CnSC_ELSA_MASK;
        LDR.N    R0,??DataTable3_6  ;; 0x40038034
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4
        LDR.N    R1,??DataTable3_6  ;; 0x40038034
        STR      R0,[R1, #+0]
//  184   FTM0_C5SC |= FTM_CnSC_MSB_MASK;
        LDR.N    R0,??DataTable3_6  ;; 0x40038034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable3_6  ;; 0x40038034
        STR      R0,[R1, #+0]
//  185 
//  186   FTM0_C6SC |= FTM_CnSC_ELSB_MASK;
        LDR.N    R0,??DataTable3_7  ;; 0x4003803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable3_7  ;; 0x4003803c
        STR      R0,[R1, #+0]
//  187   FTM0_C6SC &= ~FTM_CnSC_ELSA_MASK;
        LDR.N    R0,??DataTable3_7  ;; 0x4003803c
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4
        LDR.N    R1,??DataTable3_7  ;; 0x4003803c
        STR      R0,[R1, #+0]
//  188   FTM0_C6SC |= FTM_CnSC_MSB_MASK;
        LDR.N    R0,??DataTable3_7  ;; 0x4003803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable3_7  ;; 0x4003803c
        STR      R0,[R1, #+0]
//  189 
//  190   FTM0_C7SC |= FTM_CnSC_ELSB_MASK;
        LDR.N    R0,??DataTable3_8  ;; 0x40038044
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable3_8  ;; 0x40038044
        STR      R0,[R1, #+0]
//  191   FTM0_C7SC &= ~FTM_CnSC_ELSA_MASK;
        LDR.N    R0,??DataTable3_8  ;; 0x40038044
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4
        LDR.N    R1,??DataTable3_8  ;; 0x40038044
        STR      R0,[R1, #+0]
//  192   FTM0_C7SC |= FTM_CnSC_MSB_MASK;
        LDR.N    R0,??DataTable3_8  ;; 0x40038044
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable3_8  ;; 0x40038044
        STR      R0,[R1, #+0]
//  193 
//  194   //FTM1_SC = FTM_SC_PS(0) | FTM_SC_CLKS(1);
//  195   //FTM1_SC = 0X0F;
//  196   FTM0_SC = 0x08;//???not enable the interrupt mask
        MOVS     R0,#+8
        LDR.N    R1,??DataTable3_9  ;; 0x40038000
        STR      R0,[R1, #+0]
//  197   //系统时钟sys_clk，且为32分频，频率为2343.7Hz
//  198   //FTM1_SC = 0X1F;     //BIT5
//  199                         //0 FTM counter operates in up counting mode.
//  200                         //1 FTM counter operates in up-down counting mode.
//  201                         //BIT43 FTM1_SC|=FTM1_SC_CLKS_MASK;
//  202                         //00 No clock selected (This in effect disables the FTM counter.)
//  203                         //01 System clock
//  204                         //10 Fixed frequency clock
//  205                         //11 External clock
//  206                         //BIT210 FTM1_SC|=FTM1_SC_PS_MASK;
//  207                         //100M          MOD=2000;     MOD=4000;   MOD=1000;
//  208                         //000 Divide by 1---12KHZ     6K          24k
//  209                         //001 Divide by 2--- 6KHZ
//  210                         //010 Divide by 4--- 3K
//  211                         //011 Divide by 8--- 1.5K
//  212                         //100 Divide by 16---750
//  213                         //101 Divide by 32---375
//  214                         //110 Divide by 64---187.5HZ
//  215                         //111 Divide by 128--93.75hz
//  216 
//  217   FTM0_MODE |= FTM_MODE_WPDIS_MASK;
        LDR.N    R0,??DataTable3_10  ;; 0x40038054
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable3_10  ;; 0x40038054
        STR      R0,[R1, #+0]
//  218   //BIT1   Initialize the Channels Output
//  219   //FTMEN is bit 0, need to set to zero so DECAPEN can be set to 0
//  220   FTM0_MODE &= ~1;
        LDR.N    R0,??DataTable3_10  ;; 0x40038054
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable3_10  ;; 0x40038054
        STR      R0,[R1, #+0]
//  221   //BIT0   FTM Enable
//  222   //0 Only the TPM-compatible registers (first set of registers) can be used without any restriction. Do not use the FTM-specific registers.
//  223   //1 All registers including the FTM-specific registers (second set of registers) are available for use with no restrictions.
//  224 
//  225   FTM0_OUTMASK=0X0F;   //0 Channel output is not masked. It continues to operate normally.
        MOVS     R0,#+15
        LDR.N    R1,??DataTable3_11  ;; 0x40038060
        STR      R0,[R1, #+0]
//  226                        //1 Channel output is masked. It is forced to its inactive state.
//  227 
//  228   FTM0_COMBINE=0;      //Function for Linked Channels (FTMx_COMBINE)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_12  ;; 0x40038064
        STR      R0,[R1, #+0]
//  229   FTM0_OUTINIT=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_13  ;; 0x4003805c
        STR      R0,[R1, #+0]
//  230   FTM0_EXTTRIG=0;      //FTM External Trigger (FTMx_EXTTRIG)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_14  ;; 0x4003806c
        STR      R0,[R1, #+0]
//  231   FTM0_POL=0;          //Channels Polarity (FTMx_POL)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_15  ;; 0x40038070
        STR      R0,[R1, #+0]
//  232                        //0 The channel polarity is active high.
//  233                        //1 The channel polarity is active low.
//  234   //Set Edge Aligned PWM
//  235   FTM0_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;
        LDR.N    R0,??DataTable3_16  ;; 0x40038080
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable3_16  ;; 0x40038080
        STR      R0,[R1, #+0]
//  236   //QUADEN is Bit 1, Set Quadrature Decoder Mode (QUADEN) Enable to 0,   (disabled)
//  237   //FTM0_SC = 0x16; //Center Aligned PWM Select = 0, sets FTM Counter to operate in up counting mode,
//  238   //it is field 5 of FTMx_SC (status control) - also setting the pre-scale bits here
//  239 
//  240   FTM0_INVCTRL=0;     //反转控制
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_17  ;; 0x40038090
        STR      R0,[R1, #+0]
//  241   FTM0_SWOCTRL=0;     //软件输出控制F TM Software Output Control (FTMx_SWOCTRL)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_18  ;; 0x40038094
        STR      R0,[R1, #+0]
//  242   FTM0_PWMLOAD=0;     //FTM PWM Load
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_19  ;; 0x40038098
        STR      R0,[R1, #+0]
//  243                       //BIT9:
//  244                       //0 Loading updated values is disabled.
//  245                       //1 Loading updated values is enabled.
//  246   FTM0_CNTIN=0;       //Counter Initial Value
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_20  ;; 0x4003804c
        STR      R0,[R1, #+0]
//  247   FTM0_MOD=7500-1;      //Modulo value,The EPWM period is determined by (MOD - CNTIN + 0x0001)
        MOVW     R0,#+7499
        LDR.N    R1,??DataTable3_21  ;; 0x40038008
        STR      R0,[R1, #+0]
//  248                       //采用龙丘时钟初始化函数，可以得到4分频的频率，系统60M频率时，PWM频率是15M,以此类推
//  249                       //PMW频率=X系统频率/4/(2^FTM1_SC_PS)/FTM1_MOD
//  250   FTM0_C4V=0;         //设置 the pulse width(duty cycle) is determined by (CnV - CNTIN).
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_22  ;; 0x40038030
        STR      R0,[R1, #+0]
//  251   FTM0_C5V=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_23  ;; 0x40038038
        STR      R0,[R1, #+0]
//  252   FTM0_C6V=0; 
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_24  ;; 0x40038040
        STR      R0,[R1, #+0]
//  253   FTM0_C7V=0;             ///此处CnV写0是为了使占空比为0，暂时不输出PWM波。   --HJZ
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_25  ;; 0x40038048
        STR      R0,[R1, #+0]
//  254   FTM0_CNT=0;         //只有低16位可用    
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_26  ;; 0x40038004
        STR      R0,[R1, #+0]
//  255                     
//  256 }
        BX       LR               ;; return
//  257 
//  258 
//  259 
//  260 
//  261 
//  262 //------------------------------------------------------------------------------
//  263 //函数名：QuadInit3
//  264 //功  能：3线正交编码器初始化
//  265 //参  数：无
//  266 //返  回：无
//  267 //说  明：1. 3线仍用正交编码器模式，QUADMODE=1, A相用以计数，B相用以指示计数方向，悬空或者接高电平。
//  268 //------------------------------------------------------------------------------

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  269 void QuadInit3(void)
//  270 {
//  271   //默认先打开左路，关闭右路。
//  272   //左路A相 B18, B相 B19。打开。
//  273   PORTB_PCR18 = PORT_PCR_MUX(6); // 设置引脚B18为FTM2_PHA功能  
QuadInit3:
        MOV      R0,#+1536
        LDR.N    R1,??DataTable3_27  ;; 0x4004a048
        STR      R0,[R1, #+0]
//  274   PORTB_PCR19 = PORT_PCR_MUX(6); // 设置引脚B19为FTM2_PHB功能   
        MOV      R0,#+1536
        LDR.N    R1,??DataTable3_28  ;; 0x4004a04c
        STR      R0,[R1, #+0]
//  275   //右路A相 A10, B相 A11。置为无效复用。
//  276   PORTA_PCR10 = PORT_PCR_MUX(5); // 设置引脚A10为无效复用。
        MOV      R0,#+1280
        LDR.N    R1,??DataTable3_29  ;; 0x40049028
        STR      R0,[R1, #+0]
//  277   PORTA_PCR11 = PORT_PCR_MUX(5); // 设置引脚A11为无效复用。 
        MOV      R0,#+1280
        LDR.N    R1,??DataTable3_30  ;; 0x4004902c
        STR      R0,[R1, #+0]
//  278           
//  279   SIM_SCGC3 |= SIM_SCGC3_FTM2_MASK;         //使能FTM2时钟  
        LDR.N    R0,??DataTable3_31  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000000
        LDR.N    R1,??DataTable3_31  ;; 0x40048030
        STR      R0,[R1, #+0]
//  280   FTM2_MODE |= FTM_MODE_WPDIS_MASK;         //写保护禁止  
        LDR.N    R0,??DataTable3_32  ;; 0x400b8054
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable3_32  ;; 0x400b8054
        STR      R0,[R1, #+0]
//  281   FTM2_QDCTRL |= FTM_QDCTRL_QUADMODE_MASK;  //AB相同时确定方向和计数值，即QUADMODE = 1
        LDR.N    R0,??DataTable3_33  ;; 0x400b8080
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable3_33  ;; 0x400b8080
        STR      R0,[R1, #+0]
//  282   FTM2_CNTIN = 0;                           //FTM0计数器初始值为0  
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_34  ;; 0x400b804c
        STR      R0,[R1, #+0]
//  283   FTM2_MOD = 65535;                         //结束值  
        MOVW     R0,#+65535
        LDR.N    R1,??DataTable3_35  ;; 0x400b8008
        STR      R0,[R1, #+0]
//  284   FTM2_QDCTRL |= FTM_QDCTRL_QUADEN_MASK;    //启用FTM2正交解码模式，即QUADEN = 1  
        LDR.N    R0,??DataTable3_33  ;; 0x400b8080
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable3_33  ;; 0x400b8080
        STR      R0,[R1, #+0]
//  285   FTM2_MODE |= FTM_MODE_FTMEN_MASK;         //FTM2EN = 1    
        LDR.N    R0,??DataTable3_32  ;; 0x400b8054
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable3_32  ;; 0x400b8054
        STR      R0,[R1, #+0]
//  286   FTM2_CNT = 0;                             //计数器清零。
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_36  ;; 0x400b8004
        STR      R0,[R1, #+0]
//  287 }
        BX       LR               ;; return
//  288 
//  289 //江学长的编码器初始化函数，估计是四线编码器的。
//  290 /*
//  291 
//  292 //------------------------------------------------------------------------------
//  293 //函数名：QuadInit
//  294 //功  能：正交编码器初始化
//  295 //参  数：无
//  296 //返  回：无
//  297 //说  明：
//  298 //------------------------------------------------------------------------------
//  299 void QuadInit(void)
//  300 {
//  301   //开启端口时钟
//  302   //SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;
//  303   //选择管脚复用功能
//  304   PORTB_PCR0 = PORT_PCR_MUX(6);
//  305   PORTB_PCR1 = PORT_PCR_MUX(6);
//  306   PORTB_PCR18 = PORT_PCR_MUX(6);
//  307   PORTB_PCR19 = PORT_PCR_MUX(6);
//  308   //使能FTM1、FTM2时钟
//  309   SIM_SCGC6|=SIM_SCGC6_FTM1_MASK;
//  310   SIM_SCGC3|=SIM_SCGC3_FTM2_MASK;
//  311 
//  312   FTM1_MOD = 20000;                 //可根据需要设置
//  313   FTM2_MOD = 20000;
//  314 
//  315   FTM1_CNTIN = 0;
//  316   FTM2_CNTIN = 0;
//  317 
//  318   FTM1_MODE |= FTM_MODE_WPDIS_MASK; //禁止写保护
//  319   FTM2_MODE |= FTM_MODE_WPDIS_MASK; //禁止写保护
//  320   FTM1_MODE |= FTM_MODE_FTMEN_MASK; //FTMEN=1,关闭TPM兼容模式，开启FTM所有功能
//  321   FTM2_MODE |= FTM_MODE_FTMEN_MASK; //FTMEN=1,关闭TPM兼容模式，开启FTM所有功能
//  322 
//  323   FTM1_QDCTRL &= ~FTM_QDCTRL_QUADMODE_MASK;  //选定编码模式为A相与B相编码模式
//  324   FTM1_QDCTRL |= FTM_QDCTRL_QUADEN_MASK;     //使能正交解码模式
//  325   FTM2_QDCTRL &= ~FTM_QDCTRL_QUADMODE_MASK;  //选定编码模式为A相与B相编码模式
//  326   FTM2_QDCTRL |= FTM_QDCTRL_QUADEN_MASK;     //使能正交解码模式
//  327 
//  328   FTM1_SC |= FTM_SC_CLKS(3);         //选择外部时钟
//  329   //FTM1_CONF |=FTM_CONF_BDMMODE(3); //可根据需要选择
//  330   FTM2_SC |= FTM_SC_CLKS(3);
//  331   //FTM2_CONF |=FTM_CONF_BDMMODE(3);
//  332 }
//  333 
//  334 */
//  335 
//  336 /*
//  337 
//  338 //------------------------------------------------------------------------------
//  339 //函数名：Ftm0Init
//  340 //功  能：电机驱动PWM初始化
//  341 //参  数：无
//  342 //返  回：无
//  343 //说  明：
//  344 //------------------------------------------------------------------------------
//  345 void Ftm0Init(void)
//  346 {
//  347   //打开PORTD模块门控时钟
//  348   SIM_SCGC5 |= SIM_SCGC5_PORTD_MASK;
//  349 
//  350   //将PORTD4设置为FTM0_ch4，将PORTD5设置为FTM0_ch5，数字输出高驱动能力
//  351   PORTD_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK; //D4为FTM0_ch4，电机左
//  352   PORTD_PCR5 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK; //D5为FTM0_ch5，电机右
//  353 
//  354   //使能FTM0时钟
//  355   SIM_SCGC6 |= SIM_SCGC6_FTM0_MASK;
//  356 
//  357   //配置FTM0_ch4为边沿对齐PWM，正极性
//  358   FTM0_C4SC |= FTM_CnSC_ELSB_MASK;
//  359   FTM0_C4SC &= ~FTM_CnSC_ELSA_MASK;
//  360   FTM0_C4SC |= FTM_CnSC_MSB_MASK;
//  361 
//  362   //配置FTM0_ch5为边沿对齐PWM，正极性
//  363   FTM0_C5SC |= FTM_CnSC_ELSB_MASK;
//  364   FTM0_C5SC &= ~FTM_CnSC_ELSA_MASK;
//  365   FTM0_C5SC |= FTM_CnSC_MSB_MASK;
//  366 
//  367   //时钟源选择sys_clk，对FTM计数器预分频16倍
//  368   FTM0_SC = FTM_SC_PS(4) | FTM_SC_CLKS(1);
//  369 
//  370   FTM0_MODE &= ~FTM_MODE_FTMEN_MASK;         //禁止FTM模块
//  371   //一旦禁止FTMEN，则FTM特定寄存器不能写入，即下述语句无效
//  372   FTM0_OUTMASK = 0xCF;                       //通道4、5禁止掩码，继续正常运行
//  373 
//  374   FTM0_COMBINE = 0;                          //用于已连接通道,全部禁止
//  375   FTM0_OUTINIT = 0;                          //外部输出初始化为0
//  376   FTM0_EXTTRIG = 0;                          //外部触发设置，全部禁止
//  377   FTM0_POL = 0;                              //输出极性设置，全部为正极性
//  378 
//  379   FTM0_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;     //正交解码器不使能，EPWM或者CPWM的条件
//  380 
//  381   FTM0_INVCTRL = 0;       //FTM倒置功能禁止
//  382   FTM0_SWOCTRL = 0;       //软件输出控制禁止
//  383   FTM0_PWMLOAD = 0;       //PWM加载控制禁止
//  384 
//  385   //下面设置PWM波的周期、占空比等参数
//  386   //PWM计算方法：CnV/MOD，MOD已知，通过调整CnV控制占空比
//  387   FTM0_CNTIN = 0;         //FTM计数初始值设置为0
//  388   FTM0_MOD = 1000;        //FTM计数器模数值为1000
//  389                           //采用LQ的时钟初始化函数，得到二分频的PWM，如sys_clk为100M，则PWM为50M
//  390                           //PWM频率f=sys_clk/2/(2^FTM0_SC_PS)/FTM0_MOD=150M/2/16/1000=4687.5Hz，周期0.213ms
//  391   FTM0_C4V = 0;           //脉宽设置为CnV - CNTIN，占空比为20%
//  392   FTM0_C5V = 0;
//  393   FTM0_CNT = 0;           //FTM计数器寄存器，低16位可以用，写入任何值将使其回到CNTIN
//  394 }
//  395 */
//  396 //------------------------------------------------------------------------------
//  397 //函数名：ServoInit
//  398 //功  能：舵机驱动PWM初始化
//  399 //参  数：无
//  400 //返  回：无
//  401 //说  明：
//  402 //------------------------------------------------------------------------------

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  403 void ServoInit(void)
//  404 {
//  405   //打开PORTA模块门控时钟
//  406   SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;
ServoInit:
        LDR.N    R0,??DataTable3_37  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x200
        LDR.N    R1,??DataTable3_37  ;; 0x40048038
        STR      R0,[R1, #+0]
//  407 
//  408   //将PORTB0设置为FTM1_ch0，数字输出高驱动能力
//  409   PORTA_PCR12 = PORT_PCR_MUX(0x3)| PORT_PCR_DSE_MASK;
        MOV      R0,#+832
        LDR.N    R1,??DataTable3_38  ;; 0x40049030
        STR      R0,[R1, #+0]
//  410 
//  411   //使能FTM1模块门控时钟
//  412   SIM_SCGC6|=SIM_SCGC6_FTM1_MASK;
        LDR.N    R0,??DataTable3_4  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000000
        LDR.N    R1,??DataTable3_4  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  413 
//  414   //配置FTM1_ch0为边沿对齐PWM，正极性
//  415   FTM1_C0SC |= FTM_CnSC_ELSB_MASK;
        LDR.N    R0,??DataTable3_39  ;; 0x4003900c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable3_39  ;; 0x4003900c
        STR      R0,[R1, #+0]
//  416   FTM1_C0SC &= ~FTM_CnSC_ELSA_MASK;
        LDR.N    R0,??DataTable3_39  ;; 0x4003900c
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4
        LDR.N    R1,??DataTable3_39  ;; 0x4003900c
        STR      R0,[R1, #+0]
//  417   FTM1_C0SC |= FTM_CnSC_MSB_MASK;
        LDR.N    R0,??DataTable3_39  ;; 0x4003900c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable3_39  ;; 0x4003900c
        STR      R0,[R1, #+0]
//  418 
//  419   //时钟源选择sys_clk，对FTM计数器预分频128倍
//  420   FTM1_SC = FTM_SC_PS(6) | FTM_SC_CLKS(1);
        MOVS     R0,#+14
        LDR.N    R1,??DataTable3_40  ;; 0x40039000
        STR      R0,[R1, #+0]
//  421 
//  422   FTM1_MODE &= ~FTM_MODE_FTMEN_MASK;         //禁止FTM模块
        LDR.N    R0,??DataTable3_41  ;; 0x40039054
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable3_41  ;; 0x40039054
        STR      R0,[R1, #+0]
//  423   FTM1_OUTMASK &= ~1;                        //通道0禁止掩码，继续正常运行
        LDR.N    R0,??DataTable3_42  ;; 0x40039060
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable3_42  ;; 0x40039060
        STR      R0,[R1, #+0]
//  424 
//  425   FTM1_COMBINE = 0;                          //用于已连接通道,全部禁止
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_43  ;; 0x40039064
        STR      R0,[R1, #+0]
//  426   FTM1_OUTINIT = 0;                          //外部输出初始化为0
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_44  ;; 0x4003905c
        STR      R0,[R1, #+0]
//  427   FTM1_EXTTRIG = 0;                          //外部触发设置，全部禁止
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_45  ;; 0x4003906c
        STR      R0,[R1, #+0]
//  428   FTM1_POL = 0;                              //输出极性设置，全部为正极性
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_46  ;; 0x40039070
        STR      R0,[R1, #+0]
//  429 
//  430   FTM1_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;     //正交解码器不使能，EPWM或者CPWM的条件
        LDR.N    R0,??DataTable3_47  ;; 0x40039080
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable3_47  ;; 0x40039080
        STR      R0,[R1, #+0]
//  431 
//  432   FTM1_INVCTRL = 0;     //FTM倒置功能禁止
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_48  ;; 0x40039090
        STR      R0,[R1, #+0]
//  433   FTM1_SWOCTRL = 0;     //软件输出控制禁止
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_49  ;; 0x40039094
        STR      R0,[R1, #+0]
//  434   FTM1_PWMLOAD = 0;     //PWM加载控制禁止
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_50  ;; 0x40039098
        STR      R0,[R1, #+0]
//  435 
//  436   //下面设置PWM波的周期、占空比等参数
//  437   //PWM计算方法：CnV/MOD，MOD已知，通过调整CnV控制占空比
//  438   FTM1_CNTIN = 0;         //FTM计数初始值设置为0
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_51  ;; 0x4003904c
        STR      R0,[R1, #+0]
//  439   FTM1_MOD = 23437 - 1;        //FTM计数器模数值为2000
        MOVW     R0,#+23436
        LDR.N    R1,??DataTable3_52  ;; 0x40039008
        STR      R0,[R1, #+0]
//  440                           //采用LQ的时钟初始化函数，得到二分频的PWM，如sys_clk为100M，则PWM为50M
//  441                           //PWM频率f=sys_clk/2/(2^FTM1_SC_PS)/FTM1_MOD=150M/2/128/1953=300.02Hz，周期3.33ms
//  442   FTM1_C0V = 1750;      //脉宽设置为CnV - CNTIN，占空比为20%
        MOVW     R0,#+1750
        LDR.N    R1,??DataTable3_53  ;; 0x40039010
        STR      R0,[R1, #+0]
//  443   //4.3% 4.4%(L) 4.5% 5.0% 5.5% 6.0% 6.5% 7.0% 7.15%(C) 7.5% 8.0% 8.5% 9.0% 9.5% 9.9%(R) 10.0% 10.3% 10.5%
//  444   //1008 1031    1055 1172 1289 1406 1523 1640 1676     1758 1875 1992 2109 2226 2320    2344  2414  4922
//  445   
//  446   //6.3% 1476
//  447   //6.55% 1535
//  448   //6.6% 1547
//  449   //6.8% 1594
//  450   //6.9% 1617
//  451   //7.45% 1746
//  452   //7.9% 1851
//  453   //8.45% 1980
//  454   //8.7% 2039
//  455   //8.9% 2086
//  456   //9.3% 2180
//  457   // 1965   1765   1580
//  458   FTM1_CNT = 0;           //FTM计数器寄存器，低16位可以用，写入任何值将使其回到CNTIN
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_54  ;; 0x40039004
        STR      R0,[R1, #+0]
//  459 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     0x4004c010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     0x4004c014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     0x4004c018

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     0x4004c01c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     0x4003802c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     0x40038034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     0x4003803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_8:
        DC32     0x40038044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_9:
        DC32     0x40038000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_10:
        DC32     0x40038054

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_11:
        DC32     0x40038060

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_12:
        DC32     0x40038064

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_13:
        DC32     0x4003805c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_14:
        DC32     0x4003806c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_15:
        DC32     0x40038070

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_16:
        DC32     0x40038080

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_17:
        DC32     0x40038090

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_18:
        DC32     0x40038094

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_19:
        DC32     0x40038098

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_20:
        DC32     0x4003804c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_21:
        DC32     0x40038008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_22:
        DC32     0x40038030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_23:
        DC32     0x40038038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_24:
        DC32     0x40038040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_25:
        DC32     0x40038048

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_26:
        DC32     0x40038004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_27:
        DC32     0x4004a048

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_28:
        DC32     0x4004a04c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_29:
        DC32     0x40049028

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_30:
        DC32     0x4004902c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_31:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_32:
        DC32     0x400b8054

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_33:
        DC32     0x400b8080

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_34:
        DC32     0x400b804c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_35:
        DC32     0x400b8008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_36:
        DC32     0x400b8004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_37:
        DC32     0x40048038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_38:
        DC32     0x40049030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_39:
        DC32     0x4003900c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_40:
        DC32     0x40039000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_41:
        DC32     0x40039054

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_42:
        DC32     0x40039060

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_43:
        DC32     0x40039064

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_44:
        DC32     0x4003905c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_45:
        DC32     0x4003906c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_46:
        DC32     0x40039070

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_47:
        DC32     0x40039080

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_48:
        DC32     0x40039090

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_49:
        DC32     0x40039094

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_50:
        DC32     0x40039098

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_51:
        DC32     0x4003904c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_52:
        DC32     0x40039008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_53:
        DC32     0x40039010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_54:
        DC32     0x40039004

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
//  460 
//  461 
//  462 
//  463 
//  464 
//  465 
//  466 
//  467 
// 
//     2 bytes in section .data
// 1 232 bytes in section .text
// 
// 1 232 bytes of CODE memory
//     2 bytes of DATA memory
//
//Errors: none
//Warnings: none
