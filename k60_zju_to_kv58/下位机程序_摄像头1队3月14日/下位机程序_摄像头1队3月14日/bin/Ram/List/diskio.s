///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.10.1.12857/W32 for ARM      30/Aug/2018  15:15:48
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\SD_C\diskio.c
//    Command line =  
//        -f C:\Users\Lenovo\AppData\Local\Temp\EW8C42.tmp
//        (C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\SD_C\diskio.c
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
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\bin\Ram\List\diskio.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN SD_GetCapacity
        EXTERN SD_Init
        EXTERN SD_ReadMultiBlock
        EXTERN SD_ReadSingleBlock
        EXTERN SD_WaitReady
        EXTERN SD_WriteMultiBlock
        EXTERN SD_WriteSingleBlock
        EXTERN gpio_ctrl

        PUBLIC disk_initialize
        PUBLIC disk_ioctl
        PUBLIC disk_read
        PUBLIC disk_status
        PUBLIC disk_write
        PUBLIC get_fattime

// C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\SD_C\diskio.c
//    1 /*-----------------------------------------------------------------------*/
//    2 /* Low level disk I/O module skeleton for FatFs     (C)ChaN, 2007        */
//    3 /*-----------------------------------------------------------------------*/
//    4 /* This is a stub disk I/O module that acts as front end of the existing */
//    5 /* disk I/O modules and attach it to FatFs module with common interface. */
//    6 /*-----------------------------------------------------------------------*/
//    7 /*-----------------------------------------------------------------------*/
//    8 /* Inidialize a Drive*/
//    9 
//   10 #include "diskio.h"
//   11 #include "sd_driver.h"
//   12 
//   13 struct tm {
//   14    	int tm_sec;   // 秒 seconds after the minute, 0 to 60
//   15    	int tm_min;   // 分 minutes after the hour, 0 to 59
//   16 	int tm_hour;  // 时 hours since midnight, 0 to 23*
//   17 	int tm_mday;  // 日 day of the month, 1 to 31
//   18 	int tm_mon;   // 月 months since January, 0 to 11
//   19 	int tm_year;  // 年 years since 1900
//   20 	int tm_wday;  // 星期 days since Sunday, 0 to 6
//   21 	int tm_yday;  // 从元旦起的天数 days since January 1, 0 to 365
//   22  	int tm_isdst; // 夏令时？？Daylight Savings Time flag
//   23  	};
//   24 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   25 DSTATUS disk_initialize ( 
//   26 BYTE drv				/* Physical drive nmuber (0..) */
//   27 )
//   28 {
disk_initialize:
        PUSH     {R7,LR}
//   29     unsigned char state;
//   30 
//   31     if(drv)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??disk_initialize_0
//   32     {
//   33         return STA_NOINIT;  //仅支持磁盘0的操作
        MOVS     R0,#+1
        B.N      ??disk_initialize_1
//   34     }
//   35 
//   36     state = SD_Init();  //初始化SD卡，SD_driver层
??disk_initialize_0:
        BL       SD_Init
//   37     if(state == STA_NODISK)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+2
        BNE.N    ??disk_initialize_2
//   38     {
//   39         return STA_NODISK;
        MOVS     R0,#+2
        B.N      ??disk_initialize_1
//   40     }
//   41     else if(state != 0)
??disk_initialize_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??disk_initialize_3
//   42     {
//   43         return STA_NOINIT;  //其他错误：初始化失败
        MOVS     R0,#+1
        B.N      ??disk_initialize_1
//   44     }
//   45     else
//   46     {
//   47         return 0;           //初始化成功
??disk_initialize_3:
        MOVS     R0,#+0
??disk_initialize_1:
        POP      {R1,PC}          ;; return
//   48     }
//   49 }
//   50 
//   51 
//   52 
//   53 /*-----------------------------------------------------------------------*/
//   54 /* Return Disk Status                                                    */
//   55 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   56 DSTATUS disk_status (
//   57 	BYTE drv		/* Physical drive nmuber (0..) */
//   58 )
//   59 {
//   60     if(drv)
disk_status:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??disk_status_0
//   61     {
//   62         return STA_NOINIT;  //仅支持磁盘0操作
        MOVS     R0,#+1
        B.N      ??disk_status_1
//   63     }
//   64 
//   65     //检查SD卡是否插入
//   66 //    if(!SD_DET())
//   67 //    {
//   68 //        return STA_NODISK;
//   69 //    }
//   70     return 0;
??disk_status_0:
        MOVS     R0,#+0
??disk_status_1:
        BX       LR               ;; return
//   71 }
//   72 
//   73 
//   74 
//   75 /*-----------------------------------------------------------------------*/
//   76 /* Read Sector(s)                                                        */
//   77 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   78 DRESULT disk_read (
//   79 	BYTE drv,		/* Physical drive nmuber (0..) */
//   80 	BYTE *buff,		/* Data buffer to store read data */
//   81 	DWORD sector,	/* Sector address (LBA) */
//   82 	BYTE count		/* Number of sectors to read (1..255) */
//   83 )
//   84 {
disk_read:
        PUSH     {R4,LR}
        MOVS     R4,R2
        MOVS     R2,R3
