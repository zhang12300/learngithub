///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.30.3.8024/W32 for ARM       14/Mar/2018  19:12:11
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\Debug.c
//    Command line =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\Debug.c
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
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\List\Debug.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN BatteryCheckVal
        EXTERN BlackCenEdgeStartCol
        EXTERN BlackLeftEdgeStartCol
        EXTERN BlackLeftHeadLine
        EXTERN BlackLeftLoc
        EXTERN BlackRightEdgeStartCol
        EXTERN BlackRightHeadLine
        EXTERN BlackRightLoc
        EXTERN BrickConfirmFinalColCom
        EXTERN BrickConfirmMatLimit
        EXTERN DeviFuse
        EXTERN DeviPre
        EXTERN Draw_BMP
        EXTERN FlashEraseSector
        EXTERN FlashInit
        EXTERN FlashWrite
        EXTERN ImgNew
        EXTERN LCD_CLS
        EXTERN LCD_Init
        EXTERN LCD_P6x8Str
        EXTERN LimitLeftBMax
        EXTERN LimitLeftBMin
        EXTERN LimitLeftWBMax
        EXTERN LimitLeftWBMin
        EXTERN LimitLeftWMax
        EXTERN LimitLeftWMin
        EXTERN LimitRightBMax
        EXTERN LimitRightBMin
        EXTERN LimitRightWBMax
        EXTERN LimitRightWBMin
        EXTERN LimitRightWMax
        EXTERN LimitRightWMin
        EXTERN ServoPIDD2Mat
        EXTERN ServoPIDDMat
        EXTERN SpeedBrick
        EXTERN SpeedPIDDVal
        EXTERN SpeedPIDPVal
        EXTERN SpeedTargetMat
        EXTERN SpeedTargetValGryoResult
        EXTERN SpeedTargetValGryoUp
        EXTERN SpeedTargetValStraight
        EXTERN SpeedXiaoZhiDao
        EXTERN Steer_kp
        EXTERN __aeabi_memclr4
        EXTERN gpio_init
        EXTERN limitStopLineBlackXiu
        EXTERN speedOfCar

        PUBLIC DebugButtonConfirmCount
        PUBLIC DebugButtonDeal
        PUBLIC DebugButtonFlag
        PUBLIC DebugButtonScan
        PUBLIC DebugDebug
        PUBLIC DebugDelay
        PUBLIC DebugDisplayPage
        PUBLIC DebugInit
        PUBLIC DebugModifyCursor
        PUBLIC DebugModifyCursorMark
        PUBLIC DebugModifyCursorPre
        PUBLIC DebugModifyFlag
        PUBLIC DebugModifyNum
        PUBLIC DebugModifyPage
        PUBLIC DebugModifyValue
        PUBLIC DebugOLEDUpdate
        PUBLIC DebugOLEDUpdateCount
        PUBLIC DebugPortInit
        PUBLIC DebugScreenChosen
        PUBLIC DebugSwitchConfirmCount
        PUBLIC DebugSwitchFlag
        PUBLIC DebugSwitchScan
        PUBLIC FlashFinalWrite
        PUBLIC FlashInitRead
        PUBLIC FlashReadNow
        PUBLIC FlashWriteNow
        PUBLIC TimeRealRun
        PUBLIC TimeRealRunFlag

// E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\Debug.c
//    1 /******************************************************************************/
//    2 /*******************************************************************************
//    3   文件名：调试文件Debug.c
//    4   功  能：OLED显示，FLASH参数读写。
//    5   日  期：2015.03.13
//    6   作  者：HJZ
//    7   备  注：
//    8 *******************************************************************************/
//    9 /******************************************************************************/
//   10 
//   11 #include "Debug.h"
//   12 
//   13 
//   14 
//   15 
//   16 
//   17 //拨码开关。
//   18 //拨码开关确认计数,初始化为0.

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   19 uint8 DebugSwitchConfirmCount[SwitchNum] = 
DebugSwitchConfirmCount:
        DS8 4
//   20 {
//   21   0, 0, 0, 0  
//   22 };
//   23 
//   24 //拨码开关标志。1某个方向，0另一个方向。1个16ms周期内即可被确认。

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   25 uint8 DebugSwitchFlag[SwitchNum] = 
DebugSwitchFlag:
        DS8 4
//   26 {
//   27   0, 0, 0, 0
//   28 };
//   29 
//   30 
//   31 //按键。
//   32 //按键确认计数,初始化为0。

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   33 uint8 DebugButtonConfirmCount[ButtonNum] = 
DebugButtonConfirmCount:
        DS8 8
//   34 {
//   35   0, 0, 0, 0, 0, 0  
//   36 };
//   37 //按键标志。1表示连续DebugButtonConfirmNum个16ms周期内被按下，0表示没有。

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   38 uint8 DebugButtonFlag[ButtonNum] = 
DebugButtonFlag:
        DS8 8
//   39 {
//   40   0, 0, 0, 0, 0, 0
//   41 };
//   42 
//   43 /*
//   44 //需要修改的14个值。
//   45 uint16 DebugServoPIDPMat00 = 167;
//   46 uint16 DebugServoPIDPMat01 = 195;
//   47 uint16 DebugServoPIDPMat02 = 214;
//   48 uint16 DebugServoPIDPMat03 = 225;
//   49 uint16 DebugServoPIDPMat04 = 231;
//   50 uint16 DebugServoPIDPMat05 = 234;
//   51 uint16 DebugServoPIDPMat06 = 255;
//   52 uint16 DebugServoPIDPMat07 = 235;
//   53 uint16 DebugServoPIDPMat08 = 230;
//   54 uint16 DebugServoPIDPMat09 = 217;
//   55 //3个关键值的上下界
//   56 uint8 DebugWMin10 = 160;
//   57 uint8 DebugWMax11 = 190;
//   58 uint8 DebugBMin12 = 85;
//   59 uint8 DebugBMax13 = 140;
//   60 uint8 DebugWBMin = 70;
//   61 uint8 DebugWBMax = 100;
//   62 */
//   63 
//   64 //需要修改的60个值。每页15个。不需要赋初值，初始化时会从FLASH中读取出来。

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   65 uint16 DebugModifyNum[60];
DebugModifyNum:
        DS8 120
//   66 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   67 uint8 DebugOLEDUpdateCount = 0;       //OLED的刷新频率控制，DebugOLEDUpdateCountNum个16ms刷新一次。
DebugOLEDUpdateCount:
        DS8 1
//   68 

        SECTION `.data`:DATA:REORDER:NOROOT(0)
//   69 uint8 DebugScreenChosen = DebugScreenChosenDisplay;  //界面选择标志，分显示/调参。
DebugScreenChosen:
        DATA
        DC8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   70 uint8 DebugDisplayPage = 0;                          //显示界面，页码。0~DebugDisplayPageNum-1
DebugDisplayPage:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   71 uint8 DebugModifyPage = 0;                           //调参界面，页码。0,1,2.3
DebugModifyPage:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   72 uint8 DebugModifyCursor = 0;                         //调参界面，光标。0~14.
DebugModifyCursor:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   73 uint8 DebugModifyCursorPre = 0;                      //调参界面，上一次的光标值，0~14.
DebugModifyCursorPre:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   74 uint8 DebugModifyFlag = 0;                           //调参界面，修改标志。0表示当前为上下移模式，1表示当前为加减值模式。
DebugModifyFlag:
        DS8 1
//   75 
//   76 //定时跑

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   77 uint16 TimeRealRun = 100;                         //定时跑时，时间上限。以0.1s为单位。
TimeRealRun:
        DATA
        DC16 100

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   78 uint8 TimeRealRunFlag = 0;                  //定时跑标志。0未跑完，1已跑完。
TimeRealRunFlag:
        DS8 1
//   79 
//   80 //Debug用的引脚的初始化。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   81 uint8 DebugPortInit(void)
//   82 {
DebugPortInit:
        PUSH     {R7,LR}
//   83   //4个拨码开关IO口初始化
//   84   gpio_init(PORTE,6,0,1);                               
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+6
        LDR.W    R0,??DataTable3  ;; 0x400ff100
        BL       gpio_init
//   85   gpio_init(PORTE,7,0,1);
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+7
        LDR.W    R0,??DataTable3  ;; 0x400ff100
        BL       gpio_init
//   86   gpio_init(PORTE,8,0,1);
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+8
        LDR.W    R0,??DataTable3  ;; 0x400ff100
        BL       gpio_init
//   87   gpio_init(PORTE,9,0,1);
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+9
        LDR.W    R0,??DataTable3  ;; 0x400ff100
        BL       gpio_init
//   88   
//   89   //6个按键的初始化
//   90   gpio_init(PORTE,0,0,1);  //PTE0,按键0,初始值置1。up上。
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDR.W    R0,??DataTable3  ;; 0x400ff100
        BL       gpio_init
//   91   gpio_init(PORTE,1,0,1);  //PTE1,按键1,初始值置1。down下。
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+1
        LDR.W    R0,??DataTable3  ;; 0x400ff100
        BL       gpio_init
//   92   gpio_init(PORTE,2,0,1);  //PTE2,按键2,初始值置1。ok确认。
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+2
        LDR.W    R0,??DataTable3  ;; 0x400ff100
        BL       gpio_init
//   93   gpio_init(PORTE,3,0,1);  //PTE3,按键3,初始值置1。esc取消。
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+3
        LDR.W    R0,??DataTable3  ;; 0x400ff100
        BL       gpio_init
//   94   gpio_init(PORTE,4,0,1);  //PTE4,按键4,初始值置1
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+4
        LDR.W    R0,??DataTable3  ;; 0x400ff100
        BL       gpio_init
//   95   gpio_init(PORTE,5,0,1);  //PTE5,按键5,初始值置1
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+5
        LDR.W    R0,??DataTable3  ;; 0x400ff100
        BL       gpio_init
//   96   
//   97   return 1;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//   98 }
//   99 
//  100 
//  101 //Debug专用延时函数。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  102 void DebugDelay(int ms)
//  103 {
//  104    int ii,jj;
//  105    if (ms<1) ms=1;
DebugDelay:
        CMP      R0,#+1
        BGE.N    ??DebugDelay_0
        MOVS     R0,#+1
//  106    for(ii=0;ii<ms;ii++)     
??DebugDelay_0:
        MOVS     R1,#+0
        B.N      ??DebugDelay_1
//  107      for(jj=0;jj<5341;jj++);     
??DebugDelay_2:
        ADDS     R2,R2,#+1
??DebugDelay_3:
        MOVW     R3,#+5341
        CMP      R2,R3
        BLT.N    ??DebugDelay_2
        ADDS     R1,R1,#+1
??DebugDelay_1:
        CMP      R1,R0
        BGE.N    ??DebugDelay_4
        MOVS     R2,#+0
        B.N      ??DebugDelay_3
//  108 }
??DebugDelay_4:
        BX       LR               ;; return
//  109 
//  110 
//  111 //Debug拨码开关扫描函数。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  112 uint8 DebugSwitchScan(void)
//  113 {
//  114   //拨码开关0. 
//  115   if(!(GPIOE_PDIR&0x0001))
DebugSwitchScan:
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BMI.N    ??DebugSwitchScan_0
//  116   {
//  117     if(!(GPIOE_PDIR&0x0001))
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BMI.N    ??DebugSwitchScan_1
//  118     {    
//  119       DebugSwitchFlag[0] = 1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+0]
        B.N      ??DebugSwitchScan_2
//  120     }
//  121     else
//  122     {
//  123       DebugSwitchFlag[0] = 0;
??DebugSwitchScan_1:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+0]
        B.N      ??DebugSwitchScan_2
//  124     }
//  125   }
//  126   else
//  127   {
//  128     DebugSwitchFlag[0] = 0;
??DebugSwitchScan_0:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+0]
//  129   }
//  130   
//  131   //拨码开关1. 
//  132   if(!(GPIOE_PDIR&0x0002))
??DebugSwitchScan_2:
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BMI.N    ??DebugSwitchScan_3
//  133   {
//  134     if(!(GPIOE_PDIR&0x0002))
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BMI.N    ??DebugSwitchScan_4
//  135     {
//  136       DebugSwitchFlag[1] = 1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+1]
        B.N      ??DebugSwitchScan_5
//  137     }
//  138     else
//  139     {
//  140       DebugSwitchFlag[1] = 0;
??DebugSwitchScan_4:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+1]
        B.N      ??DebugSwitchScan_5
//  141     }
//  142   }
//  143   else
//  144   {
//  145     DebugSwitchFlag[1] = 0;
??DebugSwitchScan_3:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+1]
//  146   }
//  147   
//  148   //拨码开关2.
//  149   if(!(GPIOE_PDIR&0x0004))
??DebugSwitchScan_5:
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BMI.N    ??DebugSwitchScan_6
//  150   {
//  151     if(!(GPIOE_PDIR&0x0004))
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BMI.N    ??DebugSwitchScan_7
//  152     {
//  153       DebugSwitchFlag[2] = 1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+2]
        B.N      ??DebugSwitchScan_8
//  154     }
//  155     else
//  156     {
//  157       DebugSwitchFlag[2] = 0;
??DebugSwitchScan_7:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+2]
        B.N      ??DebugSwitchScan_8
//  158     }  
//  159   }
//  160   else
//  161   {
//  162     DebugSwitchFlag[2] = 0;
??DebugSwitchScan_6:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+2]
//  163   }  
//  164   
//  165   //拨码开关3. 
//  166   if(!(GPIOE_PDIR&0x0008))
??DebugSwitchScan_8:
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+28
        BMI.N    ??DebugSwitchScan_9
//  167   {
//  168     if(!(GPIOE_PDIR&0x0008))
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+28
        BMI.N    ??DebugSwitchScan_10
//  169     {
//  170       DebugSwitchFlag[3] = 1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+3]
        B.N      ??DebugSwitchScan_11
//  171     }
//  172     else
//  173     {
//  174       DebugSwitchFlag[3] = 0;
??DebugSwitchScan_10:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+3]
        B.N      ??DebugSwitchScan_11
//  175     }
//  176   }
//  177   else
//  178   {
//  179     DebugSwitchFlag[3] = 0;
??DebugSwitchScan_9:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_2
        STRB     R0,[R1, #+3]
//  180   }    
//  181     
//  182   //拨码开关不存在检测成不成功，扫描一遍更新标志位即可。
//  183   return 1;
??DebugSwitchScan_11:
        MOVS     R0,#+1
        BX       LR               ;; return
//  184 }
//  185 
//  186 //Debug按键扫描函数。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  187 uint8 DebugButtonScan(void)
//  188 {    
//  189   
//  190   //按键0.PTE0.
//  191   if(!(GPIOE_PDIR&0x01))
DebugButtonScan:
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BMI.N    ??DebugButtonScan_0
//  192   {
//  193     //确认次数加1.
//  194     DebugButtonConfirmCount[0]++;
        LDR.W    R0,??DataTable3_3
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+0]
//  195     //连续多个16ms周期内确认，则确认。
//  196     if(DebugButtonConfirmCount[0] > DebugButtonConfirmNum)
        LDR.W    R0,??DataTable3_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BLT.N    ??DebugButtonScan_1
//  197     {
//  198       //确认标志置位。
//  199       DebugButtonFlag[0] = 1;    
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+0]
//  200       //确认次数清0。
//  201       DebugButtonConfirmCount[0] = 0;      
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+0]
//  202       //一次只允许一个按键，若确认了，则不用检测后面的按键，直接返回正确。
//  203       return 1;
        MOVS     R0,#+1
        B.N      ??DebugButtonScan_2
//  204     }
//  205     //还没到次数，仍视为没有按下。继续检测后面的按键。
//  206     else
//  207     {
//  208       DebugButtonFlag[0] = 0;
??DebugButtonScan_1:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonScan_3
//  209     }
//  210   }
//  211   else
//  212   {
//  213     //确认次数清0。
//  214     DebugButtonConfirmCount[0] = 0;
??DebugButtonScan_0:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+0]
//  215     //确认标志置0.
//  216     DebugButtonFlag[0] = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+0]
//  217     //继续检测后面的按键。
//  218   }
//  219   
//  220   //按键1.PTE1.
//  221   if(!(GPIOE_PDIR&0x02))
??DebugButtonScan_3:
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BMI.N    ??DebugButtonScan_4
//  222   {
//  223     //确认次数加1.
//  224     DebugButtonConfirmCount[1]++;
        LDR.W    R0,??DataTable3_3
        LDRB     R0,[R0, #+1]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+1]
//  225     //连续多个16ms周期内确认，则确认。
//  226     if(DebugButtonConfirmCount[1] > DebugButtonConfirmNum)
        LDR.W    R0,??DataTable3_3
        LDRB     R0,[R0, #+1]
        CMP      R0,#+11
        BLT.N    ??DebugButtonScan_5
//  227     {
//  228       //确认标志置位。
//  229       DebugButtonFlag[1] = 1;     
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+1]
//  230       //确认次数清0。
//  231       DebugButtonConfirmCount[1] = 0;     
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+1]
//  232       //一次只允许一个按键，若确认了，则不用检测后面的按键，直接返回正确。
//  233       return 1;
        MOVS     R0,#+1
        B.N      ??DebugButtonScan_2
//  234     }
//  235     //还没到次数，仍视为没有按下。继续检测后面的按键。
//  236     else
//  237     {
//  238       DebugButtonFlag[1] = 0;
??DebugButtonScan_5:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+1]
        B.N      ??DebugButtonScan_6
//  239     }
//  240   }
//  241   else
//  242   {
//  243     //确认次数清0。
//  244     DebugButtonConfirmCount[1] = 0;
??DebugButtonScan_4:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+1]
//  245     //确认标志置0.
//  246     DebugButtonFlag[1] = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+1]
//  247     //继续检测后面的按键。
//  248   }
//  249   
//  250   //按键2.PTE2.
//  251   if(!(GPIOE_PDIR&0x04))
??DebugButtonScan_6:
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BMI.N    ??DebugButtonScan_7
//  252   {
//  253     //确认次数加1.
//  254     DebugButtonConfirmCount[2]++;
        LDR.W    R0,??DataTable3_3
        LDRB     R0,[R0, #+2]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+2]
//  255     //连续多个16ms周期内确认，则确认。
//  256     if(DebugButtonConfirmCount[2] > DebugButtonConfirmNum)
        LDR.W    R0,??DataTable3_3
        LDRB     R0,[R0, #+2]
        CMP      R0,#+11
        BLT.N    ??DebugButtonScan_8
//  257     {
//  258       //确认标志置位。
//  259       DebugButtonFlag[2] = 1;     
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+2]
//  260       //确认次数清0。
//  261       DebugButtonConfirmCount[2] = 0;           
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+2]
//  262       //一次只允许一个按键，若确认了，则不用检测后面的按键，直接返回正确。
//  263       return 1;
        MOVS     R0,#+1
        B.N      ??DebugButtonScan_2
//  264     }
//  265     //还没到次数，仍视为没有按下。继续检测后面的按键。
//  266     else
//  267     {
//  268       DebugButtonFlag[2] = 0;
??DebugButtonScan_8:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+2]
        B.N      ??DebugButtonScan_9
//  269     }
//  270   }
//  271   else
//  272   {
//  273     //确认次数清0。
//  274     DebugButtonConfirmCount[2] = 0;
??DebugButtonScan_7:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+2]
//  275     //确认标志置0.
//  276     DebugButtonFlag[2] = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+2]
//  277     //继续检测后面的按键。
//  278   }  
//  279   
//  280   //按键3.PTE3.
//  281   if(!(GPIOE_PDIR&0x08))
??DebugButtonScan_9:
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+28
        BMI.N    ??DebugButtonScan_10
//  282   {
//  283     //确认次数加1.
//  284     DebugButtonConfirmCount[3]++;
        LDR.W    R0,??DataTable3_3
        LDRB     R0,[R0, #+3]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+3]
//  285     //连续多个16ms周期内确认，则确认。
//  286     if(DebugButtonConfirmCount[3] > DebugButtonConfirmNum)
        LDR.W    R0,??DataTable3_3
        LDRB     R0,[R0, #+3]
        CMP      R0,#+11
        BLT.N    ??DebugButtonScan_11
//  287     {
//  288       //确认标志置位。
//  289       DebugButtonFlag[3] = 1;     
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+3]
//  290       //确认次数清0。
//  291       DebugButtonConfirmCount[3] = 0;           
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+3]
//  292       //一次只允许一个按键，若确认了，则不用检测后面的按键，直接返回正确。
//  293       return 1;
        MOVS     R0,#+1
        B.N      ??DebugButtonScan_2
//  294     }
//  295     //还没到次数，仍视为没有按下。继续检测后面的按键。
//  296     else
//  297     {
//  298       DebugButtonFlag[3] = 0;
??DebugButtonScan_11:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+3]
        B.N      ??DebugButtonScan_12
//  299     }
//  300   }
//  301   else
//  302   {
//  303     //确认次数清0。
//  304     DebugButtonConfirmCount[3] = 0;
??DebugButtonScan_10:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+3]
//  305     //确认标志置0.
//  306     DebugButtonFlag[3] = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+3]
//  307     //继续检测后面的按键。
//  308   }
//  309   
//  310   
//  311   //按键4.PTE4.
//  312   if(!(GPIOE_PDIR&0x10))
??DebugButtonScan_12:
        LDR.W    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BMI.N    ??DebugButtonScan_13
