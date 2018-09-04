#ifndef _IMAGEGET_H
#define _IMAGEGET_H
/******************************************************************************/
/*******************************************************************************
  �ļ�����ͼ��ɼ�����ͷ�ļ�IamgeGet.h
  ��  �ܣ�ͼ��ɼ�
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
#include <stdio.h>
#include "common.h"
#include "CameraSet.h"
#include "vectors.h"
#include "ImagePro.h"
#include "Debug.h"

//2. �궨��
#define ImgNO1 1       //��ǰ����ͼ���־λ�궨�壬��1��ͼ��
#define ImgNO2 2       //��ǰ����ͼ���־λ�궨�壬��2��ͼ��

#define ModeFlagRun 0               //ģʽ��־���ܳ���
#define ModeFlagSend 1              //ģʽ��־����ͼ��

//4. ��������
extern uint8 ModeFlag;                    //ģʽ��־
extern uint8 ImgPresent;   //��ǰ����ͼ��ı�־λ
extern uint16 LineCount;          //��ǰ�ɼ����еļ���ֵ
extern uint16 LineRealCount;      //��ǰʵ�ʵ��еļ���ֵ;
//extern uint8 ImgNew[CameraHight][CameraRealWidth];       //������ͼ�����ݴ�������
extern uint8 ImgRaw[CameraHight][CameraWidth];           //Bģʽʱ��ͼ�����ݴ�������
//extern uint16 const LineRealCountVal[CameraHeight];  //��ǰʵ�ʵ��еĳ�ʼֵ

extern uint32 ErrorCountNow7;
extern uint32 ErrorCountNow8;

//5. ��������
//ͼ���ȡ����
extern void ImageGet(void);
//���жϷ�����,�½��ش����жϣ��ݶ�ΪPTD1
extern void FieldIsr(void);
//���жϷ�����,�����ش����жϣ��ݶ�ΪPTC8
extern void LineIsr(void);

#endif //end of _IMAGEGET_H 