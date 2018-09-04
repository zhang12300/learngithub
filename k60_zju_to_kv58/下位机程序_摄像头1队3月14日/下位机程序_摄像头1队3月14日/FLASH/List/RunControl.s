///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.30.3.8024/W32 for ARM       14/Mar/2018  19:12:13
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\RunControl.c
//    Command line =  
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\RunControl.c
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
//        E:\智能车\程序\下位机程序_摄像头1队3月9日\FLASH\List\RunControl.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN AbsInt
        EXTERN BrickConfirmLockFlag
        EXTERN BrickSpeDealFlag
        EXTERN BrickSpeDealServor
        EXTERN DeviFuse
        EXTERN DeviFuse_old
        EXTERN DeviFusemtr
        EXTERN DeviPre
        EXTERN GyroResultFlag
        EXTERN LCD_CLS
        EXTERN LCD_P8x16Str
        EXTERN PathRealStraightFlag
        EXTERN RunOutFlag
        EXTERN ShiZhiFlag
        EXTERN SpeedLastLeft
        EXTERN SpeedLastRight
        EXTERN SpeedNowLeft
        EXTERN SpeedNowRight
        EXTERN StopLineCheckFlag
        EXTERN xiaoZhiDaoFlag

        PUBLIC DeltaVelocity
        PUBLIC DoneFlag
        PUBLIC DuZhuanFlag
        PUBLIC ErrorCountNow0
        PUBLIC ErrorCountNow1
        PUBLIC MotorPID
        PUBLIC MotorPIDPMat
        PUBLIC MotorTakeOffFlag
        PUBLIC MotorTakeOffQuadCountLimit
        PUBLIC QuadSpeedLevel
        PUBLIC ServoPID
        PUBLIC ServoPIDD
        PUBLIC ServoPIDD2Mat
        PUBLIC ServoPIDDMat
        PUBLIC ServoPIDInputVal
        PUBLIC ServoPIDInputValD
        PUBLIC ServoPIDInputValOld
        PUBLIC ServoPIDInputValP
        PUBLIC ServoPIDP
        PUBLIC ServoPIDPMat
        PUBLIC ServoTemp
        PUBLIC SlopeCLevel
        PUBLIC SpeedBrick
        PUBLIC SpeedDiffGet
        PUBLIC SpeedDiffGetSwitch
        PUBLIC SpeedLastTargetLeftVal
        PUBLIC SpeedLastTargetRightVal
        PUBLIC SpeedLastTargetVal
        PUBLIC SpeedLeftVal
        PUBLIC SpeedLeftValD
        PUBLIC SpeedLeftValP
        PUBLIC SpeedPIDDVal
        PUBLIC SpeedPIDIVal
        PUBLIC SpeedPIDPVal
        PUBLIC SpeedRightVal
        PUBLIC SpeedRightValD
        PUBLIC SpeedRightValP
        PUBLIC SpeedStrategyChosen
        PUBLIC SpeedTargetLeftVal
        PUBLIC SpeedTargetLevel
        PUBLIC SpeedTargetMat
        PUBLIC SpeedTargetRightVal
        PUBLIC SpeedTargetVal
        PUBLIC SpeedTargetValAngle
        PUBLIC SpeedTargetValGryoResult
        PUBLIC SpeedTargetValGryoUp
        PUBLIC SpeedTargetValSpePathDeal
        PUBLIC SpeedTargetValStraight
        PUBLIC SpeedTargetValWaitStop
        PUBLIC SpeedXiaoZhiDao
        PUBLIC Steer_kp
        PUBLIC StopFlag
        PUBLIC StopFlagMaxCount
        PUBLIC StopFlagMaxCountNum
        PUBLIC StopLineControlFlag
        PUBLIC StopLineSpeed
        PUBLIC StopLineSpeedControlPauseFlag
        PUBLIC StopRealFlag
        PUBLIC StrategyLoadSpeedIndex
        PUBLIC TimeOutFlag
        PUBLIC speedP_goal
        PUBLIC speed_kd
        PUBLIC speed_kp
        PUBLIC temp_speed_D
        PUBLIC temp_speed_P
        PUBLIC temptempSpeedLeftVal

// E:\智能车\程序\下位机程序_摄像头1队3月9日\src\Sources\C\Function_C\RunControl.c
//    1 /******************************************************************************/
//    2 /*******************************************************************************
//    3   文件名：运动控制C文件RunControl.c
//    4   功  能：偏差求取，PID反馈，控制电机，控制舵机。
//    5   日  期：2014.11.15
//    6   作  者：YCR & HJZ
//    7   备  注：
//    8 *******************************************************************************/
//    9 /******************************************************************************/
//   10 #include "RunControl.h"
//   11 
//   12 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   13 uint8 DuZhuanFlag = 0;              //堵转标志
DuZhuanFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   14 uint8 TimeOutFlag = 0;              //时间到标志
TimeOutFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   15 uint16 StopLineSpeed = 0;            //停车控制速度
StopLineSpeed:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   16 uint8 StopLineControlFlag = 0;             //停车控制标志
StopLineControlFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   17 uint8 StopLineSpeedControlPauseFlag = 0;          //停车的时候间隔一场图像的时间控一次，防止正反电压切换的时候出问题
StopLineSpeedControlPauseFlag:
        DS8 1
//   18 
//   19 

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   20 uint16 SpeedXiaoZhiDao = 280;       //小直道
SpeedXiaoZhiDao:
        DATA
        DC16 280

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   21 uint16 SpeedTargetValGryoUp = 200;  //上坡速度。
SpeedTargetValGryoUp:
        DATA
        DC16 200

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   22 uint16 SpeedBrick = 200;            //障碍速度
SpeedBrick:
        DATA
        DC16 200
//   23 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   24 uint16 StopFlagMaxCount = 0;      //停车标志置位后，停车计数，大于一定值后最终停车标志置位。
StopFlagMaxCount:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   25 uint16 StopFlagMaxCountNum = 5;      //停车标志置位后，停车计数阈值，大于该值后，最终停车标志置位。1个单位是0.1秒。 
StopFlagMaxCountNum:
        DATA
        DC16 5
//   26 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   27 uint16 SpeedStrategyChosen = 0;     //速度策略的档位，0~4，0档最慢，4档最快。
SpeedStrategyChosen:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   28 uint16 MotorTakeOffQuadCountLimit = 0; //起飞控制时，转为正常电机PID控制前两轮编码器需要达到的脉冲数。
MotorTakeOffQuadCountLimit:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   29 uint16 SpeedTargetValStraight = 350;      //长直道给定速度。
SpeedTargetValStraight:
        DATA
        DC16 350

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   30 uint16 SpeedTargetValWaitStop = 20;     //灯塔等待停车速度。20代表2m/s。
SpeedTargetValWaitStop:
        DATA
        DC16 20
//   31 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   32 uint8 StopRealFlag = 0;     //绝对停止标志。1表示绝对停止，电机一定输出0。
StopRealFlag:
        DS8 1
//   33 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   34 int32 ServoTemp = 0;
ServoTemp:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   35 int32 DeltaVelocity = 0;   //差速计算验证。
DeltaVelocity:
        DS8 4
//   36 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   37 int16 ErrorCountNow0 = 0;
ErrorCountNow0:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   38 int16 ErrorCountNow1 = 0;
ErrorCountNow1:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   39 int32 temp_speed_D;
temp_speed_D:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   40 int32 temp_speed_P;
temp_speed_P:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   41 uint8 MotorTakeOffFlag = 0;   //起飞控制标志位，1未起飞，0已起飞。初始化为未起飞。
MotorTakeOffFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   42 uint8 SpeedTargetLevel;//目标速度等级，不模糊，分段求取
SpeedTargetLevel:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   43 uint8 StopFlag=0;       // 停车标志，1表示停车
StopFlag:
        DS8 1
//   44 
//   45 
//   46 
//   47 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   48 uint16 ServoPIDPMat[15] = 
ServoPIDPMat:
        DATA
        DC16 0, 165, 180, 205, 215, 235, 240, 229, 213, 201, 185, 173, 163, 154
        DC16 154
        DC8 0, 0
//   49 {
//   50  0,165,180,205,215,
//   51  235,240,229,213,201,
//   52  185,173,163,154,154
//   53 };
//   54 //舵机PID的P矩阵，行依据是当前偏差DeviFuse的绝对值的等级
//   55 //扩大了100倍。
//   56 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   57 uint16 Steer_kp[8] = 
Steer_kp:
        DATA
        DC16 0, 20, 30, 33, 40, 40, 35, 35
//   58 {
//   59   // 0,130,206,209,215,186,150,132
//   60   //0,130,186,209,209,186,160,141
//   61   //0,130,186,209,203,178,156,141 //2.1m
//   62     //150,150,150,150,150,150,150,150 
//   63    0,20,30,33,40,40,35,35
//   64   // 0,115,150,183,196,178,158,141//2.2
//   65   //0,90,120,153,176,178,158,141
//   66    //0,40,60,70,80,80,70,70
//   67 };
//   68 
//   69 //舵机D矩阵。

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   70 uint16 ServoPIDDMat[7] = 
ServoPIDDMat:
        DATA
        DC16 10, 10, 10, 10, 10, 10, 10
        DC8 0, 0
//   71 {
//   72 //0  25   45  60  80  100  120  140
//   73 //   2,   4,   3,  2,  2 ,  1,   1,
//   74  //25,   25,   25,   25,  25,   25,   25
//   75  //12,   12,   12,   12,  12,   12,   12
//   76 // 15,   15,   15,   15,  15,   15,   15
//   77  10,   10,   10,   10,   10,   10,   10
//   78  //19,   19,   19,   19,  19,   19,   19
//   79   //  50,   50,   50,  50,  50,   50,   50
//   80 //  20,   20,   20,   20,  20,   20,   20
//   81  // 0,    0,    0,    0,   0,    0,   0
//   82 };

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   83 uint16 ServoPIDD2Mat[7] = 
ServoPIDD2Mat:
        DATA
        DC16 10, 10, 10, 10, 10, 10, 10
        DC8 0, 0
//   84 {
//   85 // 0  25   45  60  80  100  120  140
//   86   // 2,   3,   3, 3,  4 ,  3,   2,
//   87 //15,   15,   15,   15,  15,   15,   15
//   88  // 19,   19,   19,   19,  19,   19,   19
//   89 //12,   12,   12,   12,  12,   12,   12 
//   90   10,   10,   10,   10,   10,   10,   10
//   91  //20,   20,   20,   20,  20,   20,   20
//   92 // 25,   25,   25,   25,  25,   25,   25
//   93 // 50,   50,   50,  50,  50,   50,   50
//   94 //    0,    0,    0,    0,   0,   0,    0
//   95 };

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   96 uint8 speedP_goal[11]=
speedP_goal:
        DATA
        DC8 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 0
