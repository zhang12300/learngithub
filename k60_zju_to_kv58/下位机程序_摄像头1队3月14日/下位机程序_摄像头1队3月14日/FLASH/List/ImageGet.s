///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.30.3.8024/W32 for ARM       14/Mar/2018  19:12:12
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\ImageGet.c
//    Command line =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\ImageGet.c
//        -D IAR -D TWR_K60N512 -lCN
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
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\List\ImageGet.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN ImgStatus
        EXTERN ImgStore1
        EXTERN ImgStore2
        EXTERN enable_irq

        PUBLIC ErrorCountNow7
        PUBLIC ErrorCountNow8
        PUBLIC FieldIsr
        PUBLIC ImageGet
        PUBLIC ImgPresent
        PUBLIC ImgRaw
        PUBLIC LineCount
        PUBLIC LineIsr
        PUBLIC LineRealCount
        PUBLIC LineRealCountVal120_60_01
        PUBLIC LineRealCountVal120_60_02
        PUBLIC ModeFlag

// E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\ImageGet.c
//    1 /******************************************************************************/
//    2 /*******************************************************************************
//    3   文件名：图像采集程序IamgeGet.c
//    4   功  能：图像采集
//    5   日  期：2014.10.09
//    6   作  者：HJZ
//    7   备  注：
//    8 
//    9 *******************************************************************************/
//   10 /******************************************************************************/
//   11 
//   12 #include "ImageGet.h"
//   13 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   14 uint32 ErrorCountNow7 = 0;
ErrorCountNow7:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   15 uint32 ErrorCountNow8 = 0;
ErrorCountNow8:
        DS8 4
//   16 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   17 uint8 ModeFlag = ModeFlagRun;                    //模式标志
ModeFlag:
        DS8 1
//   18 

        SECTION `.data`:DATA:REORDER:NOROOT(0)
//   19 uint8 ImgPresent = ImgNO1; //当前可用图像的标志位，初始化为第1幅图像
ImgPresent:
        DATA
        DC8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   20 uint16 LineCount;          //当前采集的行的计数值
LineCount:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   21 uint16 LineRealCount;      //当前实际的行的计数值
LineRealCount:
        DS8 2
//   22 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   23 uint8 ImgRaw[CameraHight][CameraWidth];      //B模式时的图像数据储存数组
ImgRaw:
        DS8 19200
//   24 
//   25 //uint8 ImgRaw[CameraHight][CameraWidth];           //图像原始储存数组
//   26 //uint8 LineCount_Index;
//   27 /*
//   28 uint8 const LineRealCountVal01[CameraHight] = //当前实际的行的初始值，隔3行取1行
//   29 {
//   30 3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,60,63,66,69,72,75,78,81,
//   31 84,87,90,93,96,99,102,105,108,111,114,117,120,123,126,129,132,135,138,141,144,
//   32 147,150,153,156,159,162,165,168,171,174,177,180,183,186,189,192,195,198,201,
//   33 204,207,210,213,216,219,222,225,228,231,234,237,238
//   34 };
//   35 uint8 const LineRealCountVal02[CameraHight] = //当前实际的行的初始值，连续取中间的80行，效果不如隔行取好
//   36 {
//   37 151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,
//   38 171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,
//   39 191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,
//   40 211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230  
//   41 };
//   42 */
//   43 
//   44 /*
//   45 uint8 const LineRealCountVal03[CameraHight] = 
//   46 {
//   47 15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,60,63,66,69,72,75,78,81,84,87,90,
//   48 93,96,99,102,105,108,111,114,117,120,123,126,129,132,135,138,141,144,147,150,
//   49 153,156,159,162
//   50 };
//   51 
//   52 uint8 const LineRealCountVal120_01[CameraHight] = 
//   53 {
//   54 8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,
//   55 58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106
//   56 };
//   57 
//   58 
//   59 uint8 const LineRealCountVal120_02[CameraHight] = 
//   60 {
//   61 0,4,8,12,16,20,22,24,26,28,
//   62 30,32,34,36,38,40,42,44,46,48,
//   63 50,52,54,56,58,60,62,64,66,68,
//   64 70,72,74,76,78,80,82,84,86,88,
//   65 90,92,94,96,98,102,106,110,114,118  
//   66 };
//   67 
//   68 
//   69 uint8 const LineRealCountReverseVal[CameraHight] = 
//   70 {
//   71 14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,
//   72 66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112  
//   73 };
//   74 */
//   75 
//   76 /*
//   77 uint8 const LineRealCountVal120_40_01[CameraHight] = 
//   78 {
//   79 0,3,6,9,12,
//   80 15,18,21,24,27,
//   81 30,33,36,39,42,
//   82 45,48,51,54,57,
//   83 60,63,66,69,72,
//   84 75,78,81,84,87,
//   85 90,93,96,99,102,
//   86 105,108,111,114,117  
//   87 };
//   88 */
//   89 

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   90 uint8 const LineRealCountVal120_60_01[CameraHight] = 
LineRealCountVal120_60_01:
        DATA
        DC8 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92
        DC8 94, 96, 98, 100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120
        DC8 122, 124, 126, 128, 130, 132, 134, 136, 138, 140, 142, 144, 146
        DC8 148, 150, 152, 154, 156, 158, 160, 162, 164, 166, 168, 170, 172
        DC8 174, 176, 178
