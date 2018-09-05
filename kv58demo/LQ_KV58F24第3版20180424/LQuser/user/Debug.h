#ifndef __DEBUG_H__
#define __DEBUG_H__
/******************************************************************************/
/*******************************************************************************
  �ļ����������ļ�Debug.h
  ��  �ܣ�OLED��ʾ��FLASH������д��
  ��  �ڣ�2015.03.13
  ��  �ߣ�HJZ
  ��  ע��
*******************************************************************************/
/******************************************************************************/
//1. ͷ�ļ�
#include "Ftm.h"
#include "common.h"
#include "Flash.h"
#include "LQ12864.h"
#include "ImagePro.h"
#include "RunControl.h"

//2. �궨��

#define DebugOLEDUpdateCountNum 20    //OLED��ˢ��Ƶ�ʿ��ƣ�DebugOLEDUpdateCountNum��16msˢ��һ�Ρ�

//���뿪��
#define SwitchNum 4                //���뿪�صĸ�����

//������
#define ButtonNum 6                 //�����ĸ�����
#define DebugButtonConfirmNum 10    //������ȷ�ϴ��������Ըı��С����Ӧ���١�
                                    //ͬʱҲ������OLED��ˢ��Ƶ�ʣ������ٴ�16ms����ˢ��һ�Ρ�ˢ��ʱ�����жϹرգ�ˢ�º�����

#define DebugScreenChosenModify 0    //����ѡ��Ϊ ����
#define DebugScreenChosenDisplay 1   //����ѡ��Ϊ ��ʾ

#define DebugDisplayPageNum 5         //��ʾ���棬ҳ��������

//������д
#define FlashSectorIndex 224           //������дʱ����ǰ��������š���Χ0~255��������������ռ�˳���Ŀռ䡣
#define FlashSectorSize 2048           //������дʱ�������Ĵ�С����оƬ�ͺ��йء�DN512��ʾ512KB����256��������ÿ������2k��С����2048.
#define FlashElementSize 4             //����д��ʱ������Ԫ�صĴ�С��һ��Ϊ4��byte.��4.

//3. �������Ͷ���
//4. ��������
extern uint8 DebugSwitchFlag[SwitchNum];    //���뿪�ر�־��
extern uint8 DebugButtonFlag[ButtonNum];    //������־��
extern uint16 TimeRealRun;                         //��ʱ��ʱ��ʱ�����ޡ���0.1sΪ��λ��
extern uint8 TimeRealRunFlag;                  //��ʱ�ܱ�־��0δ���꣬1�����ꡣ

//5. ��������
extern uint8 DebugInit(void);
extern uint8 DebugSwitchScan(void);
extern uint8 DebugDebug(void);
extern uint8 DebugButtonScan(void);
extern uint8 FlashWriteNow(uint32 tempsectorindex, uint32 num, uint32 tempelementsize, uint8 *pointeruint8);
extern uint8 FlashFinalWrite(void);



#endif // end of __DEBUG_H__