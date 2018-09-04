///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       06/Feb/2018  21:44:12
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Component_C\adc.c
//    Command line =  
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Component_C\adc.c
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
//    List file    =  D:\智能车\程序\下位机程序_摄像头1队\FLASH\List\adc.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC ADResult0
        PUBLIC ADResult1
        PUBLIC ADResult2
        PUBLIC ADResult3
        PUBLIC ADResult4
        PUBLIC ADResult5
        PUBLIC ADResultCom
        PUBLIC GryoDeal
        PUBLIC GryoFlatCount
        PUBLIC GryoFlatFlag
        PUBLIC GyroInit
        PUBLIC GyroResult
        PUBLIC GyroResultFlag
        PUBLIC GyroResultForbidBackCount
        PUBLIC GyroResultForbidBackCountNum
        PUBLIC GyroResultForbidFlag
        PUBLIC hw_ad_ave
        PUBLIC hw_ad_mid
        PUBLIC hw_ad_once
        PUBLIC hw_adc_init

// D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Component_C\adc.c
//    1 //============================================================================
//    2 //文件名称：adc.c  
//    3 //功能概要：adc构件源文件
//    4 //版权所有：HJF
//    5 //版本更新：2011-11-13  V1.0   初始版本
//    6 //          2011-11-21   V1.1   规范排版风格
//    7 //============================================================================
//    8 
//    9 #include "adc.h"
//   10 
//   11 //AD采样结果。

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   12 int16 ADResult0 = 0;
ADResult0:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   13 int16 ADResult1 = 0;
ADResult1:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   14 int16 ADResult2 = 0;
ADResult2:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   15 int16 ADResult3 = 0;
ADResult3:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   16 int16 ADResult4 = 0;
ADResult4:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   17 int16 ADResult5 = 0;
ADResult5:
        DS8 2
//   18 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   19 uint16 ADResultCom;    //温漂修正
ADResultCom:
        DS8 2
//   20 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   21 uint32 GryoFlatCount = 0; //陀螺仪，平路计数。
GryoFlatCount:
        DS8 4

        SECTION `.data`:DATA:REORDER:NOROOT(0)
//   22 uint8 GryoFlatFlag = 1;   //陀螺仪，平路标志。1平路，0坡。
GryoFlatFlag:
        DATA
        DC8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   23 int16 GyroResult[GyroResultNum];  //陀螺仪，角度储存数组。
GyroResult:
        DS8 20

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   24 uint8 GyroResultFlag = 0;   //陀螺仪，坡道判断。0平路，1上坡，2下坡。
GyroResultFlag:
        DS8 1
//   25 
//   26 //禁止赛道类型判断

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   27 uint8 GyroResultForbidFlag = 0;           //坡道禁止赛道类型判断标志，1表示禁止任何赛道类型判断，0表示不禁止。
GyroResultForbidFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   28 uint8 GyroResultForbidBackCount = 0;      //坡道禁止赛道类型判断倒计数
GyroResultForbidBackCount:
        DS8 1

        SECTION `.data`:DATA:REORDER:NOROOT(0)
//   29 uint8 GyroResultForbidBackCountNum = 50;  //坡道禁止赛道类型判断倒计数载入值
GyroResultForbidBackCountNum:
        DATA
        DC8 50
//   30  
//   31 //============================================================================
//   32 //函数名称：adc_init
//   33 //函数返回：0 成功 ，1 失败
//   34 //参数说明：MoudelNumber：模块号
//   35 //功能概要：AD初始化
//   36 //============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   37 uint8 hw_adc_init(int MoudelNumber)
//   38 {
//   39     if(MoudelNumber == 0)//模块0
hw_adc_init:
        CMP      R0,#+0
        BNE.N    ??hw_adc_init_0
