#ifndef __DMA_H__
#define __DMA_H__
/******************************************************************************/
/*******************************************************************************
  �ļ�����DMA�ײ��ͷ�ļ�CameraSet.h
  ��  �ܣ�DMA����
  ��  �ڣ�2014.10.09
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
#include "gpio.h"
#include "ImageGet.h"

//2. �궨��
#define DMACH00 0       //DMA����ͨ���궨��
#define DMACH01 1
#define DMACH02 2
#define DMACH03 3
#define DMACH04 4
#define DMACH05 5
#define DMACH06 6
#define DMACH07 7
#define DMACH08 8
#define DMACH09 9
#define DMACH10 10
#define DMACH11 11
#define DMACH12 12
#define DMACH13 13
#define DMACH14 14
#define DMACH15 15

#define DMASOURCE_PORTA 49 //DMA���ִ���Դ��ŵĺ궨��
#define DMASOURCE_PORTB 50
#define DMASOURCE_PORTC 51
#define DMASOURCE_PORTD 52
#define DMASOURCE_PORTE 53


#define GPIOB_DIR_ADDR 0x400FF050                //GPIOB_DIR�ľ��Ե�ַ�����VLQӢ���ֲ�P1744


//4. ��������
extern volatile uint8 DMAFlag;


//5. ��������

extern void DMAPORTInit(void);
//extern uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint32 DMA_Count, uint32 S_Addr, uint32 D_Addr);
extern uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint16 DMA_Count, uint32 S_Addr, uint32 D_Addr);
extern void enable_DMA_irq(uint8 DMAno);










#endif // end of __DMA_H__
































