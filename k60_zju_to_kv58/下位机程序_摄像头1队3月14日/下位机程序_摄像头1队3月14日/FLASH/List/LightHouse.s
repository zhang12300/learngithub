///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       06/Feb/2018  21:44:22
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Function_C\LightHouse.c
//    Command line =  
//        D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Function_C\LightHouse.c
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
//    List file    =  
//        D:\智能车\程序\下位机程序_摄像头1队\FLASH\List\LightHouse.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN gpio_init

        PUBLIC LightHouseInit
        PUBLIC LightHouseNoStopFlag
        PUBLIC LightHouseOff2On
        PUBLIC LightHouseOff2OnFlag
        PUBLIC LightHouseOn2Off
        PUBLIC LightHouseOn2OffFlag
        PUBLIC LightHouseStateR0
        PUBLIC LightHouseStateR1
        PUBLIC LightHouseStateUpdate
        PUBLIC LightHouseWaitStart
        PUBLIC LightHouseWaitStartGapCount
        PUBLIC LightHouseWaitStartMaxTime
        PUBLIC LightHouseWaitStop
        PUBLIC LightHouseWaitStopDelayCount
        PUBLIC LightHouseWaitStopDelayCountLimit
        PUBLIC LightHouseWaitStopDelayFlag
        PUBLIC LightHouseWaitStopFlag
        PUBLIC LightHouseWaitStopGapCount
        PUBLIC LightHouseWaitStopGapCountLimit
        PUBLIC LightHouseWaitStopLockFlag
        PUBLIC LightHouseWaitStopOnCount
        PUBLIC LightHouseWaitStopOnCountLimit

// D:\智能车\程序\下位机程序_摄像头1队\src\Sources\C\Function_C\LightHouse.c
//    1 /******************************************************************************/
//    2 /*******************************************************************************
//    3   文件名：灯塔程序文件LightHouse.c
//    4   功  能：灯塔处理
//    5   日  期：2015.05.11
//    6   作  者：HJZ
//    7   备  注：
//    8 *******************************************************************************/
//    9 /******************************************************************************/
//   10 
//   11 #include "LightHouse.h"

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   12 uint8 LightHouseStateR0 = 0;    //灯塔接收模块0的状态
LightHouseStateR0:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   13 uint8 LightHouseStateR1 = 0;    //灯塔接收模块1的状态
LightHouseStateR1:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   14 uint8 LightHouseOn2OffFlag = 0;  //灯塔亮到暗的标志，从0到x变化，初始化为0.
LightHouseOn2OffFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   15 uint8 LightHouseOff2OnFlag = 0;  //灯塔暗到亮的标志，从0到x变化，初始化为0.
LightHouseOff2OnFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   16 uint8 LightHouseWaitStopFlag = 0;
LightHouseWaitStopFlag:
        DS8 1
//   17 
//   18   

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   19 uint8 LightHouseWaitStartGapCount;  //发车间隔计数值
LightHouseWaitStartGapCount:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   20 uint8 LightHouseWaitStopGapCount;   //停车间隔计数值
LightHouseWaitStopGapCount:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   21 uint16 LightHouseWaitStopDelayCount;  //停车延时判断计数值
LightHouseWaitStopDelayCount:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   22 uint8 LightHouseWaitStopDelayFlag;  //停车延时判断标志位
LightHouseWaitStopDelayFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   23 uint8 LightHouseWaitStopLockFlag;   //停车确认锁存标志位
LightHouseWaitStopLockFlag:
        DS8 1
//   24 

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   25 uint16 LightHouseWaitStartMaxTime = 50;         //以0.1s为单位，50代表5秒。这么多秒后，不管有没有检测到灯塔，直接发车。
LightHouseWaitStartMaxTime:
        DATA
        DC16 50

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   26 uint16 LightHouseWaitStopDelayCountLimit = 70;  //停车延时判断阈值，隔这么多个16ms才开始停车判断
LightHouseWaitStopDelayCountLimit:
        DATA
        DC16 70

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   27 uint16 LightHouseWaitStopGapCountLimit = 10;   //停车间隔计数阈值，每隔这么多个16ms就更新一次灯塔采集值。一般不要动。
LightHouseWaitStopGapCountLimit:
        DATA
        DC16 10
