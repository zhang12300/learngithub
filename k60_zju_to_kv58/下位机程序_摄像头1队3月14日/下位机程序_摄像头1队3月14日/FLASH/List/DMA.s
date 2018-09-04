///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.30.3.8024/W32 for ARM       14/Mar/2018  19:12:11
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\C\Component_C\DMA.c
//    Command line =  
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\C\Component_C\DMA.c
//        -D IAR -D TWR_K60N512 -lCN
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\FLASH\List\ -lB
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\FLASH\List\ -o
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\FLASH\Obj\ --no_cse
//        --no_unroll --no_inline --no_code_motion --no_tbaa --no_clustering
//        --no_scheduling --debug --endian=little --cpu=Cortex-M4 -e --fpu=None
//        --dlib_config "C:\Program Files (x86)\IAR Systems\Embedded Workbench
//        7.0\arm\INC\c\DLib_Config_Normal.h" -I
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\H\ -I
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\H\Component_H\
//        -I E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\H\Frame_H\
//        -I
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\H\Function_H\
//        -I E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\H\SD_H\ -Ol
//        --use_c++_inline
//    List file    =  
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\FLASH\List\DMA.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN enable_irq

        PUBLIC DMAFlag
        PUBLIC DMAInit
        PUBLIC enable_DMA_irq

// E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\C\Component_C\DMA.c
//    1 //==============================================================================
//    2 //�ļ����ƣ�DMA.c
//    3 //���ܸ�Ҫ��K60 DMA�ײ����������ļ�
//    4 //��Ȩ���У�HJZ
//    5 //�˿�ʹ�ã�
//    6 //==============================================================================
//    7 #include "DMA.h"
//    8 
//    9 
//   10 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   11 volatile uint8 DMAFlag = 0;
DMAFlag:
        DS8 1
