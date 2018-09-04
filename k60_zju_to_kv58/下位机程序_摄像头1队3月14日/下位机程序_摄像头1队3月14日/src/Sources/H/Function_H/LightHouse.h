#ifndef __LightHouse_H__
#define __LightHouse_H__
/******************************************************************************/
/*******************************************************************************
  �ļ��������������ļ�LightHouse.h
  ��  �ܣ���������
  ��  �ڣ�2015.05.11
  ��  �ߣ�HJZ
  ��  ע��
*******************************************************************************/
/******************************************************************************/
//1. ͷ�ļ�
//2. �궨��
//3. �������Ͷ���
//4. ��������
//5. ��������

//1. ͷ�ļ�
#include "common.h"
#include "vectors.h"
#include "gpio.h"
#include "MK60N512VMD100.h"

//2. �궨��
//#define LightHouseWaitStopDelayCountLimit 5  //ͣ����ʱ�ж���ֵ������ô���16ms�ſ�ʼͣ���ж�
#define LightHouseWaitStartGapCountLimit 3   //�������������ֵ��ÿ����ô��Σ�����16ms���͸���һ�ε����ɼ�ֵ



//3. �������Ͷ���

//4. ��������
extern uint8 LightHouseStateR0;    //��������ģ��0��״̬
extern uint8 LightHouseStateR1;    //��������ģ��1��״̬
extern uint8 LightHouseOn2OffFlag;  //�����������ı�־����0��x�仯����ʼ��Ϊ0.
extern uint8 LightHouseOff2OnFlag;  //�����������ı�־����0��x�仯����ʼ��Ϊ0.
extern uint8 LightHouseWaitStopFlag;

extern uint16 LightHouseWaitStartMaxTime;         //��0.1sΪ��λ��50����5�롣��ô����󣬲�����û�м�⵽������ֱ�ӷ�����
extern uint16 LightHouseWaitStopDelayCountLimit;  //ͣ����ʱ�ж���ֵ������ô���16ms�ſ�ʼͣ���ж�
extern uint16 LightHouseWaitStopGapCountLimit;   //ͣ�����������ֵ��ÿ����ô���16ms�͸���һ�ε����ɼ�ֵ
extern uint16 LightHouseWaitStopOnCount;         //ͣ��ʱ�ģ�����������
extern uint16 LightHouseWaitStopOnCountLimit;   //ͣ��ʱ����������������ֵ����ͣ����������йأ������ȱ������0.016*LightHouseWaitStopGapCountLimit*LightHouseWaitStopOnCountLimit�롣����Ҫ̫��
extern uint16 LightHouseNoStopFlag;              //������ͣ����־��1��������ģʽ�������ݵ���ͣ����ֱ�ӳ��ȥ��0�ر�����ģʽ�����ݵ���ͣ����
extern uint8 LightHouseWaitStopLockFlag;   //ͣ��ȷ�������־λ
extern uint8 LightHouseWaitStopDelayFlag;  //ͣ����ʱ�жϱ�־λ


//5. ��������
extern uint8 LightHouseInit(void);
extern uint8 LightHouseStateUpdate(void);
extern uint8 LightHouseWaitStart(void);
extern uint8 LightHouseWaitStop(void);



#endif //end of __LightHouse_H__