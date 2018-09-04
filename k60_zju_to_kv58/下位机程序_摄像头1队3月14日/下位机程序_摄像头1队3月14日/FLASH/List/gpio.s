///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       06/Feb/2018  21:44:18
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Component_C\gpio.c
//    Command line =  
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Component_C\gpio.c
//        -D IAR -D TWR_K60N512 -lCN
//        D:\智能车\程序\下位机程序_摄像头1队\FLASH\List\ -lB
//        D:\智能车\程序\下位机程序_摄像头1队\FLASH\List\ -o
//        D:\智能车\程序\下位机程序_摄像头1队\FLASH\Obj\ --no_cse --no_unroll
//        --no_inline --no_code_motion --no_tbaa --no_clustering
//        --no_scheduling --debug --endian=little --cpu=Cortex-M4 -e --fpu=None
//        --dlib_config "C:\Program Files (x86)\IAR Systems\Embedded Workbench
//        7.0\arm\INC\c\DLib_Config_Normal.h" -I
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\H\ -I
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\H\Component_H\ -I
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\H\Frame_H\ -I
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\H\Function_H\ -I
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\H\SD_H\ -Ol
//        --use_c++_inline
//    List file    =  D:\智能车\程序\下位机程序_摄像头1队\FLASH\List\gpio.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC gpio_ctrl
        PUBLIC gpio_init
        PUBLIC gpio_reverse

// D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Component_C\gpio.c
//    1 //-------------------------------------------------------------------------*
//    2 // 文件名: gpio.c                                                          *
//    3 // 说  明: gpio驱动程序文件                                                *
//    4 //-------------------------------------------------------------------------*
//    5 
//    6 #include "gpio.h"     //包含gpio头文件
//    7 
//    8 //-------------------------------------------------------------------------*
//    9 //函数名: gpio_init                                                        *
//   10 //功  能: 初始化gpio                                                       * 
//   11 //参  数: port:端口名                                                      *
//   12 //        index:指定端口引脚                                               *
//   13 //        dir:引脚方向,0=输入,1=输出                                       * 
//   14 //        data:初始状态,0=低电平,1=高电平                                  *
//   15 //返  回: 无                                                               *
//   16 //说  明: 无                                                               *
//   17 //-------------------------------------------------------------------------*
//   18 //============================本函数经过重大修改============================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   19 void gpio_init (GPIO_MemMapPtr port, int index, int dir,int data)
//   20 {
gpio_init:
        PUSH     {R4-R6}
//   21      PORT_MemMapPtr p;
//   22      switch((uint32)port)
        MOVS     R5,R0
        LDR.N    R6,??DataTable0  ;; 0x400ff000
        SUBS     R5,R5,R6
        BEQ.N    ??gpio_init_0
        SUBS     R5,R5,#+64
        BEQ.N    ??gpio_init_1
        SUBS     R5,R5,#+64
        BEQ.N    ??gpio_init_2
        SUBS     R5,R5,#+64
        BEQ.N    ??gpio_init_3
        SUBS     R5,R5,#+64
        BEQ.N    ??gpio_init_4
        B.N      ??gpio_init_5
//   23      {
//   24      case 0x400FF000u:
//   25          p = PORTA_BASE_PTR;
??gpio_init_0:
        LDR.N    R4,??DataTable0_1  ;; 0x40049000
//   26          break;
        B.N      ??gpio_init_6
//   27      case 0x400FF040u:
//   28          p = PORTB_BASE_PTR;
??gpio_init_1:
        LDR.N    R4,??DataTable0_2  ;; 0x4004a000
//   29          break;
        B.N      ??gpio_init_6
//   30      case 0x400FF080u:
//   31          p = PORTC_BASE_PTR;
??gpio_init_2:
        LDR.N    R4,??DataTable0_3  ;; 0x4004b000
//   32          break;
        B.N      ??gpio_init_6
//   33      case 0x400FF0C0u:
//   34          p = PORTD_BASE_PTR;
??gpio_init_3:
        LDR.N    R4,??DataTable0_4  ;; 0x4004c000
//   35          break;
        B.N      ??gpio_init_6
//   36      case 0x400FF100u:
//   37          p = PORTE_BASE_PTR;
??gpio_init_4:
        LDR.N    R4,??DataTable0_5  ;; 0x4004d000
//   38          break;
        B.N      ??gpio_init_6