//  313   {
//  314     //确认次数加1.
//  315     DebugButtonConfirmCount[4]++;
        LDR.W    R0,??DataTable3_3
        LDRB     R0,[R0, #+4]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+4]
//  316     //连续多个16ms周期内确认，则确认。
//  317     if(DebugButtonConfirmCount[4] > DebugButtonConfirmNum)
        LDR.W    R0,??DataTable3_3
        LDRB     R0,[R0, #+4]
        CMP      R0,#+11
        BLT.N    ??DebugButtonScan_14
//  318     {
//  319       //确认标志置位。
//  320       DebugButtonFlag[4] = 1;  
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+4]
//  321       //确认次数清0。
//  322       DebugButtonConfirmCount[4] = 0;           
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_3
        STRB     R0,[R1, #+4]
//  323       //一次只允许一个按键，若确认了，则不用检测后面的按键，直接返回正确。
//  324       return 1;
        MOVS     R0,#+1
        B.N      ??DebugButtonScan_2
//  325     }
//  326     //还没到次数，仍视为没有按下。继续检测后面的按键。
//  327     else
//  328     {
//  329       DebugButtonFlag[4] = 0;
??DebugButtonScan_14:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_4
        STRB     R0,[R1, #+4]
        B.N      ??DebugButtonScan_15
//  330     }
//  331   }
//  332   else
//  333   {
//  334     //确认次数清0。
//  335     DebugButtonConfirmCount[4] = 0;
??DebugButtonScan_13:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_3
        STRB     R0,[R1, #+4]
//  336     //确认标志置0.
//  337     DebugButtonFlag[4] = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_4
        STRB     R0,[R1, #+4]
//  338     //继续检测后面的按键。
//  339   }
//  340   
//  341   
//  342   //按键5.PTE5.
//  343   if(!(GPIOE_PDIR&0x20))
??DebugButtonScan_15:
        LDR.N    R0,??DataTable3_1  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BMI.N    ??DebugButtonScan_16
//  344   {
//  345     //确认次数加1.
//  346     DebugButtonConfirmCount[5]++;
        LDR.N    R0,??DataTable3_3
        LDRB     R0,[R0, #+5]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable3_3
        STRB     R0,[R1, #+5]
//  347     //连续多个16ms周期内确认，则确认。
//  348     if(DebugButtonConfirmCount[5] > DebugButtonConfirmNum)
        LDR.N    R0,??DataTable3_3
        LDRB     R0,[R0, #+5]
        CMP      R0,#+11
        BLT.N    ??DebugButtonScan_17
//  349     {
//  350       //确认标志置位。
//  351       DebugButtonFlag[5] = 1;     
        MOVS     R0,#+1
        LDR.N    R1,??DataTable3_4
        STRB     R0,[R1, #+5]
//  352       //确认次数清0。
//  353       DebugButtonConfirmCount[5] = 0;           
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_3
        STRB     R0,[R1, #+5]
//  354       //一次只允许一个按键，若确认了，则不用检测后面的按键，直接返回正确。
//  355       return 1;
        MOVS     R0,#+1
        B.N      ??DebugButtonScan_2
//  356     }
//  357     //还没到次数，仍视为没有按下。继续检测后面的按键。
//  358     else
//  359     {
//  360       DebugButtonFlag[5] = 0;
??DebugButtonScan_17:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_4
        STRB     R0,[R1, #+5]
        B.N      ??DebugButtonScan_18
//  361     }
//  362   }
//  363   else
//  364   {
//  365     //确认次数清0。
//  366     DebugButtonConfirmCount[5] = 0;
??DebugButtonScan_16:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_3
        STRB     R0,[R1, #+5]
//  367     //确认标志置0.
//  368     DebugButtonFlag[5] = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_4
        STRB     R0,[R1, #+5]
//  369     //继续检测后面的按键。
//  370   }
//  371     
//  372   
//  373   return 0;
??DebugButtonScan_18:
        MOVS     R0,#+0
??DebugButtonScan_2:
        BX       LR               ;; return
//  374 }
//  375 
//  376 //FLASH值的读取函数
//  377 //tempsectorindex扇区序号，tempsectorsize扇区大小，num第几个数据

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  378 uint32 FlashReadNow(uint32 tempsectorindex, uint32 tempsectorsize, uint32 num)
//  379 {
FlashReadNow:
        PUSH     {R4,R5}
//  380   uint32 temp;
//  381   
//  382   
//  383   temp = (*(byte *)((uint32)(tempsectorindex * tempsectorsize + num * 4))) 
//  384        + (*(byte *)((uint32)(tempsectorindex * tempsectorsize + num * 4 + 1))) * 256 
//  385        + (*(byte *)((uint32)(tempsectorindex * tempsectorsize + num * 4 + 2))) * 65536 
//  386        + (*(byte *)((uint32)(tempsectorindex * tempsectorsize + num * 4 + 3))) * 16777216;
        MUL      R3,R1,R0
        LDRB     R3,[R3, R2, LSL #+2]
        LSLS     R4,R2,#+2
        MLA      R4,R1,R0,R4
        LDRB     R4,[R4, #+1]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOV      R5,#+256
        MULS     R4,R5,R4
        UXTAB    R3,R4,R3
        LSLS     R4,R2,#+2
        MLA      R4,R1,R0,R4
        LDRB     R4,[R4, #+2]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R5,#+65536
        MLA      R3,R5,R4,R3
        LSLS     R2,R2,#+2
        MLA      R0,R1,R0,R2
        LDRB     R0,[R0, #+3]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R1,#+16777216
        MLA      R0,R1,R0,R3
//  387   
//  388   return temp;
        POP      {R4,R5}
        BX       LR               ;; return
//  389 }
//  390 
//  391 
//  392 //FLASH值的写入函数
//  393 //tempsectorindex扇区序号，num第几个数据，tempelementsize元素的大小（一般是4），pointeruint8数据指针（必须是uint8 *型的）。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  394 uint8 FlashWriteNow(uint32 tempsectorindex, uint32 num, uint32 tempelementsize, uint8 *pointeruint8)
//  395 {
FlashWriteNow:
        PUSH     {R7,LR}
//  396   
//  397   FlashWrite(tempsectorindex, num * 4, tempelementsize, pointeruint8);
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSLS     R1,R1,#+2
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       FlashWrite
//  398   
//  399   return 1;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//  400 }
//  401 
//  402 //FLASH模块值初始化读取

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  403 uint8 FlashInitRead(void)
//  404 {
FlashInitRead:
        PUSH     {R4,LR}
//  405   uint32 temp;
//  406   uint8 i, j, k;
//  407   
//  408   for(i = 0; i < 60; i++)
        MOVS     R4,#+0
        B.N      ??FlashInitRead_0
//  409   {
//  410     temp = FlashReadNow(FlashSectorIndex, FlashSectorSize, i);
??FlashInitRead_1:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,R4
        MOV      R1,#+2048
        MOVS     R0,#+224
        BL       FlashReadNow
//  411     DebugModifyNum[i] = temp;   //不需要强制类型转换，会自动转换的。
        LDR.N    R1,??DataTable3_5
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRH     R0,[R1, R4, LSL #+1]
//  412   }
        ADDS     R4,R4,#+1
??FlashInitRead_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+60
        BLT.N    ??FlashInitRead_1
//  413   
//  414   
//  415   //赋给实际值，不直接赋给实际变量而通过中间变量，是为了方便修改。
//  416   //LightHouseWaitStartMaxTime = DebugModifyNum[0];    //发车最多时间
//  417   //SpeedStrategyChosen = DebugModifyNum[1];          //速度档位
//  418   //MotorTakeOffQuadCountLimit = DebugModifyNum[2];   //起飞控制
//  419   //AngleZoneConfirmMatLimit = DebugModifyNum[3];  //直角黑块，标志存储数组中直角黑块的个数大于该值时，则锁存为直角黑块。
//  420   //AngleConfirmMatLimit = DebugModifyNum[4];      //直角弯标志存储数组中直角的个数大于该值时，则锁存为直角。
//  421   //BrickConfirmMatLimit = DebugModifyNum[5];      //障碍标志存储数组中障碍的个数大于该值时，则锁存为障碍。
//  422   //BrickConfirmFinalColCom = DebugModifyNum[6];   //障碍躲避时的列修正量（以15为零，左减右加。）
//  423   //LightHouseWaitStopDelayCountLimit = DebugModifyNum[7]; //停车延时判断阈值，隔这么多个16ms才开始停车判断
//  424   //LightHouseWaitStopGapCountLimit = DebugModifyNum[8];  //停车间隔计数阈值，每隔这么多个16ms就更新一次灯塔采集值
//  425 
//  426   
//  427 
//  428   //列优先,共4x8=32个，写完了DebugModifyNum[46]
//  429   k = 15;
        MOVS     R1,#+15
//  430   for(i = 0; i <= 7; i++)
        MOVS     R4,#+0
        B.N      ??FlashInitRead_2
//  431   {
//  432     for(j = 0; j <= 3; j++)
//  433     {
//  434       //ControlRow_Weight[j][i] = DebugModifyNum[k];
//  435       k++;
??FlashInitRead_3:
        ADDS     R1,R1,#+1
//  436     }
        ADDS     R0,R0,#+1
??FlashInitRead_4:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BLT.N    ??FlashInitRead_3
        ADDS     R4,R4,#+1
??FlashInitRead_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+8
        BGE.N    ??FlashInitRead_5
        MOVS     R0,#+0
        B.N      ??FlashInitRead_4
//  437   }
//  438   
//  439   //定时跑时间上限
//  440   //TimeRealRun = DebugModifyNum[47];
//  441   //电机P
//  442   //SpeedPIDPVal = DebugModifyNum[48];
//  443   //电机D
//  444   //SpeedPIDDVal = DebugModifyNum[49];
//  445   //坡道的给定速度
//  446   //SpeedTargetValGryoResult = DebugModifyNum[50];
//  447   //直角弯的给定速度
//  448   //SpeedTargetValAngle = DebugModifyNum[51];
//  449   //长直道的给定速度
//  450   //SpeedTargetValStraight = DebugModifyNum[52];
//  451   //坡道禁止赛道类型判断倒计数载入值
//  452   //GyroResultForbidBackCountNum = DebugModifyNum[53];
//  453   //连续直道计数阈值
//  454   //PathRealStraightCountLimit = DebugModifyNum[54];
//  455 //  //灯塔停车亮持续时间
//  456 //  LightHouseWaitStopOnCountLimit = DebugModifyNum[55];
//  457   //停车计数阈值。
//  458   //StopFlagMaxCountNum = DebugModifyNum[55];
//  459   //不停车标志
//  460   //LightHouseNoStopFlag = DebugModifyNum[56];
//  461   //直角弯线头差阈值。
//  462   //AngleHeadLineNum = DebugModifyNum[57];
//  463   //灯塔等待停车速度
//  464   //SpeedTargetValWaitStop = DebugModifyNum[58];
//  465   //上坡速度
//  466   //SpeedTargetValGryoUp = DebugModifyNum[59];
//  467   
//  468   
//  469  /*   
//  470   DebugModifyNum[0] = 10;
//  471   DebugModifyNum[1] = 33;
//  472   DebugModifyNum[2] = 37;
//  473   DebugModifyNum[3] = 40;
//  474   DebugModifyNum[4] = 40;
//  475   DebugModifyNum[5] = 40;
//  476   DebugModifyNum[6] = 34;
//  477   DebugModifyNum[7] = 29;
//  478   DebugModifyNum[8] = 0;
//  479   DebugModifyNum[9] = 120;
//  480   DebugModifyNum[10] = 230;
//  481   DebugModifyNum[11] = 150;
//  482   DebugModifyNum[12] = 150;
//  483   DebugModifyNum[13] = 150;
//  484   DebugModifyNum[14] = 150;
//  485   DebugModifyNum[15] = 150;
//  486   DebugModifyNum[16] = 150;
//  487   */
//  488   
//  489   speedOfCar = DebugModifyNum[0];               //校赛的时候，这个参数是决定速度的，后来就没啥用了
??FlashInitRead_5:
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable3_6
        STRH     R0,[R1, #+0]
//  490   Steer_kp[1] = DebugModifyNum[1];              //舵机的p参数
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+2]
        LDR.N    R1,??DataTable3_7
        STRH     R0,[R1, #+2]
//  491   Steer_kp[2] = DebugModifyNum[2];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+4]
        LDR.N    R1,??DataTable3_7
        STRH     R0,[R1, #+4]
//  492   Steer_kp[3] = DebugModifyNum[3];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+6]
        LDR.N    R1,??DataTable3_7
        STRH     R0,[R1, #+6]
//  493   Steer_kp[4] = DebugModifyNum[4];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+8]
        LDR.N    R1,??DataTable3_7
        STRH     R0,[R1, #+8]
//  494   Steer_kp[5] = DebugModifyNum[5];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+10]
        LDR.N    R1,??DataTable3_7
        STRH     R0,[R1, #+10]
//  495   Steer_kp[6] = DebugModifyNum[6];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+12]
        LDR.N    R1,??DataTable3_7
        STRH     R0,[R1, #+12]
//  496   Steer_kp[7] = DebugModifyNum[7];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+14]
        LDR.N    R1,??DataTable3_7
        STRH     R0,[R1, #+14]
//  497   Steer_kp[0] = DebugModifyNum[8];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+16]
        LDR.N    R1,??DataTable3_7
        STRH     R0,[R1, #+0]
//  498   SpeedPIDPVal = DebugModifyNum[9];             //电机的PI参数
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+18]
        LDR.N    R1,??DataTable3_8
        STRH     R0,[R1, #+0]
//  499   SpeedPIDDVal = DebugModifyNum[10];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+20]
        LDR.N    R1,??DataTable3_9
        STRH     R0,[R1, #+0]
//  500   SpeedTargetMat[0][5] = DebugModifyNum[11];    //给定速度
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+22]
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+10]
//  501   SpeedTargetMat[0][4] = DebugModifyNum[12];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+24]
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+8]
//  502   SpeedTargetMat[0][6] = DebugModifyNum[12];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+24]
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+12]
//  503   SpeedTargetMat[0][3] = DebugModifyNum[13];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+26]
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+6]
//  504   SpeedTargetMat[0][7] = DebugModifyNum[13];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+26]
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+14]
//  505   SpeedTargetMat[0][2] = DebugModifyNum[14];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+28]
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+4]
//  506   SpeedTargetMat[0][8] = DebugModifyNum[14];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+28]
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+16]
//  507   SpeedTargetMat[0][1] = DebugModifyNum[15];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+30]
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+2]
//  508   SpeedTargetMat[0][9] = DebugModifyNum[15];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+30]
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+18]
//  509   SpeedTargetMat[0][0] = DebugModifyNum[16];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+32]
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+0]
//  510   SpeedTargetMat[0][10] = DebugModifyNum[16];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+32]
        LDR.N    R1,??DataTable3_10
        STRH     R0,[R1, #+20]
//  511   BrickConfirmMatLimit = DebugModifyNum[17];      //障碍标志存储数组中障碍的个数大于该值时，则锁存为障碍。
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+34]
        LDR.N    R1,??DataTable3_11
        STRB     R0,[R1, #+0]
//  512   BrickConfirmFinalColCom = DebugModifyNum[18];   //障碍躲避时的列修正量（以15为零，左减右加。）
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+36]
        LDR.N    R1,??DataTable3_12
        STRB     R0,[R1, #+0]
//  513   LimitLeftWBMin = DebugModifyNum[19];          //图像黑白线的阈值
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+38]
        LDR.N    R1,??DataTable3_13
        STRB     R0,[R1, #+0]
//  514   LimitRightWBMin = DebugModifyNum[19];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+38]
        LDR.N    R1,??DataTable3_14
        STRB     R0,[R1, #+0]
//  515   LimitLeftWBMax = DebugModifyNum[20];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+40]
        LDR.N    R1,??DataTable3_15
        STRB     R0,[R1, #+0]
//  516   LimitRightWBMax = DebugModifyNum[20];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+40]
        LDR.N    R1,??DataTable3_16
        STRB     R0,[R1, #+0]
//  517   LimitLeftWMin = DebugModifyNum[21];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+42]
        LDR.N    R1,??DataTable3_17
        STRB     R0,[R1, #+0]
//  518   LimitRightWMin = DebugModifyNum[21];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+42]
        LDR.N    R1,??DataTable3_18
        STRB     R0,[R1, #+0]
//  519   LimitLeftWMax = DebugModifyNum[22];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+44]
        LDR.N    R1,??DataTable3_19
        STRB     R0,[R1, #+0]
//  520   LimitRightWMax = DebugModifyNum[22]; 
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+44]
        LDR.N    R1,??DataTable3_20
        STRB     R0,[R1, #+0]
//  521   LimitLeftBMin = DebugModifyNum[23];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+46]
        LDR.N    R1,??DataTable3_21
        STRB     R0,[R1, #+0]
//  522   LimitRightBMin = DebugModifyNum[23];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+46]
        LDR.N    R1,??DataTable3_22
        STRB     R0,[R1, #+0]
//  523   LimitLeftBMax = DebugModifyNum[24];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+48]
        LDR.N    R1,??DataTable3_23
        STRB     R0,[R1, #+0]
//  524   LimitRightBMax = DebugModifyNum[24];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+48]
        LDR.N    R1,??DataTable3_24
        STRB     R0,[R1, #+0]
//  525   SpeedTargetValStraight = DebugModifyNum[25];      //长直道速度
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+50]
        LDR.N    R1,??DataTable3_25
        STRH     R0,[R1, #+0]
//  526   SpeedBrick = DebugModifyNum[26];                  //障碍速度
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+52]
        LDR.N    R1,??DataTable3_26
        STRH     R0,[R1, #+0]
//  527   SpeedTargetValGryoUp = DebugModifyNum[27];        //上坡速度
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+54]
        LDR.N    R1,??DataTable3_27
        STRH     R0,[R1, #+0]
//  528   SpeedTargetValGryoResult = DebugModifyNum[28];    //下坡速度
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+56]
        LDR.N    R1,??DataTable3_28
        STRB     R0,[R1, #+0]
//  529   SpeedXiaoZhiDao = DebugModifyNum[29];             //小直道速度
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+58]
        LDR.N    R1,??DataTable3_29
        STRH     R0,[R1, #+0]
//  530   limitStopLineBlackXiu = DebugModifyNum[52];       //与停车线判断有关的黑色阈值的设定
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+104]
        LDR.N    R1,??DataTable3_30
        STRB     R0,[R1, #+0]
//  531   ServoPIDDMat[0] = DebugModifyNum[53];             //舵机d参数
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+106]
        LDR.N    R1,??DataTable3_31
        STRH     R0,[R1, #+0]
//  532   ServoPIDD2Mat[0] = DebugModifyNum[53];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+106]
        LDR.N    R1,??DataTable3_32
        STRH     R0,[R1, #+0]
//  533   ServoPIDDMat[1] = DebugModifyNum[54];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+108]
        LDR.N    R1,??DataTable3_31
        STRH     R0,[R1, #+2]
//  534   ServoPIDD2Mat[1] = DebugModifyNum[54];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+108]
        LDR.N    R1,??DataTable3_32
        STRH     R0,[R1, #+2]
//  535   ServoPIDDMat[2] = DebugModifyNum[55];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+110]
        LDR.N    R1,??DataTable3_31
        STRH     R0,[R1, #+4]
//  536   ServoPIDD2Mat[2] = DebugModifyNum[55];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+110]
        LDR.N    R1,??DataTable3_32
        STRH     R0,[R1, #+4]
//  537   ServoPIDDMat[3] = DebugModifyNum[56];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+112]
        LDR.N    R1,??DataTable3_31
        STRH     R0,[R1, #+6]
//  538   ServoPIDD2Mat[3] = DebugModifyNum[56];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+112]
        LDR.N    R1,??DataTable3_32
        STRH     R0,[R1, #+6]
//  539   ServoPIDDMat[4] = DebugModifyNum[57];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+114]
        LDR.N    R1,??DataTable3_31
        STRH     R0,[R1, #+8]
//  540   ServoPIDD2Mat[4] = DebugModifyNum[57];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+114]
        LDR.N    R1,??DataTable3_32
        STRH     R0,[R1, #+8]
//  541   ServoPIDDMat[5] = DebugModifyNum[58];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+116]
        LDR.N    R1,??DataTable3_31
        STRH     R0,[R1, #+10]
//  542   ServoPIDD2Mat[5] = DebugModifyNum[58];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+116]
        LDR.N    R1,??DataTable3_32
        STRH     R0,[R1, #+10]
//  543   ServoPIDDMat[6] = DebugModifyNum[59];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+118]
        LDR.N    R1,??DataTable3_31
        STRH     R0,[R1, #+12]
//  544   ServoPIDD2Mat[6] = DebugModifyNum[59];
        LDR.N    R0,??DataTable3_5
        LDRH     R0,[R0, #+118]
        LDR.N    R1,??DataTable3_32
        STRH     R0,[R1, #+12]
//  545   
//  546 
//  547   return 1;
        MOVS     R0,#+1
        POP      {R4,PC}          ;; return
//  548 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     0x400ff100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     0x400ff110

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     DebugSwitchFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     DebugButtonConfirmCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     DebugButtonFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     DebugModifyNum

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     speedOfCar

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     Steer_kp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_8:
        DC32     SpeedPIDPVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_9:
        DC32     SpeedPIDDVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_10:
        DC32     SpeedTargetMat

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_11:
        DC32     BrickConfirmMatLimit

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_12:
        DC32     BrickConfirmFinalColCom

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_13:
        DC32     LimitLeftWBMin

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_14:
        DC32     LimitRightWBMin

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_15:
        DC32     LimitLeftWBMax

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_16:
        DC32     LimitRightWBMax

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_17:
        DC32     LimitLeftWMin

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_18:
        DC32     LimitRightWMin

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_19:
        DC32     LimitLeftWMax

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_20:
        DC32     LimitRightWMax

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_21:
        DC32     LimitLeftBMin

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_22:
        DC32     LimitRightBMin

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_23:
        DC32     LimitLeftBMax

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_24:
        DC32     LimitRightBMax

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_25:
        DC32     SpeedTargetValStraight

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_26:
        DC32     SpeedBrick

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_27:
        DC32     SpeedTargetValGryoUp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_28:
        DC32     SpeedTargetValGryoResult

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_29:
        DC32     SpeedXiaoZhiDao

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_30:
        DC32     limitStopLineBlackXiu

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_31:
        DC32     ServoPIDDMat

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_32:
        DC32     ServoPIDD2Mat
//  549 
//  550 
//  551 //Debug初始化

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  552 uint8 DebugInit(void)
//  553 {
DebugInit:
        PUSH     {R7,LR}
//  554   //OLED初始化。这里会显示“Hello AE86”
//  555   LCD_Init();
        BL       LCD_Init
//  556   //FLASH初始化
//  557   FlashInit();
        BL       FlashInit
//  558   //FLASH模块值初始化读取。
//  559   //FlashInitRead();
//  560   //Debug用的引脚的初始化。
//  561   DebugPortInit();
        BL       DebugPortInit
//  562   
//  563   return 1;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//  564 }
//  565 
//  566 
//  567 
//  568 //对值的修改，temp=0表示减1个单位，temp=1表示加1个单位

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  569 uint8 DebugModifyValue(uint8 temp)
//  570 {
//  571   
//  572   //temp=0表示减1个单位
//  573   if(temp == 0)
DebugModifyValue:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.W    ??DebugModifyValue_0
//  574   {
//  575     //当前是第0页。
//  576     if(DebugModifyPage == 0)
        LDR.W    R0,??DebugModifyValue_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??DebugModifyValue_2
//  577     {
//  578       //根据光标位置来改值。
//  579       if(DebugModifyCursor == 0)
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugModifyValue_4
//  580       {
//  581         DebugModifyNum[0] --;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+0]
//  582         speedOfCar = DebugModifyNum[0];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DebugModifyValue_3+0x8
        STRH     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  583       }
//  584       else if(DebugModifyCursor == 1)
??DebugModifyValue_4:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugModifyValue_6
//  585       {
//  586         DebugModifyNum[1] --;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+2]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+2]
//  587         Steer_kp[1] = DebugModifyNum[1];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+2]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+2]
        B.W      ??DebugModifyValue_5
//  588       }
//  589       else if(DebugModifyCursor == 2)
??DebugModifyValue_6:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugModifyValue_8
//  590       {
//  591         DebugModifyNum[2] --;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+4]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+4]
//  592         Steer_kp[2] = DebugModifyNum[2];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+4]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+4]
        B.W      ??DebugModifyValue_5
//  593       }
//  594       else if(DebugModifyCursor == 3)
??DebugModifyValue_8:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugModifyValue_9
//  595       {
//  596         DebugModifyNum[3]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+6]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+6]
//  597         Steer_kp[3] = DebugModifyNum[3];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+6]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+6]
        B.W      ??DebugModifyValue_5
//  598       }
//  599       else if(DebugModifyCursor == 4)
??DebugModifyValue_9:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??DebugModifyValue_10
//  600       {
//  601         DebugModifyNum[4]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+8]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+8]
//  602         Steer_kp[4] = DebugModifyNum[4];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+8]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+8]
        B.W      ??DebugModifyValue_5
//  603       }
//  604       else if(DebugModifyCursor == 5)
??DebugModifyValue_10:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??DebugModifyValue_11
//  605       {
//  606         DebugModifyNum[5]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+10]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+10]
//  607         Steer_kp[5] = DebugModifyNum[5];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+10]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+10]
        B.W      ??DebugModifyValue_5
//  608       }
//  609       else if(DebugModifyCursor == 6)
??DebugModifyValue_11:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??DebugModifyValue_12
//  610       {
//  611         DebugModifyNum[6]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+12]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+12]
//  612         Steer_kp[6] = DebugModifyNum[6];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+12]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+12]
        B.W      ??DebugModifyValue_5
//  613       }
//  614       else if(DebugModifyCursor == 7)
??DebugModifyValue_12:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.N    ??DebugModifyValue_13
//  615       {
//  616         DebugModifyNum[7]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+14]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+14]
//  617         Steer_kp[7] = DebugModifyNum[7];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+14]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+14]
        B.W      ??DebugModifyValue_5
//  618       }
//  619       else if(DebugModifyCursor == 8)
??DebugModifyValue_13:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.N    ??DebugModifyValue_14
//  620       {
//  621         DebugModifyNum[8]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+16]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+16]
//  622         Steer_kp[0] = DebugModifyNum[8];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+16]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  623         //LightHouseWaitStopGapCountLimit = DebugModifyNum[8];
//  624       }
//  625       else if(DebugModifyCursor == 9)
??DebugModifyValue_14:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+9
        BNE.N    ??DebugModifyValue_15
//  626       {
//  627         DebugModifyNum[9]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+18]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+18]
//  628         SpeedPIDPVal = DebugModifyNum[9];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+18]
        LDR.W    R1,??DebugModifyValue_16
        STRH     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  629 
//  630         //LimitLeftWBMin = DebugModifyNum[9];
//  631         //LimitRightWBMin = DebugModifyNum[9];
//  632       }
//  633       else if(DebugModifyCursor == 10)
??DebugModifyValue_15:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??DebugModifyValue_17
//  634       {
//  635         DebugModifyNum[10]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+20]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+20]
//  636         SpeedPIDDVal = DebugModifyNum[10];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+20]
        LDR.W    R1,??DebugModifyValue_16+0x4
        STRH     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  637 
//  638         //LimitLeftWBMax = DebugModifyNum[10];
//  639         //LimitRightWBMax = DebugModifyNum[10];
//  640       }
//  641       else if(DebugModifyCursor == 11)
??DebugModifyValue_17:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BNE.N    ??DebugModifyValue_18
//  642       {
//  643         DebugModifyNum[11]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+22]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+22]
//  644         SpeedTargetMat[0][5] = DebugModifyNum[11];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+22]
        LDR.W    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+10]
        B.W      ??DebugModifyValue_5
//  645         //LimitLeftWMin = DebugModifyNum[11];
//  646         //LimitRightWMin = DebugModifyNum[11];
//  647       }
//  648       else if(DebugModifyCursor == 12)
??DebugModifyValue_18:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+12
        BNE.N    ??DebugModifyValue_19
//  649       {
//  650         DebugModifyNum[12]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+24]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+24]
//  651         SpeedTargetMat[0][4] = DebugModifyNum[12];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+24]
        LDR.W    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+8]
//  652         SpeedTargetMat[0][6] = DebugModifyNum[12];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+24]
        LDR.W    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+12]
        B.W      ??DebugModifyValue_5
//  653         //LimitLeftWMax = DebugModifyNum[12];
//  654         //LimitRightWMax = DebugModifyNum[12];
//  655       }
//  656       else if(DebugModifyCursor == 13)
??DebugModifyValue_19:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BNE.N    ??DebugModifyValue_20
//  657       {
//  658         DebugModifyNum[13]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+26]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+26]
//  659         SpeedTargetMat[0][3] = DebugModifyNum[13];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+26]
        LDR.W    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+6]
//  660         SpeedTargetMat[0][7] = DebugModifyNum[13];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+26]
        LDR.W    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+14]
        B.W      ??DebugModifyValue_5
//  661         //LimitLeftBMin = DebugModifyNum[13];
//  662         //LimitRightBMin = DebugModifyNum[13];
//  663       }
//  664       else if(DebugModifyCursor == 14)
??DebugModifyValue_20:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BNE.W    ??DebugModifyValue_5
//  665       {
//  666         DebugModifyNum[14]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+28]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+28]
//  667         SpeedTargetMat[0][2] = DebugModifyNum[14];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+28]
        LDR.W    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+4]
//  668         SpeedTargetMat[0][8] = DebugModifyNum[14];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+28]
        LDR.W    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+16]
        B.W      ??DebugModifyValue_5
//  669         //LimitLeftBMax = DebugModifyNum[14];
//  670         //LimitRightBMax = DebugModifyNum[14];
//  671       }
//  672       else
//  673       {
//  674       }
//  675     }
//  676     //当前是第1页。
//  677     else if(DebugModifyPage == 1)
??DebugModifyValue_2:
        LDR.W    R0,??DebugModifyValue_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.W    ??DebugModifyValue_21
//  678     {
//  679       //根据光标位置来改值。
//  680       if(DebugModifyCursor == 0)
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugModifyValue_22
//  681       {
//  682         DebugModifyNum[15]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+30]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+30]
//  683         SpeedTargetMat[0][1] = DebugModifyNum[15];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+30]
        LDR.W    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+2]
//  684         SpeedTargetMat[0][9] = DebugModifyNum[15];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+30]
        LDR.W    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+18]
        B.W      ??DebugModifyValue_5
//  685         //ControlRow_Weight[0][0] = DebugModifyNum[15];
//  686       }
//  687       else if(DebugModifyCursor == 1)
??DebugModifyValue_22:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugModifyValue_23
//  688       {
//  689         DebugModifyNum[16]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+32]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+32]
//  690         SpeedTargetMat[0][0] = DebugModifyNum[16];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+32]
        LDR.W    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+0]
//  691         SpeedTargetMat[0][10] = DebugModifyNum[16];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+32]
        LDR.W    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+20]
        B.W      ??DebugModifyValue_5
//  692         //ControlRow_Weight[1][0]  = DebugModifyNum[16];
//  693       }
//  694       else if(DebugModifyCursor == 2)
??DebugModifyValue_23:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugModifyValue_24
//  695       { 
//  696         DebugModifyNum[17]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+34]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+34]
//  697         BrickConfirmMatLimit = DebugModifyNum[17];      //障碍标志存储数组中障碍的个数大于该值时，则锁存为障碍。
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+34]
        LDR.W    R1,??DebugModifyValue_16+0xC
        STRB     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  698         //ControlRow_Weight[2][0]  = DebugModifyNum[17];
//  699       }
//  700       else if(DebugModifyCursor == 3)
??DebugModifyValue_24:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugModifyValue_25
//  701       {
//  702         DebugModifyNum[18]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+36]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+36]
//  703         BrickConfirmFinalColCom = DebugModifyNum[18];   //障碍躲避时的列修正量（以15为零，左减右加。）
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+36]
        LDR.W    R1,??DebugModifyValue_16+0x10
        STRB     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  704         //ControlRow_Weight[3][0]  = DebugModifyNum[18];
//  705       }
//  706       else if(DebugModifyCursor == 4)
??DebugModifyValue_25:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??DebugModifyValue_26
//  707       {
//  708         DebugModifyNum[19]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+38]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+38]
//  709         LimitLeftWBMin = DebugModifyNum[19];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+38]
        LDR.W    R1,??DebugModifyValue_16+0x14
        STRB     R0,[R1, #+0]
//  710         LimitRightWBMin = DebugModifyNum[19];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+38]
        LDR.W    R1,??DebugModifyValue_16+0x18
        STRB     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  711         //ControlRow_Weight[0][1]  = DebugModifyNum[19];
//  712       }
//  713       else if(DebugModifyCursor == 5)
??DebugModifyValue_26:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??DebugModifyValue_27
//  714       {
//  715         DebugModifyNum[20]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+40]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+40]
//  716         LimitLeftWBMax = DebugModifyNum[20];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+40]
        LDR.W    R1,??DebugModifyValue_16+0x1C
        STRB     R0,[R1, #+0]
//  717         LimitRightWBMax = DebugModifyNum[20];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+40]
        LDR.W    R1,??DebugModifyValue_28
        STRB     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  718         //ControlRow_Weight[1][1] = DebugModifyNum[20];
//  719       }
//  720       else if(DebugModifyCursor == 6)
??DebugModifyValue_27:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??DebugModifyValue_29
//  721       {
//  722         DebugModifyNum[21]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+42]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+42]
//  723         LimitLeftWMin = DebugModifyNum[21];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+42]
        LDR.W    R1,??DebugModifyValue_28+0x4
        STRB     R0,[R1, #+0]
//  724         LimitRightWMin = DebugModifyNum[21];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+42]
        LDR.W    R1,??DebugModifyValue_28+0x8
        STRB     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  725         //ControlRow_Weight[2][1] = DebugModifyNum[21];
//  726       }
//  727       else if(DebugModifyCursor == 7)
??DebugModifyValue_29:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.N    ??DebugModifyValue_30
//  728       {
//  729         DebugModifyNum[22]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+44]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+44]
//  730         LimitLeftWMax = DebugModifyNum[22];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+44]
        LDR.W    R1,??DebugModifyValue_31
        STRB     R0,[R1, #+0]
//  731         LimitRightWMax = DebugModifyNum[22]; 
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+44]
        LDR.W    R1,??DebugModifyValue_31+0x4
        STRB     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  732         //ControlRow_Weight[3][1] = DebugModifyNum[22];
//  733       }
//  734       else if(DebugModifyCursor == 8)
??DebugModifyValue_30:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.N    ??DebugModifyValue_32
//  735       {
//  736         DebugModifyNum[23]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+46]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+46]
//  737         LimitLeftBMin = DebugModifyNum[23];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+46]
        LDR.W    R1,??DebugModifyValue_31+0x8
        STRB     R0,[R1, #+0]
//  738         LimitRightBMin = DebugModifyNum[23];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+46]
        LDR.W    R1,??DebugModifyValue_31+0xC
        STRB     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  739         //ControlRow_Weight[0][2] = DebugModifyNum[23];
//  740       }
//  741       else if(DebugModifyCursor == 9)
??DebugModifyValue_32:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+9
        BNE.N    ??DebugModifyValue_33
//  742       {
//  743         DebugModifyNum[24]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+48]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+48]
//  744         LimitLeftBMax = DebugModifyNum[24];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+48]
        LDR.W    R1,??DebugModifyValue_31+0x10
        STRB     R0,[R1, #+0]
//  745         LimitRightBMax = DebugModifyNum[24];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+48]
        LDR.W    R1,??DebugModifyValue_31+0x14
        STRB     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  746         //ControlRow_Weight[1][2] = DebugModifyNum[24];
//  747       }
//  748       else if(DebugModifyCursor == 10)
??DebugModifyValue_33:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??DebugModifyValue_34
//  749       {
//  750         DebugModifyNum[25]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+50]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+50]
//  751         SpeedTargetValStraight = DebugModifyNum[25];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+50]
        LDR.W    R1,??DebugModifyValue_31+0x18
        STRH     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  752         //ControlRow_Weight[2][2] = DebugModifyNum[25];
//  753       }
//  754       else if(DebugModifyCursor == 11)
??DebugModifyValue_34:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BNE.N    ??DebugModifyValue_35
//  755       {
//  756         DebugModifyNum[26]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+52]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+52]
//  757         SpeedBrick = DebugModifyNum[26];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+52]
        LDR.W    R1,??DebugModifyValue_31+0x1C
        STRH     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  758         //ControlRow_Weight[3][2] = DebugModifyNum[26];
//  759       }
//  760       else if(DebugModifyCursor == 12)
??DebugModifyValue_35:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+12
        BNE.N    ??DebugModifyValue_36
//  761       {
//  762         DebugModifyNum[27]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+54]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+54]
//  763         SpeedTargetValGryoUp = DebugModifyNum[27];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+54]
        LDR.W    R1,??DebugModifyValue_31+0x20
        STRH     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  764         //ControlRow_Weight[0][3] = DebugModifyNum[27];
//  765       }
//  766       else if(DebugModifyCursor == 13)
??DebugModifyValue_36:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BNE.N    ??DebugModifyValue_37
//  767       {
//  768         DebugModifyNum[28]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+56]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+56]
//  769         SpeedTargetValGryoResult = DebugModifyNum[28];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+56]
        LDR.W    R1,??DebugModifyValue_31+0x24
        STRB     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  770         //ControlRow_Weight[1][3] = DebugModifyNum[28];
//  771       }
//  772       else if(DebugModifyCursor == 14)
??DebugModifyValue_37:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BNE.W    ??DebugModifyValue_5
//  773       {
//  774         DebugModifyNum[29]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+58]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+58]
//  775         SpeedXiaoZhiDao = DebugModifyNum[29];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+58]
        LDR.W    R1,??DebugModifyValue_31+0x28
        STRH     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  776         //ControlRow_Weight[2][3] = DebugModifyNum[29];
//  777       }
//  778       else
//  779       {
//  780       }
//  781     }
//  782     //当前是第2页。
//  783     else if(DebugModifyPage == 2)
??DebugModifyValue_21:
        LDR.W    R0,??DebugModifyValue_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.W    ??DebugModifyValue_38
//  784     {
//  785       //根据光标位置来改值。
//  786       if(DebugModifyCursor == 0)
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugModifyValue_39
//  787       {
//  788         DebugModifyNum[30]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+60]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+60]
        B.W      ??DebugModifyValue_5
//  789         //ControlRow_Weight[3][3] = DebugModifyNum[30];
//  790       }
//  791       else if(DebugModifyCursor == 1)
??DebugModifyValue_39:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugModifyValue_40
//  792       {
//  793         DebugModifyNum[31]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+62]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+62]
        B.W      ??DebugModifyValue_5
//  794         //ControlRow_Weight[0][4]  = DebugModifyNum[31];
//  795       }
//  796       else if(DebugModifyCursor == 2)
??DebugModifyValue_40:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugModifyValue_41
//  797       {
//  798         DebugModifyNum[32]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+64]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+64]
        B.W      ??DebugModifyValue_5
//  799         //ControlRow_Weight[1][4]  = DebugModifyNum[32];
//  800       }
//  801       else if(DebugModifyCursor == 3)
??DebugModifyValue_41:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugModifyValue_42
//  802       {
//  803         DebugModifyNum[33]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+66]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+66]
        B.W      ??DebugModifyValue_5
//  804         //ControlRow_Weight[2][4]  = DebugModifyNum[33];
//  805       }
//  806       else if(DebugModifyCursor == 4)
??DebugModifyValue_42:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??DebugModifyValue_43
//  807       {
//  808         DebugModifyNum[34]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+68]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+68]
        B.W      ??DebugModifyValue_5
//  809         //ControlRow_Weight[3][4]  = DebugModifyNum[34];
//  810       }
//  811       else if(DebugModifyCursor == 5)
??DebugModifyValue_43:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??DebugModifyValue_44
//  812       {
//  813         DebugModifyNum[35]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+70]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+70]
        B.W      ??DebugModifyValue_5
//  814         //ControlRow_Weight[0][5] = DebugModifyNum[35];
//  815       }
//  816       else if(DebugModifyCursor == 6)
??DebugModifyValue_44:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??DebugModifyValue_45
//  817       {
//  818         DebugModifyNum[36]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+72]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+72]
        B.W      ??DebugModifyValue_5
//  819         //ControlRow_Weight[1][5] = DebugModifyNum[36];
//  820       }
//  821       else if(DebugModifyCursor == 7)
??DebugModifyValue_45:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.N    ??DebugModifyValue_46
//  822       {
//  823         DebugModifyNum[37]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+74]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+74]
        B.W      ??DebugModifyValue_5
//  824         //ControlRow_Weight[2][5] = DebugModifyNum[37];
//  825       }
//  826       else if(DebugModifyCursor == 8)
??DebugModifyValue_46:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.N    ??DebugModifyValue_47
//  827       {
//  828         DebugModifyNum[38]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+76]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+76]
        B.W      ??DebugModifyValue_5
//  829         //ControlRow_Weight[3][5] = DebugModifyNum[38];
//  830       }
//  831       else if(DebugModifyCursor == 9)
??DebugModifyValue_47:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+9
        BNE.N    ??DebugModifyValue_48
//  832       {
//  833         DebugModifyNum[39]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+78]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+78]
        B.W      ??DebugModifyValue_5
//  834         //ControlRow_Weight[0][6] = DebugModifyNum[39];
//  835       }
//  836       else if(DebugModifyCursor == 10)
??DebugModifyValue_48:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??DebugModifyValue_49
//  837       {
//  838         DebugModifyNum[40]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+80]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+80]
        B.W      ??DebugModifyValue_5
//  839         //ControlRow_Weight[1][6] = DebugModifyNum[40];
//  840       }
//  841       else if(DebugModifyCursor == 11)
??DebugModifyValue_49:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BNE.N    ??DebugModifyValue_50
//  842       {
//  843         DebugModifyNum[41]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+82]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+82]
        B.W      ??DebugModifyValue_5
//  844         //ControlRow_Weight[2][6] = DebugModifyNum[41];
//  845       }
//  846       else if(DebugModifyCursor == 12)
??DebugModifyValue_50:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+12
        BNE.N    ??DebugModifyValue_51
//  847       {
//  848         DebugModifyNum[42]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+84]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+84]
        B.W      ??DebugModifyValue_5
//  849         //ControlRow_Weight[3][6] = DebugModifyNum[42];
//  850       }
//  851       else if(DebugModifyCursor == 13)
??DebugModifyValue_51:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BNE.N    ??DebugModifyValue_52
//  852       {
//  853         DebugModifyNum[43]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+86]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+86]
        B.W      ??DebugModifyValue_5
//  854         //ControlRow_Weight[0][7] = DebugModifyNum[43];
//  855       }
//  856       else if(DebugModifyCursor == 14)
??DebugModifyValue_52:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BNE.W    ??DebugModifyValue_5
//  857       {
//  858         DebugModifyNum[44]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+88]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+88]
        B.W      ??DebugModifyValue_5
//  859         //ControlRow_Weight[1][7] = DebugModifyNum[44];
//  860       }
//  861       else
//  862       {
//  863       }
//  864     }
//  865     //当前是第3页。
//  866     else if(DebugModifyPage == 3)
??DebugModifyValue_38:
        LDR.W    R0,??DebugModifyValue_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.W    ??DebugModifyValue_5
//  867     {
//  868       //根据光标位置来改值。
//  869       if(DebugModifyCursor == 0)
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugModifyValue_53
//  870       {
//  871         DebugModifyNum[45]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+90]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+90]
        B.W      ??DebugModifyValue_5
//  872         //ControlRow_Weight[2][7] = DebugModifyNum[45];
//  873       }
//  874       else if(DebugModifyCursor == 1)
??DebugModifyValue_53:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugModifyValue_54
//  875       {
//  876         DebugModifyNum[46]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+92]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+92]
        B.W      ??DebugModifyValue_5
//  877         //ControlRow_Weight[3][7]  = DebugModifyNum[46];
//  878       }
//  879       else if(DebugModifyCursor == 2)
??DebugModifyValue_54:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugModifyValue_55
//  880       {
//  881         DebugModifyNum[47] -= 10;;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+94]
        SUBS     R0,R0,#+10
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+94]
        B.W      ??DebugModifyValue_5
//  882         //TimeRealRun -= 10;
//  883       }
//  884       else if(DebugModifyCursor == 3)
??DebugModifyValue_55:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugModifyValue_56
//  885       {
//  886         DebugModifyNum[48] -= 1;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+96]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+96]
        B.W      ??DebugModifyValue_5
//  887         //SpeedPIDPVal -= 1;
//  888       }
//  889       else if(DebugModifyCursor == 4)
??DebugModifyValue_56:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??DebugModifyValue_57
//  890       {
//  891         DebugModifyNum[49] -= 1;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+98]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+98]
        B.W      ??DebugModifyValue_5
//  892         //SpeedPIDDVal -= 1;
//  893       }
//  894       else if(DebugModifyCursor == 5)
??DebugModifyValue_57:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??DebugModifyValue_58
//  895       {
//  896         DebugModifyNum[50]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+100]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+100]
        B.W      ??DebugModifyValue_5
//  897         //SpeedTargetValGryoResult--;
//  898       }
//  899       else if(DebugModifyCursor == 6)
??DebugModifyValue_58:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??DebugModifyValue_59
//  900       {
//  901         DebugModifyNum[51]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+102]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+102]
        B.W      ??DebugModifyValue_5
//  902         //SpeedTargetValAngle--;
//  903       }
//  904       else if(DebugModifyCursor == 7)
??DebugModifyValue_59:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.N    ??DebugModifyValue_60
//  905       {
//  906         DebugModifyNum[52]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+104]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+104]
//  907         limitStopLineBlackXiu = DebugModifyNum[52];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+104]
        LDR.W    R1,??DataTable4
        STRB     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  908         //SpeedTargetValStraight = DebugModifyNum[52];
//  909       }
//  910       else if(DebugModifyCursor == 8)
??DebugModifyValue_60:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.N    ??DebugModifyValue_61
//  911       {
//  912         DebugModifyNum[53]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+106]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+106]
//  913         ServoPIDDMat[0] = DebugModifyNum[53];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+106]
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+0]
//  914         ServoPIDD2Mat[0] = DebugModifyNum[53];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+106]
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  915         //GyroResultForbidBackCountNum = DebugModifyNum[53];
//  916       }
//  917       else if(DebugModifyCursor == 9)
??DebugModifyValue_61:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+9
        BNE.N    ??DebugModifyValue_62
//  918       {
//  919         DebugModifyNum[54]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+108]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+108]
//  920         ServoPIDDMat[1] = DebugModifyNum[54];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+108]
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+2]
//  921         ServoPIDD2Mat[1] = DebugModifyNum[54];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+108]
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+2]
        B.W      ??DebugModifyValue_5
//  922         //PathRealStraightCountLimit = DebugModifyNum[54];
//  923       }
//  924       else if(DebugModifyCursor == 10)
??DebugModifyValue_62:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??DebugModifyValue_63
//  925       {
//  926         DebugModifyNum[55]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+110]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+110]
//  927         ServoPIDDMat[2] = DebugModifyNum[55];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+110]
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+4]
//  928         ServoPIDD2Mat[2] = DebugModifyNum[55];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+110]
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+4]
        B.W      ??DebugModifyValue_5
//  929         //StopFlagMaxCountNum = DebugModifyNum[55];
//  930       }
//  931       else if(DebugModifyCursor == 11)
??DebugModifyValue_63:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BNE.N    ??DebugModifyValue_64
//  932       {
//  933         DebugModifyNum[56]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+112]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+112]
//  934         ServoPIDDMat[3] = DebugModifyNum[56];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+112]
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+6]
//  935         ServoPIDD2Mat[3] = DebugModifyNum[56];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+112]
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+6]
        B.W      ??DebugModifyValue_5
//  936         //LightHouseNoStopFlag = DebugModifyNum[56];
//  937       }
//  938       else if(DebugModifyCursor == 12)
??DebugModifyValue_64:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+12
        BNE.N    ??DebugModifyValue_65
//  939       {
//  940         DebugModifyNum[57]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+114]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+114]
//  941         ServoPIDDMat[4] = DebugModifyNum[57];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+114]
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+8]
//  942         ServoPIDD2Mat[4] = DebugModifyNum[57];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+114]
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+8]
        B.W      ??DebugModifyValue_5
//  943         //AngleHeadLineNum = DebugModifyNum[57];
//  944       }
//  945       else if(DebugModifyCursor == 13)
??DebugModifyValue_65:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BNE.N    ??DebugModifyValue_66
//  946       {
//  947         DebugModifyNum[58]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+116]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+116]
//  948         ServoPIDDMat[5] = DebugModifyNum[58];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+116]
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+10]
//  949         ServoPIDD2Mat[5] = DebugModifyNum[58];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+116]
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+10]
        B.W      ??DebugModifyValue_5
//  950         //SpeedTargetValWaitStop = DebugModifyNum[58];
//  951       }
//  952       else if(DebugModifyCursor == 14)
??DebugModifyValue_66:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BNE.W    ??DebugModifyValue_5
//  953       {
//  954         DebugModifyNum[59]--;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+118]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+118]
//  955         ServoPIDDMat[6] = DebugModifyNum[59];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+118]
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+12]
//  956         ServoPIDD2Mat[6] = DebugModifyNum[59];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+118]
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+12]
        B.W      ??DebugModifyValue_5
//  957         //SpeedTargetValGryoUp = DebugModifyNum[59];
//  958       }
//  959       else
//  960       {
//  961       }      
//  962       
//  963     }
//  964     else
//  965     {
//  966     }
//  967   }
//  968   //temp=1表示加1个单位
//  969   else
//  970   {
//  971     //当前是第0页。
//  972     if(DebugModifyPage == 0)
??DebugModifyValue_0:
        LDR.W    R0,??DebugModifyValue_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??DebugModifyValue_67
//  973     {
//  974       //根据光标位置来改值。
//  975       if(DebugModifyCursor == 0)
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugModifyValue_68
//  976       {
//  977         DebugModifyNum[0] ++;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+0]
//  978         speedOfCar = DebugModifyNum[0];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DebugModifyValue_3+0x8
        STRH     R0,[R1, #+0]
        B.W      ??DebugModifyValue_5
//  979       }
//  980       else if(DebugModifyCursor == 1)
??DebugModifyValue_68:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugModifyValue_69
//  981       {
//  982         DebugModifyNum[1]++;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+2]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+2]
//  983         Steer_kp[1] = DebugModifyNum[1];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+2]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+2]
        B.W      ??DebugModifyValue_5
//  984       }
//  985       else if(DebugModifyCursor == 2)
??DebugModifyValue_69:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugModifyValue_70
//  986       {
//  987         DebugModifyNum[2] ++;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+4]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+4]
//  988         Steer_kp[2] = DebugModifyNum[2];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+4]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+4]
        B.W      ??DebugModifyValue_5
//  989       }
//  990       else if(DebugModifyCursor == 3)
??DebugModifyValue_70:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugModifyValue_71
//  991       {
//  992         DebugModifyNum[3]++;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+6]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+6]
//  993         Steer_kp[3] = DebugModifyNum[3];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+6]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+6]
        B.W      ??DebugModifyValue_5
//  994       }
//  995       else if(DebugModifyCursor == 4)
??DebugModifyValue_71:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??DebugModifyValue_72
//  996       {
//  997         DebugModifyNum[4]++;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+8]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+8]
//  998         Steer_kp[4] = DebugModifyNum[4];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+8]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+8]
        B.W      ??DebugModifyValue_5
//  999       }
// 1000       else if(DebugModifyCursor == 5)
??DebugModifyValue_72:
        LDR.W    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??DebugModifyValue_73
// 1001       {
// 1002         DebugModifyNum[5]++;
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+10]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+10]
// 1003         Steer_kp[5] = DebugModifyNum[5];
        LDR.W    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+10]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+10]
        B.W      ??DebugModifyValue_5
// 1004       }
// 1005       else if(DebugModifyCursor == 6)
??DebugModifyValue_73:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??DebugModifyValue_74
// 1006       {
// 1007         DebugModifyNum[6]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+12]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+12]
// 1008         Steer_kp[6] = DebugModifyNum[6];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+12]
        LDR.W    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+12]
        B.N      ??DebugModifyValue_5
// 1009       }
// 1010       else if(DebugModifyCursor == 7)
??DebugModifyValue_74:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.N    ??DebugModifyValue_75
// 1011       {
// 1012         DebugModifyNum[7]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+14]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+14]
// 1013         Steer_kp[7] = DebugModifyNum[7];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+14]
        LDR.N    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+14]
        B.N      ??DebugModifyValue_5
// 1014       }
// 1015       else if(DebugModifyCursor == 8)
??DebugModifyValue_75:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.N    ??DebugModifyValue_76
// 1016       {
// 1017         DebugModifyNum[8]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+16]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+16]
// 1018         Steer_kp[0] = DebugModifyNum[8];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+16]
        LDR.N    R1,??DebugModifyValue_7
        STRH     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1019         //LightHouseWaitStopGapCountLimit = DebugModifyNum[8];
// 1020       }
// 1021       else if(DebugModifyCursor == 9)
??DebugModifyValue_76:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+9
        BNE.N    ??DebugModifyValue_77
// 1022       {
// 1023         DebugModifyNum[9]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+18]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+18]
// 1024         SpeedPIDPVal = DebugModifyNum[9];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+18]
        LDR.W    R1,??DebugModifyValue_16
        STRH     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1025         //LimitLeftWBMin = DebugModifyNum[9];
// 1026         //LimitRightWBMin = DebugModifyNum[9];
// 1027       }
// 1028       else if(DebugModifyCursor == 10)
??DebugModifyValue_77:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??DebugModifyValue_78
// 1029       {
// 1030         DebugModifyNum[10]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+20]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+20]
// 1031         SpeedPIDDVal = DebugModifyNum[10];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+20]
        LDR.N    R1,??DebugModifyValue_16+0x4
        STRH     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1032         //LimitLeftWBMax = DebugModifyNum[10];
// 1033         //LimitRightWBMax = DebugModifyNum[10];
// 1034       }
// 1035       else if(DebugModifyCursor == 11)
??DebugModifyValue_78:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BNE.N    ??DebugModifyValue_79
// 1036       {
// 1037         DebugModifyNum[11]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+22]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+22]
// 1038         SpeedTargetMat[0][5] = DebugModifyNum[11];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+22]
        LDR.N    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+10]
        B.N      ??DebugModifyValue_5
// 1039         //LimitLeftWMin = DebugModifyNum[11];
// 1040         //LimitRightWMin = DebugModifyNum[11];
// 1041       }
// 1042       else if(DebugModifyCursor == 12)
??DebugModifyValue_79:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+12
        BNE.N    ??DebugModifyValue_80
// 1043       {
// 1044         DebugModifyNum[12]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+24]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+24]
// 1045         SpeedTargetMat[0][4] = DebugModifyNum[12];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+24]
        LDR.N    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+8]
// 1046         SpeedTargetMat[0][6] = DebugModifyNum[12];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+24]
        LDR.N    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+12]
        B.N      ??DebugModifyValue_5
// 1047         //LimitLeftWMax = DebugModifyNum[12];
// 1048         //LimitRightWMax = DebugModifyNum[12];
// 1049       }
// 1050       else if(DebugModifyCursor == 13)
??DebugModifyValue_80:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BNE.N    ??DebugModifyValue_81
// 1051       {
// 1052         DebugModifyNum[13]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+26]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+26]
// 1053         SpeedTargetMat[0][3] = DebugModifyNum[13];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+26]
        LDR.N    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+6]
// 1054         SpeedTargetMat[0][7] = DebugModifyNum[13];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+26]
        LDR.N    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+14]
        B.N      ??DebugModifyValue_5
// 1055         //LimitLeftBMin = DebugModifyNum[13];
// 1056         //LimitRightBMin = DebugModifyNum[13];
// 1057       }
// 1058       else if(DebugModifyCursor == 14)
??DebugModifyValue_81:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BNE.W    ??DebugModifyValue_5
// 1059       {
// 1060         DebugModifyNum[14]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+28]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+28]
// 1061         SpeedTargetMat[0][2] = DebugModifyNum[14];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+28]
        LDR.N    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+4]
// 1062         SpeedTargetMat[0][8] = DebugModifyNum[14];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+28]
        LDR.N    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+16]
        B.N      ??DebugModifyValue_5
// 1063         //LimitLeftBMax = DebugModifyNum[14];
// 1064         //LimitRightBMax = DebugModifyNum[14];
// 1065       }
// 1066       else
// 1067       {
// 1068       }
// 1069     }
// 1070     //当前是第1页。
// 1071     else if(DebugModifyPage == 1)
??DebugModifyValue_67:
        LDR.N    R0,??DebugModifyValue_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.W    ??DebugModifyValue_82
// 1072     {
// 1073       //根据光标位置来改值。
// 1074       if(DebugModifyCursor == 0)
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugModifyValue_83
// 1075       {
// 1076         DebugModifyNum[15]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+30]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+30]
// 1077         SpeedTargetMat[0][1] = DebugModifyNum[15];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+30]
        LDR.N    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+2]
// 1078         SpeedTargetMat[0][9] = DebugModifyNum[15];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+30]
        LDR.N    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+18]
        B.N      ??DebugModifyValue_5
// 1079         //ControlRow_Weight[0][0] = DebugModifyNum[15];
// 1080       }
// 1081       else if(DebugModifyCursor == 1)
??DebugModifyValue_83:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugModifyValue_84
// 1082       {
// 1083         DebugModifyNum[16]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+32]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+32]
// 1084         SpeedTargetMat[0][0] = DebugModifyNum[16];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+32]
        LDR.N    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+0]
// 1085         SpeedTargetMat[0][10] = DebugModifyNum[16];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+32]
        LDR.N    R1,??DebugModifyValue_16+0x8
        STRH     R0,[R1, #+20]
        B.N      ??DebugModifyValue_5
// 1086         //ControlRow_Weight[1][0]  = DebugModifyNum[16];
// 1087       }
// 1088       else if(DebugModifyCursor == 2)
??DebugModifyValue_84:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugModifyValue_85
// 1089       {
// 1090         DebugModifyNum[17]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+34]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+34]
// 1091         BrickConfirmMatLimit = DebugModifyNum[17];      //障碍标志存储数组中障碍的个数大于该值时，则锁存为障碍。
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+34]
        LDR.N    R1,??DebugModifyValue_16+0xC
        STRB     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1092         //ControlRow_Weight[2][0]  = DebugModifyNum[17];
// 1093       }
// 1094       else if(DebugModifyCursor == 3)
??DebugModifyValue_85:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugModifyValue_86
// 1095       {
// 1096         DebugModifyNum[18]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+36]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+36]
// 1097         BrickConfirmFinalColCom = DebugModifyNum[18];   //障碍躲避时的列修正量（以15为零，左减右加。）
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+36]
        LDR.N    R1,??DebugModifyValue_16+0x10
        STRB     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1098         //ControlRow_Weight[3][0]  = DebugModifyNum[18];
// 1099       }
// 1100       else if(DebugModifyCursor == 4)
??DebugModifyValue_86:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??DebugModifyValue_87
// 1101       {
// 1102         DebugModifyNum[19]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+38]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+38]
// 1103         LimitLeftWBMin = DebugModifyNum[19];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+38]
        LDR.N    R1,??DebugModifyValue_16+0x14
        STRB     R0,[R1, #+0]
// 1104         LimitRightWBMin = DebugModifyNum[19];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+38]
        LDR.N    R1,??DebugModifyValue_16+0x18
        STRB     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1105         //ControlRow_Weight[0][1]  = DebugModifyNum[19];
// 1106       }
// 1107       else if(DebugModifyCursor == 5)
??DebugModifyValue_87:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??DebugModifyValue_88
// 1108       {
// 1109         DebugModifyNum[20]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+40]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+40]
// 1110         LimitLeftWBMax = DebugModifyNum[20];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+40]
        LDR.N    R1,??DebugModifyValue_16+0x1C
        STRB     R0,[R1, #+0]
// 1111         LimitRightWBMax = DebugModifyNum[20];        
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+40]
        LDR.W    R1,??DebugModifyValue_28
        STRB     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1112         //ControlRow_Weight[1][1] = DebugModifyNum[20];
// 1113       }
// 1114       else if(DebugModifyCursor == 6)
??DebugModifyValue_88:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??DebugModifyValue_89
// 1115       {
// 1116         DebugModifyNum[21]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+42]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+42]
// 1117         LimitLeftWMin = DebugModifyNum[21];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+42]
        LDR.W    R1,??DebugModifyValue_28+0x4
        STRB     R0,[R1, #+0]
// 1118         LimitRightWMin = DebugModifyNum[21];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+42]
        LDR.W    R1,??DebugModifyValue_28+0x8
        STRB     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1119         //ControlRow_Weight[2][1] = DebugModifyNum[21];
// 1120       }
// 1121       else if(DebugModifyCursor == 7)
??DebugModifyValue_89:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.N    ??DebugModifyValue_90
// 1122       {
// 1123         DebugModifyNum[22]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+44]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+44]
// 1124         LimitLeftWMax = DebugModifyNum[22];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+44]
        LDR.W    R1,??DebugModifyValue_31
        STRB     R0,[R1, #+0]
// 1125         LimitRightWMax = DebugModifyNum[22]; 
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+44]
        LDR.W    R1,??DebugModifyValue_31+0x4
        STRB     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1126         //ControlRow_Weight[3][1] = DebugModifyNum[22];
// 1127       }
// 1128       else if(DebugModifyCursor == 8)
??DebugModifyValue_90:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.N    ??DebugModifyValue_91
// 1129       {
// 1130         DebugModifyNum[23]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+46]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+46]
// 1131         LimitLeftBMin = DebugModifyNum[23];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+46]
        LDR.W    R1,??DebugModifyValue_31+0x8
        STRB     R0,[R1, #+0]
// 1132         LimitRightBMin = DebugModifyNum[23];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+46]
        LDR.W    R1,??DebugModifyValue_31+0xC
        STRB     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1133         //ControlRow_Weight[0][2] = DebugModifyNum[23];
// 1134       }
// 1135       else if(DebugModifyCursor == 9)
??DebugModifyValue_91:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+9
        BNE.N    ??DebugModifyValue_92
// 1136       {
// 1137         DebugModifyNum[24]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+48]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+48]
// 1138         LimitLeftBMax = DebugModifyNum[24];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+48]
        LDR.W    R1,??DebugModifyValue_31+0x10
        STRB     R0,[R1, #+0]
// 1139         LimitRightBMax = DebugModifyNum[24];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+48]
        LDR.W    R1,??DebugModifyValue_31+0x14
        STRB     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
        DATA
??DebugModifyValue_1:
        DC32     DebugModifyPage
        THUMB
// 1140         //ControlRow_Weight[1][2] = DebugModifyNum[24];
// 1141       }
// 1142       else if(DebugModifyCursor == 10)
??DebugModifyValue_92:
        LDR.N    R0,??DebugModifyValue_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??DebugModifyValue_93
// 1143       {
// 1144         DebugModifyNum[25]++;
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+50]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DebugModifyValue_3+0x4
        STRH     R0,[R1, #+50]
// 1145         SpeedTargetValStraight = DebugModifyNum[25];
        LDR.N    R0,??DebugModifyValue_3+0x4
        LDRH     R0,[R0, #+50]
        LDR.W    R1,??DebugModifyValue_31+0x18
        STRH     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
        Nop      
        DATA
??DebugModifyValue_3:
        DC32     DebugModifyCursor
        DC32     DebugModifyNum
        DC32     speedOfCar
        THUMB
// 1146         //ControlRow_Weight[2][2] = DebugModifyNum[25];
// 1147       }
// 1148       else if(DebugModifyCursor == 11)
??DebugModifyValue_93:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BNE.N    ??DebugModifyValue_94
// 1149       {
// 1150         DebugModifyNum[26]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+52]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+52]
// 1151         SpeedBrick = DebugModifyNum[26];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+52]
        LDR.W    R1,??DebugModifyValue_31+0x1C
        STRH     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
        Nop      
        DATA
??DebugModifyValue_7:
        DC32     Steer_kp
        THUMB
// 1152         //ControlRow_Weight[3][2] = DebugModifyNum[26];
// 1153       }
// 1154       else if(DebugModifyCursor == 12)
??DebugModifyValue_94:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+12
        BNE.N    ??DebugModifyValue_95
// 1155       {
// 1156         DebugModifyNum[27]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+54]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+54]
// 1157         SpeedTargetValGryoUp = DebugModifyNum[27];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+54]
        LDR.N    R1,??DebugModifyValue_31+0x20
        STRH     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1158         //ControlRow_Weight[0][3] = DebugModifyNum[27];
// 1159       }
// 1160       else if(DebugModifyCursor == 13)
??DebugModifyValue_95:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BNE.N    ??DebugModifyValue_96
// 1161       {
// 1162         DebugModifyNum[28]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+56]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+56]
// 1163         SpeedTargetValGryoResult = DebugModifyNum[28];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+56]
        LDR.N    R1,??DebugModifyValue_31+0x24
        STRB     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1164         //ControlRow_Weight[1][3] = DebugModifyNum[28];
// 1165       }
// 1166       else if(DebugModifyCursor == 14)
??DebugModifyValue_96:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BNE.W    ??DebugModifyValue_5
// 1167       {
// 1168         DebugModifyNum[29]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+58]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+58]
// 1169         SpeedXiaoZhiDao = DebugModifyNum[29];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+58]
        LDR.N    R1,??DebugModifyValue_31+0x28
        STRH     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
        Nop      
        DATA
??DebugModifyValue_16:
        DC32     SpeedPIDPVal
        DC32     SpeedPIDDVal
        DC32     SpeedTargetMat
        DC32     BrickConfirmMatLimit
        DC32     BrickConfirmFinalColCom
        DC32     LimitLeftWBMin
        DC32     LimitRightWBMin
        DC32     LimitLeftWBMax
        THUMB
// 1170         //ControlRow_Weight[2][3] = DebugModifyNum[29];
// 1171       }
// 1172       else
// 1173       {
// 1174       }
// 1175     }
// 1176     //当前是第2页。
// 1177     else if(DebugModifyPage == 2)
??DebugModifyValue_82:
        LDR.W    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.W    ??DebugModifyValue_97
// 1178     {
// 1179       //根据光标位置来改值。
// 1180       if(DebugModifyCursor == 0)
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugModifyValue_98
// 1181       {
// 1182         DebugModifyNum[30]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+60]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+60]
        B.N      ??DebugModifyValue_5
// 1183         //ControlRow_Weight[3][3] = DebugModifyNum[30];
// 1184       }
// 1185       else if(DebugModifyCursor == 1)
??DebugModifyValue_98:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugModifyValue_99
// 1186       {
// 1187         DebugModifyNum[31]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+62]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+62]
        B.N      ??DebugModifyValue_5
// 1188         //ControlRow_Weight[0][4]  = DebugModifyNum[31];
// 1189       }
// 1190       else if(DebugModifyCursor == 2)
??DebugModifyValue_99:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugModifyValue_100
// 1191       {
// 1192         DebugModifyNum[32]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+64]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+64]
        B.N      ??DebugModifyValue_5
// 1193         //ControlRow_Weight[1][4]  = DebugModifyNum[32];
// 1194       }
// 1195       else if(DebugModifyCursor == 3)
??DebugModifyValue_100:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugModifyValue_101
// 1196       {
// 1197         DebugModifyNum[33]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+66]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+66]
        B.N      ??DebugModifyValue_5
// 1198         //ControlRow_Weight[2][4]  = DebugModifyNum[33];
// 1199       }
// 1200       else if(DebugModifyCursor == 4)
??DebugModifyValue_101:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??DebugModifyValue_102
// 1201       {
// 1202         DebugModifyNum[34]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+68]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+68]
        B.N      ??DebugModifyValue_5
// 1203         //ControlRow_Weight[3][4]  = DebugModifyNum[34];
// 1204       }
// 1205       else if(DebugModifyCursor == 5)
??DebugModifyValue_102:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??DebugModifyValue_103
// 1206       {
// 1207         DebugModifyNum[35]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+70]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+70]
        B.N      ??DebugModifyValue_5
// 1208         //ControlRow_Weight[0][5] = DebugModifyNum[35];
// 1209       }
// 1210       else if(DebugModifyCursor == 6)
??DebugModifyValue_103:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??DebugModifyValue_104
// 1211       {
// 1212         DebugModifyNum[36]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+72]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+72]
        B.N      ??DebugModifyValue_5
// 1213         //ControlRow_Weight[1][5] = DebugModifyNum[36];
// 1214       }
// 1215       else if(DebugModifyCursor == 7)
??DebugModifyValue_104:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.N    ??DebugModifyValue_105
// 1216       {
// 1217         DebugModifyNum[37]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+74]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+74]
        B.N      ??DebugModifyValue_5
// 1218         //ControlRow_Weight[2][5] = DebugModifyNum[37];
// 1219       }
// 1220       else if(DebugModifyCursor == 8)
??DebugModifyValue_105:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.N    ??DebugModifyValue_106
// 1221       {
// 1222         DebugModifyNum[38]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+76]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+76]
        B.N      ??DebugModifyValue_5
// 1223         //ControlRow_Weight[3][5] = DebugModifyNum[38];
// 1224       }
// 1225       else if(DebugModifyCursor == 9)
??DebugModifyValue_106:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+9
        BNE.N    ??DebugModifyValue_107
// 1226       {
// 1227         DebugModifyNum[39]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+78]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+78]
        B.N      ??DebugModifyValue_5
// 1228         //ControlRow_Weight[0][6] = DebugModifyNum[39];
// 1229       }
// 1230       else if(DebugModifyCursor == 10)
??DebugModifyValue_107:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??DebugModifyValue_108
// 1231       {
// 1232         DebugModifyNum[40]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+80]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+80]
        B.N      ??DebugModifyValue_5
// 1233         //ControlRow_Weight[1][6] = DebugModifyNum[40];
// 1234       }
// 1235       else if(DebugModifyCursor == 11)
??DebugModifyValue_108:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BNE.N    ??DebugModifyValue_109
// 1236       {
// 1237         DebugModifyNum[41]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+82]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+82]
        B.N      ??DebugModifyValue_5
// 1238         //ControlRow_Weight[2][6] = DebugModifyNum[41];
// 1239       }
// 1240       else if(DebugModifyCursor == 12)
??DebugModifyValue_109:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+12
        BNE.N    ??DebugModifyValue_110
// 1241       {
// 1242         DebugModifyNum[42]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+84]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+84]
        B.N      ??DebugModifyValue_5
// 1243         //ControlRow_Weight[3][6] = DebugModifyNum[42];
// 1244       }
// 1245       else if(DebugModifyCursor == 13)
??DebugModifyValue_110:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BNE.N    ??DebugModifyValue_111
// 1246       {
// 1247         DebugModifyNum[43]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+86]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+86]
        B.N      ??DebugModifyValue_5
// 1248         //ControlRow_Weight[0][7] = DebugModifyNum[43];
// 1249       }
// 1250       else if(DebugModifyCursor == 14)
??DebugModifyValue_111:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BNE.W    ??DebugModifyValue_5
// 1251       {
// 1252         DebugModifyNum[44]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+88]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+88]
        B.N      ??DebugModifyValue_5
// 1253         //ControlRow_Weight[1][7] = DebugModifyNum[44];
// 1254       }
// 1255       else
// 1256       {
// 1257       }
// 1258     }
// 1259     //当前是第3页。
// 1260     else if(DebugModifyPage == 3)
??DebugModifyValue_97:
        LDR.W    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.W    ??DebugModifyValue_5
// 1261     {
// 1262       //根据光标位置来改值。
// 1263       if(DebugModifyCursor == 0)
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugModifyValue_112
// 1264       {
// 1265         DebugModifyNum[45]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+90]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+90]
        B.N      ??DebugModifyValue_5
// 1266         //ControlRow_Weight[2][7] = DebugModifyNum[45];
// 1267       }
// 1268       else if(DebugModifyCursor == 1)
??DebugModifyValue_112:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugModifyValue_113
// 1269       {
// 1270         DebugModifyNum[46]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+92]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+92]
        B.N      ??DebugModifyValue_5
// 1271         //ControlRow_Weight[3][7]  = DebugModifyNum[46];
// 1272       }
// 1273       else if(DebugModifyCursor == 2)
??DebugModifyValue_113:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugModifyValue_114
// 1274       {
// 1275         DebugModifyNum[47] += 10;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+94]
        ADDS     R0,R0,#+10
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+94]
        B.N      ??DebugModifyValue_5
// 1276         //TimeRealRun += 10;
// 1277       }
// 1278       else if(DebugModifyCursor == 3)
??DebugModifyValue_114:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugModifyValue_115
// 1279       {
// 1280         DebugModifyNum[48] += 1;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+96]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+96]
        B.N      ??DebugModifyValue_5
// 1281         //SpeedPIDPVal += 1;
// 1282       }
// 1283       else if(DebugModifyCursor == 4)
??DebugModifyValue_115:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??DebugModifyValue_116
// 1284       {
// 1285         DebugModifyNum[49] += 1;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+98]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+98]
        B.N      ??DebugModifyValue_5
// 1286         //SpeedPIDDVal += 1;
// 1287       }
// 1288       else if(DebugModifyCursor == 5)
??DebugModifyValue_116:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??DebugModifyValue_117
// 1289       {
// 1290         DebugModifyNum[50]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+100]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+100]
        B.N      ??DebugModifyValue_5
// 1291         //SpeedTargetValGryoResult++;
// 1292       }
// 1293       else if(DebugModifyCursor == 6)
??DebugModifyValue_117:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??DebugModifyValue_118
// 1294       {
// 1295         DebugModifyNum[51]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+102]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+102]
        B.N      ??DebugModifyValue_5
        Nop      
        DATA
??DebugModifyValue_28:
        DC32     LimitRightWBMax
        DC32     LimitLeftWMin
        DC32     LimitRightWMin
        THUMB
// 1296         //SpeedTargetValAngle++;
// 1297       }
// 1298       else if(DebugModifyCursor == 7)
??DebugModifyValue_118:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.N    ??DebugModifyValue_119
// 1299       {
// 1300         DebugModifyNum[52]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+104]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+104]
// 1301         limitStopLineBlackXiu = DebugModifyNum[52];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+104]
        LDR.N    R1,??DataTable4
        STRB     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
        Nop      
        DATA
??DebugModifyValue_31:
        DC32     LimitLeftWMax
        DC32     LimitRightWMax
        DC32     LimitLeftBMin
        DC32     LimitRightBMin
        DC32     LimitLeftBMax
        DC32     LimitRightBMax
        DC32     SpeedTargetValStraight
        DC32     SpeedBrick
        DC32     SpeedTargetValGryoUp
        DC32     SpeedTargetValGryoResult
        DC32     SpeedXiaoZhiDao
        THUMB
// 1302         //SpeedTargetValStraight = DebugModifyNum[52];
// 1303       }
// 1304       else if(DebugModifyCursor == 8)
??DebugModifyValue_119:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.N    ??DebugModifyValue_120
// 1305       {
// 1306         DebugModifyNum[53]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+106]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+106]
// 1307         ServoPIDDMat[0] = DebugModifyNum[53];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+106]
        LDR.W    R1,??DataTable5
        STRH     R0,[R1, #+0]
// 1308         ServoPIDD2Mat[0] = DebugModifyNum[53];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+106]
        LDR.W    R1,??DataTable5_1
        STRH     R0,[R1, #+0]
        B.N      ??DebugModifyValue_5
// 1309         //GyroResultForbidBackCountNum = DebugModifyNum[53];
// 1310       }
// 1311       else if(DebugModifyCursor == 9)
??DebugModifyValue_120:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+9
        BNE.N    ??DebugModifyValue_121
// 1312       {
// 1313         DebugModifyNum[54]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+108]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+108]
// 1314         ServoPIDDMat[1] = DebugModifyNum[54];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+108]
        LDR.N    R1,??DataTable5
        STRH     R0,[R1, #+2]
// 1315         ServoPIDD2Mat[1] = DebugModifyNum[54];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+108]
        LDR.N    R1,??DataTable5_1
        STRH     R0,[R1, #+2]
        B.N      ??DebugModifyValue_5
// 1316         //PathRealStraightCountLimit = DebugModifyNum[54];
// 1317       }
// 1318       else if(DebugModifyCursor == 10)
??DebugModifyValue_121:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??DebugModifyValue_122
// 1319       {
// 1320         DebugModifyNum[55]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+110]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+110]
// 1321         ServoPIDDMat[2] = DebugModifyNum[55];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+110]
        LDR.N    R1,??DataTable5
        STRH     R0,[R1, #+4]
// 1322         ServoPIDD2Mat[2] = DebugModifyNum[55];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+110]
        LDR.N    R1,??DataTable5_1
        STRH     R0,[R1, #+4]
        B.N      ??DebugModifyValue_5
// 1323         //StopFlagMaxCountNum = DebugModifyNum[55];
// 1324       }
// 1325       else if(DebugModifyCursor == 11)
??DebugModifyValue_122:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BNE.N    ??DebugModifyValue_123
// 1326       {
// 1327         DebugModifyNum[56]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+112]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+112]
// 1328         ServoPIDDMat[3] = DebugModifyNum[56];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+112]
        LDR.N    R1,??DataTable5
        STRH     R0,[R1, #+6]
// 1329         ServoPIDD2Mat[3] = DebugModifyNum[56];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+112]
        LDR.N    R1,??DataTable5_1
        STRH     R0,[R1, #+6]
        B.N      ??DebugModifyValue_5
// 1330         //LightHouseNoStopFlag = DebugModifyNum[56];
// 1331       }
// 1332       else if(DebugModifyCursor == 12)
??DebugModifyValue_123:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+12
        BNE.N    ??DebugModifyValue_124
// 1333       {
// 1334         DebugModifyNum[57]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+114]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+114]
// 1335         ServoPIDDMat[4] = DebugModifyNum[57];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+114]
        LDR.N    R1,??DataTable5
        STRH     R0,[R1, #+8]
// 1336         ServoPIDD2Mat[4] = DebugModifyNum[57];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+114]
        LDR.N    R1,??DataTable5_1
        STRH     R0,[R1, #+8]
        B.N      ??DebugModifyValue_5
// 1337         //AngleHeadLineNum = DebugModifyNum[57];
// 1338       }
// 1339       else if(DebugModifyCursor == 13)
??DebugModifyValue_124:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BNE.N    ??DebugModifyValue_125
// 1340       {
// 1341         DebugModifyNum[58]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+116]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+116]
// 1342         ServoPIDDMat[5] = DebugModifyNum[58];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+116]
        LDR.N    R1,??DataTable5
        STRH     R0,[R1, #+10]
// 1343         ServoPIDD2Mat[5] = DebugModifyNum[58];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+116]
        LDR.N    R1,??DataTable5_1
        STRH     R0,[R1, #+10]
        B.N      ??DebugModifyValue_5
// 1344         //SpeedTargetValWaitStop = DebugModifyNum[58];
// 1345       }
// 1346       else if(DebugModifyCursor == 14)
??DebugModifyValue_125:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BNE.N    ??DebugModifyValue_5
// 1347       {
// 1348         DebugModifyNum[59]++;
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+118]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_3
        STRH     R0,[R1, #+118]
// 1349         ServoPIDDMat[6] = DebugModifyNum[59];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+118]
        LDR.N    R1,??DataTable5
        STRH     R0,[R1, #+12]
// 1350         ServoPIDD2Mat[6] = DebugModifyNum[59];
        LDR.W    R0,??DataTable6_3
        LDRH     R0,[R0, #+118]
        LDR.N    R1,??DataTable5_1
        STRH     R0,[R1, #+12]
// 1351         //SpeedTargetValGryoUp = DebugModifyNum[59];
// 1352       }
// 1353       else
// 1354       {
// 1355       }      
// 1356       
// 1357     }
// 1358     else
// 1359     {
// 1360     }
// 1361   }
// 1362   
// 1363   return 1;
??DebugModifyValue_5:
        MOVS     R0,#+1
        BX       LR               ;; return
// 1364 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     limitStopLineBlackXiu
// 1365 
// 1366 
// 1367 //按键信息处理

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1368 uint8 DebugButtonDeal(void)
// 1369 {
DebugButtonDeal:
        PUSH     {R7,LR}
// 1370   //当前为显示界面。
// 1371   if(DebugScreenChosen == DebugScreenChosenDisplay)
        LDR.W    R0,??DataTable6_5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugButtonDeal_0
// 1372   {
// 1373     //1. 首先判断3号按键是否按下，3号按键表示切换显示/调参
// 1374     if(DebugButtonFlag[3] == 1)
        LDR.W    R0,??DataTable6_6
        LDRB     R0,[R0, #+3]
        CMP      R0,#+1
        BNE.N    ??DebugButtonDeal_1
// 1375     {
// 1376       //切换到调参界面。
// 1377       DebugScreenChosen = DebugScreenChosenModify;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_5
        STRB     R0,[R1, #+0]
// 1378       //清屏准备显示新内容。
// 1379       LCD_CLS();
        BL       LCD_CLS
// 1380       
// 1381       return 1;
        MOVS     R0,#+1
        B.N      ??DebugButtonDeal_2
// 1382     }
// 1383     else
// 1384     {
// 1385     }
// 1386     
// 1387     //2. 再判断2号按键是否按下，2号按键在显示界面下暂时没有定义////////////////
// 1388     if(DebugButtonFlag[2] == 1)
??DebugButtonDeal_1:
        LDR.W    R0,??DataTable6_6
        LDRB     R0,[R0, #+2]
        CMP      R0,#+1
        BNE.N    ??DebugButtonDeal_3
// 1389     {
// 1390       
// 1391       
// 1392       return 1;
        MOVS     R0,#+1
        B.N      ??DebugButtonDeal_2
// 1393     }
// 1394     else
// 1395     {
// 1396     }
// 1397     
// 1398     //3. 再判断1号按键是否按下，1号按键在显示界面下表示下一页。
// 1399     if(DebugButtonFlag[1] == 1)
??DebugButtonDeal_3:
        LDR.W    R0,??DataTable6_6
        LDRB     R0,[R0, #+1]
        CMP      R0,#+1
        BNE.N    ??DebugButtonDeal_4
// 1400     {
// 1401       //显示界面下的页数加1，到顶就回到0.取值范围为0~DebugDisplayPageNum - 1
// 1402       if(DebugDisplayPage >= DebugDisplayPageNum - 1)
        LDR.W    R0,??DataTable6_7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BLT.N    ??DebugButtonDeal_5
// 1403       {
// 1404         DebugDisplayPage = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_7
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonDeal_6
// 1405       }
// 1406       else
// 1407       {
// 1408         DebugDisplayPage++;
??DebugButtonDeal_5:
        LDR.W    R0,??DataTable6_7
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_7
        STRB     R0,[R1, #+0]
// 1409       }
// 1410       //清屏准备显示新内容。
// 1411       LCD_CLS();
??DebugButtonDeal_6:
        BL       LCD_CLS
// 1412       
// 1413       return 1;
        MOVS     R0,#+1
        B.N      ??DebugButtonDeal_2
// 1414     }
// 1415     else
// 1416     {      
// 1417     }    
// 1418     
// 1419     //4. 再判断0号按键是否按下，2号按键在显示界面下表示上一页。
// 1420     if(DebugButtonFlag[0] == 1)
??DebugButtonDeal_4:
        LDR.W    R0,??DataTable6_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.W    ??DebugButtonDeal_7
// 1421     {
// 1422       //显示界面下的页数减1，到底就回到顶.取值范围为0~DebugDisplayPageNum - 1   
// 1423       if(DebugDisplayPage == 0)
        LDR.W    R0,??DataTable6_7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugButtonDeal_8
// 1424       {
// 1425         DebugDisplayPage = DebugDisplayPageNum - 1;
        MOVS     R0,#+4
        LDR.W    R1,??DataTable6_7
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonDeal_9
// 1426       }
// 1427       else
// 1428       {
// 1429         DebugDisplayPage--;
??DebugButtonDeal_8:
        LDR.W    R0,??DataTable6_7
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DataTable6_7
        STRB     R0,[R1, #+0]
// 1430       }
// 1431       //清屏准备显示新内容。
// 1432       LCD_CLS();
??DebugButtonDeal_9:
        BL       LCD_CLS
// 1433       
// 1434       return 1;
        MOVS     R0,#+1
        B.N      ??DebugButtonDeal_2
// 1435     }
// 1436     else
// 1437     {
// 1438     }
// 1439     
// 1440   }
// 1441   //当前为调参界面。
// 1442   else
// 1443   {
// 1444     //1. 再判断3号按键是否按下，3号按键表示切换显示/调参。
// 1445     if(DebugButtonFlag[3] == 1)
??DebugButtonDeal_0:
        LDR.W    R0,??DataTable6_6
        LDRB     R0,[R0, #+3]
        CMP      R0,#+1
        BNE.N    ??DebugButtonDeal_10
// 1446     {
// 1447       //切换到显示界面。
// 1448       DebugScreenChosen = DebugScreenChosenDisplay;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable6_5
        STRB     R0,[R1, #+0]
// 1449       //清屏准备显示新内容。
// 1450       LCD_CLS();
        BL       LCD_CLS
// 1451       
// 1452       return 1;      
        MOVS     R0,#+1
        B.N      ??DebugButtonDeal_2
// 1453     }
// 1454     else
// 1455     {     
// 1456     }
// 1457 
// 1458     //2. 再判断2号按键是否按下，2号按键在调参界面下表示 确认/保存。
// 1459     if(DebugButtonFlag[2] == 1)
??DebugButtonDeal_10:
        LDR.W    R0,??DataTable6_6
        LDRB     R0,[R0, #+2]
        CMP      R0,#+1
        BNE.N    ??DebugButtonDeal_11
// 1460     {
// 1461       //之前修改标志为0，再按下2号键表示马上要进行修改。则屏幕上要出现更改标志。
// 1462       if(DebugModifyFlag == 0)
        LDR.W    R0,??DataTable6_8
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugButtonDeal_12
// 1463       {
// 1464         DebugModifyFlag = 1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable6_8
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonDeal_13
// 1465       }
// 1466       //之前修改标志为1，再按上2号键表示已经修改完成，需要保存并退出到上下移模式。更改标志消失。
// 1467       else
// 1468       {
// 1469         DebugModifyFlag = 0;
??DebugButtonDeal_12:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_8
        STRB     R0,[R1, #+0]
// 1470         ///////////////////////////////保存怎么保存？？？？
// 1471       }
// 1472       
// 1473       return 1;
??DebugButtonDeal_13:
        MOVS     R0,#+1
        B.N      ??DebugButtonDeal_2
// 1474     }
// 1475     else
// 1476     {
// 1477     }
// 1478     
// 1479     //3. 再判断1号按键是否按下，1号按键在调参界面下表示 光标下移/值减一个单位。
// 1480     if(DebugButtonFlag[1] == 1)
??DebugButtonDeal_11:
        LDR.W    R0,??DataTable6_6
        LDRB     R0,[R0, #+1]
        CMP      R0,#+1
        BNE.N    ??DebugButtonDeal_14
// 1481     {
// 1482       //之前修改标志为0，表示是上下移模式，按下1号键表示下移光标。
// 1483       if(DebugModifyFlag == 0)
        LDR.W    R0,??DataTable6_8
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugButtonDeal_15
// 1484       {
// 1485         //光标的取值范围为0~14
// 1486         if(DebugModifyCursor >= 14)
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BLT.N    ??DebugButtonDeal_16
// 1487         {
// 1488           //记录上一次的光标位置
// 1489           DebugModifyCursorPre = 14;
        MOVS     R0,#+14
        LDR.W    R1,??DataTable6_9
        STRB     R0,[R1, #+0]
// 1490           DebugModifyCursor = 0;         
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_2
        STRB     R0,[R1, #+0]
// 1491           //DebugModifyPage有0,1,2,3共4种取值。翻页就在这4页之间翻。
// 1492           if(DebugModifyPage == 0)
        LDR.W    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugButtonDeal_17
// 1493           {
// 1494             DebugModifyPage = 1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonDeal_18
// 1495           }
// 1496           else if(DebugModifyPage == 1)
??DebugButtonDeal_17:
        LDR.W    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugButtonDeal_19
// 1497           {
// 1498             DebugModifyPage = 2;
        MOVS     R0,#+2
        LDR.W    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonDeal_18
// 1499           }
// 1500           else if(DebugModifyPage == 2)
??DebugButtonDeal_19:
        LDR.W    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugButtonDeal_20
// 1501           {
// 1502             DebugModifyPage = 3;
        MOVS     R0,#+3
        LDR.W    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonDeal_18
// 1503           }
// 1504           else if(DebugModifyPage == 3)
??DebugButtonDeal_20:
        LDR.W    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugButtonDeal_18
// 1505           {
// 1506             DebugModifyPage = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
// 1507           }          
// 1508           else
// 1509           {
// 1510           }
// 1511           //清屏准备显示新内容。
// 1512           LCD_CLS();
??DebugButtonDeal_18:
        BL       LCD_CLS
        B.N      ??DebugButtonDeal_21
// 1513         }
// 1514         else
// 1515         {
// 1516           //记录上一次的光标位置
// 1517           DebugModifyCursorPre = DebugModifyCursor;
??DebugButtonDeal_16:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        LDR.W    R1,??DataTable6_9
        STRB     R0,[R1, #+0]
// 1518           DebugModifyCursor++;
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable6_2
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonDeal_21
// 1519           
// 1520         }
// 1521         
// 1522       }
// 1523       //之前修改标志为1，表示是加减值模式，按下1号键表示光标所在值要减一个单位。
// 1524       else
// 1525       {
// 1526         //0表示减1个单位。
// 1527         DebugModifyValue(0);
??DebugButtonDeal_15:
        MOVS     R0,#+0
        BL       DebugModifyValue
// 1528       }
// 1529       
// 1530       return 1;
??DebugButtonDeal_21:
        MOVS     R0,#+1
        B.N      ??DebugButtonDeal_2
// 1531     }
// 1532     else
// 1533     {     
// 1534     }
// 1535 
// 1536     //4. 再判断0号按键是否按下，0号按键在调参界面下表示 光标上移/值加一个单位。
// 1537     if(DebugButtonFlag[0] == 1)
??DebugButtonDeal_14:
        LDR.W    R0,??DataTable6_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugButtonDeal_7
// 1538     {
// 1539       //之前修改标志为0，表示是上下移模式，按下0号键表示上移光标。
// 1540       if(DebugModifyFlag == 0)
        LDR.W    R0,??DataTable6_8
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugButtonDeal_22
// 1541       {
// 1542         //光标的取值范围为0~14
// 1543         if(DebugModifyCursor == 0)
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugButtonDeal_23
// 1544         {
// 1545           //记录上一次的光标位置。
// 1546           DebugModifyCursorPre = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_9
        STRB     R0,[R1, #+0]
// 1547           DebugModifyCursor = 14;
        MOVS     R0,#+14
        LDR.W    R1,??DataTable6_2
        STRB     R0,[R1, #+0]
// 1548           //DebugModifyPage有0, 1, 2, 3共4种取值。翻页就在这4页之间翻。
// 1549           if(DebugModifyPage == 0)
        LDR.W    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugButtonDeal_24
// 1550           {
// 1551             DebugModifyPage = 3;
        MOVS     R0,#+3
        LDR.W    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonDeal_25
// 1552           }
// 1553           else if(DebugModifyPage == 1)
??DebugButtonDeal_24:
        LDR.W    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugButtonDeal_26
// 1554           {
// 1555             DebugModifyPage = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonDeal_25
// 1556           }
// 1557           else if(DebugModifyPage == 2)
??DebugButtonDeal_26:
        LDR.W    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugButtonDeal_27
// 1558           {
// 1559             DebugModifyPage = 1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonDeal_25
// 1560           }
// 1561           else if(DebugModifyPage == 3)
??DebugButtonDeal_27:
        LDR.W    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugButtonDeal_25
// 1562           {
// 1563             DebugModifyPage = 2;
        MOVS     R0,#+2
        LDR.W    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
// 1564           }          
// 1565           else
// 1566           {
// 1567           }
// 1568           //清屏准备显示新内容。
// 1569           LCD_CLS();   
??DebugButtonDeal_25:
        BL       LCD_CLS
        B.N      ??DebugButtonDeal_28
// 1570         }
// 1571         else
// 1572         {
// 1573           //记录上一次的光标位置。
// 1574           DebugModifyCursorPre = DebugModifyCursor;
??DebugButtonDeal_23:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        LDR.W    R1,??DataTable6_9
        STRB     R0,[R1, #+0]
// 1575           DebugModifyCursor--;
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DataTable6_2
        STRB     R0,[R1, #+0]
        B.N      ??DebugButtonDeal_28
// 1576         }
// 1577      
// 1578       }
// 1579       //之前修改标志为1，表示是加减值模式，按下0号键表示光标所在值要加一个单位。
// 1580       else
// 1581       {
// 1582         //1表示加1个单位。
// 1583         DebugModifyValue(1);
??DebugButtonDeal_22:
        MOVS     R0,#+1
        BL       DebugModifyValue
// 1584       }
// 1585       
// 1586       return 1;
??DebugButtonDeal_28:
        MOVS     R0,#+1
        B.N      ??DebugButtonDeal_2
// 1587     }
// 1588     else
// 1589     {      
// 1590     }
// 1591     
// 1592   }
// 1593   
// 1594   return 1;
??DebugButtonDeal_7:
        MOVS     R0,#+1
??DebugButtonDeal_2:
        POP      {R1,PC}          ;; return
// 1595 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     ServoPIDDMat

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     ServoPIDD2Mat
// 1596 
// 1597 //光标位置标注
// 1598 //num为光标位置0~14

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1599 uint8 DebugModifyCursorMark(void)
// 1600 {    
DebugModifyCursorMark:
        PUSH     {R7,LR}
// 1601   
// 1602   if(DebugModifyCursor == 0)
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugModifyCursorMark_0
// 1603   {
// 1604     LCD_P6x8Str(0, 1, "#");
        ADR.N    R2,??DebugModifyCursorMark_1  ;; "#"
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1605     if(DebugModifyCursorPre == 1)
        LDR.W    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugModifyCursorMark_2
// 1606     {
// 1607       LCD_P6x8Str(0, 2, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+2
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1608     }
// 1609     else if(DebugModifyCursorPre == 14)
??DebugModifyCursorMark_2:
        LDR.W    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BNE.W    ??DebugModifyCursorMark_3
// 1610     {
// 1611       LCD_P6x8Str(64, 7, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+7
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1612     }
// 1613     else
// 1614     {     
// 1615     }
// 1616   }
// 1617   else if(DebugModifyCursor == 1)
??DebugModifyCursorMark_0:
        LDR.W    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugModifyCursorMark_4
// 1618   {
// 1619     LCD_P6x8Str(0, 2, "#");
        ADR.N    R2,??DebugModifyCursorMark_1  ;; "#"
        MOVS     R1,#+2
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1620     if(DebugModifyCursorPre == 2)
        LDR.W    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugModifyCursorMark_5
// 1621     {
// 1622       LCD_P6x8Str(0, 3, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+3
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1623     }
// 1624     else if(DebugModifyCursorPre == 0)
??DebugModifyCursorMark_5:
        LDR.W    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??DebugModifyCursorMark_3
// 1625     {
// 1626       LCD_P6x8Str(0, 1, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1627     }
// 1628     else
// 1629     {     
// 1630     }
// 1631   }
// 1632   else if(DebugModifyCursor == 2)
??DebugModifyCursorMark_4:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??DebugModifyCursorMark_6
// 1633   {
// 1634     LCD_P6x8Str(0, 3, "#");
        ADR.N    R2,??DebugModifyCursorMark_1  ;; "#"
        MOVS     R1,#+3
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1635     if(DebugModifyCursorPre == 3)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugModifyCursorMark_7
// 1636     {
// 1637       LCD_P6x8Str(0, 4, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+4
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1638     }
// 1639     else if(DebugModifyCursorPre == 1)
??DebugModifyCursorMark_7:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.W    ??DebugModifyCursorMark_3
// 1640     {
// 1641       LCD_P6x8Str(0, 2, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+2
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1642     }
// 1643     else
// 1644     {     
// 1645     }
// 1646   }  
// 1647   else if(DebugModifyCursor == 3)
??DebugModifyCursorMark_6:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??DebugModifyCursorMark_8
// 1648   {
// 1649     LCD_P6x8Str(0, 4, "#");
        ADR.N    R2,??DebugModifyCursorMark_1  ;; "#"
        MOVS     R1,#+4
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1650     if(DebugModifyCursorPre == 4)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??DebugModifyCursorMark_9
// 1651     {
// 1652       LCD_P6x8Str(0, 5, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+5
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1653     }
// 1654     else if(DebugModifyCursorPre == 2)
??DebugModifyCursorMark_9:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.W    ??DebugModifyCursorMark_3
// 1655     {
// 1656       LCD_P6x8Str(0, 3, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+3
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1657     }
// 1658     else
// 1659     {     
// 1660     }
// 1661   }  
// 1662   else if(DebugModifyCursor == 4)
??DebugModifyCursorMark_8:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.N    ??DebugModifyCursorMark_10
// 1663   {
// 1664     LCD_P6x8Str(0, 5, "#");
        ADR.N    R2,??DebugModifyCursorMark_1  ;; "#"
        MOVS     R1,#+5
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1665     if(DebugModifyCursorPre == 5)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??DebugModifyCursorMark_11
// 1666     {
// 1667       LCD_P6x8Str(0, 6, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+6
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1668     }
// 1669     else if(DebugModifyCursorPre == 3)
??DebugModifyCursorMark_11:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.W    ??DebugModifyCursorMark_3
// 1670     {
// 1671       LCD_P6x8Str(0, 4, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+4
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1672     }
// 1673     else
// 1674     {     
// 1675     }
// 1676   } 
// 1677   else if(DebugModifyCursor == 5)
??DebugModifyCursorMark_10:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??DebugModifyCursorMark_12
// 1678   {
// 1679     LCD_P6x8Str(0, 6, "#");
        ADR.N    R2,??DebugModifyCursorMark_1  ;; "#"
        MOVS     R1,#+6
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1680     if(DebugModifyCursorPre == 6)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??DebugModifyCursorMark_13
// 1681     {
// 1682       LCD_P6x8Str(0, 7, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+7
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1683     }
// 1684     else if(DebugModifyCursorPre == 4)
??DebugModifyCursorMark_13:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.W    ??DebugModifyCursorMark_3
// 1685     {
// 1686       LCD_P6x8Str(0, 5, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+5
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1687     }
// 1688     else
// 1689     {     
// 1690     }
// 1691   }  
// 1692   else if(DebugModifyCursor == 6)
??DebugModifyCursorMark_12:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.N    ??DebugModifyCursorMark_14
// 1693   {
// 1694     LCD_P6x8Str(0, 7, "#");
        ADR.N    R2,??DebugModifyCursorMark_1  ;; "#"
        MOVS     R1,#+7
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1695     if(DebugModifyCursorPre == 7)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.N    ??DebugModifyCursorMark_15
// 1696     {
// 1697       LCD_P6x8Str(64, 0, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1698     }
// 1699     else if(DebugModifyCursorPre == 5)
??DebugModifyCursorMark_15:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.W    ??DebugModifyCursorMark_3
// 1700     {
// 1701       LCD_P6x8Str(0, 6, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+6
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1702     }
// 1703     else
// 1704     {     
// 1705     }
// 1706   }
// 1707   else if(DebugModifyCursor == 7)
??DebugModifyCursorMark_14:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.N    ??DebugModifyCursorMark_16
// 1708   {
// 1709     LCD_P6x8Str(64, 0, "#");
        ADR.N    R2,??DebugModifyCursorMark_1  ;; "#"
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1710     if(DebugModifyCursorPre == 8)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.N    ??DebugModifyCursorMark_17
// 1711     {
// 1712       LCD_P6x8Str(64, 1, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1713     }
// 1714     else if(DebugModifyCursorPre == 6)
??DebugModifyCursorMark_17:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BNE.W    ??DebugModifyCursorMark_3
// 1715     {
// 1716       LCD_P6x8Str(0, 7, " ");
        ADR.N    R2,??DebugModifyCursorMark_1+0x4  ;; " "
        MOVS     R1,#+7
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
        Nop      
        DATA
??DebugModifyCursorMark_1:
        DC8      "#",0x0,0x0
        DC8      " ",0x0,0x0
        THUMB
// 1717     }
// 1718     else
// 1719     {     
// 1720     }
// 1721   }
// 1722   else if(DebugModifyCursor == 8)
??DebugModifyCursorMark_16:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.N    ??DebugModifyCursorMark_18
// 1723   {
// 1724     LCD_P6x8Str(64, 1, "#");
        ADR.N    R2,??DataTable6  ;; "#"
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1725     if(DebugModifyCursorPre == 9)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+9
        BNE.N    ??DebugModifyCursorMark_19
// 1726     {
// 1727       LCD_P6x8Str(64, 2, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+2
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1728     }
// 1729     else if(DebugModifyCursorPre == 7)
??DebugModifyCursorMark_19:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+7
        BNE.W    ??DebugModifyCursorMark_3
// 1730     {
// 1731       LCD_P6x8Str(64, 0, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1732     }
// 1733     else
// 1734     {     
// 1735     }
// 1736   }
// 1737   else if(DebugModifyCursor == 9)
??DebugModifyCursorMark_18:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+9
        BNE.N    ??DebugModifyCursorMark_20
// 1738   {
// 1739     LCD_P6x8Str(64, 2, "#");
        ADR.N    R2,??DataTable6  ;; "#"
        MOVS     R1,#+2
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1740     if(DebugModifyCursorPre == 10)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??DebugModifyCursorMark_21
// 1741     {
// 1742       LCD_P6x8Str(64, 3, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+3
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1743     }
// 1744     else if(DebugModifyCursorPre == 8)
??DebugModifyCursorMark_21:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+8
        BNE.W    ??DebugModifyCursorMark_3
// 1745     {
// 1746       LCD_P6x8Str(64, 1, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1747     }
// 1748     else
// 1749     {     
// 1750     }
// 1751   }
// 1752   else if(DebugModifyCursor == 10)
??DebugModifyCursorMark_20:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??DebugModifyCursorMark_22
// 1753   {
// 1754     LCD_P6x8Str(64, 3, "#");
        ADR.N    R2,??DataTable6  ;; "#"
        MOVS     R1,#+3
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1755     if(DebugModifyCursorPre == 11)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BNE.N    ??DebugModifyCursorMark_23
// 1756     {
// 1757       LCD_P6x8Str(64, 4, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+4
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1758     }
// 1759     else if(DebugModifyCursorPre == 9)
??DebugModifyCursorMark_23:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+9
        BNE.N    ??DebugModifyCursorMark_3
// 1760     {
// 1761       LCD_P6x8Str(64, 2, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+2
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1762     }
// 1763     else
// 1764     {     
// 1765     }
// 1766   }
// 1767   else if(DebugModifyCursor == 11)
??DebugModifyCursorMark_22:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BNE.N    ??DebugModifyCursorMark_24
// 1768   {
// 1769     LCD_P6x8Str(64, 4, "#");
        ADR.N    R2,??DataTable6  ;; "#"
        MOVS     R1,#+4
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1770     if(DebugModifyCursorPre == 12)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+12
        BNE.N    ??DebugModifyCursorMark_25
// 1771     {
// 1772       LCD_P6x8Str(64, 5, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+5
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1773     }
// 1774     else if(DebugModifyCursorPre == 10)
??DebugModifyCursorMark_25:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+10
        BNE.N    ??DebugModifyCursorMark_3
// 1775     {
// 1776       LCD_P6x8Str(64, 3, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+3
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1777     }
// 1778     else
// 1779     {     
// 1780     }
// 1781   }
// 1782   else if(DebugModifyCursor == 12)
??DebugModifyCursorMark_24:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+12
        BNE.N    ??DebugModifyCursorMark_26
// 1783   {
// 1784     LCD_P6x8Str(64, 5, "#");
        ADR.N    R2,??DataTable6  ;; "#"
        MOVS     R1,#+5
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1785     if(DebugModifyCursorPre == 13)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BNE.N    ??DebugModifyCursorMark_27
// 1786     {
// 1787       LCD_P6x8Str(64, 6, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+6
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1788     }
// 1789     else if(DebugModifyCursorPre == 11)
??DebugModifyCursorMark_27:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+11
        BNE.N    ??DebugModifyCursorMark_3
// 1790     {
// 1791       LCD_P6x8Str(64, 4, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+4
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1792     }
// 1793     else
// 1794     {     
// 1795     }
// 1796   }
// 1797   else if(DebugModifyCursor == 13)
??DebugModifyCursorMark_26:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BNE.N    ??DebugModifyCursorMark_28
// 1798   {
// 1799     LCD_P6x8Str(64, 6, "#");
        ADR.N    R2,??DataTable6  ;; "#"
        MOVS     R1,#+6
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1800     if(DebugModifyCursorPre == 14)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BNE.N    ??DebugModifyCursorMark_29
// 1801     {
// 1802       LCD_P6x8Str(64, 7, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+7
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1803     }
// 1804     else if(DebugModifyCursorPre == 12)
??DebugModifyCursorMark_29:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+12
        BNE.N    ??DebugModifyCursorMark_3
// 1805     {
// 1806       LCD_P6x8Str(64, 5, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+5
        MOVS     R0,#+64
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1807     }
// 1808     else
// 1809     {     
// 1810     }
// 1811   }
// 1812   else if(DebugModifyCursor == 14)
??DebugModifyCursorMark_28:
        LDR.N    R0,??DataTable6_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+14
        BNE.N    ??DebugModifyCursorMark_3
// 1813   {
// 1814     LCD_P6x8Str(64, 7, "#");
        ADR.N    R2,??DataTable6  ;; "#"
        MOVS     R1,#+7
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1815     if(DebugModifyCursorPre == 0)
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??DebugModifyCursorMark_30
// 1816     {
// 1817       LCD_P6x8Str(0, 1, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       LCD_P6x8Str
        B.N      ??DebugModifyCursorMark_3
// 1818     }
// 1819     else if(DebugModifyCursorPre == 13)
??DebugModifyCursorMark_30:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+13
        BNE.N    ??DebugModifyCursorMark_3
// 1820     {
// 1821       LCD_P6x8Str(64, 6, " ");
        ADR.N    R2,??DataTable6_1  ;; " "
        MOVS     R1,#+6
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1822     }
// 1823     else
// 1824     {     
// 1825     }
// 1826   }
// 1827   else
// 1828   {
// 1829   }
// 1830   
// 1831   return 1;
??DebugModifyCursorMark_3:
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
// 1832 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC8      "#",0x0,0x0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC8      " ",0x0,0x0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     DebugModifyCursor

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     DebugModifyNum

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_4:
        DC32     DebugModifyPage

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_5:
        DC32     DebugScreenChosen

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_6:
        DC32     DebugButtonFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_7:
        DC32     DebugDisplayPage

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_8:
        DC32     DebugModifyFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_9:
        DC32     DebugModifyCursorPre
// 1833 
// 1834 
// 1835 //OLED屏显示信息刷新。

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1836 uint8 DebugOLEDUpdate(void)
// 1837 {
DebugOLEDUpdate:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+1808
// 1838   uint32 temp;
// 1839   uint8 i;
// 1840     
// 1841   //当前为显示界面。
// 1842   if(DebugScreenChosen == DebugScreenChosenDisplay)
        LDR.W    R0,??DebugOLEDUpdate_0
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.W    ??DebugOLEDUpdate_1
// 1843   {
// 1844     //第0页，用来显示调节舵机P值所需要的一些参数。
// 1845     //序号+英文名+正负号+数值（没有光标和更改标志）
// 1846     //0. DF = DeviFuse                   现偏差。            3位数，有正负。
// 1847     //1. DD = DeviNow - DeviPre;         偏差变化率。        3位数，有正负。
// 1848     //2. DL = DeviNowLevel               偏差等级。          1位数，无正负。
// 1849     //3. DR = DeviRowChosen              偏差选取行。        2位数，无正负。
// 1850     //4. SP = ServoPIDPMat[DeviNowLevel] 舵机P值。           3位数，无正负。
// 1851     //5. SD = ServoPIDDMat[DeviNowLevel] 舵机D值。           3位数，无正负。
// 1852     //6. SV = ServoPIDInputVal-ServoPIDCen       舵机实际值。        3位数，有正负。
// 1853     if(DebugDisplayPage == 0)
        LDR.W    R0,??DebugOLEDUpdate_0+0x4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??DebugOLEDUpdate_2
// 1854     {
// 1855       //显示界面第0页用的，第1个表示符号，中间3个表示值，最后1个表示字符串末尾。
// 1856       uint8 DF00[5] = {0, 0, 0, 0, 0};   //偏差DevuFuse
        ADD      R0,SP,#+12
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1857       uint8 DD01[5] = {0, 0, 0, 0, 0};   //偏差变化率DevuFuse-DeviPre
        ADD      R0,SP,#+4
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1858       uint8 DL02[5] = {0, 0, 0, 0, 0};   //偏差等级DeviNowLevel
        ADD      R0,SP,#+108
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1859       uint8 DR03[5] = {0, 0, 0, 0, 0};   //偏差选取行DeviRowChosen
        ADD      R0,SP,#+100
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1860       uint8 SP04[5] = {0, 0, 0, 0, 0};   //舵机P值ServoPIDPMat[DeviNowLevel]
        ADD      R0,SP,#+92
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1861       uint8 SD05[5] = {0, 0, 0, 0, 0};   //舵机D值ServoPIDDMat[DeviNowLevel]
        ADD      R0,SP,#+84
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1862       uint8 SV06[5] = {0, 0, 0, 0, 0};   //舵机实际值FTM1_C0V-ServoPIDCen
        ADD      R0,SP,#+76
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1863       uint8 QL07[5] = {0, 0, 0, 0, 0};   //左编码器返回值QuadLeftCount
        ADD      R0,SP,#+68
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1864       uint8 QR08[5] = {0, 0, 0, 0, 0};   //右编码器返回值QuadRightCount
        ADD      R0,SP,#+60
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1865       uint8 LS09[5] = {0, 0, 0, 0, 0};   //左线扫描起点BlackLeftLastEdgeStartCol
        ADD      R0,SP,#+52
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1866       uint8 RS10[5] = {0, 0, 0, 0, 0};   //右线扫描起点BlackRighttLastEdgeStartCol
        ADD      R0,SP,#+44
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1867       uint8 CS11[5] = {0, 0, 0, 0, 0};   //扫描起点定位点BlackCenEdgeStartCol
        ADD      R0,SP,#+36
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1868       uint8 LH12[5] = {0, 0, 0, 0, 0};   //左线头BlackLeftHeadLine
        ADD      R0,SP,#+28
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1869       uint8 RH13[5] = {0, 0, 0, 0, 0};   //右线头BlackRightHeadLine
        ADD      R0,SP,#+20
        MOVS     R1,#+0
        MOVS     R2,#+0
        STM      R0!,{R1,R2}
        SUBS     R0,R0,#+8
// 1870 
// 1871       //第0个显示值。
// 1872       if(DeviFuse < 0)
        LDR.W    R0,??DebugOLEDUpdate_3
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BPL.N    ??DebugOLEDUpdate_4
// 1873       {
// 1874         DF00[0] = 45;      //45代表-
        MOVS     R0,#+45
        STRB     R0,[SP, #+12]
// 1875         temp = 0 - DeviFuse;
        LDR.W    R0,??DebugOLEDUpdate_3
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
        B.N      ??DebugOLEDUpdate_5
// 1876       }
// 1877       else
// 1878       {
// 1879         DF00[0] = 32;   //32代表空格
??DebugOLEDUpdate_4:
        MOVS     R0,#+32
        STRB     R0,[SP, #+12]
// 1880         temp = DeviFuse;
        LDR.W    R0,??DebugOLEDUpdate_3
        LDR      R0,[R0, #+0]
// 1881       }
// 1882       DF00[1] = temp / 100 + 48;           //48代表0
??DebugOLEDUpdate_5:
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+13]
// 1883       DF00[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+14]
// 1884       DF00[3] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+15]
// 1885       //第1个显示值。
// 1886       if(DeviFuse - DeviPre < 0)
        LDR.W    R0,??DebugOLEDUpdate_3
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DebugOLEDUpdate_3+0x4
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        CMP      R0,#+0
        BPL.N    ??DebugOLEDUpdate_6
// 1887       {
// 1888         DD01[0] = 45;
        MOVS     R0,#+45
        STRB     R0,[SP, #+4]
// 1889         temp = DeviPre - DeviFuse;
        LDR.W    R0,??DebugOLEDUpdate_3+0x4
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DebugOLEDUpdate_3
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        B.N      ??DebugOLEDUpdate_7
// 1890       }
// 1891       else
// 1892       {
// 1893         DD01[0] = 32;
??DebugOLEDUpdate_6:
        MOVS     R0,#+32
        STRB     R0,[SP, #+4]
// 1894         temp = DeviFuse - DeviPre;        
        LDR.W    R0,??DebugOLEDUpdate_3
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DebugOLEDUpdate_3+0x4
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
// 1895       }
// 1896       DD01[1] = temp / 100 + 48;
??DebugOLEDUpdate_7:
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+5]
// 1897       DD01[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+6]
// 1898       DD01[3] = (temp % 10) / 1 + 48;      
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+7]
// 1899       //第2个显示值。
// 1900       temp = BatteryCheckVal;
        LDR.W    R0,??DebugOLEDUpdate_3+0x8
        LDRH     R0,[R0, #+0]
// 1901       DL02[0] = 32;
        MOVS     R1,#+32
        STRB     R1,[SP, #+108]
// 1902       DL02[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+109]
// 1903       DL02[2] = (temp % 100) / 10 + 48;            
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+110]
// 1904       DL02[3] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+111]
// 1905       //第3个显示值。
// 1906       temp = Steer_kp[2];
        LDR.W    R0,??DebugOLEDUpdate_3+0xC
        LDRH     R0,[R0, #+4]
// 1907       DR03[0] = 32;
        MOVS     R1,#+32
        STRB     R1,[SP, #+100]
// 1908       DR03[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+101]
// 1909       DR03[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+102]
// 1910       DR03[3] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+103]
// 1911       //第4个显示值。
// 1912       temp = Steer_kp[3];
        LDR.W    R0,??DebugOLEDUpdate_3+0xC
        LDRH     R0,[R0, #+6]
// 1913       SP04[0] = 32;
        MOVS     R1,#+32
        STRB     R1,[SP, #+92]
// 1914       SP04[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+93]
// 1915       SP04[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+94]
// 1916       SP04[3] = (temp % 10) / 1 + 48;        
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+95]
// 1917       //第5个显示值。
// 1918       temp = Steer_kp[4];
        LDR.W    R0,??DebugOLEDUpdate_3+0xC
        LDRH     R0,[R0, #+8]
// 1919       SD05[0] = 32;
        MOVS     R1,#+32
        STRB     R1,[SP, #+84]
// 1920       SD05[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+85]
// 1921       SD05[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+86]
// 1922       SD05[3] = (temp % 10) / 1 + 48;        
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+87]
// 1923       //第6个显示值。
// 1924       temp = Steer_kp[5];
        LDR.W    R0,??DebugOLEDUpdate_3+0xC
        LDRH     R0,[R0, #+10]
// 1925       SV06[0] = 32;
        MOVS     R1,#+32
        STRB     R1,[SP, #+76]
// 1926       SV06[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+77]
// 1927       SV06[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+78]
// 1928       SV06[3] = (temp % 10) / 1 + 48;         
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+79]
// 1929       //第7个显示值。
// 1930       temp = Steer_kp[6];
        LDR.W    R0,??DebugOLEDUpdate_3+0xC
        LDRH     R0,[R0, #+12]
// 1931       QL07[0] = 32;  //空格
        MOVS     R1,#+32
        STRB     R1,[SP, #+68]
// 1932       QL07[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+69]
// 1933       QL07[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+70]
// 1934       QL07[3] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+71]
// 1935       //第8个显示值。
// 1936       temp = Steer_kp[7];
        LDR.W    R0,??DebugOLEDUpdate_3+0xC
        LDRH     R0,[R0, #+14]
// 1937       QR08[0] = 32;  //空格
        MOVS     R1,#+32
        STRB     R1,[SP, #+60]
// 1938       QR08[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+61]
// 1939       QR08[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+62]
// 1940       QR08[3] = (temp % 10) / 1 + 48;   
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+63]
// 1941       //第9显示值。
// 1942       temp = BlackLeftEdgeStartCol;
        LDR.W    R0,??DebugOLEDUpdate_3+0x20
        LDRB     R0,[R0, #+0]
// 1943       LS09[0] = 32;  //空格
        MOVS     R1,#+32
        STRB     R1,[SP, #+52]
// 1944       LS09[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+53]
// 1945       LS09[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+54]
// 1946       LS09[3] = (temp % 10) / 1 + 48;  
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+55]
// 1947       //第10个显示值。
// 1948       temp = BlackRightEdgeStartCol;
        LDR.W    R0,??DebugOLEDUpdate_3+0x24
        LDRB     R0,[R0, #+0]
// 1949       RS10[0] = 32;  //空格
        MOVS     R1,#+32
        STRB     R1,[SP, #+44]
// 1950       RS10[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+45]
// 1951       RS10[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+46]
// 1952       RS10[3] = (temp % 10) / 1 + 48;  
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+47]
// 1953       //第11个显示值。
// 1954       temp = BlackCenEdgeStartCol;
        LDR.W    R0,??DebugOLEDUpdate_3+0x28
        LDRB     R0,[R0, #+0]
// 1955       CS11[0] = 32;  //空格
        MOVS     R1,#+32
        STRB     R1,[SP, #+36]
// 1956       CS11[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+37]
// 1957       CS11[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+38]
// 1958       CS11[3] = (temp % 10) / 1 + 48;  
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+39]
// 1959       //第10个显示值。
// 1960       temp = BlackLeftHeadLine;
        LDR.W    R0,??DebugOLEDUpdate_8
        LDRB     R0,[R0, #+0]
// 1961       LH12[0] = 32;  //空格
        MOVS     R1,#+32
        STRB     R1,[SP, #+28]
// 1962       LH12[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+29]
// 1963       LH12[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+30]
// 1964       LH12[3] = (temp % 10) / 1 + 48;  
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+31]
// 1965       //第11个显示值。
// 1966       temp = BlackRightHeadLine;
        LDR.W    R0,??DebugOLEDUpdate_8+0x4
        LDRB     R0,[R0, #+0]
// 1967       RH13[0] = 32;  //空格
        MOVS     R1,#+32
        STRB     R1,[SP, #+20]
// 1968       RH13[1] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+21]
// 1969       RH13[2] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        STRB     R1,[SP, #+22]
// 1970       RH13[3] = (temp % 10) / 1 + 48;        
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+23]
// 1971       //列，行，字符串。
// 1972       LCD_P6x8Str(55, 0, "D_0"); 
        ADR.N    R2,??DebugOLEDUpdate_9  ;; "D_0"
        MOVS     R1,#+0
        MOVS     R0,#+55
        BL       LCD_P6x8Str
// 1973  
// 1974       LCD_P6x8Str(0, 1, "DF");
        ADR.N    R2,??DebugOLEDUpdate_9+0x4  ;; 0x44, 0x46, 0x00, 0x00
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1975       LCD_P6x8Str(0, 2, "DD");
        ADR.N    R2,??DebugOLEDUpdate_9+0x8  ;; 0x44, 0x44, 0x00, 0x00
        MOVS     R1,#+2
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1976       LCD_P6x8Str(0, 3, "P1");
        ADR.N    R2,??DebugOLEDUpdate_9+0xC  ;; 0x50, 0x31, 0x00, 0x00
        MOVS     R1,#+3
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1977       LCD_P6x8Str(0, 4, "P2");
        ADR.N    R2,??DebugOLEDUpdate_9+0x10  ;; 0x50, 0x32, 0x00, 0x00
        MOVS     R1,#+4
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1978       LCD_P6x8Str(0, 5, "P3");
        ADR.N    R2,??DebugOLEDUpdate_9+0x14  ;; 0x50, 0x33, 0x00, 0x00
        MOVS     R1,#+5
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1979       LCD_P6x8Str(0, 6, "P4");
        ADR.N    R2,??DebugOLEDUpdate_9+0x18  ;; 0x50, 0x34, 0x00, 0x00
        MOVS     R1,#+6
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1980       LCD_P6x8Str(0, 7, "P5");
        ADR.N    R2,??DebugOLEDUpdate_9+0x1C  ;; 0x50, 0x35, 0x00, 0x00
        MOVS     R1,#+7
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 1981       
// 1982       LCD_P6x8Str(18, 1, DF00);
        ADD      R2,SP,#+12
        MOVS     R1,#+1
        MOVS     R0,#+18
        BL       LCD_P6x8Str
// 1983       LCD_P6x8Str(18, 2, DD01);
        ADD      R2,SP,#+4
        MOVS     R1,#+2
        MOVS     R0,#+18
        BL       LCD_P6x8Str
// 1984       LCD_P6x8Str(18, 3, DL02);
        ADD      R2,SP,#+108
        MOVS     R1,#+3
        MOVS     R0,#+18
        BL       LCD_P6x8Str
// 1985       LCD_P6x8Str(18, 4, DR03);
        ADD      R2,SP,#+100
        MOVS     R1,#+4
        MOVS     R0,#+18
        BL       LCD_P6x8Str
// 1986       LCD_P6x8Str(18, 5, SP04);
        ADD      R2,SP,#+92
        MOVS     R1,#+5
        MOVS     R0,#+18
        BL       LCD_P6x8Str
// 1987       LCD_P6x8Str(18, 6, SD05);
        ADD      R2,SP,#+84
        MOVS     R1,#+6
        MOVS     R0,#+18
        BL       LCD_P6x8Str
// 1988       LCD_P6x8Str(18, 7, SV06);
        ADD      R2,SP,#+76
        MOVS     R1,#+7
        MOVS     R0,#+18
        BL       LCD_P6x8Str
// 1989       
// 1990       LCD_P6x8Str(64, 1, "P6");
        ADR.N    R2,??DebugOLEDUpdate_9+0x20  ;; 0x50, 0x36, 0x00, 0x00
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1991       LCD_P6x8Str(64, 2, "P7");
        ADR.N    R2,??DebugOLEDUpdate_9+0x24  ;; 0x50, 0x37, 0x00, 0x00
        MOVS     R1,#+2
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1992       LCD_P6x8Str(64, 3, "LS");
        ADR.N    R2,??DebugOLEDUpdate_9+0x28  ;; 0x4C, 0x53, 0x00, 0x00
        MOVS     R1,#+3
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1993       LCD_P6x8Str(64, 4, "RS");
        ADR.N    R2,??DebugOLEDUpdate_9+0x2C  ;; 0x52, 0x53, 0x00, 0x00
        MOVS     R1,#+4
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1994       LCD_P6x8Str(64, 5, "CS");
        ADR.N    R2,??DebugOLEDUpdate_9+0x30  ;; 0x43, 0x53, 0x00, 0x00
        MOVS     R1,#+5
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1995       LCD_P6x8Str(64, 6, "LH");
        ADR.N    R2,??DebugOLEDUpdate_9+0x34  ;; 0x4C, 0x48, 0x00, 0x00
        MOVS     R1,#+6
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1996       LCD_P6x8Str(64, 7, "RH"); 
        ADR.N    R2,??DebugOLEDUpdate_9+0x38  ;; 0x52, 0x48, 0x00, 0x00
        MOVS     R1,#+7
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 1997       
// 1998       LCD_P6x8Str(64+18, 1, QL07);
        ADD      R2,SP,#+68
        MOVS     R1,#+1
        MOVS     R0,#+82
        BL       LCD_P6x8Str
// 1999       LCD_P6x8Str(64+18, 2, QR08);
        ADD      R2,SP,#+60
        MOVS     R1,#+2
        MOVS     R0,#+82
        BL       LCD_P6x8Str
// 2000       LCD_P6x8Str(64+18, 3, LS09);
        ADD      R2,SP,#+52
        MOVS     R1,#+3
        MOVS     R0,#+82
        BL       LCD_P6x8Str
// 2001       LCD_P6x8Str(64+18, 4, RS10);
        ADD      R2,SP,#+44
        MOVS     R1,#+4
        MOVS     R0,#+82
        BL       LCD_P6x8Str
// 2002       LCD_P6x8Str(64+18, 5, CS11);
        ADD      R2,SP,#+36
        MOVS     R1,#+5
        MOVS     R0,#+82
        BL       LCD_P6x8Str
// 2003       LCD_P6x8Str(64+18, 6, LH12);
        ADD      R2,SP,#+28
        MOVS     R1,#+6
        MOVS     R0,#+82
        BL       LCD_P6x8Str
// 2004       LCD_P6x8Str(64+18, 7, RH13);
        ADD      R2,SP,#+20
        MOVS     R1,#+7
        MOVS     R0,#+82
        BL       LCD_P6x8Str
        B.W      ??DebugOLEDUpdate_10
        Nop      
        DATA
??DebugOLEDUpdate_9:
        DC8      "D_0"
        DC8      0x44, 0x46, 0x00, 0x00
        DC8      0x44, 0x44, 0x00, 0x00
        DC8      0x50, 0x31, 0x00, 0x00
        DC8      0x50, 0x32, 0x00, 0x00
        DC8      0x50, 0x33, 0x00, 0x00
        DC8      0x50, 0x34, 0x00, 0x00
        DC8      0x50, 0x35, 0x00, 0x00
        DC8      0x50, 0x36, 0x00, 0x00
        DC8      0x50, 0x37, 0x00, 0x00
        DC8      0x4C, 0x53, 0x00, 0x00
        DC8      0x52, 0x53, 0x00, 0x00
        DC8      0x43, 0x53, 0x00, 0x00
        DC8      0x4C, 0x48, 0x00, 0x00
        DC8      0x52, 0x48, 0x00, 0x00
        THUMB
// 2005 
// 2006     }
// 2007     //第1页。用来显示固定6行的左黑线两边的黑点白点的像素值。
// 2008     else if(DebugDisplayPage == 1)
??DebugOLEDUpdate_2:
        LDR.W    R0,??DebugOLEDUpdate_0+0x4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.W    ??DebugOLEDUpdate_11
// 2009     {
// 2010       //显示界面第1页用的。
// 2011       uint8 D_1_LB[18][4] = {0, 0, 0, 0};
        ADD      R0,SP,#+572
        MOVS     R1,#+72
        BL       __aeabi_memclr4
// 2012       uint8 D_1_LW[18][4] = {0, 0, 0, 0};
        ADD      R0,SP,#+500
        MOVS     R1,#+72
        BL       __aeabi_memclr4
// 2013       
// 2014       //建立字符串的尾巴。
// 2015       for(i = 0; i < 18; i++)
        MOVS     R4,#+0
        B.N      ??DebugOLEDUpdate_12
// 2016       {
// 2017         D_1_LB[i][3] = 0;
??DebugOLEDUpdate_13:
        MOVS     R0,#+0
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+3]
// 2018         D_1_LW[i][3] = 0;
        MOVS     R0,#+0
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+3]
// 2019       }      
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_12:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+18
        BLT.N    ??DebugOLEDUpdate_13
// 2020       
// 2021       //计算左边18个值和右边18个值，左右边关于中间对称。。
// 2022       //12 06 00
// 2023       //13 07 01
// 2024       //14 08 02
// 2025       //15 09 03
// 2026       //16 10 04
// 2027       //17 11 05
// 2028       for(i = 0; i <= 5; i++)
        MOVS     R4,#+0
        B.N      ??DebugOLEDUpdate_14
// 2029       {
// 2030         //当前行的左黑线提取失败。
// 2031         if(BlackLeftLoc[9 + i * 10][0] ==  MaxValUint8)
// 2032         {
// 2033           D_1_LB[i][0] = 32;
// 2034           D_1_LB[i][1] = 32;
// 2035           D_1_LB[i][2] = 32;   
// 2036 
// 2037           D_1_LB[i + 6][0] = 32;
// 2038           D_1_LB[i + 6][1] = 32;
// 2039           D_1_LB[i + 6][2] = 32;         
// 2040 
// 2041           D_1_LB[i + 12][0] = 32;
// 2042           D_1_LB[i + 12][1] = 32;
// 2043           D_1_LB[i + 12][2] = 32;
// 2044 
// 2045           D_1_LW[i][0] = 32;
// 2046           D_1_LW[i][1] = 32;
// 2047           D_1_LW[i][2] = 32;
// 2048 
// 2049           D_1_LW[i + 6][0] = 32;
// 2050           D_1_LW[i + 6][1] = 32;
// 2051           D_1_LW[i + 6][2] = 32;
// 2052 
// 2053           D_1_LW[i + 12][0] = 32;
// 2054           D_1_LW[i + 12][1] = 32;
// 2055           D_1_LW[i + 12][2] = 32;
// 2056         }
// 2057         //当前行的左黑线提取成功。
// 2058         else
// 2059         {
// 2060           //0-5表示第3列。
// 2061           temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0] + 1 + BlackLeftEdgeNum] - ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0]];
??DebugOLEDUpdate_15:
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_8+0xC
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2254]
        LDR.W    R1,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R2,#+2500
        MLA      R1,R2,R4,R1
        LDR.W    R2,??DebugOLEDUpdate_8+0xC
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R3,#+30
        MLA      R2,R3,R4,R2
        LDRB     R2,[R2, #+27]
        ADDS     R1,R2,R1
        LDRB     R1,[R1, #+2250]
        SUBS     R0,R0,R1
// 2062           D_1_LB[i][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R1,[R2, R4, LSL #+2]
// 2063           D_1_LB[i][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+1]
// 2064           D_1_LB[i][2] = (temp % 10) / 1 + 48;   
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
// 2065           
// 2066           //6-11表示第2列。
// 2067           temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0]];
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_8+0xC
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2250]
// 2068           D_1_LB[i + 6][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+24]
// 2069           D_1_LB[i + 6][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+25]
// 2070           D_1_LB[i + 6][2] = (temp % 10) / 1 + 48;         
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+26]
// 2071           
// 2072           //12-17表示第1列。
// 2073           temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0] - 1];
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_8+0xC
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2249]
// 2074           D_1_LB[i + 12][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+48]
// 2075           D_1_LB[i + 12][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+49]
// 2076           D_1_LB[i + 12][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+50]
// 2077   
// 2078           //0-5表示第4列。
// 2079           temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0] + 1 + BlackLeftEdgeNum];
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_8+0xC
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2254]
// 2080           D_1_LW[i][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R1,[R2, R4, LSL #+2]
// 2081           D_1_LW[i][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+1]
// 2082           D_1_LW[i][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
// 2083           
// 2084           //6-11表示第5列。
// 2085           temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0] + 2 + BlackLeftEdgeNum];
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_8+0xC
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2255]
// 2086           D_1_LW[i + 6][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+24]
// 2087           D_1_LW[i + 6][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+25]
// 2088           D_1_LW[i + 6][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+26]
// 2089           
// 2090           //12-17表示第6列。
// 2091           temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0] + 3 + BlackLeftEdgeNum];
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_8+0xC
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2256]
// 2092           D_1_LW[i + 12][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+48]
// 2093           D_1_LW[i + 12][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+49]
// 2094           D_1_LW[i + 12][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+50]
// 2095         }
??DebugOLEDUpdate_16:
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_14:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+6
        BGE.N    ??DebugOLEDUpdate_17
        LDR.W    R0,??DebugOLEDUpdate_8+0xC
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+10
        MUL      R1,R1,R4
        MOVS     R2,#+3
        MLA      R0,R2,R1,R0
        LDRB     R0,[R0, #+27]
        CMP      R0,#+255
        BNE.W    ??DebugOLEDUpdate_15
        MOVS     R0,#+32
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R1, R4, LSL #+2]
        MOVS     R0,#+32
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+1]
        MOVS     R0,#+32
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
        MOVS     R0,#+32
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+24]
        MOVS     R0,#+32
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+25]
        MOVS     R0,#+32
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+26]
        MOVS     R0,#+32
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+48]
        MOVS     R0,#+32
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+49]
        MOVS     R0,#+32
        ADD      R1,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+50]
        MOVS     R0,#+32
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R1, R4, LSL #+2]
        MOVS     R0,#+32
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+1]
        MOVS     R0,#+32
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
        MOVS     R0,#+32
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+24]
        MOVS     R0,#+32
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+25]
        MOVS     R0,#+32
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+26]
        MOVS     R0,#+32
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+48]
        MOVS     R0,#+32
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+49]
        MOVS     R0,#+32
        ADD      R1,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+50]
        B.N      ??DebugOLEDUpdate_16
// 2096       }     
// 2097       
// 2098       //36个值的显示。
// 2099       LCD_P6x8Str(55, 0, "D_1");
??DebugOLEDUpdate_17:
        ADR.N    R2,??DebugOLEDUpdate_18  ;; "D_1"
        MOVS     R1,#+0
        MOVS     R0,#+55
        BL       LCD_P6x8Str
// 2100       LCD_P6x8Str(14, 1, "LB");
        ADR.N    R2,??DebugOLEDUpdate_18+0x4  ;; 0x4C, 0x42, 0x00, 0x00
        MOVS     R1,#+1
        MOVS     R0,#+14
        BL       LCD_P6x8Str
// 2101       LCD_P6x8Str(48, 1, "C");
        ADR.N    R2,??DebugOLEDUpdate_18+0x8  ;; "C"
        MOVS     R1,#+1
        MOVS     R0,#+48
        BL       LCD_P6x8Str
// 2102       LCD_P6x8Str(86, 1, "LW");
        ADR.N    R2,??DebugOLEDUpdate_18+0xC  ;; 0x4C, 0x57, 0x00, 0x00
        MOVS     R1,#+1
        MOVS     R0,#+86
        BL       LCD_P6x8Str
// 2103       
// 2104       for(i = 0; i <= 5; i++)
        MOVS     R4,#+0
??DebugOLEDUpdate_19:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+6
        BGE.W    ??DebugOLEDUpdate_10
// 2105       {
// 2106         LCD_P6x8Str(42, i+2, D_1_LB[i]);
        ADD      R0,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R0,R4, LSL #+2
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+42
        BL       LCD_P6x8Str
// 2107         LCD_P6x8Str(21, i+2, D_1_LB[i+6]);
        ADD      R0,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+24
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+21
        BL       LCD_P6x8Str
// 2108         LCD_P6x8Str(0, i+2, D_1_LB[i+12]);
        ADD      R0,SP,#+572
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+48
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 2109         LCD_P6x8Str(64, i+2, D_1_LW[i]);
        ADD      R0,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R0,R4, LSL #+2
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 2110         LCD_P6x8Str(85, i+2, D_1_LW[i+6]);
        ADD      R0,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+24
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+85
        BL       LCD_P6x8Str
// 2111         LCD_P6x8Str(106, i+2, D_1_LW[i+12]);        
        ADD      R0,SP,#+500
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+48
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+106
        BL       LCD_P6x8Str
// 2112       }
        ADDS     R4,R4,#+1
        B.N      ??DebugOLEDUpdate_19
// 2113     }
// 2114     //第2页.用来显示固定6行的右黑线两边的黑点白点的像素值。
// 2115     else if(DebugDisplayPage == 2)
??DebugOLEDUpdate_11:
        LDR.W    R0,??DebugOLEDUpdate_0+0x4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.W    ??DebugOLEDUpdate_20
// 2116     {
// 2117       //显示界面第2页用的。
// 2118       uint8 D_2_RB[18][4] = {0, 0, 0, 0};  
        ADD      R0,SP,#+428
        MOVS     R1,#+72
        BL       __aeabi_memclr4
// 2119       uint8 D_2_RW[18][4] = {0, 0, 0, 0};  
        ADD      R0,SP,#+356
        MOVS     R1,#+72
        BL       __aeabi_memclr4
// 2120       
// 2121       //建立字符串的尾巴。
// 2122       for(i = 0; i < 18; i++)
        MOVS     R4,#+0
        B.N      ??DebugOLEDUpdate_21
        Nop      
        DATA
??DebugOLEDUpdate_18:
        DC8      "D_1"
        DC8      0x4C, 0x42, 0x00, 0x00
        DC8      "C",0x0,0x0
        DC8      0x4C, 0x57, 0x00, 0x00
        THUMB
// 2123       {
// 2124         D_2_RB[i][3] = 0;
??DebugOLEDUpdate_22:
        MOVS     R0,#+0
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+3]
// 2125         D_2_RW[i][3] = 0;
        MOVS     R0,#+0
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+3]
// 2126       }
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_21:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+18
        BLT.N    ??DebugOLEDUpdate_22
// 2127       
// 2128       //计算左边18个值和右边18个值，左右边关于中间对称。。
// 2129       //12 06 00
// 2130       //13 07 01
// 2131       //14 08 02
// 2132       //15 09 03
// 2133       //16 10 04
// 2134       //17 11 05
// 2135       for(i = 0; i <= 5; i++)
        MOVS     R4,#+0
        B.N      ??DebugOLEDUpdate_23
// 2136       {
// 2137         //当前行的右黑线提取失败。
// 2138         if(BlackRightLoc[9 + i * 10][0] ==  MaxValUint8)
// 2139         {
// 2140           D_2_RB[i][0] = 32;
// 2141           D_2_RB[i][1] = 32;
// 2142           D_2_RB[i][2] = 32;
// 2143 
// 2144           D_2_RB[i + 6][0] = 32;
// 2145           D_2_RB[i + 6][1] = 32;
// 2146           D_2_RB[i + 6][2] = 32;
// 2147 
// 2148           D_2_RB[i + 12][0] = 32;
// 2149           D_2_RB[i + 12][1] = 32;
// 2150           D_2_RB[i + 12][2] = 32;
// 2151 
// 2152           D_2_RW[i][0] = 32;
// 2153           D_2_RW[i][1] = 32;
// 2154           D_2_RW[i][2] = 32;
// 2155 
// 2156           D_2_RW[i + 6][0] = 32;
// 2157           D_2_RW[i + 6][1] = 32;
// 2158           D_2_RW[i + 6][2] = 32;
// 2159 
// 2160           D_2_RW[i + 12][0] = 32;
// 2161           D_2_RW[i + 12][1] = 32;
// 2162           D_2_RW[i + 12][2] = 32;
// 2163         }
// 2164         //当前行的右黑线提取成功。
// 2165         else
// 2166         {
// 2167           //0-5表示第4列。
// 2168           temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0] - 1 - BlackLeftEdgeNum] - ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0]];
??DebugOLEDUpdate_24:
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_25+0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2246]
        LDR.W    R1,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R2,#+2500
        MLA      R1,R2,R4,R1
        LDR.W    R2,??DebugOLEDUpdate_25+0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R3,#+30
        MLA      R2,R3,R4,R2
        LDRB     R2,[R2, #+27]
        ADDS     R1,R2,R1
        LDRB     R1,[R1, #+2250]
        SUBS     R0,R0,R1
// 2169           D_2_RB[i][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R1,[R2, R4, LSL #+2]
// 2170           D_2_RB[i][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+1]
// 2171           D_2_RB[i][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
// 2172           
// 2173           //6-11表示第5列。
// 2174           temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0]];
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_25+0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2250]
// 2175           D_2_RB[i + 6][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+24]
// 2176           D_2_RB[i + 6][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+25]
// 2177           D_2_RB[i + 6][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+26]
// 2178           
// 2179           //12-17表示第6列。
// 2180           temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0] + 1];
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_25+0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2251]
// 2181           D_2_RB[i + 12][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+48]
// 2182           D_2_RB[i + 12][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+49]
// 2183           D_2_RB[i + 12][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+50]
// 2184   
// 2185           //0-5表示第3列。
// 2186           temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0] - 1 - BlackLeftEdgeNum];
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_25+0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2246]
// 2187           D_2_RW[i][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R1,[R2, R4, LSL #+2]
// 2188           D_2_RW[i][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+1]
// 2189           D_2_RW[i][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
// 2190           
// 2191           //6-11表示第2列。
// 2192           temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0] - 2 - BlackLeftEdgeNum];
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_25+0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2245]
// 2193           D_2_RW[i + 6][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+24]
// 2194           D_2_RW[i + 6][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+25]
// 2195           D_2_RW[i + 6][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+26]
// 2196           
// 2197           //12-17表示第1列。
// 2198           temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0] - 3 - BlackLeftEdgeNum];
        LDR.W    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVW     R1,#+2500
        MLA      R0,R1,R4,R0
        LDR.W    R1,??DebugOLEDUpdate_25+0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+30
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+27]
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #+2244]
// 2199           D_2_RW[i + 12][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+48]
// 2200           D_2_RW[i + 12][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+49]
// 2201           D_2_RW[i + 12][2] = (temp % 10) / 1 + 48;          
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+50]
// 2202         }
??DebugOLEDUpdate_26:
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_23:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+6
        BGE.W    ??DebugOLEDUpdate_27
        LDR.W    R0,??DebugOLEDUpdate_25+0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+10
        MUL      R1,R1,R4
        MOVS     R2,#+3
        MLA      R0,R2,R1,R0
        LDRB     R0,[R0, #+27]
        CMP      R0,#+255
        BNE.W    ??DebugOLEDUpdate_24
        MOVS     R0,#+32
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R1, R4, LSL #+2]
        MOVS     R0,#+32
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+1]
        MOVS     R0,#+32
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
        MOVS     R0,#+32
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+24]
        MOVS     R0,#+32
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+25]
        MOVS     R0,#+32
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+26]
        MOVS     R0,#+32
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+48]
        MOVS     R0,#+32
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+49]
        MOVS     R0,#+32
        ADD      R1,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+50]
        MOVS     R0,#+32
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R0,[R1, R4, LSL #+2]
        MOVS     R0,#+32
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+1]
        MOVS     R0,#+32
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
        MOVS     R0,#+32
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+24]
        MOVS     R0,#+32
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+25]
        MOVS     R0,#+32
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+26]
        MOVS     R0,#+32
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+48]
        MOVS     R0,#+32
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+49]
        MOVS     R0,#+32
        ADD      R1,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+50]
        B.N      ??DebugOLEDUpdate_26
        Nop      
        DATA
