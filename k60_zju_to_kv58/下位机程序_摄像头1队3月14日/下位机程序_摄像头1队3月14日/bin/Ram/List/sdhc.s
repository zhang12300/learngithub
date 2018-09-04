///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.10.1.12857/W32 for ARM      30/Aug/2018  15:16:04
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\SD_C\sdhc.c
//    Command line =  
//        -f C:\Users\Lenovo\AppData\Local\Temp\EWC6EA.tmp
//        (C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\SD_C\sdhc.c
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
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\bin\Ram\List\sdhc.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC ESDHC_COMMAND_XFERTYP
        PUBLIC K60_SDHC0_init
        PUBLIC SDHC_Card
        PUBLIC SDHC_Device
        PUBLIC SDHC_Info
        PUBLIC SDHC_Init
        PUBLIC SDHC_init
        PUBLIC SDHC_ioctl
        PUBLIC SDHC_is_running
        PUBLIC SDHC_send_command
        PUBLIC SDHC_set_baudrate
        PUBLIC SDHC_status_wait
        PUBLIC core_clk_khz_sd

// C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\SD_C\sdhc.c
//    1 #include "sdhc.h"
//    2 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
        DATA
//    3 uint32 core_clk_khz_sd = 150000;
core_clk_khz_sd:
        DC32 150000

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//    4 SDCARD_STRUCT 		SDHC_Card;
SDHC_Card:
        DS8 20

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//    5 SDCARD_INIT_STRUCT  SDHC_Init;
SDHC_Init:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//    6 ESDHC_INFO_STRUCT	SDHC_Info;
SDHC_Info:
        DS8 516

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//    7 ESDHC_DEVICE_STRUCT SDHC_Device;
SDHC_Device:
        DS8 8
//    8 

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
//    9 const ESDHC_INIT_STRUCT K60_SDHC0_init =
K60_SDHC0_init:
        DC32 0, 25000000
//   10 {
//   11     0,                          /* ESDHC device number */
//   12     25000000,                   /* ESDHC baudrate      */
//   13     //200000000            /* ESDHC clock source  */
//   14 };
//   15 
//   16 
//   17 //SD卡命令实际使用到的命令有 32条，其中基本命令 25条，用户应用命令 7条

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
//   18 const unsigned long ESDHC_COMMAND_XFERTYP[] =
ESDHC_COMMAND_XFERTYP:
        DC32 0, 16777216, 34144256, 52035584, 67108864, 84017152, 102367232
        DC32 119209984, 135921664, 151584768, 168361984, 186253312, 215678976
        DC32 219807744, 0, 251658240, 270139392, 286916608, 303693824, 0
        DC32 337248256, 0, 370802688, 387579904, 404357120, 421134336
        DC32 437911552, 454688768, 471531520, 488308736, 505020416, 0
        DC32 538574848, 555352064, 572129280, 588906496, 605683712, 622460928
        DC32 639303680, 654442496, 672792576, 687996928, 706412544, 0, 0, 0, 0
        DC32 0, 0, 0, 0, 857341952, 874119168, 890896384, 0, 924450816
        DC32 941293568, 0, 0, 0, 1008402432, 1025179648, 0, 0
//   19 {
//   20     /* CMD0 */
//   21     SDHC_XFERTYP_CMDINX(ESDHC_CMD0) | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_NO),
//   22     SDHC_XFERTYP_CMDINX(ESDHC_CMD1) | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_NO),
//   23     SDHC_XFERTYP_CMDINX(ESDHC_CMD2) | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_136),
//   24     SDHC_XFERTYP_CMDINX(ESDHC_CMD3) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   25     SDHC_XFERTYP_CMDINX(ESDHC_CMD4) | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_NO),
//   26     /* CMD5 */
//   27     SDHC_XFERTYP_CMDINX(ESDHC_CMD5) | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   28     SDHC_XFERTYP_CMDINX(ESDHC_CMD6) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   29     SDHC_XFERTYP_CMDINX(ESDHC_CMD7) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48BUSY),
//   30     SDHC_XFERTYP_CMDINX(ESDHC_CMD8) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   31     SDHC_XFERTYP_CMDINX(ESDHC_CMD9) | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_136),
//   32     /* CMD10 */
//   33     SDHC_XFERTYP_CMDINX(ESDHC_CMD10) | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_136),
//   34     SDHC_XFERTYP_CMDINX(ESDHC_CMD11) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   35     SDHC_XFERTYP_CMDINX(ESDHC_CMD12) | SDHC_XFERTYP_CMDTYP(ESDHC_XFERTYP_CMDTYP_ABORT) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48BUSY),
//   36     SDHC_XFERTYP_CMDINX(ESDHC_CMD13) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   37     0,
//   38     /* CMD15 */
//   39     SDHC_XFERTYP_CMDINX(ESDHC_CMD15) | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_NO),
//   40     SDHC_XFERTYP_CMDINX(ESDHC_CMD16) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   41     SDHC_XFERTYP_CMDINX(ESDHC_CMD17) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   42     SDHC_XFERTYP_CMDINX(ESDHC_CMD18) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   43     0,
//   44     /* CMD20 */
//   45     SDHC_XFERTYP_CMDINX(ESDHC_CMD20) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   46     0,
//   47     SDHC_XFERTYP_CMDINX(ESDHC_ACMD22) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   48     SDHC_XFERTYP_CMDINX(ESDHC_ACMD23) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   49     SDHC_XFERTYP_CMDINX(ESDHC_CMD24) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   50     /* CMD25 */
//   51     SDHC_XFERTYP_CMDINX(ESDHC_CMD25) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   52     SDHC_XFERTYP_CMDINX(ESDHC_CMD26) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   53     SDHC_XFERTYP_CMDINX(ESDHC_CMD27) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   54     SDHC_XFERTYP_CMDINX(ESDHC_CMD28) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48BUSY),
//   55     SDHC_XFERTYP_CMDINX(ESDHC_CMD29) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48BUSY),
//   56     /* CMD30 */
//   57     SDHC_XFERTYP_CMDINX(ESDHC_CMD30) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   58     0,
//   59     SDHC_XFERTYP_CMDINX(ESDHC_CMD32) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   60     SDHC_XFERTYP_CMDINX(ESDHC_CMD33) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   61     SDHC_XFERTYP_CMDINX(ESDHC_CMD34) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   62     /* CMD35 */
//   63     SDHC_XFERTYP_CMDINX(ESDHC_CMD35) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   64     SDHC_XFERTYP_CMDINX(ESDHC_CMD36) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   65     SDHC_XFERTYP_CMDINX(ESDHC_CMD37) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   66     SDHC_XFERTYP_CMDINX(ESDHC_CMD38) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48BUSY),
//   67     SDHC_XFERTYP_CMDINX(ESDHC_CMD39) | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   68     /* CMD40 */
//   69     SDHC_XFERTYP_CMDINX(ESDHC_CMD40) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   70     SDHC_XFERTYP_CMDINX(ESDHC_ACMD41) | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   71     SDHC_XFERTYP_CMDINX(ESDHC_CMD42) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48BUSY),
//   72     0,
//   73     0,
//   74     /* CMD45 */
//   75     0,
//   76     0,
//   77     0,
//   78     0,
//   79     0,
//   80     /* CMD50 */
//   81     0,
//   82     SDHC_XFERTYP_CMDINX(ESDHC_ACMD51) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   83     SDHC_XFERTYP_CMDINX(ESDHC_CMD52) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   84     SDHC_XFERTYP_CMDINX(ESDHC_CMD53) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   85     0,
//   86     /* CMD55 */
//   87     SDHC_XFERTYP_CMDINX(ESDHC_CMD55) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48),
//   88     SDHC_XFERTYP_CMDINX(ESDHC_CMD56) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48BUSY),
//   89     0,
//   90     0,
//   91     0,
//   92     /* CMD60 */
//   93     SDHC_XFERTYP_CMDINX(ESDHC_CMD60) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48BUSY),
//   94     SDHC_XFERTYP_CMDINX(ESDHC_CMD61) | SDHC_XFERTYP_CICEN_MASK | SDHC_XFERTYP_CCCEN_MASK | SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48BUSY),
//   95     0,
//   96     0
//   97 };
//   98 
//   99 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  100 void SDHC_set_baudrate
//  101 (
//  102     /* [IN] Module input clock in Hz */
//  103     uint32         clock,
//  104 
//  105     /* [IN] Desired baudrate in Hz */
//  106     uint32         baudrate
//  107 )
//  108 {
SDHC_set_baudrate:
        PUSH     {R4-R7}
//  109     uint32 pres, div, min, minpres = 0x80, mindiv = 0x0F;
        MOVS     R5,#+128
        MOVS     R6,#+15
//  110     int32  val;
//  111 
//  112     /* Find closest setting */
//  113     min = (uint32) - 1;
        MOVS     R4,#-1
//  114     for (pres = 2; pres <= 256; pres <<= 1)
        MOVS     R2,#+2
        B.N      ??SDHC_set_baudrate_0
//  115     {
//  116         for (div = 1; div <= 16; div++)
//  117         {
//  118             val = pres * div * baudrate - clock;
??SDHC_set_baudrate_1:
        MUL      R7,R3,R2
        MULS     R7,R1,R7
        SUBS     R7,R7,R0
//  119             if (val >= 0)
        CMP      R7,#+0
        BMI.N    ??SDHC_set_baudrate_2
//  120             {
//  121                 if (min > val)
        CMP      R7,R4
        BCS.N    ??SDHC_set_baudrate_2
//  122                 {
//  123                     min = val;
        MOVS     R4,R7
//  124                     minpres = pres;
        MOVS     R5,R2
//  125                     mindiv = div;
        MOVS     R6,R3
//  126                 }
//  127             }
//  128         }
??SDHC_set_baudrate_2:
        ADDS     R3,R3,#+1
??SDHC_set_baudrate_3:
        CMP      R3,#+17
        BCC.N    ??SDHC_set_baudrate_1
        LSLS     R2,R2,#+1
??SDHC_set_baudrate_0:
        MOVW     R3,#+257
        CMP      R2,R3
        BCS.N    ??SDHC_set_baudrate_4
        MOVS     R3,#+1
        B.N      ??SDHC_set_baudrate_3
