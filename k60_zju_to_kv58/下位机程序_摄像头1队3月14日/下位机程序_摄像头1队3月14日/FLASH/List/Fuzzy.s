///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.30.3.8024/W32 for ARM       14/Mar/2018  19:12:11
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\Fuzzy.c
//    Command line =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\Fuzzy.c
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
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\List\Fuzzy.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN AbsInt
        EXTERN BlackLeftDone
        EXTERN BlackLeftHeadLine
        EXTERN BlackRightDone
        EXTERN BlackRightHeadLine
        EXTERN BlackUdisLeftLocation
        EXTERN BlackUdisRightLocation
        EXTERN CenterLineLoc
        EXTERN DeviFuse
        EXTERN DeviPre
        EXTERN DeviPrePre
        EXTERN DeviPrePrePre
        EXTERN Devi_far
        EXTERN Devi_near
        EXTERN QuadLeftCount
        EXTERN QuadRightCount
        EXTERN __aeabi_d2f
        EXTERN __aeabi_d2iz
        EXTERN __aeabi_dadd
        EXTERN __aeabi_ddiv
        EXTERN __aeabi_dmul
        EXTERN __aeabi_f2d
        EXTERN __aeabi_f2iz
        EXTERN __aeabi_fadd
        EXTERN __aeabi_fmul
        EXTERN __aeabi_fsub
        EXTERN __aeabi_i2d
        EXTERN __aeabi_i2f
        EXTERN sqrt

        PUBLIC BiasCal
        PUBLIC ControlRow_Weight
        PUBLIC DeviFuse_dot
        PUBLIC DeviFuse_dotmtr
        PUBLIC DeviFusemtr
        PUBLIC DeviationFuse
        PUBLIC MtrGet
        PUBLIC QuadLastLeftCount
        PUBLIC QuadLastRightCount
        PUBLIC SpeedLastLeft
        PUBLIC SpeedLastRight
        PUBLIC SpeedNowLeft
        PUBLIC SpeedNowRight
        PUBLIC SpeedRealTimeGet
        PUBLIC speed_fu
        PUBLIC speed_grade

// E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\Fuzzy.c
//    1 /******************************************************************************/
//    2 /*******************************************************************************
//    3   文件名：Fuzzy.c
//    4   功  能：偏差处理，模糊控制
//    5   日  期：2015.05.29
//    6   作  者：YCR
//    7   备  注：
//    8 *******************************************************************************/
//    9 /******************************************************************************/
//   10 
//   11 #include "Fuzzy.h"
//   12 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   13 uint16 SpeedNowLeft = 0;                //左电机实时脉冲数，对应300线编码器的脉冲数。
SpeedNowLeft:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   14 uint16 SpeedNowRight = 0;               //右电机实时脉冲数，对应300线编码器的脉冲数。
SpeedNowRight:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   15 uint16 SpeedLastLeft = 0;               //上一次左电机实时脉冲数，对应300线编码器的脉冲数。
SpeedLastLeft:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   16 uint16 SpeedLastRight = 0;              //上一次右电机实时脉冲数，对应300线编码器的脉冲数。
SpeedLastRight:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   17 uint16 QuadLastLeftCount=0;
QuadLastLeftCount:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   18 uint16 QuadLastRightCount=0;
QuadLastRightCount:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   19 uint16 speed_fu=0;                      //速度隶属度求取
speed_fu:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   20 uint8 speed_grade=0;                    //速度等级
speed_grade:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   21 int32 DeviFusemtr[11];             //偏差的隶属度
DeviFusemtr:
        DS8 44

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   22 int32 DeviFuse_dotmtr[9];         //偏差变化率隶属度
DeviFuse_dotmtr:
        DS8 36

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   23 int32 DeviFuse_dot;               //偏差的变化率
DeviFuse_dot:
        DS8 4
//   24 //多行控制的行的权重，控制量是近行偏差

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   25 uint8 ControlRow_Weight[2][6] =
ControlRow_Weight:
        DATA
        DC8 30, 40, 60, 80, 100, 100, 20, 16, 12, 7, 5, 0
//   26 {
//   27 30,40,60,80,100,100, //近行权重
//   28 20,16,12,7,5,0  //远行权重
//   29 //25,20,15,9,7,1  //远行权重
//   30 };
//   31 
//   32 
//   33 //======================================================================
//   34 //函数名：BiasCal
//   35 //功  能：计算给定行的偏移量
//   36 //参  数：row给定的计算行(1到ROW_MAX_UNDIS)(注意取值范围)
//   37 //影  响：
//   38 //返  回：bias该行的偏差
//   39 //说  明：1. 这个函数在DeviationFuse函数中调用，也就是至少有一条线成功才有可能调用本函数。
//   40 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 int32 BiasCal(int32 row)
//   42 {
BiasCal:
        PUSH     {R3-R9,LR}
        MOVS     R4,R0