??DebugOLEDUpdate_0:
        DC32     DebugScreenChosen
        DC32     DebugDisplayPage
        THUMB
// 2203       }     
// 2204       
// 2205       //36个值的显示。
// 2206       LCD_P6x8Str(55, 0, "D_2");
??DebugOLEDUpdate_27:
        ADR.N    R2,??DebugOLEDUpdate_3+0x10  ;; "D_2"
        MOVS     R1,#+0
        MOVS     R0,#+55
        BL       LCD_P6x8Str
// 2207       LCD_P6x8Str(16, 1, "RW");
        ADR.N    R2,??DebugOLEDUpdate_3+0x14  ;; 0x52, 0x57, 0x00, 0x00
        MOVS     R1,#+1
        MOVS     R0,#+16
        BL       LCD_P6x8Str
// 2208       LCD_P6x8Str(70, 1, "C");
        ADR.N    R2,??DebugOLEDUpdate_3+0x18  ;; "C"
        MOVS     R1,#+1
        MOVS     R0,#+70
        BL       LCD_P6x8Str
// 2209       LCD_P6x8Str(98, 1, "RB");
        ADR.N    R2,??DebugOLEDUpdate_3+0x1C  ;; 0x52, 0x42, 0x00, 0x00
        MOVS     R1,#+1
        MOVS     R0,#+98
        BL       LCD_P6x8Str
