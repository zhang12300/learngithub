///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       06/Feb/2018  21:44:24
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\SCCB.c
//    Command line =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\SCCB.c
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
//    List file    =  D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\List\SCCB.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC SCCBAck
        PUBLIC SCCBDelay
        PUBLIC SCCBNoAck
        PUBLIC SCCBPortInit
        PUBLIC SCCBReadByte
        PUBLIC SCCBReadByteOne
        PUBLIC SCCBReceiveByte
        PUBLIC SCCBSendByte
        PUBLIC SCCBStart
        PUBLIC SCCBStop
        PUBLIC SCCBWaitAck
        PUBLIC SCCBWriteByte
        PUBLIC SCCBWriteByteOne
        PUBLIC SCLClear
        PUBLIC SCLIn
        PUBLIC SCLOut
        PUBLIC SCLSet
        PUBLIC SDAClear
        PUBLIC SDAIn
        PUBLIC SDAOut
        PUBLIC SDARead
        PUBLIC SDASet

// D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\SCCB.c
//    1 /******************************************************************************/
//    2 /*******************************************************************************
//    3   �ļ�����SCCBͨ�ŵײ���ļ�SCCB.c
//    4   ��  �ܣ�SCCBͨ��
//    5   ��  �ڣ�2014.10.10
//    6   ��  �ߣ�LYX
//    7   ��  ע��
//    8 *******************************************************************************/
//    9 /******************************************************************************/
//   10 
//   11 #include "SCCB.h"
//   12 
//   13 
//   14 //��SDA�����ϵ�ֵ

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   15 uint8 SDARead(void)
//   16 {     //�˴��ж��죬ԭ������uint8��ǿ��ת��uint32, ���������8λʱ�� ����ȥ�Ĳ��ǡ��桱��1��������һ�����롣 
//   17       uint32 Temp;
//   18       Temp = (GPIO_PDIR_REG(SDAPT_BASE_PTR) & (1 << SDAPIN) );
SDARead:
        LDR.N    R0,??DataTable9  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        ANDS     R0,R0,#0x2000000
//   19       if(Temp)
        CMP      R0,#+0
        BEQ.N    ??SDARead_0
//   20         return 1;
        MOVS     R0,#+1
        B.N      ??SDARead_1
//   21       else 
//   22         return 0;
??SDARead_0:
        MOVS     R0,#+0
??SDARead_1:
        BX       LR               ;; return
