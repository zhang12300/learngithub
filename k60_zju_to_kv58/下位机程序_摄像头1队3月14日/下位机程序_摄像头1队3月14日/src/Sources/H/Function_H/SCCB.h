#ifndef __SCCB_H__
#define __SCCB_H__
/******************************************************************************/
/*******************************************************************************
  �ļ�����SCCBͨ�ŵײ��ͷ�ļ�SCCB.h
  ��  �ܣ�SCCBͨ��
  ��  �ڣ�2014.10.10
  ��  �ߣ�LYX
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
#include "gpio.h"
#include "includes.h"

//2. �궨��
#define ADDR_OV7725 0x42 //
#define ADDR_OV7620 0x42

#define SCCB_DELAY()    SCCBDelay(600)  //�˴�����Ҫ�����Զ���SCL�ߵ�Ƶ�ʣ�OV7725Ҫ��SCL�����Ƶ�ʲ�����400kHz

//SCL, SDA���ŵĺ궨��
#define SCLPORT_BASE_PTR PORTA_BASE_PTR //����PORT_PCR_REG����
#define SCLPT_BASE_PTR PTA_BASE_PTR    //����GPIO_PDIR_REG����
#define SCLPORT PORTA           //����gpio_init����
#define SCLPIN 26

#define SDAPORT_BASE_PTR PORTA_BASE_PTR
#define SDAPT_BASE_PTR PTA_BASE_PTR
#define SDAPORT PORTA
#define SDAPIN 25

//#define YeHuo_SCCB
//#define Demok_SCCB


//5. ��������
//extern uint8 SCCBReceiveByte(void);
//extern void SCCBSendByte(uint8 SendByte);
//extern uint8 SCCBWriteByteOne(uint16 WriteAddress, uint8 SendByte);
//extern uint8 SCCBReadByteOne(uint8 *pBuffer, uint16 length, uint8 ReadAddress);

extern void SCCBPortInit(void);
extern uint8 SCCBWriteByte(uint8 WriteAddress , uint8 SendByte);
extern uint8 SCCBReadByte(uint8 *pBuffer, uint16 length, uint8 ReadAddress);







#endif // end of __SCCB_H__