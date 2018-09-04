///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.30.3.8024/W32 for ARM       14/Mar/2018  19:12:11
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Component_C\DMA.c
//    Command line =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Component_C\DMA.c
//        -D IAR -D TWR_K60N512 -lCN
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\List\ -lB
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\List\ -o
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\Obj\ --no_cse
//        --no_unroll --no_inline --no_code_motion --no_tbaa --no_clustering
//        --no_scheduling --debug --endian=little --cpu=Cortex-M4 -e --fpu=None
//        --dlib_config "C:\Program Files (x86)\IAR Systems\Embedded Workbench
//        7.0\arm\INC\c\DLib_Config_Normal.h" -I
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\H\ -I
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\H\Component_H\
//        -I E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\H\Frame_H\
//        -I
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\H\Function_H\
//        -I E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\H\SD_H\ -Ol
//        --use_c++_inline
//    List file    =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\List\DMA.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN enable_irq

        PUBLIC DMAFlag
        PUBLIC DMAInit
        PUBLIC enable_DMA_irq

// E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Component_C\DMA.c
//    1 //==============================================================================
//    2 //文件名称：DMA.c
//    3 //功能概要：K60 DMA底层驱动程序文件
//    4 //版权所有：HJZ
//    5 //端口使用：
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
//   15 // 这是给OV7725准备的DMA初始化函数
//   16 uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint32 DMA_Count, uint32 S_Addr, uint32 D_Addr)
//   17 {
//   18     //输入变量初步检查
//   19 	if (DMA_CHn > 15) return 0;                
//   20 	if (DMA_Source > 52) return 0; 
//   21 
//   22 	//DMA通道配置
//   23 	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //打开DMA多路复用时钟
//   24 	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //打开DMA模块时钟
//   25 	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
//   26 		                                   | DMAMUX_CHCFG_ENBL_MASK			        // 使能DMA通道 
//   27                                                    //| DMAMUX_CHCFG_TRIG_MASK				// 打开周期性触发模式，注意只有0~3通道支持
//   28                                                    | DMAMUX_CHCFG_SOURCE(DMA_Source)      // 指定DMA触发源 
//   29 		                                   );
//   30     
//   31 	DMA_CR = 0;												  // 默认配置，需要在DMA被激活之前配置此寄存器
//   32 	//DMA_DCHPRIn										      // 默认优先级配置，这里不另更改
//   33 	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // 主循环计数器，1个major loop, 即一次传输量=major_loop*minor_loop，最大为2^15=32767 
//   34 	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // 主循环计数器复位值，BITER应该等于CITER 
//   35 	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // 每次minor loop传送1个字节
//   36 
//   37 	//源地址操作
//   38 	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMA源地址
//   39 	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // 每次读源地址后，增加的字节数
//   40 	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA所有主循环完成后，源地址的增量
//   41 
//   42 	//目的地址操作
//   43 	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMA目标地址 
//   44 	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // 每次写目的地址后，增加的字节数
//   45 	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = 0x00;		      // DMA所有主循环完成后，目的地址的增量
//   46 	
//   47 	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
//   48 		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
//   49 		                              | DMA_ATTR_SSIZE(0)	  // 源数据宽度，   8位传送 
//   50 		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
//   51 		                              | DMA_ATTR_DSIZE(0)	  // 目的数据宽度， 8位传送 
//   52 		                              );
//   53 
//   54 	//CSR寄存器操作
//   55 	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;						  // 先清零CSR，之后再设置 
//   56         DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_BWC(3);    //每读1次，eDMA引擎停止8个周期
//   57 	DMA_INT |= (1<<DMA_CHn);	                        // 1次主循环传输完成后的中断标志位，清零 
//   58 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1次主循环传输完成后的中断使能位，使能 
//   59 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1次DMA传输完成后，自动清REQ位，停止工作 
//   60 
//   61 	//DMA启停位
//   62 	DMA_ERQ &= ~(1 << DMA_CHn);						      // 关闭相应通道的DMA请求，在配置阶段先关闭，再调用myDMA_Start函数开启DMA 
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
//   75 //函数名：DMAInit
//   76 //功  能：DMA初始化
//   77 //参  数：
//   78 //        DMA_CHn--指定的DMA通道号，范围0~15；
//   79 //        DMA_Source--DMA触发源，在DMA.h文件里有枚举定义
//   80 //        S_Addr--DMA传送源地址
//   81 //        D_Addr--DMA传送目的地址
//   82 //返  回：无
//   83 //说  明：对应OV7620，不是7725。7725用不到行中断。
//   84 //        1. 1次PCLK的硬件触发会导致1次DMA主循环，1次DMA主循环传输只有1个8位数据的传送，传送完成后目的地址会加1，直至目的数组被填满。
//   85 //        2. CAMERA_LINE次主循环后，视为"DMA传输完成"，会引发DMA传输完成中断，进入DMA传输完成中断服务函数。
//   86 //        3. DMA传输完成中断服务函数中，先清DMA传输完成中断标志位，再把行数加1。
//   87 //        4. 初始化时只打开场中断和DMA传输完成中断的IRQ，场中断中，先清自身标志位，然后初始化行数，然后打开行中断，并重复一次DMA的初始化。
//   88 //        5. 行中断中，先清自身标志位，如果没超过，就打开ERQ,如果超过了，就关行中断的IRQ。
//   89 //
//   90 //        
//   91 
//   92 //------------------------------------------------------------------------------
//   93 
//   94 
//   95 //这是给OV7620准备的DMA初始化函数，暂时先不要动
//   96 //DMA通道0，B0~B7为数据源地址，ImgSotre数组为目的地址。
//   97 //每次硬件触发传送1字节，同时目标地址加1个字节。
//   98 //采集完1行像素后进入DMA中断，此时源地址不变，目的地址加1行像素所占字节数。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   99 uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint16 DMA_Count, uint32 S_Addr, uint32 D_Addr)
//  100 {
DMAInit:
        PUSH     {R4,R5}
