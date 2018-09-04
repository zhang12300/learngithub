/******************************************************************************/
/*******************************************************************************
  文件名：电池检查BatteryCheck.c
  功  能：电池电压检测
  日  期：2015.07.14
  作  者：HJZ
  备  注：
*******************************************************************************/
/******************************************************************************/

#include "BatteryCheck.h"

uint16 BatteryCheckVal;   //电池电压AD采样值

//电池电压检测初始化
//准备用一次函数来拟合。电池电压首先要看运动过程中是否平稳，其次要看最低值是否低于危险值。
uint8 BatteryCheckInit(void)
{
  //ADC0_SE18   <->   PTE25
  PORT_PCR_REG(PORTE_BASE_PTR, 25) |= (0|PORT_PCR_MUX(0));
  
  return 1;
}


//电池电压测量值更新
//准备用一次函数来拟合。电池电压首先要看运动过程中是否平稳，其次要看最低值是否低于危险值。
uint8 BatteryCheckUpdate(void)
{
  BatteryCheckVal = hw_ad_mid(0, 18, 16);
  
  BatteryCheckVal = 0 - BatteryCheckVal;
  
  BatteryCheckVal = BatteryCheckVal / 1000;
  
  return 1;
}
