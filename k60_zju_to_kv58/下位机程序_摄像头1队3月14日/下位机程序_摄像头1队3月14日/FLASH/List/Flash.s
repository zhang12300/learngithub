///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       06/Feb/2018  21:44:16
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Function_C\Flash.c
//    Command line =  
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Function_C\Flash.c
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
//    List file    =  D:\智能车\程序\下位机程序_摄像头1队\FLASH\List\Flash.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        PUBLIC FlashEraseSector
        PUBLIC FlashInit
        PUBLIC FlashWrite

// D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Function_C\Flash.c
//    1 //==============================================================================
//    2 //文件名称：Flash.c
//    3 //功能概要：K60 Flash擦除/写入底层驱动程序源文件
//    4 //==============================================================================
//    5 #include "Flash.h" 
//    6 
//    7 //=======================内部调用函数声明=======================================
//    8 //==============================================================================
//    9 //函数名称：hw_flash_sign_off
//   10 //函数返回：无
//   11 //参数说明：无
//   12 //功能概要：配置Flash存储控制器，清除Flash预读取缓冲
//   13 //==============================================================================
//   14 static void hw_flash_sign_off(void);
//   15 
//   16 //==============================================================================
//   17 //函数名称：hw_flash_cmd_launch
//   18 //函数返回：0-成功 1-失败
//   19 //参数说明：无
//   20 //功能概要：启动Flash命令
//   21 //==============================================================================
//   22 static uint32 hw_flash_cmd_launch(void);
//   23 
//   24 //==============================================================================
//   25 
//   26 //=================外部接口函数=================================================
//   27 //==============================================================================
//   28 //函数名称：FlashInit
//   29 //函数返回：无
//   30 //参数说明：无
//   31 //功能概要：初始化Flash模块
//   32 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   33 void FlashInit(void)
//   34 {
FlashInit:
        PUSH     {R7,LR}
//   35   //清除FMC缓冲区
//   36   hw_flash_sign_off();
        BL       hw_flash_sign_off
//   37     
//   38   //禁止看门狗
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
//   43   //等待命令完成
//   44   while(!(FTFL_FSTAT & CCIF));
??FlashInit_0:
        LDR.N    R0,??DataTable4_2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??FlashInit_0