//   40     {
//   41     	//打开ADC0模块时钟
//   42         SIM_SCGC6 |= (SIM_SCGC6_ADC0_MASK );
        LDR.W    R0,??DataTable3  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.W    R1,??DataTable3  ;; 0x4004803c
        STR      R0,[R1, #+0]
//   43     }
//   44     else if(MoudelNumber == 1)//模块1
//   45     {      
//   46     	//打开ADC1模块时钟
//   47         SIM_SCGC3 |= (SIM_SCGC3_ADC1_MASK );
//   48     }
//   49     else
//   50     {
//   51         return 0;
//   52     }
//   53     
//   54     return 1;
??hw_adc_init_1:
        MOVS     R0,#+1
??hw_adc_init_2:
        BX       LR               ;; return
??hw_adc_init_0:
        CMP      R0,#+1
        BNE.N    ??hw_adc_init_3
        LDR.W    R0,??DataTable3_1  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.W    R1,??DataTable3_1  ;; 0x40048030
        STR      R0,[R1, #+0]
        B.N      ??hw_adc_init_1
??hw_adc_init_3:
        MOVS     R0,#+0
        B.N      ??hw_adc_init_2
//   55 }
//   56 
//   57 
//   58 
//   59 //============================================================================
//   60 //函数名称：ad_once
//   61 //函数返回：16位无符号的AD值 
//   62 //参数说明：MoudelNumber：模块号
//   63 //               Channel：通道号
//   64 //              accuracy：精度
//   65 //功能概要：采集一次一路模拟量的AD值    
//   66 //============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   67 uint16 hw_ad_once(int MoudelNumber,int Channel,uint8 accuracy)//采集某路模拟量的AD值
//   68 {
hw_ad_once:
        PUSH     {R4}
//   69 		uint16 result = 0;
        MOVS     R3,#+0
//   70 		uint8 ADCCfg1Mode = 0;
        MOVS     R4,#+0
//   71 		ADC_MemMapPtr ADCMoudel;//保存ADC模块地址指针
//   72 				
//   73 		switch(accuracy)
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+8
        BEQ.N    ??hw_ad_once_0
        CMP      R2,#+10
        BEQ.N    ??hw_ad_once_1
        CMP      R2,#+12
        BEQ.N    ??hw_ad_once_2
        CMP      R2,#+16
        BEQ.N    ??hw_ad_once_3
        B.N      ??hw_ad_once_4
//   74 		{
//   75 			 case 8:
//   76 			   ADCCfg1Mode = 0x00;
??hw_ad_once_0:
        MOVS     R4,#+0
//   77 			   break;
        B.N      ??hw_ad_once_5
//   78 			 case 12:
//   79 			   ADCCfg1Mode = 0x01;
??hw_ad_once_2:
        MOVS     R4,#+1
//   80 			   break;
        B.N      ??hw_ad_once_5
//   81 			 case 10:
//   82 			   ADCCfg1Mode = 0x02;
??hw_ad_once_1:
        MOVS     R4,#+2
//   83 			   break;
        B.N      ??hw_ad_once_5
//   84 			 case 16:
//   85 			   ADCCfg1Mode = 0x03;
??hw_ad_once_3:
        MOVS     R4,#+3
//   86 			   break;
        B.N      ??hw_ad_once_5
//   87 			 default:
//   88 			   ADCCfg1Mode = 0x00;
??hw_ad_once_4:
        MOVS     R4,#+0
//   89 		}
//   90 		
//   91 		
//   92 		if(MoudelNumber==0)//选择ADC模块0
??hw_ad_once_5:
        CMP      R0,#+0
        BNE.N    ??hw_ad_once_6
//   93 		{
//   94 		   ADCMoudel = ADC0_BASE_PTR;
        LDR.N    R0,??DataTable3_2  ;; 0x4003b000
        B.N      ??hw_ad_once_7
//   95 		}
//   96 		else               //选择ADC模块1
//   97 		{
//   98 		   ADCMoudel = ADC1_BASE_PTR;
??hw_ad_once_6:
        LDR.N    R0,??DataTable3_3  ;; 0x400bb000
//   99 		}
//  100 		
//  101 		//配置正常电源模式，总线时钟，总线时钟4分频，长采样时间使能，设置精度
//  102 		ADC_CFG1_REG(ADCMoudel) = ADLPC_NORMAL
//  103 								 | ADC_CFG1_ADIV(ADIV_4)
//  104 								 | ADLSMP_LONG
//  105 								 | ADC_CFG1_MODE(ADCCfg1Mode)
//  106 								 | ADC_CFG1_ADICLK(ADICLK_BUS);
??hw_ad_once_7:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R2,R4,#+2
        ANDS     R2,R2,#0xC
        ORRS     R2,R2,#0x50
        STR      R2,[R0, #+8]
//  107 		   
//  108 		//配置禁止异步时钟使能输出，ADxxat通道选择，高速配置，长采样时间   
//  109 		ADC_CFG2_REG(ADCMoudel)  =    MUXSEL_ADCA
//  110 								 | ADACKEN_DISABLED
//  111 								 | ADHSC_HISPEED
//  112 								 | ADC_CFG2_ADLSTS(ADLSTS_20) ;
        MOVS     R2,#+4
        STR      R2,[R0, #+12]
//  113 								
//  114 		//设置通道号
//  115 		ADC_SC1_REG(ADCMoudel,A) = AIEN_ON | DIFF_SINGLE | ADC_SC1_ADCH(Channel);
        ANDS     R1,R1,#0x1F
        ORRS     R1,R1,#0x40
        STR      R1,[R0, #+0]
//  116 	    //等待转换完成
//  117     	while (( ADC_SC1_REG(ADCMoudel,A) & ADC_SC1_COCO_MASK ) != ADC_SC1_COCO_MASK)
??hw_ad_once_8:
        LDR      R1,[R0, #+0]
        LSLS     R1,R1,#+24
        BPL.N    ??hw_ad_once_8
//  118 		{
//  119 
//  120 		}
//  121 	    //读取转化结果
//  122 		result = ADC_R_REG(ADCMoudel,A);       
        LDR      R3,[R0, #+16]
//  123 		//清ADC转换完成标志
//  124 		ADC_SC1_REG(ADCMoudel,A) &= ~ADC_SC1_COCO_MASK;
        LDR      R1,[R0, #+0]
        BICS     R1,R1,#0x80
        STR      R1,[R0, #+0]
//  125 
//  126     return result;
        MOVS     R0,R3
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        POP      {R4}
        BX       LR               ;; return
//  127 }
//  128 
//  129 //============================================================================
//  130 //函数名称：ad_mid
//  131 //函数返回：16位无符号的AD值 
//  132 //参数说明：MoudelNumber：模块号
//  133 //               Channel：通道号
//  134 //              accuracy：精度
//  135 //功能概要：中值滤波后的结果(范围:0-4095) 
//  136 //============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  137 uint16 hw_ad_mid(int MoudelNumber,int Channel,uint8 accuracy) 
//  138 {
hw_ad_mid:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  139 	uint16 i,j,k,tmp;
//  140 	//1.取3次A/D转换结果
//  141 	i = hw_ad_once(MoudelNumber,Channel,accuracy);
        MOVS     R2,R6
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,R5
        MOVS     R0,R4
        BL       hw_ad_once
        MOVS     R7,R0
//  142 	j = hw_ad_once(MoudelNumber,Channel,accuracy);
        MOVS     R2,R6
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,R5
        MOVS     R0,R4
        BL       hw_ad_once
        MOV      R8,R0
//  143 	k = hw_ad_once(MoudelNumber,Channel,accuracy);
        MOVS     R2,R6
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,R5
        MOVS     R0,R4
        BL       hw_ad_once
        MOVS     R1,R0
//  144 	//2.取中值
//  145 	if (i > j)
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R8,R7
        BCS.N    ??hw_ad_mid_0
//  146 	{
//  147 		tmp = i; i = j; j = tmp;
        MOVS     R0,R7
        MOV      R7,R8
        MOV      R8,R0
//  148 	}
//  149 	if (k > j) 
??hw_ad_mid_0:
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R8,R1
        BCS.N    ??hw_ad_mid_1
//  150 	  tmp = j;
        MOV      R0,R8
        B.N      ??hw_ad_mid_2
//  151 	else if(k > i) 
??hw_ad_mid_1:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R7,R1
        BCS.N    ??hw_ad_mid_3
//  152 	  tmp = k;
        MOVS     R0,R1
        B.N      ??hw_ad_mid_2
//  153     else 
//  154       tmp = i;
??hw_ad_mid_3:
        MOVS     R0,R7
//  155 	return tmp;
??hw_ad_mid_2:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        POP      {R4-R8,PC}       ;; return
//  156 }
//  157 
//  158 //============================================================================
//  159 //函数名称：ad_ave
//  160 //函数返回：16位无符号的AD值 
//  161 //参数说明：MoudelNumber：模块号
//  162 //               Channel：通道号
//  163 //              accuracy：精度
//  164 //                     N:均值滤波次数(范围:0~255)
//  165 //功能概要：均值滤波后的结果(范围:0-4095) 
//  166 //============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  167 uint16 hw_ad_ave(int MoudelNumber,int Channel,uint8 accuracy,uint8 N) 
//  168 {
hw_ad_ave:
        PUSH     {R3-R9,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
//  169 	uint32 tmp = 0;
        MOVS     R8,#+0
//  170 	uint8  i;
//  171     for(i = 0; i < N; i++)
        MOVS     R9,#+0
        B.N      ??hw_ad_ave_0
//  172 		tmp += hw_ad_mid(MoudelNumber,Channel,accuracy);
??hw_ad_ave_1:
        MOVS     R2,R6
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,R5
        MOVS     R0,R4
        BL       hw_ad_mid
        UXTAH    R8,R8,R0
        ADDS     R9,R9,#+1
??hw_ad_ave_0:
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R9,R7
        BCC.N    ??hw_ad_ave_1
//  173 	tmp = tmp / N; 
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        UDIV     R8,R8,R7
//  174     return (uint16)tmp;
        MOV      R0,R8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        POP      {R1,R4-R9,PC}    ;; return
//  175 }
//  176 
//  177 
//  178 //======================================================================
//  179 //函数名：GyroInit
//  180 //功  能：陀螺仪初始化
//  181 //参  数：
//  182 //返  回：
//  183 //影  响：
//  184 //说  明：
//  185 //      
//  186 //             
//  187 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  188 uint8 GyroInit(void)
//  189 {
GyroInit:
        PUSH     {R4,LR}
        SUB      SP,SP,#+200
//  190   uint32 temp;
//  191   uint16 adresult[100];
//  192   uint8 i, j;
//  193   
//  194   //G1  ADC0_SE10   <->   PTA7
//  195   PORT_PCR_REG(PORTA_BASE_PTR,  7) |= (0|PORT_PCR_MUX(0));
        LDR.N    R0,??DataTable3_4  ;; 0x4004901c
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable3_4  ;; 0x4004901c
        STR      R0,[R1, #+0]
//  196   //G2  ADC0_SE17   <->   PTE24
//  197   //PORT_PCR_REG(PORTE_BASE_PTR, 24) |= (0|PORT_PCR_MUX(0));
//  198   //G3  ADC0_SE18   <->   PTE25
//  199   //PORT_PCR_REG(PORTE_BASE_PTR, 25) |= (0|PORT_PCR_MUX(0));
//  200   
//  201   //采样100次。
//  202   for(i = 0; i <= 99; i++)
        MOVS     R4,#+0
        B.N      ??GyroInit_0
//  203   {
//  204     adresult[i] = hw_ad_mid(0, 10, 16);
??GyroInit_1:
        MOVS     R2,#+16
        MOVS     R1,#+10
        MOVS     R0,#+0
        BL       hw_ad_mid
        ADD      R1,SP,#+0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRH     R0,[R1, R4, LSL #+1]
//  205   }
        ADDS     R4,R4,#+1
??GyroInit_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+100
        BLT.N    ??GyroInit_1
//  206   
//  207   //从小到大冒泡排排序
//  208   for(i = 0; i <= 98; i++)
        MOVS     R4,#+0
        B.N      ??GyroInit_2
//  209   {
//  210     for(j = i + 1; j <= 99; j++)
//  211     {
//  212       if(adresult[i] < adresult[j])
??GyroInit_3:
        ADD      R0,SP,#+0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRH     R0,[R0, R4, LSL #+1]
        ADD      R2,SP,#+0
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDRH     R2,[R2, R1, LSL #+1]
        CMP      R0,R2
        BCS.N    ??GyroInit_4
//  213       {
//  214         temp = adresult[j];
        ADD      R0,SP,#+0
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDRH     R0,[R0, R1, LSL #+1]
//  215         adresult[j] = adresult[i];
        ADD      R2,SP,#+0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRH     R2,[R2, R4, LSL #+1]
        ADD      R3,SP,#+0
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        STRH     R2,[R3, R1, LSL #+1]
//  216         adresult[i] = temp;
        ADD      R2,SP,#+0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRH     R0,[R2, R4, LSL #+1]
//  217       }
//  218       else
//  219       {
//  220       }
//  221     }
??GyroInit_4:
        ADDS     R1,R1,#+1
??GyroInit_5:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+100
        BLT.N    ??GyroInit_3
        ADDS     R4,R4,#+1
??GyroInit_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+99
        BGE.N    ??GyroInit_6
        ADDS     R1,R4,#+1
        B.N      ??GyroInit_5
//  222   }
//  223   
//  224   temp = adresult[25];
??GyroInit_6:
        LDRH     R0,[SP, #+50]
//  225   //取中间若干个点求平均值
//  226   for(i = 26; i <= 75; i++)
        MOVS     R4,#+26
        B.N      ??GyroInit_7
//  227   {
//  228     temp = (temp + adresult[i]) / 2;
??GyroInit_8:
        ADD      R1,SP,#+0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRH     R1,[R1, R4, LSL #+1]
        UXTAH    R0,R0,R1
        LSRS     R0,R0,#+1
//  229   }
        ADDS     R4,R4,#+1
??GyroInit_7:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+76
        BLT.N    ??GyroInit_8
//  230   
//  231   ADResultCom = temp;
        LDR.N    R1,??DataTable3_5
        STRH     R0,[R1, #+0]
//  232   
//  233   return 1;
        MOVS     R0,#+1
        ADD      SP,SP,#+200
        POP      {R4,PC}          ;; return
//  234 }
//  235 
//  236 
//  237 //编码器处理。AD采集，标志位处理。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  238 uint8 GryoDeal(void)
//  239 {
GryoDeal:
        PUSH     {R7,LR}
//  240   //int16 temp;
//  241   uint8 i;
//  242 
//  243   //3次平均AD采集编码器的返回值，即角速度。
//  244   //由于跳变太大，所以除以1000.取千位。//原来这里是除1000的，后来改为除100
//  245   ADResult0 = (hw_ad_mid(0, 10, 16) - ADResultCom) / 1000;
        MOVS     R2,#+16
        MOVS     R1,#+10
        MOVS     R0,#+0
        BL       hw_ad_mid
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDR.N    R1,??DataTable3_5
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable3_6
        STRH     R0,[R1, #+0]
//  246   
//  247   //滤波。会给判坡带来滞后，不过上坡滞后没有关系，关键是在下坡必须要减速。（上坡加减速是可选的）
//  248   ADResult1 = (ADResult1 * 90 + ADResult0 * 10) / 100;
        LDR.N    R0,??DataTable3_7
        LDRSH    R0,[R0, #+0]
        MOVS     R1,#+90
        SMULBB   R0,R0,R1
        LDR.N    R1,??DataTable3_6
        LDRSH    R1,[R1, #+0]
        MOVS     R2,#+10
        SMLABB   R0,R1,R2,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable3_7
        STRH     R0,[R1, #+0]
//  249   //为了防止跑车过程中温漂上扬，给出1的裕度（其实是1000的裕度）。即-1~+1的变化都被滤掉。
//  250   /*
//  251   if(ADResult1 < 0)
//  252   {
//  253     temp = 0 - ADResult1;
//  254   }
//  255   else
//  256   {
//  257     temp = ADResult1;
//  258   }
//  259   
//  260   if(temp <= 1)
//  261   {
//  262     ADResult1 = 0;
//  263   }
//  264   else
//  265   {    
//  266   }
//  267   */
//  268   
//  269   
//  270   //角速度连续为0的次数的更新。由于经过上下坡后，角度不能回零，
//  271   //所以当角速度连续为0（即平路）的次数达到一定次数后，需要手动把角度归零。
//  272   if(ADResult1 == 0)
        LDR.N    R0,??DataTable3_7
        LDRSH    R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??GryoDeal_0
//  273   {
//  274     //角速度为0次数加1。
//  275     GryoFlatCount++;
        LDR.N    R0,??DataTable3_8
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable3_8
        STR      R0,[R1, #+0]
        B.N      ??GryoDeal_1
//  276   }
//  277   else
//  278   {
//  279     //角速度为0次数清零。
//  280     GryoFlatCount = 0;
??GryoDeal_0:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_8
        STR      R0,[R1, #+0]
//  281   }
//  282   
//  283   if(GryoFlatCount > GryoFlatFlagNum)
??GryoDeal_1:
        LDR.N    R0,??DataTable3_8
        LDR      R0,[R0, #+0]
        CMP      R0,#+16
        BCC.N    ??GryoDeal_2
//  284   {
//  285     //大于若干次，判定为平路。角度归零。
//  286     //置标志位。
//  287     GryoFlatFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable3_9
        STRB     R0,[R1, #+0]
//  288     //角度归零
//  289     ADResult2 = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+0]
//  290     //数组清零，防止因为角度归零引起的跳变误判。
//  291     for(i = 0; i <= GyroResultNum - 1; i++)
        MOVS     R0,#+0
??GryoDeal_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+10
        BGE.N    ??GryoDeal_4
//  292     {
//  293       GyroResult[i] = 0;
        MOVS     R1,#+0
        LDR.N    R2,??DataTable3_11
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STRH     R1,[R2, R0, LSL #+1]
//  294     }
        ADDS     R0,R0,#+1
        B.N      ??GryoDeal_3
//  295   }
//  296   else
//  297   {
//  298     GryoFlatFlag = 0;
??GryoDeal_2:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_9
        STRB     R0,[R1, #+0]
//  299   }
//  300   
//  301   
//  302   //积分。角速度变成角度。
//  303   ADResult2 += ADResult1;
??GryoDeal_4:
        LDR.N    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable3_7
        LDRH     R1,[R1, #+0]
        ADDS     R0,R1,R0
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+0]
//  304   
//  305   for(i = 0; i <= GyroResultNum - 2; i++)
        MOVS     R0,#+0
        B.N      ??GryoDeal_5
//  306   {
//  307     GyroResult[i] = GyroResult[i+1];
??GryoDeal_6:
        LDR.N    R1,??DataTable3_11
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R1,R0, LSL #+1
        LDRH     R1,[R1, #+2]
        LDR.N    R2,??DataTable3_11
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STRH     R1,[R2, R0, LSL #+1]
//  308   }
        ADDS     R0,R0,#+1
??GryoDeal_5:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+9
        BLT.N    ??GryoDeal_6
//  309   GyroResult[GyroResultNum-1] = ADResult2;
        LDR.N    R0,??DataTable3_10
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable3_11
        STRH     R0,[R1, #+18]
//  310   
//  311   //均为负值的、你陡的下降沿，上坡标志。
//  312   if(
//  313     (GyroResult[GyroResultNum-1] < 0)
//  314   &&(GyroResult[0] < 0)
//  315   &&(GyroResult[0] - GyroResult[GyroResultNum-1] > GyroResultLimit)    //巧妙的逻辑！
//  316     )
        LDR.N    R0,??DataTable3_11
        LDRSH    R0,[R0, #+18]
        CMP      R0,#+0
        BPL.N    ??GryoDeal_7
        LDR.N    R0,??DataTable3_11
        LDRSH    R0,[R0, #+0]
        CMP      R0,#+0
        BPL.N    ??GryoDeal_7
        LDR.N    R0,??DataTable3_11
        LDRSH    R0,[R0, #+0]
        LDR.N    R1,??DataTable3_11
        LDRSH    R1,[R1, #+18]
        SUBS     R0,R0,R1
        CMP      R0,#+14
        BLT.N    ??GryoDeal_7
//  317   {
//  318     GyroResultFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable3_12
        STRB     R0,[R1, #+0]
        B.N      ??GryoDeal_8
//  319   }
//  320   //均为正值的、陡的上升沿，下坡标志。下坡后容易出现上坡标志。
//  321   else if(
//  322     (GyroResult[GyroResultNum-1] > 0)
//  323   &&(GyroResult[0] > 0)
//  324   &&(GyroResult[GyroResultNum-1] - GyroResult[0] > GyroResultLimit)   //巧妙的逻辑！
//  325     )
??GryoDeal_7:
        LDR.N    R0,??DataTable3_11
        LDRSH    R0,[R0, #+18]
        CMP      R0,#+1
        BLT.N    ??GryoDeal_9
        LDR.N    R0,??DataTable3_11
        LDRSH    R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??GryoDeal_9
        LDR.N    R0,??DataTable3_11
        LDRSH    R0,[R0, #+18]
        LDR.N    R1,??DataTable3_11
        LDRSH    R1,[R1, #+0]
        SUBS     R0,R0,R1
        CMP      R0,#+14
        BLT.N    ??GryoDeal_9
//  326   {
//  327     GyroResultFlag = 2;
        MOVS     R0,#+2
        LDR.N    R1,??DataTable3_12
        STRB     R0,[R1, #+0]
        B.N      ??GryoDeal_8
//  328   }
//  329   //无跳变沿，平路。
//  330   else
//  331   {
//  332     GyroResultFlag = 0;
??GryoDeal_9:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_12
        STRB     R0,[R1, #+0]
//  333   }
//  334   
//  335   //若倒计数不是0，则每次减一，必须放在载入之前。
//  336   if(GyroResultForbidBackCount != 0)
??GryoDeal_8:
        LDR.N    R0,??DataTable3_13
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??GryoDeal_10
//  337   {
//  338     GyroResultForbidBackCount--;
        LDR.N    R0,??DataTable3_13
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.N    R1,??DataTable3_13
        STRB     R0,[R1, #+0]
//  339   }
//  340   else
//  341   {
//  342   }
//  343   //坡道禁止赛道类型判断标志
//  344   //上坡时，将标志置1，中间会经历标志置0，然后会达到标志置2.置2时或倒计数结束时，解除标志。
//  345   if(GyroResultFlag == 1)
??GryoDeal_10:
        LDR.N    R0,??DataTable3_12
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??GryoDeal_11
//  346   {
//  347     //标志位置位。
//  348     GyroResultForbidFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable3_14
        STRB     R0,[R1, #+0]
//  349     //倒计数载入
//  350     GyroResultForbidBackCount = GyroResultForbidBackCountNum;
        LDR.N    R0,??DataTable3_15
        LDRB     R0,[R0, #+0]
        LDR.N    R1,??DataTable3_13
        STRB     R0,[R1, #+0]
        B.N      ??GryoDeal_12
//  351   }
//  352   //下坡标志了，或者倒计数结束了，就解除标志。
//  353   else if(GyroResultFlag == 2 || GyroResultForbidBackCount == 0)
??GryoDeal_11:
        LDR.N    R0,??DataTable3_12
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BEQ.N    ??GryoDeal_13
        LDR.N    R0,??DataTable3_13
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??GryoDeal_12
//  354   {
//  355     //解除标志
//  356     GyroResultForbidFlag = 0;
??GryoDeal_13:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_14
        STRB     R0,[R1, #+0]
//  357   }
//  358   //平路过程，不用理会。
//  359   else
//  360   {
//  361   }
//  362   
//  363   return 1;
??GryoDeal_12:
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//  364 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     0x4003b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     0x400bb000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     0x4004901c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     ADResultCom

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     ADResult0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     ADResult1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_8:
        DC32     GryoFlatCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_9:
        DC32     GryoFlatFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_10:
        DC32     ADResult2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_11:
        DC32     GyroResult

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_12:
        DC32     GyroResultFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_13:
        DC32     GyroResultForbidBackCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_14:
        DC32     GyroResultForbidFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_15:
        DC32     GyroResultForbidBackCountNum

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  365 
//  366 
// 
//  41 bytes in section .bss
//   2 bytes in section .data
// 906 bytes in section .text
// 
// 906 bytes of CODE memory
//  43 bytes of DATA memory
//
//Errors: none
//Warnings: none