//   23     //�����Ĵ���
//   24     //return (uint8)(GPIO_PDIR_REG(SDAPT_BASE_PTR) & (1 << SDAPIN));
//   25     //return Temp;  
//   26 }
//   27 
//   28 
//   29 //SCL����GPIO��������Ϊ����

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   30 void SCLIn(void)
//   31 {
//   32     GPIO_PDDR_REG(SCLPT_BASE_PTR) &= ~(1 << SCLPIN);
SCLIn:
        LDR.N    R0,??DataTable9_1  ;; 0x400ff014
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4000000
        LDR.N    R1,??DataTable9_1  ;; 0x400ff014
        STR      R0,[R1, #+0]
//   33 }
        BX       LR               ;; return
//   34 
//   35 
//   36 //SCL����GPIO��������Ϊ���

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   37 void SCLOut(void)
//   38 {
//   39     GPIO_PDDR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
SCLOut:
        LDR.N    R0,??DataTable9_1  ;; 0x400ff014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4000000
        LDR.N    R1,??DataTable9_1  ;; 0x400ff014
        STR      R0,[R1, #+0]
//   40 }
        BX       LR               ;; return
//   41 
//   42 
//   43 //SCL��������͵�ƽ

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   44 void SCLClear(void)
//   45 {
//   46     GPIO_PDOR_REG(SCLPT_BASE_PTR) &= ~(1 << SCLPIN);
SCLClear:
        LDR.N    R0,??DataTable9_2  ;; 0x400ff000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4000000
        LDR.N    R1,??DataTable9_2  ;; 0x400ff000
        STR      R0,[R1, #+0]
//   47 }
        BX       LR               ;; return
//   48 
//   49 
//   50 //SCL��������ߵ�ƽ

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   51 void SCLSet(void)
//   52 {
//   53     GPIO_PDOR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
SCLSet:
        LDR.N    R0,??DataTable9_2  ;; 0x400ff000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4000000
        LDR.N    R1,??DataTable9_2  ;; 0x400ff000
        STR      R0,[R1, #+0]
//   54 }
        BX       LR               ;; return
//   55 
//   56 
//   57 //SDA����GPIO��������Ϊ����

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   58 void SDAIn(void)
//   59 {
//   60     GPIO_PDDR_REG(SDAPT_BASE_PTR) &= ~(1 << SDAPIN);
SDAIn:
        LDR.N    R0,??DataTable9_1  ;; 0x400ff014
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x2000000
        LDR.N    R1,??DataTable9_1  ;; 0x400ff014
        STR      R0,[R1, #+0]
//   61 }
        BX       LR               ;; return
//   62 
//   63 
//   64 //SDA����GPIO��������Ϊ���

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   65 void SDAOut(void)
//   66 {
//   67     GPIO_PDDR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
SDAOut:
        LDR.N    R0,??DataTable9_1  ;; 0x400ff014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000000
        LDR.N    R1,??DataTable9_1  ;; 0x400ff014
        STR      R0,[R1, #+0]
//   68 }
        BX       LR               ;; return
//   69 
//   70 
//   71 //SDA��������͵�ƽ

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   72 void SDAClear(void)
//   73 {
//   74     GPIO_PDOR_REG(SDAPT_BASE_PTR) &= ~(1 << SDAPIN);
SDAClear:
        LDR.N    R0,??DataTable9_2  ;; 0x400ff000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x2000000
        LDR.N    R1,??DataTable9_2  ;; 0x400ff000
        STR      R0,[R1, #+0]
//   75 }
        BX       LR               ;; return
//   76 
//   77 
//   78 //SDA��������ߵ�ƽ

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   79 void SDASet(void)
//   80 {
//   81     GPIO_PDOR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
SDASet:
        LDR.N    R0,??DataTable9_2  ;; 0x400ff000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000000
        LDR.N    R1,??DataTable9_2  ;; 0x400ff000
        STR      R0,[R1, #+0]
//   82 }
        BX       LR               ;; return
//   83 
//   84 
//   85 //SCCB��ʱ����������������ǿ���SCCB�ź�Ƶ�ʵĹؼ������ǲ�֪������ԭ��

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   86 void SCCBDelay(volatile uint16 time)
//   87 {
SCCBDelay:
        PUSH     {R0}
        B.N      ??SCCBDelay_0
//   88     while(time)
//   89     {
//   90         time--;  
??SCCBDelay_1:
        LDRH     R0,[SP, #+0]
        SUBS     R0,R0,#+1
        STRH     R0,[SP, #+0]
//   91     }
??SCCBDelay_0:
        LDRH     R0,[SP, #+0]
        CMP      R0,#+0
        BNE.N    ??SCCBDelay_1
//   92 }
        ADD      SP,SP,#+4
        BX       LR               ;; return
//   93 
//   94 //SCCB���ų�ʼ������

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   95 void SCCBPortInit(void)
//   96 {
//   97     //�������ž�����ΪGPIO�������ʼֵΪ1��©����·����������
//   98     PORT_PCR_REG(SCLPORT_BASE_PTR, SCLPIN) |= (
//   99                                     PORT_PCR_MUX(0x01) 
//  100                                   | PORT_PCR_PE_MASK 
//  101                                   | PORT_PCR_ODE_MASK
//  102                                   );
SCCBPortInit:
        LDR.N    R0,??DataTable9_3  ;; 0x40049068
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x122
        LDR.N    R1,??DataTable9_3  ;; 0x40049068
        STR      R0,[R1, #+0]
//  103     PORT_PCR_REG(SDAPORT_BASE_PTR, SDAPIN) |= (
//  104                                     PORT_PCR_MUX(0x01) 
//  105                                   | PORT_PCR_PE_MASK 
//  106                                   | PORT_PCR_ODE_MASK
//  107                                   );
        LDR.N    R0,??DataTable9_4  ;; 0x40049064
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x122
        LDR.N    R1,??DataTable9_4  ;; 0x40049064
        STR      R0,[R1, #+0]
//  108     //SCLĬ��ΪGPIO���
//  109     GPIO_PDDR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
        LDR.N    R0,??DataTable9_1  ;; 0x400ff014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4000000
        LDR.N    R1,??DataTable9_1  ;; 0x400ff014
        STR      R0,[R1, #+0]
//  110     //SCLĬ�����Ϊ�ߵ�ƽ
//  111     GPIO_PDOR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
        LDR.N    R0,??DataTable9_2  ;; 0x400ff000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4000000
        LDR.N    R1,??DataTable9_2  ;; 0x400ff000
        STR      R0,[R1, #+0]
//  112     //SDAĬ��ΪGPIO���
//  113     GPIO_PDDR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
        LDR.N    R0,??DataTable9_1  ;; 0x400ff014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000000
        LDR.N    R1,??DataTable9_1  ;; 0x400ff014
        STR      R0,[R1, #+0]
//  114     //SDAĬ�����Ϊ�ߵ�ƽ
//  115     GPIO_PDOR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
        LDR.N    R0,??DataTable9_2  ;; 0x400ff000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000000
        LDR.N    R1,??DataTable9_2  ;; 0x400ff000
        STR      R0,[R1, #+0]
//  116 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC32     0x400ff010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_1:
        DC32     0x400ff014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_2:
        DC32     0x400ff000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     0x40049068

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     0x40049064
//  117 
//  118 
//  119 
//  120 
//  121 //=======================Ұ���SCCB��======================================
//  122 
//  123 
//  124 //SCCB��ʼ�źź���

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  125 uint8 SCCBStart(void)
//  126 {      
SCCBStart:
        PUSH     {R7,LR}
//  127     uint8 temp1;
//  128     SDASet();    //SDA_H();
        BL       SDASet
//  129     SCLSet();    //SCL_H();
        BL       SCLSet
//  130     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  131 
//  132     
//  133     SDAIn();     //SDA_DDR_IN();
        BL       SDAIn
//  134     temp1 = SDARead();
        BL       SDARead
//  135     if(!temp1) // SDA_IN()
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??SCCBStart_0
//  136     {
//  137         SDAOut();  //SDA_DDR_OUT();
        BL       SDAOut
//  138         return 0;   // SDA��Ϊ�͵�ƽ������æ,�˳� 
        MOVS     R0,#+0
        B.N      ??SCCBStart_1
//  139     }
//  140     SDAOut();     //SDA_DDR_OUT();
??SCCBStart_0:
        BL       SDAOut
//  141     
//  142     
//  143     
//  144     
//  145     SDAClear();  //SDA_L();
        BL       SDAClear
//  146 
//  147     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  148     SCLClear();  //SCL_L();
        BL       SCLClear
//  149 
//  150     if(SDARead())      //SDA_IN()
        BL       SDARead
        CMP      R0,#+0
        BEQ.N    ??SCCBStart_2
//  151     {
//  152         SDAOut();    //SDA_DDR_OUT();
        BL       SDAOut
//  153         return 0;   // SDA��Ϊ�ߵ�ƽ�����߳���,�˳� 
        MOVS     R0,#+0
        B.N      ??SCCBStart_1
//  154     }
//  155     
//  156   
//  157     //SDA_DDR_OUT();
//  158     //SDA_L();
//  159     //SCCB_delay();
//  160     return 1;
??SCCBStart_2:
        MOVS     R0,#+1
??SCCBStart_1:
        POP      {R1,PC}          ;; return
//  161 }
//  162           
//  163           
//  164 //SCCBֹͣ�źź���

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  165 void SCCBStop(void)
//  166 {
SCCBStop:
        PUSH     {R7,LR}
//  167     SCLClear();  //SCL_L();
        BL       SCLClear
//  168     //SCCB_DELAY();
//  169     SDAClear(); //SDA_L();
        BL       SDAClear
//  170     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  171     SCLSet();   //SCL_H();
        BL       SCLSet
//  172     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  173     SDASet();  //SDA_H();
        BL       SDASet
//  174     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  175 }
        POP      {R0,PC}          ;; return
//  176           
//  177     
//  178 //SCCBӦ���źź���

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  179 void SCCBAck(void)
//  180 {
SCCBAck:
        PUSH     {R7,LR}
//  181     SCLClear();     //SCL_L();
        BL       SCLClear
//  182     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  183     SDAClear();     //SDA_L();
        BL       SDAClear
//  184     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  185     SCLSet();       //SCL_H();
        BL       SCLSet
//  186     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  187     SCLClear();     //SCL_L();
        BL       SCLClear
//  188     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  189 }
        POP      {R0,PC}          ;; return
//  190 
//  191           
//  192 //SCCB��Ӧ���źź���

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  193 void SCCBNoAck(void)
//  194 {
SCCBNoAck:
        PUSH     {R7,LR}
//  195     SCLClear();     //SCL_L();
        BL       SCLClear
//  196     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  197     SDASet();       //SDA_H();
        BL       SDASet
//  198     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  199     SCLSet();       //SCL_H();
        BL       SCLSet
//  200     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  201     SCLClear();     //SCL_L();
        BL       SCLClear
//  202     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  203   
//  204 }
        POP      {R0,PC}          ;; return
//  205           
//  206           
//  207 //SCCB�ȴ�Ӧ����
//  208 //0��ʾ��Ӧ��1��ʾ��Ӧ��

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  209 uint8 SCCBWaitAck(void)
//  210 {
SCCBWaitAck:
        PUSH     {R7,LR}
//  211     SCLClear();        //SCL_L();
        BL       SCLClear
//  212     //SDA_H();  //===========================���������£�Ұ���û��д��DEMOK��д��������û�б�Ҫ
//  213     SDAIn();          //SDA_DDR_IN();
        BL       SDAIn
//  214 
//  215     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  216     SCLSet();          //SCL_H();
        BL       SCLSet
//  217 
//  218     SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  219 
//  220     if(SDARead())      //SDA_IN()     //Ӧ��Ϊ�ߵ�ƽ���쳣��ͨ��ʧ��
        BL       SDARead
        CMP      R0,#+0
        BEQ.N    ??SCCBWaitAck_0
//  221     {
//  222         SDAOut();      //SDA_DDR_OUT();
        BL       SDAOut
//  223         SCLClear();    //SCL_L();
        BL       SCLClear
//  224         return 0;
        MOVS     R0,#+0
        B.N      ??SCCBWaitAck_1
//  225     }
//  226     SDAOut();          //SDA_DDR_OUT();
??SCCBWaitAck_0:
        BL       SDAOut
//  227 
//  228     SCLClear();        //SCL_L();
        BL       SCLClear
//  229     return 1;  
        MOVS     R0,#+1
??SCCBWaitAck_1:
        POP      {R1,PC}          ;; return
//  230 }
//  231 
//  232 
//  233 //SCCB�������ݺ��� 
//  234 //SendByte Ϊ��Ҫ���͵�����

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  235 void SCCBSendByte(uint8 SendByte)
//  236 {
SCCBSendByte:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  237     uint8 i = 8;
        MOVS     R5,#+8
        B.N      ??SCCBSendByte_0
//  238     while(i--)
//  239     {
//  240 
//  241         if(SendByte & 0x80)     //SDA �������
//  242         {
//  243             SDASet();           //SDA_H();
//  244         }
//  245         else
//  246         {
//  247             SDAClear();         //SDA_L();
??SCCBSendByte_1:
        BL       SDAClear
//  248         }
//  249         SendByte <<= 1;
??SCCBSendByte_2:
        LSLS     R4,R4,#+1
//  250         SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  251         SCLSet();               //SCL_H();                //SCL ���ߣ��ɼ��ź�
        BL       SCLSet
//  252         SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  253         SCLClear();             //SCL_L();                //SCL ʱ��������
        BL       SCLClear
??SCCBSendByte_0:
        MOVS     R0,R5
        SUBS     R5,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??SCCBSendByte_3
        LSLS     R0,R4,#+24
        BPL.N    ??SCCBSendByte_1
        BL       SDASet
        B.N      ??SCCBSendByte_2
//  254         //SCCB_DELAY();
//  255     }
//  256     //SCL_L();    
//  257 }
??SCCBSendByte_3:
        POP      {R0,R4,R5,PC}    ;; return
//  258           
//  259 //дһ�ֽ�����1�εĺ���
//  260 // ����  ��- WriteAddress: ��д���ַ    - SendByte: ��д������  - DeviceAddress: ��������
//  261 // ���  ������Ϊ:=1�ɹ�д��,=0ʧ��

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  262 uint8 SCCBWriteByteOne(uint8 WriteAddress, uint8 SendByte)
//  263 {
SCCBWriteByteOne:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  264     if(!SCCBStart())
        BL       SCCBStart
        CMP      R0,#+0
        BNE.N    ??SCCBWriteByteOne_0
//  265     {
//  266         return 0;
        MOVS     R0,#+0
        B.N      ??SCCBWriteByteOne_1
//  267     }
//  268     SCCBSendByte(ADDR_OV7725);                    // ������ַ
??SCCBWriteByteOne_0:
        MOVS     R0,#+66
        BL       SCCBSendByte
//  269     if( !SCCBWaitAck() )
        BL       SCCBWaitAck
        CMP      R0,#+0
        BNE.N    ??SCCBWriteByteOne_2
//  270     {
//  271         SCCBStop();
        BL       SCCBStop
//  272         return 0;
        MOVS     R0,#+0
        B.N      ??SCCBWriteByteOne_1
//  273     }
//  274     SCCBSendByte(WriteAddress);   // ���õ���ʼ��ַ 
??SCCBWriteByteOne_2:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       SCCBSendByte
//  275     SCCBWaitAck();
        BL       SCCBWaitAck
//  276     SCCBSendByte(SendByte);
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       SCCBSendByte
//  277     SCCBWaitAck();
        BL       SCCBWaitAck
//  278     SCCBStop();
        BL       SCCBStop
//  279     return 1;  
        MOVS     R0,#+1
??SCCBWriteByteOne_1:
        POP      {R1,R4,R5,PC}    ;; return
//  280 }
//  281 
//  282 //дһ�ֽ����ݶ�Σ���extern�ĺ���
//  283 // ����  ��- WriteAddress: ��д���ַ    - SendByte: ��д������  - DeviceAddress: ��������
//  284 // ���  ������Ϊ:=1�ɹ�д��,=0ʧ��
//  285 //���ǵ���sccb�Ĺܽ�ģ�⣬�Ƚ�����ʧ�ܣ���˶��Լ���               

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  286 uint8 SCCBWriteByte(uint8 WriteAddress , uint8 SendByte)            
//  287 {
SCCBWriteByte:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  288     uint8 i = 0;
        MOVS     R6,#+0
//  289     while( 0 == SCCBWriteByteOne ( WriteAddress, SendByte ) )
??SCCBWriteByte_0:
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       SCCBWriteByteOne
        CMP      R0,#+0
        BNE.N    ??SCCBWriteByte_1
//  290     {
//  291         i++;
        ADDS     R6,R6,#+1
//  292         if(i == 20)
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+20
        BNE.N    ??SCCBWriteByte_0
//  293         {
//  294             return 0 ;
        MOVS     R0,#+0
        B.N      ??SCCBWriteByte_2
//  295         }
//  296     }
//  297     return 1;    
??SCCBWriteByte_1:
        MOVS     R0,#+1
??SCCBWriteByte_2:
        POP      {R4-R6,PC}       ;; return
//  298 }
//  299 
//  300 
//  301 //����SCCB�������ݵĺ���
//  302 //���ز��������յ�������

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  303 uint8 SCCBReceiveByte(void)
//  304 {
SCCBReceiveByte:
        PUSH     {R3-R5,LR}
//  305     uint8 i = 8;
        MOVS     R4,#+8
//  306     uint8 ReceiveByte = 0;
        MOVS     R5,#+0
//  307 
//  308     //SDA_H();
//  309     //SCCB_DELAY();
//  310     SDAIn();              //SDA_DDR_IN();
        BL       SDAIn
        B.N      ??SCCBReceiveByte_0
//  311 
//  312     while(i--)
//  313     {
//  314         ReceiveByte <<= 1;
??SCCBReceiveByte_1:
        LSLS     R5,R5,#+1
//  315         SCLClear();          //SCL_L();
        BL       SCLClear
//  316         SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  317         SCLSet();            //SCL_H();
        BL       SCLSet
//  318         SCCB_DELAY();
        MOV      R0,#+600
        BL       SCCBDelay
//  319 
//  320         if(SDARead())         //SDA_IN()
        BL       SDARead
        CMP      R0,#+0
        BEQ.N    ??SCCBReceiveByte_0
//  321         {
//  322             ReceiveByte |= 0x01;
        ORRS     R5,R5,#0x1
//  323         }
//  324     }
??SCCBReceiveByte_0:
        MOVS     R0,R4
        SUBS     R4,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??SCCBReceiveByte_1
//  325     SDAOut();                 //SDA_DDR_OUT();
        BL       SDAOut
//  326     SCLClear();               //SCL_L();
        BL       SCLClear
//  327     return ReceiveByte;  
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
//  328 }
//  329           
//  330 // ��������SCCB_ReadByte
//  331 // ����  ����ȡһ������1��
//  332 // ����  ��- pBuffer: ��Ŷ�������  - length: ����������    - ReadAddress: ��������ַ        - DeviceAddress: ��������
//  333 // ���  ������Ϊ:=1�ɹ�����,=0ʧ��         

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  334 uint8 SCCBReadByteOne(uint8 *pBuffer, uint16 length, uint8 ReadAddress)
//  335 {
SCCBReadByteOne:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  336     if(!SCCBStart())
        BL       SCCBStart
        CMP      R0,#+0
        BNE.N    ??SCCBReadByteOne_0
//  337     {
//  338         return 0;
        MOVS     R0,#+0
        B.N      ??SCCBReadByteOne_1
//  339     }
//  340     SCCBSendByte( ADDR_OV7725 );         // ������ַ 
??SCCBReadByteOne_0:
        MOVS     R0,#+66
        BL       SCCBSendByte
//  341     if( !SCCBWaitAck() )
        BL       SCCBWaitAck
        CMP      R0,#+0
        BNE.N    ??SCCBReadByteOne_2
//  342     {
//  343         SCCBStop();
        BL       SCCBStop
//  344         return 0;
        MOVS     R0,#+0
        B.N      ??SCCBReadByteOne_1
//  345     }
//  346     SCCBSendByte( ReadAddress );           // ���õ���ʼ��ַ 
??SCCBReadByteOne_2:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       SCCBSendByte
//  347     SCCBWaitAck();
        BL       SCCBWaitAck
//  348     SCCBStop();
        BL       SCCBStop
//  349 
//  350     if(!SCCBStart())
        BL       SCCBStart
        CMP      R0,#+0
        BNE.N    ??SCCBReadByteOne_3
//  351     {
//  352         return 0;
        MOVS     R0,#+0
        B.N      ??SCCBReadByteOne_1
//  353     }
//  354     SCCBSendByte( ADDR_OV7725 + 1 );               // ������ַ 
??SCCBReadByteOne_3:
        MOVS     R0,#+67
        BL       SCCBSendByte
//  355 
//  356     if(!SCCBWaitAck())
        BL       SCCBWaitAck
        CMP      R0,#+0
        BNE.N    ??SCCBReadByteOne_4
//  357     {
//  358         SCCBStop();
        BL       SCCBStop
//  359         return 0;
        MOVS     R0,#+0
        B.N      ??SCCBReadByteOne_1
//  360     }
//  361     while(length)
//  362     {
//  363         *pBuffer = SCCBReceiveByte();    
//  364         if(length == 1)
//  365         {
//  366             SCCBNoAck();
//  367         }
//  368         else
//  369         {
//  370             SCCBAck();
??SCCBReadByteOne_5:
        BL       SCCBAck
//  371         }
//  372         pBuffer++;
??SCCBReadByteOne_6:
        ADDS     R4,R4,#+1
//  373         length--;
        SUBS     R5,R5,#+1
??SCCBReadByteOne_4:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+0
        BEQ.N    ??SCCBReadByteOne_7
        BL       SCCBReceiveByte
        STRB     R0,[R4, #+0]
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+1
        BNE.N    ??SCCBReadByteOne_5
        BL       SCCBNoAck
        B.N      ??SCCBReadByteOne_6
//  374     }
//  375     SCCBStop();
??SCCBReadByteOne_7:
        BL       SCCBStop
//  376     return 1;   
        MOVS     R0,#+1
??SCCBReadByteOne_1:
        POP      {R4-R6,PC}       ;; return
//  377 }
//  378 
//  379 
//  380 // ��������SCCB_ReadByte
//  381 // ����  ����ȡһ�����ݶ�Σ� ����extern�ĺ���
//  382 // ����  ��- pBuffer: ��Ŷ�������  - length: ����������    - ReadAddress: ��������ַ        - DeviceAddress: ��������
//  383 // ���  ������Ϊ:=1�ɹ�����,=0ʧ��  
//  384 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  385 uint8 SCCBReadByte(uint8 *pBuffer, uint16 length, uint8 ReadAddress)
//  386 {
SCCBReadByte:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  387     uint8 i = 0;
        MOVS     R7,#+0
//  388     while( 0 == SCCBReadByteOne(pBuffer, length, ReadAddress) )
??SCCBReadByte_0:
        MOVS     R2,R6
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,R5
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,R4
        BL       SCCBReadByteOne
        CMP      R0,#+0
        BNE.N    ??SCCBReadByte_1
//  389     {
//  390         i++;
        ADDS     R7,R7,#+1
//  391         if(i == 30)
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+30
        BNE.N    ??SCCBReadByte_0
//  392         {
//  393             return 0 ;
        MOVS     R0,#+0
        B.N      ??SCCBReadByte_2
//  394         }
//  395     }
//  396     return 1;    
??SCCBReadByte_1:
        MOVS     R0,#+1
??SCCBReadByte_2:
        POP      {R1,R4-R7,PC}    ;; return
//  397 }

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  398           
//  399 
//  400 
//  401 
//  402 
//  403 
//  404 /*
//  405 
//  406 //=======================Demok��SCCB��
//  407 //SCCBӦ���źź���
//  408 void SCCBAck(void)
//  409 {
//  410     SCLClear();     //SCL_L();
//  411     SCCB_DELAY();
//  412     SDAClear();     //SDA_L();
//  413     SCCB_DELAY();
//  414     SCLSet();       //SCL_H();
//  415     SCCB_DELAY();
//  416     SCLClear();     //SCL_L();
//  417     SCCB_DELAY();
//  418 }
//  419 
//  420           
//  421 //SCCB��Ӧ���źź���
//  422 void SCCBNoAck(void)
//  423 {
//  424     SCLClear();     //SCL_L();
//  425     SCCB_DELAY();
//  426     SDASet();       //SDA_H();
//  427     SCCB_DELAY();
//  428     SCLSet();       //SCL_H();
//  429     SCCB_DELAY();
//  430     SCLClear();     //SCL_L();
//  431     SCCB_DELAY();
//  432   
//  433 }
//  434 
//  435 void SCCBStart(void)
//  436 {
//  437     SCLOut();                 //SCL_OUT;
//  438     SDAOut();                 //SDA_OUT;
//  439                              
//  440     SDASet();                 //SDA_HIGH;
//  441                               //  //sccb_wait();
//  442     SCLSet();                 //SCL_HIGH;
//  443     SCCB_DELAY();             //sccb_wait();
//  444     SDAClear();               //SDA_LOW;
//  445     SCCB_DELAY();             //sccb_wait();
//  446     SCLClear();               //SCL_LOW;
//  447 }
//  448 
//  449 void SCCBStop(void)
//  450 {
//  451   SCLOut();                 //SCL_OUT;
//  452   SDAOut();                 //SDA_OUT;
//  453   
//  454   SDAClear();               //SDA_LOW;
//  455   SCCB_DELAY();             //sccb_wait();
//  456   SCLSet();                 //SCL_HIGH;
//  457   SCCB_DELAY();             //sccb_wait();
//  458   SDASet();                 //SDA_HIGH;
//  459   SCCB_DELAY();             //sccb_wait();
//  460 }
//  461 
//  462 
//  463 
//  464 //  ����˵����sccb�ֽ�д��         
//  465 //  ����˵����data--��д���ֽ�����
//  466 //  �������أ�ack--Ӧ���ź�
//  467 //            ack=1δ�յ�Ӧ��    ack=0�յ�Ӧ��
//  468 uint8 SCCBSendByte(uint8 data)
//  469 {
//  470     uint8 i;
//  471     uint8 ack;
//  472     
//  473     SDAOut();                //SDA_OUT;
//  474     for( i=0; i<8; i++)
//  475     {
//  476       if(data & 0x80)
//  477         SDASet();            //SDA_HIGH;
//  478       else 
//  479         SDAClear();          //SDA_LOW;
//  480       data <<= 1;
//  481       
//  482       SCCB_DELAY();          //sccb_wait();
//  483       SCLSet();              //SCL_HIGH;
//  484       SCCB_DELAY();          //sccb_wait();
//  485       SCLClear();            //SCL_LOW;
//  486       SCCB_DELAY();          //sccb_wait();
//  487     }
//  488     
//  489     SDASet();                //SDA_HIGH;
//  490     SDAIn();                 //SDA_IN;
//  491     SCCB_DELAY();            //sccb_wait();
//  492     SCLSet();                //SCL_HIGH;
//  493     SCCB_DELAY();            //sccb_wait();
//  494     ack = SDARead();         //ack = SDA_DATA;
//  495     SCLClear();              //SCL_LOW;
//  496     SCCB_DELAY();            //sccb_wait();
//  497     return ack;  
//  498 }
//  499 
//  500 //  ����˵������ָ���豸��ָ����ַ��д��ָ������        
//  501 //  ����˵����device--����ͷ�豸�ţ�����OV7620дΪ0X42   OV7640дΪ0X42  OV6620дΪ0XC0�����ѹ̶�ΪADDR_OV7725
//  502 //            address--Ҫд��ĵ�ַ
//  503 //            data--Ҫд�������
//  504 uint8 SCCBWriteByte(uint16 address, uint8 data)
//  505 {
//  506   uint8 i;
//  507   uint8 ack1, ack2, ack3;
//  508   
//  509   for( i=0; i<20; i++)         ///����20��
//  510   {
//  511     SCCBStart();                    //sccb_start();
//  512     ack1 = SCCBSendByte(ADDR_OV7725);      //ack = sccb_sendByte(device);
//  513     if( ack1 == 1 )
//  514     {
//  515      // sccb_stop();
//  516       continue;
//  517     }
//  518     
//  519     ack2 = SCCBSendByte((uint8)(address & 0x00FF));      //ack = sccb_sendByte(address);
//  520     if( ack2 == 1 )
//  521     {
//  522      // sccb_stop();
//  523       continue;
//  524     }
//  525     
//  526     ack3 = SCCBSendByte(data);      //ack = sccb_sendByte(data);
//  527     if( ack3 == 1 )
//  528     {
//  529      // sccb_stop();
//  530       continue;
//  531     }
//  532     
//  533     SCCBStop();                      //sccb_stop();
//  534     return 1;
//  535   }  
//  536   
//  537   return 0;
//  538 }
//  539 
//  540 
//  541 //����SCCB�������ݵĺ���
//  542 //���ز��������յ�������
//  543 uint8 SCCBReceiveByte(void)
//  544 {
//  545     uint8 i = 8;
//  546     uint8 ReceiveByte = 0;
//  547 
//  548     //SDA_H();
//  549     //SCCB_DELAY();
//  550     SDAIn();              //SDA_DDR_IN();
//  551 
//  552     while(i--)
//  553     {
//  554         ReceiveByte <<= 1;
//  555         SCLClear();          //SCL_L();
//  556         SCCB_DELAY();
//  557         SCLSet();            //SCL_H();
//  558         SCCB_DELAY();
//  559 
//  560         if(SDARead())         //SDA_IN()
//  561         {
//  562             ReceiveByte |= 0x01;
//  563         }
//  564     }
//  565     SDAOut();                 //SDA_DDR_OUT();
//  566     SCLClear();               //SCL_L();
//  567     return ReceiveByte;  
//  568 }
//  569 
//  570 
//  571 
//  572 
//  573 // ��������SCCB_ReadByte
//  574 // ����  ����ȡһ������1��
//  575 // ����  ��- pBuffer: ��Ŷ�������  - length: ����������    - ReadAddress: ��������ַ        - DeviceAddress: ��������
//  576 // ���  ������Ϊ:=1�ɹ�����,=0ʧ��         
//  577 // ��ע  ���ú����᳢��30�Σ�ֻҪ��һ�γɹ����ͻ�ִ�е�����return 1, ȫ��ʧ�ܺ󣬻�ִ��return 0
//  578 uint8 SCCBReadByte(uint8 *pBuffer, uint16 length, uint8 ReadAddress)
//  579 {
//  580     uint8 i; 
//  581     uint8 ack1, ack2, ack3, ack4, ack5;
//  582     
//  583     for(i = 0; i < 30; i++)
//  584     {
//  585       SCCBStart();                         //��ʼ�ź�
//  586       ack1 = SCCBSendByte( ADDR_OV7725 );         // ������ַ
//  587       if( ack1 == 1 )
//  588       {
//  589       // sccb_stop();
//  590         continue;
//  591       }  
//  592       ack2 = SCCBSendByte( ReadAddress );           // ���õ���ʼ��ַ 
//  593       if( ack2 == 1 )
//  594       {
//  595       // sccb_stop();
//  596       continue;
//  597       }      
//  598       SCCBStop();              
//  599 
//  600       //����һ��
//  601       SCCBStart();      
//  602       ack3 = SCCBSendByte( ADDR_OV7725 + 1 );               // ������ַ 
//  603       if( ack3 == 1 )
//  604       {
//  605       // sccb_stop();
//  606       continue;
//  607       }      
//  608 
//  609       while(length)
//  610       {
//  611           *pBuffer = SCCBReceiveByte();    
//  612           if(length == 1)
//  613           {
//  614               SCCBNoAck();
//  615           }
//  616           else
//  617           {
//  618               SCCBAck();
//  619           }
//  620           pBuffer++;
//  621           length--;
//  622       }
//  623       SCCBStop();
//  624       return 1;
//  625     
//  626     } // end of forѭ��
//  627     return 0;
//  628 }
//  629 
//  630 
//  631 */
//  632 
//  633 
// 
// 964 bytes in section .text
// 
// 964 bytes of CODE memory
//
//Errors: none
//Warnings: none
