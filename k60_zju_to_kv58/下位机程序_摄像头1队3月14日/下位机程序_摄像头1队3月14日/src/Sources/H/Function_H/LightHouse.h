#ifndef __LightHouse_H__
#define __LightHouse_H__
/******************************************************************************/
/*******************************************************************************
  文件名：灯塔程序文件LightHouse.h
  功  能：灯塔处理
  日  期：2015.05.11
  作  者：HJZ
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
#include "vectors.h"
#include "gpio.h"
#include "MK60N512VMD100.h"

//2. 宏定义
//#define LightHouseWaitStopDelayCountLimit 5  //停车延时判断阈值，隔这么多个16ms才开始停车判断
#define LightHouseWaitStartGapCountLimit 3   //发车间隔计数阈值，每隔这么多次（不是16ms）就更新一次灯塔采集值



//3. 变量类型定义

//4. 变量声明
extern uint8 LightHouseStateR0;    //灯塔接收模块0的状态
extern uint8 LightHouseStateR1;    //灯塔接收模块1的状态
extern uint8 LightHouseOn2OffFlag;  //灯塔亮到暗的标志，从0到x变化，初始化为0.
extern uint8 LightHouseOff2OnFlag;  //灯塔暗到亮的标志，从0到x变化，初始化为0.
extern uint8 LightHouseWaitStopFlag;

extern uint16 LightHouseWaitStartMaxTime;         //以0.1s为单位，50代表5秒。这么多秒后，不管有没有检测到灯塔，直接发车。
extern uint16 LightHouseWaitStopDelayCountLimit;  //停车延时判断阈值，隔这么多个16ms才开始停车判断
extern uint16 LightHouseWaitStopGapCountLimit;   //停车间隔计数阈值，每隔这么多个16ms就更新一次灯塔采集值
extern uint16 LightHouseWaitStopOnCount;         //停车时的，亮持续计数
extern uint16 LightHouseWaitStopOnCountLimit;   //停车时的亮持续计数的阈值，与停车间隔计数有关，即亮度必须持续0.016*LightHouseWaitStopGapCountLimit*LightHouseWaitStopOnCountLimit秒。不需要太大。
extern uint16 LightHouseNoStopFlag;              //灯塔不停车标志，1开启这种模式，不根据灯塔停车，直接冲过去。0关闭这种模式，根据灯塔停车。
extern uint8 LightHouseWaitStopLockFlag;   //停车确认锁存标志位
extern uint8 LightHouseWaitStopDelayFlag;  //停车延时判断标志位


//5. 函数声明
extern uint8 LightHouseInit(void);
extern uint8 LightHouseStateUpdate(void);
extern uint8 LightHouseWaitStart(void);
extern uint8 LightHouseWaitStop(void);



#endif //end of __LightHouse_H__