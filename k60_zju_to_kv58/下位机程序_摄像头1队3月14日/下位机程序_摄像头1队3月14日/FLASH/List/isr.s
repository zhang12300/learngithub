///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.30.3.8024/W32 for ARM       14/Mar/2018  19:12:13
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\isr.c
//    Command line =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\isr.c -D IAR
//        -D TWR_K60N512 -lCN
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\List\ -lB
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\List\ -o
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\Obj\ --no_cse
//        --no_unroll --no_inline --no_code_motion --no_tbaa --no_clustering
//        --no_scheduling --debug --endian=little --cpu=Cortex-M4 -e --fpu=None
//        --dlib_config "C:\Program Files (x86)\IAR Systems\Embedded Workbench
//        7.0\arm\INC\c\DLib_Config_Normal.h" -I
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\H\ -I
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\H\Component_H\
//        -I E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\H\Frame_H\
//        -I
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\H\Function_H\
//        -I E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\H\SD_H\ -Ol
//        --use_c++_inline
//    List file    =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\List\isr.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN FieldIsr
        EXTERN ImgPresent
        EXTERN ImgStatus
        EXTERN LineCount
        EXTERN LineIsr
        EXTERN StopRealFlag
        EXTERN TimeOutFlag
        EXTERN TimeRealRunFlag
        EXTERN disable_irq
        EXTERN disable_pit_interrupt
        EXTERN enable_irq
        EXTERN light_control
        EXTERN uart_re1
        EXTERN uart_sendN

        PUBLIC DMA0_Isr
        PUBLIC DiffCountL
        PUBLIC DiffCountR
        PUBLIC ErrorCountNow9
        PUBLIC LightHouseWaitStartTooLongFlag
        PUBLIC PIT0Count
        PUBLIC PIT0_Isr
        PUBLIC PIT1_Isr
        PUBLIC PIT2_Isr
        PUBLIC PIT2_Isr_Change
        PUBLIC PORTA_Isr
        PUBLIC PORTB_Isr
        PUBLIC PORTC_Isr
        PUBLIC PORTD_Isr
        PUBLIC PORTE_Isr
        PUBLIC QuadChangeFlag
        PUBLIC QuadDoneFlag
        PUBLIC QuadLeftCount
        PUBLIC QuadRightCount
        PUBLIC ch0
        PUBLIC ch1
        PUBLIC ch2
        PUBLIC ch3
        PUBLIC ch4
        PUBLIC ch5
        PUBLIC ch6
        PUBLIC cnt
        PUBLIC uart0_isr

// E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\isr.c
//    1 //-------------------------------------------------------------------------*
//    2 // 文件名: isr.c                                                           *
//    3 // 说  明: 中断处理例程                                                    *
//    4 //---------------苏州大学飞思卡尔嵌入式系统实验室2011年--------------------*
//    5 
//    6 #include "includes.h"
//    7 #include "common.h"
//    8 #include "DMA.h"
//    9 #include "ImageGet.h"
//   10 #include "Pit.h"
//   11 #include "RunControl.h"
//   12 #include "Debug.h"
//   13 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   14 uint32 ErrorCountNow9 = 0;
ErrorCountNow9:
        DS8 4
//   15 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   16 uint8 QuadChangeFlag = 0;       //左右编码器切换标志位 
QuadChangeFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   17 uint32 QuadLeftCount = 0;       //左编码器计数值，越大表示速度越快。
QuadLeftCount:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   18 uint32 QuadRightCount = 0;      //右编码器计数值，越大表示速度越快。
QuadRightCount:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   19 uint8 PIT0Count = 0;            //PIT0计数值
PIT0Count:
        DS8 1
//   20 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   21 uint16 DiffCountL = 0;        //用于差速测量时，左轮脉冲数的总计数。
DiffCountL:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   22 uint16 DiffCountR = 0;        //用于差速测量时，右轮脉冲数的总计数。
DiffCountR:
        DS8 2
//   23 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   24 uint8 PIT2_Isr_Change = 0;    //PIT2的功能复用选择。0表示用于发车时的5秒计数，1表示用于定时停车。
PIT2_Isr_Change:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   25 uint8 LightHouseWaitStartTooLongFlag = 0;   //灯塔等久标志位置位
LightHouseWaitStartTooLongFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   26 volatile uint8 QuadDoneFlag = 0;         //编码器速度值采集完成标志，0未完成，1完成。
QuadDoneFlag:
        DS8 1
