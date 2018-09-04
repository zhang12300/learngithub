#ifndef _FTM_H
#define _FTM_H

/******************************************************************************/
/*******************************************************************************
  文件名：FTM模块H文件Ftm.h
  功  能：电机、舵机的PWM输出，编码器的输入捕捉。
  日  期：2014.11.04
  作  者：HJZ
  备  注：
*******************************************************************************/
/******************************************************************************/
//1. 头文件
//2. 宏定义
//3. 变量类型定义
//4. 变量声明
//5. 函数声明


#include "common.h"
#include "gpio.h"

extern uint16 speedOfCar;


//5. 函数声明
//extern void MotorControl(int32 motor_left,int32 motor_right);
extern void MotorInit_JYB(void);
extern void MotorInit_SYJ(void);
extern void QuadInit3(void);
extern void ServoInit(void);













#endif //end of _FTM_H