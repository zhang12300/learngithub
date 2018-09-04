

//近行修改在本文件（.h）打星号的地方，约25行，远行修改在.c文件中


#ifndef __Fuzzy_H__
#define __Fuzzy_H__
/******************************************************************************/
/*******************************************************************************
  文件名：Fuzzy.h
  功  能：偏差处理，模糊控制
  日  期：2015.05.29
  作  者：YCR
  备  注：
*******************************************************************************/
/******************************************************************************/
//1. 头文件
//2. 宏定义
//3. 变量类型定义
//4. 变量声明
//5. 函数声明

//1. 头文件
#include "vectors.h"
#include "ImagePro.h"
//2. 宏定义

#define Fuzzy_Bias_MAX   200   //偏差最大值，待测
#define Row_diff   40     //求取偏差的时候row和head允许的最大差值，超过的话则认为bias无效
//多行控制
#define BlackControlLineLow 26   //多行控制时，基于的最根本的行。     //****************************表示近行，只需修改这一处
#define BlackControlLineFar 24    //多行控制时，基于的低处行。

//3. 变量类型定义

//4. 变量声明
extern uint16 SpeedLastLeft;                 //上一次左电机实时速度，对应300线编码器，最后转化成m/s并扩大了1000倍
extern uint16 SpeedLastRight;                //上一次右电机实时速度，对应300线编码器，最后转化成m/s并扩大了1000倍。
extern uint16 SpeedNowLeft;                //左电机实时速度，对应300线编码器，最后转化成m/s并扩大了1000倍
extern uint16 SpeedNowRight;               //右电机实时速度，对应300线编码器，最后转化成m/s并扩大了1000倍
extern int32 DeviFusemtr[11];             //偏差的隶属度
extern int32 DeviFuse_dotmtr[9];         //偏差变化率隶属度
extern int32 DeviFuse_dot;               //偏差的变化率
//5. 函数声明
extern uint8 SpeedRealTimeGet(void);
extern int32 BiasCal(int32 row);
extern uint8 DeviationFuse(void);
extern uint8 MtrGet(void);

#endif //end of __Fuzzy_H__