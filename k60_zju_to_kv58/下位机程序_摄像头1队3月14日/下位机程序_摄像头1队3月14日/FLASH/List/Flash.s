///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       06/Feb/2018  21:44:16
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\Flash.c
//    Command line =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\Flash.c
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
//    List file    =  D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\List\Flash.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC FlashEraseSector
        PUBLIC FlashInit
        PUBLIC FlashWrite

// D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\Flash.c
//    1 //==============================================================================
//    2 //�ļ����ƣ�Flash.c
//    3 //���ܸ�Ҫ��K60 Flash����/д��ײ���������Դ�ļ�
//    4 //==============================================================================
//    5 #include "Flash.h" 
//    6 
//    7 //=======================�ڲ����ú�������=======================================
//    8 //==============================================================================
//    9 //�������ƣ�hw_flash_sign_off
//   10 //�������أ���
//   11 //����˵������
//   12 //���ܸ�Ҫ������Flash�洢�����������FlashԤ��ȡ����
//   13 //==============================================================================
//   14 static void hw_flash_sign_off(void);
//   15 
//   16 //==============================================================================
//   17 //�������ƣ�hw_flash_cmd_launch
//   18 //�������أ�0-�ɹ� 1-ʧ��
//   19 //����˵������
//   20 //���ܸ�Ҫ������Flash����
//   21 //==============================================================================
//   22 static uint32 hw_flash_cmd_launch(void);
//   23 
//   24 //==============================================================================
//   25 
//   26 //=================�ⲿ�ӿں���=================================================
//   27 //==============================================================================
//   28 //�������ƣ�FlashInit
//   29 //�������أ���
//   30 //����˵������
//   31 //���ܸ�Ҫ����ʼ��Flashģ��
//   32 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   33 void FlashInit(void)
//   34 {
FlashInit:
        PUSH     {R7,LR}
//   35   //���FMC������
//   36   hw_flash_sign_off();
        BL       hw_flash_sign_off