//   91 {
//   92 60,62,64,66,68,
//   93 70,72,74,76,78,
//   94 80,82,84,86,88,
//   95 90,92,94,96,98,
//   96 100,102,104,106,108,
//   97 110,112,114,116,118,
//   98 120,122,124,126,128,
//   99 130,132,134,136,138,
//  100 140,142,144,146,148,
//  101 150,152,154,156,158,
//  102 160,162,164,166,168,
//  103 170,172,174,176,178  
//  104 };
//  105 

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//  106 uint8 const LineRealCountVal120_60_02[CameraHight] = 
LineRealCountVal120_60_02:
        DATA
        DC8 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57
        DC8 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91
        DC8 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119
        DC8 121, 123, 125, 127, 129, 131, 133, 135, 137, 139, 141, 143
//  107 {
//  108 //    1,3,5,7,9,11,13,15,17,19,
//  109 //    21,23,25,27,29,31,33,35,37,39,
//  110 //    41,43,45,47,49,51,53,55,57,59,
//  111 //    61,63,65,67,69,71,73,75,77,79,
//  112 //    81,83,85,87,89,91,93,95,97,99,
//  113 //    101,103,105,107,109,
//  114 //    111,113,115,117,119
//  115  
//  116     25,27,29,31,33,35,37,39,
//  117     41,43,45,47,49,51,53,55,57,59,
//  118     61,63,65,67,69,71,73,75,77,79,
//  119     81,83,85,87,89,91,93,95,97,99,
//  120     101,103,105,107,109,111,113,115,117,119,
//  121     121,123,125,127,129,
//  122     131,133,135,137,139,141,143   
//  123         
//  124 //    21,23,25,27,29,31,33,35,37,39,
//  125 //    41,43,45,47,49,51,53,55,57,59,
//  126 //    61,63,65,67,69,71,73,75,77,79,
//  127 //    81,83,85,87,89,91,93,95,97,99,
//  128 //    101,103,105,107,109,111,113,115,117,119,
//  129 //    121,123,125,127,129,
//  130 //    131,133,135,137,139        
//  131     //60,62,64,66,68,70,72,74,
//  132 //76,78,80,82,84,
//  133 //86,88,90,92,94,
//  134 //96,98,100,102,104,
//  135 //106,108,110,112,114,
//  136 //116,118,120,122,124,
//  137 //126,128,130,132,134,
//  138 //136,138,140,142,144,
//  139 //146,148,150,152,154,
//  140 //156,158,160,162,164,
//  141 //166,168,170,172,174,
//  142 //176,178
//  143     
//  144 //76,78,80,82,84,
//  145 //86,88,90,92,94,
//  146 //96,98,100,102,104,
//  147 //106,108,110,112,114,
//  148 //116,118,120,122,124,
//  149 //126,128,130,132,134,
//  150 //136,138,140,142,144,
//  151 //146,148,150,152,154,
//  152 //156,158,160,162,164,
//  153 //166,168,170,172,174,
//  154 //176,178,180,182,184,
//  155 //186,188,190,192,194
//  156 };
//  157 
//  158 
//  159 //场中断服务函数,下降沿触发中断，暂定为PTD1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  160 void FieldIsr(void)  
//  161 {    
FieldIsr:
        PUSH     {R7,LR}
