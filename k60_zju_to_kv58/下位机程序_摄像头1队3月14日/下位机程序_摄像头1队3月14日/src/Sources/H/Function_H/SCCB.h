#ifndef __SCCB_H__
#define __SCCB_H__
/******************************************************************************/
/*******************************************************************************
  文件名：SCCB通信底层库头文件SCCB.h
  功  能：SCCB通信
  日  期：2014.10.10
  作  者：LYX
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
#include "includes.h"

//2. 宏定义
#define ADDR_OV7725 0x42 //
#define ADDR_OV7620 0x42

#define SCCB_DELAY()    SCCBDelay(600)  //此处很重要，用以定义SCL线的频率，OV7725要求SCL线最高频率不超过400kHz

//SCL, SDA引脚的宏定义
#define SCLPORT_BASE_PTR PORTA_BASE_PTR //用于PORT_PCR_REG函数
#define SCLPT_BASE_PTR PTA_BASE_PTR    //用于GPIO_PDIR_REG函数
#define SCLPORT PORTA           //用于gpio_init函数
#define SCLPIN 26

#define SDAPORT_BASE_PTR PORTA_BASE_PTR
#define SDAPT_BASE_PTR PTA_BASE_PTR
#define SDAPORT PORTA
#define SDAPIN 25

//#define YeHuo_SCCB
//#define Demok_SCCB


//5. 函数声明
//extern uint8 SCCBReceiveByte(void);
//extern void SCCBSendByte(uint8 SendByte);
//extern uint8 SCCBWriteByteOne(uint16 WriteAddress, uint8 SendByte);
//extern uint8 SCCBReadByteOne(uint8 *pBuffer, uint16 length, uint8 ReadAddress);

extern void SCCBPortInit(void);
extern uint8 SCCBWriteByte(uint8 WriteAddress , uint8 SendByte);
extern uint8 SCCBReadByte(uint8 *pBuffer, uint16 length, uint8 ReadAddress);







#endif // end of __SCCB_H__