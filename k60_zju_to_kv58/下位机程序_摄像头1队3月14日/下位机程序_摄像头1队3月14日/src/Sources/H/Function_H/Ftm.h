#ifndef _FTM_H
#define _FTM_H

/******************************************************************************/
/*******************************************************************************
  �ļ�����FTMģ��H�ļ�Ftm.h
  ��  �ܣ�����������PWM����������������벶׽��
  ��  �ڣ�2014.11.04
  ��  �ߣ�HJZ
  ��  ע��
*******************************************************************************/
/******************************************************************************/
//1. ͷ�ļ�
//2. �궨��
//3. �������Ͷ���
//4. ��������
//5. ��������


#include "common.h"
#include "gpio.h"

extern uint16 speedOfCar;


//5. ��������
//extern void MotorControl(int32 motor_left,int32 motor_right);
extern void MotorInit_JYB(void);
extern void MotorInit_SYJ(void);
extern void QuadInit3(void);
extern void ServoInit(void);













#endif //end of _FTM_H