//   27 
//   28 //串口相关

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   29 uint8 ch0;
ch0:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   30 uint8 ch1;
ch1:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   31 uint8 ch2;
ch2:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   32 uint8 ch3;
ch3:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   33 uint8 ch4;
ch4:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   34 uint8 ch5;
ch5:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   35 uint8 ch6;
ch6:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   36 uint8 cnt = 0;
cnt:
        DS8 1
//   37 
//   38 //-------------------------------------------------------------------------*
//   39 //函数名: uart3_isr                                                        *
//   40 //功  能: 串口3数据接收中断例程                                            *
//   41 //说  明: 无                                                               *
//   42 //-------------------------------------------------------------------------*

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   43 void uart0_isr(void)
//   44 {
uart0_isr:
        PUSH     {R7,LR}
//   45     uint8 ch;
//   46     DisableInterrupts;		//关总中断
        CPSID i
//   47     
//   48     if(cnt == 0){uart_re1 (UART0,&ch0);cnt++;}
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??uart0_isr_0
        LDR.N    R1,??DataTable9_1
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_re1
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable9
        STRB     R0,[R1, #+0]
//   49     if(cnt == 1){uart_re1 (UART0,&ch1);cnt++;}
??uart0_isr_0:
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??uart0_isr_1
        LDR.N    R1,??DataTable9_3
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_re1
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable9
        STRB     R0,[R1, #+0]
//   50     if(cnt == 2){uart_re1 (UART0,&ch2);cnt++;}
??uart0_isr_1:
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??uart0_isr_2
        LDR.N    R1,??DataTable9_4
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_re1
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable9
        STRB     R0,[R1, #+0]
//   51     if(cnt == 3){uart_re1 (UART0,&ch3);cnt++;}
??uart0_isr_2:
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??uart0_isr_3
        LDR.N    R1,??DataTable9_5
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_re1
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable9
        STRB     R0,[R1, #+0]
//   52     if(cnt == 4){uart_re1 (UART0,&ch4);cnt++;}
??uart0_isr_3:
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??uart0_isr_4
        LDR.N    R1,??DataTable9_6
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_re1
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable9
        STRB     R0,[R1, #+0]
//   53     if(cnt == 5){uart_re1 (UART0,&ch5);cnt++;}
??uart0_isr_4:
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??uart0_isr_5
        LDR.N    R1,??DataTable9_7
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_re1
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable9
        STRB     R0,[R1, #+0]
//   54     if(cnt == 6)
??uart0_isr_5:
        LDR.N    R0,??DataTable9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??uart0_isr_6
//   55     {
//   56         uart_re1 (UART0,&ch6);cnt=0;
        LDR.N    R1,??DataTable9_8
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_re1
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9
        STRB     R0,[R1, #+0]
//   57         if(ch0==0xFF && ch1==0x55 && ch2==0xAA && ch3==0x77 && ch4==0x01 && ch5==0x06 && ch6==0x7C)
        LDR.N    R0,??DataTable9_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+255
        BNE.N    ??uart0_isr_7
        LDR.N    R0,??DataTable9_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+85
        BNE.N    ??uart0_isr_7
        LDR.N    R0,??DataTable9_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+170
        BNE.N    ??uart0_isr_7
        LDR.N    R0,??DataTable9_5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+119
        BNE.N    ??uart0_isr_7
        LDR.N    R0,??DataTable9_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??uart0_isr_7
        LDR.N    R0,??DataTable9_7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??uart0_isr_7
        LDR.N    R0,??DataTable9_8
        LDRB     R0,[R0, #+0]
        CMP      R0,#+124
        BNE.N    ??uart0_isr_7
//   58         {
//   59             uart_sendN(UART0, (uint8 *)"\nCar Start!", 11);
        MOVS     R2,#+11
        LDR.N    R1,??DataTable9_9
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_sendN
//   60             StopRealFlag = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_10
        STRB     R0,[R1, #+0]
//   61             light_control(PORTE, 26, Light_ON);
        MOVS     R2,#+0
        MOVS     R1,#+26
        LDR.N    R0,??DataTable9_11  ;; 0x400ff100
        BL       light_control
//   62         }
//   63         if(ch0==0xFF && ch1==0x55 && ch2==0xAA && ch3==0x77 && ch4==0x01 && ch5==0x07 && ch6==0x7D)
??uart0_isr_7:
        LDR.N    R0,??DataTable9_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+255
        BNE.N    ??uart0_isr_6
        LDR.N    R0,??DataTable9_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+85
        BNE.N    ??uart0_isr_6
        LDR.N    R0,??DataTable9_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+170
        BNE.N    ??uart0_isr_6
        LDR.N    R0,??DataTable9_5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+119
        BNE.N    ??uart0_isr_6
        LDR.N    R0,??DataTable9_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??uart0_isr_6
        LDR.N    R0,??DataTable9_7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.N    ??uart0_isr_6
        LDR.N    R0,??DataTable9_8
        LDRB     R0,[R0, #+0]
        CMP      R0,#+125
        BNE.N    ??uart0_isr_6
//   64         {
//   65             uart_sendN(UART0, (uint8 *)"\nCar Stop!", 10);
        MOVS     R2,#+10
        LDR.N    R1,??DataTable9_12
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_sendN
//   66             StopRealFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_10
        STRB     R0,[R1, #+0]
//   67             light_control(PORTE, 26, Light_OFF);
        MOVS     R2,#+1
        MOVS     R1,#+26
        LDR.N    R0,??DataTable9_11  ;; 0x400ff100
        BL       light_control
//   68         }
//   69     }
//   70     
//   71 	EnableInterrupts;		//开总中断
??uart0_isr_6:
        CPSIE i
//   72 }
        POP      {R0,PC}          ;; return
//   73 
//   74 //------------------------------------------------------------------------------
//   75 //函数名：PIT0_Isr
//   76 //功  能：周期中断定时器PIT0中断服务函数
//   77 //参  数：无
//   78 //返  回：无
//   79 //说  明：
//   80     //暂定5ms进一次中断，进两次采集完两个编码器的值。
//   81     //图像采集完成后、图像处理前，开启这个中断，与图像处理并行。
//   82     //第2次进来时关掉这个中断。
//   83 //------------------------------------------------------------------------------

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   84 void PIT0_Isr(void)
//   85 {       
PIT0_Isr:
        PUSH     {R7,LR}
//   86     if((PIT_TFLG(0)&PIT_TFLG_TIF_MASK)!=0)
        LDR.N    R0,??DataTable9_13  ;; 0x4003710c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??PIT0_Isr_0
//   87     {
//   88       PIT_TFLG(0) |= PIT_TFLG_TIF_MASK;  //清中断标志
        LDR.N    R0,??DataTable9_13  ;; 0x4003710c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable9_13  ;; 0x4003710c
        STR      R0,[R1, #+0]
//   89     }
//   90     
//   91     //gpio_reverse(PORTE, 26);
//   92     
//   93     //计数值加1。
//   94     //PIT0Count++;
//   95     //编码器速度值采集完成标志，0未完成，1完成。
//   96     //QuadDoneFlag = 0;    
//   97     QuadLeftCount = FTM2_CNT;    //记录记数器的值。
??PIT0_Isr_0:
        LDR.N    R0,??DataTable9_14  ;; 0x400b8004
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable9_15
        STR      R0,[R1, #+0]
//   98     FTM2_CNT = 0; 
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_14  ;; 0x400b8004
        STR      R0,[R1, #+0]
//   99     
//  100     //禁止PIT。很关键的一步，使得下一次从头开始倒数。
//  101     PIT_TCTRL(PIT0) &= ~(PIT_TCTRL_TEN_MASK);       //禁止pit模块运行
        LDR.N    R0,??DataTable9_16  ;; 0x40037108
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable9_16  ;; 0x40037108
        STR      R0,[R1, #+0]
//  102     //关掉中断。
//  103     disable_pit_interrupt(PIT0);
        MOVS     R0,#+0
        BL       disable_pit_interrupt
//  104     //编码器速度值采集完成标志，0未完成，1完成。
//  105     QuadDoneFlag = 1; 
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_17
        STRB     R0,[R1, #+0]
//  106 }
        POP      {R0,PC}          ;; return
//  107 /*
//  108 void PIT0_Isr(void)
//  109 {       
//  110     if((PIT_TFLG(0)&PIT_TFLG_TIF_MASK)!=0)
//  111     {
//  112       PIT_TFLG(0) |= PIT_TFLG_TIF_MASK;  //清中断标志
//  113     }
//  114     
//  115     //gpio_reverse(PORTE, 26);
//  116     
//  117     //计数值加1。
//  118     PIT0Count++;
//  119     //编码器速度值采集完成标志，0未完成，1完成。
//  120     QuadDoneFlag = 0;         
//  121 
//  122     if(QuadChangeFlag == 0)
//  123     {
//  124       QuadChangeFlag = 1;          //切换至右编码器的标志。
//  125       QuadLeftCount = FTM2_CNT;    //记录记数器的值。
//  126       
//  127       DiffCountL += QuadLeftCount;
//  128       
//  129       FTM2_CNT = 0;                //计数器清零。
//  130       //右路A相 A10, B相 A11。打开。
//  131       PORTA_PCR10 = PORT_PCR_MUX(6); // 设置引脚A10为FTM2_PHA功能  
//  132       PORTA_PCR11 = PORT_PCR_MUX(6); // 设置引脚A11为FTM2_PHB功能   
//  133       //左路A相 B18, B相 B19。置为无效复用。
//  134       PORTB_PCR18 = PORT_PCR_MUX(5); // 设置引脚B18为无效复用。
//  135       PORTB_PCR19 = PORT_PCR_MUX(5); // 设置引脚B19为无效复用。   
//  136     }
//  137     else
//  138     {
//  139       QuadChangeFlag = 0;          //切换至左编码器的标志。
//  140       QuadRightCount = FTM2_CNT;   //记录记数器的值。
//  141       
//  142       DiffCountR += QuadRightCount;
//  143       
//  144       FTM2_CNT = 0;                //计数器清零。
//  145       //左路A相 B18, B相 B19。打开。
//  146       PORTB_PCR18 = PORT_PCR_MUX(6); // 设置引脚B18为FTM2_PHA功能  
//  147       PORTB_PCR19 = PORT_PCR_MUX(6); // 设置引脚B19为FTM2_PHB功能   
//  148       //右路A相 A10, B相 A11。置为无效复用。
//  149       PORTA_PCR10 = PORT_PCR_MUX(5); // 设置引脚A10为无效复用。
//  150       PORTA_PCR11 = PORT_PCR_MUX(5); // 设置引脚A11为无效复用。 
//  151       
//  152       //禁止PIT。很关键的一步，使得下一次从头开始倒数。
//  153       PIT_TCTRL(PIT0) &= ~(PIT_TCTRL_TEN_MASK);       //禁止pit模块运行
//  154       //关掉中断。
//  155       disable_pit_interrupt(PIT0);
//  156       //编码器速度值采集完成标志，0未完成，1完成。
//  157       QuadDoneFlag = 1; 
//  158       
//  159       
//  160       
//  161     }
//  162     
//  163      
//  164 }
//  165 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  166 void PIT1_Isr(void)
//  167 {       
//  168     if((PIT_TFLG(1)&PIT_TFLG_TIF_MASK)!=0)
PIT1_Isr:
        LDR.N    R0,??DataTable9_18  ;; 0x4003711c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??PIT1_Isr_0
//  169     {
//  170       PIT_TFLG(1) |= PIT_TFLG_TIF_MASK;  //清中断标志
        LDR.N    R0,??DataTable9_18  ;; 0x4003711c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable9_18  ;; 0x4003711c
        STR      R0,[R1, #+0]
//  171     }
//  172     //FTM0_C7V = 0;
//  173     TimeOutFlag = 1;
??PIT1_Isr_0:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_19
        STRB     R0,[R1, #+0]
//  174 }
        BX       LR               ;; return
//  175 //------------------------------------------------------------------------------
//  176 //函数名：PIT2_Isr
//  177 //功  能：周期中断定时器PIT2中断服务函数
//  178 //参  数：无
//  179 //返  回：无
//  180 //说  明：1. 用来定时跑车计数
//  181 //
//  182 //------------------------------------------------------------------------------

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  183 void PIT2_Isr(void)
//  184 {
PIT2_Isr:
        PUSH     {R7,LR}
//  185   if((PIT_TFLG(2)&PIT_TFLG_TIF_MASK)!=0)
        LDR.N    R0,??DataTable9_20  ;; 0x4003712c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??PIT2_Isr_0
//  186   {
//  187     PIT_TFLG(2) |= PIT_TFLG_TIF_MASK;  //清中断标志
        LDR.N    R0,??DataTable9_20  ;; 0x4003712c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable9_20  ;; 0x4003712c
        STR      R0,[R1, #+0]
//  188   }
//  189   
//  190   //第一种功能是灯塔发车的5秒计时。
//  191   if(PIT2_Isr_Change == 0)
??PIT2_Isr_0:
        LDR.N    R0,??DataTable9_21
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??PIT2_Isr_1
//  192   {
//  193     //改用第二种功能。
//  194     PIT2_Isr_Change = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_21
        STRB     R0,[R1, #+0]
//  195     
//  196     //灯塔等久标志位置位
//  197     LightHouseWaitStartTooLongFlag = 1;    
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_22
        STRB     R0,[R1, #+0]
//  198     //进来一次后就不用再进来了。如果需要定时停车，需要重新给计数值后，再enable一次。
//  199     disable_pit_interrupt(PIT2);
        MOVS     R0,#+2
        BL       disable_pit_interrupt
        B.N      ??PIT2_Isr_2
//  200   }
//  201   //第二种功能是定时停车计时。
//  202   else
//  203   {
//  204     //定时跑标志置1。表示定时跑完成，应该马上停车。
//  205     TimeRealRunFlag = 1;
??PIT2_Isr_1:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_23
        STRB     R0,[R1, #+0]
//  206     //进来一次后就不用再进来了。一辈子只进来一次。
//  207     disable_pit_interrupt(PIT2);
        MOVS     R0,#+2
        BL       disable_pit_interrupt
//  208   }
//  209   
//  210 
//  211   
//  212 }
??PIT2_Isr_2:
        POP      {R0,PC}          ;; return
//  213 
//  214 //DMA0传输结束函数，由PCLK触发，B9
//  215 //这些处理放在这里，而不是放在LineIsr的原因是LineIsr进入后要马上开始采数据，来不及

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  216 void DMA0_Isr(void)
//  217 {
DMA0_Isr:
        PUSH     {R7,LR}
//  218   
//  219     uint8 DMACHno = 0;
        MOVS     R0,#+0
//  220   
//  221     ErrorCountNow9++;
        LDR.N    R1,??DataTable9_24
        LDR      R1,[R1, #+0]
        ADDS     R1,R1,#+1
        LDR.N    R2,??DataTable9_24
        STR      R1,[R2, #+0]
//  222     
//  223     
//  224     DMA_INT |= (1 << DMACHno);    //清DMA0通道传输完成中断标志位
        LDR.N    R1,??DataTable9_25  ;; 0x40008024
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LSLS     R0,R2,R0
        ORRS     R0,R0,R1
        LDR.N    R1,??DataTable9_25  ;; 0x40008024
        STR      R0,[R1, #+0]
//  225     LineCount++;              //采集行计数值加1
        LDR.N    R0,??DataTable9_26
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable9_26
        STRH     R0,[R1, #+0]
//  226     
//  227     if(LineCount >= CameraHight)   //如果采集完成
        LDR.N    R0,??DataTable9_26
        LDRH     R0,[R0, #+0]
        CMP      R0,#+60
        BLT.N    ??DMA0_Isr_0
//  228     {
//  229         ImgStatus = ImgGetFinish;    //图像采集结束标志位
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_27
        STRB     R0,[R1, #+0]
//  230            
//  231         if(ImgPresent == ImgNO1)  
        LDR.N    R0,??DataTable9_28
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DMA0_Isr_1
//  232         //如果当前采集的是第1幅图像，那么第1幅图像就采集完了，准备采集第2幅图像
//  233         {
//  234             ImgPresent = ImgNO2;  
        MOVS     R0,#+2
        LDR.N    R1,??DataTable9_28
        STRB     R0,[R1, #+0]
        B.N      ??DMA0_Isr_2
//  235         }
//  236         else if(ImgPresent == ImgNO2)
??DMA0_Isr_1:
        LDR.N    R0,??DataTable9_28
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DMA0_Isr_2
//  237         //如果当前采集的是第2幅图像，那么第2幅图像就采集完了，准备采集第1幅图像
//  238         {
//  239             ImgPresent = ImgNO1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable9_28
        STRB     R0,[R1, #+0]
//  240         }
//  241         else
//  242         {
//  243             //uart_sendN(UART0, (uint8 *)"\nError In DMA0_Isr()!", 21);  //错误警告 
//  244         }
//  245                 
//  246         //disable_irq(FIELD_IRQ);   //场中断IRQ禁用，等待下一次ImgGet()函数再开启
//  247         disable_irq(LINE_IRQ);    //行中断IRQ禁用
??DMA0_Isr_2:
        MOVS     R0,#+89
        BL       disable_irq
//  248         enable_irq(DMA0_IRQ);    //DMA0的IRQ禁用   
        MOVS     R0,#+0
        BL       enable_irq
//  249          
//  250     }   
//  251     
//  252   /*
//  253     uint8 DMACHno = 0;
//  254     DMA_INT |= (1 << DMACHno);    //清DMA0通道传输完成中断标志位
//  255     LineCount++;              //采集行计数值加1
//  256     
//  257     if(LineCount >= CameraHight)   //如果采集完成
//  258     {
//  259         ImgStatus = ImgGetFinish;    //图像采集结束标志位
//  260         disable_irq(FIELD_IRQ);   //场中断IRQ禁用，等待下一次ImgGet()函数再开启
//  261         disable_irq(LINE_IRQ);    //行中断IRQ禁用
//  262         disable_irq(DMA0_IRQ);    //DMA0的IRQ禁用          
//  263     }
//  264     */
//  265 }
??DMA0_Isr_0:
        POP      {R0,PC}          ;; return
//  266  
//  267 
//  268 //PORTA中断服务函数
//  269 //这个的IRQ不会打开，正常情况不会进来。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  270 void PORTA_Isr(void)  
//  271 {
PORTA_Isr:
        PUSH     {R7,LR}
//  272     PORTA_ISFR = ~0;
        MOVS     R0,#-1
        LDR.N    R1,??DataTable9_29  ;; 0x400490a0
        STR      R0,[R1, #+0]
//  273     uart_sendN(UART0, (uint8 *)"\nError In PORTA_Isr()!", 22); //错误警告
        MOVS     R2,#+22
        LDR.N    R1,??DataTable9_30
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_sendN
//  274 }
        POP      {R0,PC}          ;; return
//  275 
//  276 
//  277 //PORTB中断服务函数，含PCLK引发的DMA，B9
//  278 //这个的IRQ不会打开，正常情况不会进来。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  279 void PORTB_Isr(void)  
//  280 {
PORTB_Isr:
        PUSH     {R7,LR}
//  281     PORTB_ISFR = ~0;
        MOVS     R0,#-1
        LDR.N    R1,??DataTable9_31  ;; 0x4004a0a0
        STR      R0,[R1, #+0]
//  282     uart_sendN(UART0, (uint8 *)"\nError In PORTB_Isr()!", 22);  //错误警告
        MOVS     R2,#+22
        LDR.N    R1,??DataTable9_32
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_sendN
//  283 }
        POP      {R0,PC}          ;; return
//  284 
//  285 
//  286 //PORTC中断服务函数，含行中断，C8

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  287 void PORTC_Isr(void)  
//  288 {
PORTC_Isr:
        PUSH     {R7,LR}
//  289     uint32 FlagTmp = PORTC_ISFR;  
        LDR.N    R0,??DataTable9_33  ;; 0x4004b0a0
        LDR      R0,[R0, #+0]
//  290     PORTC_ISFR =  ~0;             //清除PORTC的所有中断标志位
        MOVS     R1,#-1
        LDR.N    R2,??DataTable9_33  ;; 0x4004b0a0
        STR      R1,[R2, #+0]
//  291     
//  292     if(FlagTmp & (1 << PIN_LINE))   //如果确认是行中断的
        LSLS     R0,R0,#+23
        BPL.N    ??PORTC_Isr_0
//  293     {
//  294         LineIsr();                    //进行中断处理函数
        BL       LineIsr
//  295     }
//  296 }
??PORTC_Isr_0:
        POP      {R0,PC}          ;; return
//  297 
//  298 
//  299 
//  300 //PORTD中断服务函数，含场中断，D1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  301 void PORTD_Isr(void)  
//  302 {
PORTD_Isr:
        PUSH     {R7,LR}
//  303     uint32 FlagTmp = PORTD_ISFR;  
        LDR.N    R0,??DataTable9_34  ;; 0x4004c0a0
        LDR      R0,[R0, #+0]
//  304     PORTD_ISFR =  ~0;             //清除PORTD的所有中断标志位
        MOVS     R1,#-1
        LDR.N    R2,??DataTable9_34  ;; 0x4004c0a0
        STR      R1,[R2, #+0]
//  305     
//  306     if(FlagTmp & (1 << PIN_FIELD))   //如果确认是场中断的
        LSLS     R0,R0,#+30
        BPL.N    ??PORTD_Isr_0
//  307     {
//  308         FieldIsr();                    //进场中断处理函数
        BL       FieldIsr
//  309     }
//  310 
//  311 }
??PORTD_Isr_0:
        POP      {R0,PC}          ;; return
//  312 
//  313 
//  314 
//  315 //PORTE中断服务函数
//  316 //这个的IRQ不会打开，正常情况不会进来。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  317 void PORTE_Isr(void)  
//  318 {
PORTE_Isr:
        PUSH     {R7,LR}
//  319     PORTE_ISFR = ~0;
        MOVS     R0,#-1
        LDR.N    R1,??DataTable9_35  ;; 0x4004d0a0
        STR      R0,[R1, #+0]
//  320     uart_sendN(UART0, (uint8 *)"\nError In PORTE_Isr()!", 22);   //错误警告
        MOVS     R2,#+22
        LDR.N    R1,??DataTable9_36
        LDR.N    R0,??DataTable9_2  ;; 0x4006a000
        BL       uart_sendN
//  321 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC32     cnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_1:
        DC32     ch0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_2:
        DC32     0x4006a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     ch1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     ch2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_5:
        DC32     ch3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_6:
        DC32     ch4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_7:
        DC32     ch5

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_8:
        DC32     ch6

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_9:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_10:
        DC32     StopRealFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_11:
        DC32     0x400ff100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_12:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_13:
        DC32     0x4003710c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_14:
        DC32     0x400b8004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_15:
        DC32     QuadLeftCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_16:
        DC32     0x40037108

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_17:
        DC32     QuadDoneFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_18:
        DC32     0x4003711c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_19:
        DC32     TimeOutFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_20:
        DC32     0x4003712c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_21:
        DC32     PIT2_Isr_Change

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_22:
        DC32     LightHouseWaitStartTooLongFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_23:
        DC32     TimeRealRunFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_24:
        DC32     ErrorCountNow9

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_25:
        DC32     0x40008024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_26:
        DC32     LineCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_27:
        DC32     ImgStatus

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_28:
        DC32     ImgPresent

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_29:
        DC32     0x400490a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_30:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_31:
        DC32     0x4004a0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_32:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_33:
        DC32     0x4004b0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_34:
        DC32     0x4004c0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_35:
        DC32     0x4004d0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_36:
        DC32     ?_4

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_0:
        DATA
        DC8 "\012Car Start!"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "\012Car Stop!"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "\012Error In PORTA_Isr()!"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC8 "\012Error In PORTB_Isr()!"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_4:
        DATA
        DC8 "\012Error In PORTE_Isr()!"
        DC8 0

        END
//  322 
//  323 
//  324 
//  325   
//  326 
//  327 /*
//  328 void porta_isr(void)//场中断，A24，下降沿中断
//  329 {
//  330   
//  331 	PORTA_PCR24 |= PORT_PCR_ISF_MASK;//清除中断标志
//  332 	DMA0_Init();
//  333 	enable_irq(0);//使能DMA通道0完成中断
//  334 	row=0;//初始化行
//  335 	imagerow=0;//初始化采集行
//  336 	enable_irq (88);//使能B口中断 ，B10行中断
//  337 
//  338 }
//  339 */
// 
//  29 bytes in section .bss
//  96 bytes in section .rodata
// 864 bytes in section .text
// 
// 864 bytes of CODE  memory
//  96 bytes of CONST memory
//  29 bytes of DATA  memory
//
//Errors: none
//Warnings: 1