//   28 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   29 uint16 LightHouseWaitStopOnCount = 0;         //停车时的，亮持续计数
LightHouseWaitStopOnCount:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   30 uint16 LightHouseWaitStopOnCountLimit = 2;    //停车时的亮持续计数的阈值，与停车间隔计数有关，即亮度必须持续0.016*LightHouseWaitStopGapCountLimit*LightHouseWaitStopOnCountLimit秒。不需要太大。
LightHouseWaitStopOnCountLimit:
        DATA
        DC16 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   31 uint16 LightHouseNoStopFlag = 0;              //灯塔不停车标志，1开启这种模式，不根据灯塔停车，直接冲过去。0关闭这种模式，根据灯塔停车。
LightHouseNoStopFlag:
        DS8 2
//   32 
//   33 
//   34 //灯塔的亮到暗的检测，检测到跳变则返回1，否则返回0.

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   35 uint8 LightHouseOn2Off(void)
//   36 {
//   37   if(LightHouseStateR0 == 0) //0表示亮
LightHouseOn2Off:
        LDR.N    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseOn2Off_0
//   38   {
//   39     //初始状态是0，确认多次是亮。
//   40     if(LightHouseOn2OffFlag == 0)
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseOn2Off_1
//   41     {
//   42       LightHouseOn2OffFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOn2Off_2
//   43     }
//   44     //确认一直是亮，则保持这个状态。
//   45     else if(LightHouseOn2OffFlag == 1)
??LightHouseOn2Off_1:
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseOn2Off_3
//   46     {
//   47       LightHouseOn2OffFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOn2Off_2
//   48     }
//   49     //从其它状态确认到亮，则返回初始状态。
//   50     else
//   51     {
//   52       LightHouseOn2OffFlag = 0;
??LightHouseOn2Off_3:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOn2Off_2
//   53     }
//   54   }
//   55   else   //1表示暗
//   56   {
//   57     if(LightHouseOn2OffFlag == 1)
??LightHouseOn2Off_0:
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseOn2Off_4
//   58     {
//   59       LightHouseOn2OffFlag = 2;
        MOVS     R0,#+2
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOn2Off_2
//   60     }
//   61     else if(LightHouseOn2OffFlag == 2)
??LightHouseOn2Off_4:
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??LightHouseOn2Off_5
//   62     {
//   63       LightHouseOn2OffFlag = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
//   64       return 1;
        MOVS     R0,#+1
        B.N      ??LightHouseOn2Off_6
//   65     }
//   66     else
//   67     {
//   68       LightHouseOn2OffFlag = 0;
??LightHouseOn2Off_5:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
//   69     }
//   70   }
//   71   
//   72   return 0;
??LightHouseOn2Off_2:
        MOVS     R0,#+0
??LightHouseOn2Off_6:
        BX       LR               ;; return
//   73   
//   74 }
//   75 
//   76 //灯塔的暗到亮的检测,检测到跳变则返回1，否则返回0.

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   77 uint8 LightHouseOff2On(void)
//   78 {
//   79   if(LightHouseStateR0 == 1) //1表示暗
LightHouseOff2On:
        LDR.N    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseOff2On_0
//   80   {
//   81     //初始状态是0，确认多次是暗。
//   82     if(LightHouseOff2OnFlag == 0)
        LDR.N    R0,??DataTable5_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseOff2On_1
//   83     {
//   84       LightHouseOff2OnFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOff2On_2
//   85     }
//   86     //确认一直是暗，则保持这个状态。
//   87     else if(LightHouseOff2OnFlag == 1)
??LightHouseOff2On_1:
        LDR.N    R0,??DataTable5_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseOff2On_3
//   88     {
//   89       LightHouseOff2OnFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOff2On_2
//   90     }
//   91     //从其它状态确认到暗，则返回初始状态。
//   92     else
//   93     {
//   94       LightHouseOff2OnFlag = 0;
??LightHouseOff2On_3:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOff2On_2
//   95     }
//   96   }
//   97   else   //0表示亮
//   98   {
//   99     if(LightHouseOff2OnFlag == 1)
??LightHouseOff2On_0:
        LDR.N    R0,??DataTable5_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseOff2On_4
//  100     {
//  101       LightHouseOff2OnFlag = 2;
        MOVS     R0,#+2
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOff2On_2
//  102     }
//  103     else if(LightHouseOff2OnFlag == 2)
??LightHouseOff2On_4:
        LDR.N    R0,??DataTable5_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??LightHouseOff2On_5
//  104     {
//  105       LightHouseOff2OnFlag = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
//  106       return 1;
        MOVS     R0,#+1
        B.N      ??LightHouseOff2On_6
