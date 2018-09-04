///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       06/Feb/2018  21:44:23
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Component_C\Pit.c
//    Command line =  
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Component_C\Pit.c
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
//    List file    =  D:\智能车\程序\下位机程序_摄像头1队\FLASH\List\Pit.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN disable_irq
        EXTERN enable_irq

        PUBLIC disable_pit_interrupt
        PUBLIC enable_pit_interrupt
        PUBLIC pit_init

// D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Component_C\Pit.c
//    1 //文件名称：Pit.c
//    2 //功能概要：K60 pit底层驱动程序文件
//    3 //版权所有：JYB
//    4 //版本更新：2013-12-16  V1.0  初始版本
//    5 //==============================================================================   
//    6 #include "Pit.h"
//    7 
//    8 /*==============================================================================
//    9   周期定时器PIT说明：
//   10   周期中断定时器模块PIT是一组可以用来产生中断和触发DMA通道的定时器
//   11   共有PIT0~PIT3四个通道，对应的IRQ中断号为68~71
//   12   PIT模块配置包括以下寄存器：
//   13   1、PIT模块控制寄存器PIT_MCR
//   14   2、定时器加载值寄存器PIT_LDVALn
//   15   3、当前定时器值寄存器PIT_CVALn
//   16   4、定时器控制寄存器PIT_TCTRLn
//   17   5、定时器标志寄存器PIT_TFLGn
//   18 
//   19   若要使能PIT模块工作，要设置以下几个寄存器
//   20   1、SIM_SCGC6开启门控之中
//   21   2、PIT_MCR的MDIS=0，使能模块时钟（必须在其他设置完成之前使能）
//   22 
//   23   PIT模块是采用减法计时的，加载值存储在寄存器PIT_CVALn中，每当定时器递减计数至0，
//   24   将产生一个脉冲触发标志位TIF。
//   25 
//   26   如果想在调试模式下禁止PIT模块，则需设置PIT_MCR中的FRZ=1。在软件开发中，允许开发
//   27   者停止计时器，查看系统当前状态，然后继续操作。
//   28 
//   29   定时器值寄存器PIT_CVALn中的值时可以随时读取的
//   30 
//   31   若想开启定时器开始计数，则需设置PIT_TCTRL中的TEN=1
//   32 
//   33   关于PIT模块中断的设置，需要考虑以下两个寄存器
//   34   1、PIT_TCTRL中的中断使能标志位TIE=1
//   35   2、开启相应的IRQ中断号的通道中断
//   36   此时，如果计数器计数到0，便会触发并置位中断标志位，进入中断。别忘了在中断服务
//   37   函数中清零标志位。清零方法是向该位写入1。
//   38 
//   39   PIT模块的时钟源:periph_clk_khz
//   40                                                                    -----By JYB
//   41 ==============================================================================*/
//   42 
//   43 //==============================================================================
//   44 //函数名称: pit_init                                                         
//   45 //函数返回: 无                                          
//   46 //参数说明: pitno:表示pit通道号。  
//   47 //	        timeout:表示定时溢出开始递减的值,该PIT计数使用总线时钟          
//   48 //功能概要: 初始化PIT        
//   49 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   50 void pit_init(uint8 pitno,uint32 timeout)
//   51 {
//   52   SIM_SCGC6 |= SIM_SCGC6_PIT_MASK;              //使能PIT时钟
pit_init:
        LDR.N    R2,??DataTable2  ;; 0x4004803c
        LDR      R2,[R2, #+0]
        ORRS     R2,R2,#0x800000
        LDR.N    R3,??DataTable2  ;; 0x4004803c
        STR      R2,[R3, #+0]
//   53   PIT_MCR &= ~(PIT_MCR_MDIS_MASK);              //使能PIT模块时钟
        LDR.N    R2,??DataTable2_1  ;; 0x40037000
        LDR      R2,[R2, #+0]
        BICS     R2,R2,#0x2
        LDR.N    R3,??DataTable2_1  ;; 0x40037000
        STR      R2,[R3, #+0]
//   54   PIT_MCR |= PIT_MCR_FRZ_MASK;                  //调试模式下禁止
        LDR.N    R2,??DataTable2_1  ;; 0x40037000
        LDR      R2,[R2, #+0]
        ORRS     R2,R2,#0x1
        LDR.N    R3,??DataTable2_1  ;; 0x40037000
        STR      R2,[R3, #+0]
//   55   PIT_LDVAL(pitno) = timeout;                   //设置周期
        LDR.N    R2,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R3,R0,#+4
        STR      R1,[R3, R2]
//   56   PIT_TCTRL(pitno) |= PIT_TCTRL_TEN_MASK;       //使能pit模块运行
        LDR.N    R1,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R1,R0, LSL #+4
        LDR      R1,[R1, #+8]
        ORRS     R1,R1,#0x1
        LDR.N    R2,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R2,R2,R0, LSL #+4
        STR      R1,[R2, #+8]
//   57   PIT_TCTRL(pitno) &= ~(PIT_TCTRL_TIE_MASK);    //关pit中断
        LDR.N    R1,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R1,R0, LSL #+4
        LDR      R1,[R1, #+8]
        BICS     R1,R1,#0x2
        LDR.N    R2,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R0,R2,R0, LSL #+4
        STR      R1,[R0, #+8]
//   58 }
        BX       LR               ;; return
//   59     
//   60 //==============================================================================
//   61 //函数名称: enable_pit_interrupt                                                     
//   62 //函数返回: 无                                              
//   63 //参数说明: pitno: 表示pit通道号      
//   64 //功能概要: 开启PIT的IRQ中断                                                                                                     
//   65 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   66 void enable_pit_interrupt(uint8 pitno)
//   67 {
enable_pit_interrupt:
        PUSH     {R7,LR}
//   68   PIT_TCTRL(pitno)|=(PIT_TCTRL_TIE_MASK); //开pit中断
        LDR.N    R1,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R1,R0, LSL #+4
        LDR      R1,[R1, #+8]
        ORRS     R1,R1,#0x2
        LDR.N    R2,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R2,R2,R0, LSL #+4
        STR      R1,[R2, #+8]
//   69   switch(pitno)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??enable_pit_interrupt_0
        CMP      R0,#+2
        BEQ.N    ??enable_pit_interrupt_1
        BCC.N    ??enable_pit_interrupt_2
        CMP      R0,#+3
        BEQ.N    ??enable_pit_interrupt_3
        B.N      ??enable_pit_interrupt_4
//   70   {
//   71     case 0:
//   72     enable_irq(68);			      //开接收引脚的IRQ中断
??enable_pit_interrupt_0:
        MOVS     R0,#+68
        BL       enable_irq
//   73     break;
        B.N      ??enable_pit_interrupt_4
//   74     case 1:
//   75     enable_irq(69);			      //开接收引脚的IRQ中断
??enable_pit_interrupt_2:
        MOVS     R0,#+69
        BL       enable_irq
//   76     break;
        B.N      ??enable_pit_interrupt_4
//   77     case 2:
//   78     enable_irq(70);			      //开接收引脚的IRQ中断
??enable_pit_interrupt_1:
        MOVS     R0,#+70
        BL       enable_irq
//   79     break;
        B.N      ??enable_pit_interrupt_4
//   80     case 3:
//   81     enable_irq(71);			      //开接收引脚的IRQ中断
??enable_pit_interrupt_3:
        MOVS     R0,#+71
        BL       enable_irq
//   82     break;
//   83   }
//   84 }
??enable_pit_interrupt_4:
        POP      {R0,PC}          ;; return
//   85 
//   86 //==============================================================================
//   87 //函数名称: disable_pit_interrupt                                                     
//   88 //函数返回: 无                                              
//   89 //参数说明: pitno: 表示pit通道号      
//   90 //功能概要: 关闭PIT的IRQ中断                                                                                               
//   91 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   92 void disable_pit_interrupt(uint8 pitno)
//   93 {
disable_pit_interrupt:
        PUSH     {R7,LR}
//   94   PIT_TCTRL(pitno)&=~(PIT_TCTRL_TIE_MASK);  //关pit中断
        LDR.N    R1,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R1,R0, LSL #+4
        LDR      R1,[R1, #+8]
        BICS     R1,R1,#0x2
        LDR.N    R2,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R2,R2,R0, LSL #+4
        STR      R1,[R2, #+8]
//   95   switch(pitno)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??disable_pit_interrupt_0
        CMP      R0,#+2
        BEQ.N    ??disable_pit_interrupt_1
        BCC.N    ??disable_pit_interrupt_2
        CMP      R0,#+3
        BEQ.N    ??disable_pit_interrupt_3
        B.N      ??disable_pit_interrupt_4
//   96   {
//   97     case 0:
//   98     disable_irq(68);	        //关接收引脚的IRQ中断
??disable_pit_interrupt_0:
        MOVS     R0,#+68
        BL       disable_irq
//   99     break;
        B.N      ??disable_pit_interrupt_4
//  100     case 1:
//  101     disable_irq(69);		      //关接收引脚的IRQ中断
??disable_pit_interrupt_2:
        MOVS     R0,#+69
        BL       disable_irq
//  102     break;
        B.N      ??disable_pit_interrupt_4
//  103     case 2:
//  104     disable_irq(70);		      //关接收引脚的IRQ中断
??disable_pit_interrupt_1:
        MOVS     R0,#+70
        BL       disable_irq
//  105     break;
        B.N      ??disable_pit_interrupt_4
//  106     case 3:
//  107     disable_irq(71);		      //关接收引脚的IRQ中断
??disable_pit_interrupt_3:
        MOVS     R0,#+71
        BL       disable_irq
//  108     break;
//  109   }
//  110 }
??disable_pit_interrupt_4:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     0x40037000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     0x40037100

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
// 258 bytes in section .text
// 
// 258 bytes of CODE memory
//
//Errors: none
//Warnings: none