// 2210       
// 2211       for(i = 0; i <= 5; i++)
        MOVS     R4,#+0
??DebugOLEDUpdate_28:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+6
        BGE.W    ??DebugOLEDUpdate_10
// 2212       {
// 2213         LCD_P6x8Str(42, i+2, D_2_RW[i]);
        ADD      R0,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R0,R4, LSL #+2
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+42
        BL       LCD_P6x8Str
// 2214         LCD_P6x8Str(21, i+2, D_2_RW[i+6]);
        ADD      R0,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+24
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+21
        BL       LCD_P6x8Str
// 2215         LCD_P6x8Str(0, i+2, D_2_RW[i+12]);
        ADD      R0,SP,#+356
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+48
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 2216         LCD_P6x8Str(64, i+2, D_2_RB[i]);
        ADD      R0,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R0,R4, LSL #+2
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 2217         LCD_P6x8Str(85, i+2, D_2_RB[i+6]);
        ADD      R0,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+24
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+85
        BL       LCD_P6x8Str
// 2218         LCD_P6x8Str(106, i+2, D_2_RB[i+12]);        
        ADD      R0,SP,#+428
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+48
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+106
        BL       LCD_P6x8Str
// 2219       }
        ADDS     R4,R4,#+1
        B.N      ??DebugOLEDUpdate_28
        Nop      
        DATA