//  107     }
//  108     else
//  109     {
//  110       LightHouseOff2OnFlag = 0;
??LightHouseOff2On_5:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
//  111     }
//  112   }
//  113   
//  114   return 0;
??LightHouseOff2On_2:
        MOVS     R0,#+0
??LightHouseOff2On_6:
        BX       LR               ;; return
//  115 }
//  116 
//  117 
//  118 
//  119 //======================================================================
//  120 //函数名：LightHouseWaitStart
//  121 //功  能：灯塔发车等待函数
//  122 //参  数：
//  123 //返  回：
//  124 //影  响：1等待 0发车
//  125 //说  明：1. 检测到亮到暗的跳变沿，则发车。
//  126 //        2. 注意对跳变沿的检测需要多几个点，防止小干扰。
//  127 //             
//  128 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  129 uint8 LightHouseWaitStart(void)
//  130 {
LightHouseWaitStart:
        PUSH     {R7,LR}
//  131   //间隔计数值加1.
//  132   LightHouseWaitStartGapCount++;
        LDR.N    R0,??DataTable5_3
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable5_3
        STRB     R0,[R1, #+0]
//  133   //实现多次更新一次值，达到滤波效果。发车的滤波可以小一些，节约一点时间。
//  134   if(LightHouseWaitStartGapCount > LightHouseWaitStartGapCountLimit)
        LDR.N    R0,??DataTable5_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BLT.N    ??LightHouseWaitStart_0
//  135   {
//  136     //灯塔信号更新
//  137     LightHouseStateUpdate();
        BL       LightHouseStateUpdate
//  138     //检测到亮到暗的跳变
//  139     if(LightHouseOn2Off() == 1)
        BL       LightHouseOn2Off
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStart_1
//  140     {
//  141       return 0;
        MOVS     R0,#+0
        B.N      ??LightHouseWaitStart_2
//  142     }
//  143     else
//  144     {
//  145       return 1;
??LightHouseWaitStart_1:
        MOVS     R0,#+1
        B.N      ??LightHouseWaitStart_2
//  146     }
//  147   }
//  148   else
//  149   {
//  150   }
//  151   
//  152   return 1;
??LightHouseWaitStart_0:
        MOVS     R0,#+1
??LightHouseWaitStart_2:
        POP      {R1,PC}          ;; return
//  153 }
//  154 
//  155 
//  156 
//  157 //======================================================================
//  158 //函数名：LightHouseWaitStop
//  159 //功  能：灯塔发车等待函数
//  160 //参  数：
//  161 //返  回：
//  162 //影  响：1等待 0发车
//  163 //说  明：
//  164 //         
//  165 //             
//  166 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  167 uint8 LightHouseWaitStop(void)
//  168 {
LightHouseWaitStop:
        PUSH     {R7,LR}
//  169   //灯塔不停车标志，永远不停车。
//  170   if(LightHouseNoStopFlag == 1)
        LDR.N    R0,??DataTable5_4
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStop_0
//  171   {
//  172     return 1;
        MOVS     R0,#+1
        B.N      ??LightHouseWaitStop_1
//  173   }
//  174   else
//  175   {
//  176   } 
//  177   
//  178   
//  179   //确认停车后，就一直锁存住。
//  180   if(LightHouseWaitStopLockFlag == 1)
??LightHouseWaitStop_0:
        LDR.N    R0,??DataTable5_5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStop_2
//  181   {
//  182     return 0;
        MOVS     R0,#+0
        B.N      ??LightHouseWaitStop_1
//  183   }
//  184   else
//  185   {
//  186   }
//  187   
//  188   //停车要延时判断，以免一发车就停车。
//  189   if(LightHouseWaitStopDelayFlag == 0)
??LightHouseWaitStop_2:
        LDR.N    R0,??DataTable5_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseWaitStop_3
//  190   {
//  191     LightHouseWaitStopDelayCount++;
        LDR.N    R0,??DataTable5_7
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable5_7
        STRH     R0,[R1, #+0]
//  192     //延时一段时间，可以设置久一些。
//  193     if(LightHouseWaitStopDelayCount > LightHouseWaitStopDelayCountLimit * 63)
        LDR.N    R0,??DataTable5_8
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+63
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable5_7
        LDRH     R1,[R1, #+0]
        CMP      R0,R1
        BGE.N    ??LightHouseWaitStop_4
//  194     {
//  195       LightHouseWaitStopDelayFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_6
        STRB     R0,[R1, #+0]
//  196     }
//  197     else
//  198     {
//  199     }
//  200   }
//  201   else
//  202   {
//  203     //间隔计数值加1.
//  204     LightHouseWaitStopGapCount++;
//  205     //实现多次更新一次值，达到滤波效果。停车的滤波可以多一些，因为从拐角过来有可能会误判。
//  206     if(LightHouseWaitStopGapCount > LightHouseWaitStopGapCountLimit)
//  207     {
//  208       //灯塔信号更新
//  209       LightHouseStateUpdate();
//  210       //1. 先检测到暗亮的跳变，再检测到亮暗的跳变
//  211       if(LightHouseWaitStopFlag == 0)
//  212       {
//  213         //先检测到暗亮的跳变
//  214         if(LightHouseOff2On() == 1)
//  215         {
//  216           //标志位变化
//  217           LightHouseWaitStopFlag = 1;
//  218           //亮持续计数清零。
//  219           LightHouseWaitStopOnCount = 0;
//  220         }
//  221         else
//  222         {
//  223         }    
//  224       }
//  225       //2. 亮必须保持够久 
//  226       else if(LightHouseWaitStopFlag == 1)
//  227       {
//  228         //若是亮，则计数加1
//  229         if(LightHouseStateR0 == 0)
//  230         {
//  231           LightHouseWaitStopOnCount++;
//  232           //亮连续计数到阈值，则标志位变化，同时清零。
//  233           if(LightHouseWaitStopOnCount >= LightHouseWaitStopOnCountLimit)
//  234           {
//  235             //标志前进
//  236             LightHouseWaitStopFlag = 2;
//  237             LightHouseWaitStopOnCount = 0;
//  238           }
//  239           else
//  240           {
//  241           }
//  242         }
//  243         //一旦中途有变暗，则回到解放前。
//  244         else
//  245         {
//  246           //标志后退
//  247           LightHouseWaitStopFlag = 0;
//  248         }
//  249       }
//  250       //3. 再检测亮到暗的跳变。
//  251       else if(LightHouseWaitStopFlag == 2)
//  252       {
//  253         if(LightHouseOn2Off() == 1)
//  254         {
//  255           LightHouseWaitStopFlag = 3;
//  256           return 0;
//  257         }
//  258         else
//  259         {
//  260         }
//  261       }
//  262       else if(LightHouseWaitStopFlag == 3)
//  263       {
//  264         //两次检测均成功，则不用再检测了。
//  265         LightHouseWaitStopLockFlag = 1;
//  266         return 0;    
//  267       }
//  268       else
//  269       {
//  270       }
//  271     }
//  272     else
//  273     {
//  274     }
//  275   }
//  276   
//  277   return 1;
??LightHouseWaitStop_4:
        MOVS     R0,#+1
??LightHouseWaitStop_1:
        POP      {R1,PC}          ;; return
??LightHouseWaitStop_3:
        LDR.N    R0,??DataTable5_9
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable5_9
        STRB     R0,[R1, #+0]
        LDR.N    R0,??DataTable5_10
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable5_9
        LDRB     R1,[R1, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R0,R1
        BCS.N    ??LightHouseWaitStop_4
        BL       LightHouseStateUpdate
        LDR.N    R0,??DataTable5_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseWaitStop_5
        BL       LightHouseOff2On
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStop_4
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_11
        STRB     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_12
        STRH     R0,[R1, #+0]
        B.N      ??LightHouseWaitStop_4
??LightHouseWaitStop_5:
        LDR.N    R0,??DataTable5_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStop_6
        LDR.N    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseWaitStop_7
        LDR.N    R0,??DataTable5_12
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable5_12
        STRH     R0,[R1, #+0]
        LDR.N    R0,??DataTable5_12
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable5_13
        LDRH     R1,[R1, #+0]
        CMP      R0,R1
        BCC.N    ??LightHouseWaitStop_4
        MOVS     R0,#+2
        LDR.N    R1,??DataTable5_11
        STRB     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_12
        STRH     R0,[R1, #+0]
        B.N      ??LightHouseWaitStop_4
??LightHouseWaitStop_7:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_11
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseWaitStop_4
??LightHouseWaitStop_6:
        LDR.N    R0,??DataTable5_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??LightHouseWaitStop_8
        BL       LightHouseOn2Off
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStop_4
        MOVS     R0,#+3
        LDR.N    R1,??DataTable5_11
        STRB     R0,[R1, #+0]
        MOVS     R0,#+0
        B.N      ??LightHouseWaitStop_1
??LightHouseWaitStop_8:
        LDR.N    R0,??DataTable5_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??LightHouseWaitStop_4
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_5
        STRB     R0,[R1, #+0]
        MOVS     R0,#+0
        B.N      ??LightHouseWaitStop_1
//  278 }
//  279 
//  280 //======================================================================
//  281 //函数名：LightHouseInit
//  282 //功  能：灯塔初始化
//  283 //参  数：
//  284 //返  回：
//  285 //影  响：
//  286 //说  明：
//  287 //      
//  288 //             
//  289 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  290 uint8 LightHouseInit(void)
//  291 {
LightHouseInit:
        PUSH     {R7,LR}
//  292   //LIGHTR0  灯塔接收模块1 复用为GPIO输入
//  293   gpio_init(PORTE, 10, 0, 1);
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+10
        LDR.N    R0,??DataTable5_14  ;; 0x400ff100
        BL       gpio_init
//  294   //LIGHTR1 灯塔接收模块2  复用为GPIO输入
//  295   gpio_init(PORTE, 11, 0, 1);
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+11
        LDR.N    R0,??DataTable5_14  ;; 0x400ff100
        BL       gpio_init
//  296   
//  297   //间隔计数值初始化。
//  298   LightHouseWaitStartGapCount = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_3
        STRB     R0,[R1, #+0]
//  299   LightHouseWaitStopGapCount = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_9
        STRB     R0,[R1, #+0]
//  300   //停车延时判断计数值初始化。
//  301   LightHouseWaitStopDelayCount = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_7
        STRH     R0,[R1, #+0]
//  302   //停车延时判断标志位初始化。
//  303   LightHouseWaitStopDelayFlag = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_6
        STRB     R0,[R1, #+0]
//  304   //停车确认锁存标志位
//  305   LightHouseWaitStopLockFlag = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_5
        STRB     R0,[R1, #+0]
//  306   
//  307   return 1;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//  308 }
//  309 
//  310 
//  311 
//  312 //======================================================================
//  313 //函数名：LightHouseStateUpdate
//  314 //功  能：灯塔接收模块的状态更新
//  315 //参  数：
//  316 //返  回：
//  317 //影  响：
//  318 //说  明：
//  319 //      
//  320 //             
//  321 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  322 uint8 LightHouseStateUpdate(void)
//  323 {
//  324   //灯塔接收模块0的状态更新 E10
//  325   if(GPIO_PDIR_REG(PTE_BASE_PTR) & (1 << 10))
LightHouseStateUpdate:
        LDR.N    R0,??DataTable5_15  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+21
        BPL.N    ??LightHouseStateUpdate_0
//  326   {
//  327     LightHouseStateR0 = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseStateUpdate_1
//  328   }
//  329   else
//  330   {
//  331     LightHouseStateR0 = 1;
??LightHouseStateUpdate_0:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5
        STRB     R0,[R1, #+0]
//  332   }
//  333   
//  334 //  //灯塔接收模块1的状态更新 E11
//  335 //  if(GPIO_PDIR_REG(PTE_BASE_PTR) & (1 << 11))
//  336 //  {
//  337 //    LightHouseStateR1 = 0;
//  338 //  }
//  339 //  else
//  340 //  {
//  341 //    LightHouseStateR1 = 1;
//  342 //  }
//  343   
//  344   
//  345   return 1;
??LightHouseStateUpdate_1:
        MOVS     R0,#+1
        BX       LR               ;; return
//  346 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     LightHouseStateR0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     LightHouseOn2OffFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     LightHouseOff2OnFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     LightHouseWaitStartGapCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     LightHouseNoStopFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     LightHouseWaitStopLockFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     LightHouseWaitStopDelayFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     LightHouseWaitStopDelayCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_8:
        DC32     LightHouseWaitStopDelayCountLimit

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_9:
        DC32     LightHouseWaitStopGapCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_10:
        DC32     LightHouseWaitStopGapCountLimit

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_11:
        DC32     LightHouseWaitStopFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_12:
        DC32     LightHouseWaitStopOnCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_13:
        DC32     LightHouseWaitStopOnCountLimit

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_14:
        DC32     0x400ff100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_15:
        DC32     0x400ff110

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  347 
// 
//  15 bytes in section .bss
//   8 bytes in section .data
// 610 bytes in section .text
// 
// 610 bytes of CODE memory
//  23 bytes of DATA memory
//
//Errors: none
//Warnings: none
