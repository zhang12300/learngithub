///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.10.1.12857/W32 for ARM      30/Aug/2018  15:15:46
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Function_C\CameraSet.c
//    Command line =  
//        -f C:\Users\Lenovo\AppData\Local\Temp\EW83D4.tmp
//        (C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Function_C\CameraSet.c
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
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\bin\Ram\List\CameraSet.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN SCCBPortInit
        EXTERN SCCBWriteByte
        EXTERN uart_sendN

        PUBLIC CameraDelay
        PUBLIC CameraInit
        PUBLIC CameraPortInit
        PUBLIC CameraRegInit
        PUBLIC ImgStatus
        PUBLIC ImgStore1
        PUBLIC ImgStore2
        PUBLIC OV7620Regs
        PUBLIC OV7725Regs

// C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Function_C\CameraSet.c
//    1 /******************************************************************************/
//    2 /*******************************************************************************
//    3   文件名：摄像头寄存器设置文件CameraSet.c
//    4   功  能：摄像头特性控制
//    5   日  期：2014.10.09
//    6   作  者：HJZ
//    7   备  注：
//    8 *******************************************************************************/
//    9 /******************************************************************************/
//   10 //头文件
//   11 #include "CameraSet.h"
//   12 
//   13 
//   14 //全局变量声明

        SECTION `.data`:DATA:REORDER:NOROOT(0)
        DATA
//   15 volatile ImgStatusDef ImgStatus = ImgGetFinish;   //当前图像状态标志标志位
ImgStatus:
        DC8 1
//   16 //uint8 ImgRaw[CameraHight][CameraWidth];           //原始数据储存数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   17 uint8 ImgStore1[CameraHight][CameraWidth];                    //图像数据储存数组1
ImgStore1:
        DS8 19200

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   18 uint8 ImgStore2[CameraHight][CameraWidth];                    //图像数据储存数组2
ImgStore2:
        DS8 19200
//   19 
//   20 //uint8 ImgSend[CameraWidth * CameraHight];      //要传送到上位机的数组，由于鹰眼摄像头是一字节8个像素，因而需要解压为 1字节1个像素，方便处理
//   21 
//   22 //OV7725寄存器专用初始值，全局变量

        SECTION `.data`:DATA:REORDER:NOROOT(2)
        DATA
//   23 CameraRegs OV7725Regs[] =
OV7725Regs:
        DC8 13, 193, 17, 0, 9, 3, 12, 208, 18, 64, 23, 63, 24, 80, 25, 3, 26
        DC8 120, 50, 0, 160, 10, 99, 224, 172, 255, 101, 12, 102, 0, 103, 0, 41
        DC8 80, 44, 30, 42, 0, 126, 12, 127, 22, 128, 42, 129, 78, 130, 97, 131
        DC8 111, 132, 123, 133, 134, 134, 142, 135, 151, 136, 164, 137, 175
        DC8 138, 197, 139, 215, 140, 232, 141, 32, 74, 0, 73, 19, 71, 8, 75, 20
        DC8 76, 23, 70, 5, 34, 153, 35, 3, 166, 4, 155, 0, 156, 255, 171, 6
        DC8 158, 17, 159, 2, 0, 0