//  129     }
//  130 
//  131     /* Disable ESDHC clocks */
//  132     SDHC_SYSCTL &= (~ SDHC_SYSCTL_SDCLKEN_MASK);
??SDHC_set_baudrate_4:
        LDR.W    R0,??DataTable5  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x8
        LDR.W    R1,??DataTable5  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  133 
//  134     /* Change dividers */
//  135     div = SDHC_SYSCTL & (~ (SDHC_SYSCTL_DTOCV_MASK | SDHC_SYSCTL_SDCLKFS_MASK | SDHC_SYSCTL_DVS_MASK));
        LDR.W    R0,??DataTable5  ;; 0x400b102c
        LDR      R3,[R0, #+0]
        BFC      R3,#+4,#+16
//  136     SDHC_SYSCTL = div | (SDHC_SYSCTL_DTOCV(0x0E) | SDHC_SYSCTL_SDCLKFS(minpres >> 1) | SDHC_SYSCTL_DVS(mindiv - 1));
        LSLS     R5,R5,#+7
        ANDS     R5,R5,#0xFF00
        ORRS     R3,R5,R3
        SUBS     R6,R6,#+1
        LSLS     R6,R6,#+4
        ANDS     R6,R6,#0xF0
        ORRS     R3,R6,R3
        ORRS     R3,R3,#0xE0000
        LDR.W    R0,??DataTable5  ;; 0x400b102c
        STR      R3,[R0, #+0]
//  137 
//  138     /* Wait for stable clock */
//  139     while (0 == (SDHC_PRSSTAT & SDHC_PRSSTAT_SDSTB_MASK));
??SDHC_set_baudrate_5:
        LDR.W    R0,??DataTable5_1  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+28
        BPL.N    ??SDHC_set_baudrate_5
//  140 
//  141 
//  142     /* Enable ESDHC clocks */
//  143     SDHC_SYSCTL |= SDHC_SYSCTL_SDCLKEN_MASK;
        LDR.W    R0,??DataTable5  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable5  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  144     SDHC_IRQSTAT |= SDHC_IRQSTAT_DTOE_MASK;
        LDR.W    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100000
        LDR.W    R1,??DataTable5_2  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  145 }
        POP      {R4-R7}
        BX       LR               ;; return
//  146 
//  147 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  148 uint32 SDHC_init
//  149 (
//  150     /* [IN/OUT] Device runtime information */
//  151     ESDHC_INFO_STRUCT_PTR  esdhc_info_ptr,
//  152 
//  153     /* [IN] Device initialization data */
//  154     ESDHC_INIT_STRUCT_CPTR esdhc_init_ptr
//  155 )
//  156 {
SDHC_init:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  157 
//  158     esdhc_info_ptr->CARD = ESDHC_CARD_NONE;
        MOVS     R0,#+0
        STR      R0,[R4, #+0]
//  159 
//  160     /* Reset ESDHC */
//  161     SDHC_SYSCTL = SDHC_SYSCTL_RSTA_MASK | SDHC_SYSCTL_SDCLKFS(0x80);
        LDR.W    R0,??DataTable5_3  ;; 0x1008000
        LDR.W    R1,??DataTable5  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  162     while (SDHC_SYSCTL & SDHC_SYSCTL_RSTA_MASK) {};
??SDHC_init_0:
        LDR.W    R0,??DataTable5  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+7
        BMI.N    ??SDHC_init_0
//  163 
//  164     /* Initial values */
//  165     SDHC_VENDOR = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_4  ;; 0x400b10c0
        STR      R0,[R1, #+0]
//  166     SDHC_BLKATTR = SDHC_BLKATTR_BLKCNT(1) | SDHC_BLKATTR_BLKSIZE(512);
        MOVS     R0,#+66048
        LDR.W    R1,??DataTable5_5  ;; 0x400b1004
        STR      R0,[R1, #+0]
//  167     SDHC_PROCTL = SDHC_PROCTL_EMODE(ESDHC_PROCTL_EMODE_INVARIANT) | SDHC_PROCTL_D3CD_MASK;
        MOVS     R0,#+40
        LDR.W    R1,??DataTable5_6  ;; 0x400b1028
        STR      R0,[R1, #+0]
//  168     SDHC_WML = SDHC_WML_RDWML(1) | SDHC_WML_WRWML(1);
        MOVS     R0,#+65537
        LDR.W    R1,??DataTable5_7  ;; 0x400b1044
        STR      R0,[R1, #+0]
//  169 
//  170     /* Set the ESDHC initial baud rate divider and start */
//  171     //SDHC_set_baudrate (esdhc_init_ptr->CLOCK_SPEED,380000);
//  172     SDHC_set_baudrate (core_clk_khz_sd * 1000, 380000);
        LDR.W    R1,??DataTable5_8  ;; 0x5cc60
        LDR.W    R0,??DataTable5_9
        LDR      R0,[R0, #+0]
        MOV      R2,#+1000
        MULS     R0,R2,R0
        BL       SDHC_set_baudrate
//  173 
//  174     /* Poll inhibit bits */
//  175     while (SDHC_PRSSTAT & (SDHC_PRSSTAT_CIHB_MASK | SDHC_PRSSTAT_CDIHB_MASK)) {};
??SDHC_init_1:
        LDR.W    R0,??DataTable5_1  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        TST      R0,#0x3
        BNE.N    ??SDHC_init_1
//  176 
//  177     /* 初始化管脚复用 */
//  178     PORTE_PCR(0) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D1  */
        MOVW     R0,#+1091
        LDR.W    R1,??DataTable5_10  ;; 0x4004d000
        STR      R0,[R1, #+0]
//  179     PORTE_PCR(1) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D0  */
        MOVW     R0,#+1091
        LDR.W    R1,??DataTable5_11  ;; 0x4004d004
        STR      R0,[R1, #+0]
//  180     PORTE_PCR(2) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_DSE_MASK);                                          /* ESDHC.CLK */
        MOV      R0,#+1088
        LDR.W    R1,??DataTable5_12  ;; 0x4004d008
        STR      R0,[R1, #+0]
//  181     PORTE_PCR(3) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.CMD */
        MOVW     R0,#+1091
        LDR.W    R1,??DataTable5_13  ;; 0x4004d00c
        STR      R0,[R1, #+0]
//  182     PORTE_PCR(4) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D3  */
        MOVW     R0,#+1091
        LDR.W    R1,??DataTable5_14  ;; 0x4004d010
        STR      R0,[R1, #+0]
//  183     PORTE_PCR(5) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D2  */
        MOVW     R0,#+1091
        LDR.W    R1,??DataTable5_15  ;; 0x4004d014
        STR      R0,[R1, #+0]
//  184 
//  185     /* Enable clock gate to SDHC module */
//  186     SIM_SCGC3 |= SIM_SCGC3_SDHC_MASK;
        LDR.W    R0,??DataTable5_16  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20000
        LDR.W    R1,??DataTable5_16  ;; 0x40048030
        STR      R0,[R1, #+0]
//  187 
//  188     /* Enable requests */
//  189     SDHC_IRQSTAT = 0xFFFF;
        MOVW     R0,#+65535
        LDR.W    R1,??DataTable5_2  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  190     SDHC_IRQSTATEN = 	  SDHC_IRQSTATEN_DEBESEN_MASK | SDHC_IRQSTATEN_DCESEN_MASK | SDHC_IRQSTATEN_DTOESEN_MASK
//  191                           | SDHC_IRQSTATEN_CIESEN_MASK | SDHC_IRQSTATEN_CEBESEN_MASK | SDHC_IRQSTATEN_CCESEN_MASK | SDHC_IRQSTATEN_CTOESEN_MASK
//  192                           | SDHC_IRQSTATEN_BRRSEN_MASK | SDHC_IRQSTATEN_BWRSEN_MASK | SDHC_IRQSTATEN_CRMSEN_MASK
//  193                           | SDHC_IRQSTATEN_TCSEN_MASK | SDHC_IRQSTATEN_CCSEN_MASK;
        LDR.W    R0,??DataTable5_17  ;; 0x7f00b3
        LDR.W    R1,??DataTable5_18  ;; 0x400b1034
        STR      R0,[R1, #+0]
//  194 
//  195     /* 80 initial clocks */
//  196     SDHC_SYSCTL |= SDHC_SYSCTL_INITA_MASK;
        LDR.W    R0,??DataTable5  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.W    R1,??DataTable5  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  197     while (SDHC_SYSCTL & SDHC_SYSCTL_INITA_MASK) {};
??SDHC_init_2:
        LDR.W    R0,??DataTable5  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4
        BMI.N    ??SDHC_init_2
//  198 
//  199     /* Check card */
//  200     if (SDHC_PRSSTAT & SDHC_PRSSTAT_CINS_MASK)
        LDR.W    R0,??DataTable5_1  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+15
        BPL.N    ??SDHC_init_3
//  201     {
//  202         esdhc_info_ptr->CARD = ESDHC_CARD_UNKNOWN;
        MOVS     R0,#+1
        STR      R0,[R4, #+0]
//  203     }
//  204     SDHC_IRQSTAT |= SDHC_IRQSTAT_CRM_MASK;
??SDHC_init_3:
        LDR.W    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.W    R1,??DataTable5_2  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  205 
//  206     return ESDHC_OK;
        MOVS     R0,#+0
        POP      {R4,PC}          ;; return
//  207 }
//  208 
//  209 /*FUNCTION****************************************************************
//  210 *
//  211 * Function Name    : _esdhc_is_running
//  212 * Returned Value   : TRUE if running, FALSE otherwise
//  213 * Comments         :
//  214 *    Checks whether eSDHC module is currently in use.
//  215 *
//  216 *END*********************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  217 uint8 SDHC_is_running(void)
//  218 {
//  219     return (0 != (SDHC_PRSSTAT & (SDHC_PRSSTAT_RTA_MASK | SDHC_PRSSTAT_WTA_MASK | SDHC_PRSSTAT_DLA_MASK | SDHC_PRSSTAT_CDIHB_MASK | SDHC_PRSSTAT_CIHB_MASK)));
SDHC_is_running:
        LDR.W    R0,??DataTable5_1  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        MOVW     R1,#+775
        TST      R0,R1
        BEQ.N    ??SDHC_is_running_0
        MOVS     R0,#+1
        B.N      ??SDHC_is_running_1
??SDHC_is_running_0:
        MOVS     R0,#+0
??SDHC_is_running_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  220 }
//  221 
//  222 /*FUNCTION****************************************************************
//  223 *
//  224 * Function Name    : SDHC_status_wait
//  225 * Returned Value   : bits set for given mask
//  226 * Comments         :
//  227 *    Waits for ESDHC interrupt status register bits according to given mask.
//  228 *
//  229 *END*********************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  230 uint32 SDHC_status_wait(uint32	mask)        /* [IN] Mask of IRQSTAT bits to wait for */
//  231 {
SDHC_status_wait:
        MOVS     R1,R0
//  232     uint32	result;
//  233     do
//  234     {
//  235         result = SDHC_IRQSTAT & mask;
??SDHC_status_wait_0:
        LDR.W    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ANDS     R0,R1,R0
//  236     }
//  237     while (0 == result);
        CMP      R0,#+0
        BEQ.N    ??SDHC_status_wait_0
//  238     return result;
        BX       LR               ;; return
//  239 }
//  240 
//  241 /*FUNCTION****************************************************************
//  242 *
//  243 * Function Name    : SDHC_send_command
//  244 * Returned Value   : 0 on success, 1 on error, -1 on timeout
//  245 * Comments         :
//  246 *    One ESDHC command transaction.
//  247 *
//  248 *END*********************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  249 uint32 SDHC_send_command (ESDHC_COMMAND_STRUCT_PTR command) /* [IN/OUT] Command specification */
//  250 {
SDHC_send_command:
        PUSH     {R3-R5,LR}
        MOVS     R5,R0
//  251     uint32	xfertyp;
//  252 
//  253     /* Check command */
//  254     xfertyp = ESDHC_COMMAND_XFERTYP[command->COMMAND & 0x3F];
        LDR.W    R0,??DataTable5_19
        LDRB     R1,[R5, #+0]
        ANDS     R1,R1,#0x3F
        LDR      R4,[R0, R1, LSL #+2]
//  255     if ((0 == xfertyp) && (0 != command->COMMAND))
        CMP      R4,#+0
        BNE.N    ??SDHC_send_command_0
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BEQ.N    ??SDHC_send_command_0
//  256     {
//  257         return 1;
        MOVS     R0,#+1
        B.N      ??SDHC_send_command_1
//  258     }
//  259 
//  260     /* Card removal check preparation */
//  261     SDHC_IRQSTAT |= SDHC_IRQSTAT_CRM_MASK;
??SDHC_send_command_0:
        LDR.W    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.W    R1,??DataTable5_2  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  262 
//  263     /* Wait for cmd line idle */
//  264     while (SDHC_PRSSTAT & SDHC_PRSSTAT_CIHB_MASK) {};
??SDHC_send_command_2:
        LDR.W    R0,??DataTable5_1  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BMI.N    ??SDHC_send_command_2
//  265 
//  266     /* Setup command */
//  267     SDHC_CMDARG = command->ARGUMENT;
        LDR      R0,[R5, #+4]
        LDR.W    R1,??DataTable5_20  ;; 0x400b1008
        STR      R0,[R1, #+0]
//  268     xfertyp &= (~ SDHC_XFERTYP_CMDTYP_MASK);
        BICS     R4,R4,#0xC00000
//  269     xfertyp |= SDHC_XFERTYP_CMDTYP(command->TYPE);
        LDRB     R0,[R5, #+1]
        LSLS     R0,R0,#+22
        ANDS     R0,R0,#0xC00000
        ORRS     R4,R0,R4
//  270     if (ESDHC_TYPE_RESUME == command->TYPE)
        LDRB     R0,[R5, #+1]
        CMP      R0,#+2
        BNE.N    ??SDHC_send_command_3
//  271     {
//  272         xfertyp |= SDHC_XFERTYP_DPSEL_MASK;
        ORRS     R4,R4,#0x200000
//  273     }
//  274     if (ESDHC_TYPE_SWITCH_BUSY == command->TYPE)
??SDHC_send_command_3:
        LDRB     R0,[R5, #+1]
        CMP      R0,#+4
        BNE.N    ??SDHC_send_command_4
//  275     {
//  276         if ((xfertyp & SDHC_XFERTYP_RSPTYP_MASK) == SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48))
        ANDS     R0,R4,#0x30000
        CMP      R0,#+131072
        BNE.N    ??SDHC_send_command_5
//  277         {
//  278             xfertyp &= (~ SDHC_XFERTYP_RSPTYP_MASK);
        BICS     R4,R4,#0x30000
//  279             xfertyp |= SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48BUSY);
        ORRS     R4,R4,#0x30000
        B.N      ??SDHC_send_command_4
//  280         }
//  281         else
//  282         {
//  283             xfertyp &= (~ SDHC_XFERTYP_RSPTYP_MASK);
??SDHC_send_command_5:
        BICS     R4,R4,#0x30000
//  284             xfertyp |= SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48);
        ORRS     R4,R4,#0x20000
//  285         }
//  286     }
//  287     SDHC_BLKATTR &= (~ SDHC_BLKATTR_BLKCNT_MASK);
??SDHC_send_command_4:
        LDR.W    R0,??DataTable5_5  ;; 0x400b1004
        LDR      R0,[R0, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDR.W    R1,??DataTable5_5  ;; 0x400b1004
        STR      R0,[R1, #+0]
//  288     if (0 != command->BLOCKS)
        LDR      R0,[R5, #+12]
        CMP      R0,#+0
        BEQ.N    ??SDHC_send_command_6
//  289     {
//  290         if ((xfertyp & SDHC_XFERTYP_RSPTYP_MASK) != SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_48BUSY))
        ANDS     R0,R4,#0x30000
        CMP      R0,#+196608
        BEQ.N    ??SDHC_send_command_7
//  291         {
//  292             xfertyp |= SDHC_XFERTYP_DPSEL_MASK;
        ORRS     R4,R4,#0x200000
//  293         }
//  294         if (command->READ)
??SDHC_send_command_7:
        LDRB     R0,[R5, #+8]
        CMP      R0,#+0
        BEQ.N    ??SDHC_send_command_8
//  295         {
//  296             xfertyp |= SDHC_XFERTYP_DTDSEL_MASK;
        ORRS     R4,R4,#0x10
//  297         }
//  298         if (command->BLOCKS > 1)
??SDHC_send_command_8:
        LDR      R0,[R5, #+12]
        CMP      R0,#+2
        BCC.N    ??SDHC_send_command_9
//  299         {
//  300             xfertyp |= SDHC_XFERTYP_MSBSEL_MASK;
        ORRS     R4,R4,#0x20
//  301         }
//  302         if ((uint32) - 1 != command->BLOCKS)
??SDHC_send_command_9:
        LDR      R0,[R5, #+12]
        CMN      R0,#+1
        BEQ.N    ??SDHC_send_command_6
//  303         {
//  304             SDHC_BLKATTR |= SDHC_BLKATTR_BLKCNT(command->BLOCKS);
        LDR.W    R0,??DataTable5_5  ;; 0x400b1004
        LDR      R0,[R0, #+0]
        LDR      R1,[R5, #+12]
        ORRS     R0,R0,R1, LSL #+16
        LDR.W    R1,??DataTable5_5  ;; 0x400b1004
        STR      R0,[R1, #+0]
//  305             xfertyp |= SDHC_XFERTYP_BCEN_MASK;
        ORRS     R4,R4,#0x2
//  306         }
//  307     }
//  308 
//  309     /* Issue command */
//  310     SDHC_DSADDR = 0;
??SDHC_send_command_6:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_21  ;; 0x400b1000
        STR      R0,[R1, #+0]
//  311     SDHC_XFERTYP = xfertyp;
        LDR.W    R0,??DataTable5_22  ;; 0x400b100c
        STR      R4,[R0, #+0]
//  312 
//  313     /* Wait for response */
//  314     if (SDHC_status_wait (SDHC_IRQSTAT_CIE_MASK | SDHC_IRQSTAT_CEBE_MASK | SDHC_IRQSTAT_CCE_MASK | SDHC_IRQSTAT_CC_MASK) != SDHC_IRQSTAT_CC_MASK)
        LDR.W    R0,??DataTable5_23  ;; 0xe0001
        BL       SDHC_status_wait
        CMP      R0,#+1
        BEQ.N    ??SDHC_send_command_10
//  315     {
//  316         SDHC_IRQSTAT |= SDHC_IRQSTAT_CTOE_MASK | SDHC_IRQSTAT_CIE_MASK | SDHC_IRQSTAT_CEBE_MASK | SDHC_IRQSTAT_CCE_MASK | SDHC_IRQSTAT_CC_MASK;
        LDR.W    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0xF0000
        ORRS     R0,R0,#0x1
        LDR.W    R1,??DataTable5_2  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  317         return 1;
        MOVS     R0,#+1
        B.N      ??SDHC_send_command_1
//  318     }
//  319 
//  320     /* Check card removal */
//  321     if (SDHC_IRQSTAT & SDHC_IRQSTAT_CRM_MASK)
??SDHC_send_command_10:
        LDR.W    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??SDHC_send_command_11
//  322     {
//  323         SDHC_IRQSTAT |= SDHC_IRQSTAT_CTOE_MASK | SDHC_IRQSTAT_CC_MASK;
        LDR.W    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10001
        LDR.W    R1,??DataTable5_2  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  324         return 1;
        MOVS     R0,#+1
        B.N      ??SDHC_send_command_1
//  325     }
//  326 
//  327     /* Get response, if available */
//  328     if (SDHC_IRQSTAT & SDHC_IRQSTAT_CTOE_MASK)
??SDHC_send_command_11:
        LDR.W    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+15
        BPL.N    ??SDHC_send_command_12
//  329     {
//  330         SDHC_IRQSTAT |= SDHC_IRQSTAT_CTOE_MASK | SDHC_IRQSTAT_CC_MASK;
        LDR.W    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10001
        LDR.W    R1,??DataTable5_2  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  331         return -1;
        MOVS     R0,#-1
        B.N      ??SDHC_send_command_1
//  332     }
//  333     if ((xfertyp & SDHC_XFERTYP_RSPTYP_MASK) != SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_NO))
??SDHC_send_command_12:
        TST      R4,#0x30000
        BEQ.N    ??SDHC_send_command_13
//  334     {
//  335         command->RESPONSE[0] = SDHC_CMDRSP(0);
        LDR.W    R0,??DataTable5_24  ;; 0x400b1010
        LDR      R0,[R0, #+0]
        STR      R0,[R5, #+16]
//  336         if ((xfertyp & SDHC_XFERTYP_RSPTYP_MASK) == SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_136))
        ANDS     R4,R4,#0x30000
        CMP      R4,#+65536
        BNE.N    ??SDHC_send_command_13
//  337         {
//  338             command->RESPONSE[1] = SDHC_CMDRSP(1);
        LDR.W    R0,??DataTable5_25  ;; 0x400b1014
        LDR      R0,[R0, #+0]
        STR      R0,[R5, #+20]
//  339             command->RESPONSE[2] = SDHC_CMDRSP(2);
        LDR.W    R0,??DataTable5_26  ;; 0x400b1018
        LDR      R0,[R0, #+0]
        STR      R0,[R5, #+24]
//  340             command->RESPONSE[3] = SDHC_CMDRSP(3);
        LDR.W    R0,??DataTable5_27  ;; 0x400b101c
        LDR      R0,[R0, #+0]
        STR      R0,[R5, #+28]
//  341         }
//  342     }
//  343 
//  344     SDHC_IRQSTAT |= SDHC_IRQSTAT_CC_MASK;
??SDHC_send_command_13:
        LDR.W    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.W    R1,??DataTable5_2  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  345 
//  346     return 0;
        MOVS     R0,#+0
??SDHC_send_command_1:
        POP      {R1,R4,R5,PC}    ;; return
//  347 }
//  348 
//  349 
//  350 /*FUNCTION****************************************************************
//  351 *
//  352 * Function Name    : _esdhc_ioctl
//  353 * Returned Value   : MQX error code
//  354 * Comments         :
//  355 *    This function performs miscellaneous services for the ESDHC I/O device.
//  356 *
//  357 *END*********************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  358 int32 SDHC_ioctl
//  359 (
//  360     /* [IN] The command to perform */
//  361     uint32              cmd,
//  362 
//  363     /* [IN/OUT] Parameters for the command */
//  364     void                *param_ptr
//  365 )
//  366 {
SDHC_ioctl:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+36
        MOVS     R4,R1
//  367     ESDHC_INFO_STRUCT_PTR   esdhc_info_ptr;
//  368     ESDHC_DEVICE_STRUCT_PTR esdhc_device_ptr;
//  369     ESDHC_INIT_STRUCT_CPTR  esdhc_init_ptr;
//  370     ESDHC_COMMAND_STRUCT    command;
//  371     uint8                   mem, io, mmc, ceata, mp, hc;
//  372     int32                  val;
//  373     uint32                  result = ESDHC_OK;
        MOVS     R5,#+0
//  374     uint32             	    *param32_ptr = param_ptr;
//  375 
//  376     /* Check parameters */
//  377     esdhc_info_ptr = (ESDHC_INFO_STRUCT_PTR)&SDHC_Info;
        LDR.W    R9,??DataTable5_28
//  378 
//  379     if (NULL == esdhc_info_ptr)
        CMP      R9,#+0
        BNE.N    ??SDHC_ioctl_0
//  380     {
//  381         return IO_DEVICE_DOES_NOT_EXIST;
        MOVW     R0,#+2561
        B.N      ??SDHC_ioctl_1
//  382     }
//  383 
//  384     esdhc_device_ptr = &SDHC_Device;
??SDHC_ioctl_0:
        LDR.W    R1,??DataTable5_29
//  385     if (NULL == esdhc_device_ptr)
        CMP      R1,#+0
        BNE.N    ??SDHC_ioctl_2
//  386     {
//  387         return IO_ERROR_DEVICE_INVALID;
        MOVW     R0,#+2571
        B.N      ??SDHC_ioctl_1
//  388     }
//  389 
//  390     esdhc_init_ptr = esdhc_device_ptr->INIT;
??SDHC_ioctl_2:
        LDR      R1,[R1, #+0]
        STR      R1,[SP, #+32]
//  391     if (NULL == esdhc_init_ptr)
        LDR      R1,[SP, #+32]
        CMP      R1,#+0
        BNE.N    ??SDHC_ioctl_3
//  392     {
//  393         return IO_ERROR_DEVICE_INVALID;
        MOVW     R0,#+2571
        B.N      ??SDHC_ioctl_1
//  394     }
//  395 
//  396     switch (cmd)
??SDHC_ioctl_3:
        SUBS     R0,R0,#+3
        BEQ.W    ??SDHC_ioctl_4
        SUBS     R0,R0,#+6
        BEQ.W    ??SDHC_ioctl_5
        MOVW     R1,#+4856
        SUBS     R0,R0,R1
        BEQ.N    ??SDHC_ioctl_6
        SUBS     R0,R0,#+1
        BEQ.W    ??SDHC_ioctl_7
        SUBS     R0,R0,#+1
        BEQ.W    ??SDHC_ioctl_8
        SUBS     R0,R0,#+1
        BEQ.W    ??SDHC_ioctl_9
        SUBS     R0,R0,#+1
        BEQ.W    ??SDHC_ioctl_10
        SUBS     R0,R0,#+1
        BEQ.W    ??SDHC_ioctl_11
        SUBS     R0,R0,#+1
        BEQ.W    ??SDHC_ioctl_12
        SUBS     R0,R0,#+1
        BEQ.W    ??SDHC_ioctl_13
        SUBS     R0,R0,#+1
        BEQ.W    ??SDHC_ioctl_14
        B.N      ??SDHC_ioctl_15
//  397     {
//  398     case IO_IOCTL_ESDHC_INIT:
//  399 
//  400         result = SDHC_init (esdhc_info_ptr, &K60_SDHC0_init);
??SDHC_ioctl_6:
        LDR.W    R1,??DataTable5_30
        MOV      R0,R9
        BL       SDHC_init
        MOVS     R5,R0
//  401         if (ESDHC_OK != result)
        CMP      R5,#+0
        BNE.W    ??SDHC_ioctl_16
//  402         {
//  403             break;
//  404         }
//  405 
//  406         mem = FALSE;
??SDHC_ioctl_17:
        MOVS     R7,#+0
//  407         io = FALSE;
        MOVS     R8,#+0
//  408         mmc = FALSE;
        MOVS     R10,#+0
//  409         ceata = FALSE;
        MOVS     R11,#+0
//  410         hc = FALSE;
        MOVS     R4,#+0
//  411         mp = FALSE;
        MOVS     R0,#+0
//  412 
//  413         /* CMD0 - Go to idle - reset card */
//  414         command.COMMAND = ESDHC_CMD0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
//  415         command.TYPE = ESDHC_TYPE_NORMAL;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  416         command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  417         command.READ = FALSE;
        MOVS     R0,#+0
        STRB     R0,[SP, #+8]
//  418         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
//  419         if (SDHC_send_command (&command))
        MOV      R0,SP
        BL       SDHC_send_command
        CMP      R0,#+0
        BEQ.N    ??SDHC_ioctl_18
//  420         {
//  421             result = ESDHC_ERROR_INIT_FAILED;
        MOVS     R5,#+1
//  422             break;
        B.N      ??SDHC_ioctl_16
//  423         }
//  424 
//  425         //DELAY_MS(1100);
//  426         for(int xx = 0; xx < 1100; xx++)
??SDHC_ioctl_18:
        MOVS     R0,#+0
        B.N      ??SDHC_ioctl_19
//  427           for(int yy = 0; yy < 150000; yy++) ;
??SDHC_ioctl_20:
        ADDS     R1,R1,#+1
??SDHC_ioctl_21:
        LDR.W    R2,??DataTable5_31  ;; 0x249f0
        CMP      R1,R2
        BLT.N    ??SDHC_ioctl_20
        ADDS     R0,R0,#+1
??SDHC_ioctl_19:
        MOVW     R1,#+1100
        CMP      R0,R1
        BGE.N    ??SDHC_ioctl_22
        MOVS     R1,#+0
        B.N      ??SDHC_ioctl_21
//  428         /* CMD8 - Send interface condition - check HC support */
//  429         command.COMMAND = ESDHC_CMD8;
??SDHC_ioctl_22:
        MOVS     R0,#+8
        STRB     R0,[SP, #+0]
//  430         command.TYPE = ESDHC_TYPE_NORMAL;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  431         command.ARGUMENT = 0x000001AA;
        MOV      R0,#+426
        STR      R0,[SP, #+4]
//  432         command.READ = FALSE;
        MOVS     R0,#+0
        STRB     R0,[SP, #+8]
//  433         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
//  434         val = SDHC_send_command (&command);
        MOV      R0,SP
        BL       SDHC_send_command
        MOVS     R6,R0
//  435 
//  436         if (val == 0)
        CMP      R6,#+0
        BNE.N    ??SDHC_ioctl_23
//  437         {
//  438             // SDHC Card
//  439             if (command.RESPONSE[0] != command.ARGUMENT)
        LDR      R0,[SP, #+16]
        LDR      R1,[SP, #+4]
        CMP      R0,R1
        BEQ.N    ??SDHC_ioctl_24
//  440             {
//  441                 result = ESDHC_ERROR_INIT_FAILED;
        MOVS     R5,#+1
//  442                 break;
        B.N      ??SDHC_ioctl_16
//  443             }
//  444             hc = TRUE;
??SDHC_ioctl_24:
        MOVS     R4,#+1
//  445         }
//  446 
//  447         mp = TRUE;
??SDHC_ioctl_23:
        MOVS     R0,#+1
//  448 
//  449         if (mp)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.W    ??SDHC_ioctl_25
//  450         {
//  451             /* CMD55 - Application specific command - check MMC */
//  452             command.COMMAND = ESDHC_CMD55;
        MOVS     R0,#+55
        STRB     R0,[SP, #+0]
//  453             command.TYPE = ESDHC_TYPE_NORMAL;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  454             command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  455             command.READ = FALSE;
        MOVS     R0,#+0
        STRB     R0,[SP, #+8]
//  456             command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
//  457             val = SDHC_send_command (&command);
        MOV      R0,SP
        BL       SDHC_send_command
        MOVS     R6,R0
//  458             if (val > 0)
        CMP      R6,#+1
        BLT.N    ??SDHC_ioctl_26
//  459             {
//  460                 result = ESDHC_ERROR_INIT_FAILED;
        MOVS     R5,#+1
//  461                 break;
        B.N      ??SDHC_ioctl_16
//  462             }
//  463             if (val < 0)
??SDHC_ioctl_26:
        CMP      R6,#+0
        BPL.N    ??SDHC_ioctl_27
//  464             {
//  465                 /* MMC or CE-ATA */
//  466                 io = FALSE;
        MOVS     R8,#+0
//  467                 mem = FALSE;
        MOVS     R7,#+0
//  468                 hc = FALSE;
        MOVS     R4,#+0
//  469 
//  470                 /* CMD1 - Send operating conditions - check HC */
//  471                 command.COMMAND = ESDHC_CMD1;
        MOVS     R0,#+1
        STRB     R0,[SP, #+0]
//  472                 command.TYPE = ESDHC_TYPE_NORMAL;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  473                 command.ARGUMENT = 0x40300000;
        LDR.W    R0,??DataTable5_32  ;; 0x40300000
        STR      R0,[SP, #+4]
//  474                 command.READ = FALSE;
        MOVS     R0,#+0
        STRB     R0,[SP, #+8]
//  475                 command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
//  476                 if (SDHC_send_command (&command))
        MOV      R0,SP
        BL       SDHC_send_command
        CMP      R0,#+0
        BEQ.N    ??SDHC_ioctl_28
//  477                 {
//  478                     result = ESDHC_ERROR_INIT_FAILED;
        MOVS     R5,#+1
//  479                     break;
        B.N      ??SDHC_ioctl_16
//  480                 }
//  481                 if (0x20000000 == (command.RESPONSE[0] & 0x60000000))
??SDHC_ioctl_28:
        LDR      R0,[SP, #+16]
        ANDS     R0,R0,#0x60000000
        CMP      R0,#+536870912
        BNE.N    ??SDHC_ioctl_29
//  482                 {
//  483                     hc = TRUE;
        MOVS     R4,#+1
//  484                 }
//  485                 mmc = TRUE;
??SDHC_ioctl_29:
        MOVS     R10,#+1
//  486 
//  487                 /* CMD39 - Fast IO - check CE-ATA signature CE */
//  488                 command.COMMAND = ESDHC_CMD39;
        MOVS     R0,#+39
        STRB     R0,[SP, #+0]
//  489                 command.TYPE = ESDHC_TYPE_NORMAL;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  490                 command.ARGUMENT = 0x0C00;
        MOV      R0,#+3072
        STR      R0,[SP, #+4]
//  491                 command.READ = FALSE;
        MOVS     R0,#+0
        STRB     R0,[SP, #+8]
//  492                 command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
//  493                 if (SDHC_send_command (&command))
        MOV      R0,SP
        BL       SDHC_send_command
        CMP      R0,#+0
        BEQ.N    ??SDHC_ioctl_30
//  494                 {
//  495                     result = ESDHC_ERROR_INIT_FAILED;
        MOVS     R5,#+1
//  496                     break;
        B.N      ??SDHC_ioctl_16
//  497                 }
//  498                 if (0xCE == (command.RESPONSE[0] >> 8) & 0xFF)
??SDHC_ioctl_30:
        LDR      R0,[SP, #+16]
        LSRS     R0,R0,#+8
        CMP      R0,#+206
        BNE.N    ??SDHC_ioctl_31
        MOVS     R0,#+1
        B.N      ??SDHC_ioctl_32
??SDHC_ioctl_31:
        MOVS     R0,#+0
??SDHC_ioctl_32:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.W    ??SDHC_ioctl_25
//  499                 {
//  500                     /* CMD39 - Fast IO - check CE-ATA signature AA */
//  501                     command.COMMAND = ESDHC_CMD39;
        MOVS     R0,#+39
        STRB     R0,[SP, #+0]
//  502                     command.TYPE = ESDHC_TYPE_NORMAL;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  503                     command.ARGUMENT = 0x0D00;
        MOV      R0,#+3328
        STR      R0,[SP, #+4]
//  504                     command.READ = FALSE;
        MOVS     R0,#+0
        STRB     R0,[SP, #+8]
//  505                     command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
//  506                     if (SDHC_send_command (&command))
        MOV      R0,SP
        BL       SDHC_send_command
        CMP      R0,#+0
        BEQ.N    ??SDHC_ioctl_33
//  507                     {
//  508                         result = ESDHC_ERROR_INIT_FAILED;
        MOVS     R5,#+1
//  509                         break;
        B.N      ??SDHC_ioctl_16
//  510                     }
//  511                     if (0xAA == (command.RESPONSE[0] >> 8) & 0xFF)
??SDHC_ioctl_33:
        LDR      R0,[SP, #+16]
        LSRS     R0,R0,#+8
        CMP      R0,#+170
        BNE.N    ??SDHC_ioctl_34
        MOVS     R0,#+1
        B.N      ??SDHC_ioctl_35
??SDHC_ioctl_34:
        MOVS     R0,#+0
??SDHC_ioctl_35:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??SDHC_ioctl_25
//  512                     {
//  513                         mmc = FALSE;
        MOVS     R10,#+0
//  514                         ceata = TRUE;
        MOVS     R11,#+1
        B.N      ??SDHC_ioctl_25
//  515                     }
//  516                 }
//  517             }
//  518             else
//  519             {
//  520                 /* SD */
//  521                 /* ACMD41 - Send Operating Conditions */
//  522                 command.COMMAND = ESDHC_ACMD41;
??SDHC_ioctl_27:
        MOVS     R0,#+105
        STRB     R0,[SP, #+0]
//  523                 command.TYPE = ESDHC_TYPE_NORMAL;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  524                 command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  525                 command.READ = FALSE;
        MOVS     R0,#+0
        STRB     R0,[SP, #+8]
//  526                 command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
//  527                 if (SDHC_send_command (&command))
        MOV      R0,SP
        BL       SDHC_send_command
        CMP      R0,#+0
        BEQ.N    ??SDHC_ioctl_36
//  528                 {
//  529                     result = ESDHC_ERROR_INIT_FAILED;
        MOVS     R5,#+1
//  530                     break;
        B.N      ??SDHC_ioctl_16
//  531                 }
//  532                 if (command.RESPONSE[0] & 0x300000)
??SDHC_ioctl_36:
        LDR      R0,[SP, #+16]
        TST      R0,#0x300000
        BEQ.N    ??SDHC_ioctl_25
//  533                 {
//  534                     val = 0;
        MOVS     R6,#+0
//  535                     do
//  536                     {
//  537                         //DELAY_MS(BSP_ALARM_RESOLUTION);
//  538                         for(int xx = 0; xx < BSP_ALARM_RESOLUTION; xx++)
??SDHC_ioctl_37:
        MOVS     R0,#+0
        B.N      ??SDHC_ioctl_38
//  539                           for(int yy = 0; yy < 150000; yy++) ;
??SDHC_ioctl_39:
        ADDS     R1,R1,#+1
??SDHC_ioctl_40:
        LDR.W    R2,??DataTable5_31  ;; 0x249f0
        CMP      R1,R2
        BLT.N    ??SDHC_ioctl_39
        ADDS     R0,R0,#+1
??SDHC_ioctl_38:
        CMP      R0,#+10
        BGE.N    ??SDHC_ioctl_41
        MOVS     R1,#+0
        B.N      ??SDHC_ioctl_40
//  540                         val++;
??SDHC_ioctl_41:
        ADDS     R6,R6,#+1
//  541 
//  542                         /* CMD55 + ACMD41 - Send OCR */
//  543                         command.COMMAND = ESDHC_CMD55;
        MOVS     R0,#+55
        STRB     R0,[SP, #+0]
//  544                         command.TYPE = ESDHC_TYPE_NORMAL;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  545                         command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  546                         command.READ = FALSE;
        MOVS     R0,#+0
        STRB     R0,[SP, #+8]
//  547                         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
//  548                         if (SDHC_send_command (&command))
        MOV      R0,SP
        BL       SDHC_send_command
        CMP      R0,#+0
        BNE.N    ??SDHC_ioctl_42
//  549                         {
//  550                             result = ESDHC_ERROR_INIT_FAILED;
//  551                             break;
//  552                         }
//  553 
//  554                         command.COMMAND = ESDHC_ACMD41;
??SDHC_ioctl_43:
        MOVS     R0,#+105
        STRB     R0,[SP, #+0]
//  555                         command.TYPE = ESDHC_TYPE_NORMAL;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  556                         if (hc)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??SDHC_ioctl_44
//  557                         {
//  558                             command.ARGUMENT = 0x40300000;
        LDR.W    R0,??DataTable5_32  ;; 0x40300000
        STR      R0,[SP, #+4]
        B.N      ??SDHC_ioctl_45
//  559                         }
??SDHC_ioctl_42:
        MOVS     R5,#+1
        B.N      ??SDHC_ioctl_46
//  560                         else
//  561                         {
//  562                             command.ARGUMENT = 0x00300000;
??SDHC_ioctl_44:
        MOVS     R0,#+3145728
        STR      R0,[SP, #+4]
//  563                         }
//  564                         command.READ = FALSE;
??SDHC_ioctl_45:
        MOVS     R0,#+0
        STRB     R0,[SP, #+8]
//  565                         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
//  566                         if (SDHC_send_command (&command))
        MOV      R0,SP
        BL       SDHC_send_command
        CMP      R0,#+0
        BNE.N    ??SDHC_ioctl_47
//  567                         {
//  568                             result = ESDHC_ERROR_INIT_FAILED;
//  569                             break;
//  570                         }
//  571                     }
//  572                     while ((0 == (command.RESPONSE[0] & 0x80000000)) && (val < BSP_ALARM_FREQUENCY));
??SDHC_ioctl_48:
        LDR      R0,[SP, #+16]
        CMP      R0,#+0
        BMI.N    ??SDHC_ioctl_46
        CMP      R6,#+100
        BLT.N    ??SDHC_ioctl_37
        B.N      ??SDHC_ioctl_46
??SDHC_ioctl_47:
        MOVS     R5,#+1
//  573                     if (ESDHC_OK != result)
??SDHC_ioctl_46:
        CMP      R5,#+0
        BNE.W    ??SDHC_ioctl_16
//  574                     {
//  575                         break;
//  576                     }
//  577                     if (val >= BSP_ALARM_FREQUENCY)
??SDHC_ioctl_49:
        CMP      R6,#+100
        BLT.N    ??SDHC_ioctl_50
//  578                     {
//  579                         hc = FALSE;
        MOVS     R4,#+0
        B.N      ??SDHC_ioctl_25
//  580                     }
//  581                     else
//  582                     {
//  583                         mem = TRUE;
??SDHC_ioctl_50:
        MOVS     R7,#+1
//  584                         if (hc)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??SDHC_ioctl_25
//  585                         {
//  586                             hc = FALSE;
        MOVS     R4,#+0
//  587                             if (command.RESPONSE[0] & 0x40000000)
        LDR      R0,[SP, #+16]
        LSLS     R0,R0,#+1
        BPL.N    ??SDHC_ioctl_25
//  588                             {
//  589                                 hc = TRUE;
        MOVS     R4,#+1
//  590                             }
//  591                         }
//  592                     }
//  593                 }
//  594             }
//  595         }
//  596 
//  597 
//  598         if (mmc)
??SDHC_ioctl_25:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??SDHC_ioctl_51
//  599         {
//  600             esdhc_info_ptr->CARD = ESDHC_CARD_MMC;
        MOVS     R0,#+7
        STR      R0,[R9, #+0]
//  601         }
//  602         if (ceata)
??SDHC_ioctl_51:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+0
        BEQ.N    ??SDHC_ioctl_52
//  603         {
//  604             esdhc_info_ptr->CARD = ESDHC_CARD_CEATA;
        MOVS     R0,#+8
        STR      R0,[R9, #+0]
//  605         }
//  606         if (io)
??SDHC_ioctl_52:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BEQ.N    ??SDHC_ioctl_53
//  607         {
//  608             esdhc_info_ptr->CARD = ESDHC_CARD_SDIO;
        MOVS     R0,#+4
        STR      R0,[R9, #+0]
//  609         }
//  610         if (mem)
??SDHC_ioctl_53:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BEQ.N    ??SDHC_ioctl_54
//  611         {
//  612             esdhc_info_ptr->CARD = ESDHC_CARD_SD;
        MOVS     R0,#+2
        STR      R0,[R9, #+0]
//  613             if (hc)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??SDHC_ioctl_54
//  614             {
//  615                 esdhc_info_ptr->CARD = ESDHC_CARD_SDHC;
        MOVS     R0,#+3
        STR      R0,[R9, #+0]
//  616             }
//  617         }
//  618         if (io && mem)
??SDHC_ioctl_54:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BEQ.N    ??SDHC_ioctl_55
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BEQ.N    ??SDHC_ioctl_55
//  619         {
//  620             esdhc_info_ptr->CARD = ESDHC_CARD_SDCOMBO;
        MOVS     R0,#+5
        STR      R0,[R9, #+0]
//  621             if (hc)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??SDHC_ioctl_55
//  622             {
//  623                 esdhc_info_ptr->CARD = ESDHC_CARD_SDHCCOMBO;
        MOVS     R0,#+6
        STR      R0,[R9, #+0]
//  624             }
//  625         }
//  626 
//  627         /* De-Init GPIO */
//  628         PORTE_PCR(0) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D1  */
??SDHC_ioctl_55:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_10  ;; 0x4004d000
        STR      R0,[R1, #+0]
//  629         PORTE_PCR(1) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D0  */
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_11  ;; 0x4004d004
        STR      R0,[R1, #+0]
//  630         PORTE_PCR(2) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_DSE_MASK);                                          /* ESDHC.CLK */
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_12  ;; 0x4004d008
        STR      R0,[R1, #+0]
//  631         PORTE_PCR(3) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.CMD */
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_13  ;; 0x4004d00c
        STR      R0,[R1, #+0]
//  632         PORTE_PCR(4) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D3  */
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_14  ;; 0x4004d010
        STR      R0,[R1, #+0]
//  633         PORTE_PCR(5) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D2  */
        MOVS     R0,#+0
        LDR.W    R1,??DataTable5_15  ;; 0x4004d014
        STR      R0,[R1, #+0]
//  634 
//  635         /* Set the ESDHC default baud rate */
//  636         //SDHC_set_baudrate (esdhc_init_ptr->CLOCK_SPEED, esdhc_init_ptr->BAUD_RATE);
//  637         SDHC_set_baudrate (core_clk_khz_sd * 1000, esdhc_init_ptr->BAUD_RATE);
        LDR      R0,[SP, #+32]
        LDR      R1,[R0, #+4]
        LDR.W    R0,??DataTable5_9
        LDR      R0,[R0, #+0]
        MOV      R2,#+1000
        MULS     R0,R2,R0
        BL       SDHC_set_baudrate
//  638 
//  639         /* Init GPIO again */
//  640         PORTE_PCR(0) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D1  */
        MOVW     R0,#+1091
        LDR.N    R1,??DataTable5_10  ;; 0x4004d000
        STR      R0,[R1, #+0]
//  641         PORTE_PCR(1) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D0  */
        MOVW     R0,#+1091
        LDR.N    R1,??DataTable5_11  ;; 0x4004d004
        STR      R0,[R1, #+0]
//  642         PORTE_PCR(2) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_DSE_MASK);                                          /* ESDHC.CLK */
        MOV      R0,#+1088
        LDR.N    R1,??DataTable5_12  ;; 0x4004d008
        STR      R0,[R1, #+0]
//  643         PORTE_PCR(3) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.CMD */
        MOVW     R0,#+1091
        LDR.N    R1,??DataTable5_13  ;; 0x4004d00c
        STR      R0,[R1, #+0]
//  644         PORTE_PCR(4) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D3  */
        MOVW     R0,#+1091
        LDR.N    R1,??DataTable5_14  ;; 0x4004d010
        STR      R0,[R1, #+0]
//  645         PORTE_PCR(5) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D2  */
        MOVW     R0,#+1091
        LDR.N    R1,??DataTable5_15  ;; 0x4004d014
        STR      R0,[R1, #+0]
//  646 
//  647         /* Enable clock gate to SDHC module */
//  648         SIM_SCGC3 |= SIM_SCGC3_SDHC_MASK;
        LDR.N    R0,??DataTable5_16  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20000
        LDR.N    R1,??DataTable5_16  ;; 0x40048030
        STR      R0,[R1, #+0]
//  649 
//  650         break;
        B.N      ??SDHC_ioctl_16
//  651     case IO_IOCTL_ESDHC_SEND_COMMAND:
//  652         val = SDHC_send_command ((ESDHC_COMMAND_STRUCT_PTR)param32_ptr);
??SDHC_ioctl_7:
        MOVS     R0,R4
        BL       SDHC_send_command
        MOVS     R6,R0
//  653         if (val > 0)
        CMP      R6,#+1
        BLT.N    ??SDHC_ioctl_56
//  654         {
//  655             result = ESDHC_ERROR_COMMAND_FAILED;
        MOVS     R5,#+2
//  656         }
//  657         if (val < 0)
??SDHC_ioctl_56:
        CMP      R6,#+0
        BPL.N    ??SDHC_ioctl_57
//  658         {
//  659             result = ESDHC_ERROR_COMMAND_TIMEOUT;
        MOVS     R5,#+3
//  660         }
//  661         break;
??SDHC_ioctl_57:
        B.N      ??SDHC_ioctl_16
//  662     case IO_IOCTL_ESDHC_GET_BAUDRATE:
//  663         if (NULL == param32_ptr)
??SDHC_ioctl_9:
        CMP      R4,#+0
        BNE.N    ??SDHC_ioctl_58
//  664         {
//  665             result = BRTOS_INVALID_PARAMETER;
        MOVS     R5,#+12
        B.N      ??SDHC_ioctl_59
//  666         }
//  667         else
//  668         {
//  669             /* Get actual baudrate */
//  670             val = ((SDHC_SYSCTL & SDHC_SYSCTL_SDCLKFS_MASK) >> SDHC_SYSCTL_SDCLKFS_SHIFT) << 1;
??SDHC_ioctl_58:
        LDR.N    R0,??DataTable5  ;; 0x400b102c
        LDR      R6,[R0, #+0]
        LSRS     R6,R6,#+7
        ANDS     R6,R6,#0x1FE
//  671             val *= ((SDHC_SYSCTL & SDHC_SYSCTL_DVS_MASK) >> SDHC_SYSCTL_DVS_SHIFT) + 1;
        LDR.N    R0,??DataTable5  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+4,#+4
        ADDS     R0,R0,#+1
        MULS     R6,R0,R6
//  672             //*param32_ptr = (uint32)((esdhc_init_ptr->CLOCK_SPEED) / val);
//  673             *param32_ptr = (uint32)((core_clk_khz_sd * 1000) / val);
        LDR.N    R0,??DataTable5_9
        LDR      R1,[R0, #+0]
        MOV      R0,#+1000
        MULS     R1,R0,R1
        UDIV     R0,R1,R6
        STR      R0,[R4, #+0]
//  674         }
//  675         break;
??SDHC_ioctl_59:
        B.N      ??SDHC_ioctl_16
//  676     case IO_IOCTL_ESDHC_SET_BAUDRATE:
//  677         if (NULL == param32_ptr)
??SDHC_ioctl_10:
        CMP      R4,#+0
        BNE.N    ??SDHC_ioctl_60
//  678         {
//  679             result = BRTOS_INVALID_PARAMETER;
        MOVS     R5,#+12
        B.N      ??SDHC_ioctl_61
//  680         }
//  681         else if (0 == (*param32_ptr))
??SDHC_ioctl_60:
        LDR      R0,[R4, #+0]
        CMP      R0,#+0
        BNE.N    ??SDHC_ioctl_62
//  682         {
//  683             result = BRTOS_INVALID_PARAMETER;
        MOVS     R5,#+12
        B.N      ??SDHC_ioctl_61
//  684         }
//  685         else
//  686         {
//  687             if (! SDHC_is_running())
??SDHC_ioctl_62:
        BL       SDHC_is_running
        CMP      R0,#+0
        BNE.N    ??SDHC_ioctl_63
//  688             {
//  689                 /* De-Init GPIO */
//  690                 PORTE_PCR(0) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D1  */
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_10  ;; 0x4004d000
        STR      R0,[R1, #+0]
//  691                 PORTE_PCR(1) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D0  */
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_11  ;; 0x4004d004
        STR      R0,[R1, #+0]
//  692                 PORTE_PCR(2) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_DSE_MASK);                                          /* ESDHC.CLK */
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_12  ;; 0x4004d008
        STR      R0,[R1, #+0]
//  693                 PORTE_PCR(3) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.CMD */
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_13  ;; 0x4004d00c
        STR      R0,[R1, #+0]
//  694                 PORTE_PCR(4) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D3  */
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_14  ;; 0x4004d010
        STR      R0,[R1, #+0]
//  695                 PORTE_PCR(5) = 0 & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D2  */
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_15  ;; 0x4004d014
        STR      R0,[R1, #+0]
//  696 
//  697                 /* Set closest baudrate */
//  698                 //SDHC_set_baudrate (esdhc_init_ptr->CLOCK_SPEED, *param32_ptr);
//  699                 SDHC_set_baudrate (core_clk_khz_sd * 1000, *param32_ptr);
        LDR      R1,[R4, #+0]
        LDR.N    R0,??DataTable5_9
        LDR      R0,[R0, #+0]
        MOV      R2,#+1000
        MULS     R0,R2,R0
        BL       SDHC_set_baudrate
//  700 
//  701                 /* Init GPIO again */
//  702                 PORTE_PCR(0) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D1  */
        MOVW     R0,#+1091
        LDR.N    R1,??DataTable5_10  ;; 0x4004d000
        STR      R0,[R1, #+0]
//  703                 PORTE_PCR(1) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D0  */
        MOVW     R0,#+1091
        LDR.N    R1,??DataTable5_11  ;; 0x4004d004
        STR      R0,[R1, #+0]
//  704                 PORTE_PCR(2) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_DSE_MASK);                                          /* ESDHC.CLK */
        MOV      R0,#+1088
        LDR.N    R1,??DataTable5_12  ;; 0x4004d008
        STR      R0,[R1, #+0]
//  705                 PORTE_PCR(3) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.CMD */
        MOVW     R0,#+1091
        LDR.N    R1,??DataTable5_13  ;; 0x4004d00c
        STR      R0,[R1, #+0]
//  706                 PORTE_PCR(4) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D3  */
        MOVW     R0,#+1091
        LDR.N    R1,??DataTable5_14  ;; 0x4004d010
        STR      R0,[R1, #+0]
//  707                 PORTE_PCR(5) = 0xFFFF & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* ESDHC.D2  */
        MOVW     R0,#+1091
        LDR.N    R1,??DataTable5_15  ;; 0x4004d014
        STR      R0,[R1, #+0]
//  708 
//  709                 /* Enable clock gate to SDHC module */
//  710                 SIM_SCGC3 |= SIM_SCGC3_SDHC_MASK;
        LDR.N    R0,??DataTable5_16  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20000
        LDR.N    R1,??DataTable5_16  ;; 0x40048030
        STR      R0,[R1, #+0]
        B.N      ??SDHC_ioctl_61
//  711             }
//  712             else
//  713             {
//  714                 result = IO_ERROR_DEVICE_BUSY;
??SDHC_ioctl_63:
        MOVW     R5,#+2570
//  715             }
//  716         }
//  717         break;
??SDHC_ioctl_61:
        B.N      ??SDHC_ioctl_16
//  718     case IO_IOCTL_ESDHC_GET_BLOCK_SIZE:
//  719         if (NULL == param32_ptr)
??SDHC_ioctl_13:
        CMP      R4,#+0
        BNE.N    ??SDHC_ioctl_64
//  720         {
//  721             result = BRTOS_INVALID_PARAMETER;
        MOVS     R5,#+12
        B.N      ??SDHC_ioctl_65
//  722         }
//  723         else
//  724         {
//  725             /* Get actual ESDHC block size */
//  726             *param32_ptr = (SDHC_BLKATTR & SDHC_BLKATTR_BLKSIZE_MASK) >> SDHC_BLKATTR_BLKSIZE_SHIFT;
??SDHC_ioctl_64:
        LDR.N    R0,??DataTable5_5  ;; 0x400b1004
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+19       ;; ZeroExtS R0,R0,#+19,#+19
        LSRS     R0,R0,#+19
        STR      R0,[R4, #+0]
//  727         }
//  728         break;
??SDHC_ioctl_65:
        B.N      ??SDHC_ioctl_16
//  729     case IO_IOCTL_ESDHC_SET_BLOCK_SIZE:
//  730         if (NULL == param32_ptr)
??SDHC_ioctl_14:
        CMP      R4,#+0
        BNE.N    ??SDHC_ioctl_66
//  731         {
//  732             result = BRTOS_INVALID_PARAMETER;
        MOVS     R5,#+12
        B.N      ??SDHC_ioctl_67
//  733         }
//  734         else
//  735         {
//  736             /* Set actual ESDHC block size */
//  737             if (! SDHC_is_running())
??SDHC_ioctl_66:
        BL       SDHC_is_running
        CMP      R0,#+0
        BNE.N    ??SDHC_ioctl_68
//  738             {
//  739                 if (*param32_ptr > 0x0FFF)
        LDR      R0,[R4, #+0]
        CMP      R0,#+4096
        BCC.N    ??SDHC_ioctl_69
//  740                 {
//  741                     result = BRTOS_INVALID_PARAMETER;
        MOVS     R5,#+12
        B.N      ??SDHC_ioctl_67
//  742                 }
//  743                 else
//  744                 {
//  745                     SDHC_BLKATTR &= (~ SDHC_BLKATTR_BLKSIZE_MASK);
??SDHC_ioctl_69:
        LDR.N    R0,??DataTable5_5  ;; 0x400b1004
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+13
        LSLS     R0,R0,#+13
        LDR.N    R1,??DataTable5_5  ;; 0x400b1004
        STR      R0,[R1, #+0]
//  746                     SDHC_BLKATTR |= SDHC_BLKATTR_BLKSIZE(*param32_ptr);
        LDR.N    R0,??DataTable5_5  ;; 0x400b1004
        LDR      R0,[R0, #+0]
        LDR      R1,[R4, #+0]
        LSLS     R1,R1,#+19       ;; ZeroExtS R1,R1,#+19,#+19
        LSRS     R1,R1,#+19
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable5_5  ;; 0x400b1004
        STR      R0,[R1, #+0]
        B.N      ??SDHC_ioctl_67
//  747                 }
//  748             }
//  749             else
//  750             {
//  751                 result = IO_ERROR_DEVICE_BUSY;
??SDHC_ioctl_68:
        MOVW     R5,#+2570
//  752             }
//  753         }
//  754         break;
??SDHC_ioctl_67:
        B.N      ??SDHC_ioctl_16
//  755     case IO_IOCTL_ESDHC_GET_BUS_WIDTH:
//  756         if (NULL == param32_ptr)
??SDHC_ioctl_11:
        CMP      R4,#+0
        BNE.N    ??SDHC_ioctl_70
//  757         {
//  758             result = BRTOS_INVALID_PARAMETER;
        MOVS     R5,#+12
        B.N      ??SDHC_ioctl_71
//  759         }
//  760         else
//  761         {
//  762             /* Get actual ESDHC bus width */
//  763             val = (SDHC_PROCTL & SDHC_PROCTL_DTW_MASK) >> SDHC_PROCTL_DTW_SHIFT;
??SDHC_ioctl_70:
        LDR.N    R0,??DataTable5_6  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        UBFX     R6,R0,#+1,#+2
//  764             if (ESDHC_PROCTL_DTW_1BIT == val)
        CMP      R6,#+0
        BNE.N    ??SDHC_ioctl_72
//  765             {
//  766                 *param32_ptr = ESDHC_BUS_WIDTH_1BIT;
        MOVS     R0,#+0
        STR      R0,[R4, #+0]
        B.N      ??SDHC_ioctl_71
//  767             }
//  768             else if (ESDHC_PROCTL_DTW_4BIT == val)
??SDHC_ioctl_72:
        CMP      R6,#+1
        BNE.N    ??SDHC_ioctl_73
//  769             {
//  770                 *param32_ptr = ESDHC_BUS_WIDTH_4BIT;
        MOVS     R0,#+1
        STR      R0,[R4, #+0]
        B.N      ??SDHC_ioctl_71
//  771             }
//  772             else if (ESDHC_PROCTL_DTW_8BIT == val)
??SDHC_ioctl_73:
        CMP      R6,#+16
        BNE.N    ??SDHC_ioctl_74
//  773             {
//  774                 *param32_ptr = ESDHC_BUS_WIDTH_8BIT;
        MOVS     R0,#+2
        STR      R0,[R4, #+0]
        B.N      ??SDHC_ioctl_71
//  775             }
//  776             else
//  777             {
//  778                 result = ESDHC_ERROR_INVALID_BUS_WIDTH;
??SDHC_ioctl_74:
        MOVS     R5,#+5
//  779             }
//  780         }
//  781         break;
??SDHC_ioctl_71:
        B.N      ??SDHC_ioctl_16
//  782     case IO_IOCTL_ESDHC_SET_BUS_WIDTH:
//  783         if (NULL == param32_ptr)
??SDHC_ioctl_12:
        CMP      R4,#+0
        BNE.N    ??SDHC_ioctl_75
//  784         {
//  785             result = BRTOS_INVALID_PARAMETER;
        MOVS     R5,#+12
        B.N      ??SDHC_ioctl_76
//  786         }
//  787         else
//  788         {
//  789             /* Set actual ESDHC bus width */
//  790             if (! SDHC_is_running())
??SDHC_ioctl_75:
        BL       SDHC_is_running
        CMP      R0,#+0
        BNE.N    ??SDHC_ioctl_77
//  791             {
//  792                 if (ESDHC_BUS_WIDTH_1BIT == *param32_ptr)
        LDR      R0,[R4, #+0]
        CMP      R0,#+0
        BNE.N    ??SDHC_ioctl_78
//  793                 {
//  794                     SDHC_PROCTL &= (~ SDHC_PROCTL_DTW_MASK);
        LDR.N    R0,??DataTable5_6  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x6
        LDR.N    R1,??DataTable5_6  ;; 0x400b1028
        STR      R0,[R1, #+0]
//  795                     SDHC_PROCTL |= SDHC_PROCTL_DTW(ESDHC_PROCTL_DTW_1BIT);
        LDR.N    R0,??DataTable5_6  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable5_6  ;; 0x400b1028
        STR      R0,[R1, #+0]
        B.N      ??SDHC_ioctl_76
//  796                 }
//  797                 else if (ESDHC_BUS_WIDTH_4BIT == *param32_ptr)
??SDHC_ioctl_78:
        LDR      R0,[R4, #+0]
        CMP      R0,#+1
        BNE.N    ??SDHC_ioctl_79
//  798                 {
//  799                     SDHC_PROCTL &= (~ SDHC_PROCTL_DTW_MASK);
        LDR.N    R0,??DataTable5_6  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x6
        LDR.N    R1,??DataTable5_6  ;; 0x400b1028
        STR      R0,[R1, #+0]
//  800                     SDHC_PROCTL |= SDHC_PROCTL_DTW(ESDHC_PROCTL_DTW_4BIT);
        LDR.N    R0,??DataTable5_6  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable5_6  ;; 0x400b1028
        STR      R0,[R1, #+0]
        B.N      ??SDHC_ioctl_76
//  801                 }
//  802                 else if (ESDHC_BUS_WIDTH_8BIT == *param32_ptr)
??SDHC_ioctl_79:
        LDR      R0,[R4, #+0]
        CMP      R0,#+2
        BNE.N    ??SDHC_ioctl_80
//  803                 {
//  804                     SDHC_PROCTL &= (~ SDHC_PROCTL_DTW_MASK);
        LDR.N    R0,??DataTable5_6  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x6
        LDR.N    R1,??DataTable5_6  ;; 0x400b1028
        STR      R0,[R1, #+0]
//  805                     SDHC_PROCTL |= SDHC_PROCTL_DTW(ESDHC_PROCTL_DTW_8BIT);
        LDR.N    R0,??DataTable5_6  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable5_6  ;; 0x400b1028
        STR      R0,[R1, #+0]
        B.N      ??SDHC_ioctl_76
//  806                 }
//  807                 else
//  808                 {
//  809                     result = ESDHC_ERROR_INVALID_BUS_WIDTH;
??SDHC_ioctl_80:
        MOVS     R5,#+5
        B.N      ??SDHC_ioctl_76
//  810                 }
//  811             }
//  812             else
//  813             {
//  814                 result = IO_ERROR_DEVICE_BUSY;
??SDHC_ioctl_77:
        MOVW     R5,#+2570
//  815             }
//  816         }
//  817         break;
??SDHC_ioctl_76:
        B.N      ??SDHC_ioctl_16
//  818     case IO_IOCTL_ESDHC_GET_CARD:
//  819         if (NULL == param32_ptr)
??SDHC_ioctl_8:
        CMP      R4,#+0
        BNE.N    ??SDHC_ioctl_81
//  820         {
//  821             result = BRTOS_INVALID_PARAMETER;
        MOVS     R5,#+12
        B.N      ??SDHC_ioctl_82
//  822         }
//  823         else
//  824         {
//  825             /* 80 clocks to update levels */
//  826             SDHC_SYSCTL |= SDHC_SYSCTL_INITA_MASK;
??SDHC_ioctl_81:
        LDR.N    R0,??DataTable5  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.N    R1,??DataTable5  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  827             while (SDHC_SYSCTL & SDHC_SYSCTL_INITA_MASK)
??SDHC_ioctl_83:
        LDR.N    R0,??DataTable5  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4
        BMI.N    ??SDHC_ioctl_83
//  828                 { };
//  829 
//  830             /* Update and return actual card status */
//  831             if (SDHC_IRQSTAT & SDHC_IRQSTAT_CRM_MASK)
        LDR.N    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??SDHC_ioctl_84
//  832             {
//  833                 SDHC_IRQSTAT |= SDHC_IRQSTAT_CRM_MASK;
        LDR.N    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable5_2  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  834                 esdhc_info_ptr->CARD = ESDHC_CARD_NONE;
        MOVS     R0,#+0
        STR      R0,[R9, #+0]
//  835             }
//  836             if (SDHC_PRSSTAT & SDHC_PRSSTAT_CINS_MASK)
??SDHC_ioctl_84:
        LDR.N    R0,??DataTable5_1  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+15
        BPL.N    ??SDHC_ioctl_85
//  837             {
//  838                 if (ESDHC_CARD_NONE == esdhc_info_ptr->CARD)
        LDR      R0,[R9, #+0]
        CMP      R0,#+0
        BNE.N    ??SDHC_ioctl_86
//  839                 {
//  840                     esdhc_info_ptr->CARD = ESDHC_CARD_UNKNOWN;
        MOVS     R0,#+1
        STR      R0,[R9, #+0]
        B.N      ??SDHC_ioctl_86
//  841                 }
//  842             }
//  843             else
//  844             {
//  845                 esdhc_info_ptr->CARD = ESDHC_CARD_NONE;
??SDHC_ioctl_85:
        MOVS     R0,#+0
        STR      R0,[R9, #+0]
//  846             }
//  847             *param32_ptr = esdhc_info_ptr->CARD;
??SDHC_ioctl_86:
        LDR      R0,[R9, #+0]
        STR      R0,[R4, #+0]
//  848         }
//  849         break;
??SDHC_ioctl_82:
        B.N      ??SDHC_ioctl_16
//  850     case IO_IOCTL_DEVICE_IDENTIFY:
//  851         /* Get ESDHC device parameters */
//  852         param32_ptr[IO_IOCTL_ID_PHY_ELEMENT]  = IO_DEV_TYPE_PHYS_ESDHC;
??SDHC_ioctl_5:
        MOVS     R0,#+28
        STR      R0,[R4, #+0]
//  853         param32_ptr[IO_IOCTL_ID_LOG_ELEMENT]  = IO_DEV_TYPE_LOGICAL_MFS;
        MOVS     R0,#+4
        STR      R0,[R4, #+4]
//  854         param32_ptr[IO_IOCTL_ID_ATTR_ELEMENT] = IO_ESDHC_ATTRIBS;
        MOV      R0,#+632
        STR      R0,[R4, #+8]
//  855         /*
//  856         if (esdhc_fd_ptr->FLAGS & IO_O_RDONLY)
//  857         {
//  858             param32_ptr[IO_IOCTL_ID_ATTR_ELEMENT] &= (~ IO_DEV_ATTR_WRITE);
//  859         }
//  860         */
//  861         break;
        B.N      ??SDHC_ioctl_16
//  862     case IO_IOCTL_FLUSH_OUTPUT:
//  863         /* Wait for transfer complete */
//  864         SDHC_status_wait (SDHC_IRQSTAT_TC_MASK);
??SDHC_ioctl_4:
        MOVS     R0,#+2
        BL       SDHC_status_wait
//  865         if (SDHC_IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
        LDR.N    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        TST      R0,#0x700000
        BEQ.N    ??SDHC_ioctl_87
//  866         {
//  867             SDHC_IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK;
        LDR.N    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x700000
        LDR.N    R1,??DataTable5_2  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  868             result = ESDHC_ERROR_DATA_TRANSFER;
        MOVS     R5,#+4
//  869         }
//  870         SDHC_IRQSTAT |= SDHC_IRQSTAT_TC_MASK | SDHC_IRQSTAT_BRR_MASK | SDHC_IRQSTAT_BWR_MASK;
??SDHC_ioctl_87:
        LDR.N    R0,??DataTable5_2  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x32
        LDR.N    R1,??DataTable5_2  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  871         break;
        B.N      ??SDHC_ioctl_16
//  872     default:
//  873         result = IO_ERROR_INVALID_IOCTL_CMD;
??SDHC_ioctl_15:
        MOVW     R5,#+2569
//  874         break;
//  875     }
//  876     return result;
??SDHC_ioctl_16:
        MOVS     R0,R5
??SDHC_ioctl_1:
        ADD      SP,SP,#+36
        POP      {R4-R11,PC}      ;; return
//  877 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     0x400b102c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     0x400b1024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     0x400b1030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     0x1008000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     0x400b10c0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     0x400b1004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     0x400b1028

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     0x400b1044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_8:
        DC32     0x5cc60

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_9:
        DC32     core_clk_khz_sd

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_10:
        DC32     0x4004d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_11:
        DC32     0x4004d004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_12:
        DC32     0x4004d008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_13:
        DC32     0x4004d00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_14:
        DC32     0x4004d010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_15:
        DC32     0x4004d014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_16:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_17:
        DC32     0x7f00b3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_18:
        DC32     0x400b1034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_19:
        DC32     ESDHC_COMMAND_XFERTYP

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_20:
        DC32     0x400b1008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_21:
        DC32     0x400b1000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_22:
        DC32     0x400b100c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_23:
        DC32     0xe0001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_24:
        DC32     0x400b1010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_25:
        DC32     0x400b1014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_26:
        DC32     0x400b1018

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_27:
        DC32     0x400b101c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_28:
        DC32     SDHC_Info

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_29:
        DC32     SDHC_Device

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_30:
        DC32     K60_SDHC0_init

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_31:
        DC32     0x249f0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_32:
        DC32     0x40300000

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 
//   548 bytes in section .bss
//     4 bytes in section .data
//   264 bytes in section .rodata
// 2 590 bytes in section .text
// 
// 2 590 bytes of CODE  memory
//   264 bytes of CONST memory
//   552 bytes of DATA  memory
//
//Errors: none
//Warnings: none
