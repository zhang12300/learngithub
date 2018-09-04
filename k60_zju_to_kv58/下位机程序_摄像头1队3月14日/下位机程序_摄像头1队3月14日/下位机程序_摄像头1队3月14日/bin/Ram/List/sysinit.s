///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.10.1.12857/W32 for ARM      30/Aug/2018  15:16:06
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Frame_C\sysinit.c
//    Command line =  
//        -f C:\Users\Lenovo\AppData\Local\Temp\EWD360.tmp
//        (C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Frame_C\sysinit.c
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
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\bin\Ram\List\sysinit.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1
        #define SHF_WRITE 0x1
        #define SHF_EXECINSTR 0x4

        PUBLIC PllInit150M
        PUBLIC core_clk_khz
        PUBLIC core_clk_mhz
        PUBLIC fb_clk_init
        PUBLIC periph_clk_khz
        PUBLIC pll_init
        PUBLIC set_sys_dividers
        PUBLIC sysinit
        PUBLIC trace_clk_init

// C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\Frame_C\sysinit.c
//    1 //-------------------------------------------------------------------------*
//    2 // �ļ���:sysinit.c                                                        *
//    3 // ˵  ��: ϵͳ�����ļ�                                                    *
//    4 //-------------------------------------------------------------------------*
//    5 
//    6 #include "sysinit.h"	//ͷ�ļ�
//    7 
//    8 //����ʱ�ӵ�ȫ�ֱ�������

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//    9 int32 core_clk_khz;       //�ں�Ƶ�� kHz
core_clk_khz:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   10 int32 core_clk_mhz;     
core_clk_mhz:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//   11 int32 periph_clk_khz;     //����Ƶ�� kHz
periph_clk_khz:
        DS8 4
//   12 
//   13 //-------------------------------------------------------------------------*
//   14 //������: sysinit                                                          *
//   15 //��  ��: ϵͳ����                                                         * 
//   16 //��  ��: ��						  	           *	
//   17 //��  ��: ��                                                               *
//   18 //˵  ��: ��                                                               *
//   19 //-------------------------------------------------------------------------*

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   20 void sysinit (void)
//   21 {
sysinit:
        PUSH     {R7,LR}