??DebugOLEDUpdate_3:
        DC32     DeviFuse
        DC32     DeviPre
        DC32     BatteryCheckVal
        DC32     Steer_kp
        DC8      "D_2"
        DC8      0x52, 0x57, 0x00, 0x00
        DC8      "C",0x0,0x0
        DC8      0x52, 0x42, 0x00, 0x00
        DC32     BlackLeftEdgeStartCol
        DC32     BlackRightEdgeStartCol
        DC32     BlackCenEdgeStartCol
        THUMB
// 2220     }
// 2221     //第3页.用来显示地板的像素值，以确定相关的阈值。
// 2222     else if(DebugDisplayPage == 3)
??DebugOLEDUpdate_20:
        LDR.W    R0,??DataTable7_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.W    ??DebugOLEDUpdate_29
// 2223     {
// 2224       //显示界面第3页用的。
// 2225       uint8 D_3_L[18][4] = {0, 0, 0, 0};
        ADD      R0,SP,#+716
        MOVS     R1,#+72
        BL       __aeabi_memclr4
// 2226       uint8 D_3_R[18][4] = {0, 0, 0, 0};
        ADD      R0,SP,#+644
        MOVS     R1,#+72
        BL       __aeabi_memclr4
// 2227       
// 2228       //建立字符串的尾巴。
// 2229       for(i = 0; i < 18; i++)
        MOVS     R4,#+0
        B.N      ??DebugOLEDUpdate_30
