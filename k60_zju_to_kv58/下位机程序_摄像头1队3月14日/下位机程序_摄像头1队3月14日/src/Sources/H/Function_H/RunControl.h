#ifndef __RunControl_H__
#define __RunControl_H__
/******************************************************************************/
/*******************************************************************************
  文件名：运动控制H件RunControl.h
  功  能：偏差求取，PID反馈，控制电机，控制舵机。
  日  期：2014.11.15
  作  者：HJZ & YCR
  备  注：
*******************************************************************************/
/******************************************************************************/
//1. 头文件
//2. 宏定义
//3. 变量类型定义
//4. 变量声明
//5. 函数声明

//1. 头文件
#include "common.h"
#include "gpio.h"
#include "Ftm.h"
#include "ImagePro.h" 
#include "VirtualScope.h"
#include "Fuzzy.h"

//2. 宏定义
//#define DeviNowEdgeLeft 60        //偏差小于-DeviNowEdgeLeft则认为是270度等大左弯
//#define DeviNowEdgeRight 60       //偏差大于DeviNowEdgeRight则认为是270度等大右弯

#define ServoPIDMax 2110            //舵机PID控制的最大值，右转
#define ServoPIDMin 1350            //舵机PID控制的最小值，左转
#define ServoPIDCen 1730             //舵机PID控制的中心值，直走。
#define ServoPIDInputValDLimitPercent 80  //舵机PID控制的D分量不能超过P分量的百分比

#define MotorPIDMax 500         //电机PID控制的最大值
#define MotorPIDMin (-300)             //电机PID控制的最小值
#define MotorTakeOffNum 500          //起飞控制时，两轮输出的FTM值。
//4. 变量声明
extern uint8 QuadSpeedLevel;
extern uint8 SlopeCLevel;


//电机



//6个局时变量全局化。
extern uint16 Steer_kp[8];

extern uint16 ServoPIDP;  //舵机PID的P值。
extern uint16 ServoPIDD;  //舵机PID的D值。
extern uint32 ServoPIDInputVal; //输入到舵机的值
extern int32 ServoPIDInputValP;   //舵机实际输入的值的P分量
extern int32 ServoPIDInputValD;   //舵机实际输入的值的D分量
extern uint32 ServoPIDInputValOld;//上次输入到舵机的值

extern uint32 SpeedTargetVal;              //电机目标速度，脉冲数。差速前。
extern uint32 SpeedLastTargetVal;
extern uint16 SpeedTargetLeftVal;          //左电机目标速度，脉冲数。差速后。
extern uint16 SpeedTargetRightVal;         //右电机目标速度，脉冲数。差速后。
extern uint16 SpeedLastTargetLeftVal;     //上一次左电机目标速度，脉冲数
extern uint16 SpeedLastTargetRightVal;    //上一次右电机目标速度，脉冲数

extern uint16 SpeedPIDPVal;                  //电机PID的P值
extern uint16 SpeedPIDDVal;                //电机PID的D值
extern uint16 SpeedPIDIVal;                //电机PID的I值

extern int32 SpeedLeftVal;                //左电机PID的值。
extern int32 SpeedRightVal;               //右电机PID的值。
extern int32 SpeedLeftValP;                //左电机P分量
extern int32 SpeedLeftValD;                //左电机D分量
extern int32 SpeedRightValP;                //右电机P分量
extern int32 SpeedRightValD;                //右电机D分量
extern uint8 MotorTakeOffFlag;   //起飞控制标志位，1未起飞，0已起飞。初始化为未起飞。



extern uint8 StopFlag;       // 停车标志，1表示停车
extern uint8 TimeOutFlag;



extern int32 speed_kp,speed_kd;
extern uint16 ServoPIDPMat[15];
extern uint16 ServoPIDDMat[7];
extern uint16 ServoPIDD2Mat[7];

extern int32 DeltaVelocity;
extern int32 ServoTemp;

extern int16 ErrorCountNow0;
extern int16 ErrorCountNow1;

extern int16 temptempSpeedLeftVal;

extern uint8 StrategyLoadSpeedIndex;      //速度策略，1最佳，2高速，3低速。
extern uint8 SpeedTargetValGryoResult;    //坡道的给定速度
extern uint8 SpeedTargetValAngle;         //直角弯的给定速度
extern uint16 SpeedBrick;

extern uint16 MotorTakeOffQuadCountLimit; //起飞控制时，转为正常电机PID控制前两轮编码器需要达到的脉冲数。
extern uint16 SpeedStrategyChosen;     //速度策略的档位，1~5，1档最慢，5档最快。
extern uint16 SpeedTargetValStraight;      //长直道给定速度。

extern uint8 StopRealFlag;     //绝对停止标志。1表示绝对停止，电机一定输出0。
extern uint16 SpeedTargetValWaitStop;     //灯塔等待停车速度。20代表2m/s。
extern uint16 StopFlagMaxCountNum;      //停车标志置位后，停车计数阈值，大于该值后，最终停车标志置位。1个单位是0.1秒。 
extern uint16 SpeedTargetValGryoUp;  //上坡速度。
extern uint16 SpeedXiaoZhiDao;

extern uint16 SpeedTargetMat[9][11];

extern uint8 StopLineSpeedControlPauseFlag;



//5. 函数声明
extern void SportControl(uint8 ImageProFlag);
extern uint8 ServoPID(void);
extern uint8 MotorPID(void);
extern uint8 StrategyLoadSpeed(void);


#endif // end of __RunControl_H__