//   12 
//   13 /*
//   14 
//   15 // ���Ǹ�OV7725׼����DMA��ʼ������
//   16 uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint32 DMA_Count, uint32 S_Addr, uint32 D_Addr)
//   17 {
//   18     //��������������
//   19 	if (DMA_CHn > 15) return 0;                
//   20 	if (DMA_Source > 52) return 0; 
//   21 
//   22 	//DMAͨ������
//   23 	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //��DMA��·����ʱ��
//   24 	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //��DMAģ��ʱ��
//   25 	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
//   26 		                                   | DMAMUX_CHCFG_ENBL_MASK			        // ʹ��DMAͨ�� 
//   27                                                    //| DMAMUX_CHCFG_TRIG_MASK				// �������Դ���ģʽ��ע��ֻ��0~3ͨ��֧��
//   28                                                    | DMAMUX_CHCFG_SOURCE(DMA_Source)      // ָ��DMA����Դ 
//   29 		                                   );
//   30     
//   31 	DMA_CR = 0;												  // Ĭ�����ã���Ҫ��DMA������֮ǰ���ô˼Ĵ���
//   32 	//DMA_DCHPRIn										      // Ĭ�����ȼ����ã����ﲻ�����
//   33 	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // ��ѭ����������1��major loop, ��һ�δ�����=major_loop*minor_loop�����Ϊ2^15=32767 
//   34 	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // ��ѭ����������λֵ��BITERӦ�õ���CITER 
//   35 	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // ÿ��minor loop����1���ֽ�
//   36 
//   37 	//Դ��ַ����
//   38 	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMAԴ��ַ
//   39 	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // ÿ�ζ�Դ��ַ�����ӵ��ֽ���
//   40 	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA������ѭ����ɺ�Դ��ַ������
//   41 
//   42 	//Ŀ�ĵ�ַ����
//   43 	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMAĿ���ַ 
//   44 	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // ÿ��дĿ�ĵ�ַ�����ӵ��ֽ���
//   45 	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = 0x00;		      // DMA������ѭ����ɺ�Ŀ�ĵ�ַ������
//   46 	
//   47 	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
//   48 		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
//   49 		                              | DMA_ATTR_SSIZE(0)	  // Դ���ݿ�ȣ�   8λ���� 
//   50 		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
//   51 		                              | DMA_ATTR_DSIZE(0)	  // Ŀ�����ݿ�ȣ� 8λ���� 
//   52 		                              );
//   53 
//   54 	//CSR�Ĵ�������
//   55 	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;						  // ������CSR��֮�������� 
//   56         DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_BWC(3);    //ÿ��1�Σ�eDMA����ֹͣ8������
//   57 	DMA_INT |= (1<<DMA_CHn);	                        // 1����ѭ��������ɺ���жϱ�־λ������ 
//   58 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1����ѭ��������ɺ���ж�ʹ��λ��ʹ�� 
//   59 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1��DMA������ɺ��Զ���REQλ��ֹͣ���� 
//   60 
//   61 	//DMA��ͣλ
//   62 	DMA_ERQ &= ~(1 << DMA_CHn);						      // �ر���Ӧͨ����DMA���������ý׶��ȹرգ��ٵ���myDMA_Start��������DMA 
//   63                                                               
//   64 	return 1;
//   65 
//   66 }// end of DMAInit()
//   67 
//   68 
//   69 */
//   70 
//   71 
//   72 
//   73 
//   74 //------------------------------------------------------------------------------
//   75 //��������DMAInit
//   76 //��  �ܣ�DMA��ʼ��
//   77 //��  ����
//   78 //        DMA_CHn--ָ����DMAͨ���ţ���Χ0~15��
//   79 //        DMA_Source--DMA����Դ����DMA.h�ļ�����ö�ٶ���
//   80 //        S_Addr--DMA����Դ��ַ
//   81 //        D_Addr--DMA����Ŀ�ĵ�ַ
//   82 //��  �أ���
//   83 //˵  ������ӦOV7620������7725��7725�ò������жϡ�
//   84 //        1. 1��PCLK��Ӳ�������ᵼ��1��DMA��ѭ����1��DMA��ѭ������ֻ��1��8λ���ݵĴ��ͣ�������ɺ�Ŀ�ĵ�ַ���1��ֱ��Ŀ�����鱻������
//   85 //        2. CAMERA_LINE����ѭ������Ϊ"DMA�������"��������DMA��������жϣ�����DMA��������жϷ�������
//   86 //        3. DMA��������жϷ������У�����DMA��������жϱ�־λ���ٰ�������1��
//   87 //        4. ��ʼ��ʱֻ�򿪳��жϺ�DMA��������жϵ�IRQ�����ж��У����������־λ��Ȼ���ʼ��������Ȼ������жϣ����ظ�һ��DMA�ĳ�ʼ����
//   88 //        5. ���ж��У����������־λ�����û�������ʹ�ERQ,��������ˣ��͹����жϵ�IRQ��
//   89 //
//   90 //        
//   91 
//   92 //------------------------------------------------------------------------------
//   93 
//   94 
//   95 //���Ǹ�OV7620׼����DMA��ʼ����������ʱ�Ȳ�Ҫ��
//   96 //DMAͨ��0��B0~B7Ϊ����Դ��ַ��ImgSotre����ΪĿ�ĵ�ַ��
//   97 //ÿ��Ӳ����������1�ֽڣ�ͬʱĿ���ַ��1���ֽڡ�
//   98 //�ɼ���1�����غ����DMA�жϣ���ʱԴ��ַ���䣬Ŀ�ĵ�ַ��1��������ռ�ֽ�����

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   99 uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint16 DMA_Count, uint32 S_Addr, uint32 D_Addr)
//  100 {
DMAInit:
        PUSH     {R4,R5}
//  101     //��������������
//  102 	if (DMA_CHn > 15) return 0;                
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+16
        BLT.N    ??DMAInit_0
        MOVS     R0,#+0
        B.N      ??DMAInit_1
//  103 	if (DMA_Source > 52) return 0; 
??DMAInit_0:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+53
        BLT.N    ??DMAInit_2
        MOVS     R0,#+0
        B.N      ??DMAInit_1
//  104 
//  105 	//DMAͨ������
//  106 	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //��DMA��·����ʱ��
??DMAInit_2:
        LDR.N    R4,??DataTable0  ;; 0x4004803c
        LDR      R4,[R4, #+0]
        ORRS     R4,R4,#0x2
        LDR.N    R5,??DataTable0  ;; 0x4004803c
        STR      R4,[R5, #+0]
//  107 	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //��DMAģ��ʱ��
        LDR.N    R4,??DataTable0_1  ;; 0x40048040
        LDR      R4,[R4, #+0]
        ORRS     R4,R4,#0x2
        LDR.N    R5,??DataTable0_1  ;; 0x40048040
        STR      R4,[R5, #+0]
//  108 	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
//  109 	                                           | DMAMUX_CHCFG_ENBL_MASK		// ʹ��DMAͨ�� 
//  110                                                  //| DMAMUX_CHCFG_TRIG_MASK		// �������Դ���ģʽ��ע��ֻ��0~3ͨ��֧��
//  111                                                    | DMAMUX_CHCFG_SOURCE(DMA_Source) // ָ��DMA����Դ 
//  112                                                     );
        ANDS     R1,R1,#0x3F
        ORRS     R1,R1,#0x80
        LDR.N    R4,??DataTable0_2  ;; 0x40021000
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STRB     R1,[R0, R4]
//  113     
//  114 	DMA_CR = 0;												  // Ĭ�����ã���Ҫ��DMA������֮ǰ���ô˼Ĵ���
        MOVS     R1,#+0
        LDR.N    R4,??DataTable0_3  ;; 0x40008000
        STR      R1,[R4, #+0]
//  115 	//DMA_DCHPRIn										      // Ĭ�����ȼ����ã����ﲻ�����
//  116 	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // ��ѭ����������1��major loop, ��һ�δ�����=major_loop*minor_loop�����Ϊ2^15=32767 
        LSLS     R1,R2,#+17       ;; ZeroExtS R1,R2,#+17,#+17
        LSRS     R1,R1,#+17
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R4,R0,#+5
        ADD      R4,R4,#+1073741824
        ADDS     R4,R4,#+36864
        STRH     R1,[R4, #+22]
//  117 	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // ��ѭ����������λֵ��BITERӦ�õ���CITER 
        LSLS     R1,R2,#+17       ;; ZeroExtS R1,R2,#+17,#+17
        LSRS     R1,R1,#+17
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+30]
//  118 	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // ÿ��minor loop����1���ֽ�
        MOVS     R1,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STR      R1,[R2, #+8]
//  119 
//  120 	//Դ��ַ����
//  121 	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMAԴ��ַ
        LDR.N    R1,??DataTable0_4  ;; 0x40009000
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        STR      R3,[R2, R1]
//  122 	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // ÿ�ζ�Դ��ַ�����ӵ��ֽ���
        MOVS     R1,#+0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+4]
//  123 	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA������ѭ����ɺ�Դ��ַ������
        MOVS     R1,#+0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STR      R1,[R2, #+12]
//  124 
//  125 	//Ŀ�ĵ�ַ����
//  126 	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMAĿ���ַ 
        LDR      R1,[SP, #+8]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STR      R1,[R2, #+16]
//  127 	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // ÿ��дĿ�ĵ�ַ�����ӵ��ֽ���
        MOVS     R1,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+20]
//  128 	//DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = CameraWidth;		      // DMA������ѭ����ɺ�Ŀ�ĵ�ַ������
//  129 	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = 0;      /////////////////////////�������ֲ�֪���ĸ��ǶԵ�
        MOVS     R1,#+0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STR      R1,[R2, #+24]
//  130         
//  131 	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
//  132 		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
//  133 		                              | DMA_ATTR_SSIZE(0)	  // Դ���ݿ�ȣ�   8λ���� 
//  134 		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
//  135 		                              | DMA_ATTR_DSIZE(0)	  // Ŀ�����ݿ�ȣ� 8λ���� 
//  136 		                              );
        MOVS     R1,#+0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+6]
//  137 
//  138 	//CSR�Ĵ�������
//  139 	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;				// ������CSR��֮�������� 
        MOVS     R1,#+0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+28]
//  140 	DMA_INT |= (1<<DMA_CHn);					// 1����ѭ��������ɺ���жϱ�־λ������ 
        LDR.N    R1,??DataTable0_5  ;; 0x40008024
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LSLS     R2,R2,R0
        ORRS     R1,R2,R1
        LDR.N    R2,??DataTable0_5  ;; 0x40008024
        STR      R1,[R2, #+0]
//  141 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1����ѭ��������ɺ���ж�ʹ��λ��ʹ�� 
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R1,R0,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRH     R1,[R1, #+28]
        ORRS     R1,R1,#0x2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+28]
//  142 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1��DMA������ɺ��Զ���REQλ��ֹͣ���� 
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R1,R0,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRH     R1,[R1, #+28]
        ORRS     R1,R1,#0x8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+28]
//  143 
//  144 	//DMA��ͣλ
//  145 	DMA_ERQ &= ~(1 << DMA_CHn);		// �ر���Ӧͨ����DMA���������ý׶��ȹر�
        LDR.N    R1,??DataTable0_6  ;; 0x4000800c
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LSLS     R0,R2,R0
        BICS     R0,R1,R0
        LDR.N    R1,??DataTable0_6  ;; 0x4000800c
        STR      R0,[R1, #+0]
//  146                                                               // ������ѭ��(����1����ѭ��)��ɺ�ERQ�ᱻ�Զ����㣬��Ҫ���ж����ٴ��ֶ�������
//  147 	return 1;
        MOVS     R0,#+1
??DMAInit_1:
        POP      {R4,R5}
        BX       LR               ;; return
//  148 
//  149 }// end of DMAInit()

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_1:
        DC32     0x40048040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_2:
        DC32     0x40021000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_3:
        DC32     0x40008000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_4:
        DC32     0x40009000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_5:
        DC32     0x40008024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_6:
        DC32     0x4000800c
//  150 
//  151 
//  152 /*  ���Ǹ�DMA����ר�õ�DMA��ʼ����������ʱ���ö�
//  153 uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint32 S_Addr, uint32 D_Addr)
//  154 {
//  155     //��������������
//  156 	if (DMA_CHn > 15) return 0;                
//  157 	if (DMA_Source > 52) return 0; 
//  158 
//  159 	//DMAͨ������
//  160 	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //��DMA��·����ʱ��
//  161 	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //��DMAģ��ʱ��
//  162 	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
//  163 												  | DMAMUX_CHCFG_ENBL_MASK			        // ʹ��DMAͨ�� 
//  164 												  //| DMAMUX_CHCFG_TRIG_MASK				// �������Դ���ģʽ��ע��ֻ��0~3ͨ��֧��
//  165 												  | DMAMUX_CHCFG_SOURCE(DMA_Source)      // ָ��DMA����Դ 
//  166 												  );
//  167     
//  168 	DMA_CR = 0;												  // Ĭ�����ã���Ҫ��DMA������֮ǰ���ô˼Ĵ���
//  169 	//DMA_DCHPRIn										      // Ĭ�����ȼ����ã����ﲻ�����
//  170 	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(10); // ��ѭ����������1��major loop, ��һ�δ�����=major_loop*minor_loop�����Ϊ2^15=32767 
//  171 	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(10); // ��ѭ����������λֵ��BITERӦ�õ���CITER 
//  172 	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // ÿ��minor loop����1���ֽ�
//  173 
//  174 	//Դ��ַ����
//  175 	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMAԴ��ַ
//  176 	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // ÿ�ζ�Դ��ַ�����ӵ��ֽ���
//  177 	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA������ѭ����ɺ�Դ��ַ������
//  178 
//  179 	//Ŀ�ĵ�ַ����
//  180 	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMAĿ���ַ 
//  181 	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // ÿ��дĿ�ĵ�ַ�����ӵ��ֽ���
//  182 	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = -10;		      // DMA������ѭ����ɺ�Ŀ�ĵ�ַ������
//  183 	
//  184 	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
//  185 		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
//  186 		                              | DMA_ATTR_SSIZE(0)	  // Դ���ݿ�ȣ�   8λ���� 
//  187 		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
//  188 		                              | DMA_ATTR_DSIZE(0)	  // Ŀ�����ݿ�ȣ� 8λ���� 
//  189 		                              );
//  190 
//  191 	//CSR�Ĵ�������
//  192 	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;						  // ������CSR��֮�������� 
//  193 	DMA_INT |= (1<<DMA_CHn);						// 1����ѭ��������ɺ���жϱ�־λ������ 
//  194 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1����ѭ��������ɺ���ж�ʹ��λ��ʹ�� 
//  195 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1��DMA������ɺ��Զ���REQλ��ֹͣ���� 
//  196 
//  197 	//DMA��ͣλ
//  198 	DMA_ERQ &= ~(1 << DMA_CHn);						      // �ر���Ӧͨ����DMA���������ý׶��ȹرգ��ٵ���myDMA_Start��������DMA 
//  199                                                               // ������ѭ��(����1����ѭ��)��ɺ�ERQ�ᱻ�Զ����㣬��Ҫ���ж����ٴ��ֶ�������
//  200 	return 1;
//  201 
//  202 }// end of DMAInit()
//  203 
//  204 */
//  205 
//  206 //���漸������Ӧ�÷���isr.c �У�ֻ���ݴ��ڴ�
//  207 /*
//  208 void DMA_CHO_ISR(void)
//  209 {
//  210 		DMA_INT|=DMA_INT_INT0_MASK;//���ͨ��0�ж�
//  211 			//putstr("DMA complete��");
//  212 				row_F[imagerow]=1;//�ɼ���ɱ�־
//  213 					imagerow++;	
//  214 }
//  215 
//  216 
//  217 
//  218 
//  219 
//  220 
//  221 
//  222 
//  223 
//  224 void portb_isr(void)//���жϣ�B10���������ж�
//  225 {
//  226 	PORTB_PCR10|=PORT_PCR_ISF_MASK;//����жϱ�־λ
//  227 	row++; //�м���
//  228 	if(row==data_table[imagerow])//�����ǰ������Ӧ�òɼ� 
//  229 		{
//  230 		DMA_ERQ|=DMA_ERQ_ERQ0_MASK;//ʹ��ͨ��0Ӳ��DMA����  
//  231 		}
//  232 	  else if(row>=ENDROW) //һ����ɣ��ر����ж�
//  233 	  	{
//  234 		  disable_irq (88);
//  235 		  	 displaypara(row,6,60);
//  236 
//  237 	  	}
//  238 }
//  239 */
//  240 
//  241 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  242 void enable_DMA_irq(uint8 DMAno)
//  243 {
enable_DMA_irq:
        PUSH     {R7,LR}
//  244   switch(DMAno)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??enable_DMA_irq_0
        CMP      R0,#+2
        BEQ.N    ??enable_DMA_irq_1
        BCC.N    ??enable_DMA_irq_2
        CMP      R0,#+4
        BEQ.N    ??enable_DMA_irq_3
        BCC.N    ??enable_DMA_irq_4
        CMP      R0,#+6
        BEQ.N    ??enable_DMA_irq_5
        BCC.N    ??enable_DMA_irq_6
        CMP      R0,#+8
        BEQ.N    ??enable_DMA_irq_7
        BCC.N    ??enable_DMA_irq_8
        CMP      R0,#+10
        BEQ.N    ??enable_DMA_irq_9
        BCC.N    ??enable_DMA_irq_10
        CMP      R0,#+12
        BEQ.N    ??enable_DMA_irq_11
        BCC.N    ??enable_DMA_irq_12
        CMP      R0,#+14
        BEQ.N    ??enable_DMA_irq_13
        BCC.N    ??enable_DMA_irq_14
        CMP      R0,#+15
        BEQ.N    ??enable_DMA_irq_15
        B.N      ??enable_DMA_irq_16
//  245   {
//  246     case 0:
//  247     enable_irq(0);			      //��DMAͨ��0��IRQ�ж�
??enable_DMA_irq_0:
        MOVS     R0,#+0
        BL       enable_irq
//  248     break;
        B.N      ??enable_DMA_irq_17
//  249     case 1:
//  250     enable_irq(1);			      //��DMAͨ��1��IRQ�ж�
??enable_DMA_irq_2:
        MOVS     R0,#+1
        BL       enable_irq
//  251     break;
        B.N      ??enable_DMA_irq_17
//  252     case 2:
//  253     enable_irq(2);			     //��DMAͨ��2��IRQ�ж�
??enable_DMA_irq_1:
        MOVS     R0,#+2
        BL       enable_irq
//  254     break;
        B.N      ??enable_DMA_irq_17
//  255     case 3:
//  256     enable_irq(3);			      //��DMAͨ��3��IRQ�ж�
??enable_DMA_irq_4:
        MOVS     R0,#+3
        BL       enable_irq
//  257     break;
        B.N      ??enable_DMA_irq_17
//  258     case 4:
//  259     enable_irq(4);			      //��DMAͨ��4��IRQ�ж�
??enable_DMA_irq_3:
        MOVS     R0,#+4
        BL       enable_irq
//  260     break;
        B.N      ??enable_DMA_irq_17
//  261     case 5:
//  262     enable_irq(5);			      //��DMAͨ��5��IRQ�ж�
??enable_DMA_irq_6:
        MOVS     R0,#+5
        BL       enable_irq
//  263     break;
        B.N      ??enable_DMA_irq_17
//  264     case 6:
//  265     enable_irq(6);			     //��DMAͨ��6��IRQ�ж�
??enable_DMA_irq_5:
        MOVS     R0,#+6
        BL       enable_irq
//  266     break;
        B.N      ??enable_DMA_irq_17
//  267     case 7:
//  268     enable_irq(7);			      //��DMAͨ��7��IRQ�ж�
??enable_DMA_irq_8:
        MOVS     R0,#+7
        BL       enable_irq
//  269     break;
        B.N      ??enable_DMA_irq_17
//  270     case 8:
//  271     enable_irq(8);			      //��DMAͨ��8��IRQ�ж�
??enable_DMA_irq_7:
        MOVS     R0,#+8
        BL       enable_irq
//  272     break;
        B.N      ??enable_DMA_irq_17
//  273     case 9:
//  274     enable_irq(9);			      //��DMAͨ��9��IRQ�ж�
??enable_DMA_irq_10:
        MOVS     R0,#+9
        BL       enable_irq
//  275     break;
        B.N      ??enable_DMA_irq_17
//  276     case 10:
//  277     enable_irq(10);			     //��DMAͨ��10��IRQ�ж�
??enable_DMA_irq_9:
        MOVS     R0,#+10
        BL       enable_irq
//  278     break;
        B.N      ??enable_DMA_irq_17
//  279     case 11:
//  280     enable_irq(11);			      //��DMAͨ��11��IRQ�ж�
??enable_DMA_irq_12:
        MOVS     R0,#+11
        BL       enable_irq
//  281     break;
        B.N      ??enable_DMA_irq_17
//  282     case 12:
//  283     enable_irq(12);			      //��DMAͨ��12��IRQ�ж�
??enable_DMA_irq_11:
        MOVS     R0,#+12
        BL       enable_irq
//  284     break;
        B.N      ??enable_DMA_irq_17
//  285     case 13:
//  286     enable_irq(13);			      //��DMAͨ��13��IRQ�ж�
??enable_DMA_irq_14:
        MOVS     R0,#+13
        BL       enable_irq
//  287     break;
        B.N      ??enable_DMA_irq_17
//  288     case 14:
//  289     enable_irq(14);			     //��DMAͨ��14��IRQ�ж�
??enable_DMA_irq_13:
        MOVS     R0,#+14
        BL       enable_irq
//  290     break;
        B.N      ??enable_DMA_irq_17
//  291     case 15:
//  292     enable_irq(15);			      //��DMAͨ��15��IRQ�ж�
??enable_DMA_irq_15:
        MOVS     R0,#+15
        BL       enable_irq
//  293     break;
        B.N      ??enable_DMA_irq_17
//  294     
//  295     default:
//  296     break;
//  297   }    
//  298 }
??enable_DMA_irq_16:
??enable_DMA_irq_17:
        POP      {R0,PC}          ;; return

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  299 
//  300 
//  301 
//  302 
//  303 
//  304 
//  305 
//  306 
//  307 
//  308 
//  309 
//  310 
//  311 
//  312 
//  313 
//  314 
//  315 
//  316 
//  317 
//  318 
//  319 
//  320 
//  321 
//  322 
//  323 
//  324 
//  325 
//  326 
//  327 
//  328 
//  329 
//  330 
//  331 
//  332 
//  333 
//  334 
//  335 
//  336 
//  337 
//  338 
//  339 
//  340 
//  341 
// 
//   1 byte  in section .bss
// 554 bytes in section .text
// 
// 554 bytes of CODE memory
//   1 byte  of DATA memory
//
//Errors: none
//Warnings: none