//   39      default:
//   40          break;
//   41      }
//   42 //=========================此时有重大更改，原为=，后改为|=，之前一直在坑  --HJZ
//   43      PORT_PCR_REG(p,index) |= (0|PORT_PCR_MUX(1));   
??gpio_init_5:
??gpio_init_6:
        LDR      R5,[R4, R1, LSL #+2]
        ORRS     R5,R5,#0x100
        STR      R5,[R4, R1, LSL #+2]
//   44 
//   45 
//   46      if(dir == 1)//output
        CMP      R2,#+1
        BNE.N    ??gpio_init_7
//   47      {
//   48     	 GPIO_PDDR_REG(port) |= (1<<index);
        LDR      R2,[R0, #+20]
        MOVS     R4,#+1
        LSLS     R4,R4,R1
        ORRS     R2,R4,R2
        STR      R2,[R0, #+20]
//   49     	 if(data == 1)//output
        CMP      R3,#+1
        BNE.N    ??gpio_init_8
//   50 			  GPIO_PDOR_REG(port) |= (1<<index);
        LDR      R2,[R0, #+0]
        MOVS     R3,#+1
        LSLS     R1,R3,R1
        ORRS     R1,R1,R2
        STR      R1,[R0, #+0]
        B.N      ??gpio_init_9
//   51 		 else
//   52 			  GPIO_PDOR_REG(port) &= ~(1<<index);
??gpio_init_8:
        LDR      R2,[R0, #+0]
        MOVS     R3,#+1
        LSLS     R1,R3,R1
        BICS     R1,R2,R1
        STR      R1,[R0, #+0]
        B.N      ??gpio_init_9
//   53      }
//   54          
//   55      else
//   56          GPIO_PDDR_REG(port) &= ~(1<<index);
??gpio_init_7:
        LDR      R2,[R0, #+20]
        MOVS     R3,#+1
        LSLS     R1,R3,R1
        BICS     R1,R2,R1
        STR      R1,[R0, #+20]
//   57 
//   58 }
??gpio_init_9:
        POP      {R4-R6}
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC32     0x400ff000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_1:
        DC32     0x40049000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_2:
        DC32     0x4004a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_3:
        DC32     0x4004b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_4:
        DC32     0x4004c000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_5:
        DC32     0x4004d000
//   59 
//   60 //-------------------------------------------------------------------------* 
//   61 //函数名: gpio_ctrl                                                        *
//   62 //功  能: 设置引脚状态                                                     *
//   63 //参  数: port:端口名                                                      *
//   64 //        index:指定端口引脚                                               *
//   65 //        data: 状态,0=低电平,1=高电平                                     *
//   66 //返  回: 无                                                               *
//   67 //说  明: 无                                                               *
//   68 //-------------------------------------------------------------------------*

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   69 void gpio_ctrl (GPIO_MemMapPtr port, int index, int data)
//   70 {
//   71     if(data == 1)//output
gpio_ctrl:
        CMP      R2,#+1
        BNE.N    ??gpio_ctrl_0
//   72          GPIO_PDOR_REG(port) |= (1<<index);
        LDR      R2,[R0, #+0]
        MOVS     R3,#+1
        LSLS     R1,R3,R1
        ORRS     R1,R1,R2
        STR      R1,[R0, #+0]
        B.N      ??gpio_ctrl_1
//   73     else
//   74          GPIO_PDOR_REG(port) &= ~(1<<index);
??gpio_ctrl_0:
        LDR      R2,[R0, #+0]
        MOVS     R3,#+1
        LSLS     R1,R3,R1
        BICS     R1,R2,R1
        STR      R1,[R0, #+0]
//   75 }
??gpio_ctrl_1:
        BX       LR               ;; return
//   76 
//   77 //-----------------------------------------------------------------------* 
//   78 //函数名: gpio_reverse                                                   *
//   79 //功  能: 改变引脚状态                                                   *
//   80 //参  数: port:端口名;                                                   *
//   81 //        index:指定端口引脚                                             *
//   82 //返  回: 无                                                             *
//   83 //说  明: 无                                                             *
//   84 //-----------------------------------------------------------------------*

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   85 void gpio_reverse (GPIO_MemMapPtr port, int index)
//   86 {
//   87     GPIO_PDOR_REG(port) ^= (1<<index);
gpio_reverse:
        LDR      R2,[R0, #+0]
        MOVS     R3,#+1
        LSLS     R1,R3,R1
        EORS     R1,R1,R2
        STR      R1,[R0, #+0]
//   88 }
        BX       LR               ;; return

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 
// 198 bytes in section .text
// 
// 198 bytes of CODE memory
//
//Errors: none
//Warnings: none