//   22     //ʹ��IO�˿�ʱ��    
//   23     SIM_SCGC5 |= (SIM_SCGC5_PORTA_MASK
//   24                               | SIM_SCGC5_PORTB_MASK
//   25                               | SIM_SCGC5_PORTC_MASK
//   26                               | SIM_SCGC5_PORTD_MASK
//   27                               | SIM_SCGC5_PORTE_MASK );
        LDR.N    R0,??DataTable4  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x3E00
        LDR.N    R1,??DataTable4  ;; 0x40048038
        STR      R0,[R1, #+0]
//   28 
//   29 #if(defined(OVERCLOCK))
//   30     {
//   31       PllInit150M();
        BL       PllInit150M
//   32       core_clk_mhz = 150;
        MOVS     R0,#+150
        LDR.N    R1,??DataTable4_1
        STR      R0,[R1, #+0]
//   33     }
//   34 #else
//   35     {
//   36       //����ϵͳʱ��
//   37       core_clk_mhz = pll_init(CORE_CLK_MHZ, REF_CLK);
//   38     }
//   39 #endif
//   40     //ͨ��pll_init�����ķ���ֵ�������ں�ʱ�Ӻ�����ʱ��
//   41     core_clk_khz = core_clk_mhz * 1000;
        LDR.N    R0,??DataTable4_1
        LDR      R1,[R0, #+0]
        MOV      R0,#+1000
        MULS     R1,R0,R1
        LDR.N    R0,??DataTable4_2
        STR      R1,[R0, #+0]
//   42     periph_clk_khz = core_clk_khz / (((SIM_CLKDIV1 & SIM_CLKDIV1_OUTDIV2_MASK) >> 24)+ 1);
        LDR.N    R0,??DataTable4_2
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_3  ;; 0x40048044
        LDR      R1,[R1, #+0]
        UBFX     R1,R1,#+24,#+4
        ADDS     R1,R1,#+1
        UDIV     R0,R0,R1
        LDR.N    R1,??DataTable4_4
        STR      R0,[R1, #+0]
//   43     //ʹ�ܸ���ʱ�ӣ����ڵ���
//   44     trace_clk_init();	
        BL       trace_clk_init
//   45     //FlexBusʱ�ӳ�ʼ��
//   46     fb_clk_init();
        BL       fb_clk_init
//   47 }
        POP      {R0,PC}          ;; return
//   48 
//   49 
//   50 
//   51 
//   52 //-------------------------------------------------------------------------*
//   53 //������: trace_clk_init                                                   *
//   54 //��  ��: ����ʱ�ӳ�ʼ��                                                   * 
//   55 //��  ��: ��							  	   *	
//   56 //��  ��: ��                                                               *
//   57 //˵  ��: ���ڵ���                                                         *
//   58 //-------------------------------------------------------------------------*

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   59 void trace_clk_init(void)
//   60 {
//   61     //���ø���ʱ��Ϊ�ں�ʱ��
//   62     SIM_SOPT2 |= SIM_SOPT2_TRACECLKSEL_MASK;	
trace_clk_init:
        LDR.N    R0,??DataTable4_5  ;; 0x40048004
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.N    R1,??DataTable4_5  ;; 0x40048004
        STR      R0,[R1, #+0]
//   63     //��PTA6������ʹ��TRACE_CLKOU����
//   64     PORTA_PCR6 = ( PORT_PCR_MUX(0x7));
        MOV      R0,#+1792
        LDR.N    R1,??DataTable4_6  ;; 0x40049018
        STR      R0,[R1, #+0]
//   65 }
        BX       LR               ;; return
//   66 
//   67 //-------------------------------------------------------------------------*
//   68 //������: fb_clk_init                                                      *
//   69 //��  ��: FlexBusʱ�ӳ�ʼ��                                                * 
//   70 //��  ��: ��								   *	
//   71 //��  ��: ��                                                               *
//   72 //˵  ��:                                                                  *
//   73 //-------------------------------------------------------------------------*

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   74 void fb_clk_init(void)
//   75 {
//   76     //ʹ��FlexBusģ��ʱ��
//   77     SIM_SCGC7 |= SIM_SCGC7_FLEXBUS_MASK;
fb_clk_init:
        LDR.N    R0,??DataTable4_7  ;; 0x40048040
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_7  ;; 0x40048040
        STR      R0,[R1, #+0]
//   78     //��PTA6������ʹ��FB_CLKOUT����
//   79     PORTC_PCR3 = ( PORT_PCR_MUX(0x5));
        MOV      R0,#+1280
        LDR.N    R1,??DataTable4_8  ;; 0x4004b00c
        STR      R0,[R1, #+0]
//   80 }
        BX       LR               ;; return
//   81 
//   82 //-------------------------------------------------------------------------*
//   83 //������: pll_init                                                         *
//   84 //��  ��: pll��ʼ��                                                        * 
//   85 //��  ��: clk_option:ʱ��ѡ��						   * 
//   86 //		  crystal_val:ʱ��ֵ                                       *	
//   87 //��  ��: ʱ��Ƶ��ֵ                                                       *
//   88 //˵  ��:                                                                  *
//   89 //-------------------------------------------------------------------------*

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   90 unsigned char pll_init(unsigned char clk_option, unsigned char crystal_val)
//   91 {
pll_init:
        PUSH     {R7,LR}
        MOVS     R2,R1
//   92     unsigned char pll_freq;
//   93     
//   94     if (clk_option > 3) {return 0;}   //���û��ѡ����õ�ѡ���򷵻�0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BLT.N    ??pll_init_0
        MOVS     R0,#+0
        B.N      ??pll_init_1
//   95     if (crystal_val > 15) {return 1;} // ���������õľ���ѡ������򷵻�1
??pll_init_0:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+16
        BLT.N    ??pll_init_2
        MOVS     R0,#+1
        B.N      ??pll_init_1
//   96     
//   97     //���ﴦ��Ĭ�ϵ�FEIģʽ
//   98     //�����ƶ���FBEģʽ
//   99     #if (defined(K60_CLK) || defined(ASB817))
//  100              MCG_C2 = 0;
??pll_init_2:
        MOVS     R2,#+0
        LDR.N    R3,??DataTable4_9  ;; 0x40064001
        STRB     R2,[R3, #+0]
//  101     #else
//  102              //ʹ���ⲿ����
//  103              MCG_C2 = MCG_C2_RANGE(2) | MCG_C2_HGO_MASK | MCG_C2_EREFS_MASK;
//  104     #endif
//  105     
//  106     //��ʼ��������ͷ�����״̬��������GPIO
//  107     SIM_SCGC4 |= SIM_SCGC4_LLWU_MASK;
        LDR.N    R2,??DataTable4_10  ;; 0x40048034
        LDR      R2,[R2, #+0]
        ORRS     R2,R2,#0x10000000
        LDR.N    R3,??DataTable4_10  ;; 0x40048034
        STR      R2,[R3, #+0]
//  108     LLWU_CS |= LLWU_CS_ACKISO_MASK;
        LDR.N    R2,??DataTable4_11  ;; 0x4007c008
        LDRB     R2,[R2, #+0]
        ORRS     R2,R2,#0x80
        LDR.N    R3,??DataTable4_11  ;; 0x4007c008
        STRB     R2,[R3, #+0]
//  109     
//  110     //ѡ���ⲿ���񣬲ο���Ƶ������IREFS�������ⲿ����
//  111     MCG_C1 = MCG_C1_CLKS(2) | MCG_C1_FRDIV(3);
        MOVS     R2,#+152
        LDR.N    R3,??DataTable4_12  ;; 0x40064000
        STRB     R2,[R3, #+0]
//  112     
//  113     //�ȴ������ȶ�	
//  114     #if (!defined(K60_CLK) && !defined(ASB817))
//  115     while (!(MCG_S & MCG_S_OSCINIT_MASK)){};  
//  116     #endif
//  117     
//  118     //�ȴ��ο�ʱ��״̬λ����
//  119     while (MCG_S & MCG_S_IREFST_MASK){}; 
??pll_init_3:
        LDR.N    R2,??DataTable4_13  ;; 0x40064006
        LDRB     R2,[R2, #+0]
        LSLS     R2,R2,#+27
        BMI.N    ??pll_init_3
//  120     //�ȴ�ʱ��״̬λ��ʾʱ��Դ�����ⲿ�ο�ʱ��
//  121     while (((MCG_S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) != 0x2){}; 
??pll_init_4:
        LDR.N    R2,??DataTable4_13  ;; 0x40064006
        LDRB     R2,[R2, #+0]
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        UBFX     R2,R2,#+2,#+2
        CMP      R2,#+2
        BNE.N    ??pll_init_4
//  122     
//  123     //����FBEģʽ
//  124     #if (defined(K60_CLK))
//  125     MCG_C5 = MCG_C5_PRDIV(0x18);
        MOVS     R2,#+24
        LDR.N    R3,??DataTable4_14  ;; 0x40064004
        STRB     R2,[R3, #+0]
//  126     #else
//  127     
//  128     //����PLL��Ƶ����ƥ�����õľ���
//  129     MCG_C5 = MCG_C5_PRDIV(crystal_val); 
//  130     #endif
//  131     
//  132     //ȷ��MCG_C6���ڸ�λ״̬����ֹLOLIE��PLL����ʱ�ӿ���������PLL VCO��Ƶ��
//  133     MCG_C6 = 0x0;
        MOVS     R2,#+0
        LDR.N    R3,??DataTable4_15  ;; 0x40064005
        STRB     R2,[R3, #+0]
//  134     //ѡ��PLL VCO��Ƶ����ϵͳʱ�ӷ�Ƶ��ȡ����ʱ��ѡ��
//  135     switch (clk_option) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??pll_init_5
        CMP      R0,#+2
        BEQ.N    ??pll_init_6
        BCC.N    ??pll_init_7
        CMP      R0,#+3
        BEQ.N    ??pll_init_8
        B.N      ??pll_init_9
//  136     case 0:
//  137       //����ϵͳ��Ƶ��
//  138       //MCG=PLL, core = MCG, bus = MCG, FlexBus = MCG, Flash clock= MCG/2
//  139       set_sys_dividers(0,0,0,1);
??pll_init_5:
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       set_sys_dividers
//  140       //����VCO��Ƶ����ʹ��PLLΪ50MHz, LOLIE=0, PLLS=1, CME=0, VDIV=1
//  141       MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(1); //VDIV = 1 (x25)
        MOVS     R0,#+65
        LDR.N    R1,??DataTable4_15  ;; 0x40064005
        STRB     R0,[R1, #+0]
//  142       pll_freq = 50;
        MOVS     R1,#+50
//  143       break;
        B.N      ??pll_init_9
//  144     case 1:
//  145       //����ϵͳ��Ƶ��
//  146       //MCG=PLL, core = MCG, bus = MCG/2, FlexBus = MCG/2, Flash clock= MCG/4
//  147       set_sys_dividers(0,1,1,3);
??pll_init_7:
        MOVS     R3,#+3
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       set_sys_dividers
//  148       //����VCO��Ƶ����ʹ��PLLΪ100MHz, LOLIE=0, PLLS=1, CME=0, VDIV=26
//  149       MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(26); //VDIV = 26 (x50)
        MOVS     R0,#+90
        LDR.N    R1,??DataTable4_15  ;; 0x40064005
        STRB     R0,[R1, #+0]
//  150       pll_freq = 100;
        MOVS     R1,#+100
//  151       break;
        B.N      ??pll_init_9
//  152     case 2:
//  153       //����ϵͳ��Ƶ��
//  154       //MCG=PLL, core = MCG, bus = MCG/2, FlexBus = MCG/2, Flash clock= MCG/4
//  155       set_sys_dividers(0,1,1,3);
??pll_init_6:
        MOVS     R3,#+3
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       set_sys_dividers
//  156       //����VCO��Ƶ����ʹ��PLLΪ96MHz, LOLIE=0, PLLS=1, CME=0, VDIV=24
//  157       MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(24); //VDIV = 24 (x48)
        MOVS     R0,#+88
        LDR.N    R1,??DataTable4_15  ;; 0x40064005
        STRB     R0,[R1, #+0]
//  158       pll_freq = 96;
        MOVS     R1,#+96
//  159       break;
        B.N      ??pll_init_9
//  160     case 3:
//  161       //����ϵͳ��Ƶ��
//  162       //MCG=PLL, core = MCG, bus = MCG, FlexBus = MCG, Flash clock= MCG/2
//  163       set_sys_dividers(0,0,0,1);
??pll_init_8:
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       set_sys_dividers
//  164       //����VCO��Ƶ����ʹ��PLLΪ48MHz, LOLIE=0, PLLS=1, CME=0, VDIV=0
//  165       MCG_C6 = MCG_C6_PLLS_MASK; //VDIV = 0 (x24)
        MOVS     R0,#+64
        LDR.N    R1,??DataTable4_15  ;; 0x40064005
        STRB     R0,[R1, #+0]
//  166       pll_freq = 48;
        MOVS     R1,#+48
//  167       break;
//  168     }
//  169     while (!(MCG_S & MCG_S_PLLST_MASK)){}; // wait for PLL status bit to set
??pll_init_9:
        LDR.N    R0,??DataTable4_13  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??pll_init_9
//  170     
//  171     while (!(MCG_S & MCG_S_LOCK_MASK)){}; // Wait for LOCK bit to set
??pll_init_10:
        LDR.N    R0,??DataTable4_13  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+25
        BPL.N    ??pll_init_10
//  172     
//  173     //����PBEģʽ
//  174     
//  175     //ͨ������CLKSλ������PEEģʽ
//  176     // CLKS=0, FRDIV=3, IREFS=0, IRCLKEN=0, IREFSTEN=0
//  177     MCG_C1 &= ~MCG_C1_CLKS_MASK;
        LDR.N    R0,??DataTable4_12  ;; 0x40064000
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0x3F
        LDR.N    R2,??DataTable4_12  ;; 0x40064000
        STRB     R0,[R2, #+0]
//  178     
//  179     //�ȴ�ʱ��״̬λ����
//  180     while (((MCG_S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) != 0x3){};
??pll_init_11:
        LDR.N    R0,??DataTable4_13  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UBFX     R0,R0,#+2,#+2
        CMP      R0,#+3
        BNE.N    ??pll_init_11
//  181     
//  182     //��ʼ����PEEģʽ
//  183     
//  184     return pll_freq;
        MOVS     R0,R1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??pll_init_1:
        POP      {R1,PC}          ;; return
//  185 }
//  186 
//  187 //-------------------------------------------------------------------------*
//  188 //������: set_sys_dividers                                                 *
//  189 //��  ��: ����ϵϵͳ��Ƶ��                                                 * 
//  190 //��  ��: Ԥ��Ƶֵ   							   *	
//  191 //��  ��: ��                                                               *
//  192 //˵  ��: �˺����������RAM��ִ�У�������������e2448����FLASHʱ�ӷ�Ƶ�ı�* 
//  193 //        ʱ�������ֹFLASH��Ԥȡ���ܡ���ʱ�ӷ�Ƶ�ı�֮�󣬱�����ʱһС��ʱ*
//  194 //	 ��ſ��Դ���ʹ��Ԥȡ���ܡ�                                        * 
//  195 //-------------------------------------------------------------------------*

        SECTION `.textrw`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, SHF_WRITE | SHF_EXECINSTR
        THUMB
//  196 __ramfunc void set_sys_dividers(uint32 outdiv1, uint32 outdiv2, uint32 outdiv3, uint32 outdiv4)
//  197 {
set_sys_dividers:
        PUSH     {R4-R6}
//  198     uint32 temp_reg;
//  199     uint8 i;
//  200     //����FMC_PFAPR��ǰ��ֵ
//  201     temp_reg = FMC_PFAPR;
        LDR.N    R4,??set_sys_dividers_0  ;; 0x4001f000
        LDR      R4,[R4, #+0]
//  202     
//  203     //ͨ��M&PFD��λM0PFD����ֹԤȡ����
//  204     FMC_PFAPR |= FMC_PFAPR_M7PFD_MASK | FMC_PFAPR_M6PFD_MASK | FMC_PFAPR_M5PFD_MASK
//  205                      | FMC_PFAPR_M4PFD_MASK | FMC_PFAPR_M3PFD_MASK | FMC_PFAPR_M2PFD_MASK
//  206                      | FMC_PFAPR_M1PFD_MASK | FMC_PFAPR_M0PFD_MASK;
        LDR.N    R5,??set_sys_dividers_0  ;; 0x4001f000
        LDR      R5,[R5, #+0]
        ORRS     R5,R5,#0xFF0000
        LDR.N    R6,??set_sys_dividers_0  ;; 0x4001f000
        STR      R5,[R6, #+0]
//  207     
//  208     //��ʱ�ӷ�Ƶ����������ֵ  
//  209     SIM_CLKDIV1 = SIM_CLKDIV1_OUTDIV1(outdiv1) | SIM_CLKDIV1_OUTDIV2(outdiv2) 
//  210                       | SIM_CLKDIV1_OUTDIV3(outdiv3) | SIM_CLKDIV1_OUTDIV4(outdiv4);
        LSLS     R1,R1,#+24
        ANDS     R1,R1,#0xF000000
        ORRS     R1,R1,R0, LSL #+28
        LSLS     R2,R2,#+20
        ANDS     R2,R2,#0xF00000
        ORRS     R1,R2,R1
        LSLS     R0,R3,#+16
        ANDS     R0,R0,#0xF0000
        ORRS     R1,R0,R1
        LDR.N    R0,??set_sys_dividers_0+0x4  ;; 0x40048044
        STR      R1,[R0, #+0]
//  211     
//  212     //�ȴ���Ƶ���ı�
//  213     for (i = 0 ; i < outdiv4 ; i++)
        MOVS     R0,#+0
        B.N      ??set_sys_dividers_1
??set_sys_dividers_2:
        ADDS     R0,R0,#+1
??set_sys_dividers_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,R3
        BCC.N    ??set_sys_dividers_2
//  214     {}
//  215     
//  216     //���´�FMC_PFAPR��ԭʼֵ
//  217     FMC_PFAPR = temp_reg; 
        LDR.N    R0,??set_sys_dividers_0  ;; 0x4001f000
        STR      R4,[R0, #+0]
//  218     
//  219     return;
        POP      {R4-R6}
        BX       LR               ;; return
        DATA
??set_sys_dividers_0:
        DC32     0x4001f000
        DC32     0x40048044
//  220 }
//  221 
//  222 
//  223 //-------------------------------------------------------------------------*
//  224 //������: PllInit150M                                                      *
//  225 //��  ��: pll��ʼ����150M���Ѿ���Ƶ��                                      * 
//  226 //��  ��: ��                    					                                 * 
//  227 //��  ��: ʱ��Ƶ��ֵ                                                       *
//  228 //˵  ��:                                                                  *
//  229 //-------------------------------------------------------------------------*

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  230 void PllInit150M(void)
//  231 {
//  232   uint32_t temp_reg;
//  233   //ʹ��IO�˿�ʱ��    
//  234   SIM_SCGC5 |= (SIM_SCGC5_PORTA_MASK
//  235                 | SIM_SCGC5_PORTB_MASK
//  236                   | SIM_SCGC5_PORTC_MASK
//  237                     | SIM_SCGC5_PORTD_MASK
//  238                       | SIM_SCGC5_PORTE_MASK );
PllInit150M:
        LDR.N    R0,??DataTable4  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x3E00
        LDR.N    R1,??DataTable4  ;; 0x40048038
        STR      R0,[R1, #+0]
//  239   //���ﴦ��Ĭ�ϵ�FEIģʽ
//  240   //�����ƶ���FBEģʽ
//  241   MCG_C2 = 0;  
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_9  ;; 0x40064001
        STRB     R0,[R1, #+0]
//  242   //MCG_C2 = MCG_C2_RANGE(2) | MCG_C2_HGO_MASK | MCG_C2_EREFS_MASK;
//  243   //��ʼ��������ͷ�����״̬��������GPIO
//  244   SIM_SCGC4 |= SIM_SCGC4_LLWU_MASK;
        LDR.N    R0,??DataTable4_10  ;; 0x40048034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10000000
        LDR.N    R1,??DataTable4_10  ;; 0x40048034
        STR      R0,[R1, #+0]
//  245   LLWU_CS |= LLWU_CS_ACKISO_MASK;
        LDR.N    R0,??DataTable4_11  ;; 0x4007c008
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable4_11  ;; 0x4007c008
        STRB     R0,[R1, #+0]
//  246     
//  247   //ѡ���ⲿ���񣬲ο���Ƶ������IREFS�������ⲿ����
//  248   MCG_C1 = MCG_C1_CLKS(2) | MCG_C1_FRDIV(3);
        MOVS     R0,#+152
        LDR.N    R1,??DataTable4_12  ;; 0x40064000
        STRB     R0,[R1, #+0]
//  249     
//  250   //�ȴ������ȶ�	    
//  251   while (MCG_S & MCG_S_IREFST_MASK){}                  //�ȴ�ʱ���л����ⲿ�ο�ʱ��
??PllInit150M_0:
        LDR.N    R0,??DataTable4_13  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BMI.N    ??PllInit150M_0
//  252   while (((MCG_S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) != 0x2){}
??PllInit150M_1:
        LDR.N    R0,??DataTable4_13  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UBFX     R0,R0,#+2,#+2
        CMP      R0,#+2
        BNE.N    ??PllInit150M_1
//  253     
//  254   //����FBEģʽ,
//  255   //0x18==25��Ƶ=2M,
//  256   //0x11==18��Ƶ=2.7778M 
//  257   //0x12==19��Ƶ=2.63M,
//  258   //0x13==20��Ƶ=2.5M    
//  259   MCG_C5 = MCG_C5_PRDIV(0x11);                
        MOVS     R0,#+17
        LDR.N    R1,??DataTable4_14  ;; 0x40064004
        STRB     R0,[R1, #+0]
//  260     
//  261   //ȷ��MCG_C6���ڸ�λ״̬����ֹLOLIE��PLL����ʱ�ӿ���������PLL VCO��Ƶ��
//  262   MCG_C6 = 0x0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_15  ;; 0x40064005
        STRB     R0,[R1, #+0]
//  263     
//  264   //����FMC_PFAPR��ǰ��ֵ
//  265   temp_reg = FMC_PFAPR;
        LDR.N    R0,??DataTable4_16  ;; 0x4001f000
        LDR      R0,[R0, #+0]
//  266     
//  267   //ͨ��M&PFD��λM0PFD����ֹԤȡ����
//  268   FMC_PFAPR |= FMC_PFAPR_M7PFD_MASK | FMC_PFAPR_M6PFD_MASK | FMC_PFAPR_M5PFD_MASK
//  269     | FMC_PFAPR_M4PFD_MASK | FMC_PFAPR_M3PFD_MASK | FMC_PFAPR_M2PFD_MASK
//  270       | FMC_PFAPR_M1PFD_MASK | FMC_PFAPR_M0PFD_MASK;    
        LDR.N    R1,??DataTable4_16  ;; 0x4001f000
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0xFF0000
        LDR.N    R2,??DataTable4_16  ;; 0x4001f000
        STR      R1,[R2, #+0]
//  271   //����ϵͳ��Ƶ��
//  272   //MCG=PLL, core = MCG, bus = MCG/2, FlexBus = MCG/2, Flash clock= MCG/8
//  273   SIM_CLKDIV1 = SIM_CLKDIV1_OUTDIV1(0) | SIM_CLKDIV1_OUTDIV2(1) 
//  274     | SIM_CLKDIV1_OUTDIV3(1) | SIM_CLKDIV1_OUTDIV4(7);       
        LDR.N    R1,??DataTable4_17  ;; 0x1170000
        LDR.N    R2,??DataTable4_3  ;; 0x40048044
        STR      R1,[R2, #+0]
//  275     
//  276   //���´�FMC_PFAPR��ԭʼֵ
//  277   FMC_PFAPR = temp_reg; 
        LDR.N    R1,??DataTable4_16  ;; 0x4001f000
        STR      R0,[R1, #+0]
//  278     
//  279   //����VCO��Ƶ����ʹ��PLLΪ150MHz, LOLIE=0, PLLS=1, CME=0, VDIV=30
//  280   //�������㣬��ȷ��Ƶ��Ϊ50/18*54=150
//  281   MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(30);  //VDIV = 30 (x54)
        MOVS     R0,#+94
        LDR.N    R1,??DataTable4_15  ;; 0x40064005
        STRB     R0,[R1, #+0]
//  282                                                   //VDIV = 26 (x50)
//  283   while (!(MCG_S & MCG_S_PLLST_MASK)){}; // wait for PLL status bit to set    
??PllInit150M_2:
        LDR.N    R0,??DataTable4_13  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??PllInit150M_2
//  284   while (!(MCG_S & MCG_S_LOCK_MASK)){}; // Wait for LOCK bit to set    
??PllInit150M_3:
        LDR.N    R0,??DataTable4_13  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+25
        BPL.N    ??PllInit150M_3
//  285     
//  286   //����PBEģʽ    
//  287   //ͨ������CLKSλ������PEEģʽ
//  288   // CLKS=0, FRDIV=3, IREFS=0, IRCLKEN=0, IREFSTEN=0
//  289   MCG_C1 &= ~MCG_C1_CLKS_MASK;
        LDR.N    R0,??DataTable4_12  ;; 0x40064000
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0x3F
        LDR.N    R1,??DataTable4_12  ;; 0x40064000
        STRB     R0,[R1, #+0]
//  290     
//  291   //�ȴ�ʱ��״̬λ����
//  292   while (((MCG_S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) != 0x3){};
??PllInit150M_4:
        LDR.N    R0,??DataTable4_13  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UBFX     R0,R0,#+2,#+2
        CMP      R0,#+3
        BNE.N    ??PllInit150M_4
//  293   //SIM_CLKDIV2 |= SIM_CLKDIV2_USBDIV(1);  
//  294     
//  295   //���ø���ʱ��Ϊ�ں�ʱ��
//  296   SIM_SOPT2 |= SIM_SOPT2_TRACECLKSEL_MASK;	
        LDR.N    R0,??DataTable4_5  ;; 0x40048004
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.N    R1,??DataTable4_5  ;; 0x40048004
        STR      R0,[R1, #+0]
//  297   //��PTA6������ʹ��TRACE_CLKOU����
//  298   PORTA_PCR6 = ( PORT_PCR_MUX(0x7));  
        MOV      R0,#+1792
        LDR.N    R1,??DataTable4_6  ;; 0x40049018
        STR      R0,[R1, #+0]
//  299   //ʹ��FlexBusģ��ʱ��
//  300   SIM_SCGC7 |= SIM_SCGC7_FLEXBUS_MASK;
        LDR.N    R0,??DataTable4_7  ;; 0x40048040
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_7  ;; 0x40048040
        STR      R0,[R1, #+0]
//  301   //��PTA6������ʹ��FB_CLKOUT����
//  302   PORTC_PCR3 = ( PORT_PCR_MUX(0x5));
        MOV      R0,#+1280
        LDR.N    R1,??DataTable4_8  ;; 0x4004b00c
        STR      R0,[R1, #+0]
//  303 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     0x40048038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     core_clk_mhz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     core_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     0x40048044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     periph_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     0x40048004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     0x40049018

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_7:
        DC32     0x40048040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_8:
        DC32     0x4004b00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_9:
        DC32     0x40064001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_10:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_11:
        DC32     0x4007c008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_12:
        DC32     0x40064000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_13:
        DC32     0x40064006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_14:
        DC32     0x40064004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_15:
        DC32     0x40064005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_16:
        DC32     0x4001f000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_17:
        DC32     0x1170000

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
//  304 
//  305 
//  306 
//  307 
//  308 
//  309 
// 
//  12 bytes in section .bss
// 630 bytes in section .text
//  76 bytes in section .textrw
// 
// 706 bytes of CODE memory
//  12 bytes of DATA memory
//
//Errors: none
//Warnings: none
