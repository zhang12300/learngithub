//============================================================================
//�ļ����ƣ�hw_spi.h
//���ܸ�Ҫ��K60 SPI�ײ���������ͷ�ļ�
//��Ȩ���У����ݴ�ѧ��˼����Ƕ��ʽ����(sumcu.suda.edu.cn)
//============================================================================
#ifndef __SPI_H__
#define __SPI_H__

//1 ͷ�ļ�
#include "common.h"
#include "ff.h"
#include "ffconf.h"
#include "diskio.h"
#include "myprintp.h"
#include "gpio.h"

//2 �궨��
//����SPI�ں�
#define SPI_0 0
#define SPI_1 1
#define SPI_2 2

//�������ӻ�ģʽ
enum spimode
{
	MASTER,    //����ģʽ
	SLAVE     //����ģʽ
};

//SPI���ڵ�IRQ�жϺ�
#define SPI0IRQ 26
#define SPI1IRQ 27
#define SPI2IRQ 28

#define SPI_SPEED_LOW   0
#define SPI_SPEED_HIGH  1

//                ��·����: SPI0��SPI1����������
//                SPI0 ����   ����       ����       SPI1 ����   ����
//                PTA14  PCS0   --------------      PTE4   PCS0
//                PTA15  SCK    --------------      PTE2   SCK
//                PTA16  SOUT   --------------      PTE3   SIN
//                PTA17  SIN    --------------      PTE1   SOUT
//=========================================================================
//�������ƣ�hw_spi_init
//����������spiNo��SPIͨ���š�
//          Master:�Ƿ���������
//�������أ���
//���ܸ�Ҫ��SPI��ʼ����
//=========================================================================
//void hw_spi_init(uint8 spiNo,uint8 master);
void SPI_Configuration(void);
void SPI_SetSpeed(unsigned char SpeedSet);
//=========================================================================
//�������ƣ�hw_spi_send
//����������spiNo��SPIͨ���š�
//          data[]����Ҫ���͵����ݡ�
//          len�����ݳ��ȡ�
//�������أ���
//���ܸ�Ҫ��SPI�������ݡ�
//=========================================================================
//uint32 hw_spi_send(uint8 spiNo,uint8 data[],uint32 len);
uint32 SPI_ReadWriteByte(uint8 spiNo,unsigned char buffer);

//=========================================================================
//�������ƣ�hw_spi_re
//����������spiNo��SPIͨ���š�
//          data[]����Ҫ���յ����ݡ�
//�������أ�0���ɹ� 1��ʧ��
//���ܸ�Ҫ��SPI�������ݡ�
//=========================================================================
uint8 hw_spi_re(uint8 spiNo,uint8 data[]);

//=========================================================================
//�������ƣ�hw_spi_enable_re_int
//����˵����spiNo: SPI��
//�������أ� ��
//���ܸ�Ҫ����SPI�����ж�
//=========================================================================
void hw_spi_enable_re_int(uint8 spiNo);

//=========================================================================
//�������ƣ�hw_spi_disable_re_int
//����˵����spiNo: SPI��
//�������أ� ��
//���ܸ�Ҫ����SPI�����ж�
//=========================================================================
void hw_spi_disable_re_int(uint8 spiNo);

//void lqspiinit(void);
//void lqwrite(unsigned char cmd);


#endif //__SPI_H__
