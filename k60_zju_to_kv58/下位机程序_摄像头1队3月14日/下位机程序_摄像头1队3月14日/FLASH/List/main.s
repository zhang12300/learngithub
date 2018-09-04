///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.30.3.8024/W32 for ARM       14/Mar/2018  19:12:13
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\main.c
//    Command line =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\main.c -D IAR
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
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\List\main.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN AngleSpeDealFlag
        EXTERN BatteryCheckInit
        EXTERN BatteryCheckUpdate
        EXTERN CameraInit
        EXTERN DMAInit
        EXTERN DebugDebug
        EXTERN DebugInit
        EXTERN DebugSwitchFlag
        EXTERN DebugSwitchScan
        EXTERN FlashFinalWrite
        EXTERN GryoDeal
        EXTERN GyroInit
        EXTERN ImagePro
        EXTERN ImageSend
        EXTERN ImgStatus
        EXTERN ImgStore1
        EXTERN LCD_CLS
        EXTERN LCD_P8x16Str
        EXTERN MotorInit_SYJ
        EXTERN MotorPID
        EXTERN QuadDoneFlag
        EXTERN QuadInit3
        EXTERN ServoInit
        EXTERN ServoPID
        EXTERN SpeedRealTimeGet
        EXTERN VariablesInit
        EXTERN Virtual2SendData
        EXTERN disable_irq
        EXTERN enable_irq
        EXTERN enable_pit_interrupt
        EXTERN gpio_init
        EXTERN hw_adc_init
        EXTERN light_control
        EXTERN light_init
        EXTERN periph_clk_khz
        EXTERN pit_init
        EXTERN uart_init
        EXTERN uart_sendN

        PUBLIC DLY_ms
        PUBLIC main

// E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\main.c
//    1 /******************************************************************************
//    2 1、程序继承于12级侯佳佐学长的程序，图像部分加了补丁，但是补丁的参数都是写死的，不一定
//    3 适合所有的车。如果补丁出现问题，可以换用侯佳佐学长的程序，然后按照我在报告中提到的补丁
//    4 思路把补丁加上。
//    5 
//    6 2、前期不会用到OLED、编码器、陀螺仪，可以关闭的功能我都用“（开始阶段可以先关闭）”备注
//    7 了
//    8 
//    9 3、建议进阶顺序为：蓝牙工作---摄像头采图---舵机打角---电机运行---OLED调参---编码器--
//   10 -陀螺仪
//   11 
//   12 4、注意，如果不关闭OLED调参功能的话，参数都是从Flash中读取的，必须保证Flash中已经设置
//   13 好了参数。建议前期关闭OLED调参功能，这些参数我都设置了默认值，关闭OLED调参功能后会以默
//   14 认参数运行。
//   15 
//   16 5、图像程序，建议结合上位机来理解图像程序。在智能车报告中我用了大篇幅专门阐述了图像处理
//   17 的思路和我在侯佳佐学长图像的基础上增加的几个补丁，可以向涛哥要往届学长的报告，但愿这些
//   18 内容会对做图像的同学在开始阶段理解图像程序有所帮助。
//   19 
//   20 6、停车线、十字的二重判定、堵转停车、跑出赛道停车等功能关闭了，停车线的函数是ImagePro.c
//   21 中的StopLineCheck()，十字二重判定的函数是ImagePro.c中的ShiZhiCheck()，均通过ImagePro.c
//   22 中的PathJudgeNew()调用。堵转停车和跑出赛道，可以通过搜索DuZhuanFlag和RunOutFlag找到
//   23 相关的代码。之所以关闭这些功能，是为了避免在你们还不熟悉图像程序的时候，调试中出现突然
//   24 停车的情况。
//   25 
//   26 7、电机PWM的控制，1、2口被我们用来控制电机驱动板的使能了，3、4口才是控制电机转速的，使
//   27 用的时候特别注意
//   28 
//   29 8、组员之间分工明确，既然决定做智能车了，就要做好以后没有课余时间的准备。控制部分多调试
//   30 积累经验，图像部分结合上位机理解不要逃避，硬件部分先用往届的板子尽早做出自己的板子，
//   31 祝愿你们取得好成绩！
//   32 
//   33 ******************************************************************************/
//   34 /******************************************************************************/
//   35 /*********************************
//   36 【dev.env.】IAR EWARM 6.30.1.3142
//   37 【Target  】MK60-DN512-VLQ10
//   38 【Crystal 】50.000  MHz
//   39 【busclock】75.000  MHz
//   40 【pllclock】150.000 MHz
//   41 *********************************/
//   42 
//   43 // 硬件外设有：电机，舵机，编码器，OLED, 摄像头
//   44 
//   45 /************************************************************/
//   46 #define MAIN_PROGRAM           //主程序测试
//   47 //#define PINREAD_DEBUG        //引脚输入测试
//   48 //#define CLOCK_DEBUG          //时钟引脚测试
//   49 //#define CAMERA_DEBUG_7725  //OV7725摄像头测试
//   50 //#define CAMERA_DEBUG_7620    //OV7620摄像头测试
//   51 //#define C_DEBUG            //C语言语法测试
//   52 //#define DAQ_DEBUG          //DAQ测试
//   53 //#define DMA_DEBUG          //DMA测试
//   54 //#define BLUETOOTH_DEBUG    //蓝牙测试
//   55 //#define SD_DEBUG            //SD卡测试
//   56 //#define MOTOR_DEBUG           //电机测试
//   57 //#define SERVO_DEBUG           //舵机测试
//   58 //#define QUAD_DEBUG            //编码器测试
//   59 //#define DIFF_DEBUG             //差速测试
//   60 //#define VIRTURL_DEBUG         //虚拟示波器测试
//   61 //#define DEBUG_DEBUG             //原来的主程序测试
//   62 //#define OLED_DEBUG               //OLED专门测试
//   63 //#define FLASH_DEBUG               //FLASH测试
//   64 //#define GYRO_DEBUG                //陀螺仪测试
//   65 //#define LIGHTHOUSE_DEBUG                //灯塔测试
//   66 
//   67 /************************************************************/
//   68 //#define ERROR_PIC
//   69 
//   70 //=================================主函数================================
//   71 //引脚分配：
//   72 //PORT     FUNCTION
//   73 //  A0     TCLK
//   74 //  A1     TDI
//   75 //  A2     TDO
//   76 //  A3     TMS
//   77 //  A8     编码器FTM1_QD_PHA
//   78 //  A9     编码器FTM1_QD_PHB
//   79 //  A10    编码器FTM2_QD_PHA
//   80 //  A11    编码器FTM2_QD_PHB
//   81 //  A12    舵机FTM1_CH0
//   82 //  A25    SCCB_SDA
//   83 //  A26    SCCB_SCL
//   84 //  B0~B7  摄像头数据
//   85 //  B9     PCLK
//   86 //  B16    UART0_RX
//   87 //  B17    UART0_TX
//   88 //  C8     HREF
//   89 //  C16    OLED_D0
//   90 //  C17    OLED_D1
//   91 //  C18    OLED_RST
//   92 //  C19    OLED_DC
//   93 //  D1     VSYNC
//   94 //  D4     电机FTM0_CH4左正
//   95 //  D5     电机FTM0_CH5左反
//   96 //  D6     电机FTM0_CH6右正
//   97 //  D7     电机FTM0_CH7右反
//   98 //  E0~E5  按钮（核心板上的那种小按钮）
//   99 //  E6~E9  拨码开头
//  100 //  E26    工作指示灯
//  101 
//  102 #ifdef MAIN_PROGRAM
//  103 
//  104 #include "math.h"
//  105 #include "common.h"
//  106 #include "sysinit.h"
//  107 #include "gpio.h"
//  108 #include "light.h"
//  109 #include "uart.h"
//  110 #include "wdog.h"
//  111 #include "Pit.h"
//  112 #include "DMA.h"
//  113 #include "ImageGet.h"
//  114 #include "ImagePro.h"
//  115 #include "CameraSet.h"
//  116 #include "vectors.h"
//  117 #include "MK60N512VMD100.h"
//  118 #include "Ftm.h"
//  119 #include "RunControl.h"
//  120 #include "VirtualScope.h"
//  121 #include "Debug.h"
//  122 #include "Flash.h"
//  123 #include "LQ12864.h"
//  124 #include "adc.h"
//  125 #include "Fuzzy.h"
//  126 #include "BatteryCheck.h"
//  127 
//  128 //延时函数

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  129 void DLY_ms(word ms)
//  130 {                         
DLY_ms:
        B.N      ??DLY_ms_0
//  131   word a;
//  132   while(ms)
//  133   {
//  134     a=13350;
??DLY_ms_1:
        MOVW     R1,#+13350
//  135     while(a--);
??DLY_ms_2:
        MOVS     R2,R1
        SUBS     R1,R2,#+1
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        CMP      R2,#+0
        BNE.N    ??DLY_ms_2
//  136     ms--;
        SUBS     R0,R0,#+1
//  137   }
??DLY_ms_0:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BNE.N    ??DLY_ms_1
//  138   return;
        BX       LR               ;; return
//  139 }
//  140 //主程序

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  141   void main(void)
//  142 {
main:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
//  143     uint8 flag;  //如果有用OLED修改参数的话，参数flag会被置位
//  144     uint32 tic1;
//  145     uint32 tic2,tic3,tic4,tic5,tic6,tic7,tic8,tic9,tic10,tic11; //这里一堆tic是调试时用来计时的
//  146     gpio_init(PORTD, 4, 1, 0);                                  //这四个是电机输出的引脚
        MOVS     R3,#+0
        MOVS     R2,#+1
        MOVS     R1,#+4
        LDR.N    R0,??DataTable0  ;; 0x400ff0c0
        BL       gpio_init
//  147     gpio_init(PORTD, 5, 1, 0);
        MOVS     R3,#+0
        MOVS     R2,#+1
        MOVS     R1,#+5
        LDR.N    R0,??DataTable0  ;; 0x400ff0c0
        BL       gpio_init
//  148     gpio_init(PORTD, 6, 1, 0);
        MOVS     R3,#+0
        MOVS     R2,#+1
        MOVS     R1,#+6
        LDR.N    R0,??DataTable0  ;; 0x400ff0c0
        BL       gpio_init
//  149     gpio_init(PORTD, 7, 1, 0);
        MOVS     R3,#+0
        MOVS     R2,#+1
        MOVS     R1,#+7
        LDR.N    R0,??DataTable0  ;; 0x400ff0c0
        BL       gpio_init
//  150     
//  151     DebugInit();            //OLED,FLASH,button,switch初始化，这里会显示“Hello AE86”，（开始阶段可以先关闭）
        BL       DebugInit
