///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       06/Feb/2018  21:44:12
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\BatteryCheck.c
//    Command line =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\BatteryCheck.c
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
//    List file    =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\List\BatteryCheck.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN hw_ad_mid

        PUBLIC BatteryCheckInit
        PUBLIC BatteryCheckUpdate
        PUBLIC BatteryCheckVal

// D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\BatteryCheck.c
//    1 /******************************************************************************/
//    2 /*******************************************************************************
//    3   �ļ�������ؼ��BatteryCheck.c
//    4   ��  �ܣ���ص�ѹ���
//    5   ��  �ڣ�2015.07.14
//    6   ��  �ߣ�HJZ
//    7   ��  ע��
//    8 *******************************************************************************/
//    9 /******************************************************************************/
//   10 
//   11 #include "BatteryCheck.h"
//   12 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   13 uint16 BatteryCheckVal;   //��ص�ѹAD����ֵ
BatteryCheckVal:
        DS8 2
//   14 
//   15 //��ص�ѹ����ʼ��
//   16 //׼����һ�κ�������ϡ���ص�ѹ����Ҫ���˶��������Ƿ�ƽ�ȣ����Ҫ�����ֵ�Ƿ����Σ��ֵ��

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   17 uint8 BatteryCheckInit(void)
//   18 {
//   19   //ADC0_SE18   <->   PTE25
//   20   PORT_PCR_REG(PORTE_BASE_PTR, 25) |= (0|PORT_PCR_MUX(0));
BatteryCheckInit:
        LDR.N    R0,??DataTable1  ;; 0x4004d064
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable1  ;; 0x4004d064
        STR      R0,[R1, #+0]
//   21   
//   22   return 1;
        MOVS     R0,#+1
        BX       LR               ;; return
//   23 }
//   24 
//   25 
//   26 //��ص�ѹ����ֵ����
//   27 //׼����һ�κ�������ϡ���ص�ѹ����Ҫ���˶��������Ƿ�ƽ�ȣ����Ҫ�����ֵ�Ƿ����Σ��ֵ��

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   28 uint8 BatteryCheckUpdate(void)
//   29 {
BatteryCheckUpdate:
        PUSH     {R7,LR}
//   30   BatteryCheckVal = hw_ad_mid(0, 18, 16);
        MOVS     R2,#+16
        MOVS     R1,#+18
        MOVS     R0,#+0
        BL       hw_ad_mid
        LDR.N    R1,??DataTable1_1
        STRH     R0,[R1, #+0]
//   31   
//   32   BatteryCheckVal = 0 - BatteryCheckVal;
        LDR.N    R0,??DataTable1_1
        LDRH     R0,[R0, #+0]
        RSBS     R0,R0,#+0
        LDR.N    R1,??DataTable1_1
        STRH     R0,[R1, #+0]
//   33   
//   34   BatteryCheckVal = BatteryCheckVal / 1000;
        LDR.N    R0,??DataTable1_1
        LDRH     R0,[R0, #+0]
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable1_1
        STRH     R0,[R1, #+0]
//   35   
//   36   return 1;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//   37 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     0x4004d064

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     BatteryCheckVal

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
//  2 bytes in section .bss
// 66 bytes in section .text
// 
// 66 bytes of CODE memory
//  2 bytes of DATA memory
//
//Errors: none
//Warnings: none