// 2230       {
// 2231         D_3_L[i][3] = 0;
??DebugOLEDUpdate_31:
        MOVS     R0,#+0
        ADD      R1,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+3]
// 2232         D_3_R[i][3] = 0;
        MOVS     R0,#+0
        ADD      R1,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+3]
// 2233       }
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_30:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+18
        BLT.N    ??DebugOLEDUpdate_31
// 2234       
// 2235       
// 2236       //更新36个值。
// 2237       for(i = 0; i <= 5; i++)
        MOVS     R4,#+0
        B.N      ??DebugOLEDUpdate_32
// 2238       {
// 2239         //0-5表示第3列。
// 2240         temp = ImgNew[9 + i * 10][CameraRealWidth/2];
??DebugOLEDUpdate_33:
        LDR.N    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+10
        MUL      R1,R1,R4
        MOVS     R2,#+250
        MLA      R0,R2,R1,R0
        LDRB     R0,[R0, #+2375]
// 2241         D_3_L[i][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R1,[R2, R4, LSL #+2]
// 2242         D_3_L[i][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+1]
// 2243         D_3_L[i][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
// 2244         
// 2245         //6-11表示第2列。
// 2246         temp = ImgNew[9 + i * 10][CameraRealWidth/2 - 1];
        LDR.N    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+10
        MUL      R1,R1,R4
        MOVS     R2,#+250
        MLA      R0,R2,R1,R0
        LDRB     R0,[R0, #+2374]
// 2247         D_3_L[i + 6][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+24]
// 2248         D_3_L[i + 6][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+25]
// 2249         D_3_L[i + 6][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+26]
// 2250         
// 2251         //12-17表示第1列。
// 2252         temp = ImgNew[9 + i * 10][CameraRealWidth/2 - 2];
        LDR.N    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+10
        MUL      R1,R1,R4
        MOVS     R2,#+250
        MLA      R0,R2,R1,R0
        LDRB     R0,[R0, #+2373]
// 2253         D_3_L[i + 12][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+48]
// 2254         D_3_L[i + 12][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+49]
// 2255         D_3_L[i + 12][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+50]
// 2256 
// 2257         //0-5表示第4列。
// 2258         temp = ImgNew[9 + i * 10][CameraRealWidth/2 + 1];
        LDR.N    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+10
        MUL      R1,R1,R4
        MOVS     R2,#+250
        MLA      R0,R2,R1,R0
        LDRB     R0,[R0, #+2376]
// 2259         D_3_R[i][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R1,[R2, R4, LSL #+2]
// 2260         D_3_R[i][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+1]
// 2261         D_3_R[i][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
// 2262         
// 2263         //6-11表示第5列。
// 2264         temp = ImgNew[9 + i * 10][CameraRealWidth/2 + 2];
        LDR.N    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+10
        MUL      R1,R1,R4
        MOVS     R2,#+250
        MLA      R0,R2,R1,R0
        LDRB     R0,[R0, #+2377]
// 2265         D_3_R[i + 6][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+24]
// 2266         D_3_R[i + 6][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+25]
// 2267         D_3_R[i + 6][2] = (temp % 10) / 1 + 48;
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+26]
// 2268         
// 2269         //12-17表示第6列。
// 2270         temp = ImgNew[9 + i * 10][CameraRealWidth/2 + 3];
        LDR.N    R0,??DebugOLEDUpdate_8+0x8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,#+10
        MUL      R1,R1,R4
        MOVS     R2,#+250
        MLA      R0,R2,R1,R0
        LDRB     R0,[R0, #+2378]
// 2271         D_3_R[i + 12][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+48]
// 2272         D_3_R[i + 12][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+49]
// 2273         D_3_R[i + 12][2] = (temp % 10) / 1 + 48;      
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+50]
// 2274       }
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_32:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+6
        BLT.W    ??DebugOLEDUpdate_33
// 2275       
// 2276       
// 2277       //36个值的显示。
// 2278       LCD_P6x8Str(55, 0, "D_3");
        ADR.N    R2,??DebugOLEDUpdate_34  ;; "D_3"
        MOVS     R1,#+0
        MOVS     R0,#+55
        BL       LCD_P6x8Str
// 2279       LCD_P6x8Str(0,   1, "123");
        ADR.N    R2,??DebugOLEDUpdate_34+0x4  ;; "123"
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 2280       LCD_P6x8Str(21,  1, "124");
        ADR.N    R2,??DebugOLEDUpdate_34+0x8  ;; "124"
        MOVS     R1,#+1
        MOVS     R0,#+21
        BL       LCD_P6x8Str
// 2281       LCD_P6x8Str(42,  1, "125");
        ADR.N    R2,??DebugOLEDUpdate_34+0xC  ;; "125"
        MOVS     R1,#+1
        MOVS     R0,#+42
        BL       LCD_P6x8Str
// 2282       LCD_P6x8Str(64,  1, "126");
        ADR.N    R2,??DebugOLEDUpdate_34+0x10  ;; "126"
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 2283       LCD_P6x8Str(85,  1, "127");
        ADR.N    R2,??DebugOLEDUpdate_34+0x14  ;; "127"
        MOVS     R1,#+1
        MOVS     R0,#+85
        BL       LCD_P6x8Str
// 2284       LCD_P6x8Str(106, 1, "128");   
        ADR.N    R2,??DebugOLEDUpdate_34+0x18  ;; "128"
        MOVS     R1,#+1
        MOVS     R0,#+106
        BL       LCD_P6x8Str
// 2285       
// 2286       for(i = 0; i <= 5; i++)
        MOVS     R4,#+0
??DebugOLEDUpdate_35:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+6
        BGE.W    ??DebugOLEDUpdate_10
// 2287       {
// 2288         LCD_P6x8Str(42, i+2, D_3_L[i]);
        ADD      R0,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R0,R4, LSL #+2
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+42
        BL       LCD_P6x8Str
// 2289         LCD_P6x8Str(21, i+2, D_3_L[i+6]);
        ADD      R0,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+24
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+21
        BL       LCD_P6x8Str
// 2290         LCD_P6x8Str(0, i+2, D_3_L[i+12]);
        ADD      R0,SP,#+716
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+48
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 2291         LCD_P6x8Str(64, i+2, D_3_R[i]);
        ADD      R0,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R0,R4, LSL #+2
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+64
        BL       LCD_P6x8Str
// 2292         LCD_P6x8Str(85, i+2, D_3_R[i+6]);
        ADD      R0,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+24
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+85
        BL       LCD_P6x8Str
// 2293         LCD_P6x8Str(106, i+2, D_3_R[i+12]);        
        ADD      R0,SP,#+644
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+2
        ADDS     R2,R0,#+48
        ADDS     R1,R4,#+2
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+106
        BL       LCD_P6x8Str
// 2294       }      
        ADDS     R4,R4,#+1
        B.N      ??DebugOLEDUpdate_35
// 2295     }
// 2296     //画图
// 2297     else if(DebugDisplayPage == 4)
??DebugOLEDUpdate_29:
        LDR.W    R0,??DataTable7_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BNE.W    ??DebugOLEDUpdate_10
// 2298     {
// 2299       uint8 bmp[127*8];  //127列0~126，8页0~7。
// 2300       uint32 j;
// 2301       uint8 page;
// 2302       //页 第0列 第126列
// 2303       //0:   0 ~ 126
// 2304       //1: 127 ~ 253
// 2305       //2: 254 ~ 380
// 2306       //3: 381 ~ 507
// 2307       //4: 508 ~ 634
// 2308       //5: 635 ~ 761
// 2309       //6: 762 ~ 888
// 2310       //7: 889 ~ 1015
// 2311       //数组清零
// 2312       for(j = 0; j < 127 * 8; j++)
        MOVS     R0,#+0
        B.N      ??DebugOLEDUpdate_36
        Nop      
        DATA
??DebugOLEDUpdate_8:
        DC32     BlackLeftHeadLine
        DC32     BlackRightHeadLine
        DC32     ImgNew
        DC32     BlackLeftLoc
        THUMB
// 2313       {
// 2314         bmp[j] = 0;
??DebugOLEDUpdate_37:
        MOVS     R1,#+0
        ADD      R2,SP,#+788
        STRB     R1,[R0, R2]
// 2315       }
        ADDS     R0,R0,#+1
??DebugOLEDUpdate_36:
        CMP      R0,#+1016
        BCC.N    ??DebugOLEDUpdate_37
// 2316       //实际图像绘制60x125，有则写1。有点小难度。
// 2317       for(i = 0; i < 60; i++)
        MOVS     R4,#+0
        B.N      ??DebugOLEDUpdate_38
// 2318       {
// 2319         //页码。
// 2320         page = i / 8;
??DebugOLEDUpdate_39:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R0,#+8
        SDIV     R0,R4,R0
// 2321         //左黑线，有则写1.
// 2322         if(BlackLeftLoc[i][0] != MaxValUint8)
        LDR.W    R1,??DataTable9_15
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+3
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+0]
        CMP      R1,#+255
        BEQ.N    ??DebugOLEDUpdate_40
// 2323         {
// 2324           bmp[127 * page + BlackLeftLoc[i][0] / 2] |= 1 << (i - page * 8);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R1,#+127
        LDR.W    R2,??DataTable9_15
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R3,#+3
        MLA      R2,R3,R4,R2
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+2
        SDIV     R2,R2,R3
        MLA      R1,R1,R0,R2
        ADD      R2,SP,#+788
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R3,#+127
        LDR.W    R5,??DataTable9_15
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R6,#+3
        MLA      R5,R6,R4,R5
        LDRB     R5,[R5, #+0]
        MOVS     R6,#+2
        SDIV     R5,R5,R6
        MLA      R3,R3,R0,R5
        ADD      R5,SP,#+788
        LDRB     R3,[R3, R5]
        MOVS     R5,#+1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        SUBS     R6,R4,R0, LSL #+3
        LSLS     R5,R5,R6
        ORRS     R3,R5,R3
        STRB     R3,[R1, R2]
// 2325         }
// 2326         else
// 2327         {
// 2328         }
// 2329         //右黑线，有则写1.
// 2330         if(BlackRightLoc[i][0] != MaxValUint8)
??DebugOLEDUpdate_40:
        LDR.W    R1,??DebugOLEDUpdate_25+0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R2,#+3
        MLA      R1,R2,R4,R1
        LDRB     R1,[R1, #+0]
        CMP      R1,#+255
        BEQ.N    ??DebugOLEDUpdate_41
// 2331         {
// 2332           bmp[127 * page + BlackRightLoc[i][0] / 2] |= 1 << (i - page * 8);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R1,#+127
        LDR.W    R2,??DebugOLEDUpdate_25+0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R3,#+3
        MLA      R2,R3,R4,R2
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+2
        SDIV     R2,R2,R3
        MLA      R1,R1,R0,R2
        ADD      R2,SP,#+788
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R3,#+127
        LDR.W    R5,??DebugOLEDUpdate_25+0x4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R6,#+3
        MLA      R5,R6,R4,R5
        LDRB     R5,[R5, #+0]
        MOVS     R6,#+2
        SDIV     R5,R5,R6
        MLA      R3,R3,R0,R5
        ADD      R5,SP,#+788
        LDRB     R3,[R3, R5]
        MOVS     R5,#+1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        SUBS     R0,R4,R0, LSL #+3
        LSLS     R0,R5,R0
        ORRS     R0,R0,R3
        STRB     R0,[R1, R2]
// 2333         }
// 2334         else
// 2335         {
// 2336         }                
// 2337       }
??DebugOLEDUpdate_41:
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_38:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+60
        BLT.N    ??DebugOLEDUpdate_39
// 2338       //行标识
// 2339       bmp[253]  |= 1 << 1;  //第9行
        LDRB     R0,[SP, #+1041]
        ORRS     R0,R0,#0x2
        STRB     R0,[SP, #+1041]
// 2340       bmp[380]  |= 1 << 3;  //第19行
        LDRB     R0,[SP, #+1168]
        ORRS     R0,R0,#0x8
        STRB     R0,[SP, #+1168]
// 2341       bmp[507]  |= 1 << 5;  //第29行
        LDRB     R0,[SP, #+1295]
        ORRS     R0,R0,#0x20
        STRB     R0,[SP, #+1295]
// 2342       bmp[634]  |= 1 << 7;  //第39行
        LDRB     R0,[SP, #+1422]
        ORRS     R0,R0,#0x80
        STRB     R0,[SP, #+1422]
// 2343       bmp[888]  |= 1 << 1;  //第49行
        LDRB     R0,[SP, #+1676]
        ORRS     R0,R0,#0x2
        STRB     R0,[SP, #+1676]
// 2344       bmp[1015] |= 1 << 3;  //第59行
        LDRB     R0,[SP, #+1803]
        ORRS     R0,R0,#0x8
        STRB     R0,[SP, #+1803]
// 2345       //左线头
// 2346       if(BlackLeftHeadLine != MaxValUint8)
        LDR.W    R0,??DataTable9_16
        LDRB     R0,[R0, #+0]
        CMP      R0,#+255
        BEQ.N    ??DebugOLEDUpdate_42
// 2347       {
// 2348         page = BlackLeftHeadLine / 8;
        LDR.W    R0,??DataTable9_16
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+8
        SDIV     R0,R0,R1
// 2349         bmp[127 * page] |= 1 << (BlackLeftHeadLine - page * 8);
        ADD      R1,SP,#+788
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R2,#+127
        MLA      R1,R2,R0,R1
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+1
        LDR.W    R3,??DataTable9_16
        LDRB     R3,[R3, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        SUBS     R3,R3,R0, LSL #+3
        LSLS     R2,R2,R3
        ORRS     R1,R2,R1
        ADD      R2,SP,#+788
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R3,#+127
        MLA      R0,R3,R0,R2
        STRB     R1,[R0, #+0]
// 2350       }
// 2351       else
// 2352       {
// 2353       }
// 2354       //右线头
// 2355       if(BlackRightHeadLine != MaxValUint8)
??DebugOLEDUpdate_42:
        LDR.W    R0,??DataTable9_17
        LDRB     R0,[R0, #+0]
        CMP      R0,#+255
        BEQ.N    ??DebugOLEDUpdate_43
// 2356       {
// 2357         page = BlackRightHeadLine / 8;
        LDR.W    R0,??DataTable9_17
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+8
        SDIV     R0,R0,R1
// 2358         bmp[127 * page + 125] |= 1 << (BlackRightHeadLine - page * 8);
        ADD      R1,SP,#+788
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R2,#+127
        MLA      R1,R2,R0,R1
        LDRB     R1,[R1, #+125]
        MOVS     R2,#+1
        LDR.W    R3,??DataTable9_17
        LDRB     R3,[R3, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        SUBS     R3,R3,R0, LSL #+3
        LSLS     R2,R2,R3
        ORRS     R1,R2,R1
        ADD      R2,SP,#+788
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R3,#+127
        MLA      R0,R3,R0,R2
        STRB     R1,[R0, #+125]
// 2359       }
// 2360       else
// 2361       {
// 2362       }      
// 2363       //列标识
// 2364       bmp[889]  |= 1 << 6;
??DebugOLEDUpdate_43:
        LDRB     R0,[SP, #+1677]
        ORRS     R0,R0,#0x40
        STRB     R0,[SP, #+1677]
// 2365       bmp[889]  |= 1 << 7;  //第0列
        LDRB     R0,[SP, #+1677]
        ORRS     R0,R0,#0x80
        STRB     R0,[SP, #+1677]
// 2366       bmp[951]  |= 1 << 6;
        LDRB     R0,[SP, #+1739]
        ORRS     R0,R0,#0x40
        STRB     R0,[SP, #+1739]
// 2367       bmp[951]  |= 1 << 7;  //第62列
        LDRB     R0,[SP, #+1739]
        ORRS     R0,R0,#0x80
        STRB     R0,[SP, #+1739]
// 2368       bmp[1014]  |= 1 << 6;
        LDRB     R0,[SP, #+1802]
        ORRS     R0,R0,#0x40
        STRB     R0,[SP, #+1802]
// 2369       bmp[1014]  |= 1 << 7;  //第125列  
        LDRB     R0,[SP, #+1802]
        ORRS     R0,R0,#0x80
        STRB     R0,[SP, #+1802]
// 2370       //左扫描起点
// 2371       bmp[889 + BlackLeftEdgeStartCol / 2] |= 1 << 4;
        LDR.W    R0,??DataTable9_18
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        SDIV     R0,R0,R1
        ADD      R1,SP,#+788
        ADDS     R0,R0,R1
        LDR.W    R1,??DataTable9_18
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+2
        SDIV     R1,R1,R2
        ADD      R2,SP,#+788
        ADDS     R1,R1,R2
        LDRB     R1,[R1, #+889]
        ORRS     R1,R1,#0x10
        STRB     R1,[R0, #+889]
// 2372       bmp[889 + BlackLeftEdgeStartCol / 2] |= 1 << 5;
        LDR.W    R0,??DataTable9_18
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        SDIV     R0,R0,R1
        ADD      R1,SP,#+788
        ADDS     R0,R0,R1
        LDR.W    R1,??DataTable9_18
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+2
        SDIV     R1,R1,R2
        ADD      R2,SP,#+788
        ADDS     R1,R1,R2
        LDRB     R1,[R1, #+889]
        ORRS     R1,R1,#0x20
        STRB     R1,[R0, #+889]
// 2373       //右扫描起点
// 2374       bmp[889 + BlackRightEdgeStartCol / 2] |= 1 << 4;
        LDR.W    R0,??DataTable9_19
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        SDIV     R0,R0,R1
        ADD      R1,SP,#+788
        ADDS     R0,R0,R1
        LDR.W    R1,??DataTable9_19
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+2
        SDIV     R1,R1,R2
        ADD      R2,SP,#+788
        ADDS     R1,R1,R2
        LDRB     R1,[R1, #+889]
        ORRS     R1,R1,#0x10
        STRB     R1,[R0, #+889]
// 2375       bmp[889 + BlackRightEdgeStartCol / 2] |= 1 << 5;      
        LDR.W    R0,??DataTable9_19
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        SDIV     R0,R0,R1
        ADD      R1,SP,#+788
        ADDS     R0,R0,R1
        LDR.W    R1,??DataTable9_19
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+2
        SDIV     R1,R1,R2
        ADD      R2,SP,#+788
        ADDS     R1,R1,R2
        LDRB     R1,[R1, #+889]
        ORRS     R1,R1,#0x20
        STRB     R1,[R0, #+889]
// 2376       //PutPixel函数有误，只能用DrawBMP函数，且更高效。
// 2377       Draw_BMP(0, 0, 127, 7, bmp);      
        ADD      R0,SP,#+788
        STR      R0,[SP, #+0]
        MOVS     R3,#+7
        MOVS     R2,#+127
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       Draw_BMP
        B.N      ??DebugOLEDUpdate_10
        Nop      
        DATA
??DebugOLEDUpdate_34:
        DC8      "D_3"
        DC8      "123"
        DC8      "124"
        DC8      "125"
        DC8      "126"
        DC8      "127"
        DC8      "128"
        THUMB
// 2378     }
// 2379     //待添加页。
// 2380     else 
// 2381     {
// 2382     }
// 2383   }
// 2384   //当前为调参界面。
// 2385   else
// 2386   {
// 2387     //调参界面用的。前3个表示值，最后1个表示字符串末尾。
// 2388     uint8 tempVal[60][4]; 
// 2389 
// 2390     //建立字符串的尾巴。
// 2391     for(i = 0; i < 60; i++)
??DebugOLEDUpdate_1:
        MOVS     R4,#+0
        B.N      ??DebugOLEDUpdate_44
// 2392     {
// 2393       tempVal[i][3] = 0;
??DebugOLEDUpdate_45:
        MOVS     R0,#+0
        ADD      R1,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+3]
// 2394     }
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_44:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+60
        BLT.N    ??DebugOLEDUpdate_45
// 2395     
// 2396     //调参界面的页码，0,1,2,3
// 2397     if(DebugModifyPage == 0)
        LDR.W    R0,??DataTable9_20
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??DebugOLEDUpdate_46
// 2398     {
// 2399       //第0页的标题。
// 2400       LCD_P6x8Str(0, 0, "M_0");
        ADR.N    R2,??DebugOLEDUpdate_47  ;; "M_0"
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 2401       //修改标志。
// 2402       if(DebugModifyFlag == 1)
        LDR.W    R0,??DataTable9_21
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugOLEDUpdate_48
// 2403       {
// 2404         LCD_P6x8Str(24, 0, "@");
        ADR.N    R2,??DebugOLEDUpdate_47+0x4  ;; "@"
        MOVS     R1,#+0
        MOVS     R0,#+24
        BL       LCD_P6x8Str
        B.N      ??DebugOLEDUpdate_49
// 2405       }
// 2406       else
// 2407       {
// 2408         LCD_P6x8Str(24, 0, " ");
??DebugOLEDUpdate_48:
        ADR.N    R2,??DebugOLEDUpdate_25  ;; " "
        MOVS     R1,#+0
        MOVS     R0,#+24
        BL       LCD_P6x8Str
// 2409       }
// 2410       
// 2411       //光标的标注。
// 2412       DebugModifyCursorMark();
??DebugOLEDUpdate_49:
        BL       DebugModifyCursorMark
// 2413       
// 2414       //15个参数的计算。
// 2415       for(i = 0; i <= 14; i++)
        MOVS     R4,#+0
        B.N      ??DebugOLEDUpdate_50
// 2416       {
// 2417         temp = DebugModifyNum[i];
??DebugOLEDUpdate_51:
        LDR.W    R0,??DataTable9_22
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRH     R0,[R0, R4, LSL #+1]
// 2418         tempVal[i][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R1,[R2, R4, LSL #+2]
// 2419         tempVal[i][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+1]
// 2420         tempVal[i][2] = (temp % 10) / 1 + 48;        
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
// 2421       }
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_50:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+15
        BLT.N    ??DebugOLEDUpdate_51
// 2422       //15个参数名字的显示。
// 2423       LCD_P6x8Str(12, 1, "SPD");
        ADR.N    R2,??DebugOLEDUpdate_25+0x8  ;; "SPD"
        MOVS     R1,#+1
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2424       LCD_P6x8Str(12, 2, "Kp1");
        ADR.N    R2,??DebugOLEDUpdate_25+0xC  ;; "Kp1"
        MOVS     R1,#+2
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2425       LCD_P6x8Str(12, 3, "Kp2");
        ADR.N    R2,??DebugOLEDUpdate_25+0x10  ;; "Kp2"
        MOVS     R1,#+3
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2426       LCD_P6x8Str(12, 4, "Kp3");
        ADR.N    R2,??DebugOLEDUpdate_25+0x14  ;; "Kp3"
        MOVS     R1,#+4
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2427       LCD_P6x8Str(12, 5, "Kp4");
        ADR.N    R2,??DebugOLEDUpdate_25+0x18  ;; "Kp4"
        MOVS     R1,#+5
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2428       LCD_P6x8Str(12, 6, "Kp5");
        ADR.N    R2,??DebugOLEDUpdate_25+0x1C  ;; "Kp5"
        MOVS     R1,#+6
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2429       LCD_P6x8Str(12, 7, "Kp6");
        ADR.N    R2,??DebugOLEDUpdate_25+0x20  ;; "Kp6"
        MOVS     R1,#+7
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2430       LCD_P6x8Str(76, 0, "Kp7");
        ADR.N    R2,??DebugOLEDUpdate_25+0x24  ;; "Kp7"
        MOVS     R1,#+0
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2431       LCD_P6x8Str(76, 1, "Kp0");
        ADR.N    R2,??DebugOLEDUpdate_25+0x28  ;; "Kp0"
        MOVS     R1,#+1
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2432       LCD_P6x8Str(76, 2, "MtI");
        ADR.N    R2,??DebugOLEDUpdate_25+0x2C  ;; "MtI"
        MOVS     R1,#+2
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2433       LCD_P6x8Str(76, 3, "MtP");
        ADR.N    R2,??DebugOLEDUpdate_25+0x30  ;; "MtP"
        MOVS     R1,#+3
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2434       LCD_P6x8Str(76, 4, "Mt5");
        ADR.N    R2,??DebugOLEDUpdate_25+0x34  ;; "Mt5"
        MOVS     R1,#+4
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2435       LCD_P6x8Str(76, 5, "Mt4");
        ADR.N    R2,??DebugOLEDUpdate_25+0x38  ;; "Mt4"
        MOVS     R1,#+5
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2436       LCD_P6x8Str(76, 6, "Mt3");
        ADR.N    R2,??DebugOLEDUpdate_25+0x3C  ;; "Mt3"
        MOVS     R1,#+6
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2437       LCD_P6x8Str(76, 7, "Mt2");
        ADR.N    R2,??DebugOLEDUpdate_25+0x40  ;; "Mt2"
        MOVS     R1,#+7
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2438       //15个参数值的显示。
// 2439       LCD_P6x8Str(36, 1, tempVal[0]);
        ADD      R2,SP,#+116
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2440       LCD_P6x8Str(36, 2, tempVal[1]);
        ADD      R2,SP,#+120
        MOVS     R1,#+2
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2441       LCD_P6x8Str(36, 3, tempVal[2]);
        ADD      R2,SP,#+124
        MOVS     R1,#+3
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2442       LCD_P6x8Str(36, 4, tempVal[3]);
        ADD      R2,SP,#+128
        MOVS     R1,#+4
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2443       LCD_P6x8Str(36, 5, tempVal[4]);
        ADD      R2,SP,#+132
        MOVS     R1,#+5
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2444       LCD_P6x8Str(36, 6, tempVal[5]);
        ADD      R2,SP,#+136
        MOVS     R1,#+6
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2445       LCD_P6x8Str(36, 7, tempVal[6]);
        ADD      R2,SP,#+140
        MOVS     R1,#+7
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2446       LCD_P6x8Str(100, 0, tempVal[7]);
        ADD      R2,SP,#+144
        MOVS     R1,#+0
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2447       LCD_P6x8Str(100, 1, tempVal[8]);
        ADD      R2,SP,#+148
        MOVS     R1,#+1
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2448       LCD_P6x8Str(100, 2, tempVal[9]);
        ADD      R2,SP,#+152
        MOVS     R1,#+2
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2449       LCD_P6x8Str(100, 3, tempVal[10]);
        ADD      R2,SP,#+156
        MOVS     R1,#+3
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2450       LCD_P6x8Str(100, 4, tempVal[11]);
        ADD      R2,SP,#+160
        MOVS     R1,#+4
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2451       LCD_P6x8Str(100, 5, tempVal[12]);
        ADD      R2,SP,#+164
        MOVS     R1,#+5
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2452       LCD_P6x8Str(100, 6, tempVal[13]);
        ADD      R2,SP,#+168
        MOVS     R1,#+6
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2453       LCD_P6x8Str(100, 7, tempVal[14]);
        ADD      R2,SP,#+172
        MOVS     R1,#+7
        MOVS     R0,#+100
        BL       LCD_P6x8Str
        B.N      ??DebugOLEDUpdate_10
// 2454       
// 2455     }
// 2456     //调参界面的页码，0,1,2,3
// 2457     else if(DebugModifyPage == 1)
??DebugOLEDUpdate_46:
        LDR.W    R0,??DataTable9_20
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.W    ??DebugOLEDUpdate_52
// 2458     {
// 2459       //第1页的标题。
// 2460       LCD_P6x8Str(0, 0, "M_1");
        ADR.N    R2,??DebugOLEDUpdate_25+0x44  ;; "M_1"
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 2461       //修改标志。
// 2462       if(DebugModifyFlag == 1)
        LDR.W    R0,??DataTable9_21
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugOLEDUpdate_53
// 2463       {
// 2464         LCD_P6x8Str(24, 0, "@");
        ADR.N    R2,??DebugOLEDUpdate_47+0x4  ;; "@"
        MOVS     R1,#+0
        MOVS     R0,#+24
        BL       LCD_P6x8Str
        B.N      ??DebugOLEDUpdate_54
// 2465       }
// 2466       else
// 2467       {
// 2468         LCD_P6x8Str(24, 0, " ");
??DebugOLEDUpdate_53:
        ADR.N    R2,??DebugOLEDUpdate_25  ;; " "
        MOVS     R1,#+0
        MOVS     R0,#+24
        BL       LCD_P6x8Str
// 2469       }
// 2470       
// 2471       //光标的标注。
// 2472       DebugModifyCursorMark();
??DebugOLEDUpdate_54:
        BL       DebugModifyCursorMark
// 2473       
// 2474       //15个参数的计算。
// 2475       for(i = 15; i <= 29; i++)
        MOVS     R4,#+15
        B.N      ??DebugOLEDUpdate_55
        DATA
??DebugOLEDUpdate_47:
        DC8      "M_0"
        DC8      "@",0x0,0x0
        THUMB
// 2476       {
// 2477         temp = DebugModifyNum[i];
??DebugOLEDUpdate_56:
        LDR.W    R0,??DataTable9_22
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRH     R0,[R0, R4, LSL #+1]
// 2478         tempVal[i][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R1,[R2, R4, LSL #+2]
// 2479         tempVal[i][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+1]
// 2480         tempVal[i][2] = (temp % 10) / 1 + 48;        
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
// 2481       }
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_55:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+30
        BLT.N    ??DebugOLEDUpdate_56
// 2482       //15个参数名字的显示。
// 2483       LCD_P6x8Str(12, 1, "Mt1");
        ADR.N    R2,??DebugOLEDUpdate_25+0x48  ;; "Mt1"
        MOVS     R1,#+1
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2484       LCD_P6x8Str(12, 2, "Mt0");
        ADR.N    R2,??DebugOLEDUpdate_57  ;; "Mt0"
        MOVS     R1,#+2
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2485       LCD_P6x8Str(12, 3, "Bci");
        ADR.N    R2,??DebugOLEDUpdate_57+0x4  ;; "Bci"
        MOVS     R1,#+3
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2486       LCD_P6x8Str(12, 4, "Bxu");
        ADR.N    R2,??DebugOLEDUpdate_57+0x8  ;; "Bxu"
        MOVS     R1,#+4
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2487       LCD_P6x8Str(12, 5, "WBi");
        ADR.N    R2,??DebugOLEDUpdate_57+0xC  ;; "WBi"
        MOVS     R1,#+5
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2488       LCD_P6x8Str(12, 6, "WBa");
        ADR.N    R2,??DebugOLEDUpdate_57+0x10  ;; "WBa"
        MOVS     R1,#+6
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2489       LCD_P6x8Str(12, 7, "Win");
        ADR.N    R2,??DebugOLEDUpdate_57+0x14  ;; "Win"
        MOVS     R1,#+7
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2490       LCD_P6x8Str(76, 0, "Wax");
        ADR.N    R2,??DebugOLEDUpdate_57+0x18  ;; "Wax"
        MOVS     R1,#+0
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2491       LCD_P6x8Str(76, 1, "Bin");
        ADR.N    R2,??DebugOLEDUpdate_57+0x1C  ;; "Bin"
        MOVS     R1,#+1
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2492       LCD_P6x8Str(76, 2, "Bax");
        ADR.N    R2,??DebugOLEDUpdate_57+0x20  ;; "Bax"
        MOVS     R1,#+2
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2493       LCD_P6x8Str(76, 3, "Zhi");
        ADR.N    R2,??DebugOLEDUpdate_57+0x24  ;; "Zhi"
        MOVS     R1,#+3
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2494       LCD_P6x8Str(76, 4, "Zha");
        ADR.N    R2,??DebugOLEDUpdate_57+0x28  ;; "Zha"
        MOVS     R1,#+4
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2495       LCD_P6x8Str(76, 5, "sPo");
        ADR.N    R2,??DebugOLEDUpdate_57+0x2C  ;; "sPo"
        MOVS     R1,#+5
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2496       LCD_P6x8Str(76, 6, "xPo");
        ADR.N    R2,??DebugOLEDUpdate_57+0x30  ;; "xPo"
        MOVS     R1,#+6
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2497       LCD_P6x8Str(76, 7, "xZi");
        ADR.N    R2,??DebugOLEDUpdate_57+0x34  ;; "xZi"
        MOVS     R1,#+7
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2498       //15个参数值的显示。
// 2499       LCD_P6x8Str(36, 1, tempVal[0+15]);
        ADD      R2,SP,#+176
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2500       LCD_P6x8Str(36, 2, tempVal[1+15]);
        ADD      R2,SP,#+180
        MOVS     R1,#+2
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2501       LCD_P6x8Str(36, 3, tempVal[2+15]);
        ADD      R2,SP,#+184
        MOVS     R1,#+3
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2502       LCD_P6x8Str(36, 4, tempVal[3+15]);
        ADD      R2,SP,#+188
        MOVS     R1,#+4
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2503       LCD_P6x8Str(36, 5, tempVal[4+15]);
        ADD      R2,SP,#+192
        MOVS     R1,#+5
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2504       LCD_P6x8Str(36, 6, tempVal[5+15]);
        ADD      R2,SP,#+196
        MOVS     R1,#+6
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2505       LCD_P6x8Str(36, 7, tempVal[6+15]);
        ADD      R2,SP,#+200
        MOVS     R1,#+7
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2506       LCD_P6x8Str(100, 0, tempVal[7+15]);
        ADD      R2,SP,#+204
        MOVS     R1,#+0
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2507       LCD_P6x8Str(100, 1, tempVal[8+15]);
        ADD      R2,SP,#+208
        MOVS     R1,#+1
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2508       LCD_P6x8Str(100, 2, tempVal[9+15]);
        ADD      R2,SP,#+212
        MOVS     R1,#+2
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2509       LCD_P6x8Str(100, 3, tempVal[10+15]);
        ADD      R2,SP,#+216
        MOVS     R1,#+3
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2510       LCD_P6x8Str(100, 4, tempVal[11+15]);
        ADD      R2,SP,#+220
        MOVS     R1,#+4
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2511       LCD_P6x8Str(100, 5, tempVal[12+15]);
        ADD      R2,SP,#+224
        MOVS     R1,#+5
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2512       LCD_P6x8Str(100, 6, tempVal[13+15]);
        ADD      R2,SP,#+228
        MOVS     R1,#+6
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2513       LCD_P6x8Str(100, 7, tempVal[14+15]);  
        ADD      R2,SP,#+232
        MOVS     R1,#+7
        MOVS     R0,#+100
        BL       LCD_P6x8Str
        B.N      ??DebugOLEDUpdate_10
        DATA
??DebugOLEDUpdate_25:
        DC8      " ",0x0,0x0
        DC32     BlackRightLoc
        DC8      "SPD"
        DC8      "Kp1"
        DC8      "Kp2"
        DC8      "Kp3"
        DC8      "Kp4"
        DC8      "Kp5"
        DC8      "Kp6"
        DC8      "Kp7"
        DC8      "Kp0"
        DC8      "MtI"
        DC8      "MtP"
        DC8      "Mt5"
        DC8      "Mt4"
        DC8      "Mt3"
        DC8      "Mt2"
        DC8      "M_1"
        DC8      "Mt1"
        THUMB
// 2514     }
// 2515     //当前是第2页。
// 2516     else if(DebugModifyPage == 2)
??DebugOLEDUpdate_52:
        LDR.W    R0,??DataTable9_20
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.W    ??DebugOLEDUpdate_58
// 2517     {
// 2518       //第2页的标题。
// 2519       LCD_P6x8Str(0, 0, "M_2");
        ADR.N    R2,??DebugOLEDUpdate_57+0x38  ;; "M_2"
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 2520       //修改标志。
// 2521       if(DebugModifyFlag == 1)
        LDR.W    R0,??DataTable9_21
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugOLEDUpdate_59
// 2522       {
// 2523         LCD_P6x8Str(24, 0, "@");
        ADR.N    R2,??DebugOLEDUpdate_57+0x3C  ;; "@"
        MOVS     R1,#+0
        MOVS     R0,#+24
        BL       LCD_P6x8Str
        B.N      ??DebugOLEDUpdate_60
// 2524       }
// 2525       else
// 2526       {
// 2527         LCD_P6x8Str(24, 0, " ");
??DebugOLEDUpdate_59:
        ADR.N    R2,??DebugOLEDUpdate_57+0x40  ;; " "
        MOVS     R1,#+0
        MOVS     R0,#+24
        BL       LCD_P6x8Str
// 2528       }
// 2529       
// 2530       //光标的标注。
// 2531       DebugModifyCursorMark();
??DebugOLEDUpdate_60:
        BL       DebugModifyCursorMark
// 2532       
// 2533       //15个参数的计算。
// 2534       for(i = 30; i <= 44; i++)
        MOVS     R4,#+30
        B.N      ??DebugOLEDUpdate_61
// 2535       {
// 2536         temp = DebugModifyNum[i];
??DebugOLEDUpdate_62:
        LDR.W    R0,??DataTable9_22
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRH     R0,[R0, R4, LSL #+1]
// 2537         tempVal[i][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R1,[R2, R4, LSL #+2]
// 2538         tempVal[i][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+1]
// 2539         tempVal[i][2] = (temp % 10) / 1 + 48;        
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
// 2540       }
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_61:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+45
        BLT.N    ??DebugOLEDUpdate_62
// 2541       //15个参数名字的显示。
// 2542       LCD_P6x8Str(12, 1, "C33");
        ADR.N    R2,??DataTable8  ;; "C33"
        MOVS     R1,#+1
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2543       LCD_P6x8Str(12, 2, "C04");
        ADR.N    R2,??DataTable8_1  ;; "C04"
        MOVS     R1,#+2
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2544       LCD_P6x8Str(12, 3, "C14");
        ADR.N    R2,??DataTable8_2  ;; "C14"
        MOVS     R1,#+3
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2545       LCD_P6x8Str(12, 4, "C24");
        ADR.N    R2,??DataTable8_3  ;; "C24"
        MOVS     R1,#+4
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2546       LCD_P6x8Str(12, 5, "C34");
        ADR.N    R2,??DataTable8_4  ;; "C34"
        MOVS     R1,#+5
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2547       LCD_P6x8Str(12, 6, "C05");
        ADR.N    R2,??DataTable8_5  ;; "C05"
        MOVS     R1,#+6
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2548       LCD_P6x8Str(12, 7, "C15");
        ADR.N    R2,??DataTable8_6  ;; "C15"
        MOVS     R1,#+7
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2549       LCD_P6x8Str(76, 0, "C25");
        ADR.N    R2,??DataTable8_7  ;; "C25"
        MOVS     R1,#+0
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2550       LCD_P6x8Str(76, 1, "C35");
        ADR.N    R2,??DataTable7  ;; "C35"
        MOVS     R1,#+1
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2551       LCD_P6x8Str(76, 2, "C06");
        ADR.N    R2,??DataTable7_1  ;; "C06"
        MOVS     R1,#+2
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2552       LCD_P6x8Str(76, 3, "C16");
        ADR.N    R2,??DataTable7_2  ;; "C16"
        MOVS     R1,#+3
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2553       LCD_P6x8Str(76, 4, "C26");
        ADR.N    R2,??DataTable7_3  ;; "C26"
        MOVS     R1,#+4
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2554       LCD_P6x8Str(76, 5, "C36");
        ADR.N    R2,??DataTable7_4  ;; "C36"
        MOVS     R1,#+5
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2555       LCD_P6x8Str(76, 6, "C07");
        ADR.N    R2,??DataTable7_5  ;; "C07"
        MOVS     R1,#+6
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2556       LCD_P6x8Str(76, 7, "C17");
        ADR.N    R2,??DataTable7_7  ;; "C17"
        MOVS     R1,#+7
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2557       //15个参数值的显示。
// 2558       LCD_P6x8Str(36, 1, tempVal[0+30]);
        ADD      R2,SP,#+236
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2559       LCD_P6x8Str(36, 2, tempVal[1+30]);
        ADD      R2,SP,#+240
        MOVS     R1,#+2
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2560       LCD_P6x8Str(36, 3, tempVal[2+30]);
        ADD      R2,SP,#+244
        MOVS     R1,#+3
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2561       LCD_P6x8Str(36, 4, tempVal[3+30]);
        ADD      R2,SP,#+248
        MOVS     R1,#+4
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2562       LCD_P6x8Str(36, 5, tempVal[4+30]);
        ADD      R2,SP,#+252
        MOVS     R1,#+5
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2563       LCD_P6x8Str(36, 6, tempVal[5+30]);
        ADD      R2,SP,#+256
        MOVS     R1,#+6
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2564       LCD_P6x8Str(36, 7, tempVal[6+30]);
        ADD      R2,SP,#+260
        MOVS     R1,#+7
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2565       LCD_P6x8Str(100, 0, tempVal[7+30]);
        ADD      R2,SP,#+264
        MOVS     R1,#+0
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2566       LCD_P6x8Str(100, 1, tempVal[8+30]);
        ADD      R2,SP,#+268
        MOVS     R1,#+1
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2567       LCD_P6x8Str(100, 2, tempVal[9+30]);
        ADD      R2,SP,#+272
        MOVS     R1,#+2
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2568       LCD_P6x8Str(100, 3, tempVal[10+30]);
        ADD      R2,SP,#+276
        MOVS     R1,#+3
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2569       LCD_P6x8Str(100, 4, tempVal[11+30]);
        ADD      R2,SP,#+280
        MOVS     R1,#+4
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2570       LCD_P6x8Str(100, 5, tempVal[12+30]);
        ADD      R2,SP,#+284
        MOVS     R1,#+5
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2571       LCD_P6x8Str(100, 6, tempVal[13+30]);
        ADD      R2,SP,#+288
        MOVS     R1,#+6
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2572       LCD_P6x8Str(100, 7, tempVal[14+30]);
        ADD      R2,SP,#+292
        MOVS     R1,#+7
        MOVS     R0,#+100
        BL       LCD_P6x8Str
        B.N      ??DebugOLEDUpdate_10
// 2573     }
// 2574     //当前是第3页。
// 2575     else if(DebugModifyPage == 3)
??DebugOLEDUpdate_58:
        LDR.N    R0,??DataTable9_20
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.W    ??DebugOLEDUpdate_10
// 2576     {
// 2577       //第2页的标题。
// 2578       LCD_P6x8Str(0, 0, "M_2");
        ADR.N    R2,??DebugOLEDUpdate_57+0x38  ;; "M_2"
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       LCD_P6x8Str
// 2579       //修改标志。
// 2580       if(DebugModifyFlag == 1)
        LDR.N    R0,??DataTable9_21
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??DebugOLEDUpdate_63
// 2581       {
// 2582         LCD_P6x8Str(24, 0, "@");
        ADR.N    R2,??DebugOLEDUpdate_57+0x3C  ;; "@"
        MOVS     R1,#+0
        MOVS     R0,#+24
        BL       LCD_P6x8Str
        B.N      ??DebugOLEDUpdate_64
// 2583       }
// 2584       else
// 2585       {
// 2586         LCD_P6x8Str(24, 0, " ");
??DebugOLEDUpdate_63:
        ADR.N    R2,??DebugOLEDUpdate_57+0x40  ;; " "
        MOVS     R1,#+0
        MOVS     R0,#+24
        BL       LCD_P6x8Str
// 2587       }
// 2588       
// 2589       //光标的标注。
// 2590       DebugModifyCursorMark();
??DebugOLEDUpdate_64:
        BL       DebugModifyCursorMark
// 2591       
// 2592       //15个参数的计算。
// 2593       for(i = 45; i <= 59; i++)
        MOVS     R4,#+45
        B.N      ??DebugOLEDUpdate_65
        DATA
??DebugOLEDUpdate_57:
        DC8      "Mt0"
        DC8      "Bci"
        DC8      "Bxu"
        DC8      "WBi"
        DC8      "WBa"
        DC8      "Win"
        DC8      "Wax"
        DC8      "Bin"
        DC8      "Bax"
        DC8      "Zhi"
        DC8      "Zha"
        DC8      "sPo"
        DC8      "xPo"
        DC8      "xZi"
        DC8      "M_2"
        DC8      "@",0x0,0x0
        DC8      " ",0x0,0x0
        THUMB
// 2594       {
// 2595         temp = DebugModifyNum[i];
??DebugOLEDUpdate_66:
        LDR.N    R0,??DataTable9_22
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRH     R0,[R0, R4, LSL #+1]
// 2596         tempVal[i][0] = temp / 100 + 48;
        MOVS     R1,#+100
        UDIV     R1,R0,R1
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R1,[R2, R4, LSL #+2]
// 2597         tempVal[i][1] = (temp % 100) / 10 + 48;
        MOVS     R1,#+100
        UDIV     R2,R0,R1
        MLS      R1,R1,R2,R0
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        ADDS     R1,R1,#+48
        ADD      R2,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R2,R2,R4, LSL #+2
        STRB     R1,[R2, #+1]
// 2598         tempVal[i][2] = (temp % 10) / 1 + 48;        
        MOVS     R1,#+10
        UDIV     R2,R0,R1
        MLS      R0,R1,R2,R0
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        ADDS     R0,R0,#+48
        ADD      R1,SP,#+116
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+2
        STRB     R0,[R1, #+2]
// 2599       }
        ADDS     R4,R4,#+1
??DebugOLEDUpdate_65:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+60
        BLT.N    ??DebugOLEDUpdate_66
// 2600       //15个参数名字的显示。
// 2601       LCD_P6x8Str(12, 1, "C27");
        ADR.N    R2,??DataTable9  ;; "C27"
        MOVS     R1,#+1
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2602       LCD_P6x8Str(12, 2, "C37");
        ADR.N    R2,??DataTable9_1  ;; "C37"
        MOVS     R1,#+2
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2603       LCD_P6x8Str(12, 3, "Tim");
        ADR.N    R2,??DataTable9_2  ;; "Tim"
        MOVS     R1,#+3
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2604       LCD_P6x8Str(12, 4, "MoP");
        ADR.N    R2,??DataTable9_3  ;; "MoP"
        MOVS     R1,#+4
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2605       LCD_P6x8Str(12, 5, "MoD");
        ADR.N    R2,??DataTable9_4  ;; "MoD"
        MOVS     R1,#+5
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2606       LCD_P6x8Str(12, 6, "STG");
        ADR.N    R2,??DataTable9_5  ;; "STG"
        MOVS     R1,#+6
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2607       LCD_P6x8Str(12, 7, "STA");
        ADR.N    R2,??DataTable9_6  ;; "STA"
        MOVS     R1,#+7
        MOVS     R0,#+12
        BL       LCD_P6x8Str
// 2608       LCD_P6x8Str(76, 0, "STL");
        ADR.N    R2,??DataTable9_7  ;; "STL"
        MOVS     R1,#+0
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2609       LCD_P6x8Str(76, 1, "Kd1");
        ADR.N    R2,??DataTable9_8  ;; "Kd1"
        MOVS     R1,#+1
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2610       LCD_P6x8Str(76, 2, "Kd2");
        ADR.N    R2,??DataTable9_9  ;; "Kd2"
        MOVS     R1,#+2
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2611       LCD_P6x8Str(76, 3, "Kd3");
        ADR.N    R2,??DataTable9_10  ;; "Kd3"
        MOVS     R1,#+3
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2612       LCD_P6x8Str(76, 4, "Kd4");
        ADR.N    R2,??DataTable9_11  ;; "Kd4"
        MOVS     R1,#+4
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2613       LCD_P6x8Str(76, 5, "Kd5");
        ADR.N    R2,??DataTable9_12  ;; "Kd5"
        MOVS     R1,#+5
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2614       LCD_P6x8Str(76, 6, "Kd6");
        ADR.N    R2,??DataTable9_13  ;; "Kd6"
        MOVS     R1,#+6
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2615       LCD_P6x8Str(76, 7, "Kd7");
        ADR.N    R2,??DataTable9_14  ;; "Kd7"
        MOVS     R1,#+7
        MOVS     R0,#+76
        BL       LCD_P6x8Str
// 2616       //15个参数值的显示。
// 2617       LCD_P6x8Str(36, 1, tempVal[0+45]);
        ADD      R2,SP,#+296
        MOVS     R1,#+1
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2618       LCD_P6x8Str(36, 2, tempVal[1+45]);
        ADD      R2,SP,#+300
        MOVS     R1,#+2
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2619       LCD_P6x8Str(36, 3, tempVal[2+45]);
        ADD      R2,SP,#+304
        MOVS     R1,#+3
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2620       LCD_P6x8Str(36, 4, tempVal[3+45]);
        ADD      R2,SP,#+308
        MOVS     R1,#+4
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2621       LCD_P6x8Str(36, 5, tempVal[4+45]);
        ADD      R2,SP,#+312
        MOVS     R1,#+5
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2622       LCD_P6x8Str(36, 6, tempVal[5+45]);
        ADD      R2,SP,#+316
        MOVS     R1,#+6
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2623       LCD_P6x8Str(36, 7, tempVal[6+45]);
        ADD      R2,SP,#+320
        MOVS     R1,#+7
        MOVS     R0,#+36
        BL       LCD_P6x8Str
// 2624       LCD_P6x8Str(100, 0, tempVal[7+45]);
        ADD      R2,SP,#+324
        MOVS     R1,#+0
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2625       LCD_P6x8Str(100, 1, tempVal[8+45]);
        ADD      R2,SP,#+328
        MOVS     R1,#+1
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2626       LCD_P6x8Str(100, 2, tempVal[9+45]);
        ADD      R2,SP,#+332
        MOVS     R1,#+2
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2627       LCD_P6x8Str(100, 3, tempVal[10+45]);
        ADD      R2,SP,#+336
        MOVS     R1,#+3
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2628       LCD_P6x8Str(100, 4, tempVal[11+45]);
        ADD      R2,SP,#+340
        MOVS     R1,#+4
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2629       LCD_P6x8Str(100, 5, tempVal[12+45]);
        ADD      R2,SP,#+344
        MOVS     R1,#+5
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2630       LCD_P6x8Str(100, 6, tempVal[13+45]);
        ADD      R2,SP,#+348
        MOVS     R1,#+6
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2631       LCD_P6x8Str(100, 7, tempVal[14+45]);
        ADD      R2,SP,#+352
        MOVS     R1,#+7
        MOVS     R0,#+100
        BL       LCD_P6x8Str
// 2632     }
// 2633     else
// 2634     {
// 2635     }
// 2636   }
// 2637   return 1;
??DebugOLEDUpdate_10:
        MOVS     R0,#+1
        ADD      SP,SP,#+1808
        POP      {R4-R6,PC}       ;; return
// 2638 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7:
        DC8      "C35"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_1:
        DC8      "C06"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_2:
        DC8      "C16"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_3:
        DC8      "C26"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_4:
        DC8      "C36"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_5:
        DC8      "C07"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_6:
        DC32     DebugDisplayPage

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_7:
        DC8      "C17"
// 2639 
// 2640 
// 2641 
// 2642 //Debug调试函数。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2643 uint8 DebugDebug(void)
// 2644 {
DebugDebug:
        PUSH     {R7,LR}
// 2645   
// 2646   //1. 拨码开关扫描，里面会对DebugSwitchFlag[]标志进行更新。
// 2647   DebugSwitchScan();
        BL       DebugSwitchScan
// 2648   
// 2649   //2. 按键扫描。里面会对DebugButtonFlag[]标志进行更新。返回确认后的按键值。
// 2650   if(DebugButtonScan() == 1)
        BL       DebugButtonScan
        CMP      R0,#+1
        BNE.N    ??DebugDebug_0
// 2651   {
// 2652     //有某个键被按下。
// 2653     //3. 按键信息处理
// 2654     DebugButtonDeal();
        BL       DebugButtonDeal
// 2655   }
// 2656   else
// 2657   {
// 2658     //没有键被按下，可以不进行第3步操作。
// 2659   }
// 2660   
// 2661   DebugOLEDUpdateCount++;
??DebugDebug_0:
        LDR.N    R0,??DataTable9_23
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable9_23
        STRB     R0,[R1, #+0]
// 2662   if(DebugOLEDUpdateCount > DebugOLEDUpdateCountNum)
        LDR.N    R0,??DataTable9_23
        LDRB     R0,[R0, #+0]
        CMP      R0,#+21
        BLT.N    ??DebugDebug_1
// 2663   {
// 2664     DebugOLEDUpdateCount = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_23
        STRB     R0,[R1, #+0]
// 2665     //4. OLED屏显示信息刷新。刷新时不需要关中断，被打断不会影响它。
// 2666     //DisableInterrupts;
// 2667     DebugOLEDUpdate();
        BL       DebugOLEDUpdate
// 2668     //EnableInterrupts;  
// 2669   }
// 2670   else
// 2671   {    
// 2672   }
// 2673   
// 2674   return 1;
??DebugDebug_1:
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
// 2675 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8:
        DC8      "C33"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_1:
        DC8      "C04"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_2:
        DC8      "C14"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_3:
        DC8      "C24"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_4:
        DC8      "C34"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_5:
        DC8      "C05"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_6:
        DC8      "C15"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_7:
        DC8      "C25"
// 2676 
// 2677 
// 2678 //将最后的值写入FLASH。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2679 uint8 FlashFinalWrite(void)
// 2680 {
FlashFinalWrite:
        PUSH     {R4,LR}
// 2681   uint8 *pointeruint8;         //uint8型数据的指针。
// 2682   uint8 i;
// 2683   
// 2684   //先擦除整个扇区。
// 2685   FlashEraseSector(FlashSectorIndex);
        MOVS     R0,#+224
        BL       FlashEraseSector
// 2686   
// 2687   for(i = 0; i < 60; i++)
        MOVS     R4,#+0
        B.N      ??FlashFinalWrite_0
// 2688   {
// 2689     pointeruint8 = (uint8 *)&DebugModifyNum[i];
??FlashFinalWrite_1:
        LDR.N    R0,??DataTable9_22
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R3,R0,R4, LSL #+1
// 2690     FlashWriteNow(FlashSectorIndex, i, FlashElementSize, pointeruint8);      
        MOVS     R2,#+4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,R4
        MOVS     R0,#+224
        BL       FlashWriteNow
// 2691   }
        ADDS     R4,R4,#+1
??FlashFinalWrite_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+60
        BLT.N    ??FlashFinalWrite_1
// 2692   
// 2693   return 1;
        MOVS     R0,#+1
        POP      {R4,PC}          ;; return
// 2694 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC8      "C27"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_1:
        DC8      "C37"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_2:
        DC8      "Tim"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC8      "MoP"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC8      "MoD"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_5:
        DC8      "STG"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_6:
        DC8      "STA"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_7:
        DC8      "STL"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_8:
        DC8      "Kd1"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_9:
        DC8      "Kd2"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_10:
        DC8      "Kd3"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_11:
        DC8      "Kd4"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_12:
        DC8      "Kd5"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_13:
        DC8      "Kd6"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_14:
        DC8      "Kd7"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_15:
        DC32     BlackLeftLoc

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_16:
        DC32     BlackLeftHeadLine

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_17:
        DC32     BlackRightHeadLine

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_18:
        DC32     BlackLeftEdgeStartCol

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_19:
        DC32     BlackRightEdgeStartCol

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_20:
        DC32     DebugModifyPage

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_21:
        DC32     DebugModifyFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_22:
        DC32     DebugModifyNum

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_23:
        DC32     DebugOLEDUpdateCount

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 "#"

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 " "

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "D_0"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "DF"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "DD"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "P1"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "P2"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "P3"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "P4"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "P5"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "P6"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "P7"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "LS"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "RS"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "CS"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "LH"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "RH"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "D_1"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "LB"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 "C"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "LW"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "D_2"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "RW"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "RB"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "D_3"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "123"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "124"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "125"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "126"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "127"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "128"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "M_0"

        SECTION `.rodata`:CONST:REORDER:NOROOT(1)
        DATA
        DC8 "@"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "SPD"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kp1"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kp2"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kp3"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kp4"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kp5"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kp6"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kp7"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kp0"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "MtI"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "MtP"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Mt5"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Mt4"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Mt3"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Mt2"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "M_1"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Mt1"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Mt0"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Bci"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Bxu"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "WBi"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "WBa"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Win"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Wax"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Bin"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Bax"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Zhi"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Zha"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "sPo"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "xPo"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "xZi"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "M_2"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C33"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C04"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C14"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C24"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C34"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C05"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C15"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C25"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C35"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C06"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C16"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C26"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C36"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C07"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C17"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C27"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "C37"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Tim"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "MoP"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "MoD"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "STG"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "STA"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "STL"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kd1"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kd2"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kd3"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kd4"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kd5"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kd6"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 "Kd7"

        END
// 
//    151 bytes in section .bss
//      3 bytes in section .data
//    916 bytes in section .rodata
// 15 910 bytes in section .text
// 
// 15 910 bytes of CODE  memory
//    916 bytes of CONST memory
//    154 bytes of DATA  memory
//
//Errors: none
//Warnings: none