//  152     
//  153     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
        MOVS     R2,#+115200
        LDR.N    R0,??DataTable0_1
        LDR      R1,[R0, #+0]
        LDR.N    R0,??DataTable0_2  ;; 0x4006a000
        BL       uart_init
//  154     //enableuartreint(UART0, 45);
//  155     
//  156     DisableInterrupts;                                    //关闭所有中断
        CPSID i
//  157     
//  158     
//  159     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
        MOVS     R2,#+0
        MOVS     R1,#+26
        LDR.N    R0,??DataTable0_3  ;; 0x400ff100
        BL       light_init
//  160     light_control(PORTE, 26, Light_OFF);
        MOVS     R2,#+1
        MOVS     R1,#+26
        LDR.N    R0,??DataTable0_3  ;; 0x400ff100
        BL       light_control
//  161     light_init(PORTD, 15, Light_ON);                      //单片机工作指示灯
        MOVS     R2,#+0
        MOVS     R1,#+15
        LDR.N    R0,??DataTable0  ;; 0x400ff0c0
        BL       light_init
//  162     light_control(PORTD, 15, Light_OFF);
        MOVS     R2,#+1
        MOVS     R1,#+15
        LDR.N    R0,??DataTable0  ;; 0x400ff0c0
        BL       light_control
//  163     
//  164     pit_init(PIT0, 75000 * 5);                              //75000即为1ms，这里是5ms用于编码器
        LDR.N    R1,??DataTable0_4  ;; 0x5b8d8
        MOVS     R0,#+0
        BL       pit_init
//  165     //enable_pit_interrupt(PIT0);                         //开PIT0中断
//  166     
//  167     VariablesInit();      //各种变量的初始化赋值
        BL       VariablesInit
//  168     ServoInit();          // 初始化舵机
        BL       ServoInit
//  169     
//  170     QuadInit3();           //初始化编码器（开始阶段可以先关闭）
        BL       QuadInit3
//  171     
//  172     //ADC初始化用于电池电压测量（开始阶段可以先关闭）
//  173     hw_adc_init(0);
        MOVS     R0,#+0
        BL       hw_adc_init
//  174     //电池电压测量初始化（开始阶段可以先关闭）
//  175     BatteryCheckInit();
        BL       BatteryCheckInit
//  176     //陀螺仪初始化，包括初始温漂求取。（开始阶段可以先关闭）
//  177     GyroInit();
        BL       GyroInit
        B.N      ??main_0
//  178     
//  179     
//  180     while(!CameraInit())         //初始化摄像头
//  181     {
//  182       uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
??main_1:
        MOVS     R2,#+23
        LDR.N    R1,??DataTable0_5
        LDR.N    R0,??DataTable0_2  ;; 0x4006a000
        BL       uart_sendN
//  183     }
??main_0:
        BL       CameraInit
        CMP      R0,#+0
        BEQ.N    ??main_1
//  184     
//  185     //DMA通道0， DMA触发源为PORTB， DMA源地址为B0~B7, DMA目的地址为ImgStore1数组
//  186     while(!DMAInit(DMACH00, DMASOURCE_PORTB, CameraWidth, GPIOB_DIR_ADDR, (uint32)(ImgStore1[0])))
??main_2:
        LDR.N    R0,??DataTable0_6
        STR      R0,[SP, #+0]
        LDR.N    R3,??DataTable0_7  ;; 0x400ff050
        MOV      R2,#+320
        MOVS     R1,#+50
        MOVS     R0,#+0
        BL       DMAInit
        CMP      R0,#+0
        BNE.N    ??main_3
//  187     {
//  188       uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
        MOVS     R2,#+20
        LDR.N    R1,??DataTable0_8
        LDR.N    R0,??DataTable0_2  ;; 0x4006a000
        BL       uart_sendN
        B.N      ??main_2
//  189     }
//  190     
//  191     
//  192     //这儿的优先级设置的正确性有待验证============================
//  193     //set_irq_priority(FIELD_IRQ, 2);
//  194     //set_irq_priority(LINE_IRQ, 1);
//  195     //set_irq_priority(DMA0_IRQ, 0);
//  196     
//  197     PORTD_ISFR = PORT_ISFR_ISF_MASK;       //清场所在PORT的标志位
??main_3:
        MOVS     R0,#-1
        LDR.N    R1,??DataTable0_9  ;; 0x4004c0a0
        STR      R0,[R1, #+0]
//  198     PORTC_ISFR = PORT_ISFR_ISF_MASK;       //清行所在PORT的标志位
        MOVS     R0,#-1
        LDR.N    R1,??DataTable0_10  ;; 0x4004b0a0
        STR      R0,[R1, #+0]
//  199     PORTB_ISFR = PORT_ISFR_ISF_MASK;       //清PCLK所在PORT的标志位
        MOVS     R0,#-1
        LDR.N    R1,??DataTable0_11  ;; 0x4004a0a0
        STR      R0,[R1, #+0]
//  200     disable_irq(LINE_IRQ);                 //关行中断IRQ
        MOVS     R0,#+89
        BL       disable_irq
//  201     disable_irq(DMA0_IRQ);                 //关DMA传输完成中断IRQ
        MOVS     R0,#+0
        BL       disable_irq
//  202     enable_irq(FIELD_IRQ);                //开场中断IRQ
        MOVS     R0,#+90
        BL       enable_irq
//  203     
//  204     ImgStatus = ImgGetStart;        //图像采集标志位置为开始
        MOVS     R0,#+4
        LDR.N    R1,??DataTable0_12
        STRB     R0,[R1, #+0]
//  205     
//  206     //初始化扫描拨码开关。
//  207     DebugSwitchScan();
        BL       DebugSwitchScan
//  208     
//  209     EnableInterrupts;                                     //打开所有中断 
        CPSIE i
//  210     flag = 0;                           //当用OLED修改参数后，参数flag会置位
        MOVS     R4,#+0
        B.N      ??main_4
//  211 
//  212     //拨码开关打开传图像的模式
//  213     while(DebugSwitchFlag[3] == 1)
//  214     {
//  215       LCD_P8x16Str(12,3,"Send Image");
??main_5:
        LDR.N    R2,??DataTable0_13
        MOVS     R1,#+3
        MOVS     R0,#+12
        BL       LCD_P8x16Str
//  216       while(ImgStatus != ImgGetFinish); //如果图像采集未结束，则一直等待。
??main_6:
        LDR.N    R0,??DataTable0_12
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??main_6
//  217       disable_irq(LINE_IRQ);                 //关行中断IRQ
        MOVS     R0,#+89
        BL       disable_irq
//  218       disable_irq(DMA0_IRQ);                 //关DMA传输完成中断IRQ
        MOVS     R0,#+0
        BL       disable_irq
//  219       disable_irq(FIELD_IRQ);                //关场中断IRQ
        MOVS     R0,#+90
        BL       disable_irq
//  220       ImageSend();
        BL       ImageSend
//  221       
//  222       PORTD_ISFR = PORT_ISFR_ISF_MASK;       //清场所在PORT的标志位
        MOVS     R0,#-1
        LDR.N    R1,??DataTable0_9  ;; 0x4004c0a0
        STR      R0,[R1, #+0]
//  223       PORTC_ISFR = PORT_ISFR_ISF_MASK;       //清行所在PORT的标志位
        MOVS     R0,#-1
        LDR.N    R1,??DataTable0_10  ;; 0x4004b0a0
        STR      R0,[R1, #+0]
//  224       PORTB_ISFR = PORT_ISFR_ISF_MASK;       //清PCLK所在PORT的标志位
        MOVS     R0,#-1
        LDR.N    R1,??DataTable0_11  ;; 0x4004a0a0
        STR      R0,[R1, #+0]
//  225       disable_irq(LINE_IRQ);                 //关行中断IRQ
        MOVS     R0,#+89
        BL       disable_irq
//  226       disable_irq(DMA0_IRQ);                 //关DMA传输完成中断IRQ
        MOVS     R0,#+0
        BL       disable_irq
//  227       enable_irq(FIELD_IRQ);                //开场中断IRQ
        MOVS     R0,#+90
        BL       enable_irq
//  228       ImgStatus = ImgGetStart;              //图像采集标志位置为开始
        MOVS     R0,#+4
        LDR.N    R1,??DataTable0_12
        STRB     R0,[R1, #+0]
//  229     }
??main_4:
        LDR.N    R0,??DataTable0_14
        LDRB     R0,[R0, #+3]
        CMP      R0,#+1
        BEQ.N    ??main_5
//  230     //若拨码开关1拨在1的位置，则一直用OLED调参，否则跳出while循环，正常跑车。
//  231     while(DebugSwitchFlag[1] == 1)
??main_7:
        LDR.N    R0,??DataTable0_14
        LDRB     R0,[R0, #+1]
        CMP      R0,#+1
        BNE.N    ??main_8
//  232     {
//  233       flag = 1;
        MOVS     R4,#+1
//  234       //16.64ms的终点。16.64ms是OV7620采集一张图片的时间
//  235       //tic1 = temptic2;
//  236       //temptic2 = PIT_CVAL(1);
//  237       
//  238       while(ImgStatus != ImgGetFinish); //如果图像采集未结束，则一直等待。
??main_9:
        LDR.N    R0,??DataTable0_12
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??main_9
//  239       
//  240       //16.64ms的起点。            
//  241       ImgStatus = ImgGetStart;        //图像采集标志位置为开始        
        MOVS     R0,#+4
        LDR.N    R1,??DataTable0_12
        STRB     R0,[R1, #+0]
//  242   
//  243       //使用OLED时，不能使用编码器采集，时间不够。
//  244       
//  245       //tic2 = PIT_CVAL(1);
//  246       //若图像处理成功（即偏差获取成功），则进行舵机和电机的控制，否则保持原状。
//  247       //若已经经过直角弯特殊处理，也可以进行舵机和电机的控制。
//  248       if(ImagePro() == 1 || AngleSpeDealFlag == 1)          //图像处理  
        BL       ImagePro
//  249       {
//  250        
//  251       }
//  252       else
//  253       {
//  254         
//  255       }
//  256 
//  257       
//  258       ServoPID();         //舵机控制
        BL       ServoPID
//  259 
//  260       //tic3 = PIT_CVAL(1);
//  261       //Debug调试，有1.拨码开关扫描，2。按键扫描，3。按键信息处理，4。OLED屏刷新。（开始阶段可以先关闭）
//  262       DebugDebug();                 
        BL       DebugDebug
//  263       //toc3 = PIT_CVAL(1);
//  264       
//  265       //电池电压测量
//  266       BatteryCheckUpdate();
        BL       BatteryCheckUpdate
        B.N      ??main_7
//  267       
//  268       //toc1 = PIT_CVAL(1);
//  269     }
//  270     
//  271     
//  272     //若是由A0模式进入到A1模式，则执行下列操作。否则跳过。
//  273     if(flag == 1)
??main_8:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??main_10
//  274     {
//  275       //从A0模式进入A1模式。
//  276       //A1模式标志。
//  277       //关掉OLED。
//  278       LCD_CLS();     
        BL       LCD_CLS
//  279       //将更改后的最新的值写入FLASH。
//  280       FlashFinalWrite();
        BL       FlashFinalWrite
//  281       LCD_P8x16Str(12,3,"Debug Succeed");
        LDR.N    R2,??DataTable0_15
        MOVS     R1,#+3
        MOVS     R0,#+12
        BL       LCD_P8x16Str
        B.N      ??main_11
//  282     }
//  283     else
//  284     {
//  285       LCD_P8x16Str(12,3,"Start");
??main_10:
        LDR.N    R2,??DataTable0_16
        MOVS     R1,#+3
        MOVS     R0,#+12
        BL       LCD_P8x16Str
//  286     }
//  287     
//  288     
//  289  
//  290 
//  291     GyroInit();                 //初始化陀螺仪（开始阶段可以先关闭）
??main_11:
        BL       GyroInit
//  292     
//  293     
//  294     MotorInit_SYJ();          //初始化电机，注意电机1，2口后来是用来控制驱动板的使能的，3，4口才是控制电机速度的PWM
        BL       MotorInit_SYJ
        B.N      ??main_12
//  295 
//  296     while(1)
//  297     {
//  298       //16.64ms的终点。
//  299 //      tic1 = PIT_CVAL(1)/75000;
//  300       while(ImgStatus != ImgGetFinish) ; //如果图像采集未结束，则一直等待。
//  301 //      tic2 = PIT_CVAL(1)/75000;
//  302       
//  303       //16.64ms的起点。            
//  304       ImgStatus = ImgGetStart;        //图像采集标志位置为开始        
//  305       
//  306       FTM2_CNT = 0;                            //计数器清零。准备开启10ms的编码器速度值采集。
//  307       QuadDoneFlag = 0;                        //提前将该标志位置0，以防ImagePro()用时少于5ms的情况。
//  308       
//  309       
//  310       PIT_TCTRL(PIT0) |= PIT_TCTRL_TEN_MASK;       //使能pit模块运行,此时PIT计数器开始倒数。用于编码器（开始阶段可以先关闭）
//  311       enable_pit_interrupt(PIT0);                         //开PIT0中断，用于编码器（开始阶段可以先关闭）
//  312       
//  313 //      tic3 = PIT_CVAL(1)/75000; 
//  314       //若图像处理成功（即偏差获取成功），则进行舵机和电机的控制，否则保持原状。
//  315       //若已经经过直角弯特殊处理，也可以进行舵机和电机的控制。
//  316       if(ImagePro() == 1 || AngleSpeDealFlag == 1)          //图像处理  
//  317       {
//  318         GPIO_PDOR_REG(PORTC) |= (1<<0);
//  319 //        tic4 = PIT_CVAL(1)/75000; 
//  320         while(QuadDoneFlag == 0) ;  //若编码器速度采集未完成，则一直等待。    
//  321         
//  322 //        tic5 = PIT_CVAL(1)/75000; 
//  323       }
//  324       else
//  325       {
//  326 //        tic6 = PIT_CVAL(1)/75000; 
//  327         GPIO_PDOR_REG(PORTC) &= ~(1<<0);
??main_13:
        LDR.N    R0,??DataTable0_17  ;; 0x400ff080
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable0_17  ;; 0x400ff080
        STR      R0,[R1, #+0]
//  328         //就算图像处理失败，也必须等10ms以后，再去做后面的电机控制。
//  329         while(QuadDoneFlag == 0) ;  //若编码器速度采集未完成，则一直等待。
??main_14:
        LDR.N    R0,??DataTable0_18
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??main_14
//  330 //        tic7 = PIT_CVAL(1)/75000; 
//  331       }
//  332       
//  333       //toc4 = PIT_CVAL(1);
//  334       
//  335       
//  336       //实时速度获取（开始阶段可以先关闭）
//  337       SpeedRealTimeGet();
??main_15:
        BL       SpeedRealTimeGet
//  338         
//  339 //       tic8 = PIT_CVAL(1)/75000; 
//  340        ServoPID();         //舵机控制 
        BL       ServoPID
//  341        //tic7 = PIT_CVAL(1);
//  342 //       tic9 = PIT_CVAL(1)/75000; 
//  343        MotorPID();         //电机控制
        BL       MotorPID
//  344 //       tic10 = PIT_CVAL(1)/75000; 
//  345        //toc7 = PIT_CVAL(1);
//  346        
//  347       //陀螺仪处理。AD采集，标志位处理。（开始阶段可以先关闭）
//  348       GryoDeal();
        BL       GryoDeal
//  349       
//  350       //电池电压测量
//  351       //BatteryCheckUpdate();
//  352       
//  353       //tic5 = temptic1;
//  354       //temptic1 = PIT_CVAL(1);
//  355       
//  356       //虚拟示波器（用的是FreeCars）
//  357       Virtual2SendData();
        BL       Virtual2SendData
??main_12:
??main_16:
        LDR.N    R0,??DataTable0_12
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??main_16
        MOVS     R0,#+4
        LDR.N    R1,??DataTable0_12
        STRB     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable0_19  ;; 0x400b8004
        STR      R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable0_18
        STRB     R0,[R1, #+0]
        LDR.N    R0,??DataTable0_20  ;; 0x40037108
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable0_20  ;; 0x40037108
        STR      R0,[R1, #+0]
        MOVS     R0,#+0
        BL       enable_pit_interrupt
        BL       ImagePro
        CMP      R0,#+1
        BEQ.N    ??main_17
        LDR.N    R0,??DataTable0_21
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??main_13
??main_17:
        LDR.N    R0,??DataTable0_17  ;; 0x400ff080
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable0_17  ;; 0x400ff080
        STR      R0,[R1, #+0]
??main_18:
        LDR.N    R0,??DataTable0_18
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??main_15
        B.N      ??main_18
//  358 //      tic11 = PIT_CVAL(1)/75000; 
//  359       //toc5 = PIT_CVAL(1);
//  360       
//  361       //toc1 = PIT_CVAL(1);
//  362       
//  363     }  // end of while(1)
//  364 
//  365 
//  366 
//  367 }      // end of main()

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC32     0x400ff0c0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_1:
        DC32     periph_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_2:
        DC32     0x4006a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_3:
        DC32     0x400ff100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_4:
        DC32     0x5b8d8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_5:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_6:
        DC32     ImgStore1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_7:
        DC32     0x400ff050

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_8:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_9:
        DC32     0x4004c0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_10:
        DC32     0x4004b0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_11:
        DC32     0x4004a0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_12:
        DC32     ImgStatus

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_13:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_14:
        DC32     DebugSwitchFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_15:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_16:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_17:
        DC32     0x400ff080

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_18:
        DC32     QuadDoneFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_19:
        DC32     0x400b8004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_20:
        DC32     0x40037108

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_21:
        DC32     AngleSpeDealFlag

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
        DC8 "\012Camera Initial Failed!"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "\012DMA Initial Failed!"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "Send Image"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC8 "Debug Succeed"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_4:
        DATA
        DC8 "Start"
        DC8 0, 0

        END
//  368 #endif // end of MAIN_PROGRAM
//  369 
//  370 
//  371 
//  372 //==========================外设时钟测试===========================
//  373 /*
//  374 外设时钟测试成功，2014.10.09
//  375 用myDAQ测PORTA10的引脚频率就行，PIT设成1ms一次中断，测得频率为500Hz
//  376 */
//  377 #ifdef CLOCK_DEBUG
//  378 
//  379 #include "common.h"
//  380 #include "sysinit.h"
//  381 #include "gpio.h"
//  382 #include "light.h"
//  383 #include "uart.h"
//  384 #include "wdog.h"
//  385 #include "Pit.h"
//  386 
//  387 void main(void)
//  388 {
//  389     DisableInterrupts;                                    //关闭所有中断
//  390     
//  391     gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
//  392     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
//  393     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
//  394     pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
//  395     enable_pit_interrupt(PIT0);                         //开PIT1中断
//  396     
//  397     EnableInterrupts;                                     //打开所有中断
//  398 
//  399     
//  400     
//  401     
//  402     while(1)
//  403     { 
//  404       
//  405       
//  406     }  // end of while(1) 
//  407 }      // end of main()
//  408 #endif // end of CLOCK_DEBUG
//  409 
//  410 
//  411 
//  412 
//  413 
//  414 
//  415 
//  416 
//  417 
//  418 
//  419 //=======================================蓝牙串口测试===========================
//  420 
//  421 //蓝牙串口测试成功。2014.10.10
//  422 //注意TX,RX对应的端口即可，龙丘板上的丝印容易看错位。
//  423 
//  424 
//  425 #ifdef  BLUETOOTH_DEBUG
//  426 
//  427 #include "common.h"
//  428 #include "sysinit.h"
//  429 #include "gpio.h"
//  430 #include "light.h"
//  431 #include "uart.h"
//  432 #include "wdog.h"
//  433 #include "Pit.h"
//  434 #include "DMA.h"
//  435 
//  436 volatile uint8 BUFF[11] = {0};
//  437 
//  438 
//  439 void main(void)
//  440 {/*
//  441     uint8 ch;
//  442     
//  443     uint8 first[] = {"\nDMA触发后 BUFF[10]={"};
//  444     uint8 last[] = {"10}"};
//  445     uint8 DMA_error[] = {"DMA初始化失败"};
//  446     uint8 helloworld[] = {"Hello World!"};
//  447    */ 
//  448     //float a1 = 60000;
//  449     //float a2 = 60000.3;
//  450     //float a3 = 
//  451     uint32 runcount;
//  452     DisableInterrupts;                                    //关闭所有中断
//  453     
//  454     gpio_init(PORTA,6,1,0);                              //时间测试引脚初始化
//  455     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
//  456     uart_init(UART4, periph_clk_khz, 115200);             //串口初始化
//  457     //pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
//  458     //enable_pit_interrupt(PIT0);                         //开PIT1中断
//  459     uart_sendN(UART4,(uint8*)"\nHello World!",13);
//  460     EnableInterrupts;
//  461 
//  462 
//  463     while(1)
//  464     {
//  465       //if(uart_re1(UART0, &ch))//此处应把uart_re1函数中的计数错误检测去掉
//  466       //{
//  467         runcount++;
//  468         if(runcount>=1000000)
//  469         {
//  470             light_change(PORTE, 26);//指示灯的亮、暗状态切换
//  471             uart_sendN(UART4,(uint8*)"\nHello World!",13);
//  472             uart_sendN(UART4,(uint8*)"\n001",13);
//  473             uart_sendN(UART4,(uint8*)"\n002",13);
//  474             uart_sendN(UART4,(uint8*)"\n003",13);
//  475             runcount=0;
//  476         }
//  477        //}// end of if接收成功
//  478     }  // end of while(1) 
//  479 }      // end of main()
//  480 #endif // end of BLUETOOTH_DEBUG
//  481 
//  482 
//  483 
//  484 
//  485 
//  486 
//  487 
//  488 
//  489 
//  490 
//  491 
//  492 
//  493 
//  494 
//  495 
//  496 
//  497 
//  498 
//  499 
//  500 
//  501 
//  502 
//  503 
//  504 //============================DMA测试=============================
//  505 /*
//  506 DMA测试成功。2014.10.10
//  507 引脚连接：PTA8用于产生边沿来触发PTA7上的DMA触发，将3V3连接到B0至B7任意引脚，
//  508           连接好串口蓝牙后，用串口调试助手发单个字符到MCU上，就可以发现BUFF数组里的数在一个个地变化。
//  509 关键配置：关闭DREQ时，DMA0的中断服务函数中不需要再打开ERQ。
//  510           打开DREQ时，DMA0的中断服务函数中需要手动打开ERQ.
//  511           DLAST配成-10，用于数组循环查看。
//  512           BITER和CITER以及BUFF长度都配成10。
//  513           PTA7做为DMA触发源，GPIO输入，下拉电阻(默认输入为0)，下降沿触发DMA。
//  514           PTB0~PTB7均设置为摄像头数据输入，下拉电阻。
//  515           PTA8配成GPIO输出。
//  516 */
//  517 #ifdef DMA_DEBUG
//  518 
//  519 #include "common.h"
//  520 #include "sysinit.h"
//  521 #include "gpio.h"
//  522 #include "light.h"
//  523 #include "uart.h"
//  524 #include "wdog.h"
//  525 #include "Pit.h"
//  526 #include "DMA.h"
//  527 
//  528 uint8 BUFF[11] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b};
//  529 
//  530 
//  531 
//  532 
//  533 void main(void)
//  534 {
//  535     uint8 ch, chh;
//  536     uint32 i;
//  537     uint8 first[] = {"\nDMA触发后 BUFF[10]={"};
//  538     uint8 last[] = {"10}"};
//  539     uint8 DMA_error[] = {"DMA初始化失败"};
//  540     
//  541     DisableInterrupts;                                    //关闭所有中断
//  542     
//  543     gpio_init(PORTA,6,1,0);                              //时间测试引脚初始化
//  544     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
//  545     uart_init(UART0, periph_clk_khz, 9600);             //串口初始化
//  546     //pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
//  547     //enable_pit_interrupt(PIT0);                         //开PIT1中断
//  548     
//  549     
//  550     
//  551     //DMA触发引脚 和 数据输入引脚 设置
//  552     DMAPORTInit();
//  553     
//  554     if(!DMAInit(DMACH00, DMASOURCE_PORTA, GPIOB_DIR_ADDR, (uint32)BUFF))
//  555     {
//  556       while(1)
//  557       {
//  558       uart_sendN(UART0, DMA_error, sizeof(DMA_error));     
//  559       }
//  560     }
//  561     
//  562     enable_DMA_irq(DMACH00);              //开启DMA通道0的IRQ中断
//  563     
//  564     EnableInterrupts;                                     //打开所有中断
//  565     
//  566     DMA_ERQ |= (1 << 0);                            //打开DMA硬件触发使能
//  567 
//  568 
//  569     while(1)
//  570     {
//  571       if(uart_re1(UART0, &ch))            //此处应把uart_re1函数中的计数错误检测去掉
//  572       {
//  573       gpio_reverse(PORTA, 8);
//  574       for(i=0;i<150000;i++)
//  575       {
//  576         asm("nop");  
//  577       }
//  578       gpio_reverse(PORTA, 8);
//  579       
//  580       uart_sendN(UART0, (uint8 *)"Hello World!", 12);
//  581       for(i = 0; i <= 10; i++)
//  582       {
//  583         chh = BUFF[i];
//  584         uart_send1(UART0, chh);
//  585       }
//  586   
//  587       
//  588 
//  589       
//  590       
//  591       
//  592       }// end of if接收成功
//  593     }  // end of while(1) 
//  594 }      // end of main()
//  595 #endif // end of DMA_DEBUG
//  596 
//  597 
//  598 
//  599 
//  600 
//  601 //=======================引脚输入读取测试==============================
//  602 //GPIO引脚输入测试成功。2014.10.12
//  603 //1. 该测试以PA15为输入引脚，PA17和PC0为输出引脚（连接到龙丘板上的两个灯）。
//  604 //   当PA15检测到低电平时，PA17灭，PC0亮。PA15检测到高电平，相反。
//  605 //2. 实际测试时发现，如果不使能上下拉电阻（漏极开路无影响），则GPIO输入模式时，默认检测到的是低电平。
//  606 //   且给输入引脚外部置高或置低时，该引脚状态会一直保持到下一次外部改变。
//  607 //3. 实际测试时发现，如果使能了上拉电阻（漏极开路无影响），则GPIO输入模式时，默认检测到的是低电平。
//  608 //   且如果输入引脚外部置高后把杜邦线拿掉，该引脚状态会自动变为低电平，经单一变量检测，的确是上拉电阻的作用。
//  609 //   也就是说，无外部输入时，GPIO输入的上拉电阻会把该引脚状态置低。
//  610 //3. PORTPCR寄存器需在GPIO寄存器前设置成MUX(1)，即设置成GPIO模式（此时默认为GPIO输入）。
//  611 //4. GPIO的方向、输出值、输入值就按下面的例子来写，简单易懂。
//  612 //                                                         --HJZ
//  613 #ifdef PINREAD_DEBUG
//  614 
//  615 #include "math.h"
//  616 #include "common.h"
//  617 #include "sysinit.h"
//  618 #include "gpio.h"
//  619 #include "light.h"
//  620 #include "uart.h"
//  621 #include "wdog.h"
//  622 #include "Pit.h"
//  623 #include "DMA.h"
//  624 #include "ImageGet.h"
//  625 #include "ImagePro.h"
//  626 #include "CameraSet.h"
//  627 #include "vectors.h"
//  628 #include "MK60N512VMD100.h"
//  629 
//  630 
//  631 
//  632 void main(void)
//  633 {	
//  634 	//开启各个GPIO口的转换时钟
//  635 	SIM_SCGC5 = SIM_SCGC5_PORTA_MASK | SIM_SCGC5_PORTB_MASK | SIM_SCGC5_PORTC_MASK | SIM_SCGC5_PORTD_MASK | SIM_SCGC5_PORTE_MASK;
//  636 	
//  637         //输入引脚PA15的初始化，GPIO输入，漏极开路，上拉电阻
//  638         PORT_PCR_REG(PORTA_BASE_PTR, 15) |= ( 0
//  639                                   |  PORT_PCR_MUX(0x01) 
//  640                                   | PORT_PCR_PE_MASK 
//  641                                   | PORT_PCR_ODE_MASK
//  642                                   );
//  643         GPIO_PDDR_REG(PTA_BASE_PTR) |= (1 << 15);
//  644         GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
//  645         GPIO_PDDR_REG(PTA_BASE_PTR) &= ~(1 << 15);
//  646 
//  647         //输入引脚PA17和PC0的初始化，GPIO输出
//  648 	PORTA_PCR17 |= (0 | PORT_PCR_MUX(1));         
//  649         PORTC_PCR0 |= (0 | PORT_PCR_MUX(1));
//  650         
//  651         GPIO_PDDR_REG(PTC_BASE_PTR) |= (1 << 0);
//  652         GPIO_PDOR_REG(PTC_BASE_PTR) &= ~(1 << 0);
//  653 	
//  654 	GPIO_PDDR_REG(PTA_BASE_PTR) |= (1 << 17);
//  655 	GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 17);   
//  656         
//  657 	for(;;)  
//  658 	{	//检测到高电平，PA17亮，PC0灭   	
//  659 		if( GPIO_PDIR_REG(PTA_BASE_PTR) & (1 << 15) )
//  660 		{
//  661 		    GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 17);
//  662                     GPIO_PDOR_REG(PTC_BASE_PTR) |= (1 << 0);	
//  663 		}
//  664                 //检测到低电平，PA17灭，PC0亮   
//  665 		else
//  666                 {		
//  667                     GPIO_PDOR_REG(PTC_BASE_PTR) &= ~(1 << 0);
//  668                     GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 17);		
//  669 		}	 
//  670 	}
//  671 	
//  672 }
//  673 
//  674 #endif // end of PINREAD_DEBUG
//  675 
//  676 
//  677 
//  678 
//  679 
//  680 
//  681 
//  682 
//  683 //=========================DAQ的边沿捕捉测试============================
//  684 #ifdef DAQ_DEBUG
//  685 
//  686 #include "MK60N512VMD100.h"
//  687 #include "gpio.h"
//  688 
//  689 void Delay(volatile uint16 time)
//  690 {
//  691     while(time)
//  692     {
//  693         time--;  
//  694     }
//  695 }
//  696 
//  697 
//  698 void main(void)
//  699 {
//  700   
//  701   SIM_SCGC5 |= (SIM_SCGC5_PORTA_MASK | SIM_SCGC5_PORTB_MASK | SIM_SCGC5_PORTC_MASK | SIM_SCGC5_PORTD_MASK | SIM_SCGC5_PORTE_MASK);
//  702   
//  703   gpio_init(PORTA, 14, 1, 1);
//  704   gpio_init(PORTA, 15, 1, 1);
//  705   //PORTA_PCR15 |= (0 | PORT_PCR_MUX(1));
//  706   
//  707   
//  708   //PORTA_PCR14 |= PORT_PCR_DSE_MASK;
//  709  //PORTA_PCR15 |= PORT_PCR_DSE_MASK;
//  710   
//  711   
//  712 
//  713   GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 14); 
//  714   Delay(1000);
//  715   
//  716   GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 15); 
//  717   Delay(1000);
//  718   
//  719   GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 14);   
//  720   Delay(1000);
//  721   
//  722   GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
//  723   Delay(1000);
//  724   
//  725     GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 14); 
//  726   Delay(1000);
//  727   
//  728   GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 15); 
//  729   Delay(1000);
//  730   
//  731   GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 14);   
//  732   Delay(1000);
//  733   
//  734   GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
//  735   Delay(1000);
//  736 
//  737   
//  738     GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 14); 
//  739   Delay(1000);
//  740   
//  741   GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 15); 
//  742   Delay(1000);
//  743   
//  744   GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 14);   
//  745   Delay(1000);
//  746   
//  747   GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
//  748   Delay(1000);
//  749 
//  750 
//  751   
//  752   while(1) ; 
//  753 
//  754 }
//  755 
//  756 #endif // end of DAQ_DEBUG
//  757 
//  758 
//  759 
//  760 //=======================蓝牙波特率设置==================================
//  761 #ifdef BT_SET
//  762 
//  763 #include "sysinit.h"
//  764 #include "common.h"
//  765 #include "gpio.h"
//  766 #include "uart.h"
//  767 #include "light.h"
//  768 
//  769 void main(void)
//  770 {
//  771     //uint8 cmd[] = {"AT+BAUD8\r"};
//  772     uint8 cmd[] = {"\nHello World!"};
//  773     uint32 runcount = 0;
//  774     DisableInterrupts;                                    //关闭所有中断
//  775     
//  776     gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
//  777     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
//  778     uart_init(UART0, periph_clk_khz, 9600);             //串口初始化
//  779 
//  780     EnableInterrupts;
//  781     while(1)
//  782     {
//  783 
//  784         runcount++;
//  785         if(runcount>=1000000)
//  786         {
//  787             light_change(PORTE, 26);//指示灯的亮、暗状态切换
//  788             uart_sendN(UART0, cmd, sizeof(cmd));
//  789             runcount=0;
//  790         }
//  791       
//  792     }
//  793 
//  794 
//  795 
//  796 } // end of main
//  797 
//  798 #endif // end of BT_SET
//  799 
//  800 
//  801 
//  802 
//  803 
//  804 
//  805 
//  806 //========================OV7725摄像头测试================================
//  807 #ifdef CAMERA_DEBUG_7725
//  808 
//  809 #include "math.h"
//  810 #include "common.h"
//  811 #include "sysinit.h"
//  812 #include "gpio.h"
//  813 #include "light.h"
//  814 #include "uart.h"
//  815 #include "wdog.h"
//  816 #include "Pit.h"
//  817 #include "DMA.h"
//  818 #include "ImageGet.h"
//  819 #include "ImagePro.h"
//  820 #include "CameraSet.h"
//  821 #include "vectors.h"
//  822 #include "MK60N512VMD100.h"
//  823 
//  824 void main(void)
//  825 {
//  826     DisableInterrupts;                                    //关闭所有中断
//  827     
//  828     gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
//  829     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
//  830     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
//  831     pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
//  832     //enable_pit_interrupt(PIT0);                         //开PIT1中断
//  833 
//  834     while(!CameraInit())         //初始化摄像头
//  835     {
//  836       uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
//  837     }
//  838     
//  839     while(!DMAInit(DMACH00, DMASOURCE_PORTA, CameraDMACount, GPIOB_DIR_ADDR, (uint32)ImgStore))
//  840     {
//  841       uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
//  842     }
//  843     
//  844     //禁止硬件请求ERQ
//  845     DMA_ERQ &= ~(1 << 0);
//  846     //关PTA中断
//  847     disable_irq(PORTA_IRQ);
//  848     //清DMAINT标志位
//  849     DMA_INT |= (1 << 0);
//  850     //开DMA的IRQ
//  851     enable_irq(DMA0_IRQ);
//  852 
//  853     EnableInterrupts;                                     //打开所有中断
//  854     while(1)
//  855     {
//  856       ImageGet();        //图像获取
//  857       ImagePro();        //图像处理
//  858       //SendImg();  
//  859       
//  860     }  // end of while(1)
//  861 }      // end of main()
//  862 
//  863 
//  864 
//  865 #endif  //end of CAMERA_DEBUG_7725
//  866 
//  867 
//  868 
//  869 
//  870 
//  871 
//  872 
//  873 
//  874 
//  875 //==========================OV7620摄像头测试==================================
//  876 //引脚分配：
//  877 //PORT     FUNCTION
//  878 //  A0     TCLK
//  879 //  A1     TDI
//  880 //  A2     TDO
//  881 //  A3     TMS
//  882 //  A8     编码器FTM1_QD_PHA
//  883 //  A9     编码器FTM1_QD_PHB
//  884 //  A10    编码器FTM2_QD_PHA
//  885 //  A11    编码器FTM2_QD_PHB
//  886 //  A12    舵机FTM1_CH0
//  887 //  A25    SCCB_SDA
//  888 //  A26    SCCB_SCL
//  889 //  B0~B7  摄像头数据
//  890 //  B9     PCLK
//  891 //  B16    UART0_RX
//  892 //  B17    UART0_TX
//  893 //  C8     HREF
//  894 //  C16    OLED_D0
//  895 //  C17    OLED_D1
//  896 //  C18    OLED_RST
//  897 //  C19    OLED_DC
//  898 //  D1     VSYNC
//  899 //  D4     电机FTM0_CH4左正
//  900 //  D5     电机FTM0_CH5左反
//  901 //  D6     电机FTM0_CH6右正
//  902 //  D7     电机FTM0_CH7右反
//  903 //  E0~E5  按钮（核心板上的那种小按钮）
//  904 //  E6~E9  拨码开头
//  905 //  E26    工作指示灯
//  906 
//  907 #ifdef CAMERA_DEBUG_7620
//  908 
//  909 #include "math.h"
//  910 #include "common.h"
//  911 #include "sysinit.h"
//  912 #include "gpio.h"
//  913 #include "light.h"
//  914 #include "uart.h"
//  915 #include "wdog.h"
//  916 #include "Pit.h"
//  917 #include "DMA.h"
//  918 #include "ImageGet.h"
//  919 #include "ImagePro.h"
//  920 #include "CameraSet.h"
//  921 #include "vectors.h"
//  922 #include "MK60N512VMD100.h"
//  923 
//  924 void main(void)
//  925 {
//  926     DisableInterrupts;                                    //关闭所有中断
//  927     
//  928     gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
//  929     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
//  930     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
//  931     pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
//  932     //enable_pit_interrupt(PIT0);                         //开PIT1中断
//  933 
//  934     while(!CameraInit())         //初始化摄像头
//  935     {
//  936       uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
//  937     }
//  938     
//  939     //DMA通道0， DMA触发源为PORTB， DMA源地址为B0~B7, DMA目的地址为ImgStore1数组
//  940     while(!DMAInit(DMACH00, DMASOURCE_PORTB, CameraWidth, GPIOB_DIR_ADDR, (uint32)(ImgStore1[0])))
//  941     {
//  942       uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
//  943     }
//  944     
//  945     //这儿的优先级设置的正确性有待验证============================
//  946     //set_irq_priority(FIELD_IRQ, 2);
//  947     //set_irq_priority(LINE_IRQ, 1);
//  948     //set_irq_priority(DMA0_IRQ, 0);
//  949     
//  950     PORTD_ISFR = PORT_ISFR_ISF_MASK;       //清场所在PORT的标志位
//  951     PORTC_ISFR = PORT_ISFR_ISF_MASK;       //清行所在PORT的标志位
//  952     PORTB_ISFR = PORT_ISFR_ISF_MASK;       //清PCLK所在PORT的标志位
//  953     disable_irq(LINE_IRQ);                 //关行中断IRQ
//  954     disable_irq(DMA0_IRQ);                 //关DMA传输完成中断IRQ
//  955     enable_irq(FIELD_IRQ);                //开场中断IRQ
//  956     
//  957     EnableInterrupts;                                     //打开所有中断
//  958     ImgStatus = ImgGetStart;        //图像采集标志位置为开始
//  959 
//  960 
//  961     while(1)
//  962     {
//  963       while(ImgStatus != ImgGetFinish) ; //如果图像采集未结束，则一直等待。
//  964       ImgStatus = ImgGetStart;        //图像采集标志位置为开始
//  965       
//  966       
//  967       ImageProSend();        //图像处理
//  968       //SendImg();  
//  969       
//  970     }  // end of while(1)
//  971 }      // end of main()
//  972 
//  973 
//  974 
//  975 #endif // end of CAMERA_DEBUG_7620
//  976 
//  977 
//  978 
//  979 //==========================C语言语法测试==================================
//  980 #ifdef C_DEBUG
//  981 
//  982 #include "common.h"
//  983 #include "sysinit.h"
//  984 #include "vectors.h"
//  985 #include "MK60N512VMD100.h"
//  986 #include "math.h"
//  987 
//  988 void main(void)
//  989 {
//  990     uint8 i, j, k;
//  991     uint8 x, y;
//  992     uint8 temp1, temp2, temp3, temp4, temp5, temp6, temp7;
//  993     int8 x1;
//  994     int8 x2;
//  995     int16 x3;
//  996    
//  997     
//  998     i = 200;
//  999     j = 100;
// 1000     k = 250;
// 1001     if((i + j) > k)
// 1002     {
// 1003       temp1 = 1;  
// 1004     }
// 1005     else
// 1006     {
// 1007       temp1 = 0;  
// 1008     }
// 1009     
// 1010     if((j - i) < 0)
// 1011     {
// 1012       temp2 = 1; 
// 1013     }
// 1014     else
// 1015     {
// 1016       temp2 = 0;  
// 1017     }
// 1018     
// 1019     x = i + j;
// 1020     if(x > k)
// 1021     {
// 1022       temp3 = 1;
// 1023     }
// 1024     else
// 1025     {
// 1026       temp3 = 0;
// 1027     }
// 1028     
// 1029     y = j - i;
// 1030     if(y < 0)
// 1031     {
// 1032       temp4 = 1;
// 1033     }
// 1034     else
// 1035     {
// 1036       temp4 = 0;  
// 1037     }
// 1038     
// 1039     
// 1040     
// 1041     x1 = (int8)(j - i);
// 1042     if(x1 < 0)
// 1043     {
// 1044       temp5 = 1;
// 1045     }
// 1046     else
// 1047     {
// 1048       temp5 = 0;  
// 1049     } 
// 1050     
// 1051     x2 = -1;
// 1052     if(x2 < 0)
// 1053       temp6 = 1;
// 1054     else
// 1055       temp6 = 0;
// 1056     
// 1057     x3 = -1;
// 1058     if(x3 < 0)
// 1059       temp7 = 1;
// 1060     else
// 1061       temp7 = 0;    
// 1062    
// 1063     
// 1064     while(1)
// 1065     {
// 1066     }
// 1067 }
// 1068 
// 1069 #endif // end of C_DEBUG
// 1070 //==========================================================================
// 1071 
// 1072 
// 1073 
// 1074 
// 1075 
// 1076 
// 1077 //==============================SD卡测试====================================
// 1078 #ifdef SD_DEBUG
// 1079 
// 1080 #include "math.h"
// 1081 #include "common.h"
// 1082 #include "sysinit.h"
// 1083 #include "gpio.h"
// 1084 #include "light.h"
// 1085 #include "uart.h"
// 1086 #include "wdog.h"
// 1087 #include "Pit.h"
// 1088 #include "DMA.h"
// 1089 #include "ImageGet.h"
// 1090 #include "ImagePro.h"
// 1091 #include "CameraSet.h"
// 1092 #include "vectors.h"
// 1093 #include "MK60N512VMD100.h"
// 1094 
// 1095 #include "diskio.h"
// 1096 #include "ff.h"
// 1097 #include "ffconf.h"
// 1098 #include "integer.h"
// 1099 #include "myprintp.h"
// 1100 #include "sd_driver.h"
// 1101 #include "spi.h"
// 1102 #include "SD.h"
// 1103 #include "sdhc.h"
// 1104 
// 1105 #include "ctype.h"
// 1106 #include "stdarg.h"
// 1107 #include "ycheck.h"
// 1108 #include "yvals.h"
// 1109 
// 1110 
// 1111 #define BUFF_SIZE   100
// 1112 void main()
// 1113 {   
// 1114  FIL fdst;  //文件
// 1115     FATFS fs;  //文件系统
// 1116 
// 1117     uint32 size, sizetmp;
// 1118     int res;
// 1119     char *str = "感谢您选用 野火Kinetis开发板 ！^_^ ";
// 1120     uint8 buff[BUFF_SIZE];
// 1121 
// 1122     for(size = 0; size < BUFF_SIZE; size++)buff[size] = 0;
// 1123 
// 1124     f_mount(0, &fs);		                                                       //SD卡系统初始化
// 1125 
// 1126     res = f_open(&fdst, "0:/FireDemo.txt", FA_OPEN_ALWAYS | FA_WRITE | FA_READ);  //打开文件，如果没有就创建，带读写打开
// 1127 
// 1128     if( res == FR_DISK_ERR)
// 1129     {
// 1130         printf( "\n没插入SD卡？？\n" );
// 1131         return;
// 1132     }
// 1133     else if ( res == FR_OK )
// 1134     {
// 1135         printf( "\n文件打开成功 \n" );
// 1136     }
// 1137     else
// 1138     {
// 1139         printf("\n返回值异常");
// 1140     }
// 1141 
// 1142 
// 1143     f_puts(str, &fdst);                     //往文件里写入字符串
// 1144 
// 1145     size = f_size(&fdst);                   //获取文件的大小
// 1146 
// 1147     printf( "\n文件大小为：%d \n" , size);  //串口打印文件的大小
// 1148 
// 1149     if(size > BUFF_SIZE)size = BUFF_SIZE;   //防止溢出
// 1150 
// 1151     f_lseek(&fdst, 0);                      //把指针指向文件顶部
// 1152     f_read (&fdst, buff, size, (UINT *)&sizetmp);   //读取
// 1153 
// 1154 
// 1155     printf("文件内容为：%s", (char const *)buff);
// 1156 
// 1157     f_close(&fdst);                         //关闭文件
// 1158      
// 1159   
// 1160     
// 1161 }
// 1162 
// 1163 
// 1164 /*
// 1165 struct WSNSTATE  //??,???????
// 1166 {
// 1167 unsigned diskok:1; //???????????????BIT0    0:??????????   1:???????
// 1168 unsigned fileok:1; //?????????BIT1                0:??????????? 1:??????
// 1169 unsigned record:1; //
// 1170 unsigned position:1; //
// 1171 };
// 1172 
// 1173 volatile struct WSNSTATE state; //????
// 1174 FATFS fs;            // Work area (file system object) for logical drive
// 1175 FRESULT res;         // FatFs function common result code
// 1176 UINT br,bw;         // File Write count
// 1177 
// 1178 FIL testdata;  //???????
// 1179 FILINFO* sfil;
// 1180 
// 1181 unsigned char filebuff[720]={0}; //????
// 1182 volatile unsigned int filebuffoffset=0;
// 1183 unsigned char read_buff[512];
// 1184 unsigned char receivebuff[512];
// 1185 unsigned char test_buff[64];
// 1186 
// 1187 void init_disk_fatfs(void)   //??????????,???state.diskok==1;
// 1188 {
// 1189 	if(state.diskok==0)  //???????? 
// 1190 	{
// 1191 		if(disk_initialize(0))
// 1192 		{
// 1193 			state.diskok=0;
// 1194 		}
// 1195 		else
// 1196 		{	
// 1197 			res = f_mount(0,&fs);      // ?????????for logical drive 0
// 1198 //			SCI0_putchar(res);
// 1199 			state.diskok=1;
// 1200 		}
// 1201 	}
// 1202 }
// 1203 
// 1204 void uart0_send1 (int8 ch)
// 1205 {
// 1206     //等待发送缓冲区空
// 1207     while(!(UART_S1_REG(UART0) & UART_S1_TDRE_MASK));
// 1208     //发送数据
// 1209     UART_D_REG(UART0) = (int8)ch;
// 1210 }
// 1211 
// 1212 
// 1213 void main(void)
// 1214 {
// 1215     unsigned char r;
// 1216     unsigned int i,n;
// 1217     unsigned char kkk;
// 1218     signed char namebuf[7];
// 1219     unsigned char tmp0,tmp1;
// 1220     FRESULT rc; 
// 1221     
// 1222     PRINT_T Print;
// 1223     
// 1224     uart_init(UART0, periph_clk_khz, 115200);
// 1225     Print.m_printf = uart0_send1;	
// 1226     Print_Init(&Print);
// 1227     
// 1228     SPI_Configuration();
// 1229     printp("\nUartInit is ok!\n");
// 1230    
// 1231     
// 1232     init_disk_fatfs();
// 1233     if(state.diskok)printp("\ninit_disk is ok!\n");
// 1234  
// 1235     //EnableInterrupts;
// 1236     for(i=0;i<=256;i++)
// 1237     {
// 1238         filebuffoffset++;
// 1239         filebuff[i]='s';
// 1240     }
// 1241     
// 1242         rc =f_open(&testdata,"0:/data1.txt",FA_CREATE_ALWAYS|FA_WRITE);
// 1243      if(FR_OK == rc)printp("\nf_open is ok\n");
// 1244     
// 1245     rc = f_write(&testdata,filebuff,filebuffoffset,&bw);
// 1246     if(FR_OK == rc)printp("\nf_write is ok!\n");
// 1247     rc = f_close(&testdata);  
// 1248     if(FR_OK == rc)
// 1249     printp("\ncreat single file is ok\n");
// 1250     printp("%dbytes",f_size(&testdata));
// 1251   
// 1252   while(1)
// 1253   {
// 1254     
// 1255     
// 1256   }    // end of while(1)  
// 1257 }      // end of main()
// 1258 */
// 1259 
// 1260 
// 1261 
// 1262 #endif // end of SD_DEBUG
// 1263 //==========================================================================
// 1264 
// 1265 
// 1266 
// 1267 
// 1268 
// 1269 //==========================电机测试==================================
// 1270 //引脚分配：
// 1271 //PORT     FUNCTION
// 1272 //  A0     TCLK
// 1273 //  A1     TDI
// 1274 //  A2     TDO
// 1275 //  A3     TMS
// 1276 //  A8     编码器FTM1_QD_PHA
// 1277 //  A9     编码器FTM1_QD_PHB
// 1278 //  A10    编码器FTM2_QD_PHA
// 1279 //  A11    编码器FTM2_QD_PHB
// 1280 //  A12    舵机FTM1_CH0
// 1281 //  A25    SCCB_SDA
// 1282 //  A26    SCCB_SCL
// 1283 //  B0~B7  摄像头数据
// 1284 //  B9     PCLK
// 1285 //  B16    UART0_RX
// 1286 //  B17    UART0_TX
// 1287 //  C8     HREF
// 1288 //  C16    OLED_D0
// 1289 //  C17    OLED_D1
// 1290 //  C18    OLED_RST
// 1291 //  C19    OLED_DC
// 1292 //  D1     VSYNC
// 1293 //  D4     电机FTM0_CH4左正
// 1294 //  D5     电机FTM0_CH5左反
// 1295 //  D6     电机FTM0_CH6右正
// 1296 //  D7     电机FTM0_CH7右反
// 1297 //  E0~E5  按钮（核心板上的那种小按钮）
// 1298 //  E6~E9  拨码开头
// 1299 //  E26    工作指示灯
// 1300 
// 1301 #ifdef MOTOR_DEBUG
// 1302 
// 1303 #include "math.h"
// 1304 #include "common.h"
// 1305 #include "sysinit.h"
// 1306 #include "gpio.h"
// 1307 #include "light.h"
// 1308 #include "uart.h"
// 1309 #include "wdog.h"
// 1310 #include "Pit.h"
// 1311 #include "DMA.h"
// 1312 #include "ImageGet.h"
// 1313 #include "ImagePro.h"
// 1314 #include "CameraSet.h"
// 1315 #include "vectors.h"
// 1316 #include "MK60N512VMD100.h"
// 1317 #include "Ftm.h"
// 1318 #include "VirtualScope.h"
// 1319 
// 1320 void main(void)
// 1321 {
// 1322     DisableInterrupts;                                    //关闭所有中断
// 1323     
// 1324     gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
// 1325     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
// 1326     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
// 1327     pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
// 1328     //enable_pit_interrupt(PIT0);                         //开PIT1中断
// 1329     
// 1330     EnableInterrupts;
// 1331     
// 1332     MotorInit_SYJ();
// 1333      FTM0_C4V = 0;         //设置 the pulse width(duty cycle) is determined by (CnV - CNTIN).
// 1334      FTM0_C5V = 100;
// 1335       FTM0_C6V = 100;    
// 1336       FTM0_C7V = 0;
// 1337     while(1)
// 1338     {
// 1339       Virtual2SendData();
// 1340       //uart_sendN(UART0, (uint8 *)"\nHello Motor!", 13);
// 1341     }  // end of while(1) 
// 1342         
// 1343 }      // end of main()
// 1344 #endif // end of MOTOR_DEBUG
// 1345 
// 1346 
// 1347 
// 1348 
// 1349 //==========================舵机测试==================================
// 1350 //引脚分配：
// 1351 //PORT     FUNCTION
// 1352 //  A0     TCLK
// 1353 //  A1     TDI
// 1354 //  A2     TDO
// 1355 //  A3     TMS
// 1356 //  A8     编码器FTM1_QD_PHA
// 1357 //  A9     编码器FTM1_QD_PHB
// 1358 //  A10    编码器FTM2_QD_PHA
// 1359 //  A11    编码器FTM2_QD_PHB
// 1360 //  A12    舵机FTM1_CH0
// 1361 //  A25    SCCB_SDA
// 1362 //  A26    SCCB_SCL
// 1363 //  B0~B7  摄像头数据
// 1364 //  B9     PCLK
// 1365 //  B16    UART0_RX
// 1366 //  B17    UART0_TX
// 1367 //  C8     HREF
// 1368 //  C16    OLED_D0
// 1369 //  C17    OLED_D1
// 1370 //  C18    OLED_RST
// 1371 //  C19    OLED_DC
// 1372 //  D1     VSYNC
// 1373 //  D4     电机FTM0_CH4左正
// 1374 //  D5     电机FTM0_CH5左反
// 1375 //  D6     电机FTM0_CH6右正
// 1376 //  D7     电机FTM0_CH7右反
// 1377 //  E0~E5  按钮（核心板上的那种小按钮）
// 1378 //  E6~E9  拨码开头
// 1379 //  E26    工作指示灯
// 1380 
// 1381 #ifdef SERVO_DEBUG
// 1382 
// 1383 #include "math.h"
// 1384 #include "common.h"
// 1385 #include "sysinit.h"
// 1386 #include "gpio.h"
// 1387 #include "light.h"
// 1388 #include "uart.h"
// 1389 #include "wdog.h"
// 1390 #include "Pit.h"
// 1391 #include "DMA.h"
// 1392 #include "ImageGet.h"
// 1393 #include "ImagePro.h"
// 1394 #include "CameraSet.h"
// 1395 #include "vectors.h"
// 1396 #include "MK60N512VMD100.h"
// 1397 #include "Ftm.h"
// 1398 
// 1399 
// 1400 void main(void)
// 1401 {
// 1402     //int i, j;
// 1403     DisableInterrupts;                                    //关闭所有中断
// 1404     
// 1405     gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
// 1406     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
// 1407     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
// 1408     pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
// 1409     //enable_pit_interrupt(PIT0);                         //开PIT1中断
// 1410     
// 1411     EnableInterrupts;
// 1412     
// 1413     ServoInit();
// 1414     while(1)
// 1415     {
// 1416       
// 1417       FTM1_C0V = 1350;
// 1418       //FTM1_C0V = 1310;
// 1419       /*for(i = 0; i < 10000; i++)
// 1420         for(j = 0; j < 10000; j++)
// 1421         {}
// 1422       FTM1_C0V = 1810;
// 1423       for(i = 0; i < 10000; i++)
// 1424         for(j = 0; j < 10000; j++)
// 1425         {}
// 1426       FTM1_C0V = 2039;
// 1427       for(i = 0; i < 10000; i++)
// 1428         for(j = 0; j < 10000; j++)
// 1429         {}
// 1430       */
// 1431       uart_sendN(UART0, (uint8 *)"\nHello Servo!", 13);
// 1432     }  // end of while(1)   
// 1433 }      // end of main()
// 1434 #endif // end of SERVO_DEBUG
// 1435   
// 1436  
// 1437   
// 1438 //==========================虚拟示波器测试===========================
// 1439 #ifdef VIRTURL_DEBUG
// 1440 
// 1441 #include "common.h"
// 1442 #include "sysinit.h"
// 1443 #include "gpio.h"
// 1444 #include "light.h"
// 1445 #include "uart.h"
// 1446 #include "wdog.h"
// 1447 #include "Pit.h"  
// 1448 #include "VirtualScope.h"
// 1449 
// 1450 
// 1451 void main(void)
// 1452 {
// 1453     uint8 t1 = 0;
// 1454     uint8 t2 = 125;
// 1455     DisableInterrupts;                                    //关闭所有中断
// 1456     
// 1457     gpio_init(PORTA,10,1,0);                              //时间测试引脚初始化
// 1458     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
// 1459     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
// 1460     pit_init(PIT0,75000);                                   //初始化PIT1周期为1ms*20*4   测试监控控制周期
// 1461     //enable_pit_interrupt(PIT0);                         //开PIT1中断
// 1462     
// 1463     EnableInterrupts;
// 1464     
// 1465     
// 1466     while(1)
// 1467     {
// 1468       t1++;
// 1469       t2++;
// 1470       Virtual2DataPush(0, t1);
// 1471       Virtual2DataPush(1, t2);
// 1472       Virtual2DataPush(15, t1);
// 1473       Virtual2Send();
// 1474       //VirtualScopeSend();     
// 1475     }  // end of while(1) 
// 1476 }      // end of main
// 1477 #endif // end of VIRTURL_DEBUG
// 1478 
// 1479 
// 1480 
// 1481 
// 1482 //================================编码器测试=================================
// 1483 #ifdef QUAD_DEBUG
// 1484 
// 1485 #include "common.h"
// 1486 #include "sysinit.h"
// 1487 #include "gpio.h"
// 1488 #include "light.h"
// 1489 #include "uart.h"
// 1490 #include "wdog.h"
// 1491 #include "Pit.h"  
// 1492 #include "Ftm.h"
// 1493 #include "VirtualScope.h"
// 1494 
// 1495 void main(void)
// 1496 {
// 1497     DisableInterrupts;                                    //关闭所有中断
// 1498     
// 1499     gpio_init(PORTA,17,1,0);                              //时间测试引脚初始化
// 1500     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
// 1501     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
// 1502     pit_init(PIT0,75000*5);                                   //初始化PIT0周期,75000是1ms.
// 1503     enable_pit_interrupt(PIT0);                         //开PIT0中断
// 1504     
// 1505     EnableInterrupts;
// 1506     
// 1507     MotorInit();                //电机初始化函数
// 1508     QuadInit3();                //3线编码器初始化函数
// 1509     while(1)
// 1510     {
// 1511       Virtual2SendData();
// 1512       //VirtualScopeSend();     
// 1513     }  // end of while(1) 
// 1514 }      // end of main
// 1515 #endif // end of QUAD_DEBUG
// 1516 
// 1517 
// 1518 
// 1519 //================================差速测试=================================
// 1520 #ifdef DIFF_DEBUG
// 1521 
// 1522 #include "common.h"
// 1523 #include "sysinit.h"
// 1524 #include "gpio.h"
// 1525 #include "light.h"
// 1526 #include "uart.h"
// 1527 #include "wdog.h"
// 1528 #include "Pit.h"  
// 1529 #include "Ftm.h"
// 1530 #include "VirtualScope.h"
// 1531 
// 1532 void main(void)
// 1533 {
// 1534     uint32 temptic1;
// 1535   
// 1536     DisableInterrupts;                                    //关闭所有中断
// 1537     
// 1538     //gpio_init(PORTA,17,1,0);                              //时间测试引脚初始化
// 1539     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
// 1540     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
// 1541     pit_init(PIT0,75000*5);                                   //初始化PIT0周期,75000是1ms.
// 1542     pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
// 1543     enable_pit_interrupt(PIT0);                         //开PIT0中断
// 1544     
// 1545     //MotorInit();                //电机初始化函数
// 1546     QuadInit3();                //3线编码器初始化函数
// 1547     ServoInit();
// 1548     //MotorInit();
// 1549     
// 1550     EnableInterrupts;
// 1551     
// 1552 
// 1553     while(1)
// 1554     {
// 1555       tic1 = temptic1;
// 1556       temptic1 = PIT_CVAL(1);
// 1557       
// 1558       FTM2_CNT = 0;                            //计数器清零。准备开启10ms的编码器速度值采集。
// 1559       QuadDoneFlag = 0;                        //提前将该标志位置0，以防ImagePro()用时少于5ms的情况。
// 1560       
// 1561       PIT_TCTRL(PIT0) |= PIT_TCTRL_TEN_MASK;       //使能pit模块运行,此时PIT计数器开始倒数。
// 1562       enable_pit_interrupt(PIT0);                         //开PIT0中断
// 1563       
// 1564       while(QuadDoneFlag == 0) ;  //若编码器速度采集未完成，则一直等待。
// 1565       
// 1566       
// 1567       gpio_init(PORTA,17,1,0);
// 1568       
// 1569       Virtual2SendData();
// 1570       
// 1571       toc1 = PIT_CVAL(1);
// 1572     }  // end of while(1) 
// 1573 }      // end of main
// 1574 #endif // end of DIFF_DEBUG
// 1575 
// 1576 
// 1577 //================================DEBUG测试================================
// 1578 #ifdef DEBUG_DEBUG
// 1579 
// 1580 #include "math.h"
// 1581 #include "common.h"
// 1582 #include "sysinit.h"
// 1583 #include "gpio.h"
// 1584 #include "light.h"
// 1585 #include "uart.h"
// 1586 #include "wdog.h"
// 1587 #include "Pit.h"
// 1588 #include "DMA.h"
// 1589 #include "ImageGet.h"
// 1590 #include "ImagePro.h"
// 1591 #include "CameraSet.h"
// 1592 #include "vectors.h"
// 1593 #include "MK60N512VMD100.h"
// 1594 #include "Ftm.h"
// 1595 #include "RunControl.h"
// 1596 #include "VirtualScope.h"
// 1597 #include "Flash.h"
// 1598 #include "LQ12864.h"
// 1599 #include "Debug.h"
// 1600 
// 1601 void main(void)
// 1602 {
// 1603     //uint8 flag;
// 1604     DisableInterrupts;                                    //关闭所有中断
// 1605     
// 1606     gpio_init(PORTA,17,1,1);                              //时间测试引脚初始化
// 1607     gpio_init(PORTC, 0,1,1);
// 1608     gpio_init(PORTD,15,1,1);
// 1609     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
// 1610     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
// 1611     pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
// 1612     pit_init(PIT0, 75000*5);                              //75000即为1ms
// 1613     //enable_pit_interrupt(PIT0);                         //开PIT0中断
// 1614     
// 1615     MotorInit();          //初始化电机
// 1616     ServoInit();          // 初始化舵机
// 1617     QuadInit3();           //初始化编码器
// 1618     //OLEDInit();           //初始化OLED
// 1619     //CameraInit();         //初始化摄像头
// 1620     
// 1621     while(!CameraInit())         //初始化摄像头
// 1622     {
// 1623       uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
// 1624     }
// 1625     
// 1626     //DMA通道0， DMA触发源为PORTB， DMA源地址为B0~B7, DMA目的地址为ImgStore1数组
// 1627     while(!DMAInit(DMACH00, DMASOURCE_PORTB, CameraWidth, GPIOB_DIR_ADDR, (uint32)(ImgStore1[0])))
// 1628     {
// 1629       uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
// 1630     }
// 1631     
// 1632     //这儿的优先级设置的正确性有待验证============================
// 1633     //set_irq_priority(FIELD_IRQ, 2);
// 1634     //set_irq_priority(LINE_IRQ, 1);
// 1635     //set_irq_priority(DMA0_IRQ, 0);
// 1636     
// 1637     PORTD_ISFR = PORT_ISFR_ISF_MASK;       //清场所在PORT的标志位
// 1638     PORTC_ISFR = PORT_ISFR_ISF_MASK;       //清行所在PORT的标志位
// 1639     PORTB_ISFR = PORT_ISFR_ISF_MASK;       //清PCLK所在PORT的标志位
// 1640     disable_irq(LINE_IRQ);                 //关行中断IRQ
// 1641     disable_irq(DMA0_IRQ);                 //关DMA传输完成中断IRQ
// 1642     enable_irq(FIELD_IRQ);                //开场中断IRQ
// 1643     
// 1644     ImgStatus = ImgGetStart;        //图像采集标志位置为开始
// 1645     EnableInterrupts;                                     //打开所有中断
// 1646     
// 1647     while(1)
// 1648     {
// 1649       //16.64ms的终点。
// 1650       tic1 = PIT_CVAL(1);
// 1651       while(ImgStatus != ImgGetFinish) ; //如果图像采集未结束，则一直等待。
// 1652       
// 1653       //16.64ms的起点。            
// 1654       ImgStatus = ImgGetStart;        //图像采集标志位置为开始        
// 1655 
// 1656       FTM2_CNT = 0;                            //计数器清零。准备开启10ms的编码器速度值采集。
// 1657       QuadDoneFlag = 0;                        //提前将该标志位置0，以防ImagePro()用时少于5ms的情况。
// 1658       
// 1659       PIT_TCTRL(PIT0) |= PIT_TCTRL_TEN_MASK;       //使能pit模块运行,此时PIT计数器开始倒数。
// 1660       enable_pit_interrupt(PIT0);                         //开PIT0中断
// 1661       
// 1662       tic2 = PIT_CVAL(1);
// 1663       //若图像处理成功（即偏差获取成功），则进行舵机和电机的控制，否则保持原状。
// 1664       //若已经经过直角弯特殊处理，也可以进行舵机和电机的控制。
// 1665       if(ImagePro() == 1 || AngleSpeDealFlag == 1)          //图像处理  
// 1666       {
// 1667         //QuadInit3();           //初始化编码器
// 1668         toc2 = PIT_CVAL(1);
// 1669         while(QuadDoneFlag == 0) ;  //若编码器速度采集未完成，则一直等待。
// 1670         
// 1671         
// 1672         tic3 = PIT_CVAL(1); 
// 1673         ServoPID();         //舵机控制
// 1674         MotorPID();         //电机控制
// 1675         toc3 = PIT_CVAL(1);
// 1676       }
// 1677       
// 1678       toc1 = PIT_CVAL(1);
// 1679       //VirtualScopeSend();
// 1680       Virtual2SendData();
// 1681       
// 1682       
// 1683       
// 1684     }  // end of while(1)
// 1685 }      // end of main()
// 1686 #endif // end of DEBUG_DEBUG
// 1687 
// 1688 
// 1689 //=================================OLED测试================================
// 1690 #ifdef OLED_DEBUG
// 1691 
// 1692 #include "math.h"
// 1693 #include "common.h"
// 1694 #include "sysinit.h"
// 1695 #include "gpio.h"
// 1696 #include "light.h"
// 1697 #include "uart.h"
// 1698 #include "wdog.h"
// 1699 #include "Pit.h"
// 1700 #include "DMA.h"
// 1701 #include "ImageGet.h"
// 1702 #include "ImagePro.h"
// 1703 #include "CameraSet.h"
// 1704 #include "vectors.h"
// 1705 #include "MK60N512VMD100.h"
// 1706 #include "Ftm.h"
// 1707 #include "RunControl.h"
// 1708 #include "VirtualScope.h"
// 1709 #include "Debug.h"
// 1710 #include "Flash.h"
// 1711 #include "LQ12864.h"
// 1712 
// 1713 void main(void)
// 1714 {
// 1715     uint16 temp = 359;
// 1716     uint8 temp1[4] = {0, 0, 0, 0};
// 1717     uint32 tempcount = 0;
// 1718   
// 1719     DisableInterrupts;                                    //关闭所有中断
// 1720         
// 1721     gpio_init(PORTA,17,1,1);                              
// 1722     gpio_init(PORTC, 0,1,1);
// 1723     gpio_init(PORTD,15,1,1);
// 1724     gpio_init(PORTE,26,1,1);
// 1725     //light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
// 1726     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
// 1727     pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
// 1728     pit_init(PIT0, 75000);                              //75000即为1ms
// 1729     enable_pit_interrupt(PIT0);
// 1730     
// 1731     //这里给一个编码器初始化是为了把FTM2模块初始化一下，因为PIT0_ISR中有取FTM2_CNT寄存器的值。
// 1732     //如果不初始化，取值的时候会过不去，一直卡在那儿。
// 1733     QuadInit3();
// 1734     
// 1735     DebugInit();
// 1736     
// 1737     //需要把PIT0_ISR函数简化。不然会跳不出来。
// 1738     
// 1739     temp1[0] = temp / 100 + 48;
// 1740     temp1[1] = (temp % 100) / 10 + 48;
// 1741     temp1[2] = (temp % 10) / 1 + 48;
// 1742     LCD_P6x8Str(0, 0, "S0");
// 1743     LCD_P6x8Str(0, 1, "S1");
// 1744     LCD_P6x8Str(0, 2, "S2");
// 1745     LCD_P6x8Str(0, 3, "S3");
// 1746     
// 1747     LCD_P6x8Str(64, 0, "B0");
// 1748     LCD_P6x8Str(64, 1, "B1");
// 1749     LCD_P6x8Str(64, 2, "B2");
// 1750     LCD_P6x8Str(64, 3, "B3");
// 1751     LCD_P6x8Str(64, 4, "B4");
// 1752     LCD_P6x8Str(64, 5, "B5");    
// 1753     
// 1754     //gpio_ctrl(PORTC, 0,0);
// 1755     //gpio_ctrl(PORTD, 15,0);
// 1756     gpio_ctrl(PORTA, 17,0);
// 1757     EnableInterrupts;                                     //打开所有中断  
// 1758     
// 1759     while(1)
// 1760     {
// 1761       gpio_ctrl(PORTD, 15,0);
// 1762       tempcount++;
// 1763       if(tempcount > 1000)
// 1764       {
// 1765         tempcount = 0;
// 1766         //DisableInterrupts;
// 1767         
// 1768         //////////实现按下某个键或者拨一下某个拨码开关，则某个灯亮。
// 1769         //中断函数会不会对LCD函数有影响？
// 1770         DebugSwitchScan();
// 1771         
// 1772          
// 1773         //拨码开关值显示。
// 1774         if(DebugSwitchFlag[0] == 1)
// 1775         {
// 1776           LCD_P6x8Str(18, 0, "1");
// 1777         }
// 1778         else
// 1779         {
// 1780           LCD_P6x8Str(18, 0, "0");
// 1781         }
// 1782         
// 1783         if(DebugSwitchFlag[1] == 1)
// 1784         {
// 1785           LCD_P6x8Str(18, 1, "1");
// 1786         }
// 1787         else
// 1788         {
// 1789           LCD_P6x8Str(18, 1, "0");
// 1790         }      
// 1791         
// 1792         if(DebugSwitchFlag[2] == 1)
// 1793         {
// 1794           LCD_P6x8Str(18, 2, "1");
// 1795         }
// 1796         else
// 1797         {
// 1798           LCD_P6x8Str(18, 2, "0");
// 1799         }
// 1800         
// 1801         if(DebugSwitchFlag[3] == 1)
// 1802         {
// 1803           LCD_P6x8Str(18, 3, "1");
// 1804         }
// 1805         else
// 1806         {
// 1807           LCD_P6x8Str(18, 3, "0");
// 1808         }
// 1809         
// 1810         
// 1811         if(DebugButtonScan() == 1)
// 1812         {
// 1813         //按键值显示。
// 1814         if(DebugButtonFlag[0] == 1)
// 1815         {
// 1816             LCD_P6x8Str(82, 0, "1");
// 1817           }
// 1818           else
// 1819           {
// 1820             LCD_P6x8Str(82, 0, "0");
// 1821           }      
// 1822     
// 1823           if(DebugButtonFlag[1] == 1)
// 1824           {
// 1825             LCD_P6x8Str(82, 1, "1");
// 1826           }
// 1827           else
// 1828           {
// 1829             LCD_P6x8Str(82, 1, "0");
// 1830           }            
// 1831           
// 1832           if(DebugButtonFlag[2] == 1)
// 1833           {
// 1834             LCD_P6x8Str(82, 2, "1");
// 1835           }
// 1836           else
// 1837           {
// 1838             LCD_P6x8Str(82, 2, "0");
// 1839           }      
// 1840           
// 1841           if(DebugButtonFlag[3] == 1)
// 1842           {
// 1843             LCD_P6x8Str(82, 3, "1");
// 1844           }
// 1845           else
// 1846           {
// 1847             LCD_P6x8Str(82, 3, "0");
// 1848           }            
// 1849           
// 1850           if(DebugButtonFlag[4] == 1)
// 1851           {
// 1852             LCD_P6x8Str(82, 4, "1");
// 1853           }
// 1854           else
// 1855           {
// 1856             LCD_P6x8Str(82, 4, "0");
// 1857           }      
// 1858     
// 1859           if(DebugButtonFlag[5] == 1)
// 1860           {
// 1861             LCD_P6x8Str(82, 5, "1");
// 1862           }
// 1863           else
// 1864           {
// 1865             LCD_P6x8Str(82, 5, "0");
// 1866           }      
// 1867         }
// 1868         
// 1869         //EnableInterrupts;
// 1870       }
// 1871       
// 1872     }  // end of while(1)
// 1873 }      // end of main()
// 1874 #endif // end of OLED_DEBUG
// 1875 
// 1876 
// 1877 
// 1878 //=================================FLASH测试================================
// 1879 #ifdef FLASH_DEBUG
// 1880 
// 1881 #include "math.h"
// 1882 #include "common.h"
// 1883 #include "sysinit.h"
// 1884 #include "gpio.h"
// 1885 #include "light.h"
// 1886 #include "uart.h"
// 1887 #include "wdog.h"
// 1888 #include "Pit.h"
// 1889 #include "DMA.h"
// 1890 #include "ImageGet.h"
// 1891 #include "ImagePro.h"
// 1892 #include "CameraSet.h"
// 1893 #include "vectors.h"
// 1894 #include "MK60N512VMD100.h"
// 1895 #include "Ftm.h"
// 1896 #include "RunControl.h"
// 1897 #include "VirtualScope.h"
// 1898 #include "Debug.h"
// 1899 #include "Flash.h"
// 1900 #include "LQ12864.h"
// 1901 
// 1902 void main(void)
// 1903 {
// 1904     uint8 *pointeruint8;         //uint8型数据的指针。
// 1905   
// 1906     uint8 i;
// 1907   /* uint32 temp[60] = {//0,10,20, 30, 40, 50, 60, 70, 80, 90,150
// 1908                        0,165,180,205,215,235,240,229,225,211,211,   //11个舵机P值。
// 1909                        130,140,110,120,   //4个图像关键阈值。
// 1910                        10, 20, 25, 20, //多行第0列-0
// 1911                        20, 25, 22, 15, //多行第1列-10
// 1912                        24, 30, 19, 11, //多行第2列-20
// 1913                        29, 38, 17, 8, //多行第3列-30
// 1914                        32, 38, 15, 7,  //多行第4列-40
// 1915                        35, 45, 13, 5, //多行第5列-50
// 1916                        37, 55, 12, 3, //多行第6列-60
// 1917                        40, 60, 12, 0,  //多行第7列-60+
// 1918                         480,             //定时跑时间，0.1s为单位。
// 1919                         35,         //电机P
// 1920                         80         //电机D
// 1921                       };*/
// 1922       uint32 temp[60] = {//0,10,20, 30, 40, 50, 60, 70, 80, 90,150
// 1923                        50,       //LightHouseWaitStartMaxTime发车最多时间
// 1924                        6,        //SpeedStrategyChosen速度策略
// 1925                        300,      //MotorTakeOffQuadCountLimit起飞速度
// 1926                        3,2,3,5, //AngleZoneConfirmMatLimit, AngleConfirmMatLimit, BrickConfirmMatLimit, BrickConfirmFinalColCom
// 1927                        20,10,    //LightHouseWaitStopDelayCountLimit, LightHouseWaitStopGapCountLimit
// 1928                        75,90,90,140,80,110,   //6个图像关键阈值。WBi, WBa, Win, Wax, Bin, Bax
// 1929                        10, 20, 25, 25, //多行第0列-0
// 1930                        20, 25, 25, 20, //多行第1列-10
// 1931                        24, 30, 20, 15, //多行第2列-20
// 1932                        29, 38, 17, 8, //多行第3列-30
// 1933                        32, 38, 15, 7,  //多行第4列-40
// 1934                        35, 45, 13, 5, //多行第5列-50
// 1935                        37, 55, 12, 3, //多行第6列-60
// 1936                        40, 60, 12, 0,  //多行第7列-60+
// 1937                         480,             //定时跑时间，0.1s为单位。
// 1938                         20,         //电机P
// 1939                         15,         //电机D
// 1940                         30,         //坡道的给定速度
// 1941                         21,         //直角弯的给定速度
// 1942                         35,         //长直道的给定速度
// 1943                         20,         //坡道禁止赛道类型判断倒计数载入值
// 1944                         8,          //连续直道计数阈值
// 1945                         5,          //停车计数阈值，1个单位是0.1s
// 1946                         0,          //灯塔不停车标志，1启用这种模式，0不使用
// 1947                         5,          //直角弯线头差阈值，如果有误检测，则调大
// 1948                         25,         //灯塔等待停车速度
// 1949                         25          //上坡速度
// 1950                       };
// 1951        
// 1952          
// 1953     DisableInterrupts;                                    //关闭所有中断
// 1954 
// 1955     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
// 1956     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
// 1957     pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
// 1958     pit_init(PIT0, 75000);                              //75000即为1ms
// 1959     //enable_pit_interrupt(PIT0);
// 1960 
// 1961     
// 1962     FlashInit();
// 1963 
// 1964     //EnableInterrupts;                                     //打开所有中断  
// 1965     
// 1966     //先擦除整个扇区。
// 1967     FlashEraseSector(FlashSectorIndex);
// 1968   
// 1969     
// 1970     for(i = 0; i < 60; i++)
// 1971     {
// 1972       pointeruint8 = (uint8 *)&temp[i];
// 1973       FlashWriteNow(FlashSectorIndex, i, FlashElementSize, pointeruint8);  
// 1974     }
// 1975     
// 1976     while(1)
// 1977     {
// 1978 
// 1979       gpio_init(PORTD,15,1,0); 
// 1980     }  // end of while(1)
// 1981 }      // end of main()
// 1982 #endif // end of FLASH_DEBUG
// 1983 
// 1984 
// 1985 //=================================陀螺仪测试================================
// 1986 #ifdef GYRO_DEBUG
// 1987 
// 1988 #include "math.h"
// 1989 #include "common.h"
// 1990 #include "sysinit.h"
// 1991 #include "gpio.h"
// 1992 #include "light.h"
// 1993 #include "uart.h"
// 1994 #include "wdog.h"
// 1995 #include "Pit.h"
// 1996 #include "DMA.h"
// 1997 #include "ImageGet.h"
// 1998 #include "ImagePro.h"
// 1999 #include "CameraSet.h"
// 2000 #include "vectors.h"
// 2001 #include "MK60N512VMD100.h"
// 2002 #include "Ftm.h"
// 2003 #include "RunControl.h"
// 2004 #include "VirtualScope.h"
// 2005 #include "Debug.h"
// 2006 #include "Flash.h"
// 2007 #include "LQ12864.h"
// 2008 #include "adc.h"
// 2009 
// 2010 void main(void)
// 2011 {
// 2012 
// 2013     DisableInterrupts;                                    //关闭所有中断
// 2014     
// 2015     light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
// 2016     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
// 2017     pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
// 2018     //pit_init(PIT0,75000*5);                                   //初始化PIT0周期,75000是1ms.
// 2019     //enable_pit_interrupt(PIT0);                         //开PIT0中断
// 2020     
// 2021     //ADC初始化
// 2022     hw_adc_init(0);
// 2023     
// 2024     //陀螺仪初始化
// 2025     GyroInit();
// 2026     
// 2027     
// 2028     //EnableInterrupts;  
// 2029 
// 2030     while(1)
// 2031     {
// 2032       
// 2033       tic2 = PIT_CVAL(1);
// 2034       //ADResult0 = (ADResult0 * 90 + (hw_ad_once(0, 10, 16) - ADResultCom) * 10) / 100;
// 2035       //ADResult1 = (ADResult1 * 90 + (hw_ad_once(0, 17, 16) - ADResultCom) * 10) / 100;
// 2036       //ADResult2 = (ADResult2 * 90 + (hw_ad_once(0, 18, 16) - ADResultCom) * 10) / 100;
// 2037       ADResult0 = hw_ad_once(0, 10, 16) - ADResultCom;
// 2038       toc2 = PIT_CVAL(1);
// 2039       
// 2040       tic3 = PIT_CVAL(1);
// 2041       //ADResult3 = (ADResult3 * 90 + (hw_ad_mid(0, 10, 16) - ADResultCom) * 10) / 100;
// 2042       //ADResult4 = (ADResult4 * 90 + (hw_ad_mid(0, 17, 16) - ADResultCom) * 10) / 100;
// 2043       //ADResult5 = (ADResult5 * 90 + (hw_ad_mid(0, 18, 16) - ADResultCom) * 10) / 100;
// 2044       ADResult3 = hw_ad_mid(0, 10, 16) - ADResultCom;
// 2045       toc3 = PIT_CVAL(1);    
// 2046       
// 2047       Virtual2SendData();
// 2048       
// 2049     }  // end of while(1)
// 2050 }      // end of main()
// 2051 #endif // end of GYRO_DEBUG
// 2052 
// 2053 //=================================灯塔测试================================
// 2054 #ifdef LIGHTHOUSE_DEBUG
// 2055 
// 2056 #include "math.h"
// 2057 #include "common.h"
// 2058 #include "sysinit.h"
// 2059 #include "gpio.h"
// 2060 #include "light.h"
// 2061 #include "uart.h"
// 2062 #include "wdog.h"
// 2063 #include "Pit.h"
// 2064 #include "DMA.h"
// 2065 #include "ImageGet.h"
// 2066 #include "ImagePro.h"
// 2067 #include "CameraSet.h"
// 2068 #include "vectors.h"
// 2069 #include "MK60N512VMD100.h"
// 2070 #include "Ftm.h"
// 2071 #include "RunControl.h"
// 2072 #include "VirtualScope.h"
// 2073 #include "Debug.h"
// 2074 #include "Flash.h"
// 2075 #include "LQ12864.h"
// 2076 #include "adc.h"
// 2077 
// 2078 void main(void)
// 2079 {
// 2080 
// 2081     DisableInterrupts;                                    //关闭所有中断
// 2082     
// 2083     //light_init(PORTE, 26, Light_ON);                      //单片机工作指示灯
// 2084     uart_init(UART0, periph_clk_khz, 115200);             //串口初始化
// 2085     pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478表示17ms，必须远大于该值才有tictoc的意义。
// 2086     //pit_init(PIT0,75000*5);                                   //初始化PIT0周期,75000是1ms.
// 2087     //enable_pit_interrupt(PIT0);                         //开PIT0中断
// 2088     
// 2089     //灯塔初始化
// 2090     LightHouseInit();
// 2091     
// 2092     gpio_init(PORTE, 26, 1, 1);   //最后一个1表示熄灭
// 2093     gpio_init(PORTA, 17, 1, 1);
// 2094     
// 2095     
// 2096     //EnableInterrupts;  
// 2097 
// 2098     while(1)
// 2099     {
// 2100       
// 2101       LightHouseStateUpdate();
// 2102       
// 2103       if(LightHouseStateR0 == 1)
// 2104       {
// 2105         GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 17);   //输出低电平表示点亮
// 2106       }
// 2107       else
// 2108       {
// 2109         GPIO_PDOR_REG(PTA_BASE_PTR) |=  (1 << 17);   //输出高电平表示熄灭
// 2110       }
// 2111  
// 2112       if(LightHouseStateR1 == 1)
// 2113       {
// 2114         GPIO_PDOR_REG(PTE_BASE_PTR) &= ~(1 << 26);   //输出低电平表示点亮
// 2115       }
// 2116       else
// 2117       {
// 2118         GPIO_PDOR_REG(PTE_BASE_PTR) |=  (1 << 26);   //输出高电平表示熄灭
// 2119       }
// 2120       
// 2121       Virtual2SendData();
// 2122       
// 2123     }  // end of while(1)
// 2124 }      // end of main()
// 2125 #endif // end of LIGHTHOUSE_DEBUG
// 2126 
// 2127 
// 2128 //标准C文件头
// 2129 
// 2130 /******************************************************************************/
// 2131 /*******************************************************************************
// 2132   文件名：图像处理程序文件ImagePro.c
// 2133   功  能：图像处理
// 2134   日  期：2014.10.09
// 2135   作  者：HJZ
// 2136   备  注：
// 2137 *******************************************************************************/
// 2138 /******************************************************************************/
// 2139 
// 2140 
// 2141 //标准H文件头
// 2142 
// 2143 /******************************************************************************/
// 2144 /*******************************************************************************
// 2145   文件名：图像处理程序头文件IamgePro.h
// 2146   功  能：图像处理
// 2147   日  期：2014.10.09
// 2148   作  者：HJZ
// 2149   备  注：
// 2150 *******************************************************************************/
// 2151 /******************************************************************************/
// 2152 //1. 头文件
// 2153 //2. 宏定义
// 2154 //3. 变量类型定义
// 2155 //4. 变量声明
// 2156 //5. 函数声明
// 2157 
// 2158 
// 2159 //标准函数头
// 2160 
// 2161 //======================================================================
// 2162 //函数名：
// 2163 //功  能：
// 2164 //参  数：
// 2165 //返  回：
// 2166 //影  响：
// 2167 //说  明：
// 2168 //      
// 2169 //             
// 2170 //======================================================================
// 
//  84 bytes in section .rodata
// 678 bytes in section .text
// 
// 678 bytes of CODE  memory
//  84 bytes of CONST memory
//
//Errors: none
//Warnings: 11
