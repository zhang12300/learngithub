///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.10.1.12857/W32 for ARM      30/Aug/2018  15:16:09
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Component_C\wdog.c
//    Command line =  
//        -f C:\Users\Lenovo\AppData\Local\Temp\EWDF7A.tmp
//        (C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Component_C\wdog.c
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
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\bin\Ram\List\wdog.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC wdog_disable
        PUBLIC wdog_unlock

// C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Component_C\wdog.c
//    1 //-------------------------------------------------------------------------*
//    2 // 文件名: wdog.c                                                          *
//    3 // 说  明: 看门狗驱动程序文件                                              *
//    4 //-------------------------------------------------------------------------*
//    5 
//    6 #include "wdog.h"	//包含wdog.h头文件
//    7        
//    8 //-------------------------------------------------------------------------*
//    9 //函数名: wdog_disable                                                     *
//   10 //功  能: 关闭看门狗模块                                                   * 
//   11 //参  数: 无			  					   *	
//   12 //返  回: 无                                                               *
//   13 //说  明: 无                                                               *
//   14 //-------------------------------------------------------------------------*

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   15 void wdog_disable(void)
//   16 {
wdog_disable:
        PUSH     {R7,LR}
//   17     //给看门狗模块解锁，以便写寄存器
//   18     wdog_unlock();
        BL       wdog_unlock
//   19     //关闭看门狗
//   20     WDOG_STCTRLH &= ~WDOG_STCTRLH_WDOGEN_MASK;
        LDR.N    R0,??DataTable1  ;; 0x40052000
        LDRH     R1,[R0, #+0]
        MOVW     R0,#+65534
        ANDS     R1,R0,R1
        LDR.N    R0,??DataTable1  ;; 0x40052000
        STRH     R1,[R0, #+0]
//   21 }
        POP      {R0,PC}          ;; return
//   22 
//   23 //-------------------------------------------------------------------------*
//   24 //函数名: wdog_unlock                                                      *
//   25 //功  能: 看门狗解锁                                                       * 
//   26 //参  数: 无							           *	
//   27 //返  回: 无                                                               *
//   28 //说  明: 无                                                               *
//   29 //-------------------------------------------------------------------------*

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   30 void wdog_unlock(void)
//   31 {
//   32     /* 注意: 不要单步调试此程序!!! ，否则会引起CPU复位*/
//   33     //关总中断
//   34     DisableInterrupts;		
wdog_unlock:
        CPSID i
//   35     //写解锁寄存器
//   36     WDOG_UNLOCK = 0xC520;	
        MOVW     R0,#+50464
        LDR.N    R1,??DataTable1_1  ;; 0x4005200e
        STRH     R0,[R1, #+0]
//   37     //完成解锁
//   38     WDOG_UNLOCK = 0xD928;	
        MOVW     R0,#+55592
        LDR.N    R1,??DataTable1_1  ;; 0x4005200e
        STRH     R0,[R1, #+0]
//   39     //开总中断
//   40     EnableInterrupts;		
        CPSIE i
//   41 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     0x40052000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     0x4005200e

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 
// 52 bytes in section .text
// 
// 52 bytes of CODE memory
//
//Errors: none
//Warnings: none