//   97 {
//   98     //-140 -110 -80 -50 -25  0   25  50    80     110  140
//   99     //20,  23,  26, 29, 30, 33,  30,  29,   26,   23,  20, 
//  100     // 24, 26,  30, 33, 35, 37,  35,  33,   30,   26,  24, 
//  101     // 27, 29,  33, 36, 38, 41,  38,  36,   33,   29,  27,
//  102      //30, 31,  34, 36, 38, 41,  38,  36,   34,   31,  30,
//  103      //45, 48,  51, 53,  57, 60,  57,  53,   51,   48,  45, 
//  104      //20,  20,   20,  20,  20,   20,  20,   20,  20,  20,
//  105      10,10,10,10,10,10,10,10,10,10,10,
//  106 };
//  107 //实际目标脉冲数矩阵。
//  108 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//  109 uint16 SpeedTargetMat[9][11]=
SpeedTargetMat:
        DATA
        DC16 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 200, 200, 210, 220
        DC16 230, 240, 230, 220, 210, 200, 200, 210, 210, 220, 230, 240, 260
        DC16 240, 230, 220, 210, 210, 210, 220, 230, 240, 250, 280, 250, 240
        DC16 230, 220, 210, 210, 225, 235, 250, 260, 280, 260, 250, 235, 225
        DC16 210, 210, 210, 240, 250, 270, 300, 270, 250, 240, 210, 210, 220
        DC16 230, 240, 260, 280, 300, 280, 260, 240, 230, 220, 200, 210, 220
        DC16 240, 280, 330, 280, 240, 220, 210, 200, 210, 220, 230, 250, 280
        DC16 330, 280, 250, 230, 220, 210
        DC8 0, 0
//  110 {
//  111  //-140, -110, -80,  -50 , -25 ,  0  , 25  ,  50 ,  80  , 110 , 140,
//  112  //190, 200, 210, 215, 220, 230, 220, 215, 210, 200, 190,    //0档
//  113   10,10,10,10,10,10,10,10,10,10,10,
//  114 // 20,30,40,50,60,60,60,50,40,30,20,
//  115    //60,80,100,120,140,140,140,120,100,80,60,
//  116    //100, 120, 140, 180, 200, 200, 200, 180, 140, 120, 100,
//  117    200, 200, 210, 220, 230, 240, 230, 220, 210, 200, 200,    //1档
//  118    210, 210, 220, 230, 240, 260, 240, 230, 220, 210, 210,    //2档，比较稳定
//  119    210, 220, 230, 240, 250, 280, 250, 240, 230, 220, 210,    //3档，直道高，弯道低
//  120    210, 225, 235, 250, 260, 280, 260, 250, 235, 225, 210,    //4档，直道高，弯道高
//  121    210, 210, 240, 250, 270, 300, 270, 250, 240, 210, 210,    //5档，直道高，弯道低
//  122    220, 230, 240, 260, 280, 300, 280, 260, 240, 230, 220,    //6档，直道高，弯道高
//  123    200, 210, 220, 240, 280, 330, 280, 240, 220, 210, 200,    //7档，直道高，弯道低  
//  124    210, 220, 230, 250, 280, 330, 280, 250, 230, 220, 210,    //8档，直道高，弯道高
//  125 };
//  126 /*
//  127 uint16 SpeedTargetMat[11][9]=
//  128 {
//  129   //-140 -110 -80  -50  -25   0   25   50   80   110  140
//  130     200, 200, 200, 205, 210, 210, 210, 205,  200, 200, 200,  //-15
//  131     200, 200, 200, 210, 210, 220, 210, 210,  200, 200, 200,  //-10
//  132     200, 205, 210, 210, 220, 230, 220, 210,  210, 205, 200,  //-6
//  133     200, 210, 210, 215, 230, 240, 230, 215,  210, 210, 200,  //-2
//  134     200, 210, 220, 220, 240, 260, 240, 220,  220, 210, 200,  //0
//  135     200, 210, 210, 215, 230, 240, 230, 215,  210, 210, 200,  //2
//  136     200, 205, 210, 210, 220, 230, 220, 210,  210, 205, 200,  //6
//  137     200, 200, 200, 210, 210, 220, 210, 210,  200, 200, 200,  //10
//  138     200, 200, 200, 205, 210, 210, 210, 205,  200, 200, 200   //15
//  139 };
//  140 */
//  141 //电机PID的P矩阵，依据是当前偏差devinow的绝对值的等级

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//  142 uint8 MotorPIDPMat[10] = 
MotorPIDPMat:
        DATA
        DC8 60, 65, 70, 70, 70, 75, 75, 80, 80, 80, 0, 0
//  143 {
//  144 60,65,70,70,70,
//  145 75,75,80,80,80
//  146 };
//  147 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  148 uint8 DoneFlag = 0;
DoneFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  149 uint8 QuadSpeedLevel = 0;    //编码器测量的实时速度的速度等级，10个等级，0最慢，9最快。
QuadSpeedLevel:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  150 uint8 SlopeCLevel = 0;        //斜率的绝对值的等级，6个等级，0最直，5最斜
SlopeCLevel:
        DS8 1
//  151 
//  152 //舵机

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  153 uint16 ServoPIDP = 0;                   //舵机PID选取的P值。
ServoPIDP:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  154 uint16 ServoPIDD = 0;                   //舵机PID选取的D值。
ServoPIDD:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//  155 uint32 ServoPIDInputVal = ServoPIDCen;            //实际输入到舵机的值
ServoPIDInputVal:
        DATA
        DC32 1730

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//  156 uint32 ServoPIDInputValOld = ServoPIDCen;         //上次输入到舵机的值
ServoPIDInputValOld:
        DATA
        DC32 1730

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  157 int32 ServoPIDInputValP = 0;            //实际输入到舵机的值的P分量
ServoPIDInputValP:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  158 int32 ServoPIDInputValD = 0;            //实际输入到舵机的值的D分量
ServoPIDInputValD:
        DS8 4
//  159 
//  160 //uint32 ServoPIDVal = ServoPIDCen;     //舵机PID控制后输入的值。
//  161 //电机
//  162 
//  163 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  164 uint32 SpeedTargetVal = 0;               //平均目标脉冲数。差速前。
SpeedTargetVal:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  165 uint32 SpeedLastTargetVal = 0;           //上次平均目标脉冲数。差速前。
SpeedLastTargetVal:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  166 uint16 SpeedTargetLeftVal = 0;           //左电机目标脉冲数。差速后。
SpeedTargetLeftVal:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  167 uint16 SpeedTargetRightVal = 0;          //右电机目标脉冲数。差速后。
SpeedTargetRightVal:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  168 uint16 SpeedLastTargetLeftVal = 0;       //上一次左电机目标脉冲数，差速后
SpeedLastTargetLeftVal:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  169 uint16 SpeedLastTargetRightVal = 0;      //上一次右电机目标脉冲数，差速后
SpeedLastTargetRightVal:
        DS8 2
//  170 

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//  171 uint16 SpeedPIDPVal = 25;                  //电机PID选取的P值
SpeedPIDPVal:
        DATA
        DC16 25

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//  172 uint16 SpeedPIDDVal = 65;                   //电机PID选取的D值
SpeedPIDDVal:
        DATA
        DC16 65

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  173 uint16 SpeedPIDIVal = 0;                 //电机PID选取的I值
SpeedPIDIVal:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  174 int32 speed_kp,speed_kd;
speed_kp:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
speed_kd:
        DS8 4
//  175 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  176 int32 SpeedLeftVal = 0;                //左电机实际输入的FTM值。
SpeedLeftVal:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  177 int32 SpeedRightVal = 0;               //右电机实际输入的FTM值。
SpeedRightVal:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  178 int32 SpeedLeftValP = 0;               //左电机实际输入的FTM值的P分量。
SpeedLeftValP:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  179 int32 SpeedLeftValD = 0;               //左电机实际输入的FTM值的D分量。
SpeedLeftValD:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  180 int32 SpeedRightValP = 0;              //右电机实际输入的FTM值的P分量。
SpeedRightValP:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  181 int32 SpeedRightValD = 0;              //右电机实际输入的FTM值的D分量。
SpeedRightValD:
        DS8 4
//  182 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  183 int16 temptempSpeedLeftVal;
temptempSpeedLeftVal:
        DS8 2
//  184 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  185 uint8 SpeedDiffGetSwitch =0;          //差速开关。1开启差速。0关闭差速。
SpeedDiffGetSwitch:
        DS8 1
//  186 
//  187 //速度策略选项

        SECTION `.data`:DATA:REORDER:NOROOT(0)
//  188 uint8 StrategyLoadSpeedIndex = 1;      //速度策略，1最佳，2高速，3低速。
StrategyLoadSpeedIndex:
        DATA
        DC8 1
//  189 
//  190 //坡道的给定速度，写在FLASH中，通过OLED修改。flash里面的乘以100才归算到统一单位

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  191 uint8 SpeedTargetValGryoResult = 0;
SpeedTargetValGryoResult:
        DS8 1
//  192 
//  193 //直角弯给定速度，写在FLASH中，通过OLED修改。flash里面的乘以100才归算到统一单位

        SECTION `.data`:DATA:REORDER:NOROOT(0)
//  194 uint8 SpeedTargetValAngle = 150;
SpeedTargetValAngle:
        DATA
        DC8 150
//  195 
//  196 //===================================舵机======================================
//  197 //////////////////////////////////舵机PID控制，后期需要放进PIT中断服务函数中

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  198 uint8 ServoPID(void)
//  199 { 
ServoPID:
        PUSH     {R3-R5,LR}
