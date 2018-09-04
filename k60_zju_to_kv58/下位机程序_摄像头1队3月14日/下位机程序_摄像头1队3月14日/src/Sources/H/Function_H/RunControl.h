#ifndef __RunControl_H__
#define __RunControl_H__
/******************************************************************************/
/*******************************************************************************
  �ļ������˶�����H��RunControl.h
  ��  �ܣ�ƫ����ȡ��PID���������Ƶ�������ƶ����
  ��  �ڣ�2014.11.15
  ��  �ߣ�HJZ & YCR
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
#include "Ftm.h"
#include "ImagePro.h" 
#include "VirtualScope.h"
#include "Fuzzy.h"

//2. �궨��
//#define DeviNowEdgeLeft 60        //ƫ��С��-DeviNowEdgeLeft����Ϊ��270�ȵȴ�����
//#define DeviNowEdgeRight 60       //ƫ�����DeviNowEdgeRight����Ϊ��270�ȵȴ�����

#define ServoPIDMax 2110            //���PID���Ƶ����ֵ����ת
#define ServoPIDMin 1350            //���PID���Ƶ���Сֵ����ת
#define ServoPIDCen 1730             //���PID���Ƶ�����ֵ��ֱ�ߡ�
#define ServoPIDInputValDLimitPercent 80  //���PID���Ƶ�D�������ܳ���P�����İٷֱ�

#define MotorPIDMax 500         //���PID���Ƶ����ֵ
#define MotorPIDMin (-300)             //���PID���Ƶ���Сֵ
#define MotorTakeOffNum 500          //��ɿ���ʱ�����������FTMֵ��
//4. ��������
extern uint8 QuadSpeedLevel;
extern uint8 SlopeCLevel;


//���



//6����ʱ����ȫ�ֻ���
extern uint16 Steer_kp[8];

extern uint16 ServoPIDP;  //���PID��Pֵ��
extern uint16 ServoPIDD;  //���PID��Dֵ��
extern uint32 ServoPIDInputVal; //���뵽�����ֵ
extern int32 ServoPIDInputValP;   //���ʵ�������ֵ��P����
extern int32 ServoPIDInputValD;   //���ʵ�������ֵ��D����
extern uint32 ServoPIDInputValOld;//�ϴ����뵽�����ֵ

extern uint32 SpeedTargetVal;              //���Ŀ���ٶȣ�������������ǰ��
extern uint32 SpeedLastTargetVal;
extern uint16 SpeedTargetLeftVal;          //����Ŀ���ٶȣ������������ٺ�
extern uint16 SpeedTargetRightVal;         //�ҵ��Ŀ���ٶȣ������������ٺ�
extern uint16 SpeedLastTargetLeftVal;     //��һ������Ŀ���ٶȣ�������
extern uint16 SpeedLastTargetRightVal;    //��һ���ҵ��Ŀ���ٶȣ�������

extern uint16 SpeedPIDPVal;                  //���PID��Pֵ
extern uint16 SpeedPIDDVal;                //���PID��Dֵ
extern uint16 SpeedPIDIVal;                //���PID��Iֵ

extern int32 SpeedLeftVal;                //����PID��ֵ��
extern int32 SpeedRightVal;               //�ҵ��PID��ֵ��
extern int32 SpeedLeftValP;                //����P����
extern int32 SpeedLeftValD;                //����D����
extern int32 SpeedRightValP;                //�ҵ��P����
extern int32 SpeedRightValD;                //�ҵ��D����
extern uint8 MotorTakeOffFlag;   //��ɿ��Ʊ�־λ��1δ��ɣ�0����ɡ���ʼ��Ϊδ��ɡ�



extern uint8 StopFlag;       // ͣ����־��1��ʾͣ��
extern uint8 TimeOutFlag;



extern int32 speed_kp,speed_kd;
extern uint16 ServoPIDPMat[15];
extern uint16 ServoPIDDMat[7];
extern uint16 ServoPIDD2Mat[7];

extern int32 DeltaVelocity;
extern int32 ServoTemp;

extern int16 ErrorCountNow0;
extern int16 ErrorCountNow1;

extern int16 temptempSpeedLeftVal;

extern uint8 StrategyLoadSpeedIndex;      //�ٶȲ��ԣ�1��ѣ�2���٣�3���١�
extern uint8 SpeedTargetValGryoResult;    //�µ��ĸ����ٶ�
extern uint8 SpeedTargetValAngle;         //ֱ����ĸ����ٶ�
extern uint16 SpeedBrick;

extern uint16 MotorTakeOffQuadCountLimit; //��ɿ���ʱ��תΪ�������PID����ǰ���ֱ�������Ҫ�ﵽ����������
extern uint16 SpeedStrategyChosen;     //�ٶȲ��Եĵ�λ��1~5��1��������5����졣
extern uint16 SpeedTargetValStraight;      //��ֱ�������ٶȡ�

extern uint8 StopRealFlag;     //����ֹͣ��־��1��ʾ����ֹͣ�����һ�����0��
extern uint16 SpeedTargetValWaitStop;     //�����ȴ�ͣ���ٶȡ�20����2m/s��
extern uint16 StopFlagMaxCountNum;      //ͣ����־��λ��ͣ��������ֵ�����ڸ�ֵ������ͣ����־��λ��1����λ��0.1�롣 
extern uint16 SpeedTargetValGryoUp;  //�����ٶȡ�
extern uint16 SpeedXiaoZhiDao;

extern uint16 SpeedTargetMat[9][11];

extern uint8 StopLineSpeedControlPauseFlag;



//5. ��������
extern void SportControl(uint8 ImageProFlag);
extern uint8 ServoPID(void);
extern uint8 MotorPID(void);
extern uint8 StrategyLoadSpeed(void);


#endif // end of __RunControl_H__