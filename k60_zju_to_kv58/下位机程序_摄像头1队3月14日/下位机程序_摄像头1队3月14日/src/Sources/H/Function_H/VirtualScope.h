#ifndef __VirtualScope_H__
#define __VirtualScope_H__
/******************************************************************************/
/*******************************************************************************
  �ļ���������ʾ����H�ļ�VirtualScope.h
  ��  �ܣ�����ʾ��������ʵ��
  ��  �ڣ�2014.11.18
  ��  �ߣ�
  ��  ע��
*******************************************************************************/
/******************************************************************************/
//1. ͷ�ļ�
//2. �궨��
//3. �������Ͷ���
//4. ��������
//5. ��������

//1. ͷ�ļ�
#include "uart.h"
#include "common.h"
#include "ImagePro.h"
#include "RunControl.h"
#include "vectors.h"
#include "adc.h"
#include "LightHouse.h"
#include "Fuzzy.h"
#include "BatteryCheck.h"

//2. �궨��

#define UartDataNum 17


//4. ��������
//extern float VirtualOutData[4];
extern uint32 tic1;  //��ʱ����ʼ������¼��ʱ����ֵ��
extern uint32 toc1;  //��ʱ����ֹ������¼��ʱ����ֵ��
extern uint32 tic2;  //��ʱ����ʼ������¼��ʱ����ֵ��
extern uint32 toc2;  //��ʱ����ֹ������¼��ʱ����ֵ��
extern uint32 tic3;  //��ʱ����ʼ������¼��ʱ����ֵ��
extern uint32 toc3;  //��ʱ����ֹ������¼��ʱ����ֵ��
extern uint32 tic4;  //��ʱ����ʼ������¼��ʱ����ֵ��
extern uint32 toc4;  //��ʱ����ֹ������¼��ʱ����ֵ��
extern uint32 tic5;  //��ʱ����ʼ������¼��ʱ����ֵ��
extern uint32 toc5;  //��ʱ����ֹ������¼��ʱ����ֵ��
extern uint32 tic6;  //��ʱ����ʼ������¼��ʱ����ֵ��
extern uint32 toc6;  //��ʱ����ֹ������¼��ʱ����ֵ��
extern uint32 tic7;  //��ʱ����ʼ������¼��ʱ����ֵ��
extern uint32 toc7;  //��ʱ����ֹ������¼��ʱ����ֵ��


extern float VirtualOutData[4];

//5. ��������
extern void VirtualOutPut_Data(void);
extern void VirtualScopeSend(void);
extern void Virtual2DataPush(uint8 chanel,uint16 data);
extern void Virtual2Send(void);
extern void Virtual2SendData(void);

#endif // end of __VirtualScope_H__