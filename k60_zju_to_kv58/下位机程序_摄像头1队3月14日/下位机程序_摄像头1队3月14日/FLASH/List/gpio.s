///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       06/Feb/2018  21:44:18
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Component_C\gpio.c
//    Command line =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Component_C\gpio.c
//        -D IAR -D TWR_K60N512 -lCN
//        D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\List\ -lB
//        D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\List\ -o
//        D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\Obj\ --no_cse --no_unroll
//        --no_inline --no_code_motion --no_tbaa --no_clustering
//        --no_scheduling --debug --endian=little --cpu=Cortex-M4 -e --fpu=None
//        --dlib_config "C:\Program Files (x86)\IAR Systems\Embedded Workbench
//        7.0\arm\INC\c\DLib_Config_Normal.h" -I
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\H\ -I
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\H\Component_H\ -I
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\H\Frame_H\ -I
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\H\Function_H\ -I
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\H\SD_H\ -Ol
//        --use_c++_inline
//    List file    =  D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\List\gpio.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC gpio_ctrl
        PUBLIC gpio_init
        PUBLIC gpio_reverse

// D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Component_C\gpio.c
//    1 //-------------------------------------------------------------------------*
//    2 // �ļ���: gpio.c                                                          *
//    3 // ˵  ��: gpio���������ļ�                                                *
//    4 //-------------------------------------------------------------------------*
//    5 
//    6 #include "gpio.h"     //����gpioͷ�ļ�
//    7 
//    8 //-------------------------------------------------------------------------*
//    9 //������: gpio_init                                                        *
//   10 //��  ��: ��ʼ��gpio                                                       * 
//   11 //��  ��: port:�˿���                                                      *
//   12 //        index:ָ���˿�����                                               *
//   13 //        dir:���ŷ���,0=����,1=���                                       * 
//   14 //        data:��ʼ״̬,0=�͵�ƽ,1=�ߵ�ƽ                                  *
//   15 //��  ��: ��                                                               *
//   16 //˵  ��: ��                                                               *
//   17 //-------------------------------------------------------------------------*
//   18 //============================�����������ش��޸�============================

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
//   42 //=========================��ʱ���ش���ģ�ԭΪ=�����Ϊ|=��֮ǰһֱ�ڿ�  --HJZ
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
//   61 //������: gpio_ctrl                                                        *
//   62 //��  ��: ��������״̬                                                     *
//   63 //��  ��: port:�˿���                                                      *
//   64 //        index:ָ���˿�����                                               *
//   65 //        data: ״̬,0=�͵�ƽ,1=�ߵ�ƽ                                     *
//   66 //��  ��: ��                                                               *
//   67 //˵  ��: ��                                                               *
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
//   78 //������: gpio_reverse                                                   *
//   79 //��  ��: �ı�����״̬                                                   *
//   80 //��  ��: port:�˿���;                                                   *
//   81 //        index:ָ���˿�����                                             *
//   82 //��  ��: ��                                                             *
//   83 //˵  ��: ��                                                             *
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
