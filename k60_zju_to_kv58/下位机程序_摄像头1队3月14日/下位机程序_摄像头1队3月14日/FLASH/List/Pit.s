///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       06/Feb/2018  21:44:23
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Component_C\Pit.c
//    Command line =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Component_C\Pit.c
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
//    List file    =  D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\List\Pit.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN disable_irq
        EXTERN enable_irq

        PUBLIC disable_pit_interrupt
        PUBLIC enable_pit_interrupt
        PUBLIC pit_init

// D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Component_C\Pit.c
//    1 //�ļ����ƣ�Pit.c
//    2 //���ܸ�Ҫ��K60 pit�ײ����������ļ�
//    3 //��Ȩ���У�JYB
//    4 //�汾���£�2013-12-16  V1.0  ��ʼ�汾
//    5 //==============================================================================   
//    6 #include "Pit.h"
//    7 
//    8 /*==============================================================================
//    9   ���ڶ�ʱ��PIT˵����
//   10   �����ж϶�ʱ��ģ��PIT��һ��������������жϺʹ���DMAͨ���Ķ�ʱ��
//   11   ����PIT0~PIT3�ĸ�ͨ������Ӧ��IRQ�жϺ�Ϊ68~71
//   12   PITģ�����ð������¼Ĵ�����
//   13   1��PITģ����ƼĴ���PIT_MCR
//   14   2����ʱ������ֵ�Ĵ���PIT_LDVALn
//   15   3����ǰ��ʱ��ֵ�Ĵ���PIT_CVALn
//   16   4����ʱ�����ƼĴ���PIT_TCTRLn
//   17   5����ʱ����־�Ĵ���PIT_TFLGn
//   18 
//   19   ��Ҫʹ��PITģ�鹤����Ҫ�������¼����Ĵ���
//   20   1��SIM_SCGC6�����ſ�֮��
//   21   2��PIT_MCR��MDIS=0��ʹ��ģ��ʱ�ӣ������������������֮ǰʹ�ܣ�
//   22 
//   23   PITģ���ǲ��ü�����ʱ�ģ�����ֵ�洢�ڼĴ���PIT_CVALn�У�ÿ����ʱ���ݼ�������0��
//   24   ������һ�����崥����־λTIF��
//   25 
//   26   ������ڵ���ģʽ�½�ֹPITģ�飬��������PIT_MCR�е�FRZ=1������������У�������
//   27   ��ֹͣ��ʱ�����鿴ϵͳ��ǰ״̬��Ȼ�����������
//   28 
//   29   ��ʱ��ֵ�Ĵ���PIT_CVALn�е�ֵʱ������ʱ��ȡ��
//   30 
//   31   ���뿪����ʱ����ʼ��������������PIT_TCTRL�е�TEN=1
//   32 
//   33   ����PITģ���жϵ����ã���Ҫ�������������Ĵ���
//   34   1��PIT_TCTRL�е��ж�ʹ�ܱ�־λTIE=1
//   35   2��������Ӧ��IRQ�жϺŵ�ͨ���ж�
//   36   ��ʱ�����������������0����ᴥ������λ�жϱ�־λ�������жϡ����������жϷ���
//   37   �����������־λ�����㷽�������λд��1��
//   38 
//   39   PITģ���ʱ��Դ:periph_clk_khz
//   40                                                                    -----By JYB
//   41 ==============================================================================*/
//   42 
//   43 //==============================================================================
//   44 //��������: pit_init                                                         
//   45 //��������: ��                                          
//   46 //����˵��: pitno:��ʾpitͨ���š�  
//   47 //	        timeout:��ʾ��ʱ�����ʼ�ݼ���ֵ,��PIT����ʹ������ʱ��          
//   48 //���ܸ�Ҫ: ��ʼ��PIT        
//   49 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   50 void pit_init(uint8 pitno,uint32 timeout)
//   51 {
//   52   SIM_SCGC6 |= SIM_SCGC6_PIT_MASK;              //ʹ��PITʱ��
pit_init:
        LDR.N    R2,??DataTable2  ;; 0x4004803c
        LDR      R2,[R2, #+0]
        ORRS     R2,R2,#0x800000
        LDR.N    R3,??DataTable2  ;; 0x4004803c
        STR      R2,[R3, #+0]
//   53   PIT_MCR &= ~(PIT_MCR_MDIS_MASK);              //ʹ��PITģ��ʱ��
        LDR.N    R2,??DataTable2_1  ;; 0x40037000
        LDR      R2,[R2, #+0]
        BICS     R2,R2,#0x2
        LDR.N    R3,??DataTable2_1  ;; 0x40037000
        STR      R2,[R3, #+0]
//   54   PIT_MCR |= PIT_MCR_FRZ_MASK;                  //����ģʽ�½�ֹ
        LDR.N    R2,??DataTable2_1  ;; 0x40037000
        LDR      R2,[R2, #+0]
        ORRS     R2,R2,#0x1
        LDR.N    R3,??DataTable2_1  ;; 0x40037000
        STR      R2,[R3, #+0]
//   55   PIT_LDVAL(pitno) = timeout;                   //��������
        LDR.N    R2,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R3,R0,#+4
        STR      R1,[R3, R2]
//   56   PIT_TCTRL(pitno) |= PIT_TCTRL_TEN_MASK;       //ʹ��pitģ������
        LDR.N    R1,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R1,R0, LSL #+4
        LDR      R1,[R1, #+8]
        ORRS     R1,R1,#0x1
        LDR.N    R2,??DataTable2_2  ;; 0x40037100
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R2,R2,R0, LSL #+4
        STR      R1,[R2, #+8]
//   57   PIT_TCTRL(pitno) &= ~(PIT_TCTRL_TIE_MASK);    //��pit�ж�
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
//   61 //��������: enable_pit_interrupt                                                     
//   62 //��������: ��                                              
//   63 //����˵��: pitno: ��ʾpitͨ����      
//   64 //���ܸ�Ҫ: ����PIT��IRQ�ж�                                                                                                     
//   65 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   66 void enable_pit_interrupt(uint8 pitno)
//   67 {
enable_pit_interrupt:
        PUSH     {R7,LR}
//   68   PIT_TCTRL(pitno)|=(PIT_TCTRL_TIE_MASK); //��pit�ж�
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
//   72     enable_irq(68);			      //���������ŵ�IRQ�ж�
??enable_pit_interrupt_0:
        MOVS     R0,#+68
        BL       enable_irq
//   73     break;
        B.N      ??enable_pit_interrupt_4
//   74     case 1:
//   75     enable_irq(69);			      //���������ŵ�IRQ�ж�
??enable_pit_interrupt_2:
        MOVS     R0,#+69
        BL       enable_irq
//   76     break;
        B.N      ??enable_pit_interrupt_4
//   77     case 2:
//   78     enable_irq(70);			      //���������ŵ�IRQ�ж�
??enable_pit_interrupt_1:
        MOVS     R0,#+70
        BL       enable_irq
//   79     break;
        B.N      ??enable_pit_interrupt_4
//   80     case 3:
//   81     enable_irq(71);			      //���������ŵ�IRQ�ж�
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
//   87 //��������: disable_pit_interrupt                                                     
//   88 //��������: ��                                              
//   89 //����˵��: pitno: ��ʾpitͨ����      
//   90 //���ܸ�Ҫ: �ر�PIT��IRQ�ж�                                                                                               
//   91 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   92 void disable_pit_interrupt(uint8 pitno)
//   93 {
disable_pit_interrupt:
        PUSH     {R7,LR}
//   94   PIT_TCTRL(pitno)&=~(PIT_TCTRL_TIE_MASK);  //��pit�ж�
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
//   98     disable_irq(68);	        //�ؽ������ŵ�IRQ�ж�
??disable_pit_interrupt_0:
        MOVS     R0,#+68
        BL       disable_irq
//   99     break;
        B.N      ??disable_pit_interrupt_4
//  100     case 1:
//  101     disable_irq(69);		      //�ؽ������ŵ�IRQ�ж�
??disable_pit_interrupt_2:
        MOVS     R0,#+69
        BL       disable_irq
//  102     break;
        B.N      ??disable_pit_interrupt_4
//  103     case 2:
//  104     disable_irq(70);		      //�ؽ������ŵ�IRQ�ж�
??disable_pit_interrupt_1:
        MOVS     R0,#+70
        BL       disable_irq
//  105     break;
        B.N      ??disable_pit_interrupt_4
//  106     case 3:
//  107     disable_irq(71);		      //�ؽ������ŵ�IRQ�ж�
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