//   24 {
//   25     //寄存器地址，寄存器值
//   26     {OV7725_COM4         , 0xC1},//01
//   27     {OV7725_CLKRC        , 0x00},//02
//   28     {OV7725_COM2         , 0x03},//03
//   29     {OV7725_COM3         , 0xD0},//04
//   30     {OV7725_COM7         , 0x40},//05
//   31     {OV7725_HSTART       , 0x3F},//06
//   32     {OV7725_HSIZE        , 0x50},//07
//   33     {OV7725_VSTRT        , 0x03},//08
//   34     {OV7725_VSIZE        , 0x78},//09
//   35     {OV7725_HREF         , 0x00},//10
//   36     {OV7725_SCAL0        , 0x0A},//11
//   37     {OV7725_AWB_Ctrl0    , 0xE0},//12
//   38     {OV7725_DSPAuto      , 0xff},//13
//   39     {OV7725_DSP_Ctrl2    , 0x0C},//14
//   40     {OV7725_DSP_Ctrl3    , 0x00},//15
//   41     {OV7725_DSP_Ctrl4    , 0x00},//16
//   42 
//   43 #if (CameraWidth == 80)             //17
//   44     {OV7725_HOutSize     , 0x14},   //共10位，此为高8位，低2位在OV7725_EXHCH中，为00。80，即0x50,右移2位，即0x14
//   45 #elif (CameraWidth == 160)
//   46     {OV7725_HOutSize     , 0x28},
//   47 #elif (CameraWidth == 240)
//   48     {OV7725_HOutSize     , 0x3c},
//   49 #elif (CameraWidth == 320)
//   50     {OV7725_HOutSize     , 0x50},
//   51 #else
//   52 
//   53 #endif
//   54 
//   55 #if (CameraHight == 60 )             //18
//   56     {OV7725_VOutSize     , 0x1E},   //共9位，此为高8位，低1位在OV7725_EXHCH中，为0。 60，即0x3C,右移1位，即0x1E
//   57 #elif (CameraHight == 120 )
//   58     {OV7725_VOutSize     , 0x3c},
//   59 #elif (CameraHight == 180 )
//   60     {OV7725_VOutSize     , 0x5a},
//   61 #elif (CameraHight == 240 )
//   62     {OV7725_VOutSize     , 0x78},
//   63 #else
//   64 
//   65 #endif
//   66 
//   67     {OV7725_EXHCH        , 0x00},//19
//   68     {OV7725_GAM1         , 0x0c},//20
//   69     {OV7725_GAM2         , 0x16},//21
//   70     {OV7725_GAM3         , 0x2a},//22
//   71     {OV7725_GAM4         , 0x4e},//23
//   72     {OV7725_GAM5         , 0x61},//24
//   73     {OV7725_GAM6         , 0x6f},//25
//   74     {OV7725_GAM7         , 0x7b},//26
//   75     {OV7725_GAM8         , 0x86},//27
//   76     {OV7725_GAM9         , 0x8e},//28
//   77     {OV7725_GAM10        , 0x97},//29
//   78     {OV7725_GAM11        , 0xa4},//30
//   79     {OV7725_GAM12        , 0xaf},//31
//   80     {OV7725_GAM13        , 0xc5},//32
//   81     {OV7725_GAM14        , 0xd7},//33
//   82     {OV7725_GAM15        , 0xe8},//34
//   83     {OV7725_SLOP         , 0x20},//35
//   84     {OV7725_LC_RADI      , 0x00},//36
//   85     {OV7725_LC_COEF      , 0x13},//37
//   86     {OV7725_LC_XC        , 0x08},//38
//   87     {OV7725_LC_COEFB     , 0x14},//39
//   88     {OV7725_LC_COEFR     , 0x17},//40
//   89     {OV7725_LC_CTR       , 0x05},//41
//   90     {OV7725_BDBase       , 0x99},//42
//   91     {OV7725_BDMStep      , 0x03},//43
//   92     {OV7725_SDE          , 0x04},//44
//   93     {OV7725_BRIGHT       , 0x00},//45
//   94     {OV7725_CNST         , 0xFF},//46
//   95     {OV7725_SIGN         , 0x06},//47
//   96     {OV7725_UVADJ0       , 0x11},//48
//   97     {OV7725_UVADJ1       , 0x02},//49
//   98 
//   99 };
//  100 
//  101 //OV7620寄存器专用初始值，全局变量

        SECTION `.data`:DATA:REORDER:NOROOT(2)
        DATA
//  102 CameraRegs OV7620Regs[] =
OV7620Regs:
        DC8 13, 193, 17, 0
//  103 {
//  104       //寄存器地址，寄存器值
//  105     {OV7725_COM4         , 0xC1},//01
//  106     {OV7725_CLKRC        , 0x00},//02
//  107 };
//  108 
//  109 
//  110 
//  111 
//  112 
//  113 //函数
//  114 
//  115 //CameraDelay函数
//  116 //5步 * 30000 * 1 = 150000 次运算，也就是1ms，不一定准。

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  117 void CameraDelay(uint32 time)
//  118 {
CameraDelay:
        SUB      SP,SP,#+4