//  101     //输入变量初步检查
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
//  105 	//DMA通道配置
//  106 	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //打开DMA多路复用时钟
??DMAInit_2:
        LDR.N    R4,??DataTable0  ;; 0x4004803c
        LDR      R4,[R4, #+0]
        ORRS     R4,R4,#0x2
        LDR.N    R5,??DataTable0  ;; 0x4004803c
        STR      R4,[R5, #+0]
//  107 	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //打开DMA模块时钟
        LDR.N    R4,??DataTable0_1  ;; 0x40048040
        LDR      R4,[R4, #+0]
        ORRS     R4,R4,#0x2
        LDR.N    R5,??DataTable0_1  ;; 0x40048040
        STR      R4,[R5, #+0]
//  108 	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
//  109 	                                           | DMAMUX_CHCFG_ENBL_MASK		// 使能DMA通道 
//  110                                                  //| DMAMUX_CHCFG_TRIG_MASK		// 打开周期性触发模式，注意只有0~3通道支持
//  111                                                    | DMAMUX_CHCFG_SOURCE(DMA_Source) // 指定DMA触发源 
//  112                                                     );
        ANDS     R1,R1,#0x3F
        ORRS     R1,R1,#0x80
        LDR.N    R4,??DataTable0_2  ;; 0x40021000
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STRB     R1,[R0, R4]
//  113     
//  114 	DMA_CR = 0;												  // 默认配置，需要在DMA被激活之前配置此寄存器
        MOVS     R1,#+0
        LDR.N    R4,??DataTable0_3  ;; 0x40008000
        STR      R1,[R4, #+0]
//  115 	//DMA_DCHPRIn										      // 默认优先级配置，这里不另更改
//  116 	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // 主循环计数器，1个major loop, 即一次传输量=major_loop*minor_loop，最大为2^15=32767 
        LSLS     R1,R2,#+17       ;; ZeroExtS R1,R2,#+17,#+17
        LSRS     R1,R1,#+17
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R4,R0,#+5
        ADD      R4,R4,#+1073741824
        ADDS     R4,R4,#+36864
        STRH     R1,[R4, #+22]
//  117 	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // 主循环计数器复位值，BITER应该等于CITER 
        LSLS     R1,R2,#+17       ;; ZeroExtS R1,R2,#+17,#+17
        LSRS     R1,R1,#+17
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+30]
//  118 	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // 每次minor loop传送1个字节
        MOVS     R1,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STR      R1,[R2, #+8]
//  119 
//  120 	//源地址操作
//  121 	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMA源地址
        LDR.N    R1,??DataTable0_4  ;; 0x40009000
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        STR      R3,[R2, R1]
//  122 	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // 每次读源地址后，增加的字节数
        MOVS     R1,#+0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+4]
//  123 	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA所有主循环完成后，源地址的增量
        MOVS     R1,#+0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STR      R1,[R2, #+12]
//  124 
//  125 	//目的地址操作
//  126 	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMA目标地址 
        LDR      R1,[SP, #+8]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STR      R1,[R2, #+16]
//  127 	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // 每次写目的地址后，增加的字节数
        MOVS     R1,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+20]
//  128 	//DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = CameraWidth;		      // DMA所有主循环完成后，目的地址的增量
//  129 	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = 0;      /////////////////////////两个数字不知道哪个是对的
        MOVS     R1,#+0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STR      R1,[R2, #+24]
//  130         
//  131 	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
//  132 		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
//  133 		                              | DMA_ATTR_SSIZE(0)	  // 源数据宽度，   8位传送 
//  134 		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
//  135 		                              | DMA_ATTR_DSIZE(0)	  // 目的数据宽度， 8位传送 
//  136 		                              );
        MOVS     R1,#+0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+6]
//  137 
//  138 	//CSR寄存器操作
//  139 	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;				// 先清零CSR，之后再设置 
        MOVS     R1,#+0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R2,R0,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+28]
//  140 	DMA_INT |= (1<<DMA_CHn);					// 1次主循环传输完成后的中断标志位，清零 
        LDR.N    R1,??DataTable0_5  ;; 0x40008024
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LSLS     R2,R2,R0
        ORRS     R1,R2,R1
        LDR.N    R2,??DataTable0_5  ;; 0x40008024
        STR      R1,[R2, #+0]
//  141 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1次主循环传输完成后的中断使能位，使能 
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
//  142 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1次DMA传输完成后，自动清REQ位，停止工作 
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
//  144 	//DMA启停位
//  145 	DMA_ERQ &= ~(1 << DMA_CHn);		// 关闭相应通道的DMA请求，在配置阶段先关闭
        LDR.N    R1,??DataTable0_6  ;; 0x4000800c
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LSLS     R0,R2,R0
        BICS     R0,R1,R0
        LDR.N    R1,??DataTable0_6  ;; 0x4000800c
        STR      R0,[R1, #+0]
//  146                                                               // 所有主循环(不是1次主循环)完成后，ERQ会被自动清零，需要行中断中再次手动开启。
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
//  152 /*  这是给DMA测试专用的DMA初始化函数，暂时不用动
//  153 uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint32 S_Addr, uint32 D_Addr)
//  154 {
//  155     //输入变量初步检查
//  156 	if (DMA_CHn > 15) return 0;                
//  157 	if (DMA_Source > 52) return 0; 
//  158 
//  159 	//DMA通道配置
//  160 	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //打开DMA多路复用时钟
//  161 	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //打开DMA模块时钟
//  162 	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
//  163 												  | DMAMUX_CHCFG_ENBL_MASK			        // 使能DMA通道 
//  164 												  //| DMAMUX_CHCFG_TRIG_MASK				// 打开周期性触发模式，注意只有0~3通道支持
//  165 												  | DMAMUX_CHCFG_SOURCE(DMA_Source)      // 指定DMA触发源 
//  166 												  );
//  167     
//  168 	DMA_CR = 0;												  // 默认配置，需要在DMA被激活之前配置此寄存器
//  169 	//DMA_DCHPRIn										      // 默认优先级配置，这里不另更改
//  170 	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(10); // 主循环计数器，1个major loop, 即一次传输量=major_loop*minor_loop，最大为2^15=32767 
//  171 	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(10); // 主循环计数器复位值，BITER应该等于CITER 
//  172 	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // 每次minor loop传送1个字节
//  173 
//  174 	//源地址操作
//  175 	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMA源地址
//  176 	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // 每次读源地址后，增加的字节数
//  177 	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA所有主循环完成后，源地址的增量
//  178 
//  179 	//目的地址操作
//  180 	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMA目标地址 
//  181 	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // 每次写目的地址后，增加的字节数
//  182 	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = -10;		      // DMA所有主循环完成后，目的地址的增量
//  183 	
//  184 	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
//  185 		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
//  186 		                              | DMA_ATTR_SSIZE(0)	  // 源数据宽度，   8位传送 
//  187 		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
//  188 		                              | DMA_ATTR_DSIZE(0)	  // 目的数据宽度， 8位传送 
//  189 		                              );
//  190 
//  191 	//CSR寄存器操作
//  192 	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;						  // 先清零CSR，之后再设置 
//  193 	DMA_INT |= (1<<DMA_CHn);						// 1次主循环传输完成后的中断标志位，清零 
//  194 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1次主循环传输完成后的中断使能位，使能 
//  195 	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1次DMA传输完成后，自动清REQ位，停止工作 
//  196 
//  197 	//DMA启停位
//  198 	DMA_ERQ &= ~(1 << DMA_CHn);						      // 关闭相应通道的DMA请求，在配置阶段先关闭，再调用myDMA_Start函数开启DMA 
//  199                                                               // 所有主循环(不是1次主循环)完成后，ERQ会被自动清零，需要行中断中再次手动开启。
//  200 	return 1;
//  201 
//  202 }// end of DMAInit()
//  203 
//  204 */
//  205 
//  206 //下面几个函数应该放在isr.c 中，只是暂存于此
//  207 /*
//  208 void DMA_CHO_ISR(void)
//  209 {
//  210 		DMA_INT|=DMA_INT_INT0_MASK;//清除通道0中断
//  211 			//putstr("DMA complete！");
//  212 				row_F[imagerow]=1;//采集完成标志
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
//  224 void portb_isr(void)//行中断，B10，上升沿中断
//  225 {
//  226 	PORTB_PCR10|=PORT_PCR_ISF_MASK;//清除中断标志位
//  227 	row++; //行计数
//  228 	if(row==data_table[imagerow])//如果当前行数据应该采集 
//  229 		{
//  230 		DMA_ERQ|=DMA_ERQ_ERQ0_MASK;//使能通道0硬件DMA请求  
//  231 		}
//  232 	  else if(row>=ENDROW) //一场完成，关闭行中断
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
//  247     enable_irq(0);			      //开DMA通道0的IRQ中断
??enable_DMA_irq_0:
        MOVS     R0,#+0
        BL       enable_irq
//  248     break;
        B.N      ??enable_DMA_irq_17
//  249     case 1:
//  250     enable_irq(1);			      //开DMA通道1的IRQ中断
??enable_DMA_irq_2:
        MOVS     R0,#+1
        BL       enable_irq
//  251     break;
        B.N      ??enable_DMA_irq_17
//  252     case 2:
//  253     enable_irq(2);			     //开DMA通道2的IRQ中断
??enable_DMA_irq_1:
        MOVS     R0,#+2
        BL       enable_irq
//  254     break;
        B.N      ??enable_DMA_irq_17
//  255     case 3:
//  256     enable_irq(3);			      //开DMA通道3的IRQ中断
??enable_DMA_irq_4:
        MOVS     R0,#+3
        BL       enable_irq
//  257     break;
        B.N      ??enable_DMA_irq_17
//  258     case 4:
//  259     enable_irq(4);			      //开DMA通道4的IRQ中断
??enable_DMA_irq_3:
        MOVS     R0,#+4
        BL       enable_irq
//  260     break;
        B.N      ??enable_DMA_irq_17
//  261     case 5:
//  262     enable_irq(5);			      //开DMA通道5的IRQ中断
??enable_DMA_irq_6:
        MOVS     R0,#+5
        BL       enable_irq
//  263     break;
        B.N      ??enable_DMA_irq_17
//  264     case 6:
//  265     enable_irq(6);			     //开DMA通道6的IRQ中断
??enable_DMA_irq_5:
        MOVS     R0,#+6
        BL       enable_irq
//  266     break;
        B.N      ??enable_DMA_irq_17
//  267     case 7:
//  268     enable_irq(7);			      //开DMA通道7的IRQ中断
??enable_DMA_irq_8:
        MOVS     R0,#+7
        BL       enable_irq
//  269     break;
        B.N      ??enable_DMA_irq_17
//  270     case 8:
//  271     enable_irq(8);			      //开DMA通道8的IRQ中断
??enable_DMA_irq_7:
        MOVS     R0,#+8
        BL       enable_irq
//  272     break;
        B.N      ??enable_DMA_irq_17
//  273     case 9:
//  274     enable_irq(9);			      //开DMA通道9的IRQ中断
??enable_DMA_irq_10:
        MOVS     R0,#+9
        BL       enable_irq
//  275     break;
        B.N      ??enable_DMA_irq_17
//  276     case 10:
//  277     enable_irq(10);			     //开DMA通道10的IRQ中断
??enable_DMA_irq_9:
        MOVS     R0,#+10
        BL       enable_irq
//  278     break;
        B.N      ??enable_DMA_irq_17
//  279     case 11:
//  280     enable_irq(11);			      //开DMA通道11的IRQ中断
??enable_DMA_irq_12:
        MOVS     R0,#+11
        BL       enable_irq
//  281     break;
        B.N      ??enable_DMA_irq_17
//  282     case 12:
//  283     enable_irq(12);			      //开DMA通道12的IRQ中断
??enable_DMA_irq_11:
        MOVS     R0,#+12
        BL       enable_irq
//  284     break;
        B.N      ??enable_DMA_irq_17
//  285     case 13:
//  286     enable_irq(13);			      //开DMA通道13的IRQ中断
??enable_DMA_irq_14:
        MOVS     R0,#+13
        BL       enable_irq
//  287     break;
        B.N      ??enable_DMA_irq_17
//  288     case 14:
//  289     enable_irq(14);			     //开DMA通道14的IRQ中断
??enable_DMA_irq_13:
        MOVS     R0,#+14
        BL       enable_irq
//  290     break;
        B.N      ??enable_DMA_irq_17
//  291     case 15:
//  292     enable_irq(15);			      //开DMA通道15的IRQ中断
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