//   37     
//   38   //��ֹ���Ź�
//   39   WDOG_UNLOCK = 0xC520;
        MOVW     R0,#+50464
        LDR.N    R1,??DataTable4  ;; 0x4005200e
        STRH     R0,[R1, #+0]
//   40   WDOG_UNLOCK = 0xD928;
        MOVW     R0,#+55592
        LDR.N    R1,??DataTable4  ;; 0x4005200e
        STRH     R0,[R1, #+0]
//   41   WDOG_STCTRLH = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_1  ;; 0x40052000
        STRH     R0,[R1, #+0]
//   42     
//   43   //�ȴ��������
//   44   while(!(FTFL_FSTAT & CCIF));
??FlashInit_0:
        LDR.N    R0,??DataTable4_2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??FlashInit_0
//   45     
//   46   //������ʳ����־λ
//   47   FTFL_FSTAT = ACCERR | FPVIOL;
        MOVS     R0,#+48
        LDR.N    R1,??DataTable4_2  ;; 0x40020000
        STRB     R0,[R1, #+0]
//   48 }
        POP      {R0,PC}          ;; return
//   49 
//   50 //==============================================================================
//   51 //�������ƣ�FlashEraseSector
//   52 //�������أ�����ִ��ִ��״̬��0=��������0=�쳣��
//   53 //����˵����sectorNo�������ţ�K60N512ʵ��ʹ��0~255��
//   54 //���ܸ�Ҫ������ָ��flash����
//   55 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   56 uint8 FlashEraseSector(uint16 sectorNo)
//   57 {
FlashEraseSector:
        PUSH     {R7,LR}
//   58   union
//   59   {
//   60     uint32  word;
//   61     uint8   byte[4];
//   62   }dest;
//   63     
//   64   dest.word = (uint32)(sectorNo*(1<<11));
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOV      R1,#+2048
        MULS     R0,R1,R0
        STR      R0,[SP, #+0]
//   65 
//   66   //���ò�������
//   67   FTFL_FCCOB0 = ERSSCR;   //lyx: ERSSCR: 0x09 ����Flash����
        MOVS     R0,#+9
        LDR.N    R1,??DataTable4_3  ;; 0x40020007
        STRB     R0,[R1, #+0]
//   68     
//   69   //����Ŀ���ַ
//   70   FTFL_FCCOB1 = dest.byte[2];
        LDRB     R0,[SP, #+2]
        LDR.N    R1,??DataTable4_4  ;; 0x40020006
        STRB     R0,[R1, #+0]
//   71   FTFL_FCCOB2 = dest.byte[1];
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable4_5  ;; 0x40020005
        STRB     R0,[R1, #+0]
//   72   FTFL_FCCOB3 = dest.byte[0];
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable4_6  ;; 0x40020004
        STRB     R0,[R1, #+0]
//   73     
//   74   //ִ����������
//   75   if(1 == hw_flash_cmd_launch())    //��ִ��������ִ���
        BL       hw_flash_cmd_launch
        CMP      R0,#+1
        BNE.N    ??FlashEraseSector_0
//   76     return 1;     //�����������
        MOVS     R0,#+1
        B.N      ??FlashEraseSector_1
//   77    
//   78   //������sector0ʱ��������豸
//   79   if(dest.word <= 0x800)
??FlashEraseSector_0:
        LDR      R0,[SP, #+0]
        CMP      R0,#+2048
        BHI.N    ??FlashEraseSector_2
//   80   {
//   81     //д��4�ֽ�
//   82     FTFL_FCCOB0 = PGM4; 
        MOVS     R0,#+6
        LDR.N    R1,??DataTable4_3  ;; 0x40020007
        STRB     R0,[R1, #+0]
//   83     //����Ŀ���ַ
//   84     FTFL_FCCOB1 = 0x00;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_4  ;; 0x40020006
        STRB     R0,[R1, #+0]
//   85     FTFL_FCCOB2 = 0x04;
        MOVS     R0,#+4
        LDR.N    R1,??DataTable4_5  ;; 0x40020005
        STRB     R0,[R1, #+0]
//   86     FTFL_FCCOB3 = 0x0C;
        MOVS     R0,#+12
        LDR.N    R1,??DataTable4_6  ;; 0x40020004
        STRB     R0,[R1, #+0]
//   87     //����
//   88     FTFL_FCCOB4 = 0xFF;
        MOVS     R0,#+255
        LDR.N    R1,??DataTable4_7  ;; 0x4002000b
        STRB     R0,[R1, #+0]
//   89     FTFL_FCCOB5 = 0xFF;
        MOVS     R0,#+255
        LDR.N    R1,??DataTable4_8  ;; 0x4002000a
        STRB     R0,[R1, #+0]
//   90     FTFL_FCCOB6 = 0xFF;
        MOVS     R0,#+255
        LDR.N    R1,??DataTable4_9  ;; 0x40020009
        STRB     R0,[R1, #+0]
//   91     FTFL_FCCOB7 = 0xFE;
        MOVS     R0,#+254
        LDR.N    R1,??DataTable4_10  ;; 0x40020008
        STRB     R0,[R1, #+0]
//   92     //ִ����������
//   93     if(1 == hw_flash_cmd_launch())  //��ִ��������ִ���
        BL       hw_flash_cmd_launch
        CMP      R0,#+1
        BNE.N    ??FlashEraseSector_2
//   94       return 2;   //�����������
        MOVS     R0,#+2
        B.N      ??FlashEraseSector_1
//   95     }  
//   96     
//   97     return 0;  //�ɹ�����
??FlashEraseSector_2:
        MOVS     R0,#+0
??FlashEraseSector_1:
        POP      {R1,PC}          ;; return
//   98 }
//   99 
//  100 //==============================================================================
//  101 //�������ƣ�FlashWrite
//  102 //�������أ�����ִ��״̬��0=��������0=�쳣��
//  103 //����˵����sectNo��Ŀ�������� ��K60N512ʵ��ʹ��0~255��
//  104 //          offset:д�������ڲ�ƫ�Ƶ�ַ��0~2043��
//  105 //          cnt��д���ֽ���Ŀ��0~2043��
//  106 //          buf��Դ���ݻ������׵�ַ
//  107 //���ܸ�Ҫ��flashд�����
//  108 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  109 uint8 FlashWrite(uint16 sectNo,uint16 offset,uint16 cnt,uint8 buf[])
//  110 {
FlashWrite:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R2
        MOVS     R5,R3
//  111   uint32 size;
//  112   uint32 destaddr;
//  113     
//  114   union
//  115   {
//  116     uint32   word;
//  117     uint8_t  byte[4];
//  118   }dest;
//  119     
//  120   if(offset%4 != 0)
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R2,#+4
        SDIV     R3,R1,R2
        MLS      R3,R3,R2,R1
        CMP      R3,#+0
        BEQ.N    ??FlashWrite_0
//  121     return 1;   //�����趨����ƫ����δ���루4�ֽڶ��룩
        MOVS     R0,#+1
        B.N      ??FlashWrite_1
//  122     
//  123   //����д������
//  124   FTFL_FCCOB0 = PGM4;
??FlashWrite_0:
        MOVS     R2,#+6
        LDR.N    R3,??DataTable4_3  ;; 0x40020007
        STRB     R2,[R3, #+0]
//  125   destaddr = (uint32)(sectNo*(1<<11) + offset);//�����ַ
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOV      R2,#+2048
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MLA      R0,R2,R0,R1
//  126   dest.word = destaddr;
        STR      R0,[SP, #+0]
//  127   for(size=0; size<cnt; size+=4, dest.word+=4, buf+=4)
        MOVS     R6,#+0
        B.N      ??FlashWrite_2
??FlashWrite_3:
        ADDS     R6,R6,#+4
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+4
        STR      R0,[SP, #+0]
        ADDS     R5,R5,#+4
??FlashWrite_2:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R6,R4
        BCS.N    ??FlashWrite_4
//  128   {
//  129     //����Ŀ���ַ
//  130     FTFL_FCCOB1 = dest.byte[2];
        LDRB     R0,[SP, #+2]
        LDR.N    R1,??DataTable4_4  ;; 0x40020006
        STRB     R0,[R1, #+0]
//  131     FTFL_FCCOB2 = dest.byte[1];
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??DataTable4_5  ;; 0x40020005
        STRB     R0,[R1, #+0]
//  132     FTFL_FCCOB3 = dest.byte[0];
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??DataTable4_6  ;; 0x40020004
        STRB     R0,[R1, #+0]
//  133  
//  134     //��������
//  135     FTFL_FCCOB4 = buf[3];
        LDRB     R0,[R5, #+3]
        LDR.N    R1,??DataTable4_7  ;; 0x4002000b
        STRB     R0,[R1, #+0]
//  136     FTFL_FCCOB5 = buf[2];
        LDRB     R0,[R5, #+2]
        LDR.N    R1,??DataTable4_8  ;; 0x4002000a
        STRB     R0,[R1, #+0]
//  137     FTFL_FCCOB6 = buf[1];
        LDRB     R0,[R5, #+1]
        LDR.N    R1,??DataTable4_9  ;; 0x40020009
        STRB     R0,[R1, #+0]
//  138     FTFL_FCCOB7 = buf[0];
        LDRB     R0,[R5, #+0]
        LDR.N    R1,??DataTable4_10  ;; 0x40020008
        STRB     R0,[R1, #+0]
//  139         
//  140     if(1 == hw_flash_cmd_launch()) 
        BL       hw_flash_cmd_launch
        CMP      R0,#+1
        BNE.N    ??FlashWrite_3
//  141       return 2;  //д���������
        MOVS     R0,#+2
        B.N      ??FlashWrite_1
//  142   }
//  143   return 0;  //�ɹ�ִ��
??FlashWrite_4:
        MOVS     R0,#+0
??FlashWrite_1:
        POP      {R1,R2,R4-R6,PC}  ;; return
//  144 }
//  145 
//  146 //========================�ڲ�����ʵ��==========================================
//  147 //==============================================================================
//  148 //�������ƣ�hw_flash_sign_off
//  149 //�������أ���
//  150 //����˵������
//  151 //���ܸ�Ҫ������Flash�洢�����������FlashԤ��ȡ����
//  152 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  153 void hw_flash_sign_off(void)
//  154 {  
//  155   //�������
//  156   FMC_PFB0CR |= FMC_PFB0CR_S_B_INV_MASK;
hw_flash_sign_off:
        LDR.N    R0,??DataTable4_11  ;; 0x4001f004
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80000
        LDR.N    R1,??DataTable4_11  ;; 0x4001f004
        STR      R0,[R1, #+0]
//  157   FMC_PFB1CR |= FMC_PFB0CR_S_B_INV_MASK;
        LDR.N    R0,??DataTable4_12  ;; 0x4001f008
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80000
        LDR.N    R1,??DataTable4_12  ;; 0x4001f008
        STR      R0,[R1, #+0]
//  158 }
        BX       LR               ;; return
//  159 
//  160 //==============================================================================
//  161 //�������ƣ�hw_flash_cmd_launch
//  162 //�������أ�0-�ɹ� 1-ʧ��
//  163 //����˵������
//  164 //���ܸ�Ҫ������Flash����
//  165 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  166 static uint32 hw_flash_cmd_launch(void)
//  167 {
//  168   //������ʴ����־λ�ͷǷ����ʱ�־λ
//  169   FTFL_FSTAT = ACCERR | FPVIOL;           //lyx: ACCERR:flash���ʴ����־λ
hw_flash_cmd_launch:
        MOVS     R0,#+48
        LDR.N    R1,??DataTable4_2  ;; 0x40020000
        STRB     R0,[R1, #+0]
//  170                                           //lyx: FPVIOL:flash�Ƿ����ʱ�����־λ
//  171   //��������
//  172   FTFL_FSTAT = CCIF;                      //lyx: CCIF:ָ������жϱ�־λ
        MOVS     R0,#+128
        LDR.N    R1,??DataTable4_2  ;; 0x40020000
        STRB     R0,[R1, #+0]
//  173 
//  174   //�ȴ��������
//  175   while(!(FTFL_FSTAT & CCIF));
??hw_flash_cmd_launch_0:
        LDR.N    R0,??DataTable4_2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??hw_flash_cmd_launch_0
//  176 
//  177   //�������־
//  178   if(FTFL_FSTAT & (ACCERR | FPVIOL | MGSTAT0))
        LDR.N    R0,??DataTable4_2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+49
        TST      R0,R1
        BEQ.N    ??hw_flash_cmd_launch_1
//  179     return 1 ; //ִ���������
        MOVS     R0,#+1
        B.N      ??hw_flash_cmd_launch_2
//  180   
//  181   return 0; //ִ������ɹ�
??hw_flash_cmd_launch_1:
        MOVS     R0,#+0
??hw_flash_cmd_launch_2:
        BX       LR               ;; return
//  182 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     0x4005200e

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x40052000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     0x40020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     0x40020007

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     0x40020006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     0x40020005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     0x40020004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_7:
        DC32     0x4002000b

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_8:
        DC32     0x4002000a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_9:
        DC32     0x40020009

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_10:
        DC32     0x40020008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_11:
        DC32     0x4001f004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_12:
        DC32     0x4001f008

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  183 //==============================================================================
//  184 
// 
// 418 bytes in section .text
// 
// 418 bytes of CODE memory
//
//Errors: none
//Warnings: none