//   85 	unsigned char res=0;
        MOVS     R3,#+0
//   86     if (drv || !count) //不是0磁盘或者 Number of sectors 为0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??disk_read_0
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BNE.N    ??disk_read_1
//   87     {    
//   88         return RES_PARERR;  //仅支持单磁盘操作，count不能等于0，否则返回参数错误
??disk_read_0:
        MOVS     R0,#+4
        B.N      ??disk_read_2
//   89     }
//   90 
//   91 //    if(!SD_DET())
//   92 //    {
//   93 //        return RES_NOTRDY;  //没有检测到SD卡，报NOT READY错误
//   94 //    }
//   95 
//   96     if(count==1)            //1个sector的读操作      
??disk_read_1:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+1
        BNE.N    ??disk_read_3
//   97     {                                                
//   98         res = SD_ReadSingleBlock(sector, buff);      //SD_driver层
        MOVS     R0,R4
        BL       SD_ReadSingleBlock
        MOVS     R3,R0
        B.N      ??disk_read_4
//   99     }                                                
//  100     else                    //多个sector的读操作     
//  101     {                                                
//  102         res = SD_ReadMultiBlock(sector, buff, count);
??disk_read_3:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R0,R4
        BL       SD_ReadMultiBlock
        MOVS     R3,R0
//  103     }                                                
//  104 
//  105     //处理返回值，将SD_driver.c的返回值转成ff.c的返回值
//  106     if(res == 0x00)
??disk_read_4:
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        CMP      R3,#+0
        BNE.N    ??disk_read_5
//  107     {
//  108         return RES_OK;
        MOVS     R0,#+0
        B.N      ??disk_read_2
//  109     }
//  110     else
//  111     {
//  112         return RES_ERROR;
??disk_read_5:
        MOVS     R0,#+1
??disk_read_2:
        POP      {R4,PC}          ;; return
//  113     }
//  114 }
//  115 
//  116 
//  117 
//  118 /*-----------------------------------------------------------------------*/
//  119 /* Write Sector(s)                                                       */
//  120 
//  121 #if _READONLY == 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  122 DRESULT disk_write (
//  123 	BYTE drv,			/* Physical drive nmuber (0..) */
//  124 	const BYTE *buff,	        /* Data to be written */
//  125 	DWORD sector,		/* Sector address (LBA) */
//  126 	BYTE count			/* Number of sectors to write (1..255) */
//  127 )
//  128 {
disk_write:
        PUSH     {R4,LR}
        MOVS     R4,R2
        MOVS     R2,R3
//  129 	unsigned char res;
//  130 
//  131     if (drv || !count)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??disk_write_0
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BNE.N    ??disk_write_1
//  132     {    
//  133         return RES_PARERR;  //仅支持单磁盘操作，count不能等于0，否则返回参数错误
??disk_write_0:
        MOVS     R0,#+4
        B.N      ??disk_write_2
//  134     }
//  135 
//  136 //    if(!SD_DET())
//  137 //    {
//  138 //        return RES_NOTRDY;  //没有检测到SD卡，报NOT READY错误
//  139 //    }
//  140 
//  141 
//  142     // 读写操作
//  143     if(count == 1)
??disk_write_1:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+1
        BNE.N    ??disk_write_3
//  144     {
//  145         res = SD_WriteSingleBlock(sector, buff);
        MOVS     R0,R4
        BL       SD_WriteSingleBlock
        B.N      ??disk_write_4
//  146     }
//  147     else
//  148     {
//  149         res = SD_WriteMultiBlock(sector, buff, count);
??disk_write_3:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R0,R4
        BL       SD_WriteMultiBlock
//  150     }
//  151     // 返回值转换
//  152     if(res == 0)
??disk_write_4:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??disk_write_5
//  153     {
//  154         return RES_OK;
        MOVS     R0,#+0
        B.N      ??disk_write_2
//  155     }
//  156     else
//  157     {
//  158         return RES_ERROR;
??disk_write_5:
        MOVS     R0,#+1
??disk_write_2:
        POP      {R4,PC}          ;; return
//  159     }
//  160 }
//  161 #endif /* _READONLY */
//  162 
//  163 
//  164 
//  165 /*-----------------------------------------------------------------------*/
//  166 /* Miscellaneous Functions                                               */
//  167 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  168 DRESULT disk_ioctl (
//  169 	BYTE drv,		/* Physical drive nmuber (0..) */
//  170 	BYTE ctrl,		/* Control code */
//  171 	void *buff		/* Buffer to send/receive control data */
//  172 )
//  173 
//  174 {
disk_ioctl:
        PUSH     {R4,LR}
        MOVS     R4,R2