//  119   volatile uint32 timecount = time * 30000;
        MOVW     R1,#+30000
        MULS     R0,R1,R0
        STR      R0,[SP, #+0]
        B.N      ??CameraDelay_0
//  120   while(timecount--)
//  121   {
//  122     asm("nop");  
??CameraDelay_1:
        nop
//  123     asm("nop");  
        nop
//  124     asm("nop");  
        nop
//  125     asm("nop");  
        nop
//  126   }
??CameraDelay_0:
        LDR      R0,[SP, #+0]
        SUBS     R1,R0,#+1
        STR      R1,[SP, #+0]
        CMP      R0,#+0
        BNE.N    ??CameraDelay_1
//  127 }
        ADD      SP,SP,#+4
        BX       LR               ;; return
//  128 
//  129 
//  130 //摄像头所需端口配置

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  131 void CameraPortInit(void)
//  132 {
CameraPortInit:
        SUB      SP,SP,#+8
//  133     uint8 i;                                  
//  134     uint8 IMAGE_PIN_IN[8] = {0,1,2,3,4,5,6,7};    
        MOV      R0,SP
        LDR.N    R1,??DataTable2
        LDRD     R2,R3,[R1, #+0]
        STRD     R2,R3,[R0, #+0]
//  135     PORT_MemMapPtr p = PORT_IMAGE_DATA_BASE_PTR;
        LDR.N    R1,??DataTable2_1  ;; 0x4004a000
//  136     
//  137     //图像数据输入口初始化， PTB0~PTB7均设置为摄像头数据输入，下拉电阻 
//  138     //SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK;
//  139     for(i = 0;i < 8;i++)
        MOVS     R0,#+0
        B.N      ??CameraPortInit_0
//  140     {
//  141         //相应的端口引脚初始化,不用输入，
//  142         //gpio_init(PORT_IMAGE_DATA,IMAGE_PIN_IN[i],0,0);
//  143         //设置端口为GPIO模式，默认上拉电阻
//  144         PORT_PCR_REG(p,IMAGE_PIN_IN[i]) |= PORT_PCR_MUX(0x01) | PORT_PCR_PE_MASK;
??CameraPortInit_1:
        MOV      R2,SP
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRB     R2,[R2, R0]
        MOV      R3,SP
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRB     R3,[R3, R0]
        LDR      R3,[R1, R3, LSL #+2]
        ORRS     R3,R3,#0x102
        STR      R3,[R1, R2, LSL #+2]
//  145         //设置为下拉电阻
//  146         PORT_PCR_REG(p,IMAGE_PIN_IN[i]) &= ~PORT_PCR_PS_MASK;
        MOV      R2,SP
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRB     R2,[R2, R0]
        MOV      R3,SP
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRB     R3,[R3, R0]
        LDR      R3,[R1, R3, LSL #+2]
        LSRS     R3,R3,#+1
        LSLS     R3,R3,#+1
        STR      R3,[R1, R2, LSL #+2]
//  147         
//  148     }
        ADDS     R0,R0,#+1
??CameraPortInit_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+8
        BLT.N    ??CameraPortInit_1
//  149     
//  150     
//  151     //场中断输入引脚初始化, 下降沿触发中断，暂定为PTD1
//  152     //无上下拉电阻，无滤波
//  153     PORT_PCR_REG(PORT_FIELD_BASE_PTR, PIN_FIELD) |= (
//  154                                                     PORT_PCR_MUX(0x01)    //GPIO
//  155                                                //   | PORT_PCR_PE_MASK    //上拉电阻
//  156                                                   | PORT_PCR_IRQC(0xA)   //下降沿触发中断
//  157                                                //   | PORT_PCR_PFE_MASK   //滤波
//  158                                                     );    
        LDR.N    R0,??DataTable2_2  ;; 0x4004c004
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0xA0000
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable2_2  ;; 0x4004c004
        STR      R0,[R1, #+0]
//  159     //行中断输入引脚初始化, 上升沿触发中断，暂定为PTC8
//  160     //无上下拉电阻，无滤波
//  161     PORT_PCR_REG(PORT_LINE_BASE_PTR, PIN_LINE) |= (
//  162                                                     PORT_PCR_MUX(0x01)    //GPIO
//  163                                                //   | PORT_PCR_PE_MASK    //上拉电阻
//  164                                                   | PORT_PCR_IRQC(0x9)    //上升沿触发中断
//  165                                                //   | PORT_PCR_PFE_MASK   //滤波
//  166                                                     );   
        LDR.N    R0,??DataTable2_3  ;; 0x4004b020
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x90000
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable2_3  ;; 0x4004b020
        STR      R0,[R1, #+0]
//  167     
//  168     //PCLK输入引脚初始化，上升沿触发DMA， 暂定为PTB9
//  169     //无上下拉电阻，无滤波
//  170     PORT_PCR_REG(PORT_PCLK_BASE_PTR, PIN_PCLK) |= (
//  171                                                     PORT_PCR_MUX(0x01) //GPIO
//  172                                                 //  | PORT_PCR_PE_MASK   //上拉电阻
//  173                                                   | PORT_PCR_IRQC(0x1) //上升沿触发DMA
//  174                                                    );         
        LDR.N    R0,??DataTable2_4  ;; 0x4004a024
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x10000
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable2_4  ;; 0x4004a024
        STR      R0,[R1, #+0]
//  175 }
        ADD      SP,SP,#+8
        BX       LR               ;; return
//  176 
//  177 
//  178 /*
//  179 //OV7725摄像头寄存器初始化 成功返回1 失败返回0
//  180 uint8 CameraRegInit(void)
//  181 {
//  182     uint8 i;
//  183     uint8 SensorID = 1;
//  184     uint8 Send_Tmp[1] = {"1"};
//  185     
//  186     //SCCB信号引脚配置
//  187     SCCBPortInit();
//  188     
//  189     //复位摄像头所有寄存器
//  190     if(SCCBWriteByte(OV7725_COM7, 0x80) == 0)
//  191     {
//  192         uart_sendN(UART0, (uint8 *)"\nCamera Registers Reset Failed!", 31);
//  193         return 0;
//  194     }
//  195     
//  196     //延时
//  197     CameraDelay(50);
//  198     
//  199     
//  200     
//  201     //读取摄像头芯片的ID号
//  202     if(SCCBReadByte(&SensorID, 1, OV7725_VER) == 0)
//  203     {
//  204         uart_sendN(UART0, (uint8 *)"\nCamera Registers ReadID Failed!", 32);
//  205         return 0;
//  206     }
//  207     
//  208     Send_Tmp[0] = SensorID;
//  209     
//  210     //获取摄像头芯片ID号成功
//  211     uart_sendN(UART0, (uint8 *)"\nCamera Registers ReadID Succeed: ", 34);
//  212     uart_send1(UART0, '\n');
//  213     uart_sendN(UART0, Send_Tmp, sizeof(Send_Tmp));
//  214     
//  215     
//  216     
//  217     //配置各个寄存器
//  218     if(SensorID == OV7725_ID) 
//  219     {
//  220         for( i = 0 ; i < 49 ; i++ )
//  221         {
//  222             if( 0 == SCCBWriteByte(OV7725Regs[i].addr, OV7725Regs[i].val) )
//  223             {
//  224                 uart_sendN(UART0, (uint8 *)"\nCamera Writing a Reg Failed!", 29);
//  225                 return 0;
//  226             }
//  227         }
//  228     }
//  229     else
//  230     {
//  231         uart_sendN(UART0, (uint8 *)"\nSensor ID Unmatch!", 19);
//  232         return 0;
//  233     }
//  234     
//  235     //配置Camera各寄存器均成功
//  236     uart_sendN(UART0, (uint8 *)"\nCamera Registers Initial Finally Succeed!", 42);
//  237     return 1;
//  238 }
//  239 
//  240 */
//  241 
//  242 
//  243 
//  244 //OV7620摄像头寄存器初始化 成功返回1 失败返回0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  245 uint8 CameraRegInit(void)
//  246 {
CameraRegInit:
        PUSH     {R7,LR}
//  247     //uint8 i;
//  248     //uint8 SensorID = 1;
//  249     //uint8 Send_Tmp[1] = {"1"};
//  250     
//  251     //SCCB信号引脚配置
//  252     SCCBPortInit();
        BL       SCCBPortInit
//  253 
//  254     //复位摄像头所有寄存器
//  255     if(SCCBWriteByte(OV7620_COMCTRLA, 0x80) == 0)
        MOVS     R1,#+128
        MOVS     R0,#+18
        BL       SCCBWriteByte
        CMP      R0,#+0
        BNE.N    ??CameraRegInit_0
//  256     {
//  257         uart_sendN(UART0, (uint8 *)"\nCamera Registers Reset Failed!", 31);
        MOVS     R2,#+31
        LDR.N    R1,??DataTable2_5
        LDR.N    R0,??DataTable2_6  ;; 0x4006a000
        BL       uart_sendN
//  258         return 0;
        MOVS     R0,#+0
        B.N      ??CameraRegInit_1
//  259     }
//  260     
//  261     //延时
//  262     CameraDelay(50);    
??CameraRegInit_0:
        MOVS     R0,#+50
        BL       CameraDelay
//  263     
//  264     //PCLK四分频，HSYNC无效，CHSYNC无效，VSYNC有效边沿。
//  265     //PCLK:166ns   HREF:254.6us   VSYN:133.6ms
//  266     /*
//  267     if( 0 == SCCBWriteByte(OV7620_CLKCTRL,0x00))
//  268     {
//  269         uart_sendN(UART0, (uint8 *)"\nCamera Writing OV7620_CLKCTRL Failed!", 38);
//  270         return 0;
//  271     }
//  272     */
//  273     /*
//  274     if( 0 == SCCBWriteByte(OV7620_HS,0x3F))
//  275     {
//  276         uart_sendN(UART0, (uint8 *)"\nCamera Writing OV7620_COMCTRLC Failed!", 39);
//  277         return 0;
//  278     }
//  279     
//  280     if( 0 == SCCBWriteByte(OV7620_HE,0xBF))
//  281     {
//  282         uart_sendN(UART0, (uint8 *)"\nCamera Writing OV7620_COMCTRLC Failed!", 39);
//  283         return 0;
//  284     }    
//  285     */
//  286     //AWB激活阈值选择为 低， QVGA输出选择320*240，VSYNC在奇偶场均输出，HREF正极性，RGB伽马校正开启。
//  287     //PCLK:332ns   HREF:509.6us   VSYN:133.6ms
//  288     if( 0 == SCCBWriteByte(OV7620_COMCTRLC,0x24))
        MOVS     R1,#+36
        MOVS     R0,#+20
        BL       SCCBWriteByte
        CMP      R0,#+0
        BNE.N    ??CameraRegInit_2
//  289     {
//  290         uart_sendN(UART0, (uint8 *)"\nCamera Writing OV7620_COMCTRLC Failed!", 39);
        MOVS     R2,#+39
        LDR.N    R1,??DataTable2_7
        LDR.N    R0,??DataTable2_6  ;; 0x4006a000
        BL       uart_sendN
//  291         return 0;
        MOVS     R0,#+0
        B.N      ??CameraRegInit_1
//  292     }
//  293     
//  294     /*
//  295     //连续采集模式(320*240)
//  296     //PCLK:666ns   HREF:509.6us   VSYN:133.6ms
//  297     if( 0 == SCCBWriteByte(OV7620_COMCTRLH,0x00))
//  298     {
//  299         uart_sendN(UART0, (uint8 *)"\nCamera Writing OV7620_COMCTRLH Failed!", 39);
//  300         return 0;
//  301     }
//  302     */
//  303 
//  304     
//  305     //配置Camera各寄存器均成功
//  306     uart_sendN(UART0, (uint8 *)"\nCamera Registers Initial Finally Succeed12!", 42);
??CameraRegInit_2:
        MOVS     R2,#+42
        LDR.N    R1,??DataTable2_8
        LDR.N    R0,??DataTable2_6  ;; 0x4006a000
        BL       uart_sendN
//  307     return 1;
        MOVS     R0,#+1
??CameraRegInit_1:
        POP      {R1,PC}          ;; return
//  308 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     0x4004a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     0x4004c004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     0x4004b020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     0x4004a024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     0x4006a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_8:
        DC32     ?_3
//  309 
//  310 
//  311 
//  312 
//  313 
//  314 //摄像头初始化函数 成功返回1 失败返回0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  315 uint8 CameraInit(void)
//  316 {
CameraInit:
        PUSH     {R7,LR}
//  317   
//  318     if(!CameraRegInit()) return 0; //摄像头寄存器初始化若失败，直接返回0
        BL       CameraRegInit
        CMP      R0,#+0
        BNE.N    ??CameraInit_0
        MOVS     R0,#+0
        B.N      ??CameraInit_1
//  319     CameraPortInit();              //摄像头所需端口配置
??CameraInit_0:
        BL       CameraPortInit
//  320     return 1;
        MOVS     R0,#+1
??CameraInit_1:
        POP      {R1,PC}          ;; return
//  321 }

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_0:
        DC8 0, 1, 2, 3, 4, 5, 6, 7

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_1:
        DC8 "\012Camera Registers Reset Failed!"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_2:
        DC8 "\012Camera Writing OV7620_COMCTRLC Failed!"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_3:
        DC8 "\012Camera Registers Initial Finally Succeed12!"
        DC8 0, 0, 0

        END
//  322 
// 
// 38 400 bytes in section .bss
//    105 bytes in section .data
//    128 bytes in section .rodata
//    298 bytes in section .text
// 
//    298 bytes of CODE  memory
//    128 bytes of CONST memory
// 38 505 bytes of DATA  memory
//
//Errors: none
//Warnings: none
