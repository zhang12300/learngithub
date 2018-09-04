#ifndef __VirtualScope_H__
#define __VirtualScope_H__
/******************************************************************************/
/*******************************************************************************
  文件名：虚拟示波器H文件VirtualScope.h
  功  能：虚拟示波器功能实现
  日  期：2014.11.18
  作  者：
  备  注：
*******************************************************************************/
/******************************************************************************/
//1. 头文件
//2. 宏定义
//3. 变量类型定义
//4. 变量声明
//5. 函数声明

//1. 头文件
#include "uart.h"
#include "common.h"
#include "ImagePro.h"
#include "RunControl.h"
#include "vectors.h"
#include "adc.h"
#include "LightHouse.h"
#include "Fuzzy.h"
#include "BatteryCheck.h"

//2. 宏定义

#define UartDataNum 17


//4. 变量声明
//extern float VirtualOutData[4];
extern uint32 tic1;  //计时用起始数，记录定时器的值。
extern uint32 toc1;  //计时用终止数，记录定时器的值。
extern uint32 tic2;  //计时用起始数，记录定时器的值。
extern uint32 toc2;  //计时用终止数，记录定时器的值。
extern uint32 tic3;  //计时用起始数，记录定时器的值。
extern uint32 toc3;  //计时用终止数，记录定时器的值。
extern uint32 tic4;  //计时用起始数，记录定时器的值。
extern uint32 toc4;  //计时用终止数，记录定时器的值。
extern uint32 tic5;  //计时用起始数，记录定时器的值。
extern uint32 toc5;  //计时用终止数，记录定时器的值。
extern uint32 tic6;  //计时用起始数，记录定时器的值。
extern uint32 toc6;  //计时用终止数，记录定时器的值。
extern uint32 tic7;  //计时用起始数，记录定时器的值。
extern uint32 toc7;  //计时用终止数，记录定时器的值。


extern float VirtualOutData[4];

//5. 函数声明
extern void VirtualOutPut_Data(void);
extern void VirtualScopeSend(void);
extern void Virtual2DataPush(uint8 chanel,uint16 data);
extern void Virtual2Send(void);
extern void Virtual2SendData(void);

#endif // end of __VirtualScope_H__