//   45     
//   46   //清除访问出错标志位
//   47   FTFL_FSTAT = ACCERR | FPVIOL;
        MOVS     R0,#+48
        LDR.N    R1,??DataTable4_2  ;; 0x40020000
        STRB     R0,[R1, #+0]
//   48 }
        POP      {R0,PC}          ;; return
//   49 
//   50 //==============================================================================
//   51 //函数名称：FlashEraseSector
//   52 //函数返回：函数执行执行状态：0=正常；非0=异常。
//   53 //参数说明：sectorNo：扇区号（K60N512实际使用0~255）
//   54 //功能概要：擦除指定flash扇区
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
//   66   //设置擦除命令
//   67   FTFL_FCCOB0 = ERSSCR;   //lyx: ERSSCR: 0x09 擦除Flash扇区
        MOVS     R0,#+9
        LDR.N    R1,??DataTable4_3  ;; 0x40020007
        STRB     R0,[R1, #+0]
//   68     
//   69   //设置目标地址
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
//   74   //执行命令序列
//   75   if(1 == hw_flash_cmd_launch())    //若执行命令出现错误
        BL       hw_flash_cmd_launch
        CMP      R0,#+1
        BNE.N    ??FlashEraseSector_0
//   76     return 1;     //擦除命令错误
        MOVS     R0,#+1
        B.N      ??FlashEraseSector_1
//   77    
//   78   //若擦除sector0时，则解锁设备
//   79   if(dest.word <= 0x800)
??FlashEraseSector_0:
        LDR      R0,[SP, #+0]
        CMP      R0,#+2048
        BHI.N    ??FlashEraseSector_2
//   80   {
//   81     //写入4字节
//   82     FTFL_FCCOB0 = PGM4; 
        MOVS     R0,#+6
        LDR.N    R1,??DataTable4_3  ;; 0x40020007
        STRB     R0,[R1, #+0]
//   83     //设置目标地址
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
//   87     //数据
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
//   92     //执行命令序列
//   93     if(1 == hw_flash_cmd_launch())  //若执行命令出现错误
        BL       hw_flash_cmd_launch
        CMP      R0,#+1
        BNE.N    ??FlashEraseSector_2
//   94       return 2;   //解锁命令错误
        MOVS     R0,#+2
        B.N      ??FlashEraseSector_1
//   95     }  
//   96     
//   97     return 0;  //成功返回
??FlashEraseSector_2:
        MOVS     R0,#+0
??FlashEraseSector_1:
        POP      {R1,PC}          ;; return
//   98 }
//   99 
//  100 //==============================================================================
//  101 //函数名称：FlashWrite
//  102 //函数返回：函数执行状态：0=正常；非0=异常。
//  103 //参数说明：sectNo：目标扇区号 （K60N512实际使用0~255）
//  104 //          offset:写入扇区内部偏移地址（0~2043）
//  105 //          cnt：写入字节数目（0~2043）
//  106 //          buf：源数据缓冲区首地址
//  107 //功能概要：flash写入操作
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
//  121     return 1;   //参数设定错误，偏移量未对齐（4字节对齐）
        MOVS     R0,#+1
        B.N      ??FlashWrite_1
//  122     
//  123   //设置写入命令
//  124   FTFL_FCCOB0 = PGM4;
??FlashWrite_0:
        MOVS     R2,#+6
        LDR.N    R3,??DataTable4_3  ;; 0x40020007
        STRB     R2,[R3, #+0]
//  125   destaddr = (uint32)(sectNo*(1<<11) + offset);//计算地址
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
//  129     //设置目标地址
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
//  134     //拷贝数据
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
//  141       return 2;  //写入命令错误
        MOVS     R0,#+2
        B.N      ??FlashWrite_1
//  142   }
//  143   return 0;  //成功执行
??FlashWrite_4:
        MOVS     R0,#+0
??FlashWrite_1:
        POP      {R1,R2,R4-R6,PC}  ;; return
//  144 }
//  145 
//  146 //========================内部函数实现==========================================
//  147 //==============================================================================
//  148 //函数名称：hw_flash_sign_off
//  149 //函数返回：无
//  150 //参数说明：无
//  151 //功能概要：配置Flash存储控制器，清除Flash预读取缓冲
//  152 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  153 void hw_flash_sign_off(void)
//  154 {  
//  155   //清除缓冲
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
//  161 //函数名称：hw_flash_cmd_launch
//  162 //函数返回：0-成功 1-失败
//  163 //参数说明：无
//  164 //功能概要：启动Flash命令
//  165 //==============================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  166 static uint32 hw_flash_cmd_launch(void)
//  167 {
//  168   //清除访问错误标志位和非法访问标志位
//  169   FTFL_FSTAT = ACCERR | FPVIOL;           //lyx: ACCERR:flash访问错误标志位
hw_flash_cmd_launch:
        MOVS     R0,#+48
        LDR.N    R1,??DataTable4_2  ;; 0x40020000
        STRB     R0,[R1, #+0]
//  170                                           //lyx: FPVIOL:flash非法访问保护标志位
//  171   //启动命令
//  172   FTFL_FSTAT = CCIF;                      //lyx: CCIF:指令完成中断标志位
        MOVS     R0,#+128
        LDR.N    R1,??DataTable4_2  ;; 0x40020000
        STRB     R0,[R1, #+0]
//  173 
//  174   //等待命令结束
//  175   while(!(FTFL_FSTAT & CCIF));
??hw_flash_cmd_launch_0:
        LDR.N    R0,??DataTable4_2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??hw_flash_cmd_launch_0
//  176 
//  177   //检查错误标志
//  178   if(FTFL_FSTAT & (ACCERR | FPVIOL | MGSTAT0))
        LDR.N    R0,??DataTable4_2  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+49
        TST      R0,R1
        BEQ.N    ??hw_flash_cmd_launch_1
//  179     return 1 ; //执行命令出错
        MOVS     R0,#+1
        B.N      ??hw_flash_cmd_launch_2
//  180   
//  181   return 0; //执行命令成功
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