//  175     DRESULT res;
//  176 
//  177 
//  178     if (drv)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??disk_ioctl_0
//  179     {    
//  180         return RES_PARERR;  //仅支持单磁盘操作，否则返回参数错误
        MOVS     R0,#+4
        B.N      ??disk_ioctl_1
//  181     }
//  182     
//  183     //FATFS目前版本仅需处理CTRL_SYNC，GET_SECTOR_COUNT，GET_BLOCK_SIZ三个命令
//  184     switch(ctrl)
??disk_ioctl_0:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BEQ.N    ??disk_ioctl_2
        CMP      R1,#+2
        BEQ.N    ??disk_ioctl_3
        BCC.N    ??disk_ioctl_4
        CMP      R1,#+3
        BEQ.N    ??disk_ioctl_5
        B.N      ??disk_ioctl_6
//  185     {
//  186     case CTRL_SYNC:
//  187         SD_CS_ENABLE();
??disk_ioctl_2:
        MOVS     R2,#+0
        MOVS     R1,#+13
        LDR.N    R0,??DataTable2  ;; 0x400ff000
        BL       gpio_ctrl
//  188         if(SD_WaitReady()==0)
        BL       SD_WaitReady
        CMP      R0,#+0
        BNE.N    ??disk_ioctl_7
//  189         {
//  190             res = RES_OK;
        MOVS     R4,#+0
        B.N      ??disk_ioctl_8
//  191         }
//  192         else
//  193         {
//  194             res = RES_ERROR;
??disk_ioctl_7:
        MOVS     R4,#+1
//  195         }
//  196         SD_CS_DISABLE();
??disk_ioctl_8:
        MOVS     R2,#+1
        MOVS     R1,#+13
        LDR.N    R0,??DataTable2  ;; 0x400ff000
        BL       gpio_ctrl
//  197         break;
        B.N      ??disk_ioctl_9
//  198         
//  199     case GET_BLOCK_SIZE:
//  200         *(DWORD*)buff = 512;
??disk_ioctl_5:
        MOV      R0,#+512
        STR      R0,[R4, #+0]
//  201         res = RES_OK;
        MOVS     R4,#+0
//  202         break;
        B.N      ??disk_ioctl_9
//  203 
//  204 
//  205     case GET_SECTOR_SIZE:
//  206         *(WORD*)buff = 512;
??disk_ioctl_3:
        MOV      R0,#+512
        STRH     R0,[R4, #+0]
//  207         res = RES_OK;
        MOVS     R4,#+0
//  208         break;
        B.N      ??disk_ioctl_9
//  209 
//  210     case GET_SECTOR_COUNT:
//  211         *(DWORD*)buff = SD_GetCapacity();
??disk_ioctl_4:
        BL       SD_GetCapacity
        STR      R0,[R4, #+0]
//  212         res = RES_OK;
        MOVS     R4,#+0
//  213         break;
        B.N      ??disk_ioctl_9
//  214     default:
//  215         res = RES_PARERR;
??disk_ioctl_6:
        MOVS     R4,#+4
//  216         break;
//  217     }
//  218 
//  219     return res;
??disk_ioctl_9:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??disk_ioctl_1:
        POP      {R4,PC}          ;; return
//  220 }
//  221 
//  222 
//  223 /*-----------------------------------------------------------------------*/
//  224 /* User defined function to give a current time to fatfs module      */
//  225 /* 31-25: Year(0-127 org.1980), 24-21: Month(1-12), 20-16: Day(1-31) */
//  226 /* 15-11: Hour(0-23), 10-5: Minute(0-59), 4-0: Second(0-29 *2) */ 
//  227 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  228 DWORD get_fattime (void)
//  229 {
//  230  /*   struct tm t;
//  231     DWORD date;
//  232     t.tm_year=2009-1980;		//年份改为1980年起
//  233     t.tm_mon=8;         	//0-11月改为1-12月
//  234 	t.tm_mday=3;
//  235 	t.tm_hour=15;
//  236 	t.tm_min=30;
//  237     t.tm_sec=20;      	//将秒数改为0-29
//  238 	date =t.tm_year;
//  239 	date=date<<7;
//  240 	date+=t.tm_mon;
//  241 	date=date<<4;
//  242 	date+=t.tm_mday;
//  243 	date=date<<5;
//  244 	date+=t.tm_hour;
//  245 	date=date<<5;
//  246 	date+=t.tm_min;
//  247 	date=date<<5;
//  248 	date+=t.tm_sec;
//  249 	date=1950466004;
//  250 */
//  251     return 1950466005;
get_fattime:
        LDR.N    R0,??DataTable2_1  ;; 0x7441bfd5
        BX       LR               ;; return
//  252 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     0x400ff000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     0x7441bfd5

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
//  253 
//  254 
// 
// 294 bytes in section .text
// 
// 294 bytes of CODE memory
//
//Errors: none
//Warnings: 1
