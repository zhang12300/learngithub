///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V8.10.1.12857/W32 for ARM      30/Aug/2018  15:15:52
// Copyright 1999-2017 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\SD_C\ff.c
//    Command line =  
//        -f C:\Users\Lenovo\AppData\Local\Temp\EW94A0.tmp
//        (C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\SD_C\ff.c
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
//        C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\bin\Ram\List\ff.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN disk_initialize
        EXTERN disk_ioctl
        EXTERN disk_read
        EXTERN disk_status
        EXTERN disk_write
        EXTERN get_fattime

        PUBLIC clust2sect
        PUBLIC f_chmod
        PUBLIC f_close
        PUBLIC f_getfree
        PUBLIC f_gets
        PUBLIC f_lseek
        PUBLIC f_mkdir
        PUBLIC f_mkfs
        PUBLIC f_mount
        PUBLIC f_open
        PUBLIC f_opendir
        PUBLIC f_printf
        PUBLIC f_putc
        PUBLIC f_puts
        PUBLIC f_read
        PUBLIC f_readdir
        PUBLIC f_rename
        PUBLIC f_stat
        PUBLIC f_sync
        PUBLIC f_truncate
        PUBLIC f_unlink
        PUBLIC f_utime
        PUBLIC f_write
        PUBLIC get_fat
        PUBLIC put_fat

// C:\Users\Lenovo\Desktop\class3\@@@@@_@@@1@3@14@\@@@@@_@@@1@3@14@\src\Sources\C\SD_C\ff.c
//    1 /*----------------------------------------------------------------------------/
//    2 /  FatFs - FAT file system module  R0.08b                 (C)ChaN, 2011
//    3 /-----------------------------------------------------------------------------/
//    4 / FatFs module is a generic FAT file system module for small embedded systems.
//    5 / This is a free software that opened for education, research and commercial
//    6 / developments under license policy of following terms.
//    7 /
//    8 /  Copyright (C) 2011, ChaN, all right reserved.
//    9 /
//   10 / * The FatFs module is a free software and there is NO WARRANTY.
//   11 / * No restriction on use. You can use, modify and redistribute it for
//   12 /   personal, non-profit or commercial products UNDER YOUR RESPONSIBILITY.
//   13 / * Redistributions of source code must retain the above copyright notice.
//   14 /
//   15 /-----------------------------------------------------------------------------/
//   16 / Feb 26,'06 R0.00  Prototype.
//   17 /
//   18 / Apr 29,'06 R0.01  First stable version.
//   19 /
//   20 / Jun 01,'06 R0.02  Added FAT12 support.
//   21 /                   Removed unbuffered mode.
//   22 /                   Fixed a problem on small (<32M) partition.
//   23 / Jun 10,'06 R0.02a Added a configuration option (_FS_MINIMUM).
//   24 /
//   25 / Sep 22,'06 R0.03  Added f_rename().
//   26 /                   Changed option _FS_MINIMUM to _FS_MINIMIZE.
//   27 / Dec 11,'06 R0.03a Improved cluster scan algorithm to write files fast.
//   28 /                   Fixed f_mkdir() creates incorrect directory on FAT32.
//   29 /
//   30 / Feb 04,'07 R0.04  Supported multiple drive system.
//   31 /                   Changed some interfaces for multiple drive system.
//   32 /                   Changed f_mountdrv() to f_mount().
//   33 /                   Added f_mkfs().
//   34 / Apr 01,'07 R0.04a Supported multiple partitions on a physical drive.
//   35 /                   Added a capability of extending file size to f_lseek().
//   36 /                   Added minimization level 3.
//   37 /                   Fixed an endian sensitive code in f_mkfs().
//   38 / May 05,'07 R0.04b Added a configuration option _USE_NTFLAG.
//   39 /                   Added FSInfo support.
//   40 /                   Fixed DBCS name can result FR_INVALID_NAME.
//   41 /                   Fixed short seek (<= csize) collapses the file object.
//   42 /
//   43 / Aug 25,'07 R0.05  Changed arguments of f_read(), f_write() and f_mkfs().
//   44 /                   Fixed f_mkfs() on FAT32 creates incorrect FSInfo.
//   45 /                   Fixed f_mkdir() on FAT32 creates incorrect directory.
//   46 / Feb 03,'08 R0.05a Added f_truncate() and f_utime().
//   47 /                   Fixed off by one error at FAT sub-type determination.
//   48 /                   Fixed btr in f_read() can be mistruncated.
//   49 /                   Fixed cached sector is not flushed when create and close without write.
//   50 /
//   51 / Apr 01,'08 R0.06  Added fputc(), fputs(), fprintf() and fgets().
//   52 /                   Improved performance of f_lseek() on moving to the same or following cluster.
//   53 /
//   54 / Apr 01,'09 R0.07  Merged Tiny-FatFs as a configuration option. (_FS_TINY)
//   55 /                   Added long file name feature.
//   56 /                   Added multiple code page feature.
//   57 /                   Added re-entrancy for multitask operation.
//   58 /                   Added auto cluster size selection to f_mkfs().
//   59 /                   Added rewind option to f_readdir().
//   60 /                   Changed result code of critical errors.
//   61 /                   Renamed string functions to avoid name collision.
//   62 / Apr 14,'09 R0.07a Separated out OS dependent code on reentrant cfg.
//   63 /                   Added multiple sector size feature.
//   64 / Jun 21,'09 R0.07c Fixed f_unlink() can return FR_OK on error.
//   65 /                   Fixed wrong cache control in f_lseek().
//   66 /                   Added relative path feature.
//   67 /                   Added f_chdir() and f_chdrive().
//   68 /                   Added proper case conversion to extended char.
//   69 / Nov 03,'09 R0.07e Separated out configuration options from ff.h to ffconf.h.
//   70 /                   Fixed f_unlink() fails to remove a sub-dir on _FS_RPATH.
//   71 /                   Fixed name matching error on the 13 char boundary.
//   72 /                   Added a configuration option, _LFN_UNICODE.
//   73 /                   Changed f_readdir() to return the SFN with always upper case on non-LFN cfg.
//   74 /
//   75 / May 15,'10 R0.08  Added a memory configuration option. (_USE_LFN = 3)
//   76 /                   Added file lock feature. (_FS_SHARE)
//   77 /                   Added fast seek feature. (_USE_FASTSEEK)
//   78 /                   Changed some types on the API, XCHAR->TCHAR.
//   79 /                   Changed fname member in the FILINFO structure on Unicode cfg.
//   80 /                   String functions support UTF-8 encoding files on Unicode cfg.
//   81 / Aug 16,'10 R0.08a Added f_getcwd(). (_FS_RPATH = 2)
//   82 /                   Added sector erase feature. (_USE_ERASE)
//   83 /                   Moved file lock semaphore table from fs object to the bss.
//   84 /                   Fixed a wrong directory entry is created on non-LFN cfg when the given name contains ';'.
//   85 /                   Fixed f_mkfs() creates wrong FAT32 volume.
//   86 / Jan 15,'11 R0.08b Fast seek feature is also applied to f_read() and f_write().
//   87 /                   f_lseek() reports required table size on creating CLMP.
//   88 /                   Extended format syntax of f_printf function.
//   89 /                   Ignores duplicated directory separators in given path names.
//   90 /---------------------------------------------------------------------------*/
//   91 
//   92 #include "ff.h"			/* FatFs configurations and declarations */
//   93 #include "diskio.h"		/* Declarations of low level disk I/O functions */
//   94 
//   95 
//   96 /*--------------------------------------------------------------------------
//   97 
//   98    Module Private Definitions
//   99 
//  100 ---------------------------------------------------------------------------*/
//  101 
//  102 #if _FATFS != 8237
//  103 #error Wrong include file (ff.h).
//  104 #endif
//  105 
//  106 
//  107 /* Definitions on sector size */
//  108 #if _MAX_SS != 512 && _MAX_SS != 1024 && _MAX_SS != 2048 && _MAX_SS != 4096
//  109 #error Wrong sector size.
//  110 #endif
//  111 #if _MAX_SS != 512
//  112 #define	SS(fs)	((fs)->ssize)	/* Multiple sector size */
//  113 #else
//  114 #define	SS(fs)	512U			/* Fixed sector size */
//  115 #endif
//  116 
//  117 
//  118 /* Reentrancy related */
//  119 #if _FS_REENTRANT
//  120 #if _USE_LFN == 1
//  121 #error Static LFN work area must not be used in re-entrant configuration.
//  122 #endif
//  123 #define	ENTER_FF(fs)		{ if (!lock_fs(fs)) return FR_TIMEOUT; }
//  124 #define	LEAVE_FF(fs, res)	{ unlock_fs(fs, res); return res; }
//  125 #else
//  126 #define	ENTER_FF(fs)
//  127 #define LEAVE_FF(fs, res)	return res
//  128 #endif
//  129 
//  130 #define	ABORT(fs, res)		{ fp->flag |= FA__ERROR; LEAVE_FF(fs, res); }
//  131 
//  132 
//  133 /* File shareing feature */
//  134 #if _FS_SHARE
//  135 #if _FS_READONLY
//  136 #error _FS_SHARE must be 0 on read-only cfg.
//  137 #endif
//  138 typedef struct {
//  139 	FATFS *fs;				/* File ID 1, volume (NULL:blank entry) */
//  140 	DWORD clu;				/* File ID 2, directory */
//  141 	WORD idx;				/* File ID 3, directory index */
//  142 	WORD ctr;				/* File open counter, 0:none, 0x01..0xFF:read open count, 0x100:write mode */
//  143 } FILESEM;
//  144 #endif
//  145 
//  146 
//  147 /* Misc definitions */
//  148 #define LD_CLUST(dir)	(((DWORD)LD_WORD(dir+DIR_FstClusHI)<<16) | LD_WORD(dir+DIR_FstClusLO))
//  149 #define ST_CLUST(dir,cl) {ST_WORD(dir+DIR_FstClusLO, cl); ST_WORD(dir+DIR_FstClusHI, (DWORD)cl>>16);}
//  150 
//  151 
//  152 /* DBCS code ranges and SBCS extend char conversion table */
//  153 
//  154 #if _CODE_PAGE == 932	/* Japanese Shift-JIS */
//  155 #define _DF1S	0x81	/* DBC 1st byte range 1 start */
//  156 #define _DF1E	0x9F	/* DBC 1st byte range 1 end */
//  157 #define _DF2S	0xE0	/* DBC 1st byte range 2 start */
//  158 #define _DF2E	0xFC	/* DBC 1st byte range 2 end */
//  159 #define _DS1S	0x40	/* DBC 2nd byte range 1 start */
//  160 #define _DS1E	0x7E	/* DBC 2nd byte range 1 end */
//  161 #define _DS2S	0x80	/* DBC 2nd byte range 2 start */
//  162 #define _DS2E	0xFC	/* DBC 2nd byte range 2 end */
//  163 
//  164 #elif _CODE_PAGE == 936	/* Simplified Chinese GBK */
//  165 #define _DF1S	0x81
//  166 #define _DF1E	0xFE
//  167 #define _DS1S	0x40
//  168 #define _DS1E	0x7E
//  169 #define _DS2S	0x80
//  170 #define _DS2E	0xFE
//  171 
//  172 #elif _CODE_PAGE == 949	/* Korean */
//  173 #define _DF1S	0x81
//  174 #define _DF1E	0xFE
//  175 #define _DS1S	0x41
//  176 #define _DS1E	0x5A
//  177 #define _DS2S	0x61
//  178 #define _DS2E	0x7A
//  179 #define _DS3S	0x81
//  180 #define _DS3E	0xFE
//  181 
//  182 #elif _CODE_PAGE == 950	/* Traditional Chinese Big5 */
//  183 #define _DF1S	0x81
//  184 #define _DF1E	0xFE
//  185 #define _DS1S	0x40
//  186 #define _DS1E	0x7E
//  187 #define _DS2S	0xA1
//  188 #define _DS2E	0xFE
//  189 
//  190 #elif _CODE_PAGE == 437	/* U.S. (OEM) */
//  191 #define _DF1S	0
//  192 #define _EXCVT {0x80,0x9A,0x90,0x41,0x8E,0x41,0x8F,0x80,0x45,0x45,0x45,0x49,0x49,0x49,0x8E,0x8F,0x90,0x92,0x92,0x4F,0x99,0x4F,0x55,0x55,0x59,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  193 				0x41,0x49,0x4F,0x55,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  194 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  195 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  196 
//  197 #elif _CODE_PAGE == 720	/* Arabic (OEM) */
//  198 #define _DF1S	0
//  199 #define _EXCVT {0x80,0x81,0x45,0x41,0x84,0x41,0x86,0x43,0x45,0x45,0x45,0x49,0x49,0x8D,0x8E,0x8F,0x90,0x92,0x92,0x93,0x94,0x95,0x49,0x49,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  200 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  201 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  202 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  203 
//  204 #elif _CODE_PAGE == 737	/* Greek (OEM) */
//  205 #define _DF1S	0
//  206 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x92,0x92,0x93,0x94,0x95,0x96,0x97,0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87, \ 
//  207 				0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0xAA,0x92,0x93,0x94,0x95,0x96,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  208 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  209 				0x97,0xEA,0xEB,0xEC,0xE4,0xED,0xEE,0xE7,0xE8,0xF1,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  210 
//  211 #elif _CODE_PAGE == 775	/* Baltic (OEM) */
//  212 #define _DF1S	0
//  213 #define _EXCVT {0x80,0x9A,0x91,0xA0,0x8E,0x95,0x8F,0x80,0xAD,0xED,0x8A,0x8A,0xA1,0x8D,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0x95,0x96,0x97,0x97,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9F, \ 
//  214 				0xA0,0xA1,0xE0,0xA3,0xA3,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  215 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xB5,0xB6,0xB7,0xB8,0xBD,0xBE,0xC6,0xC7,0xA5,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  216 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE3,0xE8,0xE8,0xEA,0xEA,0xEE,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  217 
//  218 #elif _CODE_PAGE == 850	/* Multilingual Latin 1 (OEM) */
//  219 #define _DF1S	0
//  220 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xB7,0x8F,0x80,0xD2,0xD3,0xD4,0xD8,0xD7,0xDE,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0xE3,0xEA,0xEB,0x59,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9F, \ 
//  221 				0xB5,0xD6,0xE0,0xE9,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  222 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  223 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE7,0xE7,0xE9,0xEA,0xEB,0xED,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  224 
//  225 #elif _CODE_PAGE == 852	/* Latin 2 (OEM) */
//  226 #define _DF1S	0
//  227 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xDE,0x8F,0x80,0x9D,0xD3,0x8A,0x8A,0xD7,0x8D,0x8E,0x8F,0x90,0x91,0x91,0xE2,0x99,0x95,0x95,0x97,0x97,0x99,0x9A,0x9B,0x9B,0x9D,0x9E,0x9F, \ 
//  228 				0xB5,0xD6,0xE0,0xE9,0xA4,0xA4,0xA6,0xA6,0xA8,0xA8,0xAA,0x8D,0xAC,0xB8,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBD,0xBF, \ 
//  229 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC6,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD1,0xD1,0xD2,0xD3,0xD2,0xD5,0xD6,0xD7,0xB7,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  230 				0xE0,0xE1,0xE2,0xE3,0xE3,0xD5,0xE6,0xE6,0xE8,0xE9,0xE8,0xEB,0xED,0xED,0xDD,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xEB,0xFC,0xFC,0xFE,0xFF}
//  231 
//  232 #elif _CODE_PAGE == 855	/* Cyrillic (OEM) */
//  233 #define _DF1S	0
//  234 #define _EXCVT {0x81,0x81,0x83,0x83,0x85,0x85,0x87,0x87,0x89,0x89,0x8B,0x8B,0x8D,0x8D,0x8F,0x8F,0x91,0x91,0x93,0x93,0x95,0x95,0x97,0x97,0x99,0x99,0x9B,0x9B,0x9D,0x9D,0x9F,0x9F, \ 
//  235 				0xA1,0xA1,0xA3,0xA3,0xA5,0xA5,0xA7,0xA7,0xA9,0xA9,0xAB,0xAB,0xAD,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB6,0xB6,0xB8,0xB8,0xB9,0xBA,0xBB,0xBC,0xBE,0xBE,0xBF, \ 
//  236 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD1,0xD1,0xD3,0xD3,0xD5,0xD5,0xD7,0xD7,0xDD,0xD9,0xDA,0xDB,0xDC,0xDD,0xE0,0xDF, \ 
//  237 				0xE0,0xE2,0xE2,0xE4,0xE4,0xE6,0xE6,0xE8,0xE8,0xEA,0xEA,0xEC,0xEC,0xEE,0xEE,0xEF,0xF0,0xF2,0xF2,0xF4,0xF4,0xF6,0xF6,0xF8,0xF8,0xFA,0xFA,0xFC,0xFC,0xFD,0xFE,0xFF}
//  238 
//  239 #elif _CODE_PAGE == 857	/* Turkish (OEM) */
//  240 #define _DF1S	0
//  241 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xB7,0x8F,0x80,0xD2,0xD3,0xD4,0xD8,0xD7,0x98,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0xE3,0xEA,0xEB,0x98,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9E, \ 
//  242 				0xB5,0xD6,0xE0,0xE9,0xA5,0xA5,0xA6,0xA6,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  243 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  244 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xDE,0x59,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  245 
//  246 #elif _CODE_PAGE == 858	/* Multilingual Latin 1 + Euro (OEM) */
//  247 #define _DF1S	0
//  248 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xB7,0x8F,0x80,0xD2,0xD3,0xD4,0xD8,0xD7,0xDE,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0xE3,0xEA,0xEB,0x59,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9F, \ 
//  249 				0xB5,0xD6,0xE0,0xE9,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  250 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD1,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  251 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE7,0xE7,0xE9,0xEA,0xEB,0xED,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  252 
//  253 #elif _CODE_PAGE == 862	/* Hebrew (OEM) */
//  254 #define _DF1S	0
//  255 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  256 				0x41,0x49,0x4F,0x55,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  257 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  258 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  259 
//  260 #elif _CODE_PAGE == 866	/* Russian (OEM) */
//  261 #define _DF1S	0
//  262 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  263 				0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  264 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  265 				0x90,0x91,0x92,0x93,0x9d,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F,0xF0,0xF0,0xF2,0xF2,0xF4,0xF4,0xF6,0xF6,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  266 
//  267 #elif _CODE_PAGE == 874	/* Thai (OEM, Windows) */
//  268 #define _DF1S	0
//  269 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  270 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  271 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  272 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  273 
//  274 #elif _CODE_PAGE == 1250 /* Central Europe (Windows) */
//  275 #define _DF1S	0
//  276 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x8A,0x9B,0x8C,0x8D,0x8E,0x8F, \ 
//  277 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xA3,0xB4,0xB5,0xB6,0xB7,0xB8,0xA5,0xAA,0xBB,0xBC,0xBD,0xBC,0xAF, \ 
//  278 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  279 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xFF}
//  280 
//  281 #elif _CODE_PAGE == 1251 /* Cyrillic (Windows) */
//  282 #define _DF1S	0
//  283 #define _EXCVT {0x80,0x81,0x82,0x82,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x80,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x8A,0x9B,0x8C,0x8D,0x8E,0x8F, \ 
//  284 				0xA0,0xA2,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB2,0xA5,0xB5,0xB6,0xB7,0xA8,0xB9,0xAA,0xBB,0xA3,0xBD,0xBD,0xAF, \ 
//  285 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  286 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF}
//  287 
//  288 #elif _CODE_PAGE == 1252 /* Latin 1 (Windows) */
//  289 #define _DF1S	0
//  290 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0xAd,0x9B,0x8C,0x9D,0xAE,0x9F, \ 
//  291 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  292 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  293 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0x9F}
//  294 
//  295 #elif _CODE_PAGE == 1253 /* Greek (Windows) */
//  296 #define _DF1S	0
//  297 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  298 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  299 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xA2,0xB8,0xB9,0xBA, \ 
//  300 				0xE0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xF2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xFB,0xBC,0xFD,0xBF,0xFF}
//  301 
//  302 #elif _CODE_PAGE == 1254 /* Turkish (Windows) */
//  303 #define _DF1S	0
//  304 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x8A,0x9B,0x8C,0x9D,0x9E,0x9F, \ 
//  305 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  306 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  307 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0x9F}
//  308 
//  309 #elif _CODE_PAGE == 1255 /* Hebrew (Windows) */
//  310 #define _DF1S	0
//  311 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  312 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  313 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  314 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  315 
//  316 #elif _CODE_PAGE == 1256 /* Arabic (Windows) */
//  317 #define _DF1S	0
//  318 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x8C,0x9D,0x9E,0x9F, \ 
//  319 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  320 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  321 				0x41,0xE1,0x41,0xE3,0xE4,0xE5,0xE6,0x43,0x45,0x45,0x45,0x45,0xEC,0xED,0x49,0x49,0xF0,0xF1,0xF2,0xF3,0x4F,0xF5,0xF6,0xF7,0xF8,0x55,0xFA,0x55,0x55,0xFD,0xFE,0xFF}
//  322 
//  323 #elif _CODE_PAGE == 1257 /* Baltic (Windows) */
//  324 #define _DF1S	0
//  325 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  326 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xA8,0xB9,0xAA,0xBB,0xBC,0xBD,0xBE,0xAF, \ 
//  327 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  328 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xFF}
//  329 
//  330 #elif _CODE_PAGE == 1258 /* Vietnam (OEM, Windows) */
//  331 #define _DF1S	0
//  332 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0xAC,0x9D,0x9E,0x9F, \ 
//  333 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  334 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  335 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xEC,0xCD,0xCE,0xCF,0xD0,0xD1,0xF2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xFE,0x9F}
//  336 
//  337 #elif _CODE_PAGE == 1	/* ASCII (for only non-LFN cfg) */
//  338 #if _USE_LFN
//  339 #error Cannot use LFN feature without valid code page.
//  340 #endif
//  341 #define _DF1S	0
//  342 
//  343 #else
//  344 #error Unknown code page
//  345 
//  346 #endif
//  347 
//  348 
//  349 /* Character code support macros */
//  350 #define IsUpper(c)	(((c)>='A')&&((c)<='Z'))
//  351 #define IsLower(c)	(((c)>='a')&&((c)<='z'))
//  352 #define IsDigit(c)	(((c)>='0')&&((c)<='9'))
//  353 
//  354 #if _DF1S		/* Code page is DBCS */
//  355 
//  356 #ifdef _DF2S	/* Two 1st byte areas */
//  357 #define IsDBCS1(c)	(((BYTE)(c) >= _DF1S && (BYTE)(c) <= _DF1E) || ((BYTE)(c) >= _DF2S && (BYTE)(c) <= _DF2E))
//  358 #else			/* One 1st byte area */
//  359 #define IsDBCS1(c)	((BYTE)(c) >= _DF1S && (BYTE)(c) <= _DF1E)
//  360 #endif
//  361 
//  362 #ifdef _DS3S	/* Three 2nd byte areas */
//  363 #define IsDBCS2(c)	(((BYTE)(c) >= _DS1S && (BYTE)(c) <= _DS1E) || ((BYTE)(c) >= _DS2S && (BYTE)(c) <= _DS2E) || ((BYTE)(c) >= _DS3S && (BYTE)(c) <= _DS3E))
//  364 #else			/* Two 2nd byte areas */
//  365 #define IsDBCS2(c)	(((BYTE)(c) >= _DS1S && (BYTE)(c) <= _DS1E) || ((BYTE)(c) >= _DS2S && (BYTE)(c) <= _DS2E))
//  366 #endif
//  367 
//  368 #else			/* Code page is SBCS */
//  369 
//  370 #define IsDBCS1(c)	0
//  371 #define IsDBCS2(c)	0
//  372 
//  373 #endif /* _DF1S */
//  374 
//  375 
//  376 /* Name status flags */
//  377 #define NS			11		/* Index of name status byte in fn[] */
//  378 #define NS_LOSS		0x01	/* Out of 8.3 format */
//  379 #define NS_LFN		0x02	/* Force to create LFN entry */
//  380 #define NS_LAST		0x04	/* Last segment */
//  381 #define NS_BODY		0x08	/* Lower case flag (body) */
//  382 #define NS_EXT		0x10	/* Lower case flag (ext) */
//  383 #define NS_DOT		0x20	/* Dot entry */
//  384 
//  385 
//  386 /* FAT sub-type boundaries */
//  387 /* Note that the FAT spec by Microsoft says 4085 but Windows works with 4087! */
//  388 #define MIN_FAT16	4086	/* Minimum number of clusters for FAT16 */
//  389 #define	MIN_FAT32	65526	/* Minimum number of clusters for FAT32 */
//  390 
//  391 
//  392 /* FatFs refers the members in the FAT structures as byte array instead of
//  393 / structure member because the structure is not binary compatible between
//  394 / different platforms */
//  395 
//  396 #define BS_jmpBoot			0	/* Jump instruction (3) */
//  397 #define BS_OEMName			3	/* OEM name (8) */
//  398 #define BPB_BytsPerSec		11	/* Sector size [byte] (2) */
//  399 #define BPB_SecPerClus		13	/* Cluster size [sector] (1) */
//  400 #define BPB_RsvdSecCnt		14	/* Size of reserved area [sector] (2) */
//  401 #define BPB_NumFATs			16	/* Number of FAT copies (1) */
//  402 #define BPB_RootEntCnt		17	/* Number of root dir entries for FAT12/16 (2) */
//  403 #define BPB_TotSec16		19	/* Volume size [sector] (2) */
//  404 #define BPB_Media			21	/* Media descriptor (1) */
//  405 #define BPB_FATSz16			22	/* FAT size [sector] (2) */
//  406 #define BPB_SecPerTrk		24	/* Track size [sector] (2) */
//  407 #define BPB_NumHeads		26	/* Number of heads (2) */
//  408 #define BPB_HiddSec			28	/* Number of special hidden sectors (4) */
//  409 #define BPB_TotSec32		32	/* Volume size [sector] (4) */
//  410 #define BS_DrvNum			36	/* Physical drive number (2) */
//  411 #define BS_BootSig			38	/* Extended boot signature (1) */
//  412 #define BS_VolID			39	/* Volume serial number (4) */
//  413 #define BS_VolLab			43	/* Volume label (8) */
//  414 #define BS_FilSysType		54	/* File system type (1) */
//  415 #define BPB_FATSz32			36	/* FAT size [sector] (4) */
//  416 #define BPB_ExtFlags		40	/* Extended flags (2) */
//  417 #define BPB_FSVer			42	/* File system version (2) */
//  418 #define BPB_RootClus		44	/* Root dir first cluster (4) */
//  419 #define BPB_FSInfo			48	/* Offset of FSInfo sector (2) */
//  420 #define BPB_BkBootSec		50	/* Offset of backup boot sectot (2) */
//  421 #define BS_DrvNum32			64	/* Physical drive number (2) */
//  422 #define BS_BootSig32		66	/* Extended boot signature (1) */
//  423 #define BS_VolID32			67	/* Volume serial number (4) */
//  424 #define BS_VolLab32			71	/* Volume label (8) */
//  425 #define BS_FilSysType32		82	/* File system type (1) */
//  426 #define	FSI_LeadSig			0	/* FSI: Leading signature (4) */
//  427 #define	FSI_StrucSig		484	/* FSI: Structure signature (4) */
//  428 #define	FSI_Free_Count		488	/* FSI: Number of free clusters (4) */
//  429 #define	FSI_Nxt_Free		492	/* FSI: Last allocated cluster (4) */
//  430 #define MBR_Table			446	/* MBR: Partition table offset (2) */
//  431 #define	SZ_PTE				16	/* MBR: Size of a partition table entry */
//  432 #define BS_55AA				510	/* Boot sector signature (2) */
//  433 
//  434 #define	DIR_Name			0	/* Short file name (11) */
//  435 #define	DIR_Attr			11	/* Attribute (1) */
//  436 #define	DIR_NTres			12	/* NT flag (1) */
//  437 #define	DIR_CrtTime			14	/* Created time (2) */
//  438 #define	DIR_CrtDate			16	/* Created date (2) */
//  439 #define	DIR_FstClusHI		20	/* Higher 16-bit of first cluster (2) */
//  440 #define	DIR_WrtTime			22	/* Modified time (2) */
//  441 #define	DIR_WrtDate			24	/* Modified date (2) */
//  442 #define	DIR_FstClusLO		26	/* Lower 16-bit of first cluster (2) */
//  443 #define	DIR_FileSize		28	/* File size (4) */
//  444 #define	LDIR_Ord			0	/* LFN entry order and LLE flag (1) */
//  445 #define	LDIR_Attr			11	/* LFN attribute (1) */
//  446 #define	LDIR_Type			12	/* LFN type (1) */
//  447 #define	LDIR_Chksum			13	/* Sum of corresponding SFN entry */
//  448 #define	LDIR_FstClusLO		26	/* Filled by zero (0) */
//  449 #define	SZ_DIR				32		/* Size of a directory entry */
//  450 #define	LLE					0x40	/* Last long entry flag in LDIR_Ord */
//  451 #define	DDE					0xE5	/* Deleted directory enrty mark in DIR_Name[0] */
//  452 #define	NDDE				0x05	/* Replacement of a character collides with DDE */
//  453 
//  454 
//  455 /*------------------------------------------------------------*/
//  456 /* Work area                                                  */
//  457 
//  458 #if _VOLUMES
//  459 static

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
        DATA
//  460 FATFS *FatFs[_VOLUMES];	/* Pointer to the file system objects (logical drives) */
FatFs:
        DS8 4
//  461 #else
//  462 #error Number of drives must not be 0.
//  463 #endif
//  464 
//  465 static

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
        DATA
//  466 WORD Fsid;				/* File system mount ID */
Fsid:
        DS8 2
//  467 
//  468 #if _FS_RPATH
//  469 static
//  470 BYTE CurrVol;			/* Current drive */
//  471 #endif
//  472 
//  473 #if _FS_SHARE
//  474 static
//  475 FILESEM	Files[_FS_SHARE];	/* File lock semaphores */
//  476 #endif
//  477 
//  478 #if _USE_LFN == 0			/* No LFN */
//  479 #define	DEF_NAMEBUF			BYTE sfn[12]
//  480 #define INIT_BUF(dobj)		(dobj).fn = sfn
//  481 #define	FREE_BUF()
//  482 
//  483 #elif _USE_LFN == 1			/* LFN with static LFN working buffer */
//  484 static WCHAR LfnBuf[_MAX_LFN+1];
//  485 #define	DEF_NAMEBUF			BYTE sfn[12]
//  486 #define INIT_BUF(dobj)		{ (dobj).fn = sfn; (dobj).lfn = LfnBuf; }
//  487 #define	FREE_BUF()
//  488 
//  489 #elif _USE_LFN == 2 		/* LFN with dynamic LFN working buffer on the stack */
//  490 #define	DEF_NAMEBUF			BYTE sfn[12]; WCHAR lbuf[_MAX_LFN+1]
//  491 #define INIT_BUF(dobj)		{ (dobj).fn = sfn; (dobj).lfn = lbuf; }
//  492 #define	FREE_BUF()
//  493 
//  494 #elif _USE_LFN == 3 		/* LFN with dynamic LFN working buffer on the heap */
//  495 #define	DEF_NAMEBUF			BYTE sfn[12]; WCHAR *lfn
//  496 #define INIT_BUF(dobj)		{ lfn = ff_memalloc((_MAX_LFN + 1) * 2); \ 
//  497 							  if (!lfn) LEAVE_FF((dobj).fs, FR_NOT_ENOUGH_CORE); \ 
//  498 							  (dobj).lfn = lfn;	(dobj).fn = sfn; }
//  499 #define	FREE_BUF()			ff_memfree(lfn)
//  500 
//  501 #else
//  502 #error Wrong LFN configuration.
//  503 #endif
//  504 
//  505 
//  506 
//  507 
//  508 /*--------------------------------------------------------------------------
//  509 
//  510    Module Private Functions
//  511 
//  512 ---------------------------------------------------------------------------*/
//  513 
//  514 
//  515 /*-----------------------------------------------------------------------*/
//  516 /* String functions                                                      */
//  517 /*-----------------------------------------------------------------------*/
//  518 
//  519 /* Copy memory to memory */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  520 static
//  521 void mem_cpy (void* dst, const void* src, UINT cnt) {
//  522 	BYTE *d = (BYTE*)dst;
//  523 	const BYTE *s = (const BYTE*)src;
mem_cpy:
        B.N      ??mem_cpy_0
//  524 
//  525 #if _WORD_ACCESS == 1
//  526 	while (cnt >= sizeof(int)) {
//  527 		*(int*)d = *(int*)s;
//  528 		d += sizeof(int); s += sizeof(int);
//  529 		cnt -= sizeof(int);
//  530 	}
//  531 #endif
//  532 	while (cnt--)
//  533 		*d++ = *s++;
??mem_cpy_1:
        LDRB     R3,[R1, #+0]
        STRB     R3,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
??mem_cpy_0:
        MOVS     R3,R2
        SUBS     R2,R3,#+1
        CMP      R3,#+0
        BNE.N    ??mem_cpy_1
//  534 }
        BX       LR               ;; return
//  535 
//  536 /* Fill memory */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  537 static
//  538 void mem_set (void* dst, int val, UINT cnt) {
//  539 	BYTE *d = (BYTE*)dst;
mem_set:
        B.N      ??mem_set_0
//  540 
//  541 	while (cnt--)
//  542 		*d++ = (BYTE)val;
??mem_set_1:
        STRB     R1,[R0, #+0]
        ADDS     R0,R0,#+1
??mem_set_0:
        MOVS     R3,R2
        SUBS     R2,R3,#+1
        CMP      R3,#+0
        BNE.N    ??mem_set_1
//  543 }
        BX       LR               ;; return
//  544 
//  545 /* Compare memory to memory */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  546 static
//  547 int mem_cmp (const void* dst, const void* src, UINT cnt) {
mem_cmp:
        PUSH     {R4}
        MOVS     R4,R0
//  548 	const BYTE *d = (const BYTE *)dst, *s = (const BYTE *)src;
//  549 	int r = 0;
        MOVS     R0,#+0
//  550 
//  551 	while (cnt-- && (r = *d++ - *s++) == 0) ;
??mem_cmp_0:
        MOVS     R3,R2
        SUBS     R2,R3,#+1
        CMP      R3,#+0
        BEQ.N    ??mem_cmp_1
        LDRB     R3,[R4, #+0]
        LDRB     R0,[R1, #+0]
        SUBS     R0,R3,R0
        ADDS     R1,R1,#+1
        ADDS     R4,R4,#+1
        CMP      R0,#+0
        BEQ.N    ??mem_cmp_0
//  552 	return r;
??mem_cmp_1:
        POP      {R4}
        BX       LR               ;; return
//  553 }
//  554 
//  555 /* Check if chr is contained in the string */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  556 static
//  557 int chk_chr (const char* str, int chr) {
chk_chr:
        B.N      ??chk_chr_0
//  558 	while (*str && *str != chr) str++;
??chk_chr_1:
        ADDS     R0,R0,#+1
??chk_chr_0:
        LDRB     R2,[R0, #+0]
        CMP      R2,#+0
        BEQ.N    ??chk_chr_2
        LDRB     R2,[R0, #+0]
        CMP      R2,R1
        BNE.N    ??chk_chr_1
//  559 	return *str;
??chk_chr_2:
        LDRB     R0,[R0, #+0]
        BX       LR               ;; return
//  560 }
//  561 
//  562 
//  563 
//  564 /*-----------------------------------------------------------------------*/
//  565 /* Request/Release grant to access the volume                            */
//  566 /*-----------------------------------------------------------------------*/
//  567 #if _FS_REENTRANT
//  568 
//  569 static
//  570 int lock_fs (
//  571 	FATFS *fs		/* File system object */
//  572 )
//  573 {
//  574 	return ff_req_grant(fs->sobj);
//  575 }
//  576 
//  577 
//  578 static
//  579 void unlock_fs (
//  580 	FATFS *fs,		/* File system object */
//  581 	FRESULT res		/* Result code to be returned */
//  582 )
//  583 {
//  584 	if (res != FR_NOT_ENABLED &&
//  585 		res != FR_INVALID_DRIVE &&
//  586 		res != FR_INVALID_OBJECT &&
//  587 		res != FR_TIMEOUT) {
//  588 		ff_rel_grant(fs->sobj);
//  589 	}
//  590 }
//  591 #endif
//  592 
//  593 
//  594 
//  595 /*-----------------------------------------------------------------------*/
//  596 /* File shareing control functions                                       */
//  597 /*-----------------------------------------------------------------------*/
//  598 #if _FS_SHARE
//  599 
//  600 static
//  601 FRESULT chk_lock (	/* Check if the file can be accessed */
//  602 	DIR* dj,		/* Directory object pointing the file to be checked */
//  603 	int acc			/* Desired access (0:Read, 1:Write, 2:Delete/Rename) */
//  604 )
//  605 {
//  606 	UINT i, be;
//  607 
//  608 	/* Search file semaphore table */
//  609 	for (i = be = 0; i < _FS_SHARE; i++) {
//  610 		if (Files[i].fs) {	/* Existing entry */
//  611 			if (Files[i].fs == dj->fs &&	 	/* Check if the file matched with an open file */
//  612 				Files[i].clu == dj->sclust &&
//  613 				Files[i].idx == dj->index) break;
//  614 		} else {			/* Blank entry */
//  615 			be++;
//  616 		}
//  617 	}
//  618 	if (i == _FS_SHARE)	/* The file is not opened */
//  619 		return (be || acc == 2) ? FR_OK : FR_TOO_MANY_OPEN_FILES;	/* Is there a blank entry for new file? */
//  620 
//  621 	/* The file has been opened. Reject any open against writing file and all write mode open */
//  622 	return (acc || Files[i].ctr == 0x100) ? FR_LOCKED : FR_OK;
//  623 }
//  624 
//  625 
//  626 static
//  627 int enq_lock (	/* Check if an entry is available for a new file */
//  628 	FATFS* fs	/* File system object */
//  629 )
//  630 {
//  631 	UINT i;
//  632 
//  633 	for (i = 0; i < _FS_SHARE && Files[i].fs; i++) ;
//  634 	return (i == _FS_SHARE) ? 0 : 1;
//  635 }
//  636 
//  637 
//  638 static
//  639 UINT inc_lock (	/* Increment file open counter and returns its index (0:int error) */
//  640 	DIR* dj,	/* Directory object pointing the file to register or increment */
//  641 	int acc		/* Desired access mode (0:Read, !0:Write) */
//  642 )
//  643 {
//  644 	UINT i;
//  645 
//  646 
//  647 	for (i = 0; i < _FS_SHARE; i++) {	/* Find the file */
//  648 		if (Files[i].fs == dj->fs &&
//  649 			Files[i].clu == dj->sclust &&
//  650 			Files[i].idx == dj->index) break;
//  651 	}
//  652 
//  653 	if (i == _FS_SHARE) {				/* Not opened. Register it as new. */
//  654 		for (i = 0; i < _FS_SHARE && Files[i].fs; i++) ;
//  655 		if (i == _FS_SHARE) return 0;	/* No space to register (int err) */
//  656 		Files[i].fs = dj->fs;
//  657 		Files[i].clu = dj->sclust;
//  658 		Files[i].idx = dj->index;
//  659 		Files[i].ctr = 0;
//  660 	}
//  661 
//  662 	if (acc && Files[i].ctr) return 0;	/* Access violation (int err) */
//  663 
//  664 	Files[i].ctr = acc ? 0x100 : Files[i].ctr + 1;	/* Set semaphore value */
//  665 
//  666 	return i + 1;
//  667 }
//  668 
//  669 
//  670 static
//  671 FRESULT dec_lock (	/* Decrement file open counter */
//  672 	UINT i			/* Semaphore index */
//  673 )
//  674 {
//  675 	WORD n;
//  676 	FRESULT res;
//  677 
//  678 
//  679 	if (--i < _FS_SHARE) {
//  680 		n = Files[i].ctr;
//  681 		if (n == 0x100) n = 0;
//  682 		if (n) n--;
//  683 		Files[i].ctr = n;
//  684 		if (!n) Files[i].fs = 0;
//  685 		res = FR_OK;
//  686 	} else {
//  687 		res = FR_INT_ERR;
//  688 	}
//  689 	return res;
//  690 }
//  691 
//  692 
//  693 static
//  694 void clear_lock (	/* Clear lock entries of the volume */
//  695 	FATFS *fs
//  696 )
//  697 {
//  698 	UINT i;
//  699 
//  700 	for (i = 0; i < _FS_SHARE; i++) {
//  701 		if (Files[i].fs == fs) Files[i].fs = 0;
//  702 	}
//  703 }
//  704 #endif
//  705 
//  706 
//  707 
//  708 /*-----------------------------------------------------------------------*/
//  709 /* Change window offset                                                  */
//  710 /*-----------------------------------------------------------------------*/
//  711 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  712 static
//  713 FRESULT move_window (
//  714 	FATFS *fs,		/* File system object */
//  715 	DWORD sector	/* Sector number to make appearance in the fs->win[] */
//  716 )					/* Move to zero only writes back dirty window */
//  717 {
move_window:
        PUSH     {R3-R7,LR}
        MOVS     R5,R0
        MOVS     R4,R1
//  718 	DWORD wsect;
//  719 
//  720 
//  721 	wsect = fs->winsect;
        LDR      R6,[R5, #+44]
//  722 	if (wsect != sector)
        CMP      R6,R4
        BEQ.N    ??move_window_0
//  723 	{	/* Changed current window */
//  724 #if !_FS_READONLY
//  725 		if (fs->wflag) 
        LDRB     R0,[R5, #+4]
        CMP      R0,#+0
        BEQ.N    ??move_window_1
//  726 		{	/* Write back dirty window if needed */
//  727 			if (disk_write(fs->drv, fs->win, wsect, 1) != RES_OK)
        MOVS     R3,#+1
        MOVS     R2,R6
        ADDS     R1,R5,#+48
        LDRB     R0,[R5, #+1]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??move_window_2
//  728 				return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??move_window_3
//  729 			fs->wflag = 0;
??move_window_2:
        MOVS     R0,#+0
        STRB     R0,[R5, #+4]
//  730 			if (wsect < (fs->fatbase + fs->fsize)) 
        LDR      R1,[R5, #+32]
        LDR      R0,[R5, #+28]
        ADDS     R1,R0,R1
        CMP      R6,R1
        BCS.N    ??move_window_1
//  731 			{	/* In FAT area */
//  732 				BYTE nf;
//  733 				for (nf = fs->n_fats; nf > 1; nf--) 
        LDRB     R7,[R5, #+3]
        B.N      ??move_window_4
//  734 				{	/* Reflect the change to all FAT copies */
//  735 					wsect += fs->fsize;
??move_window_5:
        LDR      R0,[R5, #+28]
        ADDS     R6,R0,R6
//  736 					disk_write(fs->drv, fs->win, wsect, 1);
        MOVS     R3,#+1
        MOVS     R2,R6
        ADDS     R1,R5,#+48
        LDRB     R0,[R5, #+1]
        BL       disk_write
//  737 				}
        SUBS     R7,R7,#+1
??move_window_4:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+2
        BGE.N    ??move_window_5
//  738 			}
//  739 		}
//  740 #endif
//  741 		if (sector) 
??move_window_1:
        CMP      R4,#+0
        BEQ.N    ??move_window_0
//  742 		{
//  743 			if (disk_read(fs->drv, fs->win, sector, 1) != RES_OK)
        MOVS     R3,#+1
        MOVS     R2,R4
        ADDS     R1,R5,#+48
        LDRB     R0,[R5, #+1]
        BL       disk_read
        CMP      R0,#+0
        BEQ.N    ??move_window_6
//  744 				return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??move_window_3
//  745 			fs->winsect = sector;
??move_window_6:
        STR      R4,[R5, #+44]
//  746 		}
//  747 	}
//  748 
//  749 	return FR_OK;
??move_window_0:
        MOVS     R0,#+0
??move_window_3:
        POP      {R1,R4-R7,PC}    ;; return
//  750 }
//  751 
//  752 
//  753 
//  754 
//  755 /*-----------------------------------------------------------------------*/
//  756 /* Clean-up cached data                                                  */
//  757 /*-----------------------------------------------------------------------*/
//  758 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  759 static
//  760 FRESULT sync (	/* FR_OK: successful, FR_DISK_ERR: failed */
//  761 	FATFS *fs	/* File system object */
//  762 )
//  763 {
sync:
        PUSH     {R3-R5,LR}
        MOVS     R5,R0
//  764 	FRESULT res;
//  765 
//  766 
//  767 	res = move_window(fs, 0);
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       move_window
        MOVS     R4,R0
//  768 	if (res == FR_OK) 
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??sync_0
//  769 	{
//  770 		/* Update FSInfo sector if needed */
//  771 		if (fs->fs_type == FS_FAT32 && fs->fsi_flag) 
        LDRB     R0,[R5, #+0]
        CMP      R0,#+3
        BNE.N    ??sync_1
        LDRB     R0,[R5, #+5]
        CMP      R0,#+0
        BEQ.N    ??sync_1
//  772 		{
//  773 			fs->winsect = 0;
        MOVS     R0,#+0
        STR      R0,[R5, #+44]
//  774 			/* Create FSInfo structure */
//  775 			mem_set(fs->win, 0, 512);
        MOV      R2,#+512
        MOVS     R1,#+0
        ADDS     R0,R5,#+48
        BL       mem_set
//  776 			ST_WORD(fs->win+BS_55AA, 0xAA55);
        MOVS     R0,#+85
        STRB     R0,[R5, #+558]
        MOVS     R0,#+170
        STRB     R0,[R5, #+559]
//  777 			ST_DWORD(fs->win+FSI_LeadSig, 0x41615252);
        MOVS     R0,#+82
        STRB     R0,[R5, #+48]
        MOVS     R0,#+82
        STRB     R0,[R5, #+49]
        MOVS     R0,#+97
        STRB     R0,[R5, #+50]
        MOVS     R0,#+65
        STRB     R0,[R5, #+51]
//  778 			ST_DWORD(fs->win+FSI_StrucSig, 0x61417272);
        MOVS     R0,#+114
        STRB     R0,[R5, #+532]
        MOVS     R0,#+114
        STRB     R0,[R5, #+533]
        MOVS     R0,#+65
        STRB     R0,[R5, #+534]
        MOVS     R0,#+97
        STRB     R0,[R5, #+535]
//  779 			ST_DWORD(fs->win+FSI_Free_Count, fs->free_clust);
        LDR      R0,[R5, #+16]
        STRB     R0,[R5, #+536]
        LDR      R0,[R5, #+16]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+537]
        LDR      R0,[R5, #+16]
        LSRS     R0,R0,#+16
        STRB     R0,[R5, #+538]
        LDR      R0,[R5, #+16]
        LSRS     R0,R0,#+24
        STRB     R0,[R5, #+539]
//  780 			ST_DWORD(fs->win+FSI_Nxt_Free, fs->last_clust);
        LDR      R0,[R5, #+12]
        STRB     R0,[R5, #+540]
        LDR      R0,[R5, #+12]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+541]
        LDR      R0,[R5, #+12]
        LSRS     R0,R0,#+16
        STRB     R0,[R5, #+542]
        LDR      R0,[R5, #+12]
        LSRS     R0,R0,#+24
        STRB     R0,[R5, #+543]
//  781 			/* Write it into the FSInfo sector */
//  782 			disk_write(fs->drv, fs->win, fs->fsi_sector, 1);
        MOVS     R3,#+1
        LDR      R2,[R5, #+20]
        ADDS     R1,R5,#+48
        LDRB     R0,[R5, #+1]
        BL       disk_write
//  783 			fs->fsi_flag = 0;
        MOVS     R0,#+0
        STRB     R0,[R5, #+5]
//  784 		}
//  785 		/* Make sure that no pending write process in the physical drive */
//  786 		if (disk_ioctl(fs->drv, CTRL_SYNC, (void*)0) != RES_OK)
??sync_1:
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDRB     R0,[R5, #+1]
        BL       disk_ioctl
        CMP      R0,#+0
        BEQ.N    ??sync_0
//  787 			res = FR_DISK_ERR;
        MOVS     R4,#+1
//  788 	}
//  789 
//  790 	return res;
??sync_0:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
//  791 }
//  792 #endif
//  793 
//  794 
//  795 
//  796 
//  797 /*-----------------------------------------------------------------------*/
//  798 /* Get sector# from cluster#                                             */
//  799 /*-----------------------------------------------------------------------*/
//  800 
//  801 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  802 DWORD clust2sect (	/* !=0: Sector number, 0: Failed - invalid cluster# */
//  803 	FATFS *fs,		/* File system object */
//  804 	DWORD clst		/* Cluster# to be converted */
//  805 )
//  806 {
//  807 	clst -= 2;
clust2sect:
        SUBS     R1,R1,#+2
//  808 	if (clst >= (fs->n_fatent - 2)) return 0;		/* Invalid cluster# */
        LDR      R2,[R0, #+24]
        SUBS     R2,R2,#+2
        CMP      R1,R2
        BCC.N    ??clust2sect_0
        MOVS     R0,#+0
        B.N      ??clust2sect_1
//  809 	return clst * fs->csize + fs->database;
??clust2sect_0:
        LDRB     R2,[R0, #+2]
        LDR      R0,[R0, #+40]
        MLA      R1,R2,R1,R0
        MOVS     R0,R1
??clust2sect_1:
        BX       LR               ;; return
//  810 }
//  811 
//  812 
//  813 
//  814 
//  815 /*-----------------------------------------------------------------------*/
//  816 /* FAT access - Read value of a FAT entry                                */
//  817 /*-----------------------------------------------------------------------*/
//  818 
//  819 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  820 DWORD get_fat (	/* 0xFFFFFFFF:Disk error, 1:Internal error, Else:Cluster status */
//  821 	FATFS *fs,	/* File system object */
//  822 	DWORD clst	/* Cluster# to get the link information */
//  823 )
//  824 {
get_fat:
        PUSH     {R3-R7,LR}
        MOVS     R5,R0
        MOVS     R4,R1
//  825 	UINT wc, bc;
//  826 	BYTE *p;
//  827 
//  828 
//  829 	if (clst < 2 || clst >= fs->n_fatent)	/* Chack range */
        CMP      R4,#+2
        BCC.N    ??get_fat_0
        LDR      R0,[R5, #+24]
        CMP      R4,R0
        BCC.N    ??get_fat_1
//  830 		return 1;
??get_fat_0:
        MOVS     R0,#+1
        B.N      ??get_fat_2
//  831 
//  832 	switch (fs->fs_type) {
??get_fat_1:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+1
        BEQ.N    ??get_fat_3
        BCC.N    ??get_fat_4
        CMP      R0,#+3
        BEQ.N    ??get_fat_5
        BCC.N    ??get_fat_6
        B.N      ??get_fat_4
//  833 	case FS_FAT12 :
//  834 		bc = (UINT)clst; bc += bc / 2;
??get_fat_3:
        MOVS     R7,R4
        ADDS     R7,R7,R7, LSR #+1
//  835 		if (move_window(fs, fs->fatbase + (bc / SS(fs)))) break;
        LDR      R1,[R5, #+32]
        ADDS     R1,R1,R7, LSR #+9
        MOVS     R0,R5
        BL       move_window
        CMP      R0,#+0
        BEQ.N    ??get_fat_7
//  836 		wc = fs->win[bc % SS(fs)]; bc++;
//  837 		if (move_window(fs, fs->fatbase + (bc / SS(fs)))) break;
//  838 		wc |= fs->win[bc % SS(fs)] << 8;
//  839 		return (clst & 1) ? (wc >> 4) : (wc & 0xFFF);
//  840 
//  841 	case FS_FAT16 :
//  842 		if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 2)))) break;
//  843 		p = &fs->win[clst * 2 % SS(fs)];
//  844 		return LD_WORD(p);
//  845 
//  846 	case FS_FAT32 :
//  847 		if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 4)))) break;
//  848 		p = &fs->win[clst * 4 % SS(fs)];
//  849 		return LD_DWORD(p) & 0x0FFFFFFF;
//  850 	}
//  851 
//  852 	return 0xFFFFFFFF;	/* An error occurred at the disk I/O layer */
??get_fat_4:
        MOVS     R0,#-1
??get_fat_2:
        POP      {R1,R4-R7,PC}    ;; return
??get_fat_7:
        LSLS     R0,R7,#+23       ;; ZeroExtS R0,R7,#+23,#+23
        LSRS     R0,R0,#+23
        ADD      R0,R5,R0
        LDRB     R6,[R0, #+48]
        ADDS     R7,R7,#+1
        LDR      R1,[R5, #+32]
        ADDS     R1,R1,R7, LSR #+9
        MOVS     R0,R5
        BL       move_window
        CMP      R0,#+0
        BNE.N    ??get_fat_4
??get_fat_8:
        LSLS     R7,R7,#+23       ;; ZeroExtS R7,R7,#+23,#+23
        LSRS     R7,R7,#+23
        ADD      R0,R5,R7
        LDRB     R0,[R0, #+48]
        ORRS     R6,R6,R0, LSL #+8
        LSLS     R0,R4,#+31
        BPL.N    ??get_fat_9
        LSRS     R6,R6,#+4
        B.N      ??get_fat_10
??get_fat_9:
        LSLS     R6,R6,#+20       ;; ZeroExtS R6,R6,#+20,#+20
        LSRS     R6,R6,#+20
??get_fat_10:
        MOVS     R0,R6
        B.N      ??get_fat_2
??get_fat_6:
        LDR      R1,[R5, #+32]
        ADDS     R1,R1,R4, LSR #+8
        MOVS     R0,R5
        BL       move_window
        CMP      R0,#+0
        BNE.N    ??get_fat_4
??get_fat_11:
        LSLS     R0,R4,#+1
        LSLS     R0,R0,#+23       ;; ZeroExtS R0,R0,#+23,#+23
        LSRS     R0,R0,#+23
        ADD      R0,R5,R0
        ADDS     R1,R0,#+48
        LDRB     R2,[R1, #+1]
        LDRB     R0,[R1, #+0]
        ORRS     R0,R0,R2, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        B.N      ??get_fat_2
??get_fat_5:
        LDR      R1,[R5, #+32]
        ADDS     R1,R1,R4, LSR #+7
        MOVS     R0,R5
        BL       move_window
        CMP      R0,#+0
        BNE.N    ??get_fat_4
??get_fat_12:
        LSLS     R0,R4,#+2
        LSLS     R0,R0,#+23       ;; ZeroExtS R0,R0,#+23,#+23
        LSRS     R0,R0,#+23
        ADD      R0,R5,R0
        ADDS     R1,R0,#+48
        LDRB     R2,[R1, #+3]
        LDRB     R0,[R1, #+2]
        LSLS     R0,R0,#+16
        ORRS     R0,R0,R2, LSL #+24
        LDRB     R2,[R1, #+1]
        ORRS     R0,R0,R2, LSL #+8
        LDRB     R1,[R1, #+0]
        ORRS     R0,R1,R0
        BIC      R0,R0,#0xF0000000
        B.N      ??get_fat_2
//  853 }
//  854 
//  855 
//  856 
//  857 
//  858 /*-----------------------------------------------------------------------*/
//  859 /* FAT access - Change value of a FAT entry                              */
//  860 /*-----------------------------------------------------------------------*/
//  861 #if !_FS_READONLY
//  862 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  863 FRESULT put_fat (
//  864 	FATFS *fs,	/* File system object */
//  865 	DWORD clst,	/* Cluster# to be changed in range of 2 to fs->n_fatent - 1 */
//  866 	DWORD val	/* New value to mark the cluster */
//  867 )
//  868 {
put_fat:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  869 	UINT bc;
//  870 	BYTE *p;
//  871 	FRESULT res;
//  872 
//  873 
//  874 	if (clst < 2 || clst >= fs->n_fatent) {	/* Check range */
        CMP      R5,#+2
        BCC.N    ??put_fat_0
        LDR      R0,[R4, #+24]
        CMP      R5,R0
        BCC.N    ??put_fat_1
//  875 		res = FR_INT_ERR;
??put_fat_0:
        MOVS     R0,#+2
        B.N      ??put_fat_2
//  876 
//  877 	} else {
//  878 		switch (fs->fs_type) {
??put_fat_1:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+1
        BEQ.N    ??put_fat_3
        BCC.N    ??put_fat_4
        CMP      R0,#+3
        BEQ.N    ??put_fat_5
        BCC.N    ??put_fat_6
        B.N      ??put_fat_4
//  879 		case FS_FAT12 :
//  880 			bc = clst; bc += bc / 2;
??put_fat_3:
        MOVS     R7,R5
        ADDS     R7,R7,R7, LSR #+1
//  881 			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
        LDR      R1,[R4, #+32]
        ADDS     R1,R1,R7, LSR #+9
        MOVS     R0,R4
        BL       move_window
//  882 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  883 			p = &fs->win[bc % SS(fs)];
??put_fat_8:
        LSLS     R0,R7,#+23       ;; ZeroExtS R0,R7,#+23,#+23
        LSRS     R0,R0,#+23
        ADD      R0,R4,R0
        ADDS     R1,R0,#+48
//  884 			*p = (clst & 1) ? ((*p & 0x0F) | ((BYTE)val << 4)) : (BYTE)val;
        LSLS     R0,R5,#+31
        BPL.N    ??put_fat_9
        LDRB     R0,[R1, #+0]
        ANDS     R0,R0,#0xF
        ORRS     R0,R0,R6, LSL #+4
        B.N      ??put_fat_10
??put_fat_9:
        MOVS     R0,R6
??put_fat_10:
        STRB     R0,[R1, #+0]
//  885 			bc++;
        ADDS     R7,R7,#+1
//  886 			fs->wflag = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+4]
//  887 			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
        LDR      R1,[R4, #+32]
        ADDS     R1,R1,R7, LSR #+9
        MOVS     R0,R4
        BL       move_window
//  888 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  889 			p = &fs->win[bc % SS(fs)];
??put_fat_11:
        LSLS     R7,R7,#+23       ;; ZeroExtS R7,R7,#+23,#+23
        LSRS     R7,R7,#+23
        ADD      R1,R4,R7
        ADDS     R1,R1,#+48
//  890 			*p = (clst & 1) ? (BYTE)(val >> 4) : ((*p & 0xF0) | ((BYTE)(val >> 8) & 0x0F));
        LSLS     R2,R5,#+31
        BPL.N    ??put_fat_12
        LSRS     R6,R6,#+4
        B.N      ??put_fat_13
??put_fat_12:
        LDRB     R2,[R1, #+0]
        ANDS     R2,R2,#0xF0
        LSRS     R6,R6,#+8
        ANDS     R6,R6,#0xF
        ORRS     R6,R6,R2
??put_fat_13:
        STRB     R6,[R1, #+0]
//  891 			break;
        B.N      ??put_fat_7
//  892 
//  893 		case FS_FAT16 :
//  894 			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 2)));
??put_fat_6:
        LDR      R1,[R4, #+32]
        ADDS     R1,R1,R5, LSR #+8
        MOVS     R0,R4
        BL       move_window
//  895 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  896 			p = &fs->win[clst * 2 % SS(fs)];
??put_fat_14:
        LSLS     R1,R5,#+1
        LSLS     R1,R1,#+23       ;; ZeroExtS R1,R1,#+23,#+23
        LSRS     R1,R1,#+23
        ADD      R1,R4,R1
        ADDS     R1,R1,#+48
//  897 			ST_WORD(p, (WORD)val);
        STRB     R6,[R1, #+0]
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        LSRS     R6,R6,#+8
        STRB     R6,[R1, #+1]
//  898 			break;
        B.N      ??put_fat_7
//  899 
//  900 		case FS_FAT32 :
//  901 			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 4)));
??put_fat_5:
        LDR      R1,[R4, #+32]
        ADDS     R1,R1,R5, LSR #+7
        MOVS     R0,R4
        BL       move_window
//  902 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  903 			p = &fs->win[clst * 4 % SS(fs)];
??put_fat_15:
        LSLS     R1,R5,#+2
        LSLS     R1,R1,#+23       ;; ZeroExtS R1,R1,#+23,#+23
        LSRS     R1,R1,#+23
        ADD      R1,R4,R1
        ADDS     R1,R1,#+48
//  904 			val |= LD_DWORD(p) & 0xF0000000;
        LDRB     R2,[R1, #+3]
        LSLS     R2,R2,#+24
        ANDS     R2,R2,#0xF0000000
        ORRS     R6,R2,R6
//  905 			ST_DWORD(p, val);
        STRB     R6,[R1, #+0]
        MOVS     R2,R6
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LSRS     R2,R2,#+8
        STRB     R2,[R1, #+1]
        MOVS     R2,R6
        LSRS     R2,R2,#+16
        STRB     R2,[R1, #+2]
        LSRS     R6,R6,#+24
        STRB     R6,[R1, #+3]
//  906 			break;
        B.N      ??put_fat_7
//  907 
//  908 		default :
//  909 			res = FR_INT_ERR;
??put_fat_4:
        MOVS     R0,#+2
//  910 		}
//  911 		fs->wflag = 1;
??put_fat_7:
        MOVS     R1,#+1
        STRB     R1,[R4, #+4]
//  912 	}
//  913 
//  914 	return res;
??put_fat_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4-R7,PC}    ;; return
//  915 }
//  916 #endif /* !_FS_READONLY */
//  917 
//  918 
//  919 
//  920 
//  921 /*-----------------------------------------------------------------------*/
//  922 /* FAT handling - Remove a cluster chain                                 */
//  923 /*-----------------------------------------------------------------------*/
//  924 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  925 static
//  926 FRESULT remove_chain (
//  927 	FATFS *fs,			/* File system object */
//  928 	DWORD clst			/* Cluster# to remove a chain from */
//  929 )
//  930 {
remove_chain:
        PUSH     {R3-R7,LR}
        MOVS     R6,R0
        MOVS     R7,R1
//  931 	FRESULT res;
//  932 	DWORD nxt;
//  933 #if _USE_ERASE
//  934 	DWORD scl = clst, ecl = clst, resion[2];
//  935 #endif
//  936 
//  937 	if (clst < 2 || clst >= fs->n_fatent) {	/* Check range */
        CMP      R7,#+2
        BCC.N    ??remove_chain_0
        LDR      R0,[R6, #+24]
        CMP      R7,R0
        BCC.N    ??remove_chain_1
//  938 		res = FR_INT_ERR;
??remove_chain_0:
        MOVS     R5,#+2
        B.N      ??remove_chain_2
//  939 
//  940 	} else {
//  941 		res = FR_OK;
??remove_chain_1:
        MOVS     R5,#+0
        B.N      ??remove_chain_3
//  942 		while (clst < fs->n_fatent) {			/* Not a last link? */
//  943 			nxt = get_fat(fs, clst);			/* Get cluster status */
//  944 			if (nxt == 0) break;				/* Empty cluster? */
//  945 			if (nxt == 1) { res = FR_INT_ERR; break; }	/* Internal error? */
??remove_chain_4:
        CMP      R4,#+1
        BEQ.N    ??remove_chain_5
//  946 			if (nxt == 0xFFFFFFFF) { res = FR_DISK_ERR; break; }	/* Disk error? */
??remove_chain_6:
        CMN      R4,#+1
        BEQ.N    ??remove_chain_7
//  947 			res = put_fat(fs, clst, 0);			/* Mark the cluster "empty" */
??remove_chain_8:
        MOVS     R2,#+0
        MOVS     R1,R7
        MOVS     R0,R6
        BL       put_fat
        MOVS     R5,R0
//  948 			if (res != FR_OK) break;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??remove_chain_9
//  949 			if (fs->free_clust != 0xFFFFFFFF) {	/* Update FSInfo */
??remove_chain_10:
        LDR      R0,[R6, #+16]
        CMN      R0,#+1
        BEQ.N    ??remove_chain_11
//  950 				fs->free_clust++;
        LDR      R0,[R6, #+16]
        ADDS     R0,R0,#+1
        STR      R0,[R6, #+16]
//  951 				fs->fsi_flag = 1;
        MOVS     R0,#+1
        STRB     R0,[R6, #+5]
//  952 			}
//  953 #if _USE_ERASE
//  954 			if (ecl + 1 == nxt) {	/* Next cluster is contiguous */
//  955 				ecl = nxt;
//  956 			} else {				/* End of contiguous clusters */ 
//  957 				resion[0] = clust2sect(fs, scl);					/* Start sector */
//  958 				resion[1] = clust2sect(fs, ecl) + fs->csize - 1;	/* End sector */
//  959 				disk_ioctl(fs->drv, CTRL_ERASE_SECTOR, resion);		/* Erase the block */
//  960 				scl = ecl = nxt;
//  961 			}
//  962 #endif
//  963 			clst = nxt;	/* Next cluster */
??remove_chain_11:
        MOVS     R7,R4
??remove_chain_3:
        LDR      R0,[R6, #+24]
        CMP      R7,R0
        BCS.N    ??remove_chain_2
        MOVS     R1,R7
        MOVS     R0,R6
        BL       get_fat
        MOVS     R4,R0
        CMP      R4,#+0
        BNE.N    ??remove_chain_4
        B.N      ??remove_chain_2
??remove_chain_5:
        MOVS     R5,#+2
        B.N      ??remove_chain_2
??remove_chain_7:
        MOVS     R5,#+1
        B.N      ??remove_chain_2
//  964 		}
//  965 	}
//  966 
//  967 	return res;
??remove_chain_9:
??remove_chain_2:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4-R7,PC}    ;; return
//  968 }
//  969 #endif
//  970 
//  971 
//  972 
//  973 
//  974 /*-----------------------------------------------------------------------*/
//  975 /* FAT handling - Stretch or Create a cluster chain                      */
//  976 /*-----------------------------------------------------------------------*/
//  977 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  978 static
//  979 DWORD create_chain (	/* 0:No free cluster, 1:Internal error, 0xFFFFFFFF:Disk error, >=2:New cluster# */
//  980 	FATFS *fs,			/* File system object */
//  981 	DWORD clst			/* Cluster# to stretch. 0 means create a new chain. */
//  982 )
//  983 {
create_chain:
        PUSH     {R3-R7,LR}
        MOVS     R6,R0
        MOVS     R4,R1
//  984 	DWORD cs, ncl, scl;
//  985 	FRESULT res;
//  986 
//  987 
//  988 	if (clst == 0) {		/* Create a new chain */
        CMP      R4,#+0
        BNE.N    ??create_chain_0
//  989 		scl = fs->last_clust;			/* Get suggested start point */
        LDR      R5,[R6, #+12]
//  990 		if (!scl || scl >= fs->n_fatent) scl = 1;
        CMP      R5,#+0
        BEQ.N    ??create_chain_1
        LDR      R0,[R6, #+24]
        CMP      R5,R0
        BCC.N    ??create_chain_2
??create_chain_1:
        MOVS     R5,#+1
        B.N      ??create_chain_2
//  991 	}
//  992 	else {					/* Stretch the current chain */
//  993 		cs = get_fat(fs, clst);			/* Check the cluster status */
??create_chain_0:
        MOVS     R1,R4
        MOVS     R0,R6
        BL       get_fat
//  994 		if (cs < 2) return 1;			/* It is an invalid cluster */
        CMP      R0,#+2
        BCS.N    ??create_chain_3
        MOVS     R0,#+1
        B.N      ??create_chain_4
//  995 		if (cs < fs->n_fatent) return cs;	/* It is already followed by next cluster */
??create_chain_3:
        LDR      R1,[R6, #+24]
        CMP      R0,R1
        BCC.N    ??create_chain_4
//  996 		scl = clst;
??create_chain_5:
        MOVS     R5,R4
//  997 	}
//  998 
//  999 	ncl = scl;				/* Start cluster */
??create_chain_2:
        MOVS     R7,R5
// 1000 	for (;;) {
// 1001 		ncl++;							/* Next cluster */
??create_chain_6:
        ADDS     R7,R7,#+1
// 1002 		if (ncl >= fs->n_fatent) {		/* Wrap around */
        LDR      R0,[R6, #+24]
        CMP      R7,R0
        BCC.N    ??create_chain_7
// 1003 			ncl = 2;
        MOVS     R7,#+2
// 1004 			if (ncl > scl) return 0;	/* No free cluster */
        CMP      R5,R7
        BCC.N    ??create_chain_8
// 1005 		}
// 1006 		cs = get_fat(fs, ncl);			/* Get the cluster status */
??create_chain_7:
        MOVS     R1,R7
        MOVS     R0,R6
        BL       get_fat
// 1007 		if (cs == 0) break;				/* Found a free cluster */
        CMP      R0,#+0
        BEQ.N    ??create_chain_9
// 1008 		if (cs == 0xFFFFFFFF || cs == 1)/* An error occurred */
??create_chain_10:
        CMN      R0,#+1
        BEQ.N    ??create_chain_11
        CMP      R0,#+1
        BEQ.N    ??create_chain_11
// 1009 			return cs;
// 1010 		if (ncl == scl) return 0;		/* No free cluster */
??create_chain_12:
        CMP      R7,R5
        BNE.N    ??create_chain_6
        MOVS     R0,#+0
        B.N      ??create_chain_4
??create_chain_8:
        MOVS     R0,#+0
        B.N      ??create_chain_4
// 1011 	}
// 1012 
// 1013 	res = put_fat(fs, ncl, 0x0FFFFFFF);	/* Mark the new cluster "last link" */
??create_chain_9:
        MVNS     R2,#-268435456
        MOVS     R1,R7
        MOVS     R0,R6
        BL       put_fat
// 1014 	if (res == FR_OK && clst != 0) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??create_chain_13
        CMP      R4,#+0
        BEQ.N    ??create_chain_13
// 1015 		res = put_fat(fs, clst, ncl);	/* Link it to the previous one if needed */
        MOVS     R2,R7
        MOVS     R1,R4
        MOVS     R0,R6
        BL       put_fat
// 1016 	}
// 1017 	if (res == FR_OK) {
??create_chain_13:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??create_chain_14
// 1018 		fs->last_clust = ncl;			/* Update FSINFO */
        STR      R7,[R6, #+12]
// 1019 		if (fs->free_clust != 0xFFFFFFFF) {
        LDR      R0,[R6, #+16]
        CMN      R0,#+1
        BEQ.N    ??create_chain_15
// 1020 			fs->free_clust--;
        LDR      R0,[R6, #+16]
        SUBS     R0,R0,#+1
        STR      R0,[R6, #+16]
// 1021 			fs->fsi_flag = 1;
        MOVS     R0,#+1
        STRB     R0,[R6, #+5]
        B.N      ??create_chain_15
// 1022 		}
// 1023 	} else {
??create_chain_11:
        B.N      ??create_chain_4
// 1024 		ncl = (res == FR_DISK_ERR) ? 0xFFFFFFFF : 1;
??create_chain_14:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BNE.N    ??create_chain_16
        MOVS     R7,#-1
        B.N      ??create_chain_15
??create_chain_16:
        MOVS     R7,#+1
// 1025 	}
// 1026 
// 1027 	return ncl;		/* Return new cluster number or error code */
??create_chain_15:
        MOVS     R0,R7
??create_chain_4:
        POP      {R1,R4-R7,PC}    ;; return
// 1028 }
// 1029 #endif /* !_FS_READONLY */
// 1030 
// 1031 
// 1032 
// 1033 /*-----------------------------------------------------------------------*/
// 1034 /* FAT handling - Convert offset into cluster with link map table        */
// 1035 /*-----------------------------------------------------------------------*/
// 1036 
// 1037 #if _USE_FASTSEEK
// 1038 static
// 1039 DWORD clmt_clust (	/* <2:Error, >=2:Cluster number */
// 1040 	FIL* fp,		/* Pointer to the file object */
// 1041 	DWORD ofs		/* File offset to be converted to cluster# */
// 1042 )
// 1043 {
// 1044 	DWORD cl, ncl, *tbl;
// 1045 
// 1046 
// 1047 	tbl = fp->cltbl + 1;	/* Top of CLMT */
// 1048 	cl = ofs / SS(fp->fs) / fp->fs->csize;	/* Cluster order from top of the file */
// 1049 	for (;;) {
// 1050 		ncl = *tbl++;			/* Number of cluters in the fragment */
// 1051 		if (!ncl) return 0;		/* End of table? (error) */
// 1052 		if (cl < ncl) break;	/* In this fragment? */
// 1053 		cl -= ncl; tbl++;		/* Next fragment */
// 1054 	}
// 1055 	return cl + *tbl;	/* Return the cluster number */
// 1056 }
// 1057 #endif	/* _USE_FASTSEEK */
// 1058 
// 1059 
// 1060 
// 1061 /*-----------------------------------------------------------------------*/
// 1062 /* Directory handling - Set directory index                              */
// 1063 /*-----------------------------------------------------------------------*/
// 1064 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1065 static
// 1066 FRESULT dir_sdi (
// 1067 	DIR *dj,		/* Pointer to directory object */
// 1068 	WORD idx		/* Directory index number */
// 1069 )
// 1070 {
dir_sdi:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 1071 	DWORD clst;
// 1072 	WORD ic;
// 1073 
// 1074 
// 1075 	dj->index = idx;
        STRH     R5,[R4, #+6]
// 1076 	clst = dj->sclust;
        LDR      R1,[R4, #+8]
// 1077 	if (clst == 1 || clst >= dj->fs->n_fatent)	/* Check start cluster range */
        CMP      R1,#+1
        BEQ.N    ??dir_sdi_0
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+24]
        CMP      R1,R0
        BCC.N    ??dir_sdi_1
// 1078 		return FR_INT_ERR;
??dir_sdi_0:
        MOVS     R0,#+2
        B.N      ??dir_sdi_2
// 1079 	if (!clst && dj->fs->fs_type == FS_FAT32)	/* Replace cluster# 0 with root cluster# if in FAT32 */
??dir_sdi_1:
        CMP      R1,#+0
        BNE.N    ??dir_sdi_3
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??dir_sdi_3
// 1080 		clst = dj->fs->dirbase;
        LDR      R0,[R4, #+0]
        LDR      R1,[R0, #+36]
// 1081 
// 1082 	if (clst == 0) {	/* Static table (root-dir in FAT12/16) */
??dir_sdi_3:
        CMP      R1,#+0
        BNE.N    ??dir_sdi_4
// 1083 		dj->clust = clst;
        STR      R1,[R4, #+12]
// 1084 		if (idx >= dj->fs->n_rootdir)		/* Index is out of range */
        MOVS     R0,R5
        LDR      R1,[R4, #+0]
        LDRH     R1,[R1, #+8]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,R1
        BCC.N    ??dir_sdi_5
// 1085 			return FR_INT_ERR;
        MOVS     R0,#+2
        B.N      ??dir_sdi_2
// 1086 		dj->sect = dj->fs->dirbase + idx / (SS(dj->fs) / SZ_DIR);	/* Sector# */
??dir_sdi_5:
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+36]
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R0,R5, LSR #+4
        STR      R0,[R4, #+16]
        B.N      ??dir_sdi_6
// 1087 	}
// 1088 	else {				/* Dynamic table (sub-dirs or root-dir in FAT32) */
// 1089 		ic = SS(dj->fs) / SZ_DIR * dj->fs->csize;	/* Entries per cluster */
??dir_sdi_4:
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+2]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSLS     R6,R0,#+4
        B.N      ??dir_sdi_7
// 1090 		while (idx >= ic) {	/* Follow cluster chain */
// 1091 			clst = get_fat(dj->fs, clst);				/* Get next cluster */
// 1092 			if (clst == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error */
// 1093 			if (clst < 2 || clst >= dj->fs->n_fatent)	/* Reached to end of table or int error */
??dir_sdi_8:
        CMP      R1,#+2
        BCC.N    ??dir_sdi_9
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+24]
        CMP      R1,R0
        BCS.N    ??dir_sdi_9
// 1094 				return FR_INT_ERR;
// 1095 			idx -= ic;
??dir_sdi_10:
        SUBS     R5,R5,R6
??dir_sdi_7:
        MOVS     R0,R5
        MOVS     R2,R6
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        CMP      R0,R2
        BCC.N    ??dir_sdi_11
        LDR      R0,[R4, #+0]
        BL       get_fat
        MOVS     R1,R0
        CMN      R1,#+1
        BNE.N    ??dir_sdi_8
        MOVS     R0,#+1
        B.N      ??dir_sdi_2
??dir_sdi_9:
        MOVS     R0,#+2
        B.N      ??dir_sdi_2
// 1096 		}
// 1097 		dj->clust = clst;
??dir_sdi_11:
        STR      R1,[R4, #+12]
// 1098 		dj->sect = clust2sect(dj->fs, clst) + idx / (SS(dj->fs) / SZ_DIR);	/* Sector# */
        LDR      R0,[R4, #+0]
        BL       clust2sect
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R0,R5, LSR #+4
        STR      R0,[R4, #+16]
// 1099 	}
// 1100 
// 1101 	dj->dir = dj->fs->win + (idx % (SS(dj->fs) / SZ_DIR)) * SZ_DIR;	/* Ptr to the entry in the sector */
??dir_sdi_6:
        LDR      R0,[R4, #+0]
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ANDS     R5,R5,#0xF
        LSLS     R1,R5,#+5
        ADD      R0,R0,R1
        ADDS     R0,R0,#+48
        STR      R0,[R4, #+20]
// 1102 
// 1103 	return FR_OK;	/* Seek succeeded */
        MOVS     R0,#+0
??dir_sdi_2:
        POP      {R4-R6,PC}       ;; return
// 1104 }
// 1105 
// 1106 
// 1107 
// 1108 
// 1109 /*-----------------------------------------------------------------------*/
// 1110 /* Directory handling - Move directory index next                        */
// 1111 /*-----------------------------------------------------------------------*/
// 1112 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1113 static
// 1114 FRESULT dir_next (	/* FR_OK:Succeeded, FR_NO_FILE:End of table, FR_DENIED:EOT and could not stretch */
// 1115 	DIR *dj,		/* Pointer to directory object */
// 1116 	int stretch		/* 0: Do not stretch table, 1: Stretch table if needed */
// 1117 )
// 1118 {
dir_next:
        PUSH     {R3-R7,LR}
        MOVS     R7,R0
        MOVS     R5,R1
// 1119 	DWORD clst;
// 1120 	WORD i;
// 1121 
// 1122 
// 1123 	i = dj->index + 1;
        LDRH     R4,[R7, #+6]
        ADDS     R4,R4,#+1
// 1124 	if (!i || !dj->sect)	/* Report EOT when index has reached 65535 */
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+0
        BEQ.N    ??dir_next_0
        LDR      R0,[R7, #+16]
        CMP      R0,#+0
        BNE.N    ??dir_next_1
// 1125 		return FR_NO_FILE;
??dir_next_0:
        MOVS     R0,#+4
        B.N      ??dir_next_2
// 1126 
// 1127 	if (!(i % (SS(dj->fs) / SZ_DIR))) {	/* Sector changed? */
??dir_next_1:
        MOVS     R0,R4
        TST      R0,#0xF
        BNE.N    ??dir_next_3
// 1128 		dj->sect++;					/* Next sector */
        LDR      R0,[R7, #+16]
        ADDS     R0,R0,#+1
        STR      R0,[R7, #+16]
// 1129 
// 1130 		if (dj->clust == 0) {	/* Static table */
        LDR      R0,[R7, #+12]
        CMP      R0,#+0
        BNE.N    ??dir_next_4
// 1131 			if (i >= dj->fs->n_rootdir)	/* Report EOT when end of table */
        MOVS     R0,R4
        LDR      R1,[R7, #+0]
        LDRH     R1,[R1, #+8]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,R1
        BCC.N    ??dir_next_3
// 1132 				return FR_NO_FILE;
        MOVS     R0,#+4
        B.N      ??dir_next_2
// 1133 		}
// 1134 		else {					/* Dynamic table */
// 1135 			if (((i / (SS(dj->fs) / SZ_DIR)) & (dj->fs->csize - 1)) == 0) {	/* Cluster changed? */
??dir_next_4:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        LDR      R0,[R7, #+0]
        LDRB     R0,[R0, #+2]
        SUBS     R0,R0,#+1
        TST      R0,R4, LSR #+4
        BNE.N    ??dir_next_3
// 1136 				clst = get_fat(dj->fs, dj->clust);				/* Get next cluster */
        LDR      R1,[R7, #+12]
        LDR      R0,[R7, #+0]
        BL       get_fat
        MOVS     R6,R0
// 1137 				if (clst <= 1) return FR_INT_ERR;
        CMP      R6,#+2
        BCS.N    ??dir_next_5
        MOVS     R0,#+2
        B.N      ??dir_next_2
// 1138 				if (clst == 0xFFFFFFFF) return FR_DISK_ERR;
??dir_next_5:
        CMN      R6,#+1
        BNE.N    ??dir_next_6
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1139 				if (clst >= dj->fs->n_fatent) {					/* When it reached end of dynamic table */
??dir_next_6:
        LDR      R0,[R7, #+0]
        LDR      R0,[R0, #+24]
        CMP      R6,R0
        BCC.N    ??dir_next_7
// 1140 #if !_FS_READONLY
// 1141 					BYTE c;
// 1142 					if (!stretch) return FR_NO_FILE;			/* When do not stretch, report EOT */
        CMP      R5,#+0
        BNE.N    ??dir_next_8
        MOVS     R0,#+4
        B.N      ??dir_next_2
// 1143 					clst = create_chain(dj->fs, dj->clust);		/* Stretch cluster chain */
??dir_next_8:
        LDR      R1,[R7, #+12]
        LDR      R0,[R7, #+0]
        BL       create_chain
        MOVS     R6,R0
// 1144 					if (clst == 0) return FR_DENIED;			/* No free cluster */
        CMP      R6,#+0
        BNE.N    ??dir_next_9
        MOVS     R0,#+7
        B.N      ??dir_next_2
// 1145 					if (clst == 1) return FR_INT_ERR;
??dir_next_9:
        CMP      R6,#+1
        BNE.N    ??dir_next_10
        MOVS     R0,#+2
        B.N      ??dir_next_2
// 1146 					if (clst == 0xFFFFFFFF) return FR_DISK_ERR;
??dir_next_10:
        CMN      R6,#+1
        BNE.N    ??dir_next_11
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1147 					/* Clean-up stretched table */
// 1148 					if (move_window(dj->fs, 0)) return FR_DISK_ERR;	/* Flush active window */
??dir_next_11:
        MOVS     R1,#+0
        LDR      R0,[R7, #+0]
        BL       move_window
        CMP      R0,#+0
        BEQ.N    ??dir_next_12
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1149 					mem_set(dj->fs->win, 0, SS(dj->fs));			/* Clear window buffer */
??dir_next_12:
        MOV      R2,#+512
        MOVS     R1,#+0
        LDR      R0,[R7, #+0]
        ADDS     R0,R0,#+48
        BL       mem_set
// 1150 					dj->fs->winsect = clust2sect(dj->fs, clst);	/* Cluster start sector */
        MOVS     R1,R6
        LDR      R0,[R7, #+0]
        BL       clust2sect
        LDR      R1,[R7, #+0]
        STR      R0,[R1, #+44]
// 1151 					for (c = 0; c < dj->fs->csize; c++) {		/* Fill the new cluster with 0 */
        MOVS     R5,#+0
        B.N      ??dir_next_13
// 1152 						dj->fs->wflag = 1;
// 1153 						if (move_window(dj->fs, 0)) return FR_DISK_ERR;
// 1154 						dj->fs->winsect++;
??dir_next_14:
        LDR      R0,[R7, #+0]
        LDR      R0,[R0, #+44]
        ADDS     R0,R0,#+1
        LDR      R1,[R7, #+0]
        STR      R0,[R1, #+44]
        ADDS     R5,R5,#+1
??dir_next_13:
        MOVS     R0,R5
        LDR      R1,[R7, #+0]
        LDRB     R1,[R1, #+2]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,R1
        BCS.N    ??dir_next_15
        MOVS     R0,#+1
        LDR      R1,[R7, #+0]
        STRB     R0,[R1, #+4]
        MOVS     R1,#+0
        LDR      R0,[R7, #+0]
        BL       move_window
        CMP      R0,#+0
        BEQ.N    ??dir_next_14
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1155 					}
// 1156 					dj->fs->winsect -= c;						/* Rewind window address */
??dir_next_15:
        LDR      R0,[R7, #+0]
        LDR      R0,[R0, #+44]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        SUBS     R5,R0,R5
        LDR      R0,[R7, #+0]
        STR      R5,[R0, #+44]
// 1157 #else
// 1158 					return FR_NO_FILE;			/* Report EOT */
// 1159 #endif
// 1160 				}
// 1161 				dj->clust = clst;				/* Initialize data for new cluster */
??dir_next_7:
        STR      R6,[R7, #+12]
// 1162 				dj->sect = clust2sect(dj->fs, clst);
        MOVS     R1,R6
        LDR      R0,[R7, #+0]
        BL       clust2sect
        STR      R0,[R7, #+16]
// 1163 			}
// 1164 		}
// 1165 	}
// 1166 
// 1167 	dj->index = i;
??dir_next_3:
        STRH     R4,[R7, #+6]
// 1168 	dj->dir = dj->fs->win + (i % (SS(dj->fs) / SZ_DIR)) * SZ_DIR;
        LDR      R0,[R7, #+0]
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ANDS     R4,R4,#0xF
        LSLS     R1,R4,#+5
        ADD      R0,R0,R1
        ADDS     R0,R0,#+48
        STR      R0,[R7, #+20]
// 1169 
// 1170 	return FR_OK;
        MOVS     R0,#+0
??dir_next_2:
        POP      {R1,R4-R7,PC}    ;; return
// 1171 }
// 1172 
// 1173 
// 1174 
// 1175 
// 1176 /*-----------------------------------------------------------------------*/
// 1177 /* LFN handling - Test/Pick/Fit an LFN segment from/to directory entry   */
// 1178 /*-----------------------------------------------------------------------*/
// 1179 #if _USE_LFN
// 1180 static
// 1181 const BYTE LfnOfs[] = {1,3,5,7,9,14,16,18,20,22,24,28,30};	/* Offset of LFN chars in the directory entry */
// 1182 
// 1183 
// 1184 static
// 1185 int cmp_lfn (			/* 1:Matched, 0:Not matched */
// 1186 	WCHAR *lfnbuf,		/* Pointer to the LFN to be compared */
// 1187 	BYTE *dir			/* Pointer to the directory entry containing a part of LFN */
// 1188 )
// 1189 {
// 1190 	UINT i, s;
// 1191 	WCHAR wc, uc;
// 1192 
// 1193 
// 1194 	i = ((dir[LDIR_Ord] & ~LLE) - 1) * 13;	/* Get offset in the LFN buffer */
// 1195 	s = 0; wc = 1;
// 1196 	do {
// 1197 		uc = LD_WORD(dir+LfnOfs[s]);	/* Pick an LFN character from the entry */
// 1198 		if (wc) {	/* Last char has not been processed */
// 1199 			wc = ff_wtoupper(uc);		/* Convert it to upper case */
// 1200 			if (i >= _MAX_LFN || wc != ff_wtoupper(lfnbuf[i++]))	/* Compare it */
// 1201 				return 0;				/* Not matched */
// 1202 		} else {
// 1203 			if (uc != 0xFFFF) return 0;	/* Check filler */
// 1204 		}
// 1205 	} while (++s < 13);				/* Repeat until all chars in the entry are checked */
// 1206 
// 1207 	if ((dir[LDIR_Ord] & LLE) && wc && lfnbuf[i])	/* Last segment matched but different length */
// 1208 		return 0;
// 1209 
// 1210 	return 1;						/* The part of LFN matched */
// 1211 }
// 1212 
// 1213 
// 1214 
// 1215 static
// 1216 int pick_lfn (			/* 1:Succeeded, 0:Buffer overflow */
// 1217 	WCHAR *lfnbuf,		/* Pointer to the Unicode-LFN buffer */
// 1218 	BYTE *dir			/* Pointer to the directory entry */
// 1219 )
// 1220 {
// 1221 	UINT i, s;
// 1222 	WCHAR wc, uc;
// 1223 
// 1224 
// 1225 	i = ((dir[LDIR_Ord] & 0x3F) - 1) * 13;	/* Offset in the LFN buffer */
// 1226 
// 1227 	s = 0; wc = 1;
// 1228 	do {
// 1229 		uc = LD_WORD(dir+LfnOfs[s]);		/* Pick an LFN character from the entry */
// 1230 		if (wc) {	/* Last char has not been processed */
// 1231 			if (i >= _MAX_LFN) return 0;	/* Buffer overflow? */
// 1232 			lfnbuf[i++] = wc = uc;			/* Store it */
// 1233 		} else {
// 1234 			if (uc != 0xFFFF) return 0;		/* Check filler */
// 1235 		}
// 1236 	} while (++s < 13);						/* Read all character in the entry */
// 1237 
// 1238 	if (dir[LDIR_Ord] & LLE) {				/* Put terminator if it is the last LFN part */
// 1239 		if (i >= _MAX_LFN) return 0;		/* Buffer overflow? */
// 1240 		lfnbuf[i] = 0;
// 1241 	}
// 1242 
// 1243 	return 1;
// 1244 }
// 1245 
// 1246 
// 1247 #if !_FS_READONLY
// 1248 static
// 1249 void fit_lfn (
// 1250 	const WCHAR *lfnbuf,	/* Pointer to the LFN buffer */
// 1251 	BYTE *dir,				/* Pointer to the directory entry */
// 1252 	BYTE ord,				/* LFN order (1-20) */
// 1253 	BYTE sum				/* SFN sum */
// 1254 )
// 1255 {
// 1256 	UINT i, s;
// 1257 	WCHAR wc;
// 1258 
// 1259 
// 1260 	dir[LDIR_Chksum] = sum;			/* Set check sum */
// 1261 	dir[LDIR_Attr] = AM_LFN;		/* Set attribute. LFN entry */
// 1262 	dir[LDIR_Type] = 0;
// 1263 	ST_WORD(dir+LDIR_FstClusLO, 0);
// 1264 
// 1265 	i = (ord - 1) * 13;				/* Get offset in the LFN buffer */
// 1266 	s = wc = 0;
// 1267 	do {
// 1268 		if (wc != 0xFFFF) wc = lfnbuf[i++];	/* Get an effective char */
// 1269 		ST_WORD(dir+LfnOfs[s], wc);	/* Put it */
// 1270 		if (!wc) wc = 0xFFFF;		/* Padding chars following last char */
// 1271 	} while (++s < 13);
// 1272 	if (wc == 0xFFFF || !lfnbuf[i]) ord |= LLE;	/* Bottom LFN part is the start of LFN sequence */
// 1273 	dir[LDIR_Ord] = ord;			/* Set the LFN order */
// 1274 }
// 1275 
// 1276 #endif
// 1277 #endif
// 1278 
// 1279 
// 1280 
// 1281 /*-----------------------------------------------------------------------*/
// 1282 /* Create numbered name                                                  */
// 1283 /*-----------------------------------------------------------------------*/
// 1284 #if _USE_LFN
// 1285 void gen_numname (
// 1286 	BYTE *dst,			/* Pointer to generated SFN */
// 1287 	const BYTE *src,	/* Pointer to source SFN to be modified */
// 1288 	const WCHAR *lfn,	/* Pointer to LFN */
// 1289 	WORD seq			/* Sequence number */
// 1290 )
// 1291 {
// 1292 	BYTE ns[8], c;
// 1293 	UINT i, j;
// 1294 
// 1295 
// 1296 	mem_cpy(dst, src, 11);
// 1297 
// 1298 	if (seq > 5) {	/* On many collisions, generate a hash number instead of sequential number */
// 1299 		do seq = (seq >> 1) + (seq << 15) + (WORD)*lfn++; while (*lfn);
// 1300 	}
// 1301 
// 1302 	/* itoa (hexdecimal) */
// 1303 	i = 7;
// 1304 	do {
// 1305 		c = (seq % 16) + '0';
// 1306 		if (c > '9') c += 7;
// 1307 		ns[i--] = c;
// 1308 		seq /= 16;
// 1309 	} while (seq);
// 1310 	ns[i] = '~';
// 1311 
// 1312 	/* Append the number */
// 1313 	for (j = 0; j < i && dst[j] != ' '; j++) {
// 1314 		if (IsDBCS1(dst[j])) {
// 1315 			if (j == i - 1) break;
// 1316 			j++;
// 1317 		}
// 1318 	}
// 1319 	do {
// 1320 		dst[j++] = (i < 8) ? ns[i++] : ' ';
// 1321 	} while (j < 8);
// 1322 }
// 1323 #endif
// 1324 
// 1325 
// 1326 
// 1327 
// 1328 /*-----------------------------------------------------------------------*/
// 1329 /* Calculate sum of an SFN                                               */
// 1330 /*-----------------------------------------------------------------------*/
// 1331 #if _USE_LFN
// 1332 static
// 1333 BYTE sum_sfn (
// 1334 	const BYTE *dir		/* Ptr to directory entry */
// 1335 )
// 1336 {
// 1337 	BYTE sum = 0;
// 1338 	UINT n = 11;
// 1339 
// 1340 	do sum = (sum >> 1) + (sum << 7) + *dir++; while (--n);
// 1341 	return sum;
// 1342 }
// 1343 #endif
// 1344 
// 1345 
// 1346 
// 1347 
// 1348 /*-----------------------------------------------------------------------*/
// 1349 /* Directory handling - Find an object in the directory                  */
// 1350 /*-----------------------------------------------------------------------*/
// 1351 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1352 static
// 1353 FRESULT dir_find (
// 1354 	DIR *dj			/* Pointer to the directory object linked to the file name */
// 1355 )
// 1356 {
dir_find:
        PUSH     {R3-R5,LR}
        MOVS     R5,R0
// 1357 	FRESULT res;
// 1358 	BYTE c, *dir;
// 1359 #if _USE_LFN
// 1360 	BYTE a, ord, sum;
// 1361 #endif
// 1362 
// 1363 	res = dir_sdi(dj, 0);			/* Rewind directory object */
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       dir_sdi
        MOVS     R4,R0
// 1364 	if (res != FR_OK) return res;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??dir_find_0
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??dir_find_1
// 1365 
// 1366 #if _USE_LFN
// 1367 	ord = sum = 0xFF;
// 1368 #endif
// 1369 	do {
// 1370 		res = move_window(dj->fs, dj->sect);
// 1371 		if (res != FR_OK) break;
// 1372 		dir = dj->dir;					/* Ptr to the directory entry of current index */
??dir_find_2:
        LDR      R3,[R5, #+20]
// 1373 		c = dir[DIR_Name];
        LDRB     R0,[R3, #+0]
// 1374 		if (c == 0) { res = FR_NO_FILE; break; }	/* Reached to end of table */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??dir_find_3
// 1375 #if _USE_LFN	/* LFN configuration */
// 1376 		a = dir[DIR_Attr] & AM_MASK;
// 1377 		if (c == DDE || ((a & AM_VOL) && a != AM_LFN)) {	/* An entry without valid data */
// 1378 			ord = 0xFF;
// 1379 		} else {
// 1380 			if (a == AM_LFN) {			/* An LFN entry is found */
// 1381 				if (dj->lfn) {
// 1382 					if (c & LLE) {		/* Is it start of LFN sequence? */
// 1383 						sum = dir[LDIR_Chksum];
// 1384 						c &= ~LLE; ord = c;	/* LFN start order */
// 1385 						dj->lfn_idx = dj->index;
// 1386 					}
// 1387 					/* Check validity of the LFN entry and compare it with given name */
// 1388 					ord = (c == ord && sum == dir[LDIR_Chksum] && cmp_lfn(dj->lfn, dir)) ? ord - 1 : 0xFF;
// 1389 				}
// 1390 			} else {					/* An SFN entry is found */
// 1391 				if (!ord && sum == sum_sfn(dir)) break;	/* LFN matched? */
// 1392 				ord = 0xFF; dj->lfn_idx = 0xFFFF;	/* Reset LFN sequence */
// 1393 				if (!(dj->fn[NS] & NS_LOSS) && !mem_cmp(dir, dj->fn, 11)) break;	/* SFN matched? */
// 1394 			}
// 1395 		}
// 1396 #else		/* Non LFN configuration */
// 1397 		if (!(dir[DIR_Attr] & AM_VOL) && !mem_cmp(dir, dj->fn, 11)) /* Is it a valid entry? */
??dir_find_4:
        LDRB     R0,[R3, #+11]
        LSLS     R0,R0,#+28
        BMI.N    ??dir_find_5
        MOVS     R2,#+11
        LDR      R1,[R5, #+24]
        MOVS     R0,R3
        BL       mem_cmp
        CMP      R0,#+0
        BEQ.N    ??dir_find_6
// 1398 			break;
// 1399 #endif
// 1400 		res = dir_next(dj, 0);		/* Next entry */
??dir_find_5:
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       dir_next
        MOVS     R4,R0
// 1401 	} while (res == FR_OK);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??dir_find_7
??dir_find_0:
        LDR      R1,[R5, #+16]
        LDR      R0,[R5, #+0]
        BL       move_window
        MOVS     R4,R0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??dir_find_2
        B.N      ??dir_find_7
??dir_find_3:
        MOVS     R4,#+4
        B.N      ??dir_find_7
// 1402 
// 1403 	return res;
??dir_find_6:
??dir_find_7:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??dir_find_1:
        POP      {R1,R4,R5,PC}    ;; return
// 1404 }
// 1405 
// 1406 
// 1407 
// 1408 
// 1409 /*-----------------------------------------------------------------------*/
// 1410 /* Read an object from the directory                                     */
// 1411 /*-----------------------------------------------------------------------*/
// 1412 #if _FS_MINIMIZE <= 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1413 static
// 1414 FRESULT dir_read (
// 1415 	DIR *dj			/* Pointer to the directory object that pointing the entry to be read */
// 1416 )
// 1417 {
dir_read:
        PUSH     {R4,LR}
        MOVS     R4,R0
// 1418 	FRESULT res;
// 1419 	BYTE c, *dir;
// 1420 #if _USE_LFN
// 1421 	BYTE a, ord = 0xFF, sum = 0xFF;
// 1422 #endif
// 1423 
// 1424 	res = FR_NO_FILE;
        MOVS     R0,#+4
// 1425 	while (dj->sect) {
??dir_read_0:
        LDR      R1,[R4, #+16]
        CMP      R1,#+0
        BEQ.N    ??dir_read_1
// 1426 		res = move_window(dj->fs, dj->sect);
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
// 1427 		if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_read_2
// 1428 		dir = dj->dir;					/* Ptr to the directory entry of current index */
??dir_read_3:
        LDR      R2,[R4, #+20]
// 1429 		c = dir[DIR_Name];
        LDRB     R1,[R2, #+0]
// 1430 		if (c == 0) { res = FR_NO_FILE; break; }	/* Reached to end of table */
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BEQ.N    ??dir_read_4
// 1431 #if _USE_LFN	/* LFN configuration */
// 1432 		a = dir[DIR_Attr] & AM_MASK;
// 1433 		if (c == DDE || (!_FS_RPATH && c == '.') || ((a & AM_VOL) && a != AM_LFN)) {	/* An entry without valid data */
// 1434 			ord = 0xFF;
// 1435 		} else {
// 1436 			if (a == AM_LFN) {			/* An LFN entry is found */
// 1437 				if (c & LLE) {			/* Is it start of LFN sequence? */
// 1438 					sum = dir[LDIR_Chksum];
// 1439 					c &= ~LLE; ord = c;
// 1440 					dj->lfn_idx = dj->index;
// 1441 				}
// 1442 				/* Check LFN validity and capture it */
// 1443 				ord = (c == ord && sum == dir[LDIR_Chksum] && pick_lfn(dj->lfn, dir)) ? ord - 1 : 0xFF;
// 1444 			} else {					/* An SFN entry is found */
// 1445 				if (ord || sum != sum_sfn(dir))	/* Is there a valid LFN? */
// 1446 					dj->lfn_idx = 0xFFFF;		/* It has no LFN. */
// 1447 				break;
// 1448 			}
// 1449 		}
// 1450 #else		/* Non LFN configuration */
// 1451 		if (c != DDE && (_FS_RPATH || c != '.') && !(dir[DIR_Attr] & AM_VOL))	/* Is it a valid entry? */
??dir_read_5:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+229
        BEQ.N    ??dir_read_6
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+46
        BEQ.N    ??dir_read_6
        LDRB     R1,[R2, #+11]
        LSLS     R1,R1,#+28
        BPL.N    ??dir_read_7
// 1452 			break;
// 1453 #endif
// 1454 		res = dir_next(dj, 0);				/* Next entry */
??dir_read_6:
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_next
// 1455 		if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??dir_read_0
// 1456 	}
// 1457 
// 1458 	if (res != FR_OK) dj->sect = 0;
??dir_read_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??dir_read_8
        MOVS     R1,#+0
        STR      R1,[R4, #+16]
// 1459 
// 1460 	return res;
??dir_read_8:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4,PC}          ;; return
??dir_read_2:
        B.N      ??dir_read_1
??dir_read_4:
        MOVS     R0,#+4
        B.N      ??dir_read_1
??dir_read_7:
        B.N      ??dir_read_1
// 1461 }
// 1462 #endif
// 1463 
// 1464 
// 1465 
// 1466 /*-----------------------------------------------------------------------*/
// 1467 /* Register an object to the directory                                   */
// 1468 /*-----------------------------------------------------------------------*/
// 1469 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1470 static
// 1471 FRESULT dir_register (	/* FR_OK:Successful, FR_DENIED:No free entry or too many SFN collision, FR_DISK_ERR:Disk error */
// 1472 	DIR *dj				/* Target directory with object name to be created */
// 1473 )
// 1474 {
dir_register:
        PUSH     {R4-R6,LR}
        MOVS     R5,R0
// 1475 	FRESULT res;
// 1476 	BYTE c, *dir;
// 1477 #if _USE_LFN	/* LFN configuration */
// 1478 	WORD n, ne, is;
// 1479 	BYTE sn[12], *fn, sum;
// 1480 	WCHAR *lfn;
// 1481 
// 1482 
// 1483 	fn = dj->fn; lfn = dj->lfn;
// 1484 	mem_cpy(sn, fn, 12);
// 1485 
// 1486 	if (_FS_RPATH && (sn[NS] & NS_DOT))		/* Cannot create dot entry */
// 1487 		return FR_INVALID_NAME;
// 1488 
// 1489 	if (sn[NS] & NS_LOSS) {			/* When LFN is out of 8.3 format, generate a numbered name */
// 1490 		fn[NS] = 0; dj->lfn = 0;			/* Find only SFN */
// 1491 		for (n = 1; n < 100; n++) {
// 1492 			gen_numname(fn, sn, lfn, n);	/* Generate a numbered name */
// 1493 			res = dir_find(dj);				/* Check if the name collides with existing SFN */
// 1494 			if (res != FR_OK) break;
// 1495 		}
// 1496 		if (n == 100) return FR_DENIED;		/* Abort if too many collisions */
// 1497 		if (res != FR_NO_FILE) return res;	/* Abort if the result is other than 'not collided' */
// 1498 		fn[NS] = sn[NS]; dj->lfn = lfn;
// 1499 	}
// 1500 
// 1501 	if (sn[NS] & NS_LFN) {			/* When LFN is to be created, reserve an SFN + LFN entries. */
// 1502 		for (ne = 0; lfn[ne]; ne++) ;
// 1503 		ne = (ne + 25) / 13;
// 1504 	} else {						/* Otherwise reserve only an SFN entry. */
// 1505 		ne = 1;
// 1506 	}
// 1507 
// 1508 	/* Reserve contiguous entries */
// 1509 	res = dir_sdi(dj, 0);
// 1510 	if (res != FR_OK) return res;
// 1511 	n = is = 0;
// 1512 	do {
// 1513 		res = move_window(dj->fs, dj->sect);
// 1514 		if (res != FR_OK) break;
// 1515 		c = *dj->dir;				/* Check the entry status */
// 1516 		if (c == DDE || c == 0) {	/* Is it a blank entry? */
// 1517 			if (n == 0) is = dj->index;	/* First index of the contiguous entry */
// 1518 			if (++n == ne) break;	/* A contiguous entry that required count is found */
// 1519 		} else {
// 1520 			n = 0;					/* Not a blank entry. Restart to search */
// 1521 		}
// 1522 		res = dir_next(dj, 1);		/* Next entry with table stretch */
// 1523 	} while (res == FR_OK);
// 1524 
// 1525 	if (res == FR_OK && ne > 1) {	/* Initialize LFN entry if needed */
// 1526 		res = dir_sdi(dj, is);
// 1527 		if (res == FR_OK) {
// 1528 			sum = sum_sfn(dj->fn);	/* Sum of the SFN tied to the LFN */
// 1529 			ne--;
// 1530 			do {					/* Store LFN entries in bottom first */
// 1531 				res = move_window(dj->fs, dj->sect);
// 1532 				if (res != FR_OK) break;
// 1533 				fit_lfn(dj->lfn, dj->dir, (BYTE)ne, sum);
// 1534 				dj->fs->wflag = 1;
// 1535 				res = dir_next(dj, 0);	/* Next entry */
// 1536 			} while (res == FR_OK && --ne);
// 1537 		}
// 1538 	}
// 1539 
// 1540 #else	/* Non LFN configuration */
// 1541 	res = dir_sdi(dj, 0);
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       dir_sdi
        MOVS     R4,R0
// 1542 	if (res == FR_OK) {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??dir_register_0
// 1543 		do {	/* Find a blank entry for the SFN */
// 1544 			res = move_window(dj->fs, dj->sect);
??dir_register_1:
        LDR      R1,[R5, #+16]
        LDR      R0,[R5, #+0]
        BL       move_window
        MOVS     R4,R0
// 1545 			if (res != FR_OK) break;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??dir_register_2
// 1546 			c = *dj->dir;
??dir_register_3:
        LDR      R0,[R5, #+20]
        LDRB     R0,[R0, #+0]
// 1547 			if (c == DDE || c == 0) break;	/* Is it a blank entry? */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+229
        BEQ.N    ??dir_register_4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??dir_register_4
// 1548 			res = dir_next(dj, 1);			/* Next entry with table stretch */
??dir_register_5:
        MOVS     R1,#+1
        MOVS     R0,R5
        BL       dir_next
        MOVS     R4,R0
// 1549 		} while (res == FR_OK);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??dir_register_1
        B.N      ??dir_register_0
??dir_register_2:
        B.N      ??dir_register_0
// 1550 	}
// 1551 #endif
// 1552 
// 1553 	if (res == FR_OK) {		/* Initialize the SFN entry */
??dir_register_4:
??dir_register_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??dir_register_6
// 1554 		res = move_window(dj->fs, dj->sect);
        LDR      R1,[R5, #+16]
        LDR      R0,[R5, #+0]
        BL       move_window
        MOVS     R4,R0
// 1555 		if (res == FR_OK) {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??dir_register_6
// 1556 			dir = dj->dir;
        LDR      R6,[R5, #+20]
// 1557 			mem_set(dir, 0, SZ_DIR);	/* Clean the entry */
        MOVS     R2,#+32
        MOVS     R1,#+0
        MOVS     R0,R6
        BL       mem_set
// 1558 			mem_cpy(dir, dj->fn, 11);	/* Put SFN */
        MOVS     R2,#+11
        LDR      R1,[R5, #+24]
        MOVS     R0,R6
        BL       mem_cpy
// 1559 #if _USE_LFN
// 1560 			dir[DIR_NTres] = *(dj->fn+NS) & (NS_BODY | NS_EXT);	/* Put NT flag */
// 1561 #endif
// 1562 			dj->fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[R5, #+0]
        STRB     R0,[R1, #+4]
// 1563 		}
// 1564 	}
// 1565 
// 1566 	return res;
??dir_register_6:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4-R6,PC}       ;; return
// 1567 }
// 1568 #endif /* !_FS_READONLY */
// 1569 
// 1570 
// 1571 
// 1572 
// 1573 /*-----------------------------------------------------------------------*/
// 1574 /* Remove an object from the directory                                   */
// 1575 /*-----------------------------------------------------------------------*/
// 1576 #if !_FS_READONLY && !_FS_MINIMIZE

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1577 static
// 1578 FRESULT dir_remove (	/* FR_OK: Successful, FR_DISK_ERR: A disk error */
// 1579 	DIR *dj				/* Directory object pointing the entry to be removed */
// 1580 )
// 1581 {
dir_remove:
        PUSH     {R4,LR}
        MOVS     R4,R0
// 1582 	FRESULT res;
// 1583 #if _USE_LFN	/* LFN configuration */
// 1584 	WORD i;
// 1585 
// 1586 	i = dj->index;	/* SFN index */
// 1587 	res = dir_sdi(dj, (WORD)((dj->lfn_idx == 0xFFFF) ? i : dj->lfn_idx));	/* Goto the SFN or top of the LFN entries */
// 1588 	if (res == FR_OK) {
// 1589 		do {
// 1590 			res = move_window(dj->fs, dj->sect);
// 1591 			if (res != FR_OK) break;
// 1592 			*dj->dir = DDE;			/* Mark the entry "deleted" */
// 1593 			dj->fs->wflag = 1;
// 1594 			if (dj->index >= i) break;	/* When reached SFN, all entries of the object has been deleted. */
// 1595 			res = dir_next(dj, 0);		/* Next entry */
// 1596 		} while (res == FR_OK);
// 1597 		if (res == FR_NO_FILE) res = FR_INT_ERR;
// 1598 	}
// 1599 
// 1600 #else			/* Non LFN configuration */
// 1601 	res = dir_sdi(dj, dj->index);
        LDRH     R1,[R4, #+6]
        MOVS     R0,R4
        BL       dir_sdi
// 1602 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_remove_0
// 1603 		res = move_window(dj->fs, dj->sect);
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
// 1604 		if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_remove_0
// 1605 			*dj->dir = DDE;			/* Mark the entry "deleted" */
        MOVS     R1,#+229
        LDR      R2,[R4, #+20]
        STRB     R1,[R2, #+0]
// 1606 			dj->fs->wflag = 1;
        MOVS     R1,#+1
        LDR      R2,[R4, #+0]
        STRB     R1,[R2, #+4]
// 1607 		}
// 1608 	}
// 1609 #endif
// 1610 
// 1611 	return res;
??dir_remove_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4,PC}          ;; return
// 1612 }
// 1613 #endif /* !_FS_READONLY */
// 1614 
// 1615 
// 1616 
// 1617 
// 1618 /*-----------------------------------------------------------------------*/
// 1619 /* Pick a segment and create the object name in directory form           */
// 1620 /*-----------------------------------------------------------------------*/
// 1621 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1622 static
// 1623 FRESULT create_name (
// 1624 	DIR *dj,			/* Pointer to the directory object */
// 1625 	const TCHAR **path	/* Pointer to pointer to the segment in the path string */
// 1626 )
// 1627 {
create_name:
        PUSH     {R3-R11,LR}
        MOVS     R5,R1
// 1628 #ifdef _EXCVT
// 1629 	static const BYTE excvt[] = _EXCVT;	/* Upper conversion table for extended chars */
// 1630 #endif
// 1631 
// 1632 #if _USE_LFN	/* LFN configuration */
// 1633 	BYTE b, cf;
// 1634 	WCHAR w, *lfn;
// 1635 	UINT i, ni, si, di;
// 1636 	const TCHAR *p;
// 1637 
// 1638 	/* Create LFN in Unicode */
// 1639 	for (p = *path; *p == '/' || *p == '\\'; p++) ;	/* Strip duplicated separator */
// 1640 	lfn = dj->lfn;
// 1641 	si = di = 0;
// 1642 	for (;;) 
// 1643 	{
// 1644 		w = p[si++];					/* Get a character */
// 1645 		if (w < ' ' || w == '/' || w == '\\') break;	/* Break on end of segment */
// 1646 		if (di >= _MAX_LFN)				/* Reject too long name */
// 1647 			return FR_INVALID_NAME;
// 1648 #if !_LFN_UNICODE
// 1649 		w &= 0xFF;
// 1650 		if (IsDBCS1(w)) 
// 1651 		{				/* Check if it is a DBC 1st byte (always false on SBCS cfg) */
// 1652 			b = (BYTE)p[si++];			/* Get 2nd byte */
// 1653 			if (!IsDBCS2(b))
// 1654 				return FR_INVALID_NAME;	/* Reject invalid sequence */
// 1655 			w = (w << 8) + b;			/* Create a DBC */
// 1656 		}
// 1657 		w = ff_convert(w, 1);			/* Convert ANSI/OEM to Unicode */
// 1658 		if (!w) return FR_INVALID_NAME;	/* Reject invalid code */
// 1659 #endif
// 1660 		if (w < 0x80 && chk_chr("\"*:<>\?|\x7F", w)) /* Reject illegal chars for LFN */
// 1661 			return FR_INVALID_NAME;
// 1662 		lfn[di++] = w;					/* Store the Unicode char */
// 1663 	}
// 1664 	*path = &p[si];						/* Return pointer to the next segment */
// 1665 	cf = (w < ' ') ? NS_LAST : 0;		/* Set last segment flag if end of path */
// 1666 #if _FS_RPATH
// 1667 	if ((di == 1 && lfn[di-1] == '.') || /* Is this a dot entry? */
// 1668 		(di == 2 && lfn[di-1] == '.' && lfn[di-2] == '.')) {
// 1669 		lfn[di] = 0;
// 1670 		for (i = 0; i < 11; i++)
// 1671 			dj->fn[i] = (i < di) ? '.' : ' ';
// 1672 		dj->fn[i] = cf | NS_DOT;		/* This is a dot entry */
// 1673 		return FR_OK;
// 1674 	}
// 1675 #endif
// 1676 	while (di)
// 1677 	{						/* Strip trailing spaces and dots */
// 1678 		w = lfn[di-1];
// 1679 		if (w != ' ' && w != '.') break;
// 1680 		di--;
// 1681 	}
// 1682 	if (!di) return FR_INVALID_NAME;	/* Reject nul string */
// 1683 
// 1684 	lfn[di] = 0;						/* LFN is created */
// 1685 
// 1686 	/* Create SFN in directory form */
// 1687 	mem_set(dj->fn, ' ', 11);
// 1688 	for (si = 0; lfn[si] == ' ' || lfn[si] == '.'; si++) ;	/* Strip leading spaces and dots */
// 1689 	if (si) cf |= NS_LOSS | NS_LFN;
// 1690 	while (di && lfn[di - 1] != '.') di--;	/* Find extension (di<=si: no extension) */
// 1691 
// 1692 	b = i = 0; ni = 8;
// 1693 	for (;;) 
// 1694 	{
// 1695 		w = lfn[si++];					/* Get an LFN char */
// 1696 		if (!w) break;					/* Break on end of the LFN */
// 1697 		if (w == ' ' || (w == '.' && si != di)) 
// 1698 		{	/* Remove spaces and dots */
// 1699 			cf |= NS_LOSS | NS_LFN; continue;
// 1700 		}
// 1701 
// 1702 		if (i >= ni || si == di)
// 1703 		{		/* Extension or end of SFN */
// 1704 			if (ni == 11) 
// 1705 			{				/* Long extension */
// 1706 				cf |= NS_LOSS | NS_LFN; break;
// 1707 			}
// 1708 			if (si != di) cf |= NS_LOSS | NS_LFN;	/* Out of 8.3 format */
// 1709 			if (si > di) break;			/* No extension */
// 1710 			si = di; i = 8; ni = 11;	/* Enter extension section */
// 1711 			b <<= 2; continue;
// 1712 		}
// 1713 
// 1714 		if (w >= 0x80) 
// 1715 		{				/* Non ASCII char */
// 1716 #ifdef _EXCVT
// 1717 			w = ff_convert(w, 0);		/* Unicode -> OEM code */
// 1718 			if (w) w = excvt[w - 0x80];	/* Convert extended char to upper (SBCS) */
// 1719 #else
// 1720 			w = ff_convert(ff_wtoupper(w), 0);	/* Upper converted Unicode -> OEM code */
// 1721 #endif
// 1722 			cf |= NS_LFN;				/* Force create LFN entry */
// 1723 		}
// 1724 
// 1725 		if (_DF1S && w >= 0x100) {		/* Double byte char (always false on SBCS cfg) */
// 1726 			if (i >= ni - 1) {
// 1727 				cf |= NS_LOSS | NS_LFN; i = ni; continue;
// 1728 			}
// 1729 			dj->fn[i++] = (BYTE)(w >> 8);
// 1730 		} else {						/* Single byte char */
// 1731 			if (!w || chk_chr("+,;=[]", w)) {	/* Replace illegal chars for SFN */
// 1732 				w = '_'; cf |= NS_LOSS | NS_LFN;/* Lossy conversion */
// 1733 			} else {
// 1734 				if (IsUpper(w)) {		/* ASCII large capital */
// 1735 					b |= 2;
// 1736 				} else {
// 1737 					if (IsLower(w)) {	/* ASCII small capital */
// 1738 						b |= 1; w -= 0x20;
// 1739 					}
// 1740 				}
// 1741 			}
// 1742 		}
// 1743 		dj->fn[i++] = (BYTE)w;
// 1744 	}
// 1745 
// 1746 	if (dj->fn[0] == DDE) dj->fn[0] = NDDE;	/* If the first char collides with deleted mark, replace it with 0x05 */
// 1747 
// 1748 	if (ni == 8) b <<= 2;
// 1749 	if ((b & 0x0C) == 0x0C || (b & 0x03) == 0x03)	/* Create LFN entry when there are composite capitals */
// 1750 		cf |= NS_LFN;
// 1751 	if (!(cf & NS_LFN)) {						/* When LFN is in 8.3 format without extended char, NT flags are created */
// 1752 		if ((b & 0x03) == 0x01) cf |= NS_EXT;	/* NT flag (Extension has only small capital) */
// 1753 		if ((b & 0x0C) == 0x04) cf |= NS_BODY;	/* NT flag (Filename has only small capital) */
// 1754 	}
// 1755 
// 1756 	dj->fn[NS] = cf;	/* SFN is created */
// 1757 
// 1758 	return FR_OK;
// 1759 
// 1760 
// 1761 #else	/* Non-LFN configuration */
// 1762 	BYTE b, c, d, *sfn;
// 1763 	UINT ni, si, i;
// 1764 	const char *p;
// 1765 
// 1766 	/* Create file name in directory form */
// 1767 	for (p = *path; *p == '/' || *p == '\\'; p++) ;	/* Strip duplicated separator */
        LDR      R6,[R5, #+0]
        B.N      ??create_name_0
??create_name_1:
        ADDS     R6,R6,#+1
??create_name_0:
        LDRB     R1,[R6, #+0]
        CMP      R1,#+47
        BEQ.N    ??create_name_1
        LDRB     R1,[R6, #+0]
        CMP      R1,#+92
        BEQ.N    ??create_name_1
// 1768 	sfn = dj->fn;
        LDR      R8,[R0, #+24]
// 1769 	mem_set(sfn, ' ', 11);
        MOVS     R2,#+11
        MOVS     R1,#+32
        MOV      R0,R8
        BL       mem_set
// 1770 	si = i = b = 0; ni = 8;
        MOVS     R11,#+0
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        MOV      R4,R11
        MOV      R10,R4
        MOVS     R9,#+8
        B.N      ??create_name_2
// 1771 #if _FS_RPATH
// 1772 	if (p[si] == '.') 
// 1773 	{ /* Is this a dot entry? */
// 1774 		for (;;) 
// 1775 		{
// 1776 			c = (BYTE)p[si++];
// 1777 			if (c != '.' || si >= 3) break;
// 1778 			sfn[i++] = c;
// 1779 		}
// 1780 		if (c != '/' && c != '\\' && c > ' ') return FR_INVALID_NAME;
// 1781 		*path = &p[si];									/* Return pointer to the next segment */
// 1782 		sfn[NS] = (c <= ' ') ? NS_LAST | NS_DOT : NS_DOT;	/* Set last segment flag if end of path */
// 1783 		return FR_OK;
// 1784 	}
// 1785 #endif
// 1786 	for (;;) 
// 1787 	{
// 1788 		c = (BYTE)p[si++];
// 1789 		if (c <= ' ' || c == '/' || c == '\\') break;	/* Break on end of segment */
// 1790 		if (c == '.' || i >= ni)
??create_name_3:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+46
        BEQ.N    ??create_name_4
        CMP      R4,R9
        BCC.N    ??create_name_5
// 1791 		{
// 1792 			if (ni != 8 || c != '.') return FR_INVALID_NAME;
??create_name_4:
        CMP      R9,#+8
        BNE.N    ??create_name_6
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+46
        BNE.N    ??create_name_6
// 1793 			i = 8; ni = 11;
??create_name_7:
        MOVS     R4,#+8
        MOVS     R9,#+11
// 1794 			b <<= 2; continue;
        LSLS     R11,R11,#+2
??create_name_2:
        LDRB     R7,[R6, R10]
        ADDS     R10,R10,#+1
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+33
        BLT.N    ??create_name_8
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+47
        BEQ.N    ??create_name_8
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+92
        BNE.N    ??create_name_3
// 1795 		}
// 1796 		if (c >= 0x80) 
// 1797 		{				/* Extended char? */
// 1798 			b |= 3;						/* Eliminate NT flag */
// 1799 #ifdef _EXCVT
// 1800 			c = excvt[c-0x80];			/* Upper conversion (SBCS) */
// 1801 #else
// 1802 #if !_DF1S	/* ASCII only cfg */
// 1803 			return FR_INVALID_NAME;
// 1804 #endif
// 1805 #endif
// 1806 		}
// 1807 		if (IsDBCS1(c)) 
// 1808 		{				/* Check if it is a DBC 1st byte (always false on SBCS cfg) */
// 1809 			d = (BYTE)p[si++];			/* Get 2nd byte */
// 1810 			if (!IsDBCS2(d) || i >= ni - 1)	/* Reject invalid DBC */
// 1811 				return FR_INVALID_NAME;
// 1812 			sfn[i++] = c;
// 1813 			sfn[i++] = d;
// 1814 		} 
// 1815 		else 
// 1816 		{						/* Single byte code */
// 1817 			if (chk_chr("\"*+,:;<=>\?[]|\x7F", c))	/* Reject illegal chrs for SFN */
// 1818 				return FR_INVALID_NAME;
// 1819 			if (IsUpper(c))
// 1820 			{			/* ASCII large capital? */
// 1821 				b |= 2;
// 1822 			} 
// 1823 			else 
// 1824 			{
// 1825 				if (IsLower(c)) 
// 1826 				{		/* ASCII small capital? */
// 1827 					b |= 1; c -= 0x20;
// 1828 				}
// 1829 			}
// 1830 			sfn[i++] = c;
// 1831 		}
// 1832 	}
// 1833 	*path = &p[si];						/* Return pointer to the next segment */
??create_name_8:
        ADD      R0,R6,R10
        STR      R0,[R5, #+0]
// 1834 	c = (c <= ' ') ? NS_LAST : 0;		/* Set last segment flag if end of path */
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+33
        BGE.N    ??create_name_9
        MOVS     R7,#+4
        B.N      ??create_name_10
??create_name_6:
        MOVS     R0,#+6
        B.N      ??create_name_11
??create_name_5:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+128
        BLT.N    ??create_name_12
        ORRS     R11,R11,#0x3
??create_name_12:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+129
        BLT.N    ??create_name_13
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+255
        BEQ.N    ??create_name_13
        LDRB     R0,[R6, R10]
        ADDS     R10,R10,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        SUBS     R1,R0,#+64
        CMP      R1,#+63
        BCC.N    ??create_name_14
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+128
        BLT.N    ??create_name_15
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+255
        BEQ.N    ??create_name_15
??create_name_14:
        SUBS     R1,R9,#+1
        CMP      R4,R1
        BCC.N    ??create_name_16
??create_name_15:
        MOVS     R0,#+6
        B.N      ??create_name_11
??create_name_16:
        STRB     R7,[R8, R4]
        ADDS     R4,R4,#+1
        STRB     R0,[R8, R4]
        ADDS     R4,R4,#+1
        B.N      ??create_name_2
??create_name_13:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        MOVS     R1,R7
        LDR.W    R0,??DataTable4
        BL       chk_chr
        CMP      R0,#+0
        BNE.N    ??create_name_17
??create_name_18:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        SUBS     R0,R7,#+65
        CMP      R0,#+26
        BCS.N    ??create_name_19
        ORRS     R11,R11,#0x2
        B.N      ??create_name_20
??create_name_17:
        MOVS     R0,#+6
        B.N      ??create_name_11
??create_name_19:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        SUBS     R0,R7,#+97
        CMP      R0,#+26
        BCS.N    ??create_name_20
        ORRS     R11,R11,#0x1
        SUBS     R7,R7,#+32
??create_name_20:
        STRB     R7,[R8, R4]
        ADDS     R4,R4,#+1
        B.N      ??create_name_2
??create_name_9:
        MOVS     R7,#+0
// 1835 
// 1836 	if (!i) return FR_INVALID_NAME;		/* Reject nul string */
??create_name_10:
        CMP      R4,#+0
        BNE.N    ??create_name_21
        MOVS     R0,#+6
        B.N      ??create_name_11
// 1837 	if (sfn[0] == DDE) sfn[0] = NDDE;	/* When first char collides with DDE, replace it with 0x05 */
??create_name_21:
        LDRB     R0,[R8, #+0]
        CMP      R0,#+229
        BNE.N    ??create_name_22
        MOVS     R0,#+5
        STRB     R0,[R8, #+0]
// 1838 
// 1839 	if (ni == 8) b <<= 2;
??create_name_22:
        CMP      R9,#+8
        BNE.N    ??create_name_23
        LSLS     R11,R11,#+2
// 1840 	if ((b & 0x03) == 0x01) c |= NS_EXT;	/* NT flag (Name extension has only small capital) */
??create_name_23:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        ANDS     R0,R11,#0x3
        CMP      R0,#+1
        BNE.N    ??create_name_24
        ORRS     R7,R7,#0x10
// 1841 	if ((b & 0x0C) == 0x04) c |= NS_BODY;	/* NT flag (Name body has only small capital) */
??create_name_24:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        ANDS     R11,R11,#0xC
        CMP      R11,#+4
        BNE.N    ??create_name_25
        ORRS     R7,R7,#0x8
// 1842 
// 1843 	sfn[NS] = c;		/* Store NT flag, File name is created */
??create_name_25:
        STRB     R7,[R8, #+11]
// 1844 
// 1845 	return FR_OK;
        MOVS     R0,#+0
??create_name_11:
        POP      {R1,R4-R11,PC}   ;; return
// 1846 #endif
// 1847 }
// 1848 
// 1849 
// 1850 
// 1851 
// 1852 /*-----------------------------------------------------------------------*/
// 1853 /* Get file information from directory entry                             */
// 1854 /*-----------------------------------------------------------------------*/
// 1855 #if _FS_MINIMIZE <= 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1856 static
// 1857 void get_fileinfo (		/* No return code */
// 1858 	DIR *dj,			/* Pointer to the directory object */
// 1859 	FILINFO *fno	 	/* Pointer to the file information to be filled */
// 1860 )
// 1861 {
get_fileinfo:
        PUSH     {R4}
// 1862 	UINT i;
// 1863 	BYTE nt, *dir;
// 1864 	TCHAR *p, c;
// 1865 
// 1866 
// 1867 	p = fno->fname;
        ADDS     R3,R1,#+9
// 1868 	if (dj->sect) 
        LDR      R2,[R0, #+16]
        CMP      R2,#+0
        BEQ.N    ??get_fileinfo_0
// 1869 	{
// 1870 		dir = dj->dir;
        LDR      R2,[R0, #+20]
// 1871 		nt = dir[DIR_NTres];		/* NT flag */
        LDRB     R0,[R2, #+12]
// 1872 		for (i = 0; i < 8; i++) 
        MOVS     R0,#+0
        B.N      ??get_fileinfo_1
// 1873 		{	/* Copy name body */
// 1874 			c = dir[i];
// 1875 			if (c == ' ') break;
// 1876 			if (c == NDDE) c = (TCHAR)DDE;
??get_fileinfo_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+5
        BNE.N    ??get_fileinfo_3
        MOVS     R4,#+229
// 1877 			if (_USE_LFN && (nt & NS_BODY) && IsUpper(c)) c += 0x20;
// 1878 #if _LFN_UNICODE
// 1879 			if (IsDBCS1(c) && i < 7 && IsDBCS2(dir[i+1]))
// 1880 				c = (c << 8) | dir[++i];
// 1881 			c = ff_convert(c, 1);
// 1882 			if (!c) c = '?';
// 1883 #endif
// 1884 			*p++ = c;
??get_fileinfo_3:
        STRB     R4,[R3, #+0]
        ADDS     R3,R3,#+1
        ADDS     R0,R0,#+1
??get_fileinfo_1:
        CMP      R0,#+8
        BCS.N    ??get_fileinfo_4
        LDRB     R4,[R2, R0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+32
        BNE.N    ??get_fileinfo_2
// 1885 		}
// 1886 		if (dir[8] != ' ') 
??get_fileinfo_4:
        LDRB     R0,[R2, #+8]
        CMP      R0,#+32
        BEQ.N    ??get_fileinfo_5
// 1887 		{		/* Copy name extension */
// 1888 			*p++ = '.';
        MOVS     R0,#+46
        STRB     R0,[R3, #+0]
        ADDS     R3,R3,#+1
// 1889 			for (i = 8; i < 11; i++)
        MOVS     R0,#+8
        B.N      ??get_fileinfo_6
// 1890 			{
// 1891 				c = dir[i];
// 1892 				if (c == ' ') break;
// 1893 				if (_USE_LFN && (nt & NS_EXT) && IsUpper(c)) c += 0x20;
// 1894 #if _LFN_UNICODE
// 1895 				if (IsDBCS1(c) && i < 10 && IsDBCS2(dir[i+1]))
// 1896 					c = (c << 8) | dir[++i];
// 1897 				c = ff_convert(c, 1);
// 1898 				if (!c) c = '?';
// 1899 #endif
// 1900 				*p++ = c;
??get_fileinfo_7:
        STRB     R4,[R3, #+0]
        ADDS     R3,R3,#+1
        ADDS     R0,R0,#+1
??get_fileinfo_6:
        CMP      R0,#+11
        BCS.N    ??get_fileinfo_5
        LDRB     R4,[R2, R0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+32
        BNE.N    ??get_fileinfo_7
// 1901 			}
// 1902 		}
// 1903 		fno->fattrib = dir[DIR_Attr];				/* Attribute */
??get_fileinfo_5:
        LDRB     R0,[R2, #+11]
        STRB     R0,[R1, #+8]
// 1904 		fno->fsize = LD_DWORD(dir+DIR_FileSize);	/* Size */
        LDRB     R0,[R2, #+31]
        LDRB     R4,[R2, #+30]
        LSLS     R4,R4,#+16
        ORRS     R4,R4,R0, LSL #+24
        LDRB     R0,[R2, #+29]
        ORRS     R4,R4,R0, LSL #+8
        LDRB     R0,[R2, #+28]
        ORRS     R4,R0,R4
        STR      R4,[R1, #+0]
// 1905 		fno->fdate = LD_WORD(dir+DIR_WrtDate);		/* Date */
        LDRB     R0,[R2, #+25]
        LDRB     R4,[R2, #+24]
        ORRS     R4,R4,R0, LSL #+8
        STRH     R4,[R1, #+4]
// 1906 		fno->ftime = LD_WORD(dir+DIR_WrtTime);		/* Time */
        LDRB     R0,[R2, #+23]
        LDRB     R2,[R2, #+22]
        ORRS     R2,R2,R0, LSL #+8
        STRH     R2,[R1, #+6]
// 1907 	}
// 1908 	*p = 0;		/* Terminate SFN str by a \0 */
??get_fileinfo_0:
        MOVS     R0,#+0
        STRB     R0,[R3, #+0]
// 1909 
// 1910 #if _USE_LFN
// 1911 	if (fno->lfname && fno->lfsize) 
// 1912 	{
// 1913 		TCHAR *tp = fno->lfname;
// 1914 		WCHAR w, *lfn;
// 1915 
// 1916 		i = 0;
// 1917 		if (dj->sect && dj->lfn_idx != 0xFFFF)
// 1918 		{/* Get LFN if available */
// 1919 			lfn = dj->lfn;
// 1920 			while ((w = *lfn++) != 0) 
// 1921 			{			/* Get an LFN char */
// 1922 #if !_LFN_UNICODE
// 1923 				w = ff_convert(w, 0);			/* Unicode -> OEM conversion */
// 1924 				if (!w) { i = 0; break; }		/* Could not convert, no LFN */
// 1925 				if (_DF1S && w >= 0x100)		/* Put 1st byte if it is a DBC (always false on SBCS cfg) */
// 1926 					tp[i++] = (TCHAR)(w >> 8);
// 1927 #endif
// 1928 				if (i >= fno->lfsize - 1) { i = 0; break; }	/* Buffer overflow, no LFN */
// 1929 				tp[i++] = (TCHAR)w;
// 1930 			}
// 1931 		}
// 1932 		tp[i] = 0;	/* Terminate the LFN str by a \0 */
// 1933 	}
// 1934 #endif
// 1935 }
        POP      {R4}
        BX       LR               ;; return
// 1936 #endif /* _FS_MINIMIZE <= 1 */
// 1937 
// 1938 
// 1939 
// 1940 
// 1941 /*-----------------------------------------------------------------------*/
// 1942 /* Follow a file path                                                    */
// 1943 /*-----------------------------------------------------------------------*/
// 1944 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1945 static
// 1946 FRESULT follow_path (	/* FR_OK(0): successful, !=0: error code */
// 1947 	DIR *dj,			/* Directory object to return last directory and found object */
// 1948 	const TCHAR *path	/* Full-path string to find a file or directory */
// 1949 )
// 1950 {
follow_path:
        PUSH     {R0,R1,R4,LR}
        MOVS     R4,R0
// 1951 	FRESULT res;
// 1952 	BYTE *dir, ns;
// 1953 
// 1954 
// 1955 #if _FS_RPATH
// 1956 	if (*path == '/' || *path == '\\') { /* There is a heading separator */
// 1957 		path++;	dj->sclust = 0;		/* Strip it and start from the root dir */
// 1958 	} else {							/* No heading separator */
// 1959 		dj->sclust = dj->fs->cdir;	/* Start from the current dir */
// 1960 	}
// 1961 #else
// 1962 	if (*path == '/' || *path == '\\')	/* Strip heading separator if exist */
        LDR      R0,[SP, #+4]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+47
        BEQ.N    ??follow_path_0
        LDR      R0,[SP, #+4]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+92
        BNE.N    ??follow_path_1
// 1963 		path++;
??follow_path_0:
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+4]
// 1964 	dj->sclust = 0;						/* Start from the root dir */
??follow_path_1:
        MOVS     R0,#+0
        STR      R0,[R4, #+8]
// 1965 #endif
// 1966 
// 1967 	if ((UINT)*path < ' ') {			/* Nul path means the start directory itself */
        LDR      R0,[SP, #+4]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+32
        BCS.N    ??follow_path_2
// 1968 		res = dir_sdi(dj, 0);
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_sdi
// 1969 		dj->dir = 0;
        MOVS     R1,#+0
        STR      R1,[R4, #+20]
        B.N      ??follow_path_3
// 1970 
// 1971 	} else {							/* Follow path */
// 1972 		for (;;) {
// 1973 			res = create_name(dj, &path);	/* Get a segment */
// 1974 			if (res != FR_OK) break;
// 1975 			res = dir_find(dj);				/* Find it */
??follow_path_4:
        MOVS     R0,R4
        BL       dir_find
// 1976 			ns = *(dj->fn+NS);
        LDR      R1,[R4, #+24]
        LDRB     R1,[R1, #+11]
// 1977 			if (res != FR_OK) {				/* Failed to find the object */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??follow_path_5
// 1978 				if (res != FR_NO_FILE) break;	/* Abort if any hard error occured */
// 1979 				/* Object not found */
// 1980 				if (_FS_RPATH && (ns & NS_DOT)) {	/* If dot entry is not exit */
// 1981 					dj->sclust = 0; dj->dir = 0;	/* It is the root dir */
// 1982 					res = FR_OK;
// 1983 					if (!(ns & NS_LAST)) continue;
// 1984 				} else {							/* Could not find the object */
// 1985 					if (!(ns & NS_LAST)) res = FR_NO_PATH;
// 1986 				}
// 1987 				break;
// 1988 			}
// 1989 			if (ns & NS_LAST) break;			/* Last segment match. Function completed. */
??follow_path_6:
        LSLS     R1,R1,#+29
        BMI.N    ??follow_path_7
// 1990 			dir = dj->dir;						/* There is next segment. Follow the sub directory */
??follow_path_8:
        LDR      R0,[R4, #+20]
// 1991 			if (!(dir[DIR_Attr] & AM_DIR)) {	/* Cannot follow because it is a file */
        LDRB     R1,[R0, #+11]
        LSLS     R1,R1,#+27
        BPL.N    ??follow_path_9
// 1992 				res = FR_NO_PATH; break;
// 1993 			}
// 1994 			dj->sclust = LD_CLUST(dir);
??follow_path_10:
        LDRB     R1,[R0, #+21]
        LDRB     R2,[R0, #+20]
        ORRS     R2,R2,R1, LSL #+8
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDRB     R1,[R0, #+27]
        LDRB     R0,[R0, #+26]
        ORRS     R0,R0,R1, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ORRS     R0,R0,R2, LSL #+16
        STR      R0,[R4, #+8]
??follow_path_2:
        ADD      R1,SP,#+4
        MOVS     R0,R4
        BL       create_name
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??follow_path_4
        B.N      ??follow_path_3
??follow_path_5:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BNE.N    ??follow_path_3
??follow_path_11:
        LSLS     R1,R1,#+29
        BMI.N    ??follow_path_12
        MOVS     R0,#+5
??follow_path_12:
        B.N      ??follow_path_3
??follow_path_7:
        B.N      ??follow_path_3
??follow_path_9:
        MOVS     R0,#+5
// 1995 		}
// 1996 	}
// 1997 
// 1998 	return res;
??follow_path_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R2,R4,PC}    ;; return
// 1999 }
// 2000 
// 2001 
// 2002 
// 2003 
// 2004 /*-----------------------------------------------------------------------*/
// 2005 /* Load boot record and check if it is an FAT boot record                */
// 2006 /*-----------------------------------------------------------------------*/
// 2007 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2008 static
// 2009 BYTE check_fs (	/* 0:The FAT BR, 1:Valid BR but not an FAT, 2:Not a BR, 3:Disk error */
// 2010 	FATFS *fs,	/* File system object */
// 2011 	DWORD sect	/* Sector# (lba) to check if it is an FAT boot record or not */
// 2012 )
// 2013 {
check_fs:
        PUSH     {R4,LR}
        MOVS     R4,R0
        MOVS     R2,R1
// 2014 	if (disk_read(fs->drv, fs->win, sect, 1) != RES_OK)	/* Load boot record */
        MOVS     R3,#+1
        ADDS     R1,R4,#+48
        LDRB     R0,[R4, #+1]
        BL       disk_read
        CMP      R0,#+0
        BEQ.N    ??check_fs_0
// 2015 		return 3;
        MOVS     R0,#+3
        B.N      ??check_fs_1
// 2016 	if (LD_WORD(&fs->win[BS_55AA]) != 0xAA55)		/* Check record signature (always placed at offset 510 even if the sector size is >512) */
??check_fs_0:
        LDRB     R0,[R4, #+559]
        LDRB     R1,[R4, #+558]
        ORRS     R1,R1,R0, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVW     R0,#+43605
        CMP      R1,R0
        BEQ.N    ??check_fs_2
// 2017 		return 2;
        MOVS     R0,#+2
        B.N      ??check_fs_1
// 2018 
// 2019 	if ((LD_DWORD(&fs->win[BS_FilSysType]) & 0xFFFFFF) == 0x544146)	/* Check "FAT" string */
??check_fs_2:
        LDRB     R0,[R4, #+104]
        LDRB     R1,[R4, #+103]
        LSLS     R1,R1,#+8
        ORRS     R1,R1,R0, LSL #+16
        LDRB     R0,[R4, #+102]
        ORRS     R1,R0,R1
        LDR.W    R0,??DataTable4_1  ;; 0x544146
        CMP      R1,R0
        BNE.N    ??check_fs_3
// 2020 		return 0;
        MOVS     R0,#+0
        B.N      ??check_fs_1
// 2021 	if ((LD_DWORD(&fs->win[BS_FilSysType32]) & 0xFFFFFF) == 0x544146)
??check_fs_3:
        LDRB     R0,[R4, #+132]
        LDRB     R1,[R4, #+131]
        LSLS     R1,R1,#+8
        ORRS     R1,R1,R0, LSL #+16
        LDRB     R0,[R4, #+130]
        ORRS     R1,R0,R1
        LDR.W    R0,??DataTable4_1  ;; 0x544146
        CMP      R1,R0
        BNE.N    ??check_fs_4
// 2022 		return 0;
        MOVS     R0,#+0
        B.N      ??check_fs_1
// 2023 
// 2024 	return 1;
??check_fs_4:
        MOVS     R0,#+1
??check_fs_1:
        POP      {R4,PC}          ;; return
// 2025 }
// 2026 
// 2027 
// 2028 
// 2029 
// 2030 /*-----------------------------------------------------------------------*/
// 2031 /* Check if the file system object is valid or not                       */
// 2032 /*-----------------------------------------------------------------------*/
// 2033 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2034 static
// 2035 FRESULT chk_mounted (	/* FR_OK(0): successful, !=0: any error occurred */
// 2036 	const TCHAR **path,	/* Pointer to pointer to the path name (drive number) */
// 2037 	FATFS **rfs,		/* Pointer to pointer to the found file system object */
// 2038 	BYTE chk_wp			/* !=0: Check media write protection for write access */
// 2039 )
// 2040 {
chk_mounted:
        PUSH     {R3-R7,LR}
        MOVS     R4,R2
// 2041 	BYTE fmt, b, *tbl;
// 2042 	UINT vol;
// 2043 	DSTATUS stat;
// 2044 	DWORD bsect, fasize, tsect, sysect, nclst, szbfat;
// 2045 	WORD nrsv;
// 2046 	const TCHAR *p = *path;
        LDR      R2,[R0, #+0]
// 2047 	FATFS *fs;
// 2048 
// 2049 	/* Get logical drive number from the path name */
// 2050 	vol = p[0] - '0';					/* Is there a drive number? */
        LDRB     R6,[R2, #+0]
        SUBS     R6,R6,#+48
// 2051 	if (vol <= 9 && p[1] == ':') 
        CMP      R6,#+10
        BCS.N    ??chk_mounted_0
        LDRB     R3,[R2, #+1]
        CMP      R3,#+58
        BNE.N    ??chk_mounted_0
// 2052 	{		/* Found a drive number, get and strip it */
// 2053 		p += 2; *path = p;				/* Return pointer to the path name */
        ADDS     R2,R2,#+2
        STR      R2,[R0, #+0]
        B.N      ??chk_mounted_1
// 2054 	} 
// 2055 	else 
// 2056 	{							/* No drive number is given */
// 2057 #if _FS_RPATH
// 2058 		vol = CurrVol;					/* Use current drive */
// 2059 #else
// 2060 		vol = 0;						/* Use drive 0 */
??chk_mounted_0:
        MOVS     R6,#+0
// 2061 #endif
// 2062 	}
// 2063 
// 2064 	/* Check if the logical drive is valid or not */
// 2065 	if (vol >= _VOLUMES) 				/* Is the drive number valid? */
??chk_mounted_1:
        CMP      R6,#+0
        BEQ.N    ??chk_mounted_2
// 2066 		return FR_INVALID_DRIVE;
        MOVS     R0,#+11
        B.N      ??chk_mounted_3
// 2067 	*rfs = fs = FatFs[vol];				/* Return pointer to the corresponding file system object */
??chk_mounted_2:
        LDR.W    R0,??DataTable4_2
        LDR      R5,[R0, R6, LSL #+2]
        STR      R5,[R1, #+0]
// 2068 	if (!fs) return FR_NOT_ENABLED;		/* Is the file system object available? */
        CMP      R5,#+0
        BNE.N    ??chk_mounted_4
        MOVS     R0,#+12
        B.N      ??chk_mounted_3
// 2069 
// 2070 	ENTER_FF(fs);						/* Lock file system */
// 2071 
// 2072 	if (fs->fs_type) 
??chk_mounted_4:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BEQ.N    ??chk_mounted_5
// 2073 	{					/* If the logical drive has been mounted */
// 2074 		stat = disk_status(fs->drv);
        LDRB     R0,[R5, #+1]
        BL       disk_status
// 2075 		if (!(stat & STA_NOINIT)) 
        LSLS     R1,R0,#+31
        BMI.N    ??chk_mounted_5
// 2076 		{		/* and the physical drive is kept initialized (has not been changed), */
// 2077 #if !_FS_READONLY
// 2078 			if (chk_wp && (stat & STA_PROTECT))	/* Check write protection if needed */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??chk_mounted_6
        LSLS     R0,R0,#+29
        BPL.N    ??chk_mounted_6
// 2079 				return FR_WRITE_PROTECTED;
        MOVS     R0,#+10
        B.N      ??chk_mounted_3
// 2080 #endif
// 2081 			return FR_OK;				/* The file system object is valid */
??chk_mounted_6:
        MOVS     R0,#+0
        B.N      ??chk_mounted_3
// 2082 		}
// 2083 	}
// 2084 
// 2085 	/* The logical drive must be mounted. */
// 2086 	/* Following code attempts to mount a volume. (analyze BPB and initialize the fs object) */
// 2087 
// 2088 	fs->fs_type = 0;					/* Clear the file system object */
??chk_mounted_5:
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
// 2089 	fs->drv = (BYTE)LD2PD(vol);			/* Bind the logical drive and a physical drive */
        STRB     R6,[R5, #+1]
// 2090 	stat = disk_initialize(fs->drv);	/* Initialize low level disk I/O layer */
        LDRB     R0,[R5, #+1]
        BL       disk_initialize
// 2091 	if (stat & STA_NOINIT)				/* Check if the initialization succeeded */
        LSLS     R1,R0,#+31
        BPL.N    ??chk_mounted_7
// 2092 		return FR_NOT_READY;			/* Failed to initialize due to no media or hard error */
        MOVS     R0,#+3
        B.N      ??chk_mounted_3
// 2093 #if _MAX_SS != 512						/* Get disk sector size (variable sector size cfg only) */
// 2094 	if (disk_ioctl(fs->drv, GET_SECTOR_SIZE, &fs->ssize) != RES_OK)
// 2095 		return FR_DISK_ERR;
// 2096 #endif
// 2097 #if !_FS_READONLY
// 2098 	if (chk_wp && (stat & STA_PROTECT))	/* Check disk write protection if needed */
??chk_mounted_7:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??chk_mounted_8
        LSLS     R0,R0,#+29
        BPL.N    ??chk_mounted_8
// 2099 		return FR_WRITE_PROTECTED;
        MOVS     R0,#+10
        B.N      ??chk_mounted_3
// 2100 #endif
// 2101 	/* Search FAT partition on the drive. Supports only generic partitionings, FDISK and SFD. */
// 2102 	fmt = check_fs(fs, bsect = 0);		/* Check sector 0 if it is a VBR */
??chk_mounted_8:
        MOVS     R6,#+0
        MOVS     R1,R6
        MOVS     R0,R5
        BL       check_fs
        MOVS     R4,R0
// 2103 	if (fmt == 1) 
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??chk_mounted_9
// 2104 	{						/* Not an FAT-VBR, the disk may be partitioned */
// 2105 		/* Check the partition listed in top of the partition table */
// 2106 		tbl = &fs->win[MBR_Table + LD2PT(vol) * SZ_PTE];/* Partition table */
        ADDS     R1,R5,#+494
// 2107 		if (tbl[4]) 
        LDRB     R0,[R1, #+4]
        CMP      R0,#+0
        BEQ.N    ??chk_mounted_9
// 2108 		{									/* Is the partition existing? */
// 2109 			bsect = LD_DWORD(&tbl[8]);					/* Partition offset in LBA */
        LDRB     R0,[R1, #+11]
        LDRB     R6,[R1, #+10]
        LSLS     R6,R6,#+16
        ORRS     R6,R6,R0, LSL #+24
        LDRB     R0,[R1, #+9]
        ORRS     R6,R6,R0, LSL #+8
        LDRB     R0,[R1, #+8]
        ORRS     R6,R0,R6
// 2110 			fmt = check_fs(fs, bsect);					/* Check the partition */
        MOVS     R1,R6
        MOVS     R0,R5
        BL       check_fs
        MOVS     R4,R0
// 2111 		}
// 2112 	}
// 2113 	if (fmt == 3) return FR_DISK_ERR;
??chk_mounted_9:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+3
        BNE.N    ??chk_mounted_10
        MOVS     R0,#+1
        B.N      ??chk_mounted_3
// 2114 	if (fmt) return FR_NO_FILESYSTEM;					/* No FAT volume is found */
??chk_mounted_10:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??chk_mounted_11
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2115 
// 2116 	/* Following code initializes the file system object */
// 2117 
// 2118 	if (LD_WORD(fs->win+BPB_BytsPerSec) != SS(fs))		/* (BPB_BytsPerSec must be equal to the physical sector size) */
??chk_mounted_11:
        LDRB     R0,[R5, #+60]
        LDRB     R1,[R5, #+59]
        ORRS     R1,R1,R0, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+512
        BEQ.N    ??chk_mounted_12
// 2119 		return FR_NO_FILESYSTEM;
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2120 
// 2121 	fasize = LD_WORD(fs->win+BPB_FATSz16);				/* Number of sectors per FAT */
??chk_mounted_12:
        LDRB     R0,[R5, #+71]
        LDRB     R2,[R5, #+70]
        ORRS     R2,R2,R0, LSL #+8
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
// 2122 	if (!fasize) fasize = LD_DWORD(fs->win+BPB_FATSz32);
        CMP      R2,#+0
        BNE.N    ??chk_mounted_13
        LDRB     R0,[R5, #+87]
        LDRB     R2,[R5, #+86]
        LSLS     R2,R2,#+16
        ORRS     R2,R2,R0, LSL #+24
        LDRB     R0,[R5, #+85]
        ORRS     R2,R2,R0, LSL #+8
        LDRB     R0,[R5, #+84]
        ORRS     R2,R0,R2
// 2123 	fs->fsize = fasize;
??chk_mounted_13:
        STR      R2,[R5, #+28]
// 2124 
// 2125 	fs->n_fats = b = fs->win[BPB_NumFATs];				/* Number of FAT copies */
        LDRB     R0,[R5, #+64]
        STRB     R0,[R5, #+3]
// 2126 	if (b != 1 && b != 2) return FR_NO_FILESYSTEM;		/* (Must be 1 or 2) */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BEQ.N    ??chk_mounted_14
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+2
        BEQ.N    ??chk_mounted_14
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2127 	fasize *= b;										/* Number of sectors for FAT area */
??chk_mounted_14:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MUL      R0,R0,R2
        MOVS     R2,R0
// 2128 
// 2129 	fs->csize = b = fs->win[BPB_SecPerClus];			/* Number of sectors per cluster */
        LDRB     R0,[R5, #+61]
        STRB     R0,[R5, #+2]
// 2130 	if (!b || (b & (b - 1))) return FR_NO_FILESYSTEM;	/* (Must be power of 2) */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??chk_mounted_15
        SUBS     R1,R0,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        TST      R0,R1
        BEQ.N    ??chk_mounted_16
??chk_mounted_15:
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2131 
// 2132 	fs->n_rootdir = LD_WORD(fs->win+BPB_RootEntCnt);	/* Number of root directory entries */
??chk_mounted_16:
        LDRB     R0,[R5, #+66]
        LDRB     R1,[R5, #+65]
        ORRS     R1,R1,R0, LSL #+8
        STRH     R1,[R5, #+8]
// 2133 	if (fs->n_rootdir % (SS(fs) / SZ_DIR)) return FR_NO_FILESYSTEM;	/* (BPB_RootEntCnt must be sector aligned) */
        LDRB     R0,[R5, #+8]
        TST      R0,#0xF
        BEQ.N    ??chk_mounted_17
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2134 
// 2135 	tsect = LD_WORD(fs->win+BPB_TotSec16);				/* Number of sectors on the volume */
??chk_mounted_17:
        LDRB     R0,[R5, #+68]
        LDRB     R1,[R5, #+67]
        ORRS     R1,R1,R0, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
// 2136 	if (!tsect) tsect = LD_DWORD(fs->win+BPB_TotSec32);
        CMP      R1,#+0
        BNE.N    ??chk_mounted_18
        LDRB     R0,[R5, #+83]
        LDRB     R1,[R5, #+82]
        LSLS     R1,R1,#+16
        ORRS     R1,R1,R0, LSL #+24
        LDRB     R0,[R5, #+81]
        ORRS     R1,R1,R0, LSL #+8
        LDRB     R0,[R5, #+80]
        ORRS     R1,R0,R1
// 2137 
// 2138 	nrsv = LD_WORD(fs->win+BPB_RsvdSecCnt);				/* Number of reserved sectors */
??chk_mounted_18:
        LDRB     R3,[R5, #+63]
        LDRB     R0,[R5, #+62]
        ORRS     R0,R0,R3, LSL #+8
// 2139 	if (!nrsv) return FR_NO_FILESYSTEM;					/* (BPB_RsvdSecCnt must not be 0) */
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BNE.N    ??chk_mounted_19
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2140 
// 2141 	/* Determine the FAT sub type */
// 2142 	sysect = nrsv + fasize + fs->n_rootdir / (SS(fs) / SZ_DIR);	/* RSV+FAT+DIR */
??chk_mounted_19:
        UXTAH    R3,R2,R0
        LDRH     R4,[R5, #+8]
        ADDS     R3,R3,R4, LSR #+4
// 2143 	if (tsect < sysect) return FR_NO_FILESYSTEM;		/* (Invalid volume size) */
        CMP      R1,R3
        BCS.N    ??chk_mounted_20
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2144 	nclst = (tsect - sysect) / fs->csize;				/* Number of clusters */
??chk_mounted_20:
        SUBS     R1,R1,R3
        LDRB     R4,[R5, #+2]
        UDIV     R1,R1,R4
// 2145 	if (!nclst) return FR_NO_FILESYSTEM;				/* (Invalid volume size) */
        CMP      R1,#+0
        BNE.N    ??chk_mounted_21
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2146 	fmt = FS_FAT12;
??chk_mounted_21:
        MOVS     R4,#+1
// 2147 	if (nclst >= MIN_FAT16) fmt = FS_FAT16;
        MOVW     R7,#+4086
        CMP      R1,R7
        BCC.N    ??chk_mounted_22
        MOVS     R4,#+2
// 2148 	if (nclst >= MIN_FAT32) fmt = FS_FAT32;
??chk_mounted_22:
        MOVW     R7,#+65526
        CMP      R1,R7
        BCC.N    ??chk_mounted_23
        MOVS     R4,#+3
// 2149 
// 2150 	/* Boundaries and Limits */
// 2151 	fs->n_fatent = nclst + 2;							/* Number of FAT entries */
??chk_mounted_23:
        ADDS     R1,R1,#+2
        STR      R1,[R5, #+24]
// 2152 	fs->database = bsect + sysect;						/* Data start sector */
        ADDS     R3,R3,R6
        STR      R3,[R5, #+40]
// 2153 	fs->fatbase = bsect + nrsv; 						/* FAT start sector */
        UXTAH    R0,R6,R0
        STR      R0,[R5, #+32]
// 2154 	if (fmt == FS_FAT32) 
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+3
        BNE.N    ??chk_mounted_24
// 2155 	{
// 2156 		if (fs->n_rootdir) return FR_NO_FILESYSTEM;		/* (BPB_RootEntCnt must be 0) */
        LDRH     R0,[R5, #+8]
        CMP      R0,#+0
        BEQ.N    ??chk_mounted_25
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2157 		fs->dirbase = LD_DWORD(fs->win+BPB_RootClus);	/* Root directory start cluster */
??chk_mounted_25:
        LDRB     R0,[R5, #+95]
        LDRB     R1,[R5, #+94]
        LSLS     R1,R1,#+16
        ORRS     R1,R1,R0, LSL #+24
        LDRB     R0,[R5, #+93]
        ORRS     R1,R1,R0, LSL #+8
        LDRB     R0,[R5, #+92]
        ORRS     R1,R0,R1
        STR      R1,[R5, #+36]
// 2158 		szbfat = fs->n_fatent * 4;						/* (Required FAT size) */
        LDR      R0,[R5, #+24]
        LSLS     R0,R0,#+2
        B.N      ??chk_mounted_26
// 2159 	} 
// 2160 	else 
// 2161 	{
// 2162 		if (!fs->n_rootdir)	return FR_NO_FILESYSTEM;	/* (BPB_RootEntCnt must not be 0) */
??chk_mounted_24:
        LDRH     R0,[R5, #+8]
        CMP      R0,#+0
        BNE.N    ??chk_mounted_27
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2163 		fs->dirbase = fs->fatbase + fasize;				/* Root directory start sector */
??chk_mounted_27:
        LDR      R0,[R5, #+32]
        ADDS     R2,R2,R0
        STR      R2,[R5, #+36]
// 2164 		szbfat = (fmt == FS_FAT16) ?					/* (Required FAT size) */
// 2165 			fs->n_fatent * 2 : fs->n_fatent * 3 / 2 + (fs->n_fatent & 1);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BNE.N    ??chk_mounted_28
        LDR      R0,[R5, #+24]
        LSLS     R0,R0,#+1
        B.N      ??chk_mounted_26
??chk_mounted_28:
        LDR      R1,[R5, #+24]
        MOVS     R0,#+3
        MULS     R1,R0,R1
        LDRB     R0,[R5, #+24]
        ANDS     R0,R0,#0x1
        ADDS     R0,R0,R1, LSR #+1
// 2166 	}
// 2167 	if (fs->fsize < (szbfat + (SS(fs) - 1)) / SS(fs))	/* (BPB_FATSz must not be less than required) */
??chk_mounted_26:
        LDR      R1,[R5, #+28]
        ADDW     R0,R0,#+511
        CMP      R1,R0, LSR #+9
        BCS.N    ??chk_mounted_29
// 2168 		return FR_NO_FILESYSTEM;
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2169 
// 2170 #if !_FS_READONLY
// 2171 	/* Initialize cluster allocation information */
// 2172 	fs->free_clust = 0xFFFFFFFF;
??chk_mounted_29:
        MOVS     R0,#-1
        STR      R0,[R5, #+16]
// 2173 	fs->last_clust = 0;
        MOVS     R0,#+0
        STR      R0,[R5, #+12]
// 2174 
// 2175 	/* Get fsinfo if available */
// 2176 	if (fmt == FS_FAT32) 
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+3
        BNE.N    ??chk_mounted_30
// 2177 	{
// 2178 	 	fs->fsi_flag = 0;
        MOVS     R0,#+0
        STRB     R0,[R5, #+5]
// 2179 		fs->fsi_sector = bsect + LD_WORD(fs->win+BPB_FSInfo);
        LDRB     R0,[R5, #+97]
        LDRB     R1,[R5, #+96]
        ORRS     R1,R1,R0, LSL #+8
        UXTAH    R0,R6,R1
        STR      R0,[R5, #+20]
// 2180 		if (disk_read(fs->drv, fs->win, fs->fsi_sector, 1) == RES_OK &&
// 2181 			LD_WORD(fs->win+BS_55AA) == 0xAA55 &&
// 2182 			LD_DWORD(fs->win+FSI_LeadSig) == 0x41615252 &&
// 2183 			LD_DWORD(fs->win+FSI_StrucSig) == 0x61417272) 
        MOVS     R3,#+1
        LDR      R2,[R5, #+20]
        ADDS     R1,R5,#+48
        LDRB     R0,[R5, #+1]
        BL       disk_read
        CMP      R0,#+0
        BNE.N    ??chk_mounted_30
        LDRB     R0,[R5, #+559]
        LDRB     R1,[R5, #+558]
        ORRS     R1,R1,R0, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVW     R0,#+43605
        CMP      R1,R0
        BNE.N    ??chk_mounted_30
        LDRB     R0,[R5, #+51]
        LDRB     R1,[R5, #+50]
        LSLS     R1,R1,#+16
        ORRS     R1,R1,R0, LSL #+24
        LDRB     R0,[R5, #+49]
        ORRS     R1,R1,R0, LSL #+8
        LDRB     R0,[R5, #+48]
        ORRS     R1,R0,R1
        LDR.N    R0,??DataTable4_3  ;; 0x41615252
        CMP      R1,R0
        BNE.N    ??chk_mounted_30
        LDRB     R0,[R5, #+535]
        LDRB     R1,[R5, #+534]
        LSLS     R1,R1,#+16
        ORRS     R1,R1,R0, LSL #+24
        LDRB     R0,[R5, #+533]
        ORRS     R1,R1,R0, LSL #+8
        LDRB     R0,[R5, #+532]
        ORRS     R1,R0,R1
        LDR.N    R0,??DataTable4_4  ;; 0x61417272
        CMP      R1,R0
        BNE.N    ??chk_mounted_30
// 2184 		{
// 2185 				fs->last_clust = LD_DWORD(fs->win+FSI_Nxt_Free);
        LDRB     R0,[R5, #+543]
        LDRB     R1,[R5, #+542]
        LSLS     R1,R1,#+16
        ORRS     R1,R1,R0, LSL #+24
        LDRB     R0,[R5, #+541]
        ORRS     R1,R1,R0, LSL #+8
        LDRB     R0,[R5, #+540]
        ORRS     R1,R0,R1
        STR      R1,[R5, #+12]
// 2186 				fs->free_clust = LD_DWORD(fs->win+FSI_Free_Count);
        LDRB     R0,[R5, #+539]
        LDRB     R1,[R5, #+538]
        LSLS     R1,R1,#+16
        ORRS     R1,R1,R0, LSL #+24
        LDRB     R0,[R5, #+537]
        ORRS     R1,R1,R0, LSL #+8
        LDRB     R0,[R5, #+536]
        ORRS     R1,R0,R1
        STR      R1,[R5, #+16]
// 2187 		}
// 2188 	}
// 2189 #endif
// 2190 	fs->fs_type = fmt;		/* FAT sub-type */
??chk_mounted_30:
        STRB     R4,[R5, #+0]
// 2191 	fs->id = ++Fsid;		/* File system mount ID */
        LDR.N    R0,??DataTable4_5
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable4_5
        STRH     R0,[R1, #+0]
        LDR.N    R0,??DataTable4_5
        LDRH     R0,[R0, #+0]
        STRH     R0,[R5, #+6]
// 2192 	fs->winsect = 0;		/* Invalidate sector cache */
        MOVS     R0,#+0
        STR      R0,[R5, #+44]
// 2193 	fs->wflag = 0;
        MOVS     R0,#+0
        STRB     R0,[R5, #+4]
// 2194 #if _FS_RPATH
// 2195 	fs->cdir = 0;			/* Current directory (root dir) */
// 2196 #endif
// 2197 #if _FS_SHARE				/* Clear file lock semaphores */
// 2198 	clear_lock(fs);
// 2199 #endif
// 2200 
// 2201 	return FR_OK;
        MOVS     R0,#+0
??chk_mounted_3:
        POP      {R1,R4-R7,PC}    ;; return
// 2202 }
// 2203 
// 2204 
// 2205 
// 2206 
// 2207 /*-----------------------------------------------------------------------*/
// 2208 /* Check if the file/dir object is valid or not                          */
// 2209 /*-----------------------------------------------------------------------*/
// 2210 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2211 static
// 2212 FRESULT validate (	/* FR_OK(0): The object is valid, !=0: Invalid */
// 2213 	FATFS *fs,		/* Pointer to the file system object */
// 2214 	WORD id			/* Member id of the target object to be checked */
// 2215 )
// 2216 {
validate:
        PUSH     {R7,LR}
// 2217 	if (!fs || !fs->fs_type || fs->id != id)
        CMP      R0,#+0
        BEQ.N    ??validate_0
        LDRB     R2,[R0, #+0]
        CMP      R2,#+0
        BEQ.N    ??validate_0
        LDRH     R2,[R0, #+6]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R2,R1
        BEQ.N    ??validate_1
// 2218 		return FR_INVALID_OBJECT;
??validate_0:
        MOVS     R0,#+9
        B.N      ??validate_2
// 2219 
// 2220 	ENTER_FF(fs);		/* Lock file system */
// 2221 
// 2222 	if (disk_status(fs->drv) & STA_NOINIT)
??validate_1:
        LDRB     R0,[R0, #+1]
        BL       disk_status
        LSLS     R0,R0,#+31
        BPL.N    ??validate_3
// 2223 		return FR_NOT_READY;
        MOVS     R0,#+3
        B.N      ??validate_2
// 2224 
// 2225 	return FR_OK;
??validate_3:
        MOVS     R0,#+0
??validate_2:
        POP      {R1,PC}          ;; return
// 2226 }
// 2227 
// 2228 
// 2229 
// 2230 
// 2231 /*--------------------------------------------------------------------------
// 2232 
// 2233    Public Functions
// 2234 
// 2235 --------------------------------------------------------------------------*/
// 2236 
// 2237 
// 2238 
// 2239 /*-----------------------------------------------------------------------*/
// 2240 /* Mount/Unmount a Logical Drive                                         */
// 2241 /*-----------------------------------------------------------------------*/
// 2242 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2243 FRESULT f_mount (
// 2244 	BYTE vol,		/* Logical drive number to be mounted/unmounted */
// 2245 	FATFS *fs		/* Pointer to new file system object (NULL for unmount)*/
// 2246 )
// 2247 {
// 2248 	FATFS *rfs;
// 2249 
// 2250 
// 2251 	if (vol >= _VOLUMES)			/* Check if the drive number is valid */
f_mount:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_mount_0
// 2252 		return FR_INVALID_DRIVE;
        MOVS     R0,#+11
        B.N      ??f_mount_1
// 2253 	rfs = FatFs[vol];				/* Get current fs object */
??f_mount_0:
        LDR.N    R2,??DataTable4_2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
// 2254 
// 2255 	if (rfs) {
        CMP      R2,#+0
        BEQ.N    ??f_mount_2
// 2256 #if _FS_SHARE
// 2257 		clear_lock(rfs);
// 2258 #endif
// 2259 #if _FS_REENTRANT					/* Discard sync object of the current volume */
// 2260 		if (!ff_del_syncobj(rfs->sobj)) return FR_INT_ERR;
// 2261 #endif
// 2262 		rfs->fs_type = 0;			/* Clear old fs object */
        MOVS     R3,#+0
        STRB     R3,[R2, #+0]
// 2263 	}
// 2264 
// 2265 	if (fs) {
??f_mount_2:
        CMP      R1,#+0
        BEQ.N    ??f_mount_3
// 2266 		fs->fs_type = 0;			/* Clear new fs object */
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
// 2267 #if _FS_REENTRANT					/* Create sync object for the new volume */
// 2268 		if (!ff_cre_syncobj(vol, &fs->sobj)) return FR_INT_ERR;
// 2269 #endif
// 2270 	}
// 2271 	FatFs[vol] = fs;				/* Register new fs object */
??f_mount_3:
        LDR.N    R2,??DataTable4_2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R1,[R2, R0, LSL #+2]
// 2272 
// 2273 	return FR_OK;
        MOVS     R0,#+0
??f_mount_1:
        BX       LR               ;; return
// 2274 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x544146

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     FatFs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     0x41615252

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     0x61417272

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     Fsid
// 2275 
// 2276 
// 2277 
// 2278 
// 2279 /*-----------------------------------------------------------------------*/
// 2280 /* Open or Create a File                                                 */
// 2281 /*-----------------------------------------------------------------------*/
// 2282 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2283 FRESULT f_open (
// 2284 	FIL *fp,			/* Pointer to the blank file object */
// 2285 	const TCHAR *path,	/* Pointer to the file name */
// 2286 	BYTE mode			/* Access mode and file open mode flags */
// 2287 )
// 2288 {
f_open:
        PUSH     {R1,R4-R9,LR}
        SUB      SP,SP,#+40
        MOVS     R7,R0
        MOV      R8,R2
// 2289 	FRESULT res;
// 2290 	DIR dj;
// 2291 	BYTE *dir;
// 2292 	DEF_NAMEBUF;
// 2293 
// 2294 
// 2295 	fp->fs = 0;			/* Clear file object */
        MOVS     R0,#+0
        STR      R0,[R7, #+0]
// 2296 
// 2297 #if !_FS_READONLY
// 2298 	mode &= FA_READ | FA_WRITE | FA_CREATE_ALWAYS | FA_OPEN_ALWAYS | FA_CREATE_NEW;
        ANDS     R8,R8,#0x1F
// 2299 	res = chk_mounted(&path, &dj.fs, (BYTE)(mode & ~FA_READ));
        ANDS     R2,R8,#0xFE
        MOV      R1,SP
        ADD      R0,SP,#+40
        BL       chk_mounted
        MOVS     R4,R0
// 2300 #else
// 2301 	mode &= FA_READ;
// 2302 	res = chk_mounted(&path, &dj.fs, 0);
// 2303 #endif
// 2304 	INIT_BUF(dj);
        ADD      R0,SP,#+28
        STR      R0,[SP, #+24]
// 2305 	if (res == FR_OK)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_open_0
// 2306 		res = follow_path(&dj, path);	/* Follow the file path */
        LDR      R1,[SP, #+40]
        MOV      R0,SP
        BL       follow_path
        MOVS     R4,R0
// 2307 	dir = dj.dir;
??f_open_0:
        LDR      R5,[SP, #+20]
// 2308 
// 2309 #if !_FS_READONLY	/* R/W configuration */
// 2310 	if (res == FR_OK) {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_open_1
// 2311 		if (!dir)	/* Current dir itself */
        CMP      R5,#+0
        BNE.N    ??f_open_1
// 2312 			res = FR_INVALID_NAME;
        MOVS     R4,#+6
// 2313 #if _FS_SHARE
// 2314 		else
// 2315 			res = chk_lock(&dj, (mode & ~FA_READ) ? 1 : 0);
// 2316 #endif
// 2317 	}
// 2318 	/* Create or Open a file */
// 2319 	if (mode & (FA_CREATE_ALWAYS | FA_OPEN_ALWAYS | FA_CREATE_NEW)) {
??f_open_1:
        TST      R8,#0x1C
        BEQ.N    ??f_open_2
// 2320 		DWORD dw, cl;
// 2321 
// 2322 		if (res != FR_OK) {					/* No file, create new */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??f_open_3
// 2323 			if (res == FR_NO_FILE)			/* There is no file to open, create a new entry */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+4
        BNE.N    ??f_open_4
// 2324 #if _FS_SHARE
// 2325 				res = enq_lock(dj.fs) ? dir_register(&dj) : FR_TOO_MANY_OPEN_FILES;
// 2326 #else
// 2327 				res = dir_register(&dj);
        MOV      R0,SP
        BL       dir_register
        MOVS     R4,R0
// 2328 #endif
// 2329 			mode |= FA_CREATE_ALWAYS;		/* File is created */
??f_open_4:
        ORRS     R8,R8,#0x8
// 2330 			dir = dj.dir;					/* New entry */
        LDR      R5,[SP, #+20]
        B.N      ??f_open_5
// 2331 		}
// 2332 		else {								/* Any object is already existing */
// 2333 			if (dir[DIR_Attr] & (AM_RDO | AM_DIR)) {	/* Cannot overwrite it (R/O or DIR) */
??f_open_3:
        LDRB     R0,[R5, #+11]
        TST      R0,#0x11
        BEQ.N    ??f_open_6
// 2334 				res = FR_DENIED;
        MOVS     R4,#+7
        B.N      ??f_open_5
// 2335 			} else {
// 2336 				if (mode & FA_CREATE_NEW)	/* Cannot create as new file */
??f_open_6:
        LSLS     R0,R8,#+29
        BPL.N    ??f_open_5
// 2337 					res = FR_EXIST;
        MOVS     R4,#+8
// 2338 			}
// 2339 		}
// 2340 		if (res == FR_OK && (mode & FA_CREATE_ALWAYS)) {	/* Truncate it if overwrite mode */
??f_open_5:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_open_7
        LSLS     R0,R8,#+28
        BPL.N    ??f_open_7
// 2341 			dw = get_fattime();					/* Created time */
        BL       get_fattime
        MOV      R9,R0
// 2342 			ST_DWORD(dir+DIR_CrtTime, dw);
        STRB     R9,[R5, #+14]
        MOV      R0,R9
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+15]
        MOV      R0,R9
        LSRS     R0,R0,#+16
        STRB     R0,[R5, #+16]
        LSRS     R9,R9,#+24
        STRB     R9,[R5, #+17]
// 2343 			dir[DIR_Attr] = 0;					/* Reset attribute */
        MOVS     R0,#+0
        STRB     R0,[R5, #+11]
// 2344 			ST_DWORD(dir+DIR_FileSize, 0);		/* size = 0 */
        MOVS     R0,#+0
        STRB     R0,[R5, #+28]
        MOVS     R0,#+0
        STRB     R0,[R5, #+29]
        MOVS     R0,#+0
        STRB     R0,[R5, #+30]
        MOVS     R0,#+0
        STRB     R0,[R5, #+31]
// 2345 			cl = LD_CLUST(dir);					/* Get start cluster */
        LDRB     R0,[R5, #+21]
        LDRB     R1,[R5, #+20]
        ORRS     R1,R1,R0, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRB     R0,[R5, #+27]
        LDRB     R6,[R5, #+26]
        ORRS     R6,R6,R0, LSL #+8
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        ORRS     R6,R6,R1, LSL #+16
// 2346 			ST_CLUST(dir, 0);					/* cluster = 0 */
        MOVS     R0,#+0
        STRB     R0,[R5, #+26]
        MOVS     R0,#+0
        STRB     R0,[R5, #+27]
        MOVS     R0,#+0
        STRB     R0,[R5, #+20]
        MOVS     R0,#+0
        STRB     R0,[R5, #+21]
// 2347 			dj.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
// 2348 			if (cl) {							/* Remove the cluster chain if exist */
        CMP      R6,#+0
        BEQ.N    ??f_open_7
// 2349 				dw = dj.fs->winsect;
        LDR      R0,[SP, #+0]
        LDR      R9,[R0, #+44]
// 2350 				res = remove_chain(dj.fs, cl);
        MOVS     R1,R6
        LDR      R0,[SP, #+0]
        BL       remove_chain
        MOVS     R4,R0
// 2351 				if (res == FR_OK) {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_open_7
// 2352 					dj.fs->last_clust = cl - 1;	/* Reuse the cluster hole */
        SUBS     R6,R6,#+1
        LDR      R0,[SP, #+0]
        STR      R6,[R0, #+12]
// 2353 					res = move_window(dj.fs, dw);
        MOV      R1,R9
        LDR      R0,[SP, #+0]
        BL       move_window
        MOVS     R4,R0
        B.N      ??f_open_7
// 2354 				}
// 2355 			}
// 2356 		}
// 2357 	}
// 2358 	else {	/* Open an existing file */
// 2359 		if (res == FR_OK) {						/* Follow succeeded */
??f_open_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_open_7
// 2360 			if (dir[DIR_Attr] & AM_DIR) {		/* It is a directory */
        LDRB     R0,[R5, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_open_8
// 2361 				res = FR_NO_FILE;
        MOVS     R4,#+4
        B.N      ??f_open_7
// 2362 			} else {
// 2363 				if ((mode & FA_WRITE) && (dir[DIR_Attr] & AM_RDO)) /* R/O violation */
??f_open_8:
        LSLS     R0,R8,#+30
        BPL.N    ??f_open_7
        LDRB     R0,[R5, #+11]
        LSLS     R0,R0,#+31
        BPL.N    ??f_open_7
// 2364 					res = FR_DENIED;
        MOVS     R4,#+7
// 2365 			}
// 2366 		}
// 2367 	}
// 2368 	if (res == FR_OK) {
??f_open_7:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_open_9
// 2369 		if (mode & FA_CREATE_ALWAYS)			/* Set file change flag if created or overwritten */
        LSLS     R0,R8,#+28
        BPL.N    ??f_open_10
// 2370 			mode |= FA__WRITTEN;
        ORRS     R8,R8,#0x20
// 2371 		fp->dir_sect = dj.fs->winsect;			/* Pointer to the directory entry */
??f_open_10:
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+44]
        STR      R0,[R7, #+28]
// 2372 		fp->dir_ptr = dir;
        STR      R5,[R7, #+32]
// 2373 #if _FS_SHARE
// 2374 		fp->lockid = inc_lock(&dj, (mode & ~FA_READ) ? 1 : 0);
// 2375 		if (!fp->lockid) res = FR_INT_ERR;
// 2376 #endif
// 2377 	}
// 2378 
// 2379 #else				/* R/O configuration */
// 2380 	if (res == FR_OK) {					/* Follow succeeded */
// 2381 		if (!dir) {						/* Current dir itself */
// 2382 			res = FR_INVALID_NAME;
// 2383 		} else {
// 2384 			if (dir[DIR_Attr] & AM_DIR)	/* It is a directory */
// 2385 				res = FR_NO_FILE;
// 2386 		}
// 2387 	}
// 2388 #endif
// 2389 	FREE_BUF();
// 2390 
// 2391 	if (res == FR_OK) {
??f_open_9:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_open_11
// 2392 		fp->flag = mode;					/* File access mode */
        STRB     R8,[R7, #+6]
// 2393 		fp->sclust = LD_CLUST(dir);			/* File start cluster */
        LDRB     R0,[R5, #+21]
        LDRB     R1,[R5, #+20]
        ORRS     R1,R1,R0, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRB     R0,[R5, #+27]
        LDRB     R2,[R5, #+26]
        ORRS     R2,R2,R0, LSL #+8
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ORRS     R2,R2,R1, LSL #+16
        STR      R2,[R7, #+16]
// 2394 		fp->fsize = LD_DWORD(dir+DIR_FileSize);	/* File size */
        LDRB     R0,[R5, #+31]
        LDRB     R1,[R5, #+30]
        LSLS     R1,R1,#+16
        ORRS     R1,R1,R0, LSL #+24
        LDRB     R0,[R5, #+29]
        ORRS     R1,R1,R0, LSL #+8
        LDRB     R0,[R5, #+28]
        ORRS     R1,R0,R1
        STR      R1,[R7, #+12]
// 2395 		fp->fptr = 0;						/* File pointer */
        MOVS     R0,#+0
        STR      R0,[R7, #+8]
// 2396 		fp->dsect = 0;
        MOVS     R0,#+0
        STR      R0,[R7, #+24]
// 2397 #if _USE_FASTSEEK
// 2398 		fp->cltbl = 0;						/* Normal seek mode */
// 2399 #endif
// 2400 		fp->fs = dj.fs; fp->id = dj.fs->id;	/* Validate file object */
        LDR      R0,[SP, #+0]
        STR      R0,[R7, #+0]
        LDR      R0,[SP, #+0]
        LDRH     R0,[R0, #+6]
        STRH     R0,[R7, #+4]
// 2401 	}
// 2402 
// 2403 	LEAVE_FF(dj.fs, res);
??f_open_11:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADD      SP,SP,#+44
        POP      {R4-R9,PC}       ;; return
// 2404 }
// 2405 
// 2406 
// 2407 
// 2408 
// 2409 /*-----------------------------------------------------------------------*/
// 2410 /* Read File                                                             */
// 2411 /*-----------------------------------------------------------------------*/
// 2412 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2413 FRESULT f_read (
// 2414 	FIL *fp, 		/* Pointer to the file object */
// 2415 	void *buff,		/* Pointer to data buffer */
// 2416 	UINT btr,		/* Number of bytes to read */
// 2417 	UINT *br		/* Pointer to number of bytes read */
// 2418 )
// 2419 {
f_read:
        PUSH     {R4-R10,LR}
        MOVS     R7,R0
        MOV      R9,R1
        MOVS     R4,R2
        MOV      R8,R3
// 2420 	FRESULT res;
// 2421 	DWORD clst, sect, remain;
// 2422 	UINT rcnt, cc;
// 2423 	BYTE csect, *rbuff = buff;
// 2424 
// 2425 
// 2426 	*br = 0;	/* Initialize byte counter */
        MOVS     R0,#+0
        STR      R0,[R8, #+0]
// 2427 
// 2428 	res = validate(fp->fs, fp->id);				/* Check validity */
        LDRH     R1,[R7, #+4]
        LDR      R0,[R7, #+0]
        BL       validate
// 2429 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_read_0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??f_read_1
// 2430 	if (fp->flag & FA__ERROR)					/* Aborted file? */
??f_read_0:
        LDRB     R0,[R7, #+6]
        LSLS     R0,R0,#+24
        BPL.N    ??f_read_2
// 2431 		LEAVE_FF(fp->fs, FR_INT_ERR);
        MOVS     R0,#+2
        B.N      ??f_read_1
// 2432 	if (!(fp->flag & FA_READ)) 					/* Check access mode */
??f_read_2:
        LDRB     R0,[R7, #+6]
        LSLS     R0,R0,#+31
        BMI.N    ??f_read_3
// 2433 		LEAVE_FF(fp->fs, FR_DENIED);
        MOVS     R0,#+7
        B.N      ??f_read_1
// 2434 	remain = fp->fsize - fp->fptr;
??f_read_3:
        LDR      R1,[R7, #+12]
        LDR      R0,[R7, #+8]
        SUBS     R0,R1,R0
// 2435 	if (btr > remain) btr = (UINT)remain;		/* Truncate btr by remaining bytes */
        CMP      R0,R4
        BCS.N    ??f_read_4
        MOVS     R4,R0
        B.N      ??f_read_4
// 2436 
// 2437 	for ( ;  btr;								/* Repeat until all data read */
// 2438 		rbuff += rcnt, fp->fptr += rcnt, *br += rcnt, btr -= rcnt) {
// 2439 		if ((fp->fptr % SS(fp->fs)) == 0) {		/* On the sector boundary? */
// 2440 			csect = (BYTE)(fp->fptr / SS(fp->fs) & (fp->fs->csize - 1));	/* Sector offset in the cluster */
// 2441 			if (!csect) {						/* On the cluster boundary? */
// 2442 				if (fp->fptr == 0) {			/* On the top of the file? */
// 2443 					clst = fp->sclust;			/* Follow from the origin */
// 2444 				} else {						/* Middle or end of the file */
// 2445 #if _USE_FASTSEEK
// 2446 					if (fp->cltbl)
// 2447 						clst = clmt_clust(fp, fp->fptr);	/* Get cluster# from the CLMT */
// 2448 					else
// 2449 #endif
// 2450 						clst = get_fat(fp->fs, fp->clust);	/* Follow cluster chain on the FAT */
// 2451 				}
// 2452 				if (clst < 2) ABORT(fp->fs, FR_INT_ERR);
// 2453 				if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
??f_read_5:
        CMN      R0,#+1
        BEQ.N    ??f_read_6
// 2454 				fp->clust = clst;				/* Update current cluster */
??f_read_7:
        STR      R0,[R7, #+20]
// 2455 			}
// 2456 			sect = clust2sect(fp->fs, fp->clust);	/* Get current sector */
??f_read_8:
        LDR      R1,[R7, #+20]
        LDR      R0,[R7, #+0]
        BL       clust2sect
        MOV      R10,R0
// 2457 			if (!sect) ABORT(fp->fs, FR_INT_ERR);
        CMP      R10,#+0
        BEQ.N    ??f_read_9
// 2458 			sect += csect;
??f_read_10:
        UXTAB    R10,R10,R5
// 2459 			cc = btr / SS(fp->fs);				/* When remaining bytes >= sector size, */
        MOVS     R6,R4
        LSRS     R6,R6,#+9
// 2460 			if (cc) {							/* Read maximum contiguous sectors directly */
        CMP      R6,#+0
        BEQ.N    ??f_read_11
// 2461 				if (csect + cc > fp->fs->csize)	/* Clip at cluster boundary */
        LDR      R0,[R7, #+0]
        LDRB     R0,[R0, #+2]
        UXTAB    R1,R6,R5
        CMP      R0,R1
        BCS.N    ??f_read_12
// 2462 					cc = fp->fs->csize - csect;
        LDR      R0,[R7, #+0]
        LDRB     R0,[R0, #+2]
        MOVS     R6,R5
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        SUBS     R6,R0,R6
// 2463 				if (disk_read(fp->fs->drv, rbuff, sect, (BYTE)cc) != RES_OK)
??f_read_12:
        MOVS     R3,R6
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOV      R2,R10
        MOV      R1,R9
        LDR      R0,[R7, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_read
        CMP      R0,#+0
        BNE.N    ??f_read_13
// 2464 					ABORT(fp->fs, FR_DISK_ERR);
// 2465 #if !_FS_READONLY && _FS_MINIMIZE <= 2			/* Replace one of the read sectors with cached data if it contains a dirty sector */
// 2466 #if _FS_TINY
// 2467 				if (fp->fs->wflag && fp->fs->winsect - sect < cc)
// 2468 					mem_cpy(rbuff + ((fp->fs->winsect - sect) * SS(fp->fs)), fp->fs->win, SS(fp->fs));
// 2469 #else
// 2470 				if ((fp->flag & FA__DIRTY) && fp->dsect - sect < cc)
??f_read_14:
        LDRB     R0,[R7, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_read_15
        LDR      R0,[R7, #+24]
        SUBS     R0,R0,R10
        CMP      R0,R6
        BCS.N    ??f_read_15
// 2471 					mem_cpy(rbuff + ((fp->dsect - sect) * SS(fp->fs)), fp->buf, SS(fp->fs));
        MOV      R2,#+512
        ADDS     R1,R7,#+36
        LDR      R0,[R7, #+24]
        SUBS     R10,R0,R10
        MOV      R0,#+512
        MUL      R10,R0,R10
        ADD      R0,R9,R10
        BL       mem_cpy
// 2472 #endif
// 2473 #endif
// 2474 				rcnt = SS(fp->fs) * cc;			/* Number of bytes transferred */
??f_read_15:
        MOV      R0,#+512
        MULS     R6,R0,R6
// 2475 				continue;
??f_read_16:
        ADD      R9,R9,R6
        LDR      R0,[R7, #+8]
        ADDS     R0,R6,R0
        STR      R0,[R7, #+8]
        LDR      R0,[R8, #+0]
        ADDS     R0,R6,R0
        STR      R0,[R8, #+0]
        SUBS     R4,R4,R6
??f_read_4:
        CMP      R4,#+0
        BEQ.N    ??f_read_17
        LDR      R0,[R7, #+8]
        LSLS     R0,R0,#+23
        BNE.N    ??f_read_18
        LDR      R5,[R7, #+8]
        LSRS     R5,R5,#+9
        LDR      R0,[R7, #+0]
        LDRB     R0,[R0, #+2]
        SUBS     R0,R0,#+1
        ANDS     R5,R0,R5
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_read_8
        LDR      R0,[R7, #+8]
        CMP      R0,#+0
        BNE.N    ??f_read_19
        LDR      R0,[R7, #+16]
        B.N      ??f_read_20
??f_read_19:
        LDR      R1,[R7, #+20]
        LDR      R0,[R7, #+0]
        BL       get_fat
??f_read_20:
        CMP      R0,#+2
        BCS.N    ??f_read_5
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+2
        B.N      ??f_read_1
??f_read_6:
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
??f_read_9:
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+2
        B.N      ??f_read_1
??f_read_13:
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
// 2476 			}
// 2477 #if !_FS_TINY
// 2478 			if (fp->dsect != sect) {			/* Load data sector if not in cache */
??f_read_11:
        LDR      R0,[R7, #+24]
        CMP      R0,R10
        BEQ.N    ??f_read_21
// 2479 #if !_FS_READONLY
// 2480 				if (fp->flag & FA__DIRTY) {		/* Write-back dirty sector cache */
        LDRB     R0,[R7, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_read_22
// 2481 					if (disk_write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
        MOVS     R3,#+1
        LDR      R2,[R7, #+24]
        ADDS     R1,R7,#+36
        LDR      R0,[R7, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_write
        CMP      R0,#+0
        BNE.N    ??f_read_23
// 2482 						ABORT(fp->fs, FR_DISK_ERR);
// 2483 					fp->flag &= ~FA__DIRTY;
??f_read_24:
        LDRB     R0,[R7, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R7, #+6]
// 2484 				}
// 2485 #endif
// 2486 				if (disk_read(fp->fs->drv, fp->buf, sect, 1) != RES_OK)	/* Fill sector cache */
??f_read_22:
        MOVS     R3,#+1
        MOV      R2,R10
        ADDS     R1,R7,#+36
        LDR      R0,[R7, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_read
        CMP      R0,#+0
        BNE.N    ??f_read_25
// 2487 					ABORT(fp->fs, FR_DISK_ERR);
// 2488 			}
// 2489 #endif
// 2490 			fp->dsect = sect;
??f_read_21:
        STR      R10,[R7, #+24]
// 2491 		}
// 2492 		rcnt = SS(fp->fs) - (fp->fptr % SS(fp->fs));	/* Get partial sector data from sector buffer */
??f_read_18:
        LDR      R6,[R7, #+8]
        LSLS     R6,R6,#+23       ;; ZeroExtS R6,R6,#+23,#+23
        LSRS     R6,R6,#+23
        RSBS     R6,R6,#+512
// 2493 		if (rcnt > btr) rcnt = btr;
        CMP      R4,R6
        BCS.N    ??f_read_26
        MOVS     R6,R4
// 2494 #if _FS_TINY
// 2495 		if (move_window(fp->fs, fp->dsect))		/* Move sector window */
// 2496 			ABORT(fp->fs, FR_DISK_ERR);
// 2497 		mem_cpy(rbuff, &fp->fs->win[fp->fptr % SS(fp->fs)], rcnt);	/* Pick partial sector */
// 2498 #else
// 2499 		mem_cpy(rbuff, &fp->buf[fp->fptr % SS(fp->fs)], rcnt);	/* Pick partial sector */
??f_read_26:
        MOVS     R2,R6
        LDR      R0,[R7, #+8]
        LSLS     R0,R0,#+23       ;; ZeroExtS R0,R0,#+23,#+23
        LSRS     R0,R0,#+23
        ADD      R0,R7,R0
        ADDS     R1,R0,#+36
        MOV      R0,R9
        BL       mem_cpy
        B.N      ??f_read_16
??f_read_23:
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
??f_read_25:
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
// 2500 #endif
// 2501 	}
// 2502 
// 2503 	LEAVE_FF(fp->fs, FR_OK);
??f_read_17:
        MOVS     R0,#+0
??f_read_1:
        POP      {R4-R10,PC}      ;; return
// 2504 }
// 2505 
// 2506 
// 2507 
// 2508 
// 2509 #if !_FS_READONLY
// 2510 /*-----------------------------------------------------------------------*/
// 2511 /* Write File                                                            */
// 2512 /*-----------------------------------------------------------------------*/
// 2513 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2514 FRESULT f_write (
// 2515 	FIL *fp,			/* Pointer to the file object */
// 2516 	const void *buff,	/* Pointer to the data to be written */
// 2517 	UINT btw,			/* Number of bytes to write */
// 2518 	UINT *bw			/* Pointer to number of bytes written */
// 2519 )
// 2520 {
f_write:
        PUSH     {R4-R10,LR}
        MOVS     R6,R0
        MOV      R8,R1
        MOVS     R4,R2
        MOVS     R7,R3
// 2521 	FRESULT res;
// 2522 	DWORD clst, sect;
// 2523 	UINT wcnt, cc;
// 2524 	const BYTE *wbuff = buff;
// 2525 	BYTE csect;
// 2526 
// 2527 
// 2528 	*bw = 0;	/* Initialize byte counter */
        MOVS     R0,#+0
        STR      R0,[R7, #+0]
// 2529 
// 2530 	res = validate(fp->fs, fp->id);			/* Check validity */
        LDRH     R1,[R6, #+4]
        LDR      R0,[R6, #+0]
        BL       validate
// 2531 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_write_0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??f_write_1
// 2532 	if (fp->flag & FA__ERROR)				/* Aborted file? */
??f_write_0:
        LDRB     R0,[R6, #+6]
        LSLS     R0,R0,#+24
        BPL.N    ??f_write_2
// 2533 		LEAVE_FF(fp->fs, FR_INT_ERR);
        MOVS     R0,#+2
        B.N      ??f_write_1
// 2534 	if (!(fp->flag & FA_WRITE))				/* Check access mode */
??f_write_2:
        LDRB     R0,[R6, #+6]
        LSLS     R0,R0,#+30
        BMI.N    ??f_write_3
// 2535 		LEAVE_FF(fp->fs, FR_DENIED);
        MOVS     R0,#+7
        B.N      ??f_write_1
// 2536 	if ((DWORD)(fp->fsize + btw) < fp->fsize) btw = 0;	/* File size cannot reach 4GB */
??f_write_3:
        LDR      R0,[R6, #+12]
        ADDS     R0,R4,R0
        LDR      R1,[R6, #+12]
        CMP      R0,R1
        BCS.N    ??f_write_4
        MOVS     R4,#+0
        B.N      ??f_write_4
// 2537 
// 2538 	for ( ;  btw;							/* Repeat until all data written */
// 2539 		wbuff += wcnt, fp->fptr += wcnt, *bw += wcnt, btw -= wcnt) {
// 2540 		if ((fp->fptr % SS(fp->fs)) == 0) {	/* On the sector boundary? */
// 2541 			csect = (BYTE)(fp->fptr / SS(fp->fs) & (fp->fs->csize - 1));	/* Sector offset in the cluster */
// 2542 			if (!csect) {					/* On the cluster boundary? */
// 2543 				if (fp->fptr == 0) {		/* On the top of the file? */
// 2544 					clst = fp->sclust;		/* Follow from the origin */
// 2545 					if (clst == 0)			/* When no cluster is allocated, */
// 2546 						fp->sclust = clst = create_chain(fp->fs, 0);	/* Create a new cluster chain */
// 2547 				} else {					/* Middle or end of the file */
// 2548 #if _USE_FASTSEEK
// 2549 					if (fp->cltbl)
// 2550 						clst = clmt_clust(fp, fp->fptr);	/* Get cluster# from the CLMT */
// 2551 					else
// 2552 #endif
// 2553 						clst = create_chain(fp->fs, fp->clust);	/* Follow or stretch cluster chain on the FAT */
// 2554 				}
// 2555 				if (clst == 0) break;		/* Could not allocate a new cluster (disk full) */
// 2556 				if (clst == 1) ABORT(fp->fs, FR_INT_ERR);
??f_write_5:
        CMP      R0,#+1
        BEQ.W    ??f_write_6
// 2557 				if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
??f_write_7:
        CMN      R0,#+1
        BEQ.W    ??f_write_8
// 2558 				fp->clust = clst;			/* Update current cluster */
??f_write_9:
        STR      R0,[R6, #+20]
// 2559 			}
// 2560 #if _FS_TINY
// 2561 			if (fp->fs->winsect == fp->dsect && move_window(fp->fs, 0))	/* Write-back sector cache */
// 2562 				ABORT(fp->fs, FR_DISK_ERR);
// 2563 #else
// 2564 			if (fp->flag & FA__DIRTY) {		/* Write-back sector cache */
??f_write_10:
        LDRB     R0,[R6, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_write_11
// 2565 				if (disk_write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
        MOVS     R3,#+1
        LDR      R2,[R6, #+24]
        ADDS     R1,R6,#+36
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_write
        CMP      R0,#+0
        BNE.W    ??f_write_12
// 2566 					ABORT(fp->fs, FR_DISK_ERR);
// 2567 				fp->flag &= ~FA__DIRTY;
??f_write_13:
        LDRB     R0,[R6, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R6, #+6]
// 2568 			}
// 2569 #endif
// 2570 			sect = clust2sect(fp->fs, fp->clust);	/* Get current sector */
??f_write_11:
        LDR      R1,[R6, #+20]
        LDR      R0,[R6, #+0]
        BL       clust2sect
        MOV      R10,R0
// 2571 			if (!sect) ABORT(fp->fs, FR_INT_ERR);
        CMP      R10,#+0
        BEQ.W    ??f_write_14
// 2572 			sect += csect;
??f_write_15:
        UXTAB    R10,R10,R5
// 2573 			cc = btw / SS(fp->fs);			/* When remaining bytes >= sector size, */
        MOV      R9,R4
        LSRS     R9,R9,#+9
// 2574 			if (cc) {						/* Write maximum contiguous sectors directly */
        CMP      R9,#+0
        BEQ.W    ??f_write_16
// 2575 				if (csect + cc > fp->fs->csize)	/* Clip at cluster boundary */
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+2]
        UXTAB    R1,R9,R5
        CMP      R0,R1
        BCS.N    ??f_write_17
// 2576 					cc = fp->fs->csize - csect;
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+2]
        MOV      R9,R5
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        SUBS     R9,R0,R9
// 2577 				if (disk_write(fp->fs->drv, wbuff, sect, (BYTE)cc) != RES_OK)
??f_write_17:
        MOV      R3,R9
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOV      R2,R10
        MOV      R1,R8
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_write
        CMP      R0,#+0
        BNE.N    ??f_write_18
// 2578 					ABORT(fp->fs, FR_DISK_ERR);
// 2579 #if _FS_TINY
// 2580 				if (fp->fs->winsect - sect < cc) {	/* Refill sector cache if it gets invalidated by the direct write */
// 2581 					mem_cpy(fp->fs->win, wbuff + ((fp->fs->winsect - sect) * SS(fp->fs)), SS(fp->fs));
// 2582 					fp->fs->wflag = 0;
// 2583 				}
// 2584 #else
// 2585 				if (fp->dsect - sect < cc) { /* Refill sector cache if it gets invalidated by the direct write */
??f_write_19:
        LDR      R0,[R6, #+24]
        SUBS     R0,R0,R10
        CMP      R0,R9
        BCS.N    ??f_write_20
// 2586 					mem_cpy(fp->buf, wbuff + ((fp->dsect - sect) * SS(fp->fs)), SS(fp->fs));
        MOV      R2,#+512
        LDR      R0,[R6, #+24]
        SUBS     R10,R0,R10
        MOV      R0,#+512
        MUL      R10,R0,R10
        ADD      R1,R8,R10
        ADDS     R0,R6,#+36
        BL       mem_cpy
// 2587 					fp->flag &= ~FA__DIRTY;
        LDRB     R0,[R6, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R6, #+6]
// 2588 				}
// 2589 #endif
// 2590 				wcnt = SS(fp->fs) * cc;		/* Number of bytes transferred */
??f_write_20:
        MOV      R0,#+512
        MUL      R9,R0,R9
// 2591 				continue;
??f_write_21:
        ADD      R8,R8,R9
        LDR      R0,[R6, #+8]
        ADDS     R0,R9,R0
        STR      R0,[R6, #+8]
        LDR      R0,[R7, #+0]
        ADDS     R0,R9,R0
        STR      R0,[R7, #+0]
        SUBS     R4,R4,R9
??f_write_4:
        CMP      R4,#+0
        BEQ.N    ??f_write_22
        LDR      R0,[R6, #+8]
        LSLS     R0,R0,#+23
        BNE.N    ??f_write_23
        LDR      R5,[R6, #+8]
        LSRS     R5,R5,#+9
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+2]
        SUBS     R0,R0,#+1
        ANDS     R5,R0,R5
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_write_10
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??f_write_24
        LDR      R0,[R6, #+16]
        CMP      R0,#+0
        BNE.N    ??f_write_25
        MOVS     R1,#+0
        LDR      R0,[R6, #+0]
        BL       create_chain
        STR      R0,[R6, #+16]
        B.N      ??f_write_25
??f_write_24:
        LDR      R1,[R6, #+20]
        LDR      R0,[R6, #+0]
        BL       create_chain
??f_write_25:
        CMP      R0,#+0
        BNE.W    ??f_write_5
// 2592 			}
// 2593 #if _FS_TINY
// 2594 			if (fp->fptr >= fp->fsize) {	/* Avoid silly cache filling at growing edge */
// 2595 				if (move_window(fp->fs, 0)) ABORT(fp->fs, FR_DISK_ERR);
// 2596 				fp->fs->winsect = sect;
// 2597 			}
// 2598 #else
// 2599 			if (fp->dsect != sect) {		/* Fill sector cache with file data */
// 2600 				if (fp->fptr < fp->fsize &&
// 2601 					disk_read(fp->fs->drv, fp->buf, sect, 1) != RES_OK)
// 2602 						ABORT(fp->fs, FR_DISK_ERR);
// 2603 			}
// 2604 #endif
// 2605 			fp->dsect = sect;
// 2606 		}
// 2607 		wcnt = SS(fp->fs) - (fp->fptr % SS(fp->fs));/* Put partial sector into file I/O buffer */
// 2608 		if (wcnt > btw) wcnt = btw;
// 2609 #if _FS_TINY
// 2610 		if (move_window(fp->fs, fp->dsect))	/* Move sector window */
// 2611 			ABORT(fp->fs, FR_DISK_ERR);
// 2612 		mem_cpy(&fp->fs->win[fp->fptr % SS(fp->fs)], wbuff, wcnt);	/* Fit partial sector */
// 2613 		fp->fs->wflag = 1;
// 2614 #else
// 2615 		mem_cpy(&fp->buf[fp->fptr % SS(fp->fs)], wbuff, wcnt);	/* Fit partial sector */
// 2616 		fp->flag |= FA__DIRTY;
// 2617 #endif
// 2618 	}
// 2619 
// 2620 	if (fp->fptr > fp->fsize) fp->fsize = fp->fptr;	/* Update file size if needed */
??f_write_22:
        LDR      R0,[R6, #+12]
        LDR      R1,[R6, #+8]
        CMP      R0,R1
        BCS.N    ??f_write_26
        LDR      R0,[R6, #+8]
        STR      R0,[R6, #+12]
// 2621 	fp->flag |= FA__WRITTEN;						/* Set file change flag */
??f_write_26:
        LDRB     R0,[R6, #+6]
        ORRS     R0,R0,#0x20
        STRB     R0,[R6, #+6]
// 2622 
// 2623 	LEAVE_FF(fp->fs, FR_OK);
        MOVS     R0,#+0
??f_write_1:
        POP      {R4-R10,PC}      ;; return
??f_write_6:
        LDRB     R0,[R6, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R6, #+6]
        MOVS     R0,#+2
        B.N      ??f_write_1
??f_write_8:
        LDRB     R0,[R6, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R6, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
??f_write_12:
        LDRB     R0,[R6, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R6, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
??f_write_14:
        LDRB     R0,[R6, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R6, #+6]
        MOVS     R0,#+2
        B.N      ??f_write_1
??f_write_18:
        LDRB     R0,[R6, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R6, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
??f_write_16:
        LDR      R0,[R6, #+24]
        CMP      R0,R10
        BEQ.N    ??f_write_27
        LDR      R0,[R6, #+8]
        LDR      R1,[R6, #+12]
        CMP      R0,R1
        BCS.N    ??f_write_27
        MOVS     R3,#+1
        MOV      R2,R10
        ADDS     R1,R6,#+36
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_read
        CMP      R0,#+0
        BNE.N    ??f_write_28
??f_write_27:
        STR      R10,[R6, #+24]
??f_write_23:
        LDR      R9,[R6, #+8]
        LSLS     R9,R9,#+23       ;; ZeroExtS R9,R9,#+23,#+23
        LSRS     R9,R9,#+23
        RSBS     R9,R9,#+512
        CMP      R4,R9
        BCS.N    ??f_write_29
        MOV      R9,R4
??f_write_29:
        MOV      R2,R9
        MOV      R1,R8
        LDR      R0,[R6, #+8]
        LSLS     R0,R0,#+23       ;; ZeroExtS R0,R0,#+23,#+23
        LSRS     R0,R0,#+23
        ADD      R0,R6,R0
        ADDS     R0,R0,#+36
        BL       mem_cpy
        LDRB     R0,[R6, #+6]
        ORRS     R0,R0,#0x40
        STRB     R0,[R6, #+6]
        B.N      ??f_write_21
??f_write_28:
        LDRB     R0,[R6, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R6, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
// 2624 }
// 2625 
// 2626 
// 2627 
// 2628 
// 2629 /*-----------------------------------------------------------------------*/
// 2630 /* Synchronize the File Object                                           */
// 2631 /*-----------------------------------------------------------------------*/
// 2632 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2633 FRESULT f_sync (
// 2634 	FIL *fp		/* Pointer to the file object */
// 2635 )
// 2636 {
f_sync:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
// 2637 	FRESULT res;
// 2638 	DWORD tim;
// 2639 	BYTE *dir;
// 2640 
// 2641 
// 2642 	res = validate(fp->fs, fp->id);		/* Check validity of the object */
        LDRH     R1,[R4, #+4]
        LDR      R0,[R4, #+0]
        BL       validate
// 2643 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_sync_0
// 2644 		if (fp->flag & FA__WRITTEN) {	/* Has the file been written? */
        LDRB     R1,[R4, #+6]
        LSLS     R1,R1,#+26
        BPL.N    ??f_sync_0
// 2645 #if !_FS_TINY	/* Write-back dirty buffer */
// 2646 			if (fp->flag & FA__DIRTY) {
        LDRB     R0,[R4, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_sync_1
// 2647 				if (disk_write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
        MOVS     R3,#+1
        LDR      R2,[R4, #+24]
        ADDS     R1,R4,#+36
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_sync_2
// 2648 					LEAVE_FF(fp->fs, FR_DISK_ERR);
        MOVS     R0,#+1
        B.N      ??f_sync_3
// 2649 				fp->flag &= ~FA__DIRTY;
??f_sync_2:
        LDRB     R0,[R4, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R4, #+6]
// 2650 			}
// 2651 #endif
// 2652 			/* Update the directory entry */
// 2653 			res = move_window(fp->fs, fp->dir_sect);
??f_sync_1:
        LDR      R1,[R4, #+28]
        LDR      R0,[R4, #+0]
        BL       move_window
// 2654 			if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_sync_0
// 2655 				dir = fp->dir_ptr;
        LDR      R5,[R4, #+32]
// 2656 				dir[DIR_Attr] |= AM_ARC;					/* Set archive bit */
        LDRB     R0,[R5, #+11]
        ORRS     R0,R0,#0x20
        STRB     R0,[R5, #+11]
// 2657 				ST_DWORD(dir+DIR_FileSize, fp->fsize);		/* Update file size */
        LDR      R0,[R4, #+12]
        STRB     R0,[R5, #+28]
        LDR      R0,[R4, #+12]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+29]
        LDR      R0,[R4, #+12]
        LSRS     R0,R0,#+16
        STRB     R0,[R5, #+30]
        LDR      R0,[R4, #+12]
        LSRS     R0,R0,#+24
        STRB     R0,[R5, #+31]
// 2658 				ST_CLUST(dir, fp->sclust);					/* Update start cluster */
        LDR      R0,[R4, #+16]
        STRB     R0,[R5, #+26]
        LDR      R0,[R4, #+16]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+27]
        LDR      R0,[R4, #+16]
        LSRS     R0,R0,#+16
        STRB     R0,[R5, #+20]
        LDR      R0,[R4, #+16]
        LSRS     R0,R0,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+21]
// 2659 				tim = get_fattime();						/* Update updated time */
        BL       get_fattime
// 2660 				ST_DWORD(dir+DIR_WrtTime, tim);
        STRB     R0,[R5, #+22]
        MOVS     R1,R0
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R5, #+23]
        MOVS     R1,R0
        LSRS     R1,R1,#+16
        STRB     R1,[R5, #+24]
        LSRS     R0,R0,#+24
        STRB     R0,[R5, #+25]
// 2661 				fp->flag &= ~FA__WRITTEN;
        LDRB     R0,[R4, #+6]
        ANDS     R0,R0,#0xDF
        STRB     R0,[R4, #+6]
// 2662 				fp->fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[R4, #+0]
        STRB     R0,[R1, #+4]
// 2663 				res = sync(fp->fs);
        LDR      R0,[R4, #+0]
        BL       sync
// 2664 			}
// 2665 		}
// 2666 	}
// 2667 
// 2668 	LEAVE_FF(fp->fs, res);
??f_sync_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_sync_3:
        POP      {R1,R4,R5,PC}    ;; return
// 2669 }
// 2670 
// 2671 #endif /* !_FS_READONLY */
// 2672 
// 2673 
// 2674 
// 2675 
// 2676 /*-----------------------------------------------------------------------*/
// 2677 /* Close File                                                            */
// 2678 /*-----------------------------------------------------------------------*/
// 2679 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2680 FRESULT f_close (
// 2681 	FIL *fp		/* Pointer to the file object to be closed */
// 2682 )
// 2683 {
f_close:
        PUSH     {R4,LR}
        MOVS     R4,R0
// 2684 	FRESULT res;
// 2685 
// 2686 #if _FS_READONLY
// 2687 	FATFS *fs = fp->fs;
// 2688 	res = validate(fs, fp->id);
// 2689 	if (res == FR_OK) fp->fs = 0;	/* Discard file object */
// 2690 	LEAVE_FF(fs, res);
// 2691 
// 2692 #else
// 2693 	res = f_sync(fp);		/* Flush cached data */
        MOVS     R0,R4
        BL       f_sync
// 2694 #if _FS_SHARE
// 2695 	if (res == FR_OK) {		/* Decrement open counter */
// 2696 #if _FS_REENTRANT
// 2697 		res = validate(fp->fs, fp->id);
// 2698 		if (res == FR_OK) {
// 2699 			res = dec_lock(fp->lockid);	
// 2700 			unlock_fs(fp->fs, FR_OK);
// 2701 		}
// 2702 #else
// 2703 		res = dec_lock(fp->lockid);
// 2704 #endif
// 2705 	}
// 2706 #endif
// 2707 	if (res == FR_OK) fp->fs = 0;	/* Discard file object */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_close_0
        MOVS     R1,#+0
        STR      R1,[R4, #+0]
// 2708 	return res;
??f_close_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4,PC}          ;; return
// 2709 #endif
// 2710 }
// 2711 
// 2712 
// 2713 
// 2714 
// 2715 /*-----------------------------------------------------------------------*/
// 2716 /* Current Drive/Directory Handlings                                     */
// 2717 /*-----------------------------------------------------------------------*/
// 2718 
// 2719 #if _FS_RPATH >= 1
// 2720 
// 2721 FRESULT f_chdrive (
// 2722 	BYTE drv		/* Drive number */
// 2723 )
// 2724 {
// 2725 	if (drv >= _VOLUMES) return FR_INVALID_DRIVE;
// 2726 
// 2727 	CurrVol = drv;
// 2728 
// 2729 	return FR_OK;
// 2730 }
// 2731 
// 2732 
// 2733 
// 2734 FRESULT f_chdir (
// 2735 	const TCHAR *path	/* Pointer to the directory path */
// 2736 )
// 2737 {
// 2738 	FRESULT res;
// 2739 	DIR dj;
// 2740 	DEF_NAMEBUF;
// 2741 
// 2742 
// 2743 	res = chk_mounted(&path, &dj.fs, 0);
// 2744 	if (res == FR_OK) {
// 2745 		INIT_BUF(dj);
// 2746 		res = follow_path(&dj, path);		/* Follow the path */
// 2747 		FREE_BUF();
// 2748 		if (res == FR_OK) {					/* Follow completed */
// 2749 			if (!dj.dir) {
// 2750 				dj.fs->cdir = dj.sclust;	/* Start directory itself */
// 2751 			} else {
// 2752 				if (dj.dir[DIR_Attr] & AM_DIR)	/* Reached to the directory */
// 2753 					dj.fs->cdir = LD_CLUST(dj.dir);
// 2754 				else
// 2755 					res = FR_NO_PATH;		/* Reached but a file */
// 2756 			}
// 2757 		}
// 2758 		if (res == FR_NO_FILE) res = FR_NO_PATH;
// 2759 	}
// 2760 
// 2761 	LEAVE_FF(dj.fs, res);
// 2762 }
// 2763 
// 2764 
// 2765 #if _FS_RPATH >= 2
// 2766 FRESULT f_getcwd (
// 2767 	TCHAR *path,	/* Pointer to the directory path */
// 2768 	UINT sz_path	/* Size of path */
// 2769 )
// 2770 {
// 2771 	FRESULT res;
// 2772 	DIR dj;
// 2773 	UINT i, n;
// 2774 	DWORD ccl;
// 2775 	TCHAR *tp;
// 2776 	FILINFO fno;
// 2777 	DEF_NAMEBUF;
// 2778 
// 2779 
// 2780 	*path = 0;
// 2781 	res = chk_mounted((const TCHAR**)&path, &dj.fs, 0);	/* Get current volume */
// 2782 	if (res == FR_OK) {
// 2783 		INIT_BUF(dj);
// 2784 		i = sz_path;		/* Bottom of buffer (dir stack base) */
// 2785 		dj.sclust = dj.fs->cdir;			/* Start to follow upper dir from current dir */
// 2786 		while ((ccl = dj.sclust) != 0) {	/* Repeat while current dir is a sub-dir */
// 2787 			res = dir_sdi(&dj, 1);			/* Get parent dir */
// 2788 			if (res != FR_OK) break;
// 2789 			res = dir_read(&dj);
// 2790 			if (res != FR_OK) break;
// 2791 			dj.sclust = LD_CLUST(dj.dir);	/* Goto parent dir */
// 2792 			res = dir_sdi(&dj, 0);
// 2793 			if (res != FR_OK) break;
// 2794 			do {							/* Find the entry links to the child dir */
// 2795 				res = dir_read(&dj);
// 2796 				if (res != FR_OK) break;
// 2797 				if (ccl == LD_CLUST(dj.dir)) break;	/* Found the entry */
// 2798 				res = dir_next(&dj, 0);	
// 2799 			} while (res == FR_OK);
// 2800 			if (res == FR_NO_FILE) res = FR_INT_ERR;/* It cannot be 'not found'. */
// 2801 			if (res != FR_OK) break;
// 2802 #if _USE_LFN
// 2803 			fno.lfname = path;
// 2804 			fno.lfsize = i;
// 2805 #endif
// 2806 			get_fileinfo(&dj, &fno);		/* Get the dir name and push it to the buffer */
// 2807 			tp = fno.fname;
// 2808 			if (_USE_LFN && *path) tp = path;
// 2809 			for (n = 0; tp[n]; n++) ;
// 2810 			if (i < n + 3) {
// 2811 				res = FR_NOT_ENOUGH_CORE; break;
// 2812 			}
// 2813 			while (n) path[--i] = tp[--n];
// 2814 			path[--i] = '/';
// 2815 		}
// 2816 		tp = path;
// 2817 		if (res == FR_OK) {
// 2818 			*tp++ = '0' + CurrVol;			/* Put drive number */
// 2819 			*tp++ = ':';
// 2820 			if (i == sz_path) {				/* Root-dir */
// 2821 				*tp++ = '/';
// 2822 			} else {						/* Sub-dir */
// 2823 				do		/* Add stacked path str */
// 2824 					*tp++ = path[i++];
// 2825 				while (i < sz_path);
// 2826 			}
// 2827 		}
// 2828 		*tp = 0;
// 2829 		FREE_BUF();
// 2830 	}
// 2831 
// 2832 	LEAVE_FF(dj.fs, res);
// 2833 }
// 2834 #endif /* _FS_RPATH >= 2 */
// 2835 #endif /* _FS_RPATH >= 1 */
// 2836 
// 2837 
// 2838 
// 2839 #if _FS_MINIMIZE <= 2
// 2840 /*-----------------------------------------------------------------------*/
// 2841 /* Seek File R/W Pointer                                                 */
// 2842 /*-----------------------------------------------------------------------*/
// 2843 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2844 FRESULT f_lseek (
// 2845 	FIL *fp,		/* Pointer to the file object */
// 2846 	DWORD ofs		/* File pointer from top of file */
// 2847 )
// 2848 {
f_lseek:
        PUSH     {R4-R8,LR}
        MOVS     R7,R0
        MOVS     R6,R1
// 2849 	FRESULT res;
// 2850 
// 2851 
// 2852 	res = validate(fp->fs, fp->id);		/* Check validity of the object */
        LDRH     R1,[R7, #+4]
        LDR      R0,[R7, #+0]
        BL       validate
        MOVS     R4,R0
// 2853 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??f_lseek_0
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??f_lseek_1
// 2854 	if (fp->flag & FA__ERROR)			/* Check abort flag */
??f_lseek_0:
        LDRB     R0,[R7, #+6]
        LSLS     R0,R0,#+24
        BPL.N    ??f_lseek_2
// 2855 		LEAVE_FF(fp->fs, FR_INT_ERR);
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2856 
// 2857 #if _USE_FASTSEEK
// 2858 	if (fp->cltbl) 
// 2859 	{	/* Fast seek */
// 2860 		DWORD cl, pcl, ncl, tcl, dsc, tlen, ulen, *tbl;
// 2861 
// 2862 		if (ofs == CREATE_LINKMAP) 
// 2863 		{	/* Create CLMT */
// 2864 			tbl = fp->cltbl;
// 2865 			tlen = *tbl++; ulen = 2;	/* Given table size and required table size */
// 2866 			cl = fp->sclust;			/* Top of the chain */
// 2867 			if (cl) 
// 2868 			{
// 2869 				do 
// 2870 				{
// 2871 					/* Get a fragment */
// 2872 					tcl = cl; ncl = 0; ulen += 2;	/* Top, length and used items */
// 2873 					do 
// 2874 					{
// 2875 						pcl = cl; ncl++;
// 2876 						cl = get_fat(fp->fs, cl);
// 2877 						if (cl <= 1) ABORT(fp->fs, FR_INT_ERR);
// 2878 						if (cl == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
// 2879 					}while (cl == pcl + 1);
// 2880 					if (ulen <= tlen) 
// 2881 					{		/* Store the length and top of the fragment */
// 2882 						*tbl++ = ncl; *tbl++ = tcl;
// 2883 					}
// 2884 				}while (cl < fp->fs->n_fatent);	/* Repeat until end of chain */
// 2885 			}
// 2886 			*fp->cltbl = ulen;	/* Number of items used */
// 2887 			if (ulen <= tlen)
// 2888 				*tbl = 0;		/* Terminate table */
// 2889 			else
// 2890 				res = FR_NOT_ENOUGH_CORE;	/* Given table size is smaller than required */
// 2891 
// 2892 		} 
// 2893 		else 
// 2894 		{						/* Fast seek */
// 2895 			if (ofs > fp->fsize)		/* Clip offset at the file size */
// 2896 				ofs = fp->fsize;
// 2897 			fp->fptr = ofs;				/* Set file pointer */
// 2898 			if (ofs) 
// 2899 			{
// 2900 				fp->clust = clmt_clust(fp, ofs - 1);
// 2901 				dsc = clust2sect(fp->fs, fp->clust);
// 2902 				if (!dsc) ABORT(fp->fs, FR_INT_ERR);
// 2903 				dsc += (ofs - 1) / SS(fp->fs) & (fp->fs->csize - 1);
// 2904 				if (fp->fptr % SS(fp->fs) && dsc != fp->dsect) 
// 2905 				{	/* Refill sector cache if needed */
// 2906 #if !_FS_TINY
// 2907 #if !_FS_READONLY
// 2908 					if (fp->flag & FA__DIRTY) 
// 2909 					{		/* Write-back dirty sector cache */
// 2910 						if (disk_write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
// 2911 							ABORT(fp->fs, FR_DISK_ERR);
// 2912 						fp->flag &= ~FA__DIRTY;
// 2913 					}
// 2914 #endif
// 2915 					if (disk_read(fp->fs->drv, fp->buf, dsc, 1) != RES_OK)	/* Load current sector */
// 2916 						ABORT(fp->fs, FR_DISK_ERR);
// 2917 #endif
// 2918 					fp->dsect = dsc;
// 2919 				}
// 2920 			}
// 2921 		}
// 2922 	} else
// 2923 #endif
// 2924 
// 2925 	/* Normal Seek */
// 2926 	{
// 2927 		DWORD clst, bcs, nsect, ifptr;
// 2928 
// 2929 		if (ofs > fp->fsize					/* In read-only mode, clip offset with the file size */
// 2930 #if !_FS_READONLY
// 2931 			 && !(fp->flag & FA_WRITE)
// 2932 #endif
// 2933 			) ofs = fp->fsize;
??f_lseek_2:
        LDR      R0,[R7, #+12]
        CMP      R0,R6
        BCS.N    ??f_lseek_3
        LDRB     R0,[R7, #+6]
        LSLS     R0,R0,#+30
        BMI.N    ??f_lseek_3
        LDR      R6,[R7, #+12]
// 2934 
// 2935 		ifptr = fp->fptr;
??f_lseek_3:
        LDR      R0,[R7, #+8]
// 2936 		fp->fptr = nsect = 0;
        MOVS     R5,#+0
        STR      R5,[R7, #+8]
// 2937 		if (ofs) 
        CMP      R6,#+0
        BEQ.N    ??f_lseek_4
// 2938 		{
// 2939 			bcs = (DWORD)fp->fs->csize * SS(fp->fs);	/* Cluster size (byte) */
        LDR      R1,[R7, #+0]
        LDRB     R8,[R1, #+2]
        MOV      R1,#+512
        MUL      R8,R1,R8
// 2940 			if (ifptr > 0 &&
// 2941 				(ofs - 1) / bcs >= (ifptr - 1) / bcs) 
        CMP      R0,#+0
        BEQ.N    ??f_lseek_5
        SUBS     R1,R0,#+1
        UDIV     R1,R1,R8
        SUBS     R2,R6,#+1
        UDIV     R2,R2,R8
        CMP      R2,R1
        BCC.N    ??f_lseek_5
// 2942 			{	/* When seek to same or following cluster, */
// 2943 				fp->fptr = (ifptr - 1) & ~(bcs - 1);	/* start from the current cluster */
        SUBS     R0,R0,#+1
        SUBS     R1,R8,#+1
        BICS     R0,R0,R1
        STR      R0,[R7, #+8]
// 2944 				ofs -= fp->fptr;
        LDR      R0,[R7, #+8]
        SUBS     R6,R6,R0
// 2945 				clst = fp->clust;
        LDR      R0,[R7, #+20]
        B.N      ??f_lseek_6
// 2946 			} 
// 2947 			else 
// 2948 			{									/* When seek to back cluster, */
// 2949 				clst = fp->sclust;						/* start from the first cluster */
??f_lseek_5:
        LDR      R0,[R7, #+16]
// 2950 #if !_FS_READONLY
// 2951 				if (clst == 0) 
        CMP      R0,#+0
        BNE.N    ??f_lseek_7
// 2952 				{						/* If no cluster chain, create a new chain */
// 2953 					clst = create_chain(fp->fs, 0);
        MOVS     R1,#+0
        LDR      R0,[R7, #+0]
        BL       create_chain
// 2954 					if (clst == 1) ABORT(fp->fs, FR_INT_ERR);
        CMP      R0,#+1
        BNE.N    ??f_lseek_8
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2955 					if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
??f_lseek_8:
        CMN      R0,#+1
        BNE.N    ??f_lseek_9
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 2956 					fp->sclust = clst;
??f_lseek_9:
        STR      R0,[R7, #+16]
// 2957 				}
// 2958 #endif
// 2959 				fp->clust = clst;
??f_lseek_7:
        STR      R0,[R7, #+20]
// 2960 			}
// 2961 			if (clst != 0) 
??f_lseek_6:
        CMP      R0,#+0
        BNE.N    ??f_lseek_10
        B.N      ??f_lseek_4
// 2962 			{
// 2963 				while (ofs > bcs) 
// 2964 				{						/* Cluster following loop */
// 2965 #if !_FS_READONLY
// 2966 					if (fp->flag & FA_WRITE) 
// 2967 					{			/* Check if in write mode or not */
// 2968 						clst = create_chain(fp->fs, clst);	/* Force stretch if in write mode */
// 2969 						if (clst == 0) 
// 2970 						{				/* When disk gets full, clip file size */
// 2971 							ofs = bcs; break;
// 2972 						}
// 2973 					} 
// 2974 					else
// 2975 #endif
// 2976 						clst = get_fat(fp->fs, clst);	/* Follow cluster chain if not in write mode */
// 2977 					if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
// 2978 					if (clst <= 1 || clst >= fp->fs->n_fatent) ABORT(fp->fs, FR_INT_ERR);
??f_lseek_11:
        CMP      R0,#+2
        BCC.N    ??f_lseek_12
        LDR      R1,[R7, #+0]
        LDR      R1,[R1, #+24]
        CMP      R0,R1
        BCS.N    ??f_lseek_12
// 2979 					fp->clust = clst;
??f_lseek_13:
        STR      R0,[R7, #+20]
// 2980 					fp->fptr += bcs;
        LDR      R1,[R7, #+8]
        ADDS     R1,R8,R1
        STR      R1,[R7, #+8]
// 2981 					ofs -= bcs;
        SUBS     R6,R6,R8
??f_lseek_10:
        CMP      R8,R6
        BCS.N    ??f_lseek_14
        LDRB     R1,[R7, #+6]
        LSLS     R1,R1,#+30
        BPL.N    ??f_lseek_15
        MOVS     R1,R0
        LDR      R0,[R7, #+0]
        BL       create_chain
        CMP      R0,#+0
        BNE.N    ??f_lseek_16
        MOV      R6,R8
// 2982 				}
// 2983 				fp->fptr += ofs;
??f_lseek_14:
        LDR      R1,[R7, #+8]
        ADDS     R1,R6,R1
        STR      R1,[R7, #+8]
// 2984 				if (ofs % SS(fp->fs)) 
        LSLS     R1,R6,#+23
        BEQ.N    ??f_lseek_4
// 2985 				{
// 2986 					nsect = clust2sect(fp->fs, clst);	/* Current sector */
        MOVS     R1,R0
        LDR      R0,[R7, #+0]
        BL       clust2sect
        MOVS     R5,R0
// 2987 					if (!nsect) ABORT(fp->fs, FR_INT_ERR);
        CMP      R5,#+0
        BNE.N    ??f_lseek_17
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
??f_lseek_15:
        MOVS     R1,R0
        LDR      R0,[R7, #+0]
        BL       get_fat
??f_lseek_16:
        CMN      R0,#+1
        BNE.N    ??f_lseek_11
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
??f_lseek_12:
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2988 					nsect += ofs / SS(fp->fs);
??f_lseek_17:
        ADDS     R5,R5,R6, LSR #+9
// 2989 				}
// 2990 			}
// 2991 		}
// 2992 		if (fp->fptr % SS(fp->fs) && nsect != fp->dsect) 
??f_lseek_4:
        LDR      R0,[R7, #+8]
        LSLS     R0,R0,#+23
        BEQ.N    ??f_lseek_18
        LDR      R0,[R7, #+24]
        CMP      R5,R0
        BEQ.N    ??f_lseek_18
// 2993 		{	/* Fill sector cache if needed */
// 2994 #if !_FS_TINY
// 2995 #if !_FS_READONLY
// 2996 			if (fp->flag & FA__DIRTY) 
        LDRB     R0,[R7, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_lseek_19
// 2997 			{			/* Write-back dirty sector cache */
// 2998 				if (disk_write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
        MOVS     R3,#+1
        LDR      R2,[R7, #+24]
        ADDS     R1,R7,#+36
        LDR      R0,[R7, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_lseek_20
// 2999 					ABORT(fp->fs, FR_DISK_ERR);
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 3000 				fp->flag &= ~FA__DIRTY;
??f_lseek_20:
        LDRB     R0,[R7, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R7, #+6]
// 3001 			}
// 3002 #endif
// 3003 			if (disk_read(fp->fs->drv, fp->buf, nsect, 1) != RES_OK)	/* Fill sector cache */
??f_lseek_19:
        MOVS     R3,#+1
        MOVS     R2,R5
        ADDS     R1,R7,#+36
        LDR      R0,[R7, #+0]
        LDRB     R0,[R0, #+1]
        BL       disk_read
        CMP      R0,#+0
        BEQ.N    ??f_lseek_21
// 3004 				ABORT(fp->fs, FR_DISK_ERR);
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R7, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 3005 #endif
// 3006 			fp->dsect = nsect;
??f_lseek_21:
        STR      R5,[R7, #+24]
// 3007 		}
// 3008 #if !_FS_READONLY
// 3009 		if (fp->fptr > fp->fsize) 
??f_lseek_18:
        LDR      R0,[R7, #+12]
        LDR      R1,[R7, #+8]
        CMP      R0,R1
        BCS.N    ??f_lseek_22
// 3010 		{			/* Set file change flag if the file size is extended */
// 3011 			fp->fsize = fp->fptr;
        LDR      R0,[R7, #+8]
        STR      R0,[R7, #+12]
// 3012 			fp->flag |= FA__WRITTEN;
        LDRB     R0,[R7, #+6]
        ORRS     R0,R0,#0x20
        STRB     R0,[R7, #+6]
// 3013 		}
// 3014 #endif
// 3015 	}
// 3016 
// 3017 	LEAVE_FF(fp->fs, res);
??f_lseek_22:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_lseek_1:
        POP      {R4-R8,PC}       ;; return
// 3018 }
// 3019 
// 3020 
// 3021 
// 3022 #if _FS_MINIMIZE <= 1
// 3023 /*-----------------------------------------------------------------------*/
// 3024 /* Create a Directroy Object                                             */
// 3025 /*-----------------------------------------------------------------------*/
// 3026 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3027 FRESULT f_opendir (
// 3028 	DIR *dj,			/* Pointer to directory object to create */
// 3029 	const TCHAR *path	/* Pointer to the directory path */
// 3030 )
// 3031 {
f_opendir:
        PUSH     {R1,R4,LR}
        SUB      SP,SP,#+12
        MOVS     R4,R0
// 3032 	FRESULT res;
// 3033 	DEF_NAMEBUF;
// 3034 
// 3035 
// 3036 	res = chk_mounted(&path, &dj->fs, 0);
        MOVS     R2,#+0
        MOVS     R1,R4
        ADD      R0,SP,#+12
        BL       chk_mounted
// 3037 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_opendir_0
// 3038 		INIT_BUF(*dj);
        MOV      R0,SP
        STR      R0,[R4, #+24]
// 3039 		res = follow_path(dj, path);			/* Follow the path to the directory */
        LDR      R1,[SP, #+12]
        MOVS     R0,R4
        BL       follow_path
// 3040 		FREE_BUF();
// 3041 		if (res == FR_OK) {						/* Follow completed */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_opendir_1
// 3042 			if (dj->dir) {						/* It is not the root dir */
        LDR      R1,[R4, #+20]
        CMP      R1,#+0
        BEQ.N    ??f_opendir_2
// 3043 				if (dj->dir[DIR_Attr] & AM_DIR) {	/* The object is a directory */
        LDR      R1,[R4, #+20]
        LDRB     R1,[R1, #+11]
        LSLS     R1,R1,#+27
        BPL.N    ??f_opendir_3
// 3044 					dj->sclust = LD_CLUST(dj->dir);
        LDR      R1,[R4, #+20]
        LDRB     R1,[R1, #+21]
        LDR      R2,[R4, #+20]
        LDRB     R2,[R2, #+20]
        ORRS     R2,R2,R1, LSL #+8
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDR      R1,[R4, #+20]
        LDRB     R1,[R1, #+27]
        LDR      R3,[R4, #+20]
        LDRB     R3,[R3, #+26]
        ORRS     R3,R3,R1, LSL #+8
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        ORRS     R3,R3,R2, LSL #+16
        STR      R3,[R4, #+8]
        B.N      ??f_opendir_2
// 3045 				} else {						/* The object is not a directory */
// 3046 					res = FR_NO_PATH;
??f_opendir_3:
        MOVS     R0,#+5
// 3047 				}
// 3048 			}
// 3049 			if (res == FR_OK) {
??f_opendir_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_opendir_1
// 3050 				dj->id = dj->fs->id;
        LDR      R0,[R4, #+0]
        LDRH     R0,[R0, #+6]
        STRH     R0,[R4, #+4]
// 3051 				res = dir_sdi(dj, 0);			/* Rewind dir */
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_sdi
// 3052 			}
// 3053 		}
// 3054 		if (res == FR_NO_FILE) res = FR_NO_PATH;
??f_opendir_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BNE.N    ??f_opendir_0
        MOVS     R0,#+5
// 3055 	}
// 3056 
// 3057 	LEAVE_FF(dj->fs, res);
??f_opendir_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADD      SP,SP,#+16
        POP      {R4,PC}          ;; return
// 3058 }
// 3059 
// 3060 
// 3061 
// 3062 
// 3063 /*-----------------------------------------------------------------------*/
// 3064 /* Read Directory Entry in Sequense                                      */
// 3065 /*-----------------------------------------------------------------------*/
// 3066 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3067 FRESULT f_readdir (
// 3068 	DIR *dj,			/* Pointer to the open directory object */
// 3069 	FILINFO *fno		/* Pointer to file information to return */
// 3070 )
// 3071 {
f_readdir:
        PUSH     {R1-R5,LR}
        MOVS     R5,R0
        MOVS     R4,R1
// 3072 	FRESULT res;
// 3073 	DEF_NAMEBUF;
// 3074 
// 3075 
// 3076 	res = validate(dj->fs, dj->id);			/* Check validity of the object */
        LDRH     R1,[R5, #+4]
        LDR      R0,[R5, #+0]
        BL       validate
// 3077 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_readdir_0
// 3078 		if (!fno) {
        CMP      R4,#+0
        BNE.N    ??f_readdir_1
// 3079 			res = dir_sdi(dj, 0);			/* Rewind the directory object */
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       dir_sdi
        B.N      ??f_readdir_0
// 3080 		} else {
// 3081 			INIT_BUF(*dj);
??f_readdir_1:
        MOV      R0,SP
        STR      R0,[R5, #+24]
// 3082 			res = dir_read(dj);				/* Read an directory item */
        MOVS     R0,R5
        BL       dir_read
// 3083 			if (res == FR_NO_FILE) {		/* Reached end of dir */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BNE.N    ??f_readdir_2
// 3084 				dj->sect = 0;
        MOVS     R0,#+0
        STR      R0,[R5, #+16]
// 3085 				res = FR_OK;
        MOVS     R0,#+0
// 3086 			}
// 3087 			if (res == FR_OK) {				/* A valid entry is found */
??f_readdir_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_readdir_0
// 3088 				get_fileinfo(dj, fno);		/* Get the object information */
        MOVS     R1,R4
        MOVS     R0,R5
        BL       get_fileinfo
// 3089 				res = dir_next(dj, 0);		/* Increment index for next */
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       dir_next
// 3090 				if (res == FR_NO_FILE) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BNE.N    ??f_readdir_0
// 3091 					dj->sect = 0;
        MOVS     R0,#+0
        STR      R0,[R5, #+16]
// 3092 					res = FR_OK;
        MOVS     R0,#+0
// 3093 				}
// 3094 			}
// 3095 			FREE_BUF();
// 3096 		}
// 3097 	}
// 3098 
// 3099 	LEAVE_FF(dj->fs, res);
??f_readdir_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1-R5,PC}       ;; return
// 3100 }
// 3101 
// 3102 
// 3103 
// 3104 #if _FS_MINIMIZE == 0
// 3105 /*-----------------------------------------------------------------------*/
// 3106 /* Get File Status                                                       */
// 3107 /*-----------------------------------------------------------------------*/
// 3108 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3109 FRESULT f_stat (
// 3110 	const TCHAR *path,	/* Pointer to the file path */
// 3111 	FILINFO *fno		/* Pointer to file information to return */
// 3112 )
// 3113 {
f_stat:
        PUSH     {R0,R4,R5,LR}
        SUB      SP,SP,#+40
        MOVS     R5,R1
// 3114 	FRESULT res;
// 3115 	DIR dj;
// 3116 	DEF_NAMEBUF;
// 3117 
// 3118 
// 3119 	res = chk_mounted(&path, &dj.fs, 0);
        MOVS     R2,#+0
        ADD      R1,SP,#+12
        ADD      R0,SP,#+40
        BL       chk_mounted
        MOVS     R4,R0
// 3120 	if (res == FR_OK) {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_stat_0
// 3121 		INIT_BUF(dj);
        MOV      R0,SP
        STR      R0,[SP, #+36]
// 3122 		res = follow_path(&dj, path);	/* Follow the file path */
        LDR      R1,[SP, #+40]
        ADD      R0,SP,#+12
        BL       follow_path
        MOVS     R4,R0
// 3123 		if (res == FR_OK) {				/* Follow completed */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_stat_0
// 3124 			if (dj.dir)		/* Found an object */
        LDR      R0,[SP, #+32]
        CMP      R0,#+0
        BEQ.N    ??f_stat_1
// 3125 				get_fileinfo(&dj, fno);
        MOVS     R1,R5
        ADD      R0,SP,#+12
        BL       get_fileinfo
        B.N      ??f_stat_0
// 3126 			else			/* It is root dir */
// 3127 				res = FR_INVALID_NAME;
??f_stat_1:
        MOVS     R4,#+6
// 3128 		}
// 3129 		FREE_BUF();
// 3130 	}
// 3131 
// 3132 	LEAVE_FF(dj.fs, res);
??f_stat_0:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADD      SP,SP,#+44
        POP      {R4,R5,PC}       ;; return
// 3133 }
// 3134 
// 3135 
// 3136 
// 3137 #if !_FS_READONLY
// 3138 /*-----------------------------------------------------------------------*/
// 3139 /* Get Number of Free Clusters                                           */
// 3140 /*-----------------------------------------------------------------------*/
// 3141 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3142 FRESULT f_getfree (
// 3143 	const TCHAR *path,	/* Pointer to the logical drive number (root dir) */
// 3144 	DWORD *nclst,		/* Pointer to the variable to return number of free clusters */
// 3145 	FATFS **fatfs		/* Pointer to pointer to corresponding file system object to return */
// 3146 )
// 3147 {
f_getfree:
        PUSH     {R0,R4-R10,LR}
        SUB      SP,SP,#+4
        MOVS     R6,R1
        MOVS     R7,R2
// 3148 	FRESULT res;
// 3149 	DWORD n, clst, sect, stat;
// 3150 	UINT i;
// 3151 	BYTE fat, *p;
// 3152 
// 3153 
// 3154 	/* Get drive number */
// 3155 	res = chk_mounted(&path, fatfs, 0);
        MOVS     R2,#+0
        MOVS     R1,R7
        ADD      R0,SP,#+4
        BL       chk_mounted
        MOVS     R4,R0
// 3156 	if (res == FR_OK) {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_getfree_0
// 3157 		/* If free_clust is valid, return it without full cluster scan */
// 3158 		if ((*fatfs)->free_clust <= (*fatfs)->n_fatent - 2) {
        LDR      R0,[R7, #+0]
        LDR      R0,[R0, #+24]
        SUBS     R0,R0,#+2
        LDR      R1,[R7, #+0]
        LDR      R1,[R1, #+16]
        CMP      R0,R1
        BCC.N    ??f_getfree_1
// 3159 			*nclst = (*fatfs)->free_clust;
        LDR      R0,[R7, #+0]
        LDR      R0,[R0, #+16]
        STR      R0,[R6, #+0]
        B.N      ??f_getfree_0
// 3160 		} else {
// 3161 			/* Get number of free clusters */
// 3162 			fat = (*fatfs)->fs_type;
??f_getfree_1:
        LDR      R0,[R7, #+0]
        LDRB     R8,[R0, #+0]
// 3163 			n = 0;
        MOVS     R9,#+0
// 3164 			if (fat == FS_FAT12) {
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+1
        BNE.N    ??f_getfree_2
// 3165 				clst = 2;
        MOVS     R5,#+2
// 3166 				do {
// 3167 					stat = get_fat(*fatfs, clst);
??f_getfree_3:
        MOVS     R1,R5
        LDR      R0,[R7, #+0]
        BL       get_fat
// 3168 					if (stat == 0xFFFFFFFF) { res = FR_DISK_ERR; break; }
        CMN      R0,#+1
        BEQ.N    ??f_getfree_4
// 3169 					if (stat == 1) { res = FR_INT_ERR; break; }
??f_getfree_5:
        CMP      R0,#+1
        BEQ.N    ??f_getfree_6
// 3170 					if (stat == 0) n++;
??f_getfree_7:
        CMP      R0,#+0
        BNE.N    ??f_getfree_8
        ADDS     R9,R9,#+1
// 3171 				} while (++clst < (*fatfs)->n_fatent);
??f_getfree_8:
        ADDS     R5,R5,#+1
        LDR      R0,[R7, #+0]
        LDR      R0,[R0, #+24]
        CMP      R5,R0
        BCC.N    ??f_getfree_3
        B.N      ??f_getfree_9
??f_getfree_4:
        MOVS     R4,#+1
        B.N      ??f_getfree_9
??f_getfree_6:
        MOVS     R4,#+2
        B.N      ??f_getfree_9
// 3172 			} else {
// 3173 				clst = (*fatfs)->n_fatent;
??f_getfree_2:
        LDR      R0,[R7, #+0]
        LDR      R5,[R0, #+24]
// 3174 				sect = (*fatfs)->fatbase;
        LDR      R0,[R7, #+0]
        LDR      R10,[R0, #+32]
// 3175 				i = 0; p = 0;
        MOVS     R0,#+0
        MOVS     R2,#+0
// 3176 				do {
// 3177 					if (!i) {
??f_getfree_10:
        CMP      R0,#+0
        BNE.N    ??f_getfree_11
// 3178 						res = move_window(*fatfs, sect++);
        MOV      R1,R10
        LDR      R0,[R7, #+0]
        BL       move_window
        MOVS     R4,R0
        ADDS     R10,R10,#+1
// 3179 						if (res != FR_OK) break;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_getfree_12
// 3180 						p = (*fatfs)->win;
??f_getfree_13:
        LDR      R0,[R7, #+0]
        ADDS     R2,R0,#+48
// 3181 						i = SS(*fatfs);
        MOV      R0,#+512
// 3182 					}
// 3183 					if (fat == FS_FAT16) {
??f_getfree_11:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+2
        BNE.N    ??f_getfree_14
// 3184 						if (LD_WORD(p) == 0) n++;
        LDRB     R3,[R2, #+1]
        LDRB     R1,[R2, #+0]
        ORRS     R1,R1,R3, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+0
        BNE.N    ??f_getfree_15
        ADDS     R9,R9,#+1
// 3185 						p += 2; i -= 2;
??f_getfree_15:
        ADDS     R2,R2,#+2
        SUBS     R0,R0,#+2
        B.N      ??f_getfree_16
// 3186 					} else {
??f_getfree_12:
        B.N      ??f_getfree_9
// 3187 						if ((LD_DWORD(p) & 0x0FFFFFFF) == 0) n++;
??f_getfree_14:
        LDRB     R1,[R2, #+3]
        LDRB     R3,[R2, #+2]
        LSLS     R3,R3,#+16
        ORRS     R3,R3,R1, LSL #+24
        LDRB     R1,[R2, #+1]
        ORRS     R3,R3,R1, LSL #+8
        LDRB     R1,[R2, #+0]
        ORRS     R3,R1,R3
        LSLS     R1,R3,#+4
        BNE.N    ??f_getfree_17
        ADDS     R9,R9,#+1
// 3188 						p += 4; i -= 4;
??f_getfree_17:
        ADDS     R2,R2,#+4
        SUBS     R0,R0,#+4
// 3189 					}
// 3190 				} while (--clst);
??f_getfree_16:
        SUBS     R5,R5,#+1
        CMP      R5,#+0
        BNE.N    ??f_getfree_10
// 3191 			}
// 3192 			(*fatfs)->free_clust = n;
??f_getfree_9:
        LDR      R0,[R7, #+0]
        STR      R9,[R0, #+16]
// 3193 			if (fat == FS_FAT32) (*fatfs)->fsi_flag = 1;
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+3
        BNE.N    ??f_getfree_18
        MOVS     R0,#+1
        LDR      R1,[R7, #+0]
        STRB     R0,[R1, #+5]
// 3194 			*nclst = n;
??f_getfree_18:
        STR      R9,[R6, #+0]
// 3195 		}
// 3196 	}
// 3197 	LEAVE_FF(*fatfs, res);
??f_getfree_0:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R2,R4-R10,PC}  ;; return
// 3198 }
// 3199 
// 3200 
// 3201 
// 3202 
// 3203 /*-----------------------------------------------------------------------*/
// 3204 /* Truncate File                                                         */
// 3205 /*-----------------------------------------------------------------------*/
// 3206 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3207 FRESULT f_truncate (
// 3208 	FIL *fp		/* Pointer to the file object */
// 3209 )
// 3210 {
f_truncate:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
// 3211 	FRESULT res;
// 3212 	DWORD ncl;
// 3213 
// 3214 
// 3215 	res = validate(fp->fs, fp->id);		/* Check validity of the object */
        LDRH     R1,[R4, #+4]
        LDR      R0,[R4, #+0]
        BL       validate
// 3216 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_0
// 3217 		if (fp->flag & FA__ERROR) {			/* Check abort flag */
        LDRB     R1,[R4, #+6]
        LSLS     R1,R1,#+24
        BPL.N    ??f_truncate_1
// 3218 			res = FR_INT_ERR;
        MOVS     R0,#+2
        B.N      ??f_truncate_0
// 3219 		} else {
// 3220 			if (!(fp->flag & FA_WRITE))		/* Check access mode */
??f_truncate_1:
        LDRB     R1,[R4, #+6]
        LSLS     R1,R1,#+30
        BMI.N    ??f_truncate_0
// 3221 				res = FR_DENIED;
        MOVS     R0,#+7
// 3222 		}
// 3223 	}
// 3224 	if (res == FR_OK) {
??f_truncate_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_2
// 3225 		if (fp->fsize > fp->fptr) {
        LDR      R1,[R4, #+8]
        LDR      R2,[R4, #+12]
        CMP      R1,R2
        BCS.N    ??f_truncate_3
// 3226 			fp->fsize = fp->fptr;	/* Set file size to current R/W point */
        LDR      R0,[R4, #+8]
        STR      R0,[R4, #+12]
// 3227 			fp->flag |= FA__WRITTEN;
        LDRB     R0,[R4, #+6]
        ORRS     R0,R0,#0x20
        STRB     R0,[R4, #+6]
// 3228 			if (fp->fptr == 0) {	/* When set file size to zero, remove entire cluster chain */
        LDR      R0,[R4, #+8]
        CMP      R0,#+0
        BNE.N    ??f_truncate_4
// 3229 				res = remove_chain(fp->fs, fp->sclust);
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       remove_chain
// 3230 				fp->sclust = 0;
        MOVS     R1,#+0
        STR      R1,[R4, #+16]
        B.N      ??f_truncate_3
// 3231 			} else {				/* When truncate a part of the file, remove remaining clusters */
// 3232 				ncl = get_fat(fp->fs, fp->clust);
??f_truncate_4:
        LDR      R1,[R4, #+20]
        LDR      R0,[R4, #+0]
        BL       get_fat
        MOVS     R5,R0
// 3233 				res = FR_OK;
        MOVS     R0,#+0
// 3234 				if (ncl == 0xFFFFFFFF) res = FR_DISK_ERR;
        CMN      R5,#+1
        BNE.N    ??f_truncate_5
        MOVS     R0,#+1
// 3235 				if (ncl == 1) res = FR_INT_ERR;
??f_truncate_5:
        CMP      R5,#+1
        BNE.N    ??f_truncate_6
        MOVS     R0,#+2
// 3236 				if (res == FR_OK && ncl < fp->fs->n_fatent) {
??f_truncate_6:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_3
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+24]
        CMP      R5,R1
        BCS.N    ??f_truncate_3
// 3237 					res = put_fat(fp->fs, fp->clust, 0x0FFFFFFF);
        MVNS     R2,#-268435456
        LDR      R1,[R4, #+20]
        LDR      R0,[R4, #+0]
        BL       put_fat
// 3238 					if (res == FR_OK) res = remove_chain(fp->fs, ncl);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_3
        MOVS     R1,R5
        LDR      R0,[R4, #+0]
        BL       remove_chain
// 3239 				}
// 3240 			}
// 3241 		}
// 3242 		if (res != FR_OK) fp->flag |= FA__ERROR;
??f_truncate_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_truncate_2
        LDRB     R1,[R4, #+6]
        ORRS     R1,R1,#0x80
        STRB     R1,[R4, #+6]
// 3243 	}
// 3244 
// 3245 	LEAVE_FF(fp->fs, res);
??f_truncate_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
// 3246 }
// 3247 
// 3248 
// 3249 
// 3250 
// 3251 /*-----------------------------------------------------------------------*/
// 3252 /* Delete a File or Directory                                            */
// 3253 /*-----------------------------------------------------------------------*/
// 3254 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3255 FRESULT f_unlink (
// 3256 	const TCHAR *path		/* Pointer to the file or directory path */
// 3257 )
// 3258 {
f_unlink:
        PUSH     {R0,R4,LR}
        SUB      SP,SP,#+68
// 3259 	FRESULT res;
// 3260 	DIR dj, sdj;
// 3261 	BYTE *dir;
// 3262 	DWORD dclst;
// 3263 	DEF_NAMEBUF;
// 3264 
// 3265 
// 3266 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        MOV      R1,SP
        ADD      R0,SP,#+68
        BL       chk_mounted
// 3267 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_unlink_0
// 3268 		INIT_BUF(dj);
        ADD      R0,SP,#+28
        STR      R0,[SP, #+24]
// 3269 		res = follow_path(&dj, path);		/* Follow the file path */
        LDR      R1,[SP, #+68]
        MOV      R0,SP
        BL       follow_path
// 3270 		if (_FS_RPATH && res == FR_OK && (dj.fn[NS] & NS_DOT))
// 3271 			res = FR_INVALID_NAME;			/* Cannot remove dot entry */
// 3272 #if _FS_SHARE
// 3273 		if (res == FR_OK) res = chk_lock(&dj, 2);	/* Cannot remove open file */
// 3274 #endif
// 3275 		if (res == FR_OK) {					/* The object is accessible */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_unlink_0
// 3276 			dir = dj.dir;
        LDR      R1,[SP, #+20]
// 3277 			if (!dir) {
        CMP      R1,#+0
        BNE.N    ??f_unlink_1
// 3278 				res = FR_INVALID_NAME;		/* Cannot remove the start directory */
        MOVS     R0,#+6
        B.N      ??f_unlink_2
// 3279 			} else {
// 3280 				if (dir[DIR_Attr] & AM_RDO)
??f_unlink_1:
        LDRB     R2,[R1, #+11]
        LSLS     R2,R2,#+31
        BPL.N    ??f_unlink_2
// 3281 					res = FR_DENIED;		/* Cannot remove R/O object */
        MOVS     R0,#+7
// 3282 			}
// 3283 			dclst = LD_CLUST(dir);
??f_unlink_2:
        LDRB     R2,[R1, #+21]
        LDRB     R3,[R1, #+20]
        ORRS     R3,R3,R2, LSL #+8
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        LDRB     R2,[R1, #+27]
        LDRB     R4,[R1, #+26]
        ORRS     R4,R4,R2, LSL #+8
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        ORRS     R4,R4,R3, LSL #+16
// 3284 			if (res == FR_OK && (dir[DIR_Attr] & AM_DIR)) {	/* Is it a sub-dir? */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_unlink_3
        LDRB     R1,[R1, #+11]
        LSLS     R1,R1,#+27
        BPL.N    ??f_unlink_3
// 3285 				if (dclst < 2) {
        CMP      R4,#+2
        BCS.N    ??f_unlink_4
// 3286 					res = FR_INT_ERR;
        MOVS     R0,#+2
        B.N      ??f_unlink_3
// 3287 				} else {
// 3288 					mem_cpy(&sdj, &dj, sizeof(DIR));	/* Check if the sub-dir is empty or not */
??f_unlink_4:
        MOVS     R2,#+28
        MOV      R1,SP
        ADD      R0,SP,#+40
        BL       mem_cpy
// 3289 					sdj.sclust = dclst;
        STR      R4,[SP, #+48]
// 3290 					res = dir_sdi(&sdj, 2);		/* Exclude dot entries */
        MOVS     R1,#+2
        ADD      R0,SP,#+40
        BL       dir_sdi
// 3291 					if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_unlink_3
// 3292 						res = dir_read(&sdj);
        ADD      R0,SP,#+40
        BL       dir_read
// 3293 						if (res == FR_OK			/* Not empty dir */
// 3294 #if _FS_RPATH
// 3295 						|| dclst == sdj.fs->cdir	/* Current dir */
// 3296 #endif
// 3297 						) res = FR_DENIED;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_unlink_5
        MOVS     R0,#+7
// 3298 						if (res == FR_NO_FILE) res = FR_OK;	/* Empty */
??f_unlink_5:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BNE.N    ??f_unlink_3
        MOVS     R0,#+0
// 3299 					}
// 3300 				}
// 3301 			}
// 3302 			if (res == FR_OK) {
??f_unlink_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_unlink_0
// 3303 				res = dir_remove(&dj);		/* Remove the directory entry */
        MOV      R0,SP
        BL       dir_remove
// 3304 				if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_unlink_0
// 3305 					if (dclst)				/* Remove the cluster chain if exist */
        CMP      R4,#+0
        BEQ.N    ??f_unlink_6
// 3306 						res = remove_chain(dj.fs, dclst);
        MOVS     R1,R4
        LDR      R0,[SP, #+0]
        BL       remove_chain
// 3307 					if (res == FR_OK) res = sync(dj.fs);
??f_unlink_6:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_unlink_0
        LDR      R0,[SP, #+0]
        BL       sync
// 3308 				}
// 3309 			}
// 3310 		}
// 3311 		FREE_BUF();
// 3312 	}
// 3313 	LEAVE_FF(dj.fs, res);
??f_unlink_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADD      SP,SP,#+72
        POP      {R4,PC}          ;; return
// 3314 }
// 3315 
// 3316 
// 3317 
// 3318 
// 3319 /*-----------------------------------------------------------------------*/
// 3320 /* Create a Directory                                                    */
// 3321 /*-----------------------------------------------------------------------*/
// 3322 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3323 FRESULT f_mkdir (
// 3324 	const TCHAR *path		/* Pointer to the directory path */
// 3325 )
// 3326 {
f_mkdir:
        PUSH     {R0,R4-R9,LR}
        SUB      SP,SP,#+40
// 3327 	FRESULT res;
// 3328 	DIR dj;
// 3329 	BYTE *dir, n;
// 3330 	DWORD dsc, dcl, pcl, tim = get_fattime();
        BL       get_fattime
        MOVS     R7,R0
// 3331 	DEF_NAMEBUF;
// 3332 
// 3333 
// 3334 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        MOV      R1,SP
        ADD      R0,SP,#+40
        BL       chk_mounted
        MOVS     R4,R0
// 3335 	if (res == FR_OK) {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.W    ??f_mkdir_0
// 3336 		INIT_BUF(dj);
        ADD      R0,SP,#+28
        STR      R0,[SP, #+24]
// 3337 		res = follow_path(&dj, path);			/* Follow the file path */
        LDR      R1,[SP, #+40]
        MOV      R0,SP
        BL       follow_path
        MOVS     R4,R0
// 3338 		if (res == FR_OK) res = FR_EXIST;		/* Any object with same name is already existing */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_mkdir_1
        MOVS     R4,#+8
// 3339 		if (_FS_RPATH && res == FR_NO_FILE && (dj.fn[NS] & NS_DOT))
// 3340 			res = FR_INVALID_NAME;
// 3341 		if (res == FR_NO_FILE) {				/* Can create a new directory */
??f_mkdir_1:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+4
        BNE.W    ??f_mkdir_0
// 3342 			dcl = create_chain(dj.fs, 0);		/* Allocate a cluster for the new directory table */
        MOVS     R1,#+0
        LDR      R0,[SP, #+0]
        BL       create_chain
        MOVS     R6,R0
// 3343 			res = FR_OK;
        MOVS     R4,#+0
// 3344 			if (dcl == 0) res = FR_DENIED;		/* No space to allocate a new cluster */
        CMP      R6,#+0
        BNE.N    ??f_mkdir_2
        MOVS     R4,#+7
// 3345 			if (dcl == 1) res = FR_INT_ERR;
??f_mkdir_2:
        CMP      R6,#+1
        BNE.N    ??f_mkdir_3
        MOVS     R4,#+2
// 3346 			if (dcl == 0xFFFFFFFF) res = FR_DISK_ERR;
??f_mkdir_3:
        CMN      R6,#+1
        BNE.N    ??f_mkdir_4
        MOVS     R4,#+1
// 3347 			if (res == FR_OK)					/* Flush FAT */
??f_mkdir_4:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_mkdir_5
// 3348 				res = move_window(dj.fs, 0);
        MOVS     R1,#+0
        LDR      R0,[SP, #+0]
        BL       move_window
        MOVS     R4,R0
// 3349 			if (res == FR_OK) {					/* Initialize the new directory table */
??f_mkdir_5:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_mkdir_6
// 3350 				dsc = clust2sect(dj.fs, dcl);
        MOVS     R1,R6
        LDR      R0,[SP, #+0]
        BL       clust2sect
        MOV      R8,R0
// 3351 				dir = dj.fs->win;
        LDR      R0,[SP, #+0]
        ADDS     R9,R0,#+48
// 3352 				mem_set(dir, 0, SS(dj.fs));
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R9
        BL       mem_set
// 3353 				mem_set(dir+DIR_Name, ' ', 8+3);	/* Create "." entry */
        MOVS     R2,#+11
        MOVS     R1,#+32
        MOV      R0,R9
        BL       mem_set
// 3354 				dir[DIR_Name] = '.';
        MOVS     R0,#+46
        STRB     R0,[R9, #+0]
// 3355 				dir[DIR_Attr] = AM_DIR;
        MOVS     R0,#+16
        STRB     R0,[R9, #+11]
// 3356 				ST_DWORD(dir+DIR_WrtTime, tim);
        STRB     R7,[R9, #+22]
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+23]
        MOVS     R0,R7
        LSRS     R0,R0,#+16
        STRB     R0,[R9, #+24]
        MOVS     R0,R7
        LSRS     R0,R0,#+24
        STRB     R0,[R9, #+25]
// 3357 				ST_CLUST(dir, dcl);
        STRB     R6,[R9, #+26]
        MOVS     R0,R6
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+27]
        MOVS     R0,R6
        LSRS     R0,R0,#+16
        STRB     R0,[R9, #+20]
        MOVS     R0,R6
        LSRS     R0,R0,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+21]
// 3358 				mem_cpy(dir+SZ_DIR, dir, SZ_DIR); 	/* Create ".." entry */
        MOVS     R2,#+32
        MOV      R1,R9
        ADDS     R0,R9,#+32
        BL       mem_cpy
// 3359 				dir[33] = '.'; pcl = dj.sclust;
        MOVS     R0,#+46
        STRB     R0,[R9, #+33]
        LDR      R0,[SP, #+8]
// 3360 				if (dj.fs->fs_type == FS_FAT32 && pcl == dj.fs->dirbase)
        LDR      R1,[SP, #+0]
        LDRB     R1,[R1, #+0]
        CMP      R1,#+3
        BNE.N    ??f_mkdir_7
        LDR      R1,[SP, #+0]
        LDR      R1,[R1, #+36]
        CMP      R0,R1
        BNE.N    ??f_mkdir_7
// 3361 					pcl = 0;
        MOVS     R0,#+0
// 3362 				ST_CLUST(dir+SZ_DIR, pcl);
??f_mkdir_7:
        STRB     R0,[R9, #+58]
        MOVS     R1,R0
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R9, #+59]
        MOVS     R1,R0
        LSRS     R1,R1,#+16
        STRB     R1,[R9, #+52]
        LSRS     R0,R0,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+53]
// 3363 				for (n = dj.fs->csize; n; n--) {	/* Write dot entries and clear following sectors */
        LDR      R0,[SP, #+0]
        LDRB     R5,[R0, #+2]
        B.N      ??f_mkdir_8
// 3364 					dj.fs->winsect = dsc++;
// 3365 					dj.fs->wflag = 1;
// 3366 					res = move_window(dj.fs, 0);
// 3367 					if (res != FR_OK) break;
// 3368 					mem_set(dir, 0, SS(dj.fs));
??f_mkdir_9:
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R9
        BL       mem_set
        SUBS     R5,R5,#+1
??f_mkdir_8:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??f_mkdir_6
        LDR      R0,[SP, #+0]
        STR      R8,[R0, #+44]
        ADDS     R8,R8,#+1
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
        MOVS     R1,#+0
        LDR      R0,[SP, #+0]
        BL       move_window
        MOVS     R4,R0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??f_mkdir_9
// 3369 				}
// 3370 			}
// 3371 			if (res == FR_OK) res = dir_register(&dj);	/* Register the object to the directoy */
??f_mkdir_6:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_mkdir_10
        MOV      R0,SP
        BL       dir_register
        MOVS     R4,R0
// 3372 			if (res != FR_OK) {
??f_mkdir_10:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??f_mkdir_11
// 3373 				remove_chain(dj.fs, dcl);			/* Could not register, remove cluster chain */
        MOVS     R1,R6
        LDR      R0,[SP, #+0]
        BL       remove_chain
        B.N      ??f_mkdir_0
// 3374 			} else {
// 3375 				dir = dj.dir;
??f_mkdir_11:
        LDR      R9,[SP, #+20]
// 3376 				dir[DIR_Attr] = AM_DIR;				/* Attribute */
        MOVS     R0,#+16
        STRB     R0,[R9, #+11]
// 3377 				ST_DWORD(dir+DIR_WrtTime, tim);		/* Created time */
        STRB     R7,[R9, #+22]
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+23]
        MOVS     R0,R7
        LSRS     R0,R0,#+16
        STRB     R0,[R9, #+24]
        LSRS     R7,R7,#+24
        STRB     R7,[R9, #+25]
// 3378 				ST_CLUST(dir, dcl);					/* Table start cluster */
        STRB     R6,[R9, #+26]
        MOVS     R0,R6
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+27]
        MOVS     R0,R6
        LSRS     R0,R0,#+16
        STRB     R0,[R9, #+20]
        LSRS     R6,R6,#+16
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        LSRS     R6,R6,#+8
        STRB     R6,[R9, #+21]
// 3379 				dj.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
// 3380 				res = sync(dj.fs);
        LDR      R0,[SP, #+0]
        BL       sync
        MOVS     R4,R0
// 3381 			}
// 3382 		}
// 3383 		FREE_BUF();
// 3384 	}
// 3385 
// 3386 	LEAVE_FF(dj.fs, res);
??f_mkdir_0:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADD      SP,SP,#+44
        POP      {R4-R9,PC}       ;; return
// 3387 }
// 3388 
// 3389 
// 3390 
// 3391 
// 3392 /*-----------------------------------------------------------------------*/
// 3393 /* Change Attribute                                                      */
// 3394 /*-----------------------------------------------------------------------*/
// 3395 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3396 FRESULT f_chmod (
// 3397 	const TCHAR *path,	/* Pointer to the file path */
// 3398 	BYTE value,			/* Attribute bits */
// 3399 	BYTE mask			/* Attribute mask to change */
// 3400 )
// 3401 {
f_chmod:
        PUSH     {R0,R4,R5,LR}
        SUB      SP,SP,#+40
        MOVS     R4,R1
        MOVS     R5,R2
// 3402 	FRESULT res;
// 3403 	DIR dj;
// 3404 	BYTE *dir;
// 3405 	DEF_NAMEBUF;
// 3406 
// 3407 
// 3408 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        MOV      R1,SP
        ADD      R0,SP,#+40
        BL       chk_mounted
// 3409 	if (res == FR_OK) 
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_chmod_0
// 3410 	{
// 3411 		INIT_BUF(dj);
        ADD      R0,SP,#+28
        STR      R0,[SP, #+24]
// 3412 		res = follow_path(&dj, path);		/* Follow the file path */
        LDR      R1,[SP, #+40]
        MOV      R0,SP
        BL       follow_path
// 3413 		FREE_BUF();
// 3414 		if (_FS_RPATH && res == FR_OK && (dj.fn[NS] & NS_DOT))
// 3415 			res = FR_INVALID_NAME;
// 3416 		if (res == FR_OK) 
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_chmod_0
// 3417 		{
// 3418 			dir = dj.dir;
        LDR      R0,[SP, #+20]
// 3419 			if (!dir) 
        CMP      R0,#+0
        BNE.N    ??f_chmod_1
// 3420 			{						/* Is it a root directory? */
// 3421 				res = FR_INVALID_NAME;
        MOVS     R0,#+6
        B.N      ??f_chmod_0
// 3422 			} 
// 3423 			else 
// 3424 			{						/* File or sub directory */
// 3425 				mask &= AM_RDO|AM_HID|AM_SYS|AM_ARC;	/* Valid attribute mask */
??f_chmod_1:
        ANDS     R5,R5,#0x27
// 3426 				dir[DIR_Attr] = (value & mask) | (dir[DIR_Attr] & (BYTE)~mask);	/* Apply attribute change */
        ANDS     R4,R5,R4
        LDRB     R1,[R0, #+11]
        BICS     R5,R1,R5
        ORRS     R4,R5,R4
        STRB     R4,[R0, #+11]
// 3427 				dj.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
// 3428 				res = sync(dj.fs);
        LDR      R0,[SP, #+0]
        BL       sync
// 3429 			}
// 3430 		}
// 3431 	}
// 3432 
// 3433 	LEAVE_FF(dj.fs, res);
??f_chmod_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADD      SP,SP,#+44
        POP      {R4,R5,PC}       ;; return
// 3434 }
// 3435 
// 3436 
// 3437 
// 3438 
// 3439 /*-----------------------------------------------------------------------*/
// 3440 /* Change Timestamp                                                      */
// 3441 /*-----------------------------------------------------------------------*/
// 3442 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3443 FRESULT f_utime (
// 3444 	const TCHAR *path,	/* Pointer to the file/directory name */
// 3445 	const FILINFO *fno	/* Pointer to the time stamp to be set */
// 3446 )
// 3447 {
f_utime:
        PUSH     {R0,R4,LR}
        SUB      SP,SP,#+44
        MOVS     R4,R1
// 3448 	FRESULT res;
// 3449 	DIR dj;
// 3450 	BYTE *dir;
// 3451 	DEF_NAMEBUF;
// 3452 
// 3453 
// 3454 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        MOV      R1,SP
        ADD      R0,SP,#+44
        BL       chk_mounted
// 3455 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_utime_0
// 3456 		INIT_BUF(dj);
        ADD      R0,SP,#+28
        STR      R0,[SP, #+24]
// 3457 		res = follow_path(&dj, path);	/* Follow the file path */
        LDR      R1,[SP, #+44]
        MOV      R0,SP
        BL       follow_path
// 3458 		FREE_BUF();
// 3459 		if (_FS_RPATH && res == FR_OK && (dj.fn[NS] & NS_DOT))
// 3460 			res = FR_INVALID_NAME;
// 3461 		if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_utime_0
// 3462 			dir = dj.dir;
        LDR      R0,[SP, #+20]
// 3463 			if (!dir) {					/* Root directory */
        CMP      R0,#+0
        BNE.N    ??f_utime_1
// 3464 				res = FR_INVALID_NAME;
        MOVS     R0,#+6
        B.N      ??f_utime_0
// 3465 			} else {					/* File or sub-directory */
// 3466 				ST_WORD(dir+DIR_WrtTime, fno->ftime);
??f_utime_1:
        LDRH     R1,[R4, #+6]
        STRB     R1,[R0, #+22]
        LDRH     R1,[R4, #+6]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+23]
// 3467 				ST_WORD(dir+DIR_WrtDate, fno->fdate);
        LDRH     R1,[R4, #+4]
        STRB     R1,[R0, #+24]
        LDRH     R1,[R4, #+4]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+25]
// 3468 				dj.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
// 3469 				res = sync(dj.fs);
        LDR      R0,[SP, #+0]
        BL       sync
// 3470 			}
// 3471 		}
// 3472 	}
// 3473 
// 3474 	LEAVE_FF(dj.fs, res);
??f_utime_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADD      SP,SP,#+48
        POP      {R4,PC}          ;; return
// 3475 }
// 3476 
// 3477 
// 3478 
// 3479 
// 3480 /*-----------------------------------------------------------------------*/
// 3481 /* Rename File/Directory                                                 */
// 3482 /*-----------------------------------------------------------------------*/
// 3483 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3484 FRESULT f_rename (
// 3485 	const TCHAR *path_old,	/* Pointer to the old name */
// 3486 	const TCHAR *path_new	/* Pointer to the new name */
// 3487 )
// 3488 {
f_rename:
        PUSH     {R0,R4,R5,LR}
        SUB      SP,SP,#+96
        MOVS     R5,R1
// 3489 	FRESULT res;
// 3490 	DIR djo, djn;
// 3491 	BYTE buf[21], *dir;
// 3492 	DWORD dw;
// 3493 	DEF_NAMEBUF;
// 3494 
// 3495 
// 3496 	res = chk_mounted(&path_old, &djo.fs, 1);
        MOVS     R2,#+1
        ADD      R1,SP,#+28
        ADD      R0,SP,#+96
        BL       chk_mounted
        MOVS     R4,R0
// 3497 	if (res == FR_OK) {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.W    ??f_rename_0
// 3498 		djn.fs = djo.fs;
        LDR      R0,[SP, #+28]
        STR      R0,[SP, #+0]
// 3499 		INIT_BUF(djo);
        ADD      R0,SP,#+56
        STR      R0,[SP, #+52]
// 3500 		res = follow_path(&djo, path_old);		/* Check old object */
        LDR      R1,[SP, #+96]
        ADD      R0,SP,#+28
        BL       follow_path
        MOVS     R4,R0
// 3501 		if (_FS_RPATH && res == FR_OK && (djo.fn[NS] & NS_DOT))
// 3502 			res = FR_INVALID_NAME;
// 3503 #if _FS_SHARE
// 3504 		if (res == FR_OK) res = chk_lock(&djo, 2);
// 3505 #endif
// 3506 		if (res == FR_OK) {						/* Old object is found */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.W    ??f_rename_0
// 3507 			if (!djo.dir) {						/* Is root dir? */
        LDR      R0,[SP, #+48]
        CMP      R0,#+0
        BNE.N    ??f_rename_1
// 3508 				res = FR_NO_FILE;
        MOVS     R4,#+4
        B.N      ??f_rename_0
// 3509 			} else {
// 3510 				mem_cpy(buf, djo.dir+DIR_Attr, 21);		/* Save the object information except for name */
??f_rename_1:
        MOVS     R2,#+21
        LDR      R0,[SP, #+48]
        ADDS     R1,R0,#+11
        ADD      R0,SP,#+68
        BL       mem_cpy
// 3511 				mem_cpy(&djn, &djo, sizeof(DIR));		/* Check new object */
        MOVS     R2,#+28
        ADD      R1,SP,#+28
        MOV      R0,SP
        BL       mem_cpy
// 3512 				res = follow_path(&djn, path_new);
        MOVS     R1,R5
        MOV      R0,SP
        BL       follow_path
        MOVS     R4,R0
// 3513 				if (res == FR_OK) res = FR_EXIST;		/* The new object name is already existing */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_rename_2
        MOVS     R4,#+8
// 3514 				if (res == FR_NO_FILE) { 				/* Is it a valid path and no name collision? */
??f_rename_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+4
        BNE.N    ??f_rename_0
// 3515 /* Start critical section that any interruption or error can cause cross-link */
// 3516 					res = dir_register(&djn);			/* Register the new entry */
        MOV      R0,SP
        BL       dir_register
        MOVS     R4,R0
// 3517 					if (res == FR_OK) {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_rename_0
// 3518 						dir = djn.dir;					/* Copy object information except for name */
        LDR      R5,[SP, #+20]
// 3519 						mem_cpy(dir+13, buf+2, 19);
        MOVS     R2,#+19
        ADD      R1,SP,#+70
        ADDS     R0,R5,#+13
        BL       mem_cpy
// 3520 						dir[DIR_Attr] = buf[0] | AM_ARC;
        LDRB     R0,[SP, #+68]
        ORRS     R0,R0,#0x20
        STRB     R0,[R5, #+11]
// 3521 						djo.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+28]
        STRB     R0,[R1, #+4]
// 3522 						if (djo.sclust != djn.sclust && (dir[DIR_Attr] & AM_DIR)) {		/* Update .. entry in the directory if needed */
        LDR      R0,[SP, #+36]
        LDR      R1,[SP, #+8]
        CMP      R0,R1
        BEQ.N    ??f_rename_3
        LDRB     R0,[R5, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_rename_3
// 3523 							dw = clust2sect(djn.fs, LD_CLUST(dir));
        LDRB     R0,[R5, #+21]
        LDRB     R2,[R5, #+20]
        ORRS     R2,R2,R0, LSL #+8
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LDRB     R0,[R5, #+27]
        LDRB     R1,[R5, #+26]
        ORRS     R1,R1,R0, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ORRS     R1,R1,R2, LSL #+16
        LDR      R0,[SP, #+0]
        BL       clust2sect
// 3524 							if (!dw) {
        CMP      R0,#+0
        BNE.N    ??f_rename_4
// 3525 								res = FR_INT_ERR;
        MOVS     R4,#+2
        B.N      ??f_rename_3
// 3526 							} else {
// 3527 								res = move_window(djn.fs, dw);
??f_rename_4:
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       move_window
        MOVS     R4,R0
// 3528 								dir = djn.fs->win+SZ_DIR;	/* .. entry */
        LDR      R0,[SP, #+0]
        ADDS     R5,R0,#+80
// 3529 								if (res == FR_OK && dir[1] == '.') {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_rename_3
        LDRB     R0,[R5, #+1]
        CMP      R0,#+46
        BNE.N    ??f_rename_3
// 3530 									dw = (djn.fs->fs_type == FS_FAT32 && djn.sclust == djn.fs->dirbase) ? 0 : djn.sclust;
        LDR      R0,[SP, #+0]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??f_rename_5
        LDR      R0,[SP, #+8]
        LDR      R1,[SP, #+0]
        LDR      R1,[R1, #+36]
        CMP      R0,R1
        BNE.N    ??f_rename_5
        MOVS     R0,#+0
        B.N      ??f_rename_6
??f_rename_5:
        LDR      R0,[SP, #+8]
// 3531 									ST_CLUST(dir, dw);
??f_rename_6:
        STRB     R0,[R5, #+26]
        MOVS     R1,R0
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R5, #+27]
        MOVS     R1,R0
        LSRS     R1,R1,#+16
        STRB     R1,[R5, #+20]
        LSRS     R0,R0,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+21]
// 3532 									djn.fs->wflag = 1;
        MOVS     R0,#+1
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+4]
// 3533 								}
// 3534 							}
// 3535 						}
// 3536 						if (res == FR_OK) {
??f_rename_3:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_rename_0
// 3537 							res = dir_remove(&djo);		/* Remove old entry */
        ADD      R0,SP,#+28
        BL       dir_remove
        MOVS     R4,R0
// 3538 							if (res == FR_OK)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_rename_0
// 3539 								res = sync(djo.fs);
        LDR      R0,[SP, #+28]
        BL       sync
        MOVS     R4,R0
// 3540 						}
// 3541 					}
// 3542 /* End critical section */
// 3543 				}
// 3544 			}
// 3545 		}
// 3546 		FREE_BUF();
// 3547 	}
// 3548 	LEAVE_FF(djo.fs, res);
??f_rename_0:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADD      SP,SP,#+100
        POP      {R4,R5,PC}       ;; return
// 3549 }
// 3550 
// 3551 #endif /* !_FS_READONLY */
// 3552 #endif /* _FS_MINIMIZE == 0 */
// 3553 #endif /* _FS_MINIMIZE <= 1 */
// 3554 #endif /* _FS_MINIMIZE <= 2 */
// 3555 
// 3556 
// 3557 
// 3558 /*-----------------------------------------------------------------------*/
// 3559 /* Forward data to the stream directly (available on only tiny cfg)      */
// 3560 /*-----------------------------------------------------------------------*/
// 3561 #if _USE_FORWARD && _FS_TINY
// 3562 
// 3563 FRESULT f_forward (
// 3564 	FIL *fp, 						/* Pointer to the file object */
// 3565 	UINT (*func)(const BYTE*,UINT),	/* Pointer to the streaming function */
// 3566 	UINT btr,						/* Number of bytes to forward */
// 3567 	UINT *bf						/* Pointer to number of bytes forwarded */
// 3568 )
// 3569 {
// 3570 	FRESULT res;
// 3571 	DWORD remain, clst, sect;
// 3572 	UINT rcnt;
// 3573 	BYTE csect;
// 3574 
// 3575 
// 3576 	*bf = 0;	/* Initialize byte counter */
// 3577 
// 3578 	res = validate(fp->fs, fp->id);					/* Check validity of the object */
// 3579 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
// 3580 	if (fp->flag & FA__ERROR)						/* Check error flag */
// 3581 		LEAVE_FF(fp->fs, FR_INT_ERR);
// 3582 	if (!(fp->flag & FA_READ))						/* Check access mode */
// 3583 		LEAVE_FF(fp->fs, FR_DENIED);
// 3584 
// 3585 	remain = fp->fsize - fp->fptr;
// 3586 	if (btr > remain) btr = (UINT)remain;			/* Truncate btr by remaining bytes */
// 3587 
// 3588 	for ( ;  btr && (*func)(0, 0);					/* Repeat until all data transferred or stream becomes busy */
// 3589 		fp->fptr += rcnt, *bf += rcnt, btr -= rcnt) {
// 3590 		csect = (BYTE)(fp->fptr / SS(fp->fs) & (fp->fs->csize - 1));	/* Sector offset in the cluster */
// 3591 		if ((fp->fptr % SS(fp->fs)) == 0) {			/* On the sector boundary? */
// 3592 			if (!csect) {							/* On the cluster boundary? */
// 3593 				clst = (fp->fptr == 0) ?			/* On the top of the file? */
// 3594 					fp->sclust : get_fat(fp->fs, fp->clust);
// 3595 				if (clst <= 1) ABORT(fp->fs, FR_INT_ERR);
// 3596 				if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
// 3597 				fp->clust = clst;					/* Update current cluster */
// 3598 			}
// 3599 		}
// 3600 		sect = clust2sect(fp->fs, fp->clust);		/* Get current data sector */
// 3601 		if (!sect) ABORT(fp->fs, FR_INT_ERR);
// 3602 		sect += csect;
// 3603 		if (move_window(fp->fs, sect))				/* Move sector window */
// 3604 			ABORT(fp->fs, FR_DISK_ERR);
// 3605 		fp->dsect = sect;
// 3606 		rcnt = SS(fp->fs) - (WORD)(fp->fptr % SS(fp->fs));	/* Forward data from sector window */
// 3607 		if (rcnt > btr) rcnt = btr;
// 3608 		rcnt = (*func)(&fp->fs->win[(WORD)fp->fptr % SS(fp->fs)], rcnt);
// 3609 		if (!rcnt) ABORT(fp->fs, FR_INT_ERR);
// 3610 	}
// 3611 
// 3612 	LEAVE_FF(fp->fs, FR_OK);
// 3613 }
// 3614 #endif /* _USE_FORWARD */
// 3615 
// 3616 
// 3617 
// 3618 #if _USE_MKFS && !_FS_READONLY
// 3619 /*-----------------------------------------------------------------------*/
// 3620 /* Create File System on the Drive                                       */
// 3621 /*-----------------------------------------------------------------------*/
// 3622 #define N_ROOTDIR	512		/* Number of root dir entries for FAT12/16 */
// 3623 #define N_FATS		1		/* Number of FAT copies (1 or 2) */
// 3624 
// 3625 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3626 FRESULT f_mkfs (
// 3627 	BYTE drv,		/* Logical drive number */
// 3628 	BYTE sfd,		/* Partitioning rule 0:FDISK, 1:SFD */
// 3629 	UINT au			/* Allocation unit size [bytes] */
// 3630 )
// 3631 {
f_mkfs:
        PUSH     {R0,R4-R11,LR}
        SUB      SP,SP,#+24
        MOVS     R7,R1
        MOVS     R5,R2
// 3632 	static const WORD vst[] = { 1024,   512,  256,  128,   64,    32,   16,    8,    4,    2,   0};
// 3633 	static const WORD cst[] = {32768, 16384, 8192, 4096, 2048, 16384, 8192, 4096, 2048, 1024, 512};
// 3634 	BYTE fmt, md, *tbl;
// 3635 	DWORD n_clst, vs, n, wsect;
// 3636 	UINT i;
// 3637 	DWORD b_vol, b_fat, b_dir, b_data;	/* Offset (LBA) */
// 3638 	DWORD n_vol, n_rsv, n_fat, n_dir;	/* Size */
// 3639 	FATFS *fs;
// 3640 	DSTATUS stat;
// 3641 
// 3642 
// 3643 	/* Check mounted drive and clear work area */
// 3644 	if (drv >= _VOLUMES) return FR_INVALID_DRIVE;
        LDRB     R0,[SP, #+24]
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_0
        MOVS     R0,#+11
        B.N      ??f_mkfs_1
// 3645 	fs = FatFs[drv];
??f_mkfs_0:
        LDR.W    R0,??DataTable5
        LDRB     R1,[SP, #+24]
        LDR      R0,[R0, R1, LSL #+2]
        STR      R0,[SP, #+12]
// 3646 	if (!fs) return FR_NOT_ENABLED;
        LDR      R0,[SP, #+12]
        CMP      R0,#+0
        BNE.N    ??f_mkfs_2
        MOVS     R0,#+12
        B.N      ??f_mkfs_1
// 3647 	fs->fs_type = 0;
??f_mkfs_2:
        MOVS     R0,#+0
        LDR      R1,[SP, #+12]
        STRB     R0,[R1, #+0]
// 3648 	drv = LD2PD(drv);
// 3649 
// 3650 	/* Get disk statics */
// 3651 	stat = disk_initialize(drv);
        LDRB     R0,[SP, #+24]
        BL       disk_initialize
// 3652 	if (stat & STA_NOINIT) return FR_NOT_READY;
        LSLS     R1,R0,#+31
        BPL.N    ??f_mkfs_3
        MOVS     R0,#+3
        B.N      ??f_mkfs_1
// 3653 	if (stat & STA_PROTECT) return FR_WRITE_PROTECTED;
??f_mkfs_3:
        LSLS     R0,R0,#+29
        BPL.N    ??f_mkfs_4
        MOVS     R0,#+10
        B.N      ??f_mkfs_1
// 3654 #if _MAX_SS != 512					/* Get disk sector size */
// 3655 	if (disk_ioctl(drv, GET_SECTOR_SIZE, &SS(fs)) != RES_OK)
// 3656 		return FR_DISK_ERR;
// 3657 #endif
// 3658 	if (disk_ioctl(drv, GET_SECTOR_COUNT, &n_vol) != RES_OK || n_vol < 128)
??f_mkfs_4:
        ADD      R2,SP,#+4
        MOVS     R1,#+1
        LDRB     R0,[SP, #+24]
        BL       disk_ioctl
        CMP      R0,#+0
        BNE.N    ??f_mkfs_5
        LDR      R0,[SP, #+4]
        CMP      R0,#+128
        BCS.N    ??f_mkfs_6
// 3659 		return FR_DISK_ERR;
??f_mkfs_5:
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3660 	b_vol = (sfd) ? 0 : 63;	/* Volume start sector */
??f_mkfs_6:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BEQ.N    ??f_mkfs_7
        MOVS     R10,#+0
        B.N      ??f_mkfs_8
??f_mkfs_7:
        MOVS     R10,#+63
// 3661 	n_vol -= b_vol;
??f_mkfs_8:
        LDR      R0,[SP, #+4]
        SUBS     R0,R0,R10
        STR      R0,[SP, #+4]
// 3662 	if (au & (au - 1)) au = 0;	/* Check validity of the AU size */
        SUBS     R0,R5,#+1
        TST      R5,R0
        BEQ.N    ??f_mkfs_9
        MOVS     R5,#+0
// 3663 	if (!au) {					/* AU auto selection */
??f_mkfs_9:
        CMP      R5,#+0
        BNE.N    ??f_mkfs_10
// 3664 		vs = n_vol / (2000 / (SS(fs) / 512));
        LDR      R0,[SP, #+4]
        MOV      R1,#+2000
        UDIV     R0,R0,R1
// 3665 		for (i = 0; vs < vst[i]; i++) ;
        MOVS     R4,#+0
        B.N      ??f_mkfs_11
??f_mkfs_12:
        ADDS     R4,R4,#+1
??f_mkfs_11:
        LDR.W    R1,??DataTable5_1
        LDRH     R1,[R1, R4, LSL #+1]
        CMP      R0,R1
        BCC.N    ??f_mkfs_12
// 3666 		au = cst[i];
        LDR.W    R0,??DataTable5_2
        LDRH     R5,[R0, R4, LSL #+1]
// 3667 	}
// 3668 	au /= SS(fs);		/* Number of sectors per cluster */
??f_mkfs_10:
        LSRS     R5,R5,#+9
// 3669 	if (au == 0) au = 1;
        CMP      R5,#+0
        BNE.N    ??f_mkfs_13
        MOVS     R5,#+1
// 3670 	if (au > 128) au = 128;
??f_mkfs_13:
        CMP      R5,#+129
        BCC.N    ??f_mkfs_14
        MOVS     R5,#+128
// 3671 
// 3672 	/* Pre-compute number of clusters and FAT syb-type */
// 3673 	n_clst = n_vol / au;
??f_mkfs_14:
        LDR      R0,[SP, #+4]
        UDIV     R8,R0,R5
// 3674 	fmt = FS_FAT12;
        MOVS     R6,#+1
// 3675 	if (n_clst >= MIN_FAT16) fmt = FS_FAT16;
        MOVW     R0,#+4086
        CMP      R8,R0
        BCC.N    ??f_mkfs_15
        MOVS     R6,#+2
// 3676 	if (n_clst >= MIN_FAT32) fmt = FS_FAT32;
??f_mkfs_15:
        MOVW     R0,#+65526
        CMP      R8,R0
        BCC.N    ??f_mkfs_16
        MOVS     R6,#+3
// 3677 
// 3678 	/* Determine offset and size of FAT structure */
// 3679 	if (fmt == FS_FAT32) {
??f_mkfs_16:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??f_mkfs_17
// 3680 		n_fat = ((n_clst * 4) + 8 + SS(fs) - 1) / SS(fs);
        LSLS     R11,R8,#+2
        ADDW     R11,R11,#+519
        LSRS     R11,R11,#+9
// 3681 		n_rsv = 32;
        MOVS     R9,#+32
// 3682 		n_dir = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+16]
        B.N      ??f_mkfs_18
// 3683 	} else {
// 3684 		n_fat = (fmt == FS_FAT12) ? (n_clst * 3 + 1) / 2 + 3 : (n_clst * 2) + 4;
??f_mkfs_17:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+1
        BNE.N    ??f_mkfs_19
        MOVS     R0,#+3
        MUL      R8,R0,R8
        ADDS     R8,R8,#+1
        LSRS     R8,R8,#+1
        ADDS     R8,R8,#+3
        MOV      R11,R8
        B.N      ??f_mkfs_20
??f_mkfs_19:
        LSLS     R11,R8,#+1
        ADDS     R11,R11,#+4
// 3685 		n_fat = (n_fat + SS(fs) - 1) / SS(fs);
??f_mkfs_20:
        ADDW     R11,R11,#+511
        LSRS     R11,R11,#+9
// 3686 		n_rsv = 1;
        MOVS     R9,#+1
// 3687 		n_dir = (DWORD)N_ROOTDIR * SZ_DIR / SS(fs);
        MOVS     R0,#+32
        STR      R0,[SP, #+16]
// 3688 	}
// 3689 	b_fat = b_vol + n_rsv;				/* FAT area start sector */
??f_mkfs_18:
        ADDS     R0,R9,R10
        STR      R0,[SP, #+20]
// 3690 	b_dir = b_fat + n_fat * N_FATS;		/* Directory area start sector */
        LDR      R4,[SP, #+20]
        ADDS     R4,R11,R4
// 3691 	b_data = b_dir + n_dir;				/* Data area start sector */
        LDR      R0,[SP, #+16]
        ADDS     R4,R0,R4
// 3692 	if (n_vol < b_data + au) return FR_MKFS_ABORTED;	/* Too small volume */
        LDR      R0,[SP, #+4]
        ADDS     R1,R5,R4
        CMP      R0,R1
        BCS.N    ??f_mkfs_21
        MOVS     R0,#+14
        B.N      ??f_mkfs_1
// 3693 
// 3694 	/* Align data start sector to erase block boundary (for flash memory media) */
// 3695 	if (disk_ioctl(drv, GET_BLOCK_SIZE, &n) != RES_OK || !n || n > 32768) n = 1;
??f_mkfs_21:
        MOV      R2,SP
        MOVS     R1,#+3
        LDRB     R0,[SP, #+24]
        BL       disk_ioctl
        CMP      R0,#+0
        BNE.N    ??f_mkfs_22
        LDR      R0,[SP, #+0]
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_22
        LDR      R0,[SP, #+0]
        MOVW     R1,#+32769
        CMP      R0,R1
        BCC.N    ??f_mkfs_23
??f_mkfs_22:
        MOVS     R0,#+1
        STR      R0,[SP, #+0]
// 3696 	n = (b_data + n - 1) & ~(n - 1);	/* Next nearest erase block from current data start */
??f_mkfs_23:
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,R4
        SUBS     R0,R0,#+1
        LDR      R1,[SP, #+0]
        SUBS     R1,R1,#+1
        BICS     R0,R0,R1
        STR      R0,[SP, #+0]
// 3697 	n = (n - b_data) / N_FATS;
        LDR      R0,[SP, #+0]
        SUBS     R4,R0,R4
        MOVS     R0,#+1
        UDIV     R0,R4,R0
        STR      R0,[SP, #+0]
// 3698 	if (fmt == FS_FAT32) {		/* FAT32: Move FAT offset */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??f_mkfs_24
// 3699 		n_rsv += n;
        LDR      R0,[SP, #+0]
        ADDS     R9,R0,R9
// 3700 		b_fat += n;
        LDR      R1,[SP, #+20]
        LDR      R0,[SP, #+0]
        ADDS     R1,R0,R1
        STR      R1,[SP, #+20]
        B.N      ??f_mkfs_25
// 3701 	} else {					/* FAT12/16: Expand FAT size */
// 3702 		n_fat += n;
??f_mkfs_24:
        LDR      R0,[SP, #+0]
        ADDS     R11,R0,R11
// 3703 	}
// 3704 
// 3705 	/* Determine number of clusters and final check of validity of the FAT sub-type */
// 3706 	n_clst = (n_vol - n_rsv - n_fat * N_FATS - n_dir) / au;
??f_mkfs_25:
        LDR      R1,[SP, #+4]
        SUBS     R1,R1,R9
        SUBS     R1,R1,R11
        LDR      R0,[SP, #+16]
        SUBS     R1,R1,R0
        UDIV     R8,R1,R5
// 3707 	if (   (fmt == FS_FAT16 && n_clst < MIN_FAT16)
// 3708 		|| (fmt == FS_FAT32 && n_clst < MIN_FAT32))
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+2
        BNE.N    ??f_mkfs_26
        MOVW     R0,#+4086
        CMP      R8,R0
        BCC.N    ??f_mkfs_27
??f_mkfs_26:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??f_mkfs_28
        MOVW     R0,#+65526
        CMP      R8,R0
        BCS.N    ??f_mkfs_28
// 3709 		return FR_MKFS_ABORTED;
??f_mkfs_27:
        MOVS     R0,#+14
        B.N      ??f_mkfs_1
// 3710 
// 3711 	/* Create partition table if required */
// 3712 	if (sfd) {	/* No patition table (SFD) */
??f_mkfs_28:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BEQ.N    ??f_mkfs_29
// 3713 		md = 0xF0;
        MOVS     R0,#+240
        STRB     R0,[SP, #+8]
        B.N      ??f_mkfs_30
// 3714 	} else {	/* With patition table (FDISK) */
// 3715 		DWORD n_disk = b_vol + n_vol;
??f_mkfs_29:
        LDR      R4,[SP, #+4]
        ADDS     R4,R4,R10
// 3716 
// 3717 		mem_set(fs->win, 0, SS(fs));
        MOV      R2,#+512
        MOVS     R1,#+0
        LDR      R0,[SP, #+12]
        ADDS     R0,R0,#+48
        BL       mem_set
// 3718 		tbl = fs->win+MBR_Table;
        LDR      R0,[SP, #+12]
        ADDS     R7,R0,#+494
// 3719 		ST_DWORD(tbl, 0x00010180);			/* Partition start in CHS */
        MOVS     R0,#+128
        STRB     R0,[R7, #+0]
        MOVS     R0,#+1
        STRB     R0,[R7, #+1]
        MOVS     R0,#+1
        STRB     R0,[R7, #+2]
        MOVS     R0,#+0
        STRB     R0,[R7, #+3]
// 3720 		if (n_disk < 63UL * 255 * 1024) {	/* Partition end in CHS */
        LDR.W    R0,??DataTable5_3  ;; 0xfb0400
        CMP      R4,R0
        BCS.N    ??f_mkfs_31
// 3721 			n_disk = n_disk / 63 / 255;
        MOVS     R0,#+63
        UDIV     R0,R4,R0
        MOVS     R1,#+255
        UDIV     R4,R0,R1
// 3722 			tbl[7] = (BYTE)n_disk;
        STRB     R4,[R7, #+7]
// 3723 			tbl[6] = (BYTE)((n_disk >> 2) | 63);
        LSRS     R4,R4,#+2
        ORRS     R4,R4,#0x3F
        STRB     R4,[R7, #+6]
        B.N      ??f_mkfs_32
// 3724 		} else {
// 3725 			ST_WORD(&tbl[6], 0xFFFF);	/* CHS saturated */
??f_mkfs_31:
        MOVS     R0,#+255
        STRB     R0,[R7, #+6]
        MOVS     R0,#+255
        STRB     R0,[R7, #+7]
// 3726 		}
// 3727 		tbl[5] = 254;
??f_mkfs_32:
        MOVS     R0,#+254
        STRB     R0,[R7, #+5]
// 3728 		if (fmt != FS_FAT32)				/* System ID */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BEQ.N    ??f_mkfs_33
// 3729 			tbl[4] = (n_vol < 0x10000) ? 0x04 : 0x06;
        LDR      R0,[SP, #+4]
        CMP      R0,#+65536
        BCS.N    ??f_mkfs_34
        MOVS     R0,#+4
        B.N      ??f_mkfs_35
??f_mkfs_34:
        MOVS     R0,#+6
??f_mkfs_35:
        STRB     R0,[R7, #+4]
        B.N      ??f_mkfs_36
// 3730 		else
// 3731 			tbl[4] = 0x0c;
??f_mkfs_33:
        MOVS     R0,#+12
        STRB     R0,[R7, #+4]
// 3732 		ST_DWORD(tbl+8, 63);				/* Partition start in LBA */
??f_mkfs_36:
        MOVS     R0,#+63
        STRB     R0,[R7, #+8]
        MOVS     R0,#+0
        STRB     R0,[R7, #+9]
        MOVS     R0,#+0
        STRB     R0,[R7, #+10]
        MOVS     R0,#+0
        STRB     R0,[R7, #+11]
// 3733 		ST_DWORD(tbl+12, n_vol);			/* Partition size in LBA */
        LDR      R0,[SP, #+4]
        STRB     R0,[R7, #+12]
        LDR      R0,[SP, #+4]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+13]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+16
        STRB     R0,[R7, #+14]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+24
        STRB     R0,[R7, #+15]
// 3734 		ST_WORD(fs->win+BS_55AA, 0xAA55);	/* MBR signature */
        MOVS     R0,#+85
        LDR      R1,[SP, #+12]
        STRB     R0,[R1, #+558]
        MOVS     R0,#+170
        LDR      R1,[SP, #+12]
        STRB     R0,[R1, #+559]
// 3735 		if (disk_write(drv, fs->win, 0, 1) != RES_OK)	/* Put the MBR into first physical sector */
        MOVS     R3,#+1
        MOVS     R2,#+0
        LDR      R0,[SP, #+12]
        ADDS     R1,R0,#+48
        LDRB     R0,[SP, #+24]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_37
// 3736 			return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3737 		md = 0xF8;
??f_mkfs_37:
        MOVS     R0,#+248
        STRB     R0,[SP, #+8]
// 3738 	}
// 3739 
// 3740 	/* Create volume boot record */
// 3741 	tbl = fs->win;							/* Clear sector */
??f_mkfs_30:
        LDR      R0,[SP, #+12]
        ADDS     R7,R0,#+48
// 3742 	mem_set(tbl, 0, SS(fs));
        MOV      R2,#+512
        MOVS     R1,#+0
        MOVS     R0,R7
        BL       mem_set
// 3743 	mem_cpy(tbl, "\xEB\xFE\x90" "MSDOS5.0", 11);/* Boot jump code, OEM name */
        MOVS     R2,#+11
        LDR.W    R1,??DataTable5_4
        MOVS     R0,R7
        BL       mem_cpy
// 3744 	i = SS(fs);								/* Sector size */
        MOV      R4,#+512
// 3745 	ST_WORD(tbl+BPB_BytsPerSec, i);
        STRB     R4,[R7, #+11]
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        LSRS     R4,R4,#+8
        STRB     R4,[R7, #+12]
// 3746 	tbl[BPB_SecPerClus] = (BYTE)au;			/* Sectors per cluster */
        STRB     R5,[R7, #+13]
// 3747 	ST_WORD(tbl+BPB_RsvdSecCnt, n_rsv);		/* Reserved sectors */
        STRB     R9,[R7, #+14]
        UXTH     R9,R9            ;; ZeroExt  R9,R9,#+16,#+16
        LSRS     R9,R9,#+8
        STRB     R9,[R7, #+15]
// 3748 	tbl[BPB_NumFATs] = N_FATS;				/* Number of FATs */
        MOVS     R0,#+1
        STRB     R0,[R7, #+16]
// 3749 	i = (fmt == FS_FAT32) ? 0 : N_ROOTDIR;	/* Number of rootdir entries */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??f_mkfs_38
        MOVS     R4,#+0
        B.N      ??f_mkfs_39
??f_mkfs_38:
        MOV      R4,#+512
// 3750 	ST_WORD(tbl+BPB_RootEntCnt, i);
??f_mkfs_39:
        STRB     R4,[R7, #+17]
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        LSRS     R4,R4,#+8
        STRB     R4,[R7, #+18]
// 3751 	if (n_vol < 0x10000) {					/* Number of total sectors */
        LDR      R0,[SP, #+4]
        CMP      R0,#+65536
        BCS.N    ??f_mkfs_40
// 3752 		ST_WORD(tbl+BPB_TotSec16, n_vol);
        LDR      R0,[SP, #+4]
        STRB     R0,[R7, #+19]
        LDR      R0,[SP, #+4]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+20]
        B.N      ??f_mkfs_41
// 3753 	} else {
// 3754 		ST_DWORD(tbl+BPB_TotSec32, n_vol);
??f_mkfs_40:
        LDR      R0,[SP, #+4]
        STRB     R0,[R7, #+32]
        LDR      R0,[SP, #+4]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+33]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+16
        STRB     R0,[R7, #+34]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+24
        STRB     R0,[R7, #+35]
// 3755 	}
// 3756 	tbl[BPB_Media] = md;					/* Media descriptor */
??f_mkfs_41:
        LDRB     R0,[SP, #+8]
        STRB     R0,[R7, #+21]
// 3757 	ST_WORD(tbl+BPB_SecPerTrk, 63);			/* Number of sectors per track */
        MOVS     R0,#+63
        STRB     R0,[R7, #+24]
        MOVS     R0,#+0
        STRB     R0,[R7, #+25]
// 3758 	ST_WORD(tbl+BPB_NumHeads, 255);			/* Number of heads */
        MOVS     R0,#+255
        STRB     R0,[R7, #+26]
        MOVS     R0,#+0
        STRB     R0,[R7, #+27]
// 3759 	ST_DWORD(tbl+BPB_HiddSec, b_vol);		/* Hidden sectors */
        STRB     R10,[R7, #+28]
        MOV      R0,R10
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+29]
        MOV      R0,R10
        LSRS     R0,R0,#+16
        STRB     R0,[R7, #+30]
        MOV      R0,R10
        LSRS     R0,R0,#+24
        STRB     R0,[R7, #+31]
// 3760 	n = get_fattime();						/* Use current time as VSN */
        BL       get_fattime
        STR      R0,[SP, #+0]
// 3761 	if (fmt == FS_FAT32) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??f_mkfs_42
// 3762 		ST_DWORD(tbl+BS_VolID32, n);		/* VSN */
        LDR      R0,[SP, #+0]
        STRB     R0,[R7, #+67]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+68]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R7, #+69]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R7, #+70]
// 3763 		ST_DWORD(tbl+BPB_FATSz32, n_fat);	/* Number of sectors per FAT */
        STRB     R11,[R7, #+36]
        MOV      R0,R11
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+37]
        MOV      R0,R11
        LSRS     R0,R0,#+16
        STRB     R0,[R7, #+38]
        MOV      R0,R11
        LSRS     R0,R0,#+24
        STRB     R0,[R7, #+39]
// 3764 		ST_DWORD(tbl+BPB_RootClus, 2);		/* Root directory start cluster (2) */
        MOVS     R0,#+2
        STRB     R0,[R7, #+44]
        MOVS     R0,#+0
        STRB     R0,[R7, #+45]
        MOVS     R0,#+0
        STRB     R0,[R7, #+46]
        MOVS     R0,#+0
        STRB     R0,[R7, #+47]
// 3765 		ST_WORD(tbl+BPB_FSInfo, 1);			/* FSInfo record offset (VBR+1) */
        MOVS     R0,#+1
        STRB     R0,[R7, #+48]
        MOVS     R0,#+0
        STRB     R0,[R7, #+49]
// 3766 		ST_WORD(tbl+BPB_BkBootSec, 6);		/* Backup boot record offset (VBR+6) */
        MOVS     R0,#+6
        STRB     R0,[R7, #+50]
        MOVS     R0,#+0
        STRB     R0,[R7, #+51]
// 3767 		tbl[BS_DrvNum32] = 0x80;			/* Drive number */
        MOVS     R0,#+128
        STRB     R0,[R7, #+64]
// 3768 		tbl[BS_BootSig32] = 0x29;			/* Extended boot signature */
        MOVS     R0,#+41
        STRB     R0,[R7, #+66]
// 3769 		mem_cpy(tbl+BS_VolLab32, "NO NAME    " "FAT32   ", 19);	/* Volume label, FAT signature */
        MOVS     R2,#+19
        LDR.N    R1,??DataTable5_5
        ADDS     R0,R7,#+71
        BL       mem_cpy
        B.N      ??f_mkfs_43
// 3770 	} else {
// 3771 		ST_DWORD(tbl+BS_VolID, n);			/* VSN */
??f_mkfs_42:
        LDR      R0,[SP, #+0]
        STRB     R0,[R7, #+39]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+40]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R7, #+41]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R7, #+42]
// 3772 		ST_WORD(tbl+BPB_FATSz16, n_fat);	/* Number of sectors per FAT */
        STRB     R11,[R7, #+22]
        MOV      R0,R11
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+23]
// 3773 		tbl[BS_DrvNum] = 0x80;				/* Drive number */
        MOVS     R0,#+128
        STRB     R0,[R7, #+36]
// 3774 		tbl[BS_BootSig] = 0x29;				/* Extended boot signature */
        MOVS     R0,#+41
        STRB     R0,[R7, #+38]
// 3775 		mem_cpy(tbl+BS_VolLab, "NO NAME    " "FAT     ", 19);	/* Volume label, FAT signature */
        MOVS     R2,#+19
        LDR.N    R1,??DataTable5_6
        ADDS     R0,R7,#+43
        BL       mem_cpy
// 3776 	}
// 3777 	ST_WORD(tbl+BS_55AA, 0xAA55);			/* Signature (Offset is fixed here regardless of sector size) */
??f_mkfs_43:
        MOVS     R0,#+85
        STRB     R0,[R7, #+510]
        MOVS     R0,#+170
        STRB     R0,[R7, #+511]
// 3778 	if (disk_write(drv, tbl, b_vol, 1) != RES_OK)	/* Write VBR */
        MOVS     R3,#+1
        MOV      R2,R10
        MOVS     R1,R7
        LDRB     R0,[SP, #+24]
        BL       disk_write
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_44
// 3779 		return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3780 	if (fmt == FS_FAT32)							/* Write backup VBR if needed (VBR+6) */
??f_mkfs_44:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??f_mkfs_45
// 3781 		disk_write(drv, tbl, b_vol + 6, 1);
        MOVS     R3,#+1
        ADDS     R2,R10,#+6
        MOVS     R1,R7
        LDRB     R0,[SP, #+24]
        BL       disk_write
// 3782 
// 3783 	/* Initialize FAT area */
// 3784 	wsect = b_fat;
??f_mkfs_45:
        LDR      R9,[SP, #+20]
// 3785 	for (i = 0; i < N_FATS; i++) {		/* Initialize each FAT copy */
        MOVS     R4,#+0
        B.N      ??f_mkfs_46
??f_mkfs_47:
        ADDS     R4,R4,#+1
??f_mkfs_46:
        CMP      R4,#+0
        BNE.N    ??f_mkfs_48
// 3786 		mem_set(tbl, 0, SS(fs));			/* 1st sector of the FAT  */
        MOV      R2,#+512
        MOVS     R1,#+0
        MOVS     R0,R7
        BL       mem_set
// 3787 		n = md;								/* Media descriptor byte */
        LDRB     R0,[SP, #+8]
        STR      R0,[SP, #+0]
// 3788 		if (fmt != FS_FAT32) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BEQ.N    ??f_mkfs_49
// 3789 			n |= (fmt == FS_FAT12) ? 0x00FFFF00 : 0xFFFFFF00;
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+1
        BNE.N    ??f_mkfs_50
        LDR.N    R0,??DataTable5_7  ;; 0xffff00
        B.N      ??f_mkfs_51
??f_mkfs_50:
        MVNS     R0,#+255
??f_mkfs_51:
        LDR      R1,[SP, #+0]
        ORRS     R0,R0,R1
        STR      R0,[SP, #+0]
// 3790 			ST_DWORD(tbl+0, n);				/* Reserve cluster #0-1 (FAT12/16) */
        LDR      R0,[SP, #+0]
        STRB     R0,[R7, #+0]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+1]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R7, #+2]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R7, #+3]
        B.N      ??f_mkfs_52
// 3791 		} else {
// 3792 			n |= 0xFFFFFF00;
??f_mkfs_49:
        LDR      R0,[SP, #+0]
        ORNS     R0,R0,#+255
        STR      R0,[SP, #+0]
// 3793 			ST_DWORD(tbl+0, n);				/* Reserve cluster #0-1 (FAT32) */
        LDR      R0,[SP, #+0]
        STRB     R0,[R7, #+0]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+1]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R7, #+2]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R7, #+3]
// 3794 			ST_DWORD(tbl+4, 0xFFFFFFFF);
        MOVS     R0,#+255
        STRB     R0,[R7, #+4]
        MOVS     R0,#+255
        STRB     R0,[R7, #+5]
        MOVS     R0,#+255
        STRB     R0,[R7, #+6]
        MOVS     R0,#+255
        STRB     R0,[R7, #+7]
// 3795 			ST_DWORD(tbl+8, 0x0FFFFFFF);	/* Reserve cluster #2 for root dir */
        MOVS     R0,#+255
        STRB     R0,[R7, #+8]
        MOVS     R0,#+255
        STRB     R0,[R7, #+9]
        MOVS     R0,#+255
        STRB     R0,[R7, #+10]
        MOVS     R0,#+15
        STRB     R0,[R7, #+11]
// 3796 		}
// 3797 		if (disk_write(drv, tbl, wsect++, 1) != RES_OK)
??f_mkfs_52:
        MOVS     R3,#+1
        MOV      R2,R9
        MOVS     R1,R7
        LDRB     R0,[SP, #+24]
        BL       disk_write
        ADDS     R9,R9,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_mkfs_53
// 3798 			return FR_DISK_ERR;
// 3799 		mem_set(tbl, 0, SS(fs));			/* Fill following FAT entries with zero */
??f_mkfs_54:
        MOV      R2,#+512
        MOVS     R1,#+0
        MOVS     R0,R7
        BL       mem_set
// 3800 		for (n = 1; n < n_fat; n++) {		/* This loop may take a time on FAT32 volume due to many single sector writes */
        MOVS     R0,#+1
        STR      R0,[SP, #+0]
        B.N      ??f_mkfs_55
??f_mkfs_53:
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
??f_mkfs_56:
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+0]
??f_mkfs_55:
        LDR      R0,[SP, #+0]
        CMP      R0,R11
        BCS.N    ??f_mkfs_47
// 3801 			if (disk_write(drv, tbl, wsect++, 1) != RES_OK)
        MOVS     R3,#+1
        MOV      R2,R9
        MOVS     R1,R7
        LDRB     R0,[SP, #+24]
        BL       disk_write
        ADDS     R9,R9,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_56
// 3802 				return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3803 		}
// 3804 	}
// 3805 
// 3806 	/* Initialize root directory */
// 3807 	i = (fmt == FS_FAT32) ? au : n_dir;
??f_mkfs_48:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??f_mkfs_57
        MOVS     R4,R5
        B.N      ??f_mkfs_58
??f_mkfs_57:
        LDR      R4,[SP, #+16]
// 3808 	do {
// 3809 		if (disk_write(drv, tbl, wsect++, 1) != RES_OK)
??f_mkfs_58:
        MOVS     R3,#+1
        MOV      R2,R9
        MOVS     R1,R7
        LDRB     R0,[SP, #+24]
        BL       disk_write
        ADDS     R9,R9,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_mkfs_59
// 3810 			return FR_DISK_ERR;
// 3811 	} while (--i);
??f_mkfs_60:
        SUBS     R4,R4,#+1
        CMP      R4,#+0
        BNE.N    ??f_mkfs_58
// 3812 
// 3813 #if _USE_ERASE	/* Erase data area if needed */
// 3814 	{
// 3815 		DWORD eb[2];
// 3816 
// 3817 		eb[0] = wsect; eb[1] = wsect + (n_clst - ((fmt == FS_FAT32) ? 1 : 0)) * au - 1;
// 3818 		disk_ioctl(drv, CTRL_ERASE_SECTOR, eb);
// 3819 	}
// 3820 #endif
// 3821 
// 3822 	/* Create FSInfo if needed */
// 3823 	if (fmt == FS_FAT32) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??f_mkfs_61
// 3824 		ST_DWORD(tbl+FSI_LeadSig, 0x41615252);
        MOVS     R0,#+82
        STRB     R0,[R7, #+0]
        MOVS     R0,#+82
        STRB     R0,[R7, #+1]
        MOVS     R0,#+97
        STRB     R0,[R7, #+2]
        MOVS     R0,#+65
        STRB     R0,[R7, #+3]
// 3825 		ST_DWORD(tbl+FSI_StrucSig, 0x61417272);
        MOVS     R0,#+114
        STRB     R0,[R7, #+484]
        MOVS     R0,#+114
        STRB     R0,[R7, #+485]
        MOVS     R0,#+65
        STRB     R0,[R7, #+486]
        MOVS     R0,#+97
        STRB     R0,[R7, #+487]
// 3826 		ST_DWORD(tbl+FSI_Free_Count, n_clst - 1);	/* Number of free clusters */
        MOV      R0,R8
        SUBS     R0,R0,#+1
        STRB     R0,[R7, #+488]
        MOV      R0,R8
        SUBS     R0,R0,#+1
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R7, #+489]
        SUBS     R0,R8,#+1
        LSRS     R0,R0,#+16
        STRB     R0,[R7, #+490]
        SUBS     R8,R8,#+1
        LSRS     R8,R8,#+24
        STRB     R8,[R7, #+491]
// 3827 		ST_DWORD(tbl+FSI_Nxt_Free, 2);				/* Last allocated cluster# */
        MOVS     R0,#+2
        STRB     R0,[R7, #+492]
        MOVS     R0,#+0
        STRB     R0,[R7, #+493]
        MOVS     R0,#+0
        STRB     R0,[R7, #+494]
        MOVS     R0,#+0
        STRB     R0,[R7, #+495]
// 3828 		ST_WORD(tbl+BS_55AA, 0xAA55);
        MOVS     R0,#+85
        STRB     R0,[R7, #+510]
        MOVS     R0,#+170
        STRB     R0,[R7, #+511]
// 3829 		disk_write(drv, tbl, b_vol + 1, 1);	/* Write original (VBR+1) */
        MOVS     R3,#+1
        ADDS     R2,R10,#+1
        MOVS     R1,R7
        LDRB     R0,[SP, #+24]
        BL       disk_write
// 3830 		disk_write(drv, tbl, b_vol + 7, 1);	/* Write backup (VBR+7) */
        MOVS     R3,#+1
        ADDS     R10,R10,#+7
        MOV      R2,R10
        MOVS     R1,R7
        LDRB     R0,[SP, #+24]
        BL       disk_write
// 3831 	}
// 3832 
// 3833 	return (disk_ioctl(drv, CTRL_SYNC, (void*)0) == RES_OK) ? FR_OK : FR_DISK_ERR;
??f_mkfs_61:
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDRB     R0,[SP, #+24]
        BL       disk_ioctl
        CMP      R0,#+0
        BNE.N    ??f_mkfs_62
        MOVS     R0,#+0
        B.N      ??f_mkfs_63
??f_mkfs_59:
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
??f_mkfs_62:
        MOVS     R0,#+1
??f_mkfs_63:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_mkfs_1:
        ADD      SP,SP,#+28
        POP      {R4-R11,PC}      ;; return
// 3834 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     FatFs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     `f_mkfs::vst`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     `f_mkfs::cst`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     0xfb0400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     0xffff00

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_0:
        DC8 "\"*+,:;<=>?[]|\177"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_1:
        DC8 "\353\376\220MSDOS5.0"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_2:
        DC8 "NO NAME    FAT32   "

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
?_3:
        DC8 "NO NAME    FAT     "

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
`f_mkfs::vst`:
        DC16 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 0
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
`f_mkfs::cst`:
        DC16 32768, 16384, 8192, 4096, 2048, 16384, 8192, 4096, 2048, 1024, 512
        DC8 0, 0
// 3835 
// 3836 #endif /* _USE_MKFS && !_FS_READONLY */
// 3837 
// 3838 
// 3839 
// 3840 
// 3841 #if _USE_STRFUNC
// 3842 /*-----------------------------------------------------------------------*/
// 3843 /* Get a string from the file                                            */
// 3844 /*-----------------------------------------------------------------------*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3845 TCHAR* f_gets (
// 3846 	TCHAR* buff,	/* Pointer to the string buffer to read */
// 3847 	int len,		/* Size of string buffer (characters) */
// 3848 	FIL* fil		/* Pointer to the file object */
// 3849 )
// 3850 {
f_gets:
        PUSH     {R2-R8,LR}
        MOVS     R5,R0
        MOVS     R7,R1
        MOV      R8,R2
// 3851 	int n = 0;
        MOVS     R4,#+0
// 3852 	TCHAR c, *p = buff;
        MOVS     R6,R5
// 3853 	BYTE s[2];
// 3854 	UINT rc;
// 3855 
// 3856 
// 3857 	while (n < len - 1) {			/* Read bytes until buffer gets filled */
??f_gets_0:
        SUBS     R0,R7,#+1
        CMP      R4,R0
        BGE.N    ??f_gets_1
// 3858 		f_read(fil, s, 1, &rc);
        ADD      R3,SP,#+4
        MOVS     R2,#+1
        MOV      R1,SP
        MOV      R0,R8
        BL       f_read
// 3859 		if (rc != 1) break;			/* Break on EOF or error */
        LDR      R0,[SP, #+4]
        CMP      R0,#+1
        BNE.N    ??f_gets_2
// 3860 		c = s[0];
??f_gets_3:
        LDRB     R0,[SP, #+0]
// 3861 #if _LFN_UNICODE					/* Read a character in UTF-8 encoding */
// 3862 		if (c >= 0x80) {
// 3863 			if (c < 0xC0) continue;	/* Skip stray trailer */
// 3864 			if (c < 0xE0) {			/* Two-byte sequense */
// 3865 				f_read(fil, s, 1, &rc);
// 3866 				if (rc != 1) break;
// 3867 				c = ((c & 0x1F) << 6) | (s[0] & 0x3F);
// 3868 				if (c < 0x80) c = '?';
// 3869 			} else {
// 3870 				if (c < 0xF0) {		/* Three-byte sequense */
// 3871 					f_read(fil, s, 2, &rc);
// 3872 					if (rc != 2) break;
// 3873 					c = (c << 12) | ((s[0] & 0x3F) << 6) | (s[1] & 0x3F);
// 3874 					if (c < 0x800) c = '?';
// 3875 				} else {			/* Reject four-byte sequense */
// 3876 					c = '?';
// 3877 				}
// 3878 			}
// 3879 		}
// 3880 #endif
// 3881 #if _USE_STRFUNC >= 2
// 3882 		if (c == '\r') continue;	/* Strip '\r' */
// 3883 #endif
// 3884 		*p++ = c;
        STRB     R0,[R6, #+0]
        ADDS     R6,R6,#+1
// 3885 		n++;
        ADDS     R4,R4,#+1
// 3886 		if (c == '\n') break;		/* Break on EOL */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+10
        BNE.N    ??f_gets_0
// 3887 	}
// 3888 	*p = 0;
??f_gets_1:
        MOVS     R0,#+0
        STRB     R0,[R6, #+0]
// 3889 	return n ? buff : 0;			/* When no data read (eof or error), return with error. */
        CMP      R4,#+0
        BEQ.N    ??f_gets_4
        B.N      ??f_gets_5
??f_gets_2:
        B.N      ??f_gets_1
??f_gets_4:
        MOVS     R5,#+0
??f_gets_5:
        MOVS     R0,R5
        POP      {R1,R2,R4-R8,PC}  ;; return
// 3890 }
// 3891 
// 3892 
// 3893 
// 3894 #if !_FS_READONLY
// 3895 #include <stdarg.h>
// 3896 /*-----------------------------------------------------------------------*/
// 3897 /* Put a character to the file                                           */
// 3898 /*-----------------------------------------------------------------------*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3899 int f_putc (
// 3900 	TCHAR c,	/* A character to be output */
// 3901 	FIL* fil	/* Pointer to the file object */
// 3902 )
// 3903 {
f_putc:
        PUSH     {R4,R5,LR}
        SUB      SP,SP,#+12
        MOVS     R4,R1
// 3904 	UINT bw, btw;
// 3905 	BYTE s[3];
// 3906 
// 3907 
// 3908 #if _USE_STRFUNC >= 2
// 3909 	if (c == '\n') f_putc ('\r', fil);	/* LF -> CRLF conversion */
// 3910 #endif
// 3911 
// 3912 #if _LFN_UNICODE	/* Write the character in UTF-8 encoding */
// 3913 	if (c < 0x80) {			/* 7-bit */
// 3914 		s[0] = (BYTE)c;
// 3915 		btw = 1;
// 3916 	} else {
// 3917 		if (c < 0x800) {	/* 11-bit */
// 3918 			s[0] = (BYTE)(0xC0 | (c >> 6));
// 3919 			s[1] = (BYTE)(0x80 | (c & 0x3F));
// 3920 			btw = 2;
// 3921 		} else {			/* 16-bit */
// 3922 			s[0] = (BYTE)(0xE0 | (c >> 12));
// 3923 			s[1] = (BYTE)(0x80 | ((c >> 6) & 0x3F));
// 3924 			s[2] = (BYTE)(0x80 | (c & 0x3F));
// 3925 			btw = 3;
// 3926 		}
// 3927 	}
// 3928 #else				/* Write the character without conversion */
// 3929 	s[0] = (BYTE)c;
        STRB     R0,[SP, #+0]
// 3930 	btw = 1;
        MOVS     R5,#+1
// 3931 #endif
// 3932 	f_write(fil, s, btw, &bw);		/* Write the char to the file */
        ADD      R3,SP,#+4
        MOVS     R2,R5
        MOV      R1,SP
        MOVS     R0,R4
        BL       f_write
// 3933 	return (bw == btw) ? 1 : EOF;	/* Return the result */
        LDR      R0,[SP, #+4]
        CMP      R0,R5
        BNE.N    ??f_putc_0
        MOVS     R0,#+1
        B.N      ??f_putc_1
??f_putc_0:
        MOVS     R0,#-1
??f_putc_1:
        POP      {R1-R5,PC}       ;; return
// 3934 }
// 3935 
// 3936 
// 3937 
// 3938 
// 3939 /*-----------------------------------------------------------------------*/
// 3940 /* Put a string to the file                                              */
// 3941 /*-----------------------------------------------------------------------*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3942 int f_puts (
// 3943 	const TCHAR* str,	/* Pointer to the string to be output */
// 3944 	FIL* fil			/* Pointer to the file object */
// 3945 )
// 3946 {
f_puts:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 3947 	int n;
// 3948 
// 3949 
// 3950 	for (n = 0; *str; str++, n++) {
        MOVS     R6,#+0
        B.N      ??f_puts_0
??f_puts_1:
        ADDS     R4,R4,#+1
        ADDS     R6,R6,#+1
??f_puts_0:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??f_puts_2
// 3951 		if (f_putc(*str, fil) == EOF) return EOF;
        MOVS     R1,R5
        LDRB     R0,[R4, #+0]
        BL       f_putc
        CMN      R0,#+1
        BNE.N    ??f_puts_1
        MOVS     R0,#-1
        B.N      ??f_puts_3
// 3952 	}
// 3953 	return n;
??f_puts_2:
        MOVS     R0,R6
??f_puts_3:
        POP      {R4-R6,PC}       ;; return
// 3954 }
// 3955 
// 3956 
// 3957 
// 3958 
// 3959 /*-----------------------------------------------------------------------*/
// 3960 /* Put a formatted string to the file                                    */
// 3961 /*-----------------------------------------------------------------------*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3962 int f_printf (
// 3963 	FIL* fil,			/* Pointer to the file object */
// 3964 	const TCHAR* str,	/* Pointer to the format string */
// 3965 	...					/* Optional arguments... */
// 3966 )
// 3967 {
f_printf:
        PUSH     {R0,R2,R3}
        PUSH     {R0-R11,LR}
        MOVS     R6,R1
// 3968 	va_list arp;
// 3969 	BYTE f, r;
// 3970 	UINT i, j, w;
// 3971 	ULONG v;
// 3972 	TCHAR c, d, s[16], *p;
// 3973 	int res, cc;
// 3974 
// 3975 
// 3976 	va_start(arp, str);
        ADD      R7,SP,#+56
// 3977 
// 3978 	for (cc = res = 0; cc != EOF; res += cc) {
        MOVS     R5,#+0
        MOVS     R0,R5
        B.N      ??f_printf_0
// 3979 		c = *str++;
// 3980 		if (c == 0) break;			/* End of string */
// 3981 		if (c != '%') {				/* Non escape character */
// 3982 			cc = f_putc(c, fil);
// 3983 			if (cc != EOF) cc = 1;
// 3984 			continue;
// 3985 		}
// 3986 		w = f = 0;
// 3987 		c = *str++;
// 3988 		if (c == '0') {				/* Flag: '0' padding */
// 3989 			f = 1; c = *str++;
// 3990 		} else {
// 3991 			if (c == '-') {			/* Flag: left justified */
// 3992 				f = 2; c = *str++;
// 3993 			}
// 3994 		}
// 3995 		while (IsDigit(c)) {		/* Precision */
// 3996 			w = w * 10 + c - '0';
// 3997 			c = *str++;
// 3998 		}
// 3999 		if (c == 'l' || c == 'L') {	/* Prefix: Size is long int */
// 4000 			f |= 4; c = *str++;
// 4001 		}
// 4002 		if (!c) break;
// 4003 		d = c;
// 4004 		if (IsLower(d)) d -= 0x20;
// 4005 		switch (d) {				/* Type is... */
// 4006 		case 'S' :					/* String */
// 4007 			p = va_arg(arp, TCHAR*);
// 4008 			for (j = 0; p[j]; j++) ;
// 4009 			res = 0;
// 4010 			while (!(f & 2) && j++ < w) res += (cc = f_putc(' ', fil));
// 4011 			res += (cc = f_puts(p, fil));
// 4012 			while (j++ < w) res += (cc = f_putc(' ', fil));
// 4013 			if (cc != EOF) cc = res;
// 4014 			continue;
// 4015 		case 'C' :					/* Character */
// 4016 			cc = f_putc((TCHAR)va_arg(arp, int), fil); continue;
// 4017 		case 'B' :					/* Binary */
// 4018 			r = 2; break;
// 4019 		case 'O' :					/* Octal */
// 4020 			r = 8; break;
// 4021 		case 'D' :					/* Signed decimal */
// 4022 		case 'U' :					/* Unsigned decimal */
// 4023 			r = 10; break;
// 4024 		case 'X' :					/* Hexdecimal */
// 4025 			r = 16; break;
// 4026 		default:					/* Unknown type (passthrough) */
// 4027 			cc = f_putc(c, fil); continue;
// 4028 		}
// 4029 
// 4030 		/* Get an argument and put it in numeral */
// 4031 		v = (f & 4) ? va_arg(arp, long) : ((d == 'D') ? (long)va_arg(arp, int) : va_arg(arp, unsigned int));
// 4032 		if (d == 'D' && (v & 0x80000000)) {
// 4033 			v = 0 - v;
// 4034 			f |= 8;
// 4035 		}
// 4036 		i = 0;
// 4037 		do {
// 4038 			d = (TCHAR)(v % r); v /= r;
// 4039 			if (d > 9) d += (c == 'x') ? 0x27 : 0x07;
// 4040 			s[i++] = d + '0';
// 4041 		} while (v && i < sizeof(s) / sizeof(s[0]));
// 4042 		if (f & 8) s[i++] = '-';
// 4043 		j = i; d = (f & 1) ? '0' : ' ';
// 4044 		res = 0;
// 4045 		while (!(f & 2) && j++ < w) res += (cc = f_putc(d, fil));
// 4046 		do res += (cc = f_putc(s[--i], fil)); while(i);
// 4047 		while (j++ < w) res += (cc = f_putc(' ', fil));
// 4048 		if (cc != EOF) cc = res;
??f_printf_1:
        CMN      R0,#+1
        BEQ.N    ??f_printf_2
        MOVS     R0,R5
        B.N      ??f_printf_2
??f_printf_3:
        MOV      R11,R2
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        SUBS     R0,R11,#+97
        CMP      R0,#+26
        BCS.N    ??f_printf_4
        SUBS     R11,R11,#+32
??f_printf_4:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        MOV      R0,R11
        CMP      R0,#+66
        BEQ.W    ??f_printf_5
        CMP      R0,#+67
        BEQ.W    ??f_printf_6
        CMP      R0,#+68
        BEQ.W    ??f_printf_7
        CMP      R0,#+79
        BEQ.W    ??f_printf_8
        CMP      R0,#+83
        BEQ.N    ??f_printf_9
        CMP      R0,#+85
        BEQ.W    ??f_printf_7
        CMP      R0,#+88
        BEQ.W    ??f_printf_10
??f_printf_11:
        LDR      R1,[SP, #+52]
        MOVS     R0,R2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
??f_printf_2:
        ADDS     R5,R0,R5
??f_printf_0:
        CMN      R0,#+1
        BEQ.N    ??f_printf_12
        LDRB     R2,[R6, #+0]
        ADDS     R6,R6,#+1
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BEQ.N    ??f_printf_13
??f_printf_14:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+37
        BEQ.N    ??f_printf_15
        LDR      R1,[SP, #+52]
        MOVS     R0,R2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
        CMN      R0,#+1
        BEQ.N    ??f_printf_16
        MOVS     R0,#+1
??f_printf_16:
        B.N      ??f_printf_2
// 4049 	}
// 4050 
// 4051 	va_end(arp);
// 4052 	return (cc == EOF) ? cc : res;
??f_printf_13:
??f_printf_12:
        CMN      R0,#+1
        BNE.W    ??f_printf_17
        B.N      ??f_printf_18
??f_printf_15:
        MOVS     R8,#+0
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        MOV      R9,R8
        LDRB     R2,[R6, #+0]
        ADDS     R6,R6,#+1
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+48
        BNE.N    ??f_printf_19
        MOVS     R8,#+1
        LDRB     R2,[R6, #+0]
        ADDS     R6,R6,#+1
        B.N      ??f_printf_20
??f_printf_19:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+45
        BNE.N    ??f_printf_20
        MOVS     R8,#+2
        LDRB     R2,[R6, #+0]
        ADDS     R6,R6,#+1
        B.N      ??f_printf_20
??f_printf_21:
        MOVS     R1,#+10
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MLA      R9,R1,R9,R2
        SUBS     R9,R9,#+48
        LDRB     R2,[R6, #+0]
        ADDS     R6,R6,#+1
??f_printf_20:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        SUBS     R1,R2,#+48
        CMP      R1,#+10
        BCC.N    ??f_printf_21
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+108
        BEQ.N    ??f_printf_22
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+76
        BNE.N    ??f_printf_23
??f_printf_22:
        ORRS     R8,R8,#0x4
        LDRB     R2,[R6, #+0]
        ADDS     R6,R6,#+1
??f_printf_23:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BNE.N    ??f_printf_3
        B.N      ??f_printf_12
??f_printf_9:
        LDR      R4,[R7, #+0]
        ADDS     R7,R7,#+4
        MOVS     R10,#+0
        B.N      ??f_printf_24
??f_printf_25:
        ADDS     R10,R10,#+1
??f_printf_24:
        LDRB     R0,[R4, R10]
        CMP      R0,#+0
        BNE.N    ??f_printf_25
        MOVS     R5,#+0
        B.N      ??f_printf_26
??f_printf_27:
        LDR      R1,[SP, #+52]
        MOVS     R0,#+32
        BL       f_putc
        ADDS     R5,R0,R5
??f_printf_26:
        LSLS     R0,R8,#+30
        BMI.N    ??f_printf_28
        MOV      R0,R10
        ADDS     R10,R0,#+1
        CMP      R0,R9
        BCC.N    ??f_printf_27
??f_printf_28:
        LDR      R1,[SP, #+52]
        MOVS     R0,R4
        BL       f_puts
        ADDS     R5,R0,R5
        B.N      ??f_printf_29
??f_printf_30:
        LDR      R1,[SP, #+52]
        MOVS     R0,#+32
        BL       f_putc
        ADDS     R5,R0,R5
??f_printf_29:
        MOV      R1,R10
        ADDS     R10,R1,#+1
        CMP      R1,R9
        BCC.N    ??f_printf_30
        CMN      R0,#+1
        BEQ.N    ??f_printf_31
        MOVS     R0,R5
??f_printf_31:
        B.N      ??f_printf_2
??f_printf_6:
        LDR      R0,[R7, #+0]
        ADDS     R7,R7,#+4
        LDR      R1,[SP, #+52]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
        B.N      ??f_printf_2
??f_printf_5:
        MOVS     R1,#+2
??f_printf_32:
        LSLS     R0,R8,#+29
        BPL.N    ??f_printf_33
        LDR      R0,[R7, #+0]
        ADDS     R7,R7,#+4
        B.N      ??f_printf_34
??f_printf_8:
        MOVS     R1,#+8
        B.N      ??f_printf_32
??f_printf_7:
        MOVS     R1,#+10
        B.N      ??f_printf_32
??f_printf_10:
        MOVS     R1,#+16
        B.N      ??f_printf_32
??f_printf_33:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+68
        BNE.N    ??f_printf_35
        LDR      R0,[R7, #+0]
        ADDS     R7,R7,#+4
        B.N      ??f_printf_34
??f_printf_35:
        LDR      R0,[R7, #+0]
        ADDS     R7,R7,#+4
??f_printf_34:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+68
        BNE.N    ??f_printf_36
        CMP      R0,#+0
        BPL.N    ??f_printf_36
        RSBS     R0,R0,#+0
        ORRS     R8,R8,#0x8
??f_printf_36:
        MOVS     R4,#+0
??f_printf_37:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        UDIV     R11,R0,R1
        MLS      R11,R1,R11,R0
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        UDIV     R0,R0,R1
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+10
        BLT.N    ??f_printf_38
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+120
        BNE.N    ??f_printf_39
        MOVS     R3,#+39
        B.N      ??f_printf_40
??f_printf_39:
        MOVS     R3,#+7
??f_printf_40:
        ADDS     R11,R3,R11
??f_printf_38:
        ADDS     R11,R11,#+48
        MOV      R3,SP
        STRB     R11,[R3, R4]
        ADDS     R4,R4,#+1
        CMP      R0,#+0
        BEQ.N    ??f_printf_41
        CMP      R4,#+16
        BCC.N    ??f_printf_37
??f_printf_41:
        LSLS     R0,R8,#+28
        BPL.N    ??f_printf_42
        MOVS     R0,#+45
        MOV      R1,SP
        STRB     R0,[R1, R4]
        ADDS     R4,R4,#+1
??f_printf_42:
        MOV      R10,R4
        LSLS     R0,R8,#+31
        BPL.N    ??f_printf_43
        MOVS     R11,#+48
        B.N      ??f_printf_44
??f_printf_43:
        MOVS     R11,#+32
??f_printf_44:
        MOVS     R5,#+0
        B.N      ??f_printf_45
??f_printf_46:
        LDR      R1,[SP, #+52]
        MOV      R0,R11
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
        ADDS     R5,R0,R5
??f_printf_45:
        LSLS     R0,R8,#+30
        BMI.N    ??f_printf_47
        MOV      R0,R10
        ADDS     R10,R0,#+1
        CMP      R0,R9
        BCC.N    ??f_printf_46
??f_printf_47:
        SUBS     R4,R4,#+1
        LDR      R1,[SP, #+52]
        MOV      R0,SP
        LDRB     R0,[R0, R4]
        BL       f_putc
        ADDS     R5,R0,R5
        CMP      R4,#+0
        BNE.N    ??f_printf_47
??f_printf_48:
        MOV      R1,R10
        ADDS     R10,R1,#+1
        CMP      R1,R9
        BCS.W    ??f_printf_1
        LDR      R1,[SP, #+52]
        MOVS     R0,#+32
        BL       f_putc
        ADDS     R5,R0,R5
        B.N      ??f_printf_48
??f_printf_17:
        MOVS     R0,R5
??f_printf_18:
        ADD      SP,SP,#+16
        POP      {R4-R11}
        LDR      PC,[SP], #+16    ;; return
// 4053 }

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 4054 
// 4055 #endif /* !_FS_READONLY */
// 4056 #endif /* _USE_STRFUNC */
// 
//      6 bytes in section .bss
//    116 bytes in section .rodata
// 10 086 bytes in section .text
// 
// 10 086 bytes of CODE  memory
//    116 bytes of CONST memory
//      6 bytes of DATA  memory
//
//Errors: none
//Warnings: none