//  200   int32 temp,DeviFuse_fu;
//  201   uint8 DeviFuse_grade;
//  202   
//  203   DeviFuse = (DeviFuse*10 + DeviFuse_old*0)/10;
        LDR.W    R0,??DataTable2
        LDR      R0,[R0, #+0]
        MOVS     R1,#+10
        LDR.W    R2,??DataTable2_1
        LDR      R2,[R2, #+0]
        MOVS     R3,#+0
        MULS     R2,R3,R2
        MLA      R0,R1,R0,R2
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable2
        STR      R0,[R1, #+0]
//  204   DeviFuse_old = DeviFuse;
        LDR.W    R0,??DataTable2
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable2_1
        STR      R0,[R1, #+0]
//  205   
//  206   
//  207    
//  208   temp=AbsInt(DeviFuse);
        LDR.W    R0,??DataTable2
        LDR      R0,[R0, #+0]
        BL       AbsInt
//  209   
//  210 /*  if(temp > 45)
//  211   {
//  212     if(AbsInt(DeviFuse-DeviPre) > AbsInt(DeviPre)*0.2)
//  213     {
//  214         DeviFuse = (DeviFuse*3 + DeviPre*7)/10;
//  215     }
//  216   }*/
//  217   
//  218   if(temp<20)
        CMP      R0,#+20
        BGE.N    ??ServoPID_0
//  219   {
//  220      DeviFuse_grade=1;
        MOVS     R4,#+1
//  221      DeviFuse_fu=(temp-0)*750/(20-0);
        MOVW     R1,#+750
        MULS     R0,R1,R0
        MOVS     R1,#+20
        SDIV     R0,R0,R1
        B.N      ??ServoPID_1
//  222      //FTM0_C7V = 200;
//  223   }
//  224   else if(temp<30)
??ServoPID_0:
        CMP      R0,#+30
        BGE.N    ??ServoPID_2
//  225   {
//  226      DeviFuse_grade=2;
        MOVS     R4,#+2
//  227      DeviFuse_fu=(temp-20)*750/(30-20);
        SUBS     R0,R0,#+20
        MOVW     R1,#+750
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        B.N      ??ServoPID_1
//  228      //FTM0_C7V = 170;
//  229   }
//  230    else if(temp<40)
??ServoPID_2:
        CMP      R0,#+40
        BGE.N    ??ServoPID_3
//  231   {
//  232      DeviFuse_grade=3;
        MOVS     R4,#+3
//  233      DeviFuse_fu=(temp-30)*750/(40-30);
        SUBS     R0,R0,#+30
        MOVW     R1,#+750
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        B.N      ??ServoPID_1
//  234      //FTM0_C7V = 160;
//  235   }
//  236   else if(temp<50)
??ServoPID_3:
        CMP      R0,#+50
        BGE.N    ??ServoPID_4
//  237   {
//  238      DeviFuse_grade=4;
        MOVS     R4,#+4
//  239      DeviFuse_fu=(temp-40)*750/(50-40);
        SUBS     R0,R0,#+40
        MOVW     R1,#+750
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        B.N      ??ServoPID_1
//  240      //FTM0_C7V = 150;
//  241   }
//  242   else if(temp<60)
??ServoPID_4:
        CMP      R0,#+60
        BGE.N    ??ServoPID_5
//  243   {
//  244      DeviFuse_grade=5;
        MOVS     R4,#+5
//  245      DeviFuse_fu=(temp-50)*750/(60-50);
        SUBS     R0,R0,#+50
        MOVW     R1,#+750
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        B.N      ??ServoPID_1
//  246      //FTM0_C7V = 140;
//  247   }
//  248   else if(temp<80)
??ServoPID_5:
        CMP      R0,#+80
        BGE.N    ??ServoPID_6
//  249   {
//  250      DeviFuse_grade=6;
        MOVS     R4,#+6
//  251      DeviFuse_fu=(temp-60)*750/(80-60);
        SUBS     R0,R0,#+60
        MOVW     R1,#+750
        MULS     R0,R1,R0
        MOVS     R1,#+20
        SDIV     R0,R0,R1
        B.N      ??ServoPID_1
//  252      //FTM0_C7V = 120;
//  253   }
//  254    else if(temp<100)
??ServoPID_6:
        CMP      R0,#+100
        BGE.N    ??ServoPID_7
//  255   {
//  256      DeviFuse_grade=7;
        MOVS     R4,#+7
//  257       DeviFuse_fu=(temp-80)*750/(100-80);
        SUBS     R0,R0,#+80
        MOVW     R1,#+750
        MULS     R0,R1,R0
        MOVS     R1,#+20
        SDIV     R0,R0,R1
        B.N      ??ServoPID_1
//  258       //FTM0_C7V = 100;
//  259   }
//  260   else
//  261   {
//  262      DeviFuse_grade=7; 
??ServoPID_7:
        MOVS     R4,#+7
//  263      DeviFuse_fu=750;//1000;//修改过
        MOVW     R0,#+750
//  264      //FTM0_C7V = 100;
//  265   }
//  266   
//  267   ServoPIDP=(DeviFuse_fu*Steer_kp[DeviFuse_grade]+(750-DeviFuse_fu)*Steer_kp[DeviFuse_grade-1])/1000;
??ServoPID_1:
        LDR.N    R1,??DataTable2_2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRH     R1,[R1, R4, LSL #+1]
        MOVW     R2,#+750
        SUBS     R2,R2,R0
        LDR.N    R3,??DataTable2_2
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R3,R3,R4, LSL #+1
        LDRH     R3,[R3, #-2]
        MULS     R2,R3,R2
        MLA      R0,R1,R0,R2
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable2_3
        STRH     R0,[R1, #+0]
//  268   //P分量。
//  269   ServoPIDInputValP = ServoPIDP * DeviFuse / 10;
        LDR.N    R0,??DataTable2_3
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable2
        LDR      R1,[R1, #+0]
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable2_4
        STR      R0,[R1, #+0]
//  270   //D分量
//  271   
//  272   if((AbsInt(DeviFuse)-AbsInt(DeviPre))>=0)
        LDR.N    R0,??DataTable2
        LDR      R0,[R0, #+0]
        BL       AbsInt
        MOVS     R5,R0
        LDR.N    R0,??DataTable2_5
        LDR      R0,[R0, #+0]
        BL       AbsInt
        SUBS     R0,R5,R0
        CMP      R0,#+0
        BMI.N    ??ServoPID_8
//  273   {
//  274    ServoPIDD=ServoPIDDMat[DeviFuse_grade-1];
        LDR.N    R0,??DataTable2_6
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+1
        LDRH     R0,[R0, #-2]
        LDR.N    R1,??DataTable2_7
        STRH     R0,[R1, #+0]
        B.N      ??ServoPID_9
//  275   }
//  276   else
//  277   {
//  278   ServoPIDD=ServoPIDD2Mat[DeviFuse_grade-1];
??ServoPID_8:
        LDR.N    R0,??DataTable2_8
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R0,R4, LSL #+1
        LDRH     R0,[R0, #-2]
        LDR.N    R1,??DataTable2_7
        STRH     R0,[R1, #+0]
//  279   }
//  280   
//  281   
//  282   
//  283   ServoPIDInputValD=ServoPIDD*(DeviFuse-DeviPre);
??ServoPID_9:
        LDR.N    R0,??DataTable2_7
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable2
        LDR      R1,[R1, #+0]
        LDR.N    R2,??DataTable2_5
        LDR      R2,[R2, #+0]
        SUBS     R1,R1,R2
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable2_9
        STR      R0,[R1, #+0]
//  284   //记录上一次的输入值。
//  285   ServoPIDInputValOld = ServoPIDInputVal;
        LDR.N    R0,??DataTable2_10
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable2_11
        STR      R0,[R1, #+0]
//  286 
//  287   //新的输入值
//  288   ServoPIDInputVal = ServoPIDCen + ServoPIDInputValP + ServoPIDInputValD;
        LDR.N    R0,??DataTable2_4
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable2_9
        LDR      R1,[R1, #+0]
        ADDS     R0,R1,R0
        ADDW     R0,R0,#+1730
        LDR.N    R1,??DataTable2_10
        STR      R0,[R1, #+0]
//  289  
//  290   //滤波
//  291    ServoPIDInputVal = (ServoPIDInputValOld * 0 + ServoPIDInputVal * 10) / 10;
        LDR.N    R0,??DataTable2_11
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        LDR.N    R2,??DataTable2_10
        LDR      R2,[R2, #+0]
        MOVS     R3,#+10
        MULS     R2,R3,R2
        MLA      R0,R1,R0,R2
        MOVS     R1,#+10
        UDIV     R0,R0,R1
        LDR.N    R1,??DataTable2_10
        STR      R0,[R1, #+0]
//  292   /*
//  293    //舵机跳变限幅
//  294   if(ServoPIDInputVal>(ServoPIDInputValOld+70))
//  295   {
//  296     ServoPIDInputVal=ServoPIDInputValOld+70;
//  297   }
//  298   else if(ServoPIDInputVal<(ServoPIDInputValOld-70))
//  299   {
//  300     ServoPIDInputVal=ServoPIDInputValOld-70;
//  301   }
//  302   else
//  303   {
//  304    
//  305   }
//  306   */
//  307    
//  308   //针对障碍的打角限制
//  309   BrickSpeDealServor();
        BL       BrickSpeDealServor
//  310   
//  311   //针对十字的打角限制，以及修改偏差
//  312   if(ShiZhiFlag==1)
        LDR.N    R0,??DataTable2_12
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??ServoPID_10
//  313   {
//  314       if(ServoPIDInputVal >= (ServoPIDMax-ServoPIDCen)/5+ServoPIDCen)
        LDR.N    R0,??DataTable2_10
        LDR      R0,[R0, #+0]
        MOVW     R1,#+1806
        CMP      R0,R1
        BCC.N    ??ServoPID_11
//  315       {
//  316         ServoPIDInputVal = (ServoPIDMax-ServoPIDCen)/5+ServoPIDCen;
        MOVW     R0,#+1806
        LDR.N    R1,??DataTable2_10
        STR      R0,[R1, #+0]
        B.N      ??ServoPID_12
//  317       }
//  318       
//  319       else if(ServoPIDInputVal <= ServoPIDCen-(ServoPIDCen-ServoPIDMin)/5)
??ServoPID_11:
        LDR.N    R0,??DataTable2_10
        LDR      R0,[R0, #+0]
        MOVW     R1,#+1655
        CMP      R0,R1
        BCS.N    ??ServoPID_12
//  320       {
//  321         ServoPIDInputVal = ServoPIDCen-(ServoPIDCen-ServoPIDMin)/5;
        MOVW     R0,#+1654
        LDR.N    R1,??DataTable2_10
        STR      R0,[R1, #+0]
//  322       }
//  323       DeviFuse = 0;
??ServoPID_12:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable2
        STR      R0,[R1, #+0]
//  324   }
//  325    
//  326   //限幅。  
//  327   if(ServoPIDInputVal >= ServoPIDMax)
??ServoPID_10:
        LDR.N    R0,??DataTable2_10
        LDR      R0,[R0, #+0]
        MOVW     R1,#+2110
        CMP      R0,R1
        BCC.N    ??ServoPID_13
//  328   {
//  329     ServoPIDInputVal = ServoPIDMax;
        MOVW     R0,#+2110
        LDR.N    R1,??DataTable2_10
        STR      R0,[R1, #+0]
        B.N      ??ServoPID_14
//  330   }
//  331   
//  332   else if(ServoPIDInputVal <= ServoPIDMin)
??ServoPID_13:
        LDR.N    R0,??DataTable2_10
        LDR      R0,[R0, #+0]
        MOVW     R1,#+1351
        CMP      R0,R1
        BCS.N    ??ServoPID_14
//  333   {
//  334     ServoPIDInputVal = ServoPIDMin;
        MOVW     R0,#+1350
        LDR.N    R1,??DataTable2_10
        STR      R0,[R1, #+0]
//  335   }
//  336   
//  337   else
//  338   {
//  339     
//  340   } 
//  341 
//  342   //赋值给实际的舵机I/O口。
//  343   //FTM1_C0V = 2100;右打死
//  344   FTM1_C0V = (uint16)(2*ServoPIDCen-ServoPIDInputVal);
??ServoPID_14:
        MOVW     R0,#+3460
        LDR.N    R1,??DataTable2_10
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDR.W    R1,??DataTable3  ;; 0x40039010
        STR      R0,[R1, #+0]
//  345   return 1;
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}    ;; return
//  346 }
//  347 
//  348     
//  349 //======================================================================
//  350 //函数名：SpeedDiffGet
//  351 //功  能：左右电机的差速值计算。
//  352 //参  数：tempSpeedTarget预设速度值，num处理的电机编号0左1右
//  353 //返  回：tempSpeedTarget差速后的预设速度值
//  354 //影  响：
//  355 //说  明：1. MotorPID应该放在ServoPID后，即ServoPIDInputVal更新后。
//  356 //      
//  357 //             
//  358 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  359 uint16 SpeedDiffGet(uint16 tempSpeedTarget, uint8 num)
//  360 {
SpeedDiffGet:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  361   
//  362   //int32 DeltaVelocity;
//  363   //int32 ServoTemp = 0;
//  364   uint32 val;
//  365   
//  366   //舵机偏量的绝对值
//  367   ServoTemp = AbsInt(ServoPIDCen - ServoPIDInputVal);
        MOVW     R0,#+1730
        LDR.N    R1,??DataTable2_10
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        BL       AbsInt
        LDR.N    R1,??DataTable2_13
        STR      R0,[R1, #+0]
//  368  // DeltaVelocity = ((1000 * ServoTemp / 125) - (8 * ServoTemp * ServoTemp / 1000) + (71 * ServoTemp * ServoTemp * ServoTemp / 1000000))*30/10;//乘以目标速度转化成速度差,该值放大了10000倍
//  369   DeltaVelocity = ((1000 * ServoTemp / 125)  + (71 * ServoTemp * ServoTemp * ServoTemp / 1000000))*13/10;//乘以目标速度转化成速度差,该值放大了10000倍
        LDR.N    R0,??DataTable2_13
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        MOVS     R1,#+125
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable2_13
        LDR      R1,[R1, #+0]
        LDR.N    R2,??DataTable2_13
        LDR      R2,[R2, #+0]
        MULS     R1,R2,R1
        LDR.N    R2,??DataTable2_13
        LDR      R2,[R2, #+0]
        MULS     R1,R2,R1
        MOVS     R2,#+71
        MULS     R1,R2,R1
        LDR.W    R2,??DataTable3_1  ;; 0xf4240
        SDIV     R1,R1,R2
        ADDS     R0,R1,R0
        MOVS     R1,#+13
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_2
        STR      R0,[R1, #+0]
//  370   //DeltaVelocity=(70200*ServoTemp-0*ServoTemp*ServoTemp+15*ServoTemp*ServoTemp*ServoTemp/10-345000)/10000;
//  371  // DeltaVelocity=(70200*ServoTemp+2*ServoTemp*ServoTemp*ServoTemp)/10000;
//  372   //当前右转。
//  373   if(ServoPIDInputVal > ServoPIDCen)
        LDR.N    R0,??DataTable2_10
        LDR      R0,[R0, #+0]
        MOVW     R1,#+1731
        CMP      R0,R1
        BCC.N    ??SpeedDiffGet_0
//  374   {
//  375     //对左电机的处理，速度加大。
//  376     if(num == 0)
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??SpeedDiffGet_1
//  377     {    
//  378      val = tempSpeedTarget + (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDR.W    R1,??DataTable3_2
        LDR      R1,[R1, #+0]
        MULS     R0,R1,R0
        MOVW     R1,#+10000
        SDIV     R0,R0,R1
        UXTAH    R4,R4,R0
        B.N      ??SpeedDiffGet_2
//  379     }
//  380     //对右电机的处理，速度减小。
//  381     else
//  382     {
//  383       val = tempSpeedTarget - (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
??SpeedDiffGet_1:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDR.W    R1,??DataTable3_2
        LDR      R1,[R1, #+0]
        MULS     R0,R1,R0
        MOVW     R1,#+10000
        SDIV     R0,R0,R1
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        SUBS     R4,R4,R0
        B.N      ??SpeedDiffGet_2
//  384     }
//  385   }
//  386   //当前左转。
//  387   else if(ServoPIDInputVal < ServoPIDCen)
??SpeedDiffGet_0:
        LDR.N    R0,??DataTable2_10
        LDR      R0,[R0, #+0]
        MOVW     R1,#+1730
        CMP      R0,R1
        BCS.N    ??SpeedDiffGet_3
//  388   {
//  389     //对左电机的处理，速度减小。
//  390     if(num == 0)
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??SpeedDiffGet_4
//  391     {
//  392       val = tempSpeedTarget - (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDR.W    R1,??DataTable3_2
        LDR      R1,[R1, #+0]
        MULS     R0,R1,R0
        MOVW     R1,#+10000
        SDIV     R0,R0,R1
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        SUBS     R4,R4,R0
        B.N      ??SpeedDiffGet_2
//  393     }
//  394     //对右电机的处理，速度加大。
//  395     else
//  396     {
//  397       val = tempSpeedTarget + (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
??SpeedDiffGet_4:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDR.W    R1,??DataTable3_2
        LDR      R1,[R1, #+0]
        MULS     R0,R1,R0
        MOVW     R1,#+10000
        SDIV     R0,R0,R1
        UXTAH    R4,R4,R0
        B.N      ??SpeedDiffGet_2
//  398     }
//  399   }
//  400   //当前直走，不作任何处理。
//  401   else
//  402   {
//  403     //val = tempSpeedTarget;
//  404     val = tempSpeedTarget;
??SpeedDiffGet_3:
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
//  405   }  
//  406   
//  407   return val;
??SpeedDiffGet_2:
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        POP      {R1,R4,R5,PC}    ;; return
//  408 }
//  409 //特殊赛道时，平均目标速度的特殊处理。

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  410 uint32 SpeedTargetValSpePathDeal(uint32 temp)
//  411 {
//  412   uint32 val;
//  413   
//  414   //每次只允许有一种特殊赛道。
//  415   if(StopFlag == 1)
SpeedTargetValSpePathDeal:
        LDR.W    R1,??DataTable3_3
        LDRB     R1,[R1, #+0]
        CMP      R1,#+1
        BNE.N    ??SpeedTargetValSpePathDeal_0
//  416   {
//  417     val = 0;
        MOVS     R0,#+0
        B.N      ??SpeedTargetValSpePathDeal_1
//  418   }
//  419  /* else if(LightHouseWaitStopFlag != 0)
//  420   {
//  421     //val = SpeedTargetValWaitStop;
//  422     light_control(PORTA, 17, Light_ON);
//  423   }
//  424   //直角
//  425   else if(AngleConfirmLockFlag == 1)
//  426   {
//  427     //直角弯锁存等待时，减速处理。
//  428     //val = SpeedTargetValAngle;
//  429     light_control(PORTD, 15, Light_ON);
//  430   }*/
//  431   else if(BrickConfirmLockFlag == 1 || BrickSpeDealFlag == 1)
??SpeedTargetValSpePathDeal_0:
        LDR.W    R1,??DataTable3_4
        LDRB     R1,[R1, #+0]
        CMP      R1,#+1
        BEQ.N    ??SpeedTargetValSpePathDeal_2
        LDR.W    R1,??DataTable3_5
        LDRB     R1,[R1, #+0]
        CMP      R1,#+1
        BNE.N    ??SpeedTargetValSpePathDeal_3
//  432   {
//  433     val = SpeedBrick;
??SpeedTargetValSpePathDeal_2:
        LDR.W    R0,??DataTable3_6
        LDRH     R0,[R0, #+0]
        B.N      ??SpeedTargetValSpePathDeal_1
//  434   }
//  435   //上坡速度。大的话就飞过，小的话就贴着过。
//  436   else if(GyroResultFlag == 1)
??SpeedTargetValSpePathDeal_3:
        LDR.W    R1,??DataTable3_7
        LDRB     R1,[R1, #+0]
        CMP      R1,#+1
        BNE.N    ??SpeedTargetValSpePathDeal_4
//  437   {
//  438     val = SpeedTargetValGryoUp;
        LDR.W    R0,??DataTable3_8
        LDRH     R0,[R0, #+0]
        B.N      ??SpeedTargetValSpePathDeal_1
//  439   }
//  440   //下坡后的启动速度。
//  441   else if(GyroResultFlag == 2)
??SpeedTargetValSpePathDeal_4:
        LDR.W    R1,??DataTable3_7
        LDRB     R1,[R1, #+0]
        CMP      R1,#+2
        BNE.N    ??SpeedTargetValSpePathDeal_5
//  442   {
//  443     //若在坡上，则将平均目标脉冲数赋值为较小的值。
//  444     val = SpeedTargetValGryoResult;
        LDR.W    R0,??DataTable3_9
        LDRB     R0,[R0, #+0]
        B.N      ??SpeedTargetValSpePathDeal_1
//  445   }
//  446   //长直道
//  447   else if(PathRealStraightFlag == 1)
??SpeedTargetValSpePathDeal_5:
        LDR.W    R1,??DataTable3_10
        LDRB     R1,[R1, #+0]
        CMP      R1,#+1
        BNE.N    ??SpeedTargetValSpePathDeal_6
//  448   {
//  449     //长直道，速度加快。
//  450     val = SpeedTargetValStraight;
        LDR.W    R0,??DataTable3_11
        LDRH     R0,[R0, #+0]
        B.N      ??SpeedTargetValSpePathDeal_1
//  451   }
//  452   else if(xiaoZhiDaoFlag == 1)
??SpeedTargetValSpePathDeal_6:
        LDR.W    R1,??DataTable3_12
        LDRB     R1,[R1, #+0]
        CMP      R1,#+1
        BNE.N    ??SpeedTargetValSpePathDeal_7
//  453   {
//  454     val = SpeedXiaoZhiDao;
        LDR.W    R0,??DataTable3_13
        LDRH     R0,[R0, #+0]
        B.N      ??SpeedTargetValSpePathDeal_1
//  455       //val = temp;
//  456   }
//  457   //无特殊赛道，返回原值。
//  458   else
//  459   {
//  460     val = temp;
//  461   }
//  462   
//  463   return val;
??SpeedTargetValSpePathDeal_7:
??SpeedTargetValSpePathDeal_1:
        BX       LR               ;; return
//  464 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     DeviFuse

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     DeviFuse_old

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     Steer_kp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     ServoPIDP

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     ServoPIDInputValP

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     DeviPre

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     ServoPIDDMat

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     ServoPIDD

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_8:
        DC32     ServoPIDD2Mat

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_9:
        DC32     ServoPIDInputValD

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_10:
        DC32     ServoPIDInputVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_11:
        DC32     ServoPIDInputValOld

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_12:
        DC32     ShiZhiFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_13:
        DC32     ServoTemp
//  465     
//  466 
//  467 
//  468 //=========================电机========================================
//  469 //////////////////////////////////电机PID控制，后期需要放进PIT中断服务函数中

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  470 uint8 MotorPID(void)
//  471 {
MotorPID:
        PUSH     {R7,LR}
//  472   uint8 DeviFuseLevel;
//  473   uint8 i;
//  474   //uint8 j;     
//  475   int32 temp_speed_bias;
//  476   
//  477   
//  478   ErrorCountNow1++;  
        LDR.W    R0,??DataTable3_14
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable3_14
        STRH     R0,[R1, #+0]
//  479   //起飞未完成前，按起飞的速度控制。
//  480   if(MotorTakeOffFlag == 1)
        LDR.W    R0,??DataTable3_15
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.W    ??MotorPID_0
//  481   {
//  482     //偏差等级的获取
//  483     DeviFuseLevel = AbsInt(DeviFuse) / 10;
        LDR.W    R0,??DataTable3_16
        LDR      R0,[R0, #+0]
        BL       AbsInt
        MOVS     R1,#+10
        SDIV     R0,R0,R1
//  484     if(DeviFuseLevel > 8)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+9
        BLT.N    ??MotorPID_1
//  485     {
//  486       //偏差等级的修正
//  487       DeviFuseLevel = 9;
        MOVS     R0,#+9
//  488     }
//  489     else
//  490     { 
//  491       
//  492     }
//  493     
//  494     //模糊求取平均目标脉冲数
//  495     SpeedTargetVal = 0;
??MotorPID_1:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_17
        STR      R0,[R1, #+0]
//  496    
//  497     for(i = 0;i < 11; i++)
        MOVS     R0,#+0
        B.N      ??MotorPID_2
//  498     {
//  499 //      for(j=0;j <9 ;j++)
//  500 //      {
//  501 //         SpeedTargetVal += DeviFusemtr[i]*DeviFuse_dotmtr[j] * SpeedTargetMat[i][j]/1000;      
//  502 //      }
//  503       SpeedTargetVal += DeviFusemtr[i] * SpeedTargetMat[0][i]; 
??MotorPID_3:
        LDR.W    R1,??DataTable3_17
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable3_18
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDR.W    R3,??DataTable3_19
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRH     R3,[R3, R0, LSL #+1]
        MLA      R1,R3,R2,R1
        LDR.W    R2,??DataTable3_17
        STR      R1,[R2, #+0]
//  504     }
        ADDS     R0,R0,#+1
??MotorPID_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+11
        BLT.N    ??MotorPID_3
//  505     SpeedTargetVal = SpeedTargetVal/ 1000;
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        UDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_17
        STR      R0,[R1, #+0]
//  506     
//  507     
//  508     
//  509     //计算左电机应输入的值。
//  510     //储存为上一次左电机的目标速度
//  511     SpeedLastTargetLeftVal = SpeedTargetLeftVal;
        LDR.W    R0,??DataTable3_20
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_21
        STRH     R0,[R1, #+0]
//  512     //左电机差速
//  513     if(SpeedDiffGetSwitch == 1)
        LDR.W    R0,??DataTable3_22
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_4
//  514     {
//  515       SpeedTargetLeftVal = SpeedDiffGet(SpeedTargetVal, 0);   
        MOVS     R1,#+0
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       SpeedDiffGet
        LDR.W    R1,??DataTable3_20
        STRH     R0,[R1, #+0]
//  516       SpeedTargetLeftVal=(SpeedTargetLeftVal*9+SpeedLastTargetLeftVal*1)/10;
        LDR.W    R0,??DataTable3_20
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+9
        LDR.W    R2,??DataTable3_21
        LDRH     R2,[R2, #+0]
        MLA      R0,R1,R0,R2
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_20
        STRH     R0,[R1, #+0]
        B.N      ??MotorPID_5
//  517     }
//  518     else
//  519     {
//  520       SpeedTargetLeftVal = SpeedTargetVal;
??MotorPID_4:
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_20
        STRH     R0,[R1, #+0]
//  521       SpeedTargetLeftVal=(SpeedTargetLeftVal*9+SpeedLastTargetLeftVal*1)/10; 
        LDR.W    R0,??DataTable3_20
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+9
        LDR.W    R2,??DataTable3_21
        LDRH     R2,[R2, #+0]
        MLA      R0,R1,R0,R2
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_20
        STRH     R0,[R1, #+0]
//  522     }
//  523     //左电机P分量
//  524      temp_speed_bias=AbsInt (SpeedTargetLeftVal - SpeedNowLeft);
??MotorPID_5:
        LDR.W    R0,??DataTable3_20
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_23
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        BL       AbsInt
//  525     
//  526       speed_kd=SpeedPIDDVal;
        LDR.W    R0,??DataTable3_24
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_25
        STR      R0,[R1, #+0]
//  527       speed_kp=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_26
        STR      R0,[R1, #+0]
//  528      for(i = 0;i < 11; i++)
        MOVS     R0,#+0
        B.N      ??MotorPID_6
//  529     {
//  530       speed_kp += DeviFusemtr[i] * speedP_goal[i];      
??MotorPID_7:
        LDR.W    R1,??DataTable3_26
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable3_18
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDR.W    R3,??DataTable3_27
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRB     R3,[R0, R3]
        MLA      R1,R3,R2,R1
        LDR.W    R2,??DataTable3_26
        STR      R1,[R2, #+0]
//  531     }
        ADDS     R0,R0,#+1
??MotorPID_6:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+11
        BLT.N    ??MotorPID_7
//  532     speed_kp = speed_kp / 1000;
        LDR.W    R0,??DataTable3_26
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_26
        STR      R0,[R1, #+0]
//  533     SpeedPIDPVal=speed_kp;
        LDR.W    R0,??DataTable3_26
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_28
        STRH     R0,[R1, #+0]
//  534     //speed_kp=SpeedPIDPVal;        //修改过
//  535      SpeedLeftValP +=SpeedTargetLeftVal - SpeedNowLeft;
        LDR.W    R0,??DataTable3_29
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_20
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.W    R1,??DataTable3_23
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable3_29
        STR      R0,[R1, #+0]
//  536        //积分限幅
//  537     if(SpeedLeftValP>800)
        LDR.W    R0,??DataTable3_29
        LDR      R0,[R0, #+0]
        CMP      R0,#+800
        BLE.N    ??MotorPID_8
//  538     {
//  539       SpeedLeftValP=800;
        MOV      R0,#+800
        LDR.W    R1,??DataTable3_29
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_9
//  540     }
//  541     else if(SpeedLeftValP<-800)
??MotorPID_8:
        LDR.W    R0,??DataTable3_29
        LDR      R0,[R0, #+0]
        CMN      R0,#+800
        BGE.N    ??MotorPID_9
//  542     {
//  543        SpeedLeftValP=-800;
        LDR.W    R0,??DataTable3_30  ;; 0xfffffce0
        LDR.W    R1,??DataTable3_29
        STR      R0,[R1, #+0]
//  544     }
//  545     //左电机D分量
//  546     SpeedLeftValD +=  (SpeedTargetLeftVal - SpeedNowLeft) - (SpeedLastTargetLeftVal - SpeedLastLeft);
??MotorPID_9:
        LDR.W    R0,??DataTable3_31
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_20
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.W    R1,??DataTable3_23
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable3_21
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable3_32
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.W    R1,??DataTable3_31
        STR      R0,[R1, #+0]
//  547     
//  548     //左电机输入值。/////////////////////////////////////////////////增量式！！
//  549     SpeedLeftVal = (speed_kp*SpeedLeftValP +speed_kd* SpeedLeftValD*10)/100;
        LDR.W    R0,??DataTable3_26
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_29
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable3_25
        LDR      R2,[R2, #+0]
        LDR.W    R3,??DataTable3_31
        LDR      R3,[R3, #+0]
        MULS     R2,R3,R2
        MOVS     R3,#+10
        MULS     R2,R3,R2
        MLA      R0,R1,R0,R2
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_33
        STR      R0,[R1, #+0]
//  550    
//  551     //左电机输入值的限幅。
//  552     if(SpeedLeftVal >= MotorPIDMax)
        LDR.W    R0,??DataTable3_33
        LDR      R0,[R0, #+0]
        CMP      R0,#+500
        BLT.N    ??MotorPID_10
//  553     {
//  554       SpeedLeftVal = MotorPIDMax;
        MOV      R0,#+500
        LDR.W    R1,??DataTable3_33
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_11
//  555     }
//  556     else if(SpeedLeftVal <= MotorPIDMin)
??MotorPID_10:
        LDR.W    R0,??DataTable3_33
        LDR      R0,[R0, #+0]
        MVNS     R1,#+298
        CMP      R0,R1
        BGE.N    ??MotorPID_11
//  557     {
//  558       SpeedLeftVal = MotorPIDMin;
        LDR.W    R0,??DataTable3_34  ;; 0xfffffed4
        LDR.W    R1,??DataTable3_33
        STR      R0,[R1, #+0]
//  559     }
//  560     else
//  561     {
//  562       
//  563     }
//  564     
//  565       
//  566     //计算右电机应输入的值。
//  567     //储存为上一次右电机的目标速度
//  568     SpeedLastTargetRightVal = SpeedTargetRightVal;
??MotorPID_11:
        LDR.W    R0,??DataTable3_35
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_36
        STRH     R0,[R1, #+0]
//  569     //右电机差速
//  570     if(SpeedDiffGetSwitch == 1)
        LDR.W    R0,??DataTable3_22
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_12
//  571     {
//  572       SpeedTargetRightVal = SpeedDiffGet(SpeedTargetVal, 1);  
        MOVS     R1,#+1
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       SpeedDiffGet
        LDR.W    R1,??DataTable3_35
        STRH     R0,[R1, #+0]
//  573       SpeedTargetRightVal=(SpeedTargetRightVal*9+SpeedLastTargetRightVal*1)/10;
        LDR.W    R0,??DataTable3_35
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+9
        LDR.W    R2,??DataTable3_36
        LDRH     R2,[R2, #+0]
        MLA      R0,R1,R0,R2
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_35
        STRH     R0,[R1, #+0]
        B.N      ??MotorPID_13
//  574     }
//  575     else
//  576     {
//  577       SpeedTargetRightVal = SpeedTargetVal;
??MotorPID_12:
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_35
        STRH     R0,[R1, #+0]
//  578     }
//  579     
//  580       temp_speed_bias=AbsInt (SpeedTargetRightVal - SpeedNowRight);
??MotorPID_13:
        LDR.W    R0,??DataTable3_35
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_37
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        BL       AbsInt
//  581     
//  582     
//  583     speed_kd=SpeedPIDDVal;
        LDR.W    R0,??DataTable3_24
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_25
        STR      R0,[R1, #+0]
//  584     //右电机P分量
//  585     speed_kp=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_26
        STR      R0,[R1, #+0]
//  586     
//  587      for(i = 0;i < 11; i++)
        MOVS     R0,#+0
        B.N      ??MotorPID_14
//  588     {
//  589       speed_kp += DeviFusemtr[i] * speedP_goal[i];      
??MotorPID_15:
        LDR.W    R1,??DataTable3_26
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable3_18
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDR.W    R3,??DataTable3_27
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRB     R3,[R0, R3]
        MLA      R1,R3,R2,R1
        LDR.W    R2,??DataTable3_26
        STR      R1,[R2, #+0]
//  590     }
        ADDS     R0,R0,#+1
??MotorPID_14:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+11
        BLT.N    ??MotorPID_15
//  591     speed_kp = speed_kp / 1000;
        LDR.W    R0,??DataTable3_26
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_26
        STR      R0,[R1, #+0]
//  592     SpeedPIDPVal=speed_kp;
        LDR.W    R0,??DataTable3_26
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_28
        STRH     R0,[R1, #+0]
//  593     //speed_kp=SpeedPIDPVal;         //修改过
//  594     SpeedRightValP +=  SpeedTargetRightVal - SpeedNowRight;
        LDR.W    R0,??DataTable3_38
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_35
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.W    R1,??DataTable3_37
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable3_38
        STR      R0,[R1, #+0]
//  595 
//  596      //积分限幅
//  597     if(SpeedRightValP>800)
        LDR.W    R0,??DataTable3_38
        LDR      R0,[R0, #+0]
        CMP      R0,#+800
        BLE.N    ??MotorPID_16
//  598     {
//  599       SpeedRightValP=800;
        MOV      R0,#+800
        LDR.W    R1,??DataTable3_38
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_17
//  600     }
//  601     else if(SpeedRightValP<-800)
??MotorPID_16:
        LDR.W    R0,??DataTable3_38
        LDR      R0,[R0, #+0]
        CMN      R0,#+800
        BGE.N    ??MotorPID_17
//  602     {
//  603        SpeedRightValP=-800;
        LDR.W    R0,??DataTable3_30  ;; 0xfffffce0
        LDR.W    R1,??DataTable3_38
        STR      R0,[R1, #+0]
//  604     }
//  605     //右电机D分量
//  606     SpeedRightValD +=   ((SpeedTargetRightVal - SpeedNowRight) - (SpeedLastTargetRightVal - SpeedLastRight));
??MotorPID_17:
        LDR.W    R0,??DataTable3_39
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_35
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.W    R1,??DataTable3_37
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable3_36
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable3_40
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.W    R1,??DataTable3_39
        STR      R0,[R1, #+0]
//  607     //右电机输入值。/////////////////////////////////////////////////增量式！！
//  608     SpeedRightVal = (speed_kp *SpeedRightValP/10 + speed_kd*SpeedRightValD);
        LDR.W    R0,??DataTable3_26
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_38
        LDR      R1,[R1, #+0]
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_25
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable3_39
        LDR      R2,[R2, #+0]
        MLA      R0,R2,R1,R0
        LDR.W    R1,??DataTable3_41
        STR      R0,[R1, #+0]
//  609     //右电机输入值的限幅。
//  610     if(SpeedRightVal >= MotorPIDMax)
        LDR.W    R0,??DataTable3_41
        LDR      R0,[R0, #+0]
        CMP      R0,#+500
        BLT.N    ??MotorPID_18
//  611     {
//  612       SpeedRightVal = MotorPIDMax;
        MOV      R0,#+500
        LDR.W    R1,??DataTable3_41
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_19
//  613     }
//  614     else if(SpeedRightVal <= MotorPIDMin)
??MotorPID_18:
        LDR.W    R0,??DataTable3_41
        LDR      R0,[R0, #+0]
        MVNS     R1,#+298
        CMP      R0,R1
        BGE.N    ??MotorPID_19
//  615     {
//  616       SpeedRightVal = MotorPIDMin;
        LDR.W    R0,??DataTable3_34  ;; 0xfffffed4
        LDR.W    R1,??DataTable3_41
        STR      R0,[R1, #+0]
//  617     }
//  618     else
//  619     {
//  620     }
//  621     
//  622     //两轮速度都超过起飞阈值后，就转为正常的电机PID控制。
//  623     if(SpeedNowLeft > MotorTakeOffQuadCountLimit)// && SpeedNowRight > MotorTakeOffQuadCountLimit
??MotorPID_19:
        LDR.W    R0,??DataTable3_42
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_23
        LDRH     R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??MotorPID_20
//  624     {
//  625       MotorTakeOffFlag = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_15
        STRB     R0,[R1, #+0]
        B.N      ??MotorPID_21
//  626     }
//  627     else
//  628     {
//  629       //没达到起飞脉冲数，则持续输出很高的速度。
//  630       SpeedLeftVal = MotorTakeOffNum;
??MotorPID_20:
        MOV      R0,#+500
        LDR.W    R1,??DataTable3_33
        STR      R0,[R1, #+0]
//  631       SpeedRightVal = MotorTakeOffNum;
        MOV      R0,#+500
        LDR.W    R1,??DataTable3_41
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_21
//  632     }
//  633     
//  634     
//  635     
//  636   }
//  637   //以下是起飞后的电机控制
//  638   else
//  639   {
//  640     //偏差等级的获取
//  641     DeviFuseLevel = AbsInt(DeviFuse) / 10;
??MotorPID_0:
        LDR.W    R0,??DataTable3_16
        LDR      R0,[R0, #+0]
        BL       AbsInt
        MOVS     R1,#+10
        SDIV     R0,R0,R1
//  642     if(DeviFuseLevel > 8)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+9
        BLT.N    ??MotorPID_22
//  643     {
//  644       //偏差等级的修正
//  645       DeviFuseLevel = 9;
        MOVS     R0,#+9
//  646     }
//  647     else
//  648     { 
//  649     }
//  650     
//  651     
//  652     //模糊求取平均目标脉冲数
//  653     SpeedTargetVal = 0;
??MotorPID_22:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_17
        STR      R0,[R1, #+0]
//  654 //    if(StopFlag==0)
//  655 //    {
//  656         for(i = 0;i < 11; i++)
        MOVS     R0,#+0
        B.N      ??MotorPID_23
//  657        {
//  658 //          for(j=0;j <9 ;j++)
//  659 //          {
//  660 //             SpeedTargetVal += DeviFusemtr[i]*DeviFuse_dotmtr[j] * SpeedTargetMat[i][j]/1000;      
//  661 //          } 
//  662          SpeedTargetVal += DeviFusemtr[i] * SpeedTargetMat[0][i]; 
??MotorPID_24:
        LDR.W    R1,??DataTable3_17
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable3_18
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDR.W    R3,??DataTable3_19
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRH     R3,[R3, R0, LSL #+1]
        MLA      R1,R3,R2,R1
        LDR.W    R2,??DataTable3_17
        STR      R1,[R2, #+0]
//  663         }
        ADDS     R0,R0,#+1
??MotorPID_23:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+11
        BLT.N    ??MotorPID_24
//  664        SpeedTargetVal = SpeedTargetVal / 1000;
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        UDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_17
        STR      R0,[R1, #+0]
//  665 //    }
//  666 //    else
//  667 //    {
//  668 //      //停车，目标速度置零
//  669 //    }
//  670 
//  671   
//  672     //特殊赛道时，平均目标速度的特殊处理。
//  673     SpeedTargetVal = SpeedTargetValSpePathDeal(SpeedTargetVal);
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        BL       SpeedTargetValSpePathDeal
        LDR.W    R1,??DataTable3_17
        STR      R0,[R1, #+0]
//  674     
//  675     //停车时的速度控制
//  676     if(StopLineControlFlag==1 && StopRealFlag==0)
        LDR.W    R0,??DataTable3_43
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_25
        LDR.W    R0,??DataTable3_44
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_25
//  677     {
//  678         if(StopLineSpeed == 0)
        LDR.W    R0,??DataTable3_45
        LDRH     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_26
//  679         {
//  680             StopLineSpeed = SpeedTargetVal - 10;
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        SUBS     R0,R0,#+10
        LDR.W    R1,??DataTable3_45
        STRH     R0,[R1, #+0]
//  681             StopLineSpeedControlPauseFlag = 1 - StopLineSpeedControlPauseFlag;
        LDR.W    R0,??DataTable3_46
        LDRB     R0,[R0, #+0]
        RSBS     R0,R0,#+1
        LDR.W    R1,??DataTable3_46
        STRB     R0,[R1, #+0]
        B.N      ??MotorPID_27
//  682         } 
//  683         else if(SpeedNowLeft < 50)
??MotorPID_26:
        LDR.W    R0,??DataTable3_23
        LDRH     R0,[R0, #+0]
        CMP      R0,#+50
        BGE.N    ??MotorPID_28
//  684         {
//  685             StopRealFlag = 1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_44
        STRB     R0,[R1, #+0]
//  686             StopLineSpeedControlPauseFlag = 1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable3_46
        STRB     R0,[R1, #+0]
        B.N      ??MotorPID_27
//  687         }
//  688         else
//  689         {
//  690             StopLineSpeed -= 10;
??MotorPID_28:
        LDR.W    R0,??DataTable3_45
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+10
        LDR.W    R1,??DataTable3_45
        STRH     R0,[R1, #+0]
//  691             if(StopLineSpeed<50)
        LDR.W    R0,??DataTable3_45
        LDRH     R0,[R0, #+0]
        CMP      R0,#+50
        BGE.N    ??MotorPID_29
//  692             {
//  693                 StopLineSpeed = 50;
        MOVS     R0,#+50
        LDR.W    R1,??DataTable3_45
        STRH     R0,[R1, #+0]
//  694             }
//  695             StopLineSpeedControlPauseFlag = 1 - StopLineSpeedControlPauseFlag;
??MotorPID_29:
        LDR.W    R0,??DataTable3_46
        LDRB     R0,[R0, #+0]
        RSBS     R0,R0,#+1
        LDR.W    R1,??DataTable3_46
        STRB     R0,[R1, #+0]
//  696         }
//  697         SpeedTargetVal = StopLineSpeed;
??MotorPID_27:
        LDR.W    R0,??DataTable3_45
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_17
        STR      R0,[R1, #+0]
//  698         //提前把驱动板的使能去掉，便于加反电压
//  699         FTM0_C4V = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_47  ;; 0x40038030
        STR      R0,[R1, #+0]
//  700         FTM0_C5V = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_48  ;; 0x40038038
        STR      R0,[R1, #+0]
//  701     }
//  702     
//  703     
//  704      //计算左电机应输入的值。
//  705     //储存为上一次左电机的目标速度
//  706     SpeedLastTargetLeftVal = SpeedTargetLeftVal;
??MotorPID_25:
        LDR.W    R0,??DataTable3_20
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_21
        STRH     R0,[R1, #+0]
//  707     //左电机差速
//  708     if(0)//if(SpeedDiffGetSwitch == 1)
//  709     {
//  710       SpeedTargetLeftVal = SpeedDiffGet(SpeedTargetVal, 0);   
//  711       SpeedTargetLeftVal=(SpeedTargetLeftVal*9+SpeedLastTargetLeftVal*1)/10;
//  712     }
//  713     else
//  714     {
//  715       SpeedTargetLeftVal = SpeedTargetVal;
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_20
        STRH     R0,[R1, #+0]
//  716       SpeedTargetLeftVal=(SpeedTargetLeftVal*9+SpeedLastTargetLeftVal*1)/10;
        LDR.W    R0,??DataTable3_20
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+9
        LDR.W    R2,??DataTable3_21
        LDRH     R2,[R2, #+0]
        MLA      R0,R1,R0,R2
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_20
        STRH     R0,[R1, #+0]
//  717     }
//  718     
//  719     //如果堵转的话就停下(需要编码器，刚开始做车的阶段关闭)
//  720     /*if(SpeedNowLeft<50)
//  721     {
//  722         StopFlagMaxCount++;
//  723         if(StopFlagMaxCount >= 12)
//  724         {
//  725            DuZhuanFlag = 1;
//  726         }
//  727     }
//  728     else
//  729     {
//  730         StopFlagMaxCount = 0;
//  731     }*/
//  732     
//  733     //左电机D分量
//  734     temp_speed_bias= SpeedTargetLeftVal - SpeedNowLeft;
        LDR.W    R0,??DataTable3_20
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_23
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
//  735      speed_kd=SpeedPIDDVal;
        LDR.W    R0,??DataTable3_24
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_25
        STR      R0,[R1, #+0]
//  736     
//  737     speed_kp=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_26
        STR      R0,[R1, #+0]
//  738      for(i = 0;i < 11; i++)
        MOVS     R0,#+0
        B.N      ??MotorPID_30
//  739     {
//  740       speed_kp += DeviFusemtr[i] * speedP_goal[i];      
??MotorPID_31:
        LDR.W    R1,??DataTable3_26
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable3_18
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDR.W    R3,??DataTable3_27
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRB     R3,[R0, R3]
        MLA      R1,R3,R2,R1
        LDR.W    R2,??DataTable3_26
        STR      R1,[R2, #+0]
//  741     }
        ADDS     R0,R0,#+1
??MotorPID_30:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+11
        BLT.N    ??MotorPID_31
//  742     speed_kp = speed_kp / 1000;
        LDR.W    R0,??DataTable3_26
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_26
        STR      R0,[R1, #+0]
//  743     
//  744 
//  745     speed_kp=SpeedPIDPVal;
        LDR.W    R0,??DataTable3_28
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_26
        STR      R0,[R1, #+0]
//  746     SpeedLeftValP +=SpeedTargetLeftVal - SpeedNowLeft;
        LDR.W    R0,??DataTable3_29
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_20
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.W    R1,??DataTable3_23
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable3_29
        STR      R0,[R1, #+0]
//  747    
//  748       //积分限幅
//  749     if(SpeedLeftValP>800)
        LDR.W    R0,??DataTable3_29
        LDR      R0,[R0, #+0]
        CMP      R0,#+800
        BLE.N    ??MotorPID_32
//  750     {
//  751       SpeedLeftValP=800;
        MOV      R0,#+800
        LDR.W    R1,??DataTable3_29
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_33
//  752     }
//  753     else if(SpeedLeftValP<-800)
??MotorPID_32:
        LDR.W    R0,??DataTable3_29
        LDR      R0,[R0, #+0]
        CMN      R0,#+800
        BGE.N    ??MotorPID_33
//  754     {
//  755        SpeedLeftValP=-800;
        LDR.W    R0,??DataTable3_30  ;; 0xfffffce0
        LDR.W    R1,??DataTable3_29
        STR      R0,[R1, #+0]
//  756     }
//  757     
//  758     //左电机D分量
//  759     SpeedLeftValD +=  (SpeedTargetLeftVal - SpeedNowLeft) - (SpeedLastTargetLeftVal - SpeedLastLeft);
??MotorPID_33:
        LDR.W    R0,??DataTable3_31
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_20
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.W    R1,??DataTable3_23
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable3_21
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable3_32
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.W    R1,??DataTable3_31
        STR      R0,[R1, #+0]
//  760     
//  761     //左电机输入值。/////////////////////////////////////////////////增量式！！
//  762     SpeedLeftVal = (speed_kp*SpeedLeftValP +speed_kd* SpeedLeftValD*10)/100;
        LDR.W    R0,??DataTable3_26
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_29
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable3_25
        LDR      R2,[R2, #+0]
        LDR.W    R3,??DataTable3_31
        LDR      R3,[R3, #+0]
        MULS     R2,R3,R2
        MOVS     R3,#+10
        MULS     R2,R3,R2
        MLA      R0,R1,R0,R2
        MOVS     R1,#+100
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_33
        STR      R0,[R1, #+0]
//  763    
//  764     //左电机输入值的限幅。
//  765     if(SpeedLeftVal >= MotorPIDMax)
        LDR.W    R0,??DataTable3_33
        LDR      R0,[R0, #+0]
        CMP      R0,#+500
        BLT.N    ??MotorPID_34
//  766     {
//  767       SpeedLeftVal = MotorPIDMax;
        MOV      R0,#+500
        LDR.W    R1,??DataTable3_33
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_35
//  768     }
//  769     else if(SpeedLeftVal <= MotorPIDMin)
??MotorPID_34:
        LDR.W    R0,??DataTable3_33
        LDR      R0,[R0, #+0]
        MVNS     R1,#+298
        CMP      R0,R1
        BGE.N    ??MotorPID_35
//  770     {
//  771       SpeedLeftVal = MotorPIDMin;
        LDR.W    R0,??DataTable3_34  ;; 0xfffffed4
        LDR.W    R1,??DataTable3_33
        STR      R0,[R1, #+0]
//  772     }
//  773     else
//  774     {
//  775       
//  776     }
//  777 
//  778    
//  779       
//  780     //计算右电机应输入的值。
//  781     //储存为上一次右电机的目标速度
//  782     SpeedLastTargetRightVal = SpeedTargetRightVal;
??MotorPID_35:
        LDR.W    R0,??DataTable3_35
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_36
        STRH     R0,[R1, #+0]
//  783     //右电机差速
//  784     if(SpeedDiffGetSwitch == 1)
        LDR.W    R0,??DataTable3_22
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_36
//  785     {
//  786       SpeedTargetRightVal = SpeedDiffGet(SpeedTargetVal, 1);   
        MOVS     R1,#+1
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       SpeedDiffGet
        LDR.W    R1,??DataTable3_35
        STRH     R0,[R1, #+0]
//  787       SpeedTargetRightVal=(SpeedTargetRightVal*9+SpeedLastTargetRightVal*1)/10;
        LDR.W    R0,??DataTable3_35
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+9
        LDR.W    R2,??DataTable3_36
        LDRH     R2,[R2, #+0]
        MLA      R0,R1,R0,R2
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_35
        STRH     R0,[R1, #+0]
        B.N      ??MotorPID_37
//  788     }
//  789     else
//  790     {
//  791       SpeedTargetRightVal = SpeedTargetVal; 
??MotorPID_36:
        LDR.W    R0,??DataTable3_17
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_35
        STRH     R0,[R1, #+0]
//  792     }
//  793     //右电机P分量
//  794      temp_speed_bias=SpeedTargetRightVal - SpeedNowRight;
??MotorPID_37:
        LDR.W    R0,??DataTable3_35
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_37
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
//  795  
//  796     speed_kd=SpeedPIDDVal;
        LDR.W    R0,??DataTable3_24
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_25
        STR      R0,[R1, #+0]
//  797       speed_kp=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable3_26
        STR      R0,[R1, #+0]
//  798      for(i = 0;i < 11; i++)
        MOVS     R0,#+0
        B.N      ??MotorPID_38
//  799     {
//  800       speed_kp += DeviFusemtr[i] * speedP_goal[i];      
??MotorPID_39:
        LDR.W    R1,??DataTable3_26
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable3_18
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR      R2,[R2, R0, LSL #+2]
        LDR.W    R3,??DataTable3_27
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDRB     R3,[R0, R3]
        MLA      R1,R3,R2,R1
        LDR.W    R2,??DataTable3_26
        STR      R1,[R2, #+0]
//  801     }
        ADDS     R0,R0,#+1
??MotorPID_38:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+11
        BLT.N    ??MotorPID_39
//  802     speed_kp = speed_kp / 1000;
        LDR.W    R0,??DataTable3_26
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        LDR.W    R1,??DataTable3_26
        STR      R0,[R1, #+0]
//  803    
//  804       speed_kp=SpeedPIDPVal;
        LDR.W    R0,??DataTable3_28
        LDRH     R0,[R0, #+0]
        LDR.W    R1,??DataTable3_26
        STR      R0,[R1, #+0]
//  805      SpeedRightValP +=  SpeedTargetRightVal - SpeedNowRight;
        LDR.W    R0,??DataTable3_38
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable3_35
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.W    R1,??DataTable3_37
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.W    R1,??DataTable3_38
        STR      R0,[R1, #+0]
//  806 
//  807      //积分限幅
//  808     if(SpeedRightValP>800)
        LDR.W    R0,??DataTable3_38
        LDR      R0,[R0, #+0]
        CMP      R0,#+800
        BLE.N    ??MotorPID_40
//  809     {
//  810       SpeedRightValP=800;
        MOV      R0,#+800
        LDR.N    R1,??DataTable3_38
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_41
//  811     }
//  812     else if(SpeedRightValP<-800)
??MotorPID_40:
        LDR.N    R0,??DataTable3_38
        LDR      R0,[R0, #+0]
        CMN      R0,#+800
        BGE.N    ??MotorPID_41
//  813     {
//  814        SpeedRightValP=-800;
        LDR.N    R0,??DataTable3_30  ;; 0xfffffce0
        LDR.N    R1,??DataTable3_38
        STR      R0,[R1, #+0]
//  815     }
//  816     //右电机D分量
//  817     SpeedRightValD +=  ((SpeedTargetRightVal - SpeedNowRight) - (SpeedLastTargetRightVal - SpeedLastRight));
??MotorPID_41:
        LDR.N    R0,??DataTable3_39
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable3_35
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.N    R1,??DataTable3_37
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable3_36
        LDRH     R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable3_40
        LDRH     R1,[R1, #+0]
        UXTAH    R0,R0,R1
        LDR.N    R1,??DataTable3_39
        STR      R0,[R1, #+0]
//  818     //右电机输入值。/////////////////////////////////////////////////增量式！！
//  819     SpeedRightVal = (speed_kp *SpeedRightValP/10 + speed_kd*SpeedRightValD);
        LDR.N    R0,??DataTable3_26
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable3_38
        LDR      R1,[R1, #+0]
        MULS     R0,R1,R0
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable3_25
        LDR      R1,[R1, #+0]
        LDR.N    R2,??DataTable3_39
        LDR      R2,[R2, #+0]
        MLA      R0,R2,R1,R0
        LDR.N    R1,??DataTable3_41
        STR      R0,[R1, #+0]
//  820     
//  821     //右电机输入值的限幅。
//  822     if(SpeedRightVal >= MotorPIDMax)
        LDR.N    R0,??DataTable3_41
        LDR      R0,[R0, #+0]
        CMP      R0,#+500
        BLT.N    ??MotorPID_42
//  823     {
//  824       SpeedRightVal = MotorPIDMax;
        MOV      R0,#+500
        LDR.N    R1,??DataTable3_41
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_21
//  825     }
//  826     else if(SpeedRightVal <= MotorPIDMin)
??MotorPID_42:
        LDR.N    R0,??DataTable3_41
        LDR      R0,[R0, #+0]
        MVNS     R1,#+298
        CMP      R0,R1
        BGE.N    ??MotorPID_21
//  827     {
//  828       SpeedRightVal = MotorPIDMin;
        LDR.N    R0,??DataTable3_34  ;; 0xfffffed4
        LDR.N    R1,??DataTable3_41
        STR      R0,[R1, #+0]
//  829     }
//  830     else
//  831     {
//  832       
//  833     }
//  834 
//  835   }
//  836 
//  837       if(StopFlag == 1)   //确认完全停车后，输出为0
??MotorPID_21:
        LDR.N    R0,??DataTable3_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_43
//  838       {
//  839           //停车保险计数
//  840           StopFlagMaxCount++;
        LDR.N    R0,??DataTable3_49
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable3_49
        STRH     R0,[R1, #+0]
//  841           //int32 speed;//车的中心速度，两轮速度的平均值
//  842          //左右轮任何一个轮子速度低于某值，或到一定时间，则完全停车，停下电机。
//  843          if(SpeedNowLeft < 20 || SpeedNowRight < 20 || StopFlagMaxCount > StopFlagMaxCountNum * 6) //16ms进来一次，乘以6表示以0.1s为单位。
        LDR.N    R0,??DataTable3_23
        LDRH     R0,[R0, #+0]
        CMP      R0,#+20
        BLT.N    ??MotorPID_44
        LDR.N    R0,??DataTable3_37
        LDRH     R0,[R0, #+0]
        CMP      R0,#+20
        BLT.N    ??MotorPID_44
        LDR.N    R0,??DataTable3_50
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+6
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable3_49
        LDRH     R1,[R1, #+0]
        CMP      R0,R1
        BGE.N    ??MotorPID_43
//  844          {
//  845            StopRealFlag = 1;//完全停车，停下电机      
??MotorPID_44:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable3_44
        STRB     R0,[R1, #+0]
//  846          }
//  847          else
//  848          {      
//  849          }      
//  850       }
//  851       else
//  852       {
//  853       }  
//  854   
//  855       if(StopRealFlag == 0)
??MotorPID_43:
        LDR.N    R0,??DataTable3_44
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_45
//  856       {
//  857         if(StopLineCheckFlag==1 && DuZhuanFlag==0 && TimeOutFlag==0 && RunOutFlag==0 && StopLineControlFlag == 0)
        LDR.N    R0,??DataTable3_51
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_46
        LDR.N    R0,??DataTable3_52
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_46
        LDR.N    R0,??DataTable3_53
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_46
        LDR.N    R0,??DataTable3_54
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_46
        LDR.N    R0,??DataTable3_43
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_46
//  858         {
//  859             StopLineControlFlag = 1;LCD_CLS();LCD_P8x16Str(12,3,"StopLine");
        MOVS     R0,#+1
        LDR.N    R1,??DataTable3_43
        STRB     R0,[R1, #+0]
        BL       LCD_CLS
        LDR.N    R2,??DataTable3_55
        MOVS     R1,#+3
        MOVS     R0,#+12
        BL       LCD_P8x16Str
        B.N      ??MotorPID_45
//  860         }
//  861         else if(DuZhuanFlag==1 && StopLineCheckFlag==0 && TimeOutFlag==0 && RunOutFlag==0){StopRealFlag = 1;LCD_CLS();LCD_P8x16Str(12,3,"DuZhuan");}
??MotorPID_46:
        LDR.N    R0,??DataTable3_52
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_47
        LDR.N    R0,??DataTable3_51
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_47
        LDR.N    R0,??DataTable3_53
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_47
        LDR.N    R0,??DataTable3_54
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_47
        MOVS     R0,#+1
        LDR.N    R1,??DataTable3_44
        STRB     R0,[R1, #+0]
        BL       LCD_CLS
        LDR.N    R2,??DataTable3_56
        MOVS     R1,#+3
        MOVS     R0,#+12
        BL       LCD_P8x16Str
        B.N      ??MotorPID_45
//  862         else if(DuZhuanFlag==0 && StopLineCheckFlag==0 && TimeOutFlag==1 &&  RunOutFlag==0){StopRealFlag = 1;}
??MotorPID_47:
        LDR.N    R0,??DataTable3_52
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_48
        LDR.N    R0,??DataTable3_51
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_48
        LDR.N    R0,??DataTable3_53
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_48
        LDR.N    R0,??DataTable3_54
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_48
        MOVS     R0,#+1
        LDR.N    R1,??DataTable3_44
        STRB     R0,[R1, #+0]
        B.N      ??MotorPID_45
//  863         else if(DuZhuanFlag==0 && StopLineCheckFlag==0 && TimeOutFlag==0 &&  RunOutFlag==1){StopRealFlag = 1;LCD_CLS();LCD_P8x16Str(12,3,"RunOut");}
??MotorPID_48:
        LDR.N    R0,??DataTable3_52
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_45
        LDR.N    R0,??DataTable3_51
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_45
        LDR.N    R0,??DataTable3_53
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??MotorPID_45
        LDR.N    R0,??DataTable3_54
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_45
        MOVS     R0,#+1
        LDR.N    R1,??DataTable3_44
        STRB     R0,[R1, #+0]
        BL       LCD_CLS
        LDR.N    R2,??DataTable3_57
        MOVS     R1,#+3
        MOVS     R0,#+12
        BL       LCD_P8x16Str
//  864       }
//  865       if(StopRealFlag == 1)
??MotorPID_45:
        LDR.N    R0,??DataTable3_44
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_49
//  866       {
//  867         FTM0_C4V = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_47  ;; 0x40038030
        STR      R0,[R1, #+0]
//  868         FTM0_C5V = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_48  ;; 0x40038038
        STR      R0,[R1, #+0]
//  869         FTM0_C6V = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_58  ;; 0x40038040
        STR      R0,[R1, #+0]
//  870         FTM0_C7V = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable3_59  ;; 0x40038048
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_50
//  871       }
//  872       else
//  873       {
//  874         //赋值给电机实际对应的I/O口。
//  875         if(SpeedLeftVal>0)
??MotorPID_49:
        LDR.N    R0,??DataTable3_33
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??MotorPID_51
//  876         {
//  877          // FTM0_C4V = 100;
//  878          //FTM0_C5V = 100;
//  879          FTM0_C5V = 300;
        MOV      R0,#+300
        LDR.N    R1,??DataTable3_48  ;; 0x40038038
        STR      R0,[R1, #+0]
//  880          FTM0_C4V = 100;//SpeedLeftVal;
        MOVS     R0,#+100
        LDR.N    R1,??DataTable3_47  ;; 0x40038030
        STR      R0,[R1, #+0]
//  881     
//  882           if(StopLineSpeedControlPauseFlag == 1)
        LDR.N    R0,??DataTable3_46
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_52
//  883           {
//  884             FTM0_C4V = 1000;
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_47  ;; 0x40038030
        STR      R0,[R1, #+0]
//  885             FTM0_C5V = 1000;
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_48  ;; 0x40038038
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_52
//  886           }
//  887         }
//  888         else
//  889         {
//  890           
//  891          // FTM0_C4V = 100;
//  892          // FTM0_C5V = 100;
//  893           FTM0_C5V = 300;
??MotorPID_51:
        MOV      R0,#+300
        LDR.N    R1,??DataTable3_48  ;; 0x40038038
        STR      R0,[R1, #+0]
//  894           FTM0_C4V = 100;//0-SpeedLeftVal;          
        MOVS     R0,#+100
        LDR.N    R1,??DataTable3_47  ;; 0x40038030
        STR      R0,[R1, #+0]
//  895           if(StopLineSpeedControlPauseFlag == 1)
        LDR.N    R0,??DataTable3_46
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_52
//  896           {
//  897             FTM0_C4V = 1000;
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_47  ;; 0x40038030
        STR      R0,[R1, #+0]
//  898             FTM0_C5V = 1000;          
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_48  ;; 0x40038038
        STR      R0,[R1, #+0]
//  899           }
//  900         }
//  901         
//  902         if(SpeedRightVal>0)
??MotorPID_52:
        LDR.N    R0,??DataTable3_41
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??MotorPID_53
//  903         {
//  904              
//  905         // FTM0_C7V = 100;        
//  906          // FTM0_C6V = 100;
//  907           FTM0_C6V = 300;        
        MOV      R0,#+300
        LDR.N    R1,??DataTable3_58  ;; 0x40038040
        STR      R0,[R1, #+0]
//  908           FTM0_C7V = 100;//SpeedRightVal;
        MOVS     R0,#+100
        LDR.N    R1,??DataTable3_59  ;; 0x40038048
        STR      R0,[R1, #+0]
//  909           if(StopLineSpeedControlPauseFlag == 1)
        LDR.N    R0,??DataTable3_46
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_50
//  910           {
//  911             FTM0_C6V = 1000;
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_58  ;; 0x40038040
        STR      R0,[R1, #+0]
//  912             FTM0_C7V = 1000;
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_59  ;; 0x40038048
        STR      R0,[R1, #+0]
        B.N      ??MotorPID_50
//  913           }
//  914           //FTM0_C6V = SpeedRightVal;
//  915           //FTM0_C7V = 0;  
//  916         }
//  917         else
//  918         {
//  919              
//  920           //FTM0_C7V = 100;        
//  921          // FTM0_C6V = 100;
//  922          FTM0_C7V = 100;//0-SpeedRightVal;        
??MotorPID_53:
        MOVS     R0,#+100
        LDR.N    R1,??DataTable3_59  ;; 0x40038048
        STR      R0,[R1, #+0]
//  923           FTM0_C6V = 300;
        MOV      R0,#+300
        LDR.N    R1,??DataTable3_58  ;; 0x40038040
        STR      R0,[R1, #+0]
//  924           if(StopLineSpeedControlPauseFlag == 1)
        LDR.N    R0,??DataTable3_46
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??MotorPID_50
//  925           {
//  926             FTM0_C6V = 1000;
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_58  ;; 0x40038040
        STR      R0,[R1, #+0]
//  927             FTM0_C7V = 1000;
        MOV      R0,#+1000
        LDR.N    R1,??DataTable3_59  ;; 0x40038048
        STR      R0,[R1, #+0]
//  928           }
//  929           //FTM0_C6V = 0;
//  930           //FTM0_C7V = 0-SpeedRightVal;   
//  931         }
//  932       }
//  933   return 1;
??MotorPID_50:
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//  934 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     0x40039010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     0xf4240

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     DeltaVelocity

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     StopFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     BrickConfirmLockFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     BrickSpeDealFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     SpeedBrick

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     GyroResultFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_8:
        DC32     SpeedTargetValGryoUp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_9:
        DC32     SpeedTargetValGryoResult

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_10:
        DC32     PathRealStraightFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_11:
        DC32     SpeedTargetValStraight

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_12:
        DC32     xiaoZhiDaoFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_13:
        DC32     SpeedXiaoZhiDao

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_14:
        DC32     ErrorCountNow1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_15:
        DC32     MotorTakeOffFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_16:
        DC32     DeviFuse

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_17:
        DC32     SpeedTargetVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_18:
        DC32     DeviFusemtr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_19:
        DC32     SpeedTargetMat

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_20:
        DC32     SpeedTargetLeftVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_21:
        DC32     SpeedLastTargetLeftVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_22:
        DC32     SpeedDiffGetSwitch

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_23:
        DC32     SpeedNowLeft

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_24:
        DC32     SpeedPIDDVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_25:
        DC32     speed_kd

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_26:
        DC32     speed_kp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_27:
        DC32     speedP_goal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_28:
        DC32     SpeedPIDPVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_29:
        DC32     SpeedLeftValP

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_30:
        DC32     0xfffffce0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_31:
        DC32     SpeedLeftValD

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_32:
        DC32     SpeedLastLeft

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_33:
        DC32     SpeedLeftVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_34:
        DC32     0xfffffed4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_35:
        DC32     SpeedTargetRightVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_36:
        DC32     SpeedLastTargetRightVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_37:
        DC32     SpeedNowRight

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_38:
        DC32     SpeedRightValP

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_39:
        DC32     SpeedRightValD

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_40:
        DC32     SpeedLastRight

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_41:
        DC32     SpeedRightVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_42:
        DC32     MotorTakeOffQuadCountLimit

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_43:
        DC32     StopLineControlFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_44:
        DC32     StopRealFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_45:
        DC32     StopLineSpeed

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_46:
        DC32     StopLineSpeedControlPauseFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_47:
        DC32     0x40038030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_48:
        DC32     0x40038038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_49:
        DC32     StopFlagMaxCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_50:
        DC32     StopFlagMaxCountNum

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_51:
        DC32     StopLineCheckFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_52:
        DC32     DuZhuanFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_53:
        DC32     TimeOutFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_54:
        DC32     RunOutFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_55:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_56:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_57:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_58:
        DC32     0x40038040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_59:
        DC32     0x40038048

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_0:
        DATA
        DC8 "StopLine"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "DuZhuan"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "RunOut"
        DC8 0

        END
//  935 
//  936 
//  937 
//  938 
//  939 
//  940 
// 
//   105 bytes in section .bss
//   330 bytes in section .data
//    28 bytes in section .rodata
// 3 752 bytes in section .text
// 
// 3 752 bytes of CODE  memory
//    28 bytes of CONST memory
//   435 bytes of DATA  memory
//
//Errors: none
//Warnings: 1