//   43   int32 searchline;  //搜索行
//   44   int32 leftborder, rightborder; //左右边界
//   45   int32 bias;       //偏差
//   46   float offset;     //偏移量
//   47   float slope;      //斜率
//   48   
//   49   //不用判断Done标志，因为只有黑线提取成功才不会是MaxValUint8，才有可能小于row.
//   50   
//   51   //左右黑线均有效
//   52   
//   53   if(BlackLeftDone == 1 && BlackRightDone == 1)
        LDR.W    R1,??DataTable0
        LDRB     R1,[R1, #+0]
        CMP      R1,#+1
        BNE.W    ??BiasCal_0
        LDR.W    R1,??DataTable0_1
        LDRB     R1,[R1, #+0]
        CMP      R1,#+1
        BNE.W    ??BiasCal_0
//   54   {
//   55     //左右黑线头均满足
//   56     if(BlackUdisLeftLocation[BlackLeftHeadLine].y <= row && BlackUdisRightLocation[BlackRightHeadLine].y <= row)
        LDR.W    R0,??DataTable0_2
        LDR.W    R1,??DataTable0_3
        LDRB     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+3
        LDR      R0,[R0, #+4]
        CMP      R4,R0
        BLT.W    ??BiasCal_1
        LDR.W    R0,??DataTable0_4
        LDR.W    R1,??DataTable0_5
        LDRB     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+3
        LDR      R0,[R0, #+4]
        CMP      R4,R0
        BLT.W    ??BiasCal_1
//   57     {
//   58       //搜索该行在哪两行之间(这里直接搜索左线就行了，不用搜索右线)
//   59       for(searchline = BlackLeftHeadLine; searchline <= CameraHight - 1; searchline++)
        LDR.W    R0,??DataTable0_3
        LDRB     R6,[R0, #+0]
        B.N      ??BiasCal_2
??BiasCal_3:
        ADDS     R6,R6,#+1
??BiasCal_2:
        CMP      R6,#+60
        BGE.N    ??BiasCal_4
//   60       {
//   61         if(BlackUdisLeftLocation[searchline].y >= row)
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        CMP      R0,R4
        BLT.N    ??BiasCal_3
//   62         {
//   63           break;
//   64         }      
//   65       }
//   66       
//   67       //左右边界求取
//   68       //如果刚好在线头上，就直接按该线头所在列作为左右边界。
//   69       if(searchline == BlackLeftHeadLine)
??BiasCal_4:
        LDR.W    R0,??DataTable0_3
        LDRB     R0,[R0, #+0]
        CMP      R6,R0
        BNE.N    ??BiasCal_5
//   70       {
//   71         leftborder = BlackUdisLeftLocation[searchline].x;
        LDR.W    R0,??DataTable0_2
        LDR      R7,[R0, R6, LSL #+3]
//   72         rightborder = BlackUdisRightLocation[searchline].x;
        LDR.W    R0,??DataTable0_4
        LDR      R4,[R0, R6, LSL #+3]
        B.N      ??BiasCal_6
//   73       }
//   74       else
//   75       {      
//   76           if((BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y)!=0 && (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y)!=0)
??BiasCal_5:
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R0,R0,R1
        CMP      R0,#+0
        BEQ.N    ??BiasCal_7
        LDR.W    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R0,R0,R1
        CMP      R0,#+0
        BEQ.N    ??BiasCal_7
//   77           {
//   78         //插值计算该行畸变矫正后的左边界
//   79         leftborder = (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
//   80                    / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y) + BlackUdisLeftLocation[searchline-1].x;
        LDR.W    R0,??DataTable0_2
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R1,R4,R1
        MULS     R0,R1,R0
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+4]
        LDR.W    R2,??DataTable0_2
        ADDS     R2,R2,R6, LSL #+3
        LDR      R2,[R2, #-4]
        SUBS     R1,R1,R2
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        ADDS     R7,R1,R0
//   81         //插值计算该行畸变矫正后的右边界
//   82         rightborder = (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
//   83                     / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y) + BlackUdisRightLocation[searchline-1].x;
        LDR.W    R0,??DataTable0_4
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R1,R4,R1
        MULS     R0,R1,R0
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+4]
        LDR.W    R2,??DataTable0_4
        ADDS     R2,R2,R6, LSL #+3
        LDR      R2,[R2, #-4]
        SUBS     R1,R1,R2
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        ADDS     R4,R1,R0
        B.N      ??BiasCal_6
//   84           }
//   85           else
//   86           {
//   87              //插值计算该行畸变矫正后的左边界
//   88         leftborder = (int)((BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
//   89                    / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y+0.1) + BlackUdisLeftLocation[searchline-1].x);
??BiasCal_7:
        LDR.W    R0,??DataTable0_2
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R1,R4,R1
        MULS     R0,R1,R0
        BL       __aeabi_i2d
        MOV      R8,R0
        MOV      R9,R1
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        LDR.W    R2,??DataTable0_6  ;; 0x9999999a
        LDR.W    R3,??DataTable0_7  ;; 0x3fb99999
        BL       __aeabi_dadd
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ddiv
        MOV      R8,R0
        MOV      R9,R1
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #-8]
        BL       __aeabi_i2d
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
        MOVS     R7,R0
//   90         //插值计算该行畸变矫正后的右边界
//   91         rightborder = (int)((BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
//   92                     / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y+0.1) + BlackUdisRightLocation[searchline-1].x);
        LDR.W    R0,??DataTable0_4
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R1,R4,R1
        MULS     R0,R1,R0
        BL       __aeabi_i2d
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        LDR.W    R2,??DataTable0_6  ;; 0x9999999a
        LDR.W    R3,??DataTable0_7  ;; 0x3fb99999
        BL       __aeabi_dadd
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_ddiv
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #-8]
        BL       __aeabi_i2d
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
        MOVS     R4,R0
//   93           }
//   94       }
//   95       
//   96       //偏差求取，物理中心点与实际中心点的差即为偏差
//   97       bias = CameraRealWidth / 2 - (leftborder + rightborder) / 2;
??BiasCal_6:
        ADDS     R0,R4,R7
        MOVS     R1,#+2
        SDIV     R0,R0,R1
        RSBS     R0,R0,#+125
        B.W      ??BiasCal_8
//   98       
//   99     }
//  100     //只有左线头满足
//  101     else if(BlackUdisLeftLocation[BlackLeftHeadLine].y <= row)
??BiasCal_1:
        LDR.W    R0,??DataTable0_2
        LDR.W    R1,??DataTable0_3
        LDRB     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+3
        LDR      R0,[R0, #+4]
        CMP      R4,R0
        BLT.W    ??BiasCal_9
//  102     {
//  103       //搜索该行在哪两行之间
//  104       for(searchline = BlackLeftHeadLine; searchline <= CameraHight - 1; searchline++)
        LDR.W    R0,??DataTable0_3
        LDRB     R6,[R0, #+0]
        B.N      ??BiasCal_10
??BiasCal_11:
        ADDS     R6,R6,#+1
??BiasCal_10:
        CMP      R6,#+60
        BGE.N    ??BiasCal_12
//  105       {
//  106         if(BlackUdisLeftLocation[searchline].y >= row)
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        CMP      R0,R4
        BLT.N    ??BiasCal_11
//  107         {
//  108           break;
//  109         }
//  110       }
//  111       
//  112       //左边界求取
//  113       if(searchline == BlackLeftHeadLine)
??BiasCal_12:
        LDR.W    R0,??DataTable0_3
        LDRB     R0,[R0, #+0]
        CMP      R6,R0
        BNE.N    ??BiasCal_13
//  114       {
//  115         leftborder = BlackUdisLeftLocation[searchline].x;
        LDR.W    R0,??DataTable0_2
        LDR      R7,[R0, R6, LSL #+3]
        B.N      ??BiasCal_14
//  116       }
//  117       else
//  118       {     
//  119         //插值计算该行畸变矫正后的左黑线的列
//  120         leftborder = (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
//  121                    / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y) + BlackUdisLeftLocation[searchline-1].x;
??BiasCal_13:
        LDR.W    R0,??DataTable0_2
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R1,R4,R1
        MULS     R0,R1,R0
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+4]
        LDR.W    R2,??DataTable0_2
        ADDS     R2,R2,R6, LSL #+3
        LDR      R2,[R2, #-4]
        SUBS     R1,R1,R2
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        ADDS     R7,R1,R0
//  122       }
//  123       
//  124       //偏移量求取，通过斜率估算偏移量。
//  125       if(searchline <= CameraHight-5 && searchline == BlackLeftHeadLine)
??BiasCal_14:
        CMP      R6,#+56
        BGE.N    ??BiasCal_15
        LDR.W    R0,??DataTable0_3
        LDRB     R0,[R0, #+0]
        CMP      R6,R0
        BNE.N    ??BiasCal_15
//  126       {
//  127         slope = 1.0 * (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline+4].x) / 
//  128                       (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline+4].y);
        LDR.W    R0,??DataTable0_2
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_16
//  129       }
//  130       else if(searchline <= CameraHight-5)
??BiasCal_15:
        CMP      R6,#+56
        BGE.N    ??BiasCal_17
//  131       {
//  132         slope = 1.0 * (BlackUdisLeftLocation[searchline-1].x - BlackUdisLeftLocation[searchline+4].x) / 
//  133                       (BlackUdisLeftLocation[searchline-1].y - BlackUdisLeftLocation[searchline+4].y);
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #-8]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #-4]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_16
//  134       }
//  135       else
//  136       {
//  137         slope = 0;
??BiasCal_17:
        MOVS     R5,#+0
//  138       }
//  139       //超然的计算公式
//  140       offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
??BiasCal_16:
        MOVS     R0,R5
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,#+1065353216
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        BL       sqrt
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1_1  ;; 0x40690000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        MOVS     R3,#+1073741824
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOV      R8,R0
//  141       
//  142       //偏差求取
//  143       bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //记得加括号
        MOVS     R0,R7
        BL       __aeabi_i2f
        MOV      R1,R8
        BL       __aeabi_fadd
        BL       __aeabi_f2iz
        RSBS     R0,R0,#+125
        B.W      ??BiasCal_8
//  144     }
//  145     //只有右线头满足
//  146     else if(BlackUdisRightLocation[BlackRightHeadLine].y <= row)
??BiasCal_9:
        LDR.W    R0,??DataTable0_4
        LDR.W    R1,??DataTable0_5
        LDRB     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+3
        LDR      R0,[R0, #+4]
        CMP      R4,R0
        BLT.W    ??BiasCal_18
//  147     {
//  148       //搜索该行在哪两行之间
//  149       for(searchline = BlackRightHeadLine; searchline <= CameraHight - 1; searchline++)
        LDR.W    R0,??DataTable0_5
        LDRB     R6,[R0, #+0]
        B.N      ??BiasCal_19
??BiasCal_20:
        ADDS     R6,R6,#+1
??BiasCal_19:
        CMP      R6,#+60
        BGE.N    ??BiasCal_21
//  150       {
//  151         if(BlackUdisRightLocation[searchline].y >= row)
        LDR.W    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        CMP      R0,R4
        BLT.N    ??BiasCal_20
//  152         {
//  153           break;
//  154         }
//  155       }
//  156       
//  157       //右边界求取
//  158       if(searchline == BlackRightHeadLine)
??BiasCal_21:
        LDR.W    R0,??DataTable0_5
        LDRB     R0,[R0, #+0]
        CMP      R6,R0
        BNE.N    ??BiasCal_22
//  159       {
//  160         rightborder = BlackUdisRightLocation[searchline].x;
        LDR.W    R0,??DataTable0_4
        LDR      R4,[R0, R6, LSL #+3]
        B.N      ??BiasCal_23
//  161       }
//  162       else
//  163       {
//  164         //插值计算该行畸变矫正后的左黑线的列
//  165         rightborder = (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
//  166                     / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y) + BlackUdisRightLocation[searchline-1].x;
??BiasCal_22:
        LDR.W    R0,??DataTable0_4
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R1,R4,R1
        MULS     R0,R1,R0
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+4]
        LDR.W    R2,??DataTable0_4
        ADDS     R2,R2,R6, LSL #+3
        LDR      R2,[R2, #-4]
        SUBS     R1,R1,R2
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        ADDS     R4,R1,R0
//  167       }
//  168       
//  169       //偏移量求取，通过斜率估算偏移量。
//  170       if(searchline <= CameraHight-5 && searchline == BlackRightHeadLine)
??BiasCal_23:
        CMP      R6,#+56
        BGE.N    ??BiasCal_24
        LDR.W    R0,??DataTable0_5
        LDRB     R0,[R0, #+0]
        CMP      R6,R0
        BNE.N    ??BiasCal_24
//  171       {
//  172         slope = 1.0 * (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline+4].x) / 
//  173                       (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline+4].y);
        LDR.W    R0,??DataTable0_4
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDR.W    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_25
//  174       }
//  175       else if(searchline <= CameraHight-5)
??BiasCal_24:
        CMP      R6,#+56
        BGE.N    ??BiasCal_26
//  176       {
//  177         slope = 1.0 * (BlackUdisRightLocation[searchline-1].x - BlackUdisRightLocation[searchline+4].x) / 
//  178                       (BlackUdisRightLocation[searchline-1].y - BlackUdisRightLocation[searchline+4].y);
        LDR.W    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #-8]
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDR.W    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #-4]
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_25
//  179       }
//  180       else
//  181       {
//  182         slope = 0;
??BiasCal_26:
        MOVS     R5,#+0
//  183       }
//  184       //超然的计算公式
//  185       offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
??BiasCal_25:
        MOVS     R0,R5
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,#+1065353216
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        BL       sqrt
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1_1  ;; 0x40690000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        MOVS     R3,#+1073741824
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOV      R8,R0
//  186       
//  187       //偏差求取
//  188       bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //记得加括号
        MOVS     R0,R4
        BL       __aeabi_i2f
        MOV      R1,R8
        BL       __aeabi_fsub
        BL       __aeabi_f2iz
        RSBS     R0,R0,#+125
        B.N      ??BiasCal_8
//  189     }
//  190     //左右线头均不满足
//  191     else
//  192     {
//  193       
//  194       //左线头比右线头远，同时也包括了左线成功右线失败的情况。(失败时是MaxValUint8)
//  195       //
//  196       if(BlackLeftHeadLine <= BlackRightHeadLine)
??BiasCal_18:
        LDR.W    R0,??DataTable0_5
        LDRB     R0,[R0, #+0]
        LDR.W    R1,??DataTable0_3
        LDRB     R1,[R1, #+0]
        CMP      R0,R1
        BCC.N    ??BiasCal_27
//  197       {
//  198         //直将把左线头作为基本计算行
//  199         searchline = BlackLeftHeadLine;
        LDR.W    R0,??DataTable0_3
        LDRB     R6,[R0, #+0]
//  200               
//  201         //计算斜率
//  202         if(searchline <= CameraHight-5)
        CMP      R6,#+56
        BGE.N    ??BiasCal_28
//  203         {
//  204           slope = 1.0 * (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline+4].x) / 
//  205                         (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline+4].y);
        LDR.W    R0,??DataTable0_2
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_29
//  206         }
//  207         
//  208         else
//  209         {
//  210           slope = 0;
??BiasCal_28:
        MOVS     R5,#+0
//  211         }
//  212         //计算偏移量
//  213         offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
??BiasCal_29:
        MOVS     R0,R5
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,#+1065353216
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        BL       sqrt
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1_1  ;; 0x40690000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        MOVS     R3,#+1073741824
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOV      R8,R0
//  214         //计算左边界
//  215         leftborder = (int32)(BlackUdisLeftLocation[searchline].x + (row - BlackUdisLeftLocation[searchline].y) * slope); 
        LDR.W    R0,??DataTable0_2
        LDR      R0,[R0, R6, LSL #+3]
        BL       __aeabi_i2f
        MOVS     R7,R0
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        SUBS     R0,R4,R0
        BL       __aeabi_i2f
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,R7
        BL       __aeabi_fadd
        BL       __aeabi_f2iz
        MOVS     R7,R0
//  216         //计算偏差
//  217         bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //记得加括号
        MOVS     R0,R7
        BL       __aeabi_i2f
        MOV      R1,R8
        BL       __aeabi_fadd
        BL       __aeabi_f2iz
        RSBS     R0,R0,#+125
        B.N      ??BiasCal_8
//  218       }
//  219       //右线头比左线头远，同时也包括了左线失败右线成功的情况。(失败时是MaxValUint8)
//  220       else
//  221       {
//  222         //直将把右线头作为基本计算行
//  223         searchline = BlackRightHeadLine;
??BiasCal_27:
        LDR.W    R0,??DataTable0_5
        LDRB     R6,[R0, #+0]
//  224        
//  225        
//  226         //计算斜率
//  227         if(searchline <= CameraHight-5)
        CMP      R6,#+56
        BGE.N    ??BiasCal_30
//  228         {
//  229           slope = 1.0 * (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline+4].x) / 
//  230                         (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline+4].y);
        LDR.W    R0,??DataTable0_4
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDR.W    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.W    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_31
//  231         }
//  232         else
//  233         {
//  234           slope = 0;
??BiasCal_30:
        MOVS     R5,#+0
//  235         }
//  236         //计算偏移量
//  237         offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
??BiasCal_31:
        MOVS     R0,R5
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,#+1065353216
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        BL       sqrt
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1_1  ;; 0x40690000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        MOVS     R3,#+1073741824
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOV      R8,R0
//  238         //计算右边界
//  239         rightborder = (int32)(BlackUdisRightLocation[searchline].x + (row - BlackUdisRightLocation[searchline].y) * slope); 
        LDR.W    R0,??DataTable0_4
        LDR      R0,[R0, R6, LSL #+3]
        BL       __aeabi_i2f
        MOVS     R7,R0
        LDR.W    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        SUBS     R0,R4,R0
        BL       __aeabi_i2f
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,R7
        BL       __aeabi_fadd
        BL       __aeabi_f2iz
        MOVS     R4,R0
//  240         //计算偏差
//  241         bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //记得加括号
        MOVS     R0,R4
        BL       __aeabi_i2f
        MOV      R1,R8
        BL       __aeabi_fsub
        BL       __aeabi_f2iz
        RSBS     R0,R0,#+125
        B.N      ??BiasCal_8
//  242       }
//  243     }
//  244   }
//  245   //只有左黑线有效
//  246   else if(BlackLeftDone == 1)
??BiasCal_0:
        LDR.W    R1,??DataTable0
        LDRB     R1,[R1, #+0]
        CMP      R1,#+1
        BNE.W    ??BiasCal_32
//  247   {
//  248     //左线头满足条件
//  249     if(BlackUdisLeftLocation[BlackLeftHeadLine].y <= row)
        LDR.W    R0,??DataTable0_2
        LDR.W    R1,??DataTable0_3
        LDRB     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+3
        LDR      R0,[R0, #+4]
        CMP      R4,R0
        BLT.W    ??BiasCal_33
//  250     {
//  251       //搜索该行在哪两行之间
//  252       for(searchline = BlackLeftHeadLine; searchline <= CameraHight - 1; searchline++)
        LDR.W    R0,??DataTable0_3
        LDRB     R6,[R0, #+0]
        B.N      ??BiasCal_34
??BiasCal_35:
        ADDS     R6,R6,#+1
??BiasCal_34:
        CMP      R6,#+60
        BGE.N    ??BiasCal_36
//  253       {
//  254         if(BlackUdisLeftLocation[searchline].y >= row)
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        CMP      R0,R4
        BLT.N    ??BiasCal_35
//  255         {
//  256           break;
//  257         }
//  258       }
//  259       
//  260       //左边界求取
//  261       if(searchline == BlackLeftHeadLine)
??BiasCal_36:
        LDR.W    R0,??DataTable0_3
        LDRB     R0,[R0, #+0]
        CMP      R6,R0
        BNE.N    ??BiasCal_37
//  262       {
//  263         leftborder = BlackUdisLeftLocation[searchline].x;
        LDR.W    R0,??DataTable0_2
        LDR      R7,[R0, R6, LSL #+3]
        B.N      ??BiasCal_38
//  264       }
//  265       else
//  266       {     
//  267         //插值计算该行畸变矫正后的左黑线的列
//  268         leftborder = (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
//  269                    / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y) + BlackUdisLeftLocation[searchline-1].x;
??BiasCal_37:
        LDR.W    R0,??DataTable0_2
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R1,R4,R1
        MULS     R0,R1,R0
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+4]
        LDR.W    R2,??DataTable0_2
        ADDS     R2,R2,R6, LSL #+3
        LDR      R2,[R2, #-4]
        SUBS     R1,R1,R2
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        ADDS     R7,R1,R0
//  270       }
//  271       
//  272       //偏移量求取，通过斜率估算偏移量。
//  273       if(searchline <= CameraHight-5 && searchline == BlackLeftHeadLine)
??BiasCal_38:
        CMP      R6,#+56
        BGE.N    ??BiasCal_39
        LDR.W    R0,??DataTable0_3
        LDRB     R0,[R0, #+0]
        CMP      R6,R0
        BNE.N    ??BiasCal_39
//  274       {
//  275         slope = 1.0 * (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline+4].x) / 
//  276                       (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline+4].y);
        LDR.W    R0,??DataTable0_2
        LDR      R0,[R0, R6, LSL #+3]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_40
//  277       }
//  278       else if(searchline <= CameraHight-5)
??BiasCal_39:
        CMP      R6,#+56
        BGE.N    ??BiasCal_41
//  279       {
//  280         slope = 1.0 * (BlackUdisLeftLocation[searchline-1].x - BlackUdisLeftLocation[searchline+4].x) / 
//  281                       (BlackUdisLeftLocation[searchline-1].y - BlackUdisLeftLocation[searchline+4].y);
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #-8]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #-4]
        LDR.W    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_40
//  282       }
//  283       else
//  284       {
//  285         slope = 0;
??BiasCal_41:
        MOVS     R5,#+0
//  286       }
//  287       //超然的计算公式
//  288       offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
??BiasCal_40:
        MOVS     R0,R5
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,#+1065353216
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        BL       sqrt
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1_1  ;; 0x40690000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        MOVS     R3,#+1073741824
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOV      R8,R0
//  289       
//  290       //偏差求取
//  291       bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //记得加括号
        MOVS     R0,R7
        BL       __aeabi_i2f
        MOV      R1,R8
        BL       __aeabi_fadd
        BL       __aeabi_f2iz
        RSBS     R0,R0,#+125
        B.N      ??BiasCal_8
//  292     }
//  293     //左线头不满足条件，不够远。
//  294     else
//  295     {
//  296         //直将把左线头作为基本计算行
//  297         searchline = BlackLeftHeadLine;
??BiasCal_33:
        LDR.N    R0,??DataTable0_3
        LDRB     R6,[R0, #+0]
//  298        
//  299        
//  300         
//  301         //计算斜率
//  302         if(searchline <= CameraHight-5)
        CMP      R6,#+56
        BGE.N    ??BiasCal_42
//  303         {
//  304           slope = 1.0 * (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline+4].x) / 
//  305                         (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline+4].y);
        LDR.N    R0,??DataTable0_2
        LDR      R0,[R0, R6, LSL #+3]
        LDR.N    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDR.N    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.N    R1,??DataTable0_2
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_43
//  306         }
//  307         else
//  308         {
//  309           slope = 0;
??BiasCal_42:
        MOVS     R5,#+0
//  310         }
//  311         //计算偏移量
//  312         offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
??BiasCal_43:
        MOVS     R0,R5
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,#+1065353216
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        BL       sqrt
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1_1  ;; 0x40690000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        MOVS     R3,#+1073741824
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOV      R8,R0
//  313         //计算左边界
//  314         leftborder = (int32)(BlackUdisLeftLocation[searchline].x + (row - BlackUdisLeftLocation[searchline].y) * slope); 
        LDR.N    R0,??DataTable0_2
        LDR      R0,[R0, R6, LSL #+3]
        BL       __aeabi_i2f
        MOVS     R7,R0
        LDR.N    R0,??DataTable0_2
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        SUBS     R0,R4,R0
        BL       __aeabi_i2f
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,R7
        BL       __aeabi_fadd
        BL       __aeabi_f2iz
        MOVS     R7,R0
//  315         //计算偏差
//  316         bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //记得加括号
        MOVS     R0,R7
        BL       __aeabi_i2f
        MOV      R1,R8
        BL       __aeabi_fadd
        BL       __aeabi_f2iz
        RSBS     R0,R0,#+125
        B.N      ??BiasCal_8
//  317     }
//  318   }
//  319   else if(BlackRightDone == 1)
??BiasCal_32:
        LDR.N    R1,??DataTable0_1
        LDRB     R1,[R1, #+0]
        CMP      R1,#+1
        BNE.W    ??BiasCal_8
//  320   {
//  321     //右线头满足条件
//  322     if(BlackUdisRightLocation[BlackRightHeadLine].y <= row)
        LDR.N    R0,??DataTable0_4
        LDR.N    R1,??DataTable0_5
        LDRB     R1,[R1, #+0]
        ADDS     R0,R0,R1, LSL #+3
        LDR      R0,[R0, #+4]
        CMP      R4,R0
        BLT.W    ??BiasCal_44
//  323     {
//  324       //搜索该行在哪两行之间
//  325       for(searchline = BlackRightHeadLine; searchline <= CameraHight - 1; searchline++)
        LDR.N    R0,??DataTable0_5
        LDRB     R6,[R0, #+0]
        B.N      ??BiasCal_45
??BiasCal_46:
        ADDS     R6,R6,#+1
??BiasCal_45:
        CMP      R6,#+60
        BGE.N    ??BiasCal_47
//  326       {
//  327         if(BlackUdisRightLocation[searchline].y >= row)
        LDR.N    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        CMP      R0,R4
        BLT.N    ??BiasCal_46
//  328         {
//  329           break;
//  330         }
//  331       }
//  332       
//  333       //右边界求取
//  334       if(searchline == BlackRightHeadLine)
??BiasCal_47:
        LDR.N    R0,??DataTable0_5
        LDRB     R0,[R0, #+0]
        CMP      R6,R0
        BNE.N    ??BiasCal_48
//  335       {
//  336         rightborder = BlackUdisRightLocation[searchline].x;
        LDR.N    R0,??DataTable0_4
        LDR      R4,[R0, R6, LSL #+3]
        B.N      ??BiasCal_49
//  337       }
//  338       else
//  339       {
//  340         //插值计算该行畸变矫正后的左黑线的列
//  341         rightborder = (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
//  342                     / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y) + BlackUdisRightLocation[searchline-1].x;
??BiasCal_48:
        LDR.N    R0,??DataTable0_4
        LDR      R0,[R0, R6, LSL #+3]
        LDR.N    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-4]
        SUBS     R1,R4,R1
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+4]
        LDR.N    R2,??DataTable0_4
        ADDS     R2,R2,R6, LSL #+3
        LDR      R2,[R2, #-4]
        SUBS     R1,R1,R2
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #-8]
        ADDS     R4,R1,R0
//  343       }
//  344       
//  345       //偏移量求取，通过斜率估算偏移量。
//  346       if(searchline <= CameraHight-5 && searchline == BlackRightHeadLine)
??BiasCal_49:
        CMP      R6,#+56
        BGE.N    ??BiasCal_50
        LDR.N    R0,??DataTable0_5
        LDRB     R0,[R0, #+0]
        CMP      R6,R0
        BNE.N    ??BiasCal_50
//  347       {
//  348         slope = 1.0 * (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline+4].x) / 
//  349                       (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline+4].y);
        LDR.N    R0,??DataTable0_4
        LDR      R0,[R0, R6, LSL #+3]
        LDR.N    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDR.N    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.N    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_51
//  350       }
//  351       else if(searchline <= CameraHight-5)
??BiasCal_50:
        CMP      R6,#+56
        BGE.N    ??BiasCal_52
//  352       {
//  353         slope = 1.0 * (BlackUdisRightLocation[searchline-1].x - BlackUdisRightLocation[searchline+4].x) / 
//  354                       (BlackUdisRightLocation[searchline-1].y - BlackUdisRightLocation[searchline+4].y);
        LDR.N    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #-8]
        LDR.N    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDR.N    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #-4]
        LDR.N    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_51
//  355       }
//  356       else
//  357       {
//  358         slope = 0;
??BiasCal_52:
        MOVS     R5,#+0
//  359       }
//  360       //超然的计算公式
//  361       offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
??BiasCal_51:
        MOVS     R0,R5
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,#+1065353216
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        BL       sqrt
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1_1  ;; 0x40690000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        MOVS     R3,#+1073741824
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOV      R8,R0
//  362       
//  363       //偏差求取
//  364       bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //记得加括号
        MOVS     R0,R4
        BL       __aeabi_i2f
        MOV      R1,R8
        BL       __aeabi_fsub
        BL       __aeabi_f2iz
        RSBS     R0,R0,#+125
        B.N      ??BiasCal_8
//  365     }
//  366     //右线头不满足条件，不够远
//  367     else
//  368     {
//  369         //直将把右线头作为基本计算行
//  370         searchline = BlackRightHeadLine;
??BiasCal_44:
        LDR.N    R0,??DataTable0_5
        LDRB     R6,[R0, #+0]
//  371         
//  372        
//  373         //计算斜率
//  374         if(searchline <= CameraHight-5)
        CMP      R6,#+56
        BGE.N    ??BiasCal_53
//  375         {
//  376           slope = 1.0 * (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline+4].x) / 
//  377                         (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline+4].y);
        LDR.N    R0,??DataTable0_4
        LDR      R0,[R0, R6, LSL #+3]
        LDR.N    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+32]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDR.N    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        LDR.N    R1,??DataTable0_4
        ADDS     R1,R1,R6, LSL #+3
        LDR      R1,[R1, #+36]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOVS     R5,R0
        B.N      ??BiasCal_54
//  378         }
//  379         else
//  380         {
//  381           slope = 0;
??BiasCal_53:
        MOVS     R5,#+0
//  382         }
//  383         //计算偏移量
//  384         offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
??BiasCal_54:
        MOVS     R0,R5
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,#+1065353216
        BL       __aeabi_fadd
        BL       __aeabi_f2d
        BL       sqrt
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1  ;; 0x3ff00000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.W    R3,??DataTable1_1  ;; 0x40690000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        MOVS     R3,#+1073741824
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        MOV      R8,R0
//  385         //计算右边界
//  386         rightborder = (int32)(BlackUdisRightLocation[searchline].x + (row - BlackUdisRightLocation[searchline].y) * slope); 
        LDR.N    R0,??DataTable0_4
        LDR      R0,[R0, R6, LSL #+3]
        BL       __aeabi_i2f
        MOVS     R7,R0
        LDR.N    R0,??DataTable0_4
        ADDS     R0,R0,R6, LSL #+3
        LDR      R0,[R0, #+4]
        SUBS     R0,R4,R0
        BL       __aeabi_i2f
        MOVS     R1,R5
        BL       __aeabi_fmul
        MOVS     R1,R7
        BL       __aeabi_fadd
        BL       __aeabi_f2iz
        MOVS     R4,R0
//  387         //计算偏差
//  388         bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //记得加括号
        MOVS     R0,R4
        BL       __aeabi_i2f
        MOV      R1,R8
        BL       __aeabi_fsub
        BL       __aeabi_f2iz
        RSBS     R0,R0,#+125
//  389     }
//  390   }
//  391   //理论上不会走到这里
//  392   else 
//  393   {    
//  394   }
//  395   
//  396   return bias;
??BiasCal_8:
        POP      {R1,R4-R9,PC}    ;; return
//  397 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC32     BlackLeftDone

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_1:
        DC32     BlackRightDone

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_2:
        DC32     BlackUdisLeftLocation

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_3:
        DC32     BlackLeftHeadLine

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_4:
        DC32     BlackUdisRightLocation

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_5:
        DC32     BlackRightHeadLine

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_6:
        DC32     0x9999999a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_7:
        DC32     0x3fb99999
//  398 
//  399 //------------------------------------------------------------------------------
//  400 //函数名：SpeedRealTimeGet
//  401 //功  能：实时速度获取，确定速度等级
//  402 //参  数：
//  403 //返  回：
//  404 //说  明：将脉冲数归算到实际速度，扩大1000陪.speed_fu为隶属度
//  405 //------------------------------------------------------------------------------

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  406 uint8 SpeedRealTimeGet(void)
//  407 {
//  408   int32 speed;//车的中心速度，两轮速度的平均值
//  409   //储存上一次的脉冲数
//  410   SpeedLastLeft = SpeedNowLeft;          
SpeedRealTimeGet:
        LDR.W    R0,??DataTable3
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_1
        STRH     R0,[R1, #+0]
//  411   SpeedLastRight = SpeedNowRight;  
        LDR.W    R0,??DataTable3_2
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_3
        STRH     R0,[R1, #+0]
//  412   //更新左右电机实时脉冲数，且进行了滤波操作。
//  413   QuadLeftCount=(QuadLeftCount*3+QuadLastLeftCount*7)/10;
        LDR.W    R0,??DataTable3_4
        LDR      R0,[R0, #+0]
        MOVS     R1,#+3
        LDR.W    R2,??DataTable3_5
        LDRH     R2,[R2, #+0]
        MOVS     R3,#+7
        MULS     R2,R3,R2
        MLA      R0,R1,R0,R2
        MOVS     R1,#+10
        UDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_4
        STR      R0,[R1, #+0]
//  414   QuadRightCount=(QuadRightCount*3+QuadLastRightCount*7)/10;
        LDR.W    R0,??DataTable3_6
        LDR      R0,[R0, #+0]
        MOVS     R1,#+3
        LDR.W    R2,??DataTable3_7
        LDRH     R2,[R2, #+0]
        MOVS     R3,#+7
        MULS     R2,R3,R2
        MLA      R0,R1,R0,R2
        MOVS     R1,#+10
        UDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_6
        STR      R0,[R1, #+0]
//  415   
//  416   QuadLastLeftCount=QuadLeftCount;
        LDR.W    R0,??DataTable3_4
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_5
        STRH     R0,[R1, #+0]
//  417   QuadLastRightCount=QuadRightCount;
        LDR.W    R0,??DataTable3_6
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_7
        STRH     R0,[R1, #+0]
//  418   
//  419   SpeedNowLeft = QuadLeftCount*200*100/(3250*3);//脉冲数转化为实际速度，扩大了100倍。1m对应5260个脉冲，500/3对应6毫秒
        LDR.W    R0,??DataTable3_4
        LDR      R0,[R0, #+0]
        MOVW     R1,#+20000
        MULS     R0,R1,R0
        MOVW     R1,#+9750
        UDIV     R0,R0,R1
        LDR.W    R1,??DataTable3
        STRH     R0,[R1, #+0]
//  420   SpeedNowRight = QuadRightCount*200*100/(3250*3);//脉冲数转化为实际速度，扩大了100倍。1m对应5260个脉冲，500/3对应6毫秒
        LDR.W    R0,??DataTable3_6
        LDR      R0,[R0, #+0]
        MOVW     R1,#+20000
        MULS     R0,R1,R0
        MOVW     R1,#+9750
        UDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_2
        STRH     R0,[R1, #+0]
//  421   
//  422   speed=(SpeedNowLeft)*10;//平均速度
        LDR.W    R0,??DataTable3
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+10
        MULS     R0,R1,R0
//  423 
//  424   //speed=2100;//速度给成定值，调试用
//  425   if(speed<1000)
        CMP      R0,#+1000
        BGE.N    ??SpeedRealTimeGet_0
//  426     {
//  427       speed_grade = 1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_8
        STRB     R0,[R1, #+0]
//  428       speed_fu = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  429     }
//  430     else if(speed<1400)
??SpeedRealTimeGet_0:
        CMP      R0,#+1400
        BGE.N    ??SpeedRealTimeGet_2
//  431     {
//  432       speed_grade = 1;
        MOVS     R1,#+1
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  433       speed_fu = (speed - 1000)*1000 / (1400 - 1000);
        SUBS     R0,R0,#+1000
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOV      R1,#+400
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  434     }
//  435     else if(speed<1600)
??SpeedRealTimeGet_2:
        CMP      R0,#+1600
        BGE.N    ??SpeedRealTimeGet_3
//  436     {
//  437       speed_grade = 2;
        MOVS     R1,#+2
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  438       speed_fu = (speed - 1400)*1000 / (1600 - 1400);
        SUBS     R0,R0,#+1400
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+200
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  439     }
//  440     else if(speed<1700)
??SpeedRealTimeGet_3:
        MOVW     R1,#+1700
        CMP      R0,R1
        BGE.N    ??SpeedRealTimeGet_4
//  441     {
//  442       speed_grade = 3;
        MOVS     R1,#+3
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  443       speed_fu = (speed - 1600)*1000 / (1700 - 1600);
        SUBS     R0,R0,#+1600
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  444     }
//  445     else if(speed<1800)
??SpeedRealTimeGet_4:
        CMP      R0,#+1800
        BGE.N    ??SpeedRealTimeGet_5
//  446     {
//  447       speed_grade = 4;
        MOVS     R1,#+4
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  448       speed_fu = (speed - 1700)*1000 / (1800 - 1700);
        SUBW     R0,R0,#+1700
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  449     }
//  450     else if(speed<1900)
??SpeedRealTimeGet_5:
        MOVW     R1,#+1900
        CMP      R0,R1
        BGE.N    ??SpeedRealTimeGet_6
//  451     {
//  452       speed_grade = 5;
        MOVS     R1,#+5
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  453       speed_fu = (speed - 1800)*1000 / (1900 - 1800);
        SUBS     R0,R0,#+1800
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  454     }
//  455     else if(speed<2000)
??SpeedRealTimeGet_6:
        CMP      R0,#+2000
        BGE.N    ??SpeedRealTimeGet_7
//  456     {
//  457       speed_grade = 6;
        MOVS     R1,#+6
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  458       speed_fu = (speed - 1900)*1000 / (2000 - 1900);
        SUBW     R0,R0,#+1900
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  459     }
//  460     else if(speed<2100)
??SpeedRealTimeGet_7:
        MOVW     R1,#+2100
        CMP      R0,R1
        BGE.N    ??SpeedRealTimeGet_8
//  461     {
//  462       speed_grade = 7;
        MOVS     R1,#+7
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  463       speed_fu = (speed - 2000)*1000 / (2100 - 2000);
        SUBS     R0,R0,#+2000
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  464     }
//  465     else if(speed<2200)
??SpeedRealTimeGet_8:
        MOVW     R1,#+2200
        CMP      R0,R1
        BGE.N    ??SpeedRealTimeGet_9
//  466     {
//  467       speed_grade = 8;
        MOVS     R1,#+8
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  468       speed_fu = (speed - 2100)*1000 / (2200 - 2100);
        SUBW     R0,R0,#+2100
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  469     }
//  470     else if(speed<2300)
??SpeedRealTimeGet_9:
        MOVW     R1,#+2300
        CMP      R0,R1
        BGE.N    ??SpeedRealTimeGet_10
//  471     {
//  472       speed_grade = 9;
        MOVS     R1,#+9
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  473       speed_fu = (speed - 2200)*1000 / (2300 - 2200);
        SUBW     R0,R0,#+2200
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  474     }
//  475     else if(speed<2400)
??SpeedRealTimeGet_10:
        CMP      R0,#+2400
        BGE.N    ??SpeedRealTimeGet_11
//  476     {
//  477       speed_grade = 10;
        MOVS     R1,#+10
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  478       speed_fu = (speed - 2300)*1000 / (2400 - 2300);
        SUBW     R0,R0,#+2300
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  479     }
//  480     else if(speed<2500)
??SpeedRealTimeGet_11:
        MOVW     R1,#+2500
        CMP      R0,R1
        BGE.N    ??SpeedRealTimeGet_12
//  481     {
//  482       speed_grade = 11;
        MOVS     R1,#+11
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  483       speed_fu = (speed - 2400)*1000 / (2500 - 2400);
        SUBS     R0,R0,#+2400
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  484     }
//  485     else if(speed<2600)
??SpeedRealTimeGet_12:
        MOVW     R1,#+2600
        CMP      R0,R1
        BGE.N    ??SpeedRealTimeGet_13
//  486     {
//  487       speed_grade = 12;
        MOVS     R1,#+12
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  488       speed_fu = (speed - 2500)*1000 / (2600 - 2500);
        SUBW     R0,R0,#+2500
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  489     }
//  490     else if(speed<2700)
??SpeedRealTimeGet_13:
        MOVW     R1,#+2700
        CMP      R0,R1
        BGE.N    ??SpeedRealTimeGet_14
//  491     {
//  492       speed_grade = 13;
        MOVS     R1,#+13
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  493       speed_fu = (speed - 2600)*1000 / (2700 - 2600);
        SUBW     R0,R0,#+2600
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  494     }
//  495     else if(speed<2800)
??SpeedRealTimeGet_14:
        CMP      R0,#+2800
        BGE.N    ??SpeedRealTimeGet_15
//  496     {
//  497       speed_grade = 14;
        MOVS     R1,#+14
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  498       speed_fu = (speed - 2700)*1000 / (2800 - 2700);
        SUBW     R0,R0,#+2700
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  499     }
//  500     else if(speed<2900)
??SpeedRealTimeGet_15:
        MOVW     R1,#+2900
        CMP      R0,R1
        BGE.N    ??SpeedRealTimeGet_16
//  501     {
//  502       speed_grade = 15;
        MOVS     R1,#+15
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  503       speed_fu = (speed - 2800)*1000 / (2900 - 2800);
        SUBS     R0,R0,#+2800
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  504     }
//  505     else if(speed<3000)
??SpeedRealTimeGet_16:
        MOVW     R1,#+3000
        CMP      R0,R1
        BGE.N    ??SpeedRealTimeGet_17
//  506     {
//  507       speed_grade = 16;
        MOVS     R1,#+16
        LDR.W    R2,??DataTable3_8
        STRB     R1,[R2, #+0]
//  508       speed_fu = (speed - 2900)*1000 / (3000 - 2900);
        SUBW     R0,R0,#+2900
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
        B.N      ??SpeedRealTimeGet_1
//  509     }
//  510     else
//  511     {
//  512       speed_grade = 16;
??SpeedRealTimeGet_17:
        MOVS     R0,#+16
        LDR.W    R1,??DataTable3_8
        STRB     R0,[R1, #+0]
//  513       speed_fu = 1000;
        MOV      R0,#+1000
        LDR.W    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
//  514     }
//  515   return 1;
??SpeedRealTimeGet_1:
        MOVS     R0,#+1
        BX       LR               ;; return
//  516 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     0x3ff00000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     0x40690000
//  517 
//  518 
//  519 
//  520 //======================================================================
//  521 //函数名：DeviationFuse
//  522 //功  能：多行偏差的融合
//  523 //参  数：
//  524 //返  回：
//  525 //影  响：
//  526 //说  明： 
//  527 //      
//  528 //             
//  529 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  530 uint8 DeviationFuse(void)
//  531 {    
DeviationFuse:
        PUSH     {R3-R5,LR}
//  532   //uint8 i;
//  533  //int32 DeviPredict;
//  534   
//  535   //多行偏差融合预处理
//  536   int32 near_p,far_p,temp,temp_far;
//  537   int32 Devi_near_fu;
//  538   uint8 Devi_near_grade;
//  539   uint8 line_far_index;
//  540   
//  541   Devi_near=PhyCenterCol-(CenterLineLoc[BlackControlLineLow-2]+CenterLineLoc[BlackControlLineLow-1]+CenterLineLoc[BlackControlLineLow]+CenterLineLoc[BlackControlLineLow+1]+CenterLineLoc[BlackControlLineLow+2])/5;
        LDR.W    R0,??DataTable3_10
        LDRSH    R0,[R0, #+48]
        LDR.W    R1,??DataTable3_10
        LDRSH    R1,[R1, #+50]
        ADDS     R0,R1,R0
        LDR.W    R1,??DataTable3_10
        LDRSH    R1,[R1, #+52]
        ADDS     R0,R0,R1
        LDR.W    R1,??DataTable3_10
        LDRSH    R1,[R1, #+54]
        ADDS     R0,R0,R1
        LDR.W    R1,??DataTable3_10
        LDRSH    R1,[R1, #+56]
        ADDS     R0,R0,R1
        MOVS     R1,#+5
        SDIV     R0,R0,R1
        RSBS     R0,R0,#+125
        LDR.W    R1,??DataTable3_11
        STR      R0,[R1, #+0]
//  542   //Devi_far=PhyCenterCol-CenterLineLoc[BlackControlLineFar];
//  543   
//  544   if(Devi_near>140)
        LDR.W    R0,??DataTable3_11
        LDR      R0,[R0, #+0]
        CMP      R0,#+141
        BLT.N    ??DeviationFuse_0
//  545   {
//  546     Devi_near=140;
        MOVS     R0,#+140
        LDR.W    R1,??DataTable3_11
        STR      R0,[R1, #+0]
        B.N      ??DeviationFuse_1
//  547   }
//  548   else if(Devi_near<-140)
??DeviationFuse_0:
        LDR.W    R0,??DataTable3_11
        LDR      R0,[R0, #+0]
        CMN      R0,#+140
        BGE.N    ??DeviationFuse_1
//  549   {
//  550     Devi_near=-140;  
        MVNS     R0,#+139
        LDR.W    R1,??DataTable3_11
        STR      R0,[R1, #+0]
//  551   }
//  552   
//  553   temp=AbsInt(Devi_near);
??DeviationFuse_1:
        LDR.W    R0,??DataTable3_11
        LDR      R0,[R0, #+0]
        BL       AbsInt
//  554   
//  555   if(temp<20)
        CMP      R0,#+20
        BGE.N    ??DeviationFuse_2
//  556   {
//  557     Devi_near_grade=1;
        MOVS     R1,#+1
//  558     Devi_near_fu=(temp-0)*1000/(20-0);
        MOV      R2,#+1000
        MUL      R2,R2,R0
        MOVS     R3,#+20
        SDIV     R2,R2,R3
        B.N      ??DeviationFuse_3
//  559   }
//  560   else if(temp<50)
??DeviationFuse_2:
        CMP      R0,#+50
        BGE.N    ??DeviationFuse_4
//  561   {
//  562     Devi_near_grade=2;
        MOVS     R1,#+2
//  563     Devi_near_fu=(temp-20)*1000/(50-20);
        SUBS     R2,R0,#+20
        MOV      R3,#+1000
        MULS     R2,R3,R2
        MOVS     R3,#+30
        SDIV     R2,R2,R3
        B.N      ??DeviationFuse_3
//  564   }
//  565   else if(temp<70)
??DeviationFuse_4:
        CMP      R0,#+70
        BGE.N    ??DeviationFuse_5
//  566   {
//  567      Devi_near_grade=3;
        MOVS     R1,#+3
//  568      Devi_near_fu=(temp-50)*1000/(70-50);
        SUBS     R2,R0,#+50
        MOV      R3,#+1000
        MULS     R2,R3,R2
        MOVS     R3,#+20
        SDIV     R2,R2,R3
        B.N      ??DeviationFuse_3
//  569   }  
//  570   else if(temp<90)
??DeviationFuse_5:
        CMP      R0,#+90
        BGE.N    ??DeviationFuse_6
//  571   {
//  572      Devi_near_grade=4;
        MOVS     R1,#+4
//  573      Devi_near_fu=(temp-70)*1000/(90-70);
        SUBS     R2,R0,#+70
        MOV      R3,#+1000
        MULS     R2,R3,R2
        MOVS     R3,#+20
        SDIV     R2,R2,R3
        B.N      ??DeviationFuse_3
//  574   }
//  575   else if(temp<120)
??DeviationFuse_6:
        CMP      R0,#+120
        BGE.N    ??DeviationFuse_7
//  576   {
//  577      Devi_near_grade=5;
        MOVS     R1,#+5
//  578      Devi_near_fu=(temp-90)*1000/(120-90);
        SUBS     R2,R0,#+90
        MOV      R3,#+1000
        MULS     R2,R3,R2
        MOVS     R3,#+30
        SDIV     R2,R2,R3
        B.N      ??DeviationFuse_3
//  579   }
//  580   else
//  581   {
//  582      Devi_near_grade=5;
??DeviationFuse_7:
        MOVS     R1,#+5
//  583      Devi_near_fu=1000;
        MOV      R2,#+1000
//  584   }
//  585    
//  586   if(temp<15)
??DeviationFuse_3:
        CMP      R0,#+15
        BGE.N    ??DeviationFuse_8
//  587     {
//  588      line_far_index=15;    //近行很小，用最远的行20
        MOVS     R0,#+15
        B.N      ??DeviationFuse_9
//  589     }
//  590   else 
//  591     {
//  592      line_far_index=15+(temp-15)/10; 
??DeviationFuse_8:
        SUBS     R0,R0,#+15
        MOVS     R3,#+10
        SDIV     R0,R0,R3
        ADDS     R0,R0,#+15
//  593     }
//  594   if(line_far_index>18) line_far_index=18;
??DeviationFuse_9:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+19
        BLT.N    ??DeviationFuse_10
        MOVS     R0,#+18
//  595 
//  596   
//  597   //超前滞后滤，单行容易错
//  598   temp_far=(CenterLineLoc[line_far_index-2]+CenterLineLoc[line_far_index-1]+CenterLineLoc[line_far_index]+CenterLineLoc[line_far_index+1]+CenterLineLoc[line_far_index+2])/5;
??DeviationFuse_10:
        LDR.W    R3,??DataTable3_10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R3,R3,R0, LSL #+1
        LDRSH    R3,[R3, #-4]
        LDR.W    R4,??DataTable3_10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R4,R4,R0, LSL #+1
        LDRSH    R4,[R4, #-2]
        SXTAH    R3,R4,R3
        LDR.W    R4,??DataTable3_10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRSH    R4,[R4, R0, LSL #+1]
        ADDS     R3,R3,R4
        LDR.W    R4,??DataTable3_10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R4,R4,R0, LSL #+1
        LDRSH    R4,[R4, #+2]
        SXTAH    R3,R3,R4
        LDR.W    R4,??DataTable3_10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R0,R4,R0, LSL #+1
        LDRSH    R0,[R0, #+4]
        SXTAH    R0,R3,R0
        MOVS     R3,#+5
        SDIV     R0,R0,R3
//  599   
//  600   Devi_far=PhyCenterCol-temp_far;
        RSBS     R0,R0,#+125
        LDR.W    R3,??DataTable3_12
        STR      R0,[R3, #+0]
//  601   if(Devi_far>140)
        LDR.W    R0,??DataTable3_12
        LDR      R0,[R0, #+0]
        CMP      R0,#+141
        BLT.N    ??DeviationFuse_11
//  602   {
//  603     Devi_far=140;
        MOVS     R0,#+140
        LDR.W    R3,??DataTable3_12
        STR      R0,[R3, #+0]
        B.N      ??DeviationFuse_12
//  604   }
//  605   else if(Devi_far<-140)
??DeviationFuse_11:
        LDR.W    R0,??DataTable3_12
        LDR      R0,[R0, #+0]
        CMN      R0,#+140
        BGE.N    ??DeviationFuse_12
//  606   {
//  607     Devi_far=-140;  
        MVNS     R0,#+139
        LDR.W    R3,??DataTable3_12
        STR      R0,[R3, #+0]
//  608   }
//  609   
//  610     
//  611     near_p=(Devi_near_fu*ControlRow_Weight[0][Devi_near_grade]+(1000-Devi_near_fu)*ControlRow_Weight[0][Devi_near_grade-1])/1000;
??DeviationFuse_12:
        LDR.W    R0,??DataTable3_13
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDRB     R0,[R1, R0]
        RSBS     R3,R2,#+1000
        LDR.W    R4,??DataTable3_13
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ADDS     R4,R1,R4
        LDRB     R4,[R4, #-1]
        MULS     R3,R4,R3
        MLA      R0,R0,R2,R3
        MOV      R3,#+1000
        SDIV     R0,R0,R3
//  612     far_p=(Devi_near_fu*ControlRow_Weight[1][Devi_near_grade]+(1000-Devi_near_fu)*ControlRow_Weight[1][Devi_near_grade-1])/1000;
        LDR.W    R3,??DataTable3_13
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ADDS     R3,R1,R3
        LDRB     R3,[R3, #+6]
        RSBS     R4,R2,#+1000
        LDR.W    R5,??DataTable3_13
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ADDS     R1,R1,R5
        LDRB     R1,[R1, #+5]
        MUL      R1,R1,R4
        MLA      R1,R3,R2,R1
        MOV      R2,#+1000
        SDIV     R1,R1,R2
//  613     DeviPrePrePre=DeviPrePre;
        LDR.W    R2,??DataTable3_14
        LDR      R2,[R2, #+0]
        LDR.W    R3,??DataTable3_15
        STR      R2,[R3, #+0]
//  614     DeviPrePre=DeviPre;
        LDR.W    R2,??DataTable3_16
        LDR      R2,[R2, #+0]
        LDR.W    R3,??DataTable3_14
        STR      R2,[R3, #+0]
//  615     DeviPre=DeviFuse;
        LDR.W    R2,??DataTable3_17
        LDR      R2,[R2, #+0]
        LDR.W    R3,??DataTable3_16
        STR      R2,[R3, #+0]
//  616     
//  617     DeviFuse=(Devi_near*near_p+Devi_far*far_p)/(near_p+far_p);
        LDR.W    R2,??DataTable3_11
        LDR      R2,[R2, #+0]
        LDR.W    R3,??DataTable3_12
        LDR      R3,[R3, #+0]
        MULS     R3,R1,R3
        MLA      R2,R0,R2,R3
        ADDS     R0,R1,R0
        SDIV     R0,R2,R0
        LDR.W    R1,??DataTable3_17
        STR      R0,[R1, #+0]
//  618     
//  619     
//  620   //两次跳变太大，认为是错误点
//  621   
//  622   if(DeviFuse>DeviPre+100)      //本来是100
        LDR.W    R0,??DataTable3_16
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+100
        LDR.W    R1,??DataTable3_17
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BGE.N    ??DeviationFuse_13
//  623   {
//  624     DeviFuse=DeviPre;
        LDR.W    R0,??DataTable3_16
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_17
        STR      R0,[R1, #+0]
        B.N      ??DeviationFuse_14
//  625   }
//  626   else if(DeviFuse<DeviPre-100)
??DeviationFuse_13:
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_16
        LDR      R1,[R1, #+0]
        SUBS     R1,R1,#+100
        CMP      R0,R1
        BGE.N    ??DeviationFuse_14
//  627   {
//  628      DeviFuse=DeviPre;
        LDR.W    R0,??DataTable3_16
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_17
        STR      R0,[R1, #+0]
//  629   } 
//  630   /*
//  631    int tempDeviJudge;
//  632   tempDeviJudge=((DeviPre-DeviPrePre)*7+(DeviPrePre-DeviPrePrePre)*3)/10;
//  633   if(tempDeviJudge>0)
//  634   {
//  635     if(DeviFuse-DeviPre<-45)
//  636     {
//  637        DeviFuse=DeviPre;
//  638     }     
//  639   }
//  640  else
//  641  {
//  642    if(DeviFuse-DeviPre>45)
//  643     {
//  644        DeviFuse=DeviPre;
//  645     }     
//  646  }
//  647 */
//  648   return 1;
??DeviationFuse_14:
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}    ;; return
//  649 }//end of DeviationFuse
//  650 
//  651 
//  652 
//  653 
//  654 
//  655 //======================================================================
//  656 //函数名：MtrGet
//  657 //功  能：隶属度计算函数
//  658 //参  数：
//  659 //返  回：
//  660 //影  响：
//  661 //说  明：输入近行（第39行偏差），根据近行偏差确定不同行的权重
//  662 //      
//  663 //             
//  664 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  665 uint8 MtrGet(void)
//  666 {
//  667    uint8 i;
//  668       //偏差隶属度计算,先清零
//  669       for(i=0;i<11;i++)
MtrGet:
        MOVS     R0,#+0
        B.N      ??MtrGet_0
//  670       {
//  671         DeviFusemtr[i]=0;
??MtrGet_1:
        MOVS     R1,#+0
        LDR.W    R2,??DataTable3_18
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R1,[R2, R0, LSL #+2]
//  672       }
        ADDS     R0,R0,#+1
??MtrGet_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+11
        BLT.N    ??MtrGet_1
//  673       
//  674       
//  675       if(DeviFuse<=0-80)
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        CMN      R0,#+79
        BGE.N    ??MtrGet_2
//  676       {
//  677         DeviFusemtr[0]=1000;
        MOV      R0,#+1000
        LDR.W    R1,??DataTable3_18
        STR      R0,[R1, #+0]
        B.N      ??MtrGet_3
//  678       }
//  679        else if(DeviFuse<=0-60)
??MtrGet_2:
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        CMN      R0,#+59
        BGE.N    ??MtrGet_4
//  680        {
//  681           DeviFusemtr[0]=(-60-DeviFuse)*1000/(80-60);
        MVNS     R0,#+59
        LDR.W    R1,??DataTable3_17
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+20
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_18
        STR      R0,[R1, #+0]
//  682           DeviFusemtr[1]=1000-DeviFusemtr[0];
        LDR.W    R0,??DataTable3_18
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+1000
        LDR.W    R1,??DataTable3_18
        STR      R0,[R1, #+4]
        B.N      ??MtrGet_3
//  683        }
//  684        else if(DeviFuse<=0-40)
??MtrGet_4:
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        CMN      R0,#+39
        BGE.N    ??MtrGet_5
//  685         {
//  686           DeviFusemtr[1]=(-40-DeviFuse)*1000/(60-40);
        MVNS     R0,#+39
        LDR.W    R1,??DataTable3_17
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+20
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_18
        STR      R0,[R1, #+4]
//  687           DeviFusemtr[2]=1000-DeviFusemtr[1];
        LDR.W    R0,??DataTable3_18
        LDR      R0,[R0, #+4]
        RSBS     R0,R0,#+1000
        LDR.W    R1,??DataTable3_18
        STR      R0,[R1, #+8]
        B.N      ??MtrGet_3
//  688         }
//  689         else if(DeviFuse<=0-20)
??MtrGet_5:
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        CMN      R0,#+19
        BGE.N    ??MtrGet_6
//  690         {
//  691           DeviFusemtr[2]=(-20-DeviFuse)*1000/(40-20);
        MVNS     R0,#+19
        LDR.W    R1,??DataTable3_17
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+20
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_18
        STR      R0,[R1, #+8]
//  692           DeviFusemtr[3]=1000-DeviFusemtr[2];
        LDR.W    R0,??DataTable3_18
        LDR      R0,[R0, #+8]
        RSBS     R0,R0,#+1000
        LDR.W    R1,??DataTable3_18
        STR      R0,[R1, #+12]
        B.N      ??MtrGet_3
//  693         } 
//  694         else if(DeviFuse<=0-10)
??MtrGet_6:
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        CMN      R0,#+9
        BGE.N    ??MtrGet_7
//  695         {
//  696           DeviFusemtr[3]=(-10-DeviFuse)*1000/(20-10);
        MVNS     R0,#+9
        LDR.N    R1,??DataTable3_17
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+12]
//  697           DeviFusemtr[4]=1000-DeviFusemtr[3];
        LDR.N    R0,??DataTable3_18
        LDR      R0,[R0, #+12]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+16]
        B.N      ??MtrGet_3
//  698         } 
//  699         else if(DeviFuse<=0)
??MtrGet_7:
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BGE.N    ??MtrGet_8
//  700         {
//  701           DeviFusemtr[4]=(-0-DeviFuse)*1000/(10-0);
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+16]
//  702           DeviFusemtr[5]=1000-DeviFusemtr[4];
        LDR.N    R0,??DataTable3_18
        LDR      R0,[R0, #+16]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+20]
        B.N      ??MtrGet_3
//  703         } 
//  704         else if(DeviFuse<=10)
??MtrGet_8:
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        CMP      R0,#+11
        BGE.N    ??MtrGet_9
//  705         {
//  706           DeviFusemtr[5]=(10-DeviFuse)*1000/(10-0);
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+10
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+20]
//  707           DeviFusemtr[6]=1000-DeviFusemtr[5];
        LDR.N    R0,??DataTable3_18
        LDR      R0,[R0, #+20]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+24]
        B.N      ??MtrGet_3
//  708 
//  709         } 
//  710         else if(DeviFuse<=20)
??MtrGet_9:
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        CMP      R0,#+21
        BGE.N    ??MtrGet_10
//  711         {
//  712           DeviFusemtr[6]=(20-DeviFuse)*1000/(20-10);
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+20
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+24]
//  713           DeviFusemtr[7]=1000-DeviFusemtr[6];
        LDR.N    R0,??DataTable3_18
        LDR      R0,[R0, #+24]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+28]
        B.N      ??MtrGet_3
//  714         } 
//  715         else if(DeviFuse<=40)
??MtrGet_10:
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        CMP      R0,#+41
        BGE.N    ??MtrGet_11
//  716         {
//  717           DeviFusemtr[7]=(40-DeviFuse)*1000/(40-20);
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+40
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+20
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+28]
//  718           DeviFusemtr[8]=1000-DeviFusemtr[7];
        LDR.N    R0,??DataTable3_18
        LDR      R0,[R0, #+28]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+32]
        B.N      ??MtrGet_3
//  719         } 
//  720         else if(DeviFuse<=60)
??MtrGet_11:
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        CMP      R0,#+61
        BGE.N    ??MtrGet_12
//  721         {
//  722           DeviFusemtr[8]=(60-DeviFuse)*1000/(60-40);
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+60
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+20
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+32]
//  723           DeviFusemtr[9]=1000-DeviFusemtr[8];
        LDR.N    R0,??DataTable3_18
        LDR      R0,[R0, #+32]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+36]
        B.N      ??MtrGet_3
//  724         } 
//  725         else if(DeviFuse<=80)
??MtrGet_12:
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        CMP      R0,#+81
        BGE.N    ??MtrGet_13
//  726         {
//  727           DeviFusemtr[9]=(80-DeviFuse)*1000/(80-60);
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+80
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+20
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+36]
//  728           DeviFusemtr[10]=1000-DeviFusemtr[9];
        LDR.N    R0,??DataTable3_18
        LDR      R0,[R0, #+36]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+40]
        B.N      ??MtrGet_3
//  729         }        
//  730         else
//  731         {
//  732           DeviFusemtr[10]=1000;
??MtrGet_13:
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_18
        STR      R0,[R1, #+40]
//  733          
//  734         }
//  735 
//  736         DeviFuse_dot=DeviFuse-DeviPre;//求取偏差变化率
??MtrGet_3:
        LDR.N    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable3_16
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable3_19
        STR      R0,[R1, #+0]
//  737         
//  738       //计算DeviFuse_dot的隶属度
//  739    
//  740         for(i=0;i<9;i++)//隶属度清零
        MOVS     R0,#+0
        B.N      ??MtrGet_14
//  741         {
//  742           DeviFuse_dotmtr[i]=0;
??MtrGet_15:
        MOVS     R1,#+0
        LDR.N    R2,??DataTable3_20
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R1,[R2, R0, LSL #+2]
//  743         }
        ADDS     R0,R0,#+1
??MtrGet_14:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+9
        BLT.N    ??MtrGet_15
//  744         
//  745         if(DeviFuse_dot<=-15)
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        CMN      R0,#+14
        BGE.N    ??MtrGet_16
//  746         {
//  747           DeviFuse_dotmtr[0]=1000;
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+0]
        B.N      ??MtrGet_17
//  748         }
//  749         else if(DeviFuse_dot<=-10)
??MtrGet_16:
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        CMN      R0,#+9
        BGE.N    ??MtrGet_18
//  750         {
//  751           DeviFuse_dotmtr[0]=(-10-DeviFuse_dot)*200;
        MVNS     R0,#+9
        LDR.N    R1,??DataTable3_19
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOVS     R1,#+200
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+0]
//  752           DeviFuse_dotmtr[1]=1000-DeviFuse_dotmtr[0];
        LDR.N    R0,??DataTable3_20
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+4]
        B.N      ??MtrGet_17
//  753         }
//  754           else if(DeviFuse_dot<=-6)
??MtrGet_18:
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        CMN      R0,#+5
        BGE.N    ??MtrGet_19
//  755         {
//  756           DeviFuse_dotmtr[1]=(-6-DeviFuse_dot)*250;
        MVNS     R0,#+5
        LDR.N    R1,??DataTable3_19
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOVS     R1,#+250
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+4]
//  757           DeviFuse_dotmtr[2]=1000-DeviFuse_dotmtr[1];
        LDR.N    R0,??DataTable3_20
        LDR      R0,[R0, #+4]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+8]
        B.N      ??MtrGet_17
//  758         }
//  759           else if(DeviFuse_dot<=-2)
??MtrGet_19:
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        CMN      R0,#+1
        BGE.N    ??MtrGet_20
//  760         {
//  761           DeviFuse_dotmtr[2]=(-2-DeviFuse_dot)*250;
        MVNS     R0,#+1
        LDR.N    R1,??DataTable3_19
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOVS     R1,#+250
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+8]
//  762           DeviFuse_dotmtr[3]=1000-DeviFuse_dotmtr[2];
        LDR.N    R0,??DataTable3_20
        LDR      R0,[R0, #+8]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+12]
        B.N      ??MtrGet_17
//  763         }
//  764         else if(DeviFuse_dot<=0)
??MtrGet_20:
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BGE.N    ??MtrGet_21
//  765         {
//  766           DeviFuse_dotmtr[3]=(0-DeviFuse_dot)*500;
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
        MOV      R1,#+500
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+12]
//  767           DeviFuse_dotmtr[4]=1000-DeviFuse_dotmtr[3];
        LDR.N    R0,??DataTable3_20
        LDR      R0,[R0, #+12]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+16]
        B.N      ??MtrGet_17
//  768         }
//  769         else if(DeviFuse_dot<=2)
??MtrGet_21:
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        CMP      R0,#+3
        BGE.N    ??MtrGet_22
//  770         {
//  771           DeviFuse_dotmtr[4]=(2-DeviFuse_dot)*500;
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+2
        MOV      R1,#+500
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+16]
//  772           DeviFuse_dotmtr[5]=1000-DeviFuse_dotmtr[4];
        LDR.N    R0,??DataTable3_20
        LDR      R0,[R0, #+16]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+20]
        B.N      ??MtrGet_17
//  773         }
//  774         else if(DeviFuse_dot<=6)
??MtrGet_22:
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        CMP      R0,#+7
        BGE.N    ??MtrGet_23
//  775         {
//  776           DeviFuse_dotmtr[5]=(6-DeviFuse_dot)*250;
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+6
        MOVS     R1,#+250
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+20]
//  777           DeviFuse_dotmtr[6]=1000-DeviFuse_dotmtr[5];
        LDR.N    R0,??DataTable3_20
        LDR      R0,[R0, #+20]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+24]
        B.N      ??MtrGet_17
//  778         }
//  779         else if(DeviFuse_dot<=10)
??MtrGet_23:
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        CMP      R0,#+11
        BGE.N    ??MtrGet_24
//  780         {
//  781           DeviFuse_dotmtr[6]=(10-DeviFuse_dot)*250;
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+10
        MOVS     R1,#+250
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+24]
//  782           DeviFuse_dotmtr[7]=1000-DeviFuse_dotmtr[6];
        LDR.N    R0,??DataTable3_20
        LDR      R0,[R0, #+24]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+28]
        B.N      ??MtrGet_17
//  783         }
//  784         else if(DeviFuse_dot<=15)
??MtrGet_24:
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        CMP      R0,#+16
        BGE.N    ??MtrGet_25
//  785         {
//  786           DeviFuse_dotmtr[7]=(15-DeviFuse_dot)*200;
        LDR.N    R0,??DataTable3_19
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+15
        MOVS     R1,#+200
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+28]
//  787           DeviFuse_dotmtr[8]=1000-DeviFuse_dotmtr[7];
        LDR.N    R0,??DataTable3_20
        LDR      R0,[R0, #+28]
        RSBS     R0,R0,#+1000
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+32]
        B.N      ??MtrGet_17
//  788         }
//  789         else 
//  790         {
//  791           DeviFuse_dotmtr[8]=1000;
??MtrGet_25:
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_20
        STR      R0,[R1, #+32]
//  792         }
//  793       
//  794         return 1;
??MtrGet_17:
        MOVS     R0,#+1
        BX       LR               ;; return
//  795 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     SpeedNowLeft

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     SpeedLastLeft

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     SpeedNowRight

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     SpeedLastRight

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     QuadLeftCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     QuadLastLeftCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     QuadRightCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     QuadLastRightCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_8:
        DC32     speed_grade

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_9:
        DC32     speed_fu

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_10:
        DC32     CenterLineLoc

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_11:
        DC32     Devi_near

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_12:
        DC32     Devi_far

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_13:
        DC32     ControlRow_Weight

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_14:
        DC32     DeviPrePre

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_15:
        DC32     DeviPrePrePre

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_16:
        DC32     DeviPre

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_17:
        DC32     DeviFuse

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_18:
        DC32     DeviFusemtr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_19:
        DC32     DeviFuse_dot

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_20:
        DC32     DeviFuse_dotmtr

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 
//    99 bytes in section .bss
//    12 bytes in section .data
// 5 750 bytes in section .text
// 
// 5 750 bytes of CODE memory
//   111 bytes of DATA memory
//
//Errors: none
//Warnings: none