//  162     ErrorCountNow7++;
        LDR.N    R0,??DataTable2
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable2
        STR      R0,[R1, #+0]
//  163 
//  164     if(ImgStatus == ImgGetStart)  //如果的确是在ImageGet()中置了开始位，则继续。
        LDR.N    R0,??DataTable2_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??FieldIsr_0
//  165     {
//  166       //进来前已经清过标志位
//  167       enable_irq(LINE_IRQ);         //使能行中断IRQ
        MOVS     R0,#+89
        BL       enable_irq
//  168       enable_irq(DMA0_IRQ);         //使能DMA0的IRQ
        MOVS     R0,#+0
        BL       enable_irq
//  169       
//  170       LineCount = 0;               //采集行数初始值为1，后面的溢出判断就用">"而不是">="
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_2
        STRH     R0,[R1, #+0]
//  171       LineRealCount = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2_3
        STRH     R0,[R1, #+0]
//  172       //LineCount_Index = 0;
//  173 
//  174       //DMA_BASE_PTR->TCD[0].DADDR = (uint32)ImgRaw[0];     //目的地址恢复为数组开头
//  175 
//  176       if(ImgPresent == ImgNO1)    //如果当前是第1幅图像正在接收数据（即第2幅图像接收完成）
        LDR.N    R0,??DataTable2_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??FieldIsr_1
//  177       {
//  178           DMA_BASE_PTR->TCD[0].DADDR = (uint32)ImgStore1[0];     //目的地址恢复为第1个图像储存数组
        LDR.N    R0,??DataTable2_5
        LDR.N    R1,??DataTable2_6  ;; 0x40009010
        STR      R0,[R1, #+0]
        B.N      ??FieldIsr_2
//  179       }
//  180       else if(ImgPresent == ImgNO2)  //如果当前是第2幅图像正在接收数据（即第1幅图像接收完成）
??FieldIsr_1:
        LDR.N    R0,??DataTable2_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??FieldIsr_2
//  181       {
//  182           DMA_BASE_PTR->TCD[0].DADDR = (uint32)ImgStore2[0];     //目的地址恢复为第2个图像储存数组
        LDR.N    R0,??DataTable2_7
        LDR.N    R1,??DataTable2_6  ;; 0x40009010
        STR      R0,[R1, #+0]
//  183       }
//  184       else 
//  185       {
//  186           //uart_sendN(UART0, (uint8 *)"\nError In FieldIsr()!", 21);   //错误警告
//  187       }
//  188 
//  189       DMA_ERQ &= ~(1 << 0);      //DMA硬件禁用
??FieldIsr_2:
        LDR.N    R0,??DataTable2_8  ;; 0x4000800c
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable2_8  ;; 0x4000800c
        STR      R0,[R1, #+0]
//  190     }
//  191     else
//  192     {
//  193         //uart_sendN(UART0, (uint8 *)"\nError In FieldIsr()!", 21);  //错误警报
//  194     }
//  195   
//  196 }
??FieldIsr_0:
        POP      {R0,PC}          ;; return
//  197 
//  198 
//  199 
//  200 //行中断服务函数,上升沿触发中断，暂定为PTC8

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  201 void LineIsr(void)
//  202 {
//  203     ErrorCountNow8++;
LineIsr:
        LDR.N    R0,??DataTable2_9
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable2_9
        STR      R0,[R1, #+0]
//  204     
//  205     if(LineRealCount == LineRealCountVal120_60_02[LineCount])  //如果是需要采集的行，就采集，不是的话就跳过
        LDR.N    R0,??DataTable2_3
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable2_10
        LDR.N    R2,??DataTable2_2
        LDRH     R2,[R2, #+0]
        LDRB     R1,[R2, R1]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R0,R1
        BNE.N    ??LineIsr_0
//  206     {
//  207        //LineCount_Index++;
//  208         //DMA_INT |= (1<<0);        //清DMA传输完成标志位
//  209         DMA_ERQ |= (1 << 0);      //DMA硬件使能
        LDR.N    R0,??DataTable2_8  ;; 0x4000800c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable2_8  ;; 0x4000800c
        STR      R0,[R1, #+0]
//  210     }
//  211     LineRealCount++;             //实际行计数
??LineIsr_0:
        LDR.N    R0,??DataTable2_3
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable2_3
        STRH     R0,[R1, #+0]
//  212 }
        BX       LR               ;; return
//  213 
//  214 
//  215 
//  216 
//  217 
//  218 
//  219 //图像获取函数

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  220 void ImageGet(void)
//  221 {
ImageGet:
        PUSH     {R7,LR}
//  222     
//  223     ImgStatus = ImgGetStart;        //图像采集标志位置为开始
        MOVS     R0,#+4
        LDR.N    R1,??DataTable2_1
        STRB     R0,[R1, #+0]
//  224     enable_irq(FIELD_IRQ);         //开启图像采集
        MOVS     R0,#+90
        BL       enable_irq
//  225     
//  226     while(ImgStatus != ImgGetFinish) ; //如果图像采集未结束，则一直等待。
??ImageGet_0:
        LDR.N    R0,??DataTable2_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??ImageGet_0
//  227         
//  228 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     ErrorCountNow7

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     ImgStatus

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     LineCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     LineRealCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     ImgPresent

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     ImgStore1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     0x40009010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     ImgStore2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_8:
        DC32     0x4000800c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_9:
        DC32     ErrorCountNow8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_10:
        DC32     LineRealCountVal120_60_02

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  229 
//  230 
//  231 
//  232 
//  233 
//  234 
//  235 
//  236 
//  237 
//  238 
//  239 
//  240 
//  241 
//  242 
//  243 
//  244 
//  245 
//  246 
//  247 
//  248 
//  249 
//  250 
// 
// 19 213 bytes in section .bss
//      1 byte  in section .data
//    120 bytes in section .rodata
//    208 bytes in section .text
// 
//    208 bytes of CODE  memory
//    120 bytes of CONST memory
// 19 214 bytes of DATA  memory
//
//Errors: none
//Warnings: none
