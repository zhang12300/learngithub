#ifndef __ImagePro_H__
#define __ImagePro_H__
/******************************************************************************/
/*******************************************************************************
  �ļ�����ͼ�������ͷ�ļ�IamgePro.h
  ��  �ܣ�ͼ����
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
#include "ImageGet.h"
#include "RunControl.h"
#include "math.h"

//2. �궨��
#define CameraRealWidth 250         //һ��ʵ��ȡ�����ص���
#define MaxValUint8 255             //�Զ������Чֵ
#define MaxValInt16 32767           //�Զ������Чֵ��
#define PhyCenterCol 125           //�������������У���ø�CameraRealWidth/2��ȣ�
//#define RoadWidth 166              //����������������ȣ�ֱ����ÿ�ж������ֵ��
#define RoadWidth 200

//#define TempHalfWidthVal 90           //�ݶ����������
#define TempHalfWidthVal 95           

#define BlackCenEdgeStartColLimitL 30   //ɨ����㶨λ�����߽�����
#define BlackCenEdgeStartColLimitR 220   //ɨ����㶨λ�����߽�����

//��������
#define PathTypeUnknown     0            //�������ͣ�δ֪
#define PathTypeStraight    1            //�������ͣ�ֱ��
#define PathTypeLeft        2            //�������ͣ�����
#define PathTypeRight       3            //�������ͣ�����
#define PathTypeAngleL      4            //�������ͣ���ֱ��
#define PathTypeAngleR      5            //�������ͣ���ֱ��
#define PathTypeSmallSL     6            //�������ͣ���S,��Z���Ρ�
#define PathTypeSmallSR     7            //�������ͣ���S,Z���Ρ�
#define PathBrickLeft       8            //�������ͣ����ϰ�
#define PathBrickRight      9            //�������ͣ����ϰ�
#define PathAngleZone       10           //�������ͣ�ֱ�Ǻ�ɫ����

#define PathJudgeStraightSlopeLimit 2100   //���������ж�ʱ��ֱ��С5��б�ʵ����ƣ�������2000���ڡ�
#define PathSmallSHeadLimit 10            //���������ж�ʱ��СS���ж�Ҫ�����ͷ�߶�Ҫ��ֵ
#define PathSmallSGapLine    3            //���������ж�ʱ��СS���ж�ʱ������������
#define PathJudgeNewStraightChoose 2     //�������ͣ�ֱ���ж�ʱ��
                                         //0��ʾ�ж�ֱ��Ҫ�õ����еĵ㣬��������ͷ���Ƚ��ϸ񣬻��Сֱ���жϳɹ��ʣ��������׽������������г�ֱ����
                                         //1��ʾ�ж�ֱ��ʱ������ͷ��ʼ�����е�10�У����жϡ�������ֱ���жϳɹ��ʣ������׽������������г�ֱ����
                                         //2��1�ĸĽ������ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
//������
#define CenterForwardLineNum 4           //�������������ǰ����ʱ������б�ʻ��ڵ�������

#define BlackStep1Size 48                 //������ȡ��1�׶ε���������
#define BlackMiddleLine 50                //С�ڸ��кŵ��У���Χ�ڵ�Ҫ������3���Ϊ2�㡣
#define BlackFarLine 40                   //С�ڸ��кŵ��У���Χ�ڵ�Ҫ������2���Ϊ1�㡣
#define BlackFarfarLine 20                //С�ڸ��кŵ��У�ֻҪ������Ͱ׵㣬��Ҫ����Χ�ڵ㡣
#define BlackCrossGapLine 12              //ʮ��·��ʱ����һ�κ��ߵ��ڶ��κ��������������Ĺ���ֵ��ԭ����12
#define BlackBackLineNum 4                //ʮ�������ʱ����С���˷����ڵĵ�����
#define BlackCrossConfirmNum 4        //ʮ����ǰȷ�ϴ���ʱ����С���˷����ڵĵ���
#define BlackCrossConfirmWin 40     //ʮ����ǰȷ�ϴ���ʱ���������Ĵ�С��ԭ����40
#define LeastSquareMulti 1000        //��С���˷����Եı���
#define BlackLeftCrossStep3Multi 1000      //����ʮ�ּ���3�׶��Բ��ߴ���ʱ�����Եı���
#define BlackRightCrossStep3Multi 1000      //����ʮ�ּ���3�׶��Բ��ߴ���ʱ�����Եı���
#define BlackAgainForCrossFar10CutSwitch 1  //������ʮ���ټ�����Զ10��ɾ�����أ�1��ʾ��Զ10�е�ʮ���ټ��Ͳ�Ҫ�ˣ�0��ʾ�������⴦��
#define BlackCrossConfirmSlopeLimit 3000   //ʮ�ֲ���ȷ��ʱ����һ��ͼ��б�����ƣ�����̫��
#define BlackCrossConfirmHeadLineLimit 40  //ʮ�ֲ���ȷ��ʱ����һ��ͼ����ͷ���ƣ�����̫����

//ʮ����β
#define BlackLeftCrossTailRowLimit 50      //ʮ����βʱ����1�׶μ�����ͷ������С�ڸ�ֵʱ������������濪ʼʮ����β��⡣
#define BlackLeftCrossTailSlopeLimit 3400  //ʮ����βʱ����1��С���б�ʴ��ڸ�ֵʱ����ȷ��Ϊʮ����β������б���Ǹ�ֵ��
#define BlackRightCrossTailRowLimit 50      //ʮ����βʱ����1�׶μ�����ͷ������С�ڸ�ֵʱ������������濪ʼʮ����β��⡣
#define BlackRightCrossTailSlopeLimit 3400  //ʮ����βʱ����1��С���б�ʴ��ڸ�ֵʱ����ȷ��Ϊʮ����β������б������ֵ��




//��


//��
//����3���ؼ�ֵ��ʱ������ԣ��
#define LimitLeftWBMargin 20         //�ڰ����ص��ֵ��ԣ��
#define LimitLeftWMargin 40          //�׵��ԣ�ȣ��׵�Թ��ߵı仯�����У������ʵ��ſ�
#define LimitLeftBMargin 35           //�ڵ��ԣ��

#define BlackLeftWinVal 15           //�����������⺯���Ĵ��Ĵ�С
#define BlackLeftStep1ScanMinus 8    //��1�׶���ͷ����ʱ���������к��ߵĲ����������ֵ
//#define BlackLeftBackLineStart 12    //�����ʱ����ͷ����Ҫ���������С��������CameraHight-1-BlackControlLineBase����
#define BlackLeftBackLineStart 48
#define BlackLeftEdgeNum 3           //�����������ص�ʱ���������ĵ���
#define BlackLeftBackLineSlope 100   //����������ʱ�������ߵ�б�ʼ��ȷ�ϡ����Ͻ�Ϊԭ�㣬����Ϊx,����Ϊy.
#define BlackLeftCrossConfirmSlopeLimit 1100  //��ʮ���м䲹��ȷ��ʱ����б�ʵ�����
#define BlackLeftCrossConfirmGapLine 35      //��ʮ���м䲹��ʱ������������̫С���������ڵ��м������̫С�˻�270��ʮ�֣�̫���˻�����ʮ�ֳ�������

//��
//����3���ؼ�ֵ��ʱ������ԣ��
#define LimitRightWBMargin 20         //�ڰ����ص��ֵ��ԣ��
#define LimitRightWMargin 40          //�׵��ԣ�ȣ��׵�Թ��ߵı仯�����У������ʵ��ſ�
#define LimitRightBMargin 35           //�ڵ��ԣ��


#define BlackRightWinVal 15            //�����������⺯���Ĵ��Ĵ�С
#define BlackRightStep1ScanMinus 8    //��1�׶���ͷ����ʱ���������к��ߵĲ����������ֵ
//#define BlackRightBackLineStart 12    //�����ʱ����ͷ����Ҫ���������С��������CameraHight-1-BlackControlLineBase����
#define BlackRightBackLineStart 48
#define BlackRightEdgeNum 3           //���Ҽ�������ص�ʱ���������ĵ���
#define BlackRightBackLineSlope 100   //�Һ��������ʱ�������ߵ�б�ʼ��ȷ�ϡ����Ͻ�Ϊԭ�㣬����Ϊx,����Ϊy.
#define BlackRightCrossConfirmSlopeLimit 1100  //��ʮ���м䲹��ȷ��ʱ����б�ʵ�����
#define BlackRightCrossConfirmGapLine 35      //��ʮ���м䲹��ʱ������������̫С���������ڵ��м������̫С�˻�270��ʮ�֣�̫���˻�����ʮ�ֳ�������

#define DeviSelRowStart 30                //ƫ����ȡʱ��ѡ�����ʼ�С�
#define DeviSelRowEnd 55                //ƫ����ȡʱ��ѡ�����ֹ�С�
//DeviNow��ͨ�˲�ʱ������
///////////////////�޸Ĵ�ֵʱ��Ҫ�޸�DeviNowArrayWight��DeviNowArray����
#define DeviNowArrayNum 3

//����ͣ��
#define EmergencyStopCountNum 15       //ͼ����ʧ�������������ڸ�ֵʱ����ͣ���ȴ����硣125��16msԼΪ2s.
#define EmergencyStopSwitch 0           //����ͣ�����أ�1����0�ء���Ϊ����ͣ���Ļ������ѭ�������Բ�̫���á�

//ֱ�Ǻ�ɫ����
//�ж�
#define AngleZoneHeadLineNum 15     //ֱ�Ǻڿ飬��ͷ��С�ڸ�ֵ���ſ�ʼ�ж�ֱ�Ǻڿ顣
#define AngleZoneJudgeRowNear 50   //ֱ�Ǻڿ飬����ͷ����С�ڵ���
#define AngleZoneJudgeRowFar 14   //ֱ�Ǻڿ飬����ͷ������ڵ���
#define AngleJudgeSlopeRowNum 8        //ֱ�Ǻڿ飬б�ʼ�����ڵ�������
#define AngleZoneJudgeRowCom 2   //ֱ�Ǻڿ飬��С���˷�(��Ͱ�λ������Զ�λ����׼)����Ŀ�����е���ʼ�к���ֹ��ʱ�����м俿£������������
#define AngleZoneJudgeRowNum 5   //ֱ�Ǻڿ飬������ͷѡ�е�Ҫ�����е�������
#define AngleZoneJudgeRoadWidth 70 //ֱ�Ǻڿ飬ɨ����Ч��ʱĬ�ϵ�������ȡ�
#define AngleZoneJudgeBlackNumP 45  //ֱ�Ǻڿ飬���Ʊ�Ҫ�����Ч�ڵ����ٸ�����ȡ45�����ң����ϰ���
#define AngleZoneJudgeBlackNumN 20  //ֱ�Ǻڿ飬���Ʊ�Ҫ�����Ч�ڵ����ٸ�����ȡ20�����ң��ȵ��߿�ȶ�
//ȷ��
#define AngleZoneConfirmLockMeterCountLimit 40 //ֱ�Ǻڿ飬�������е��ۼӼ�����ֵ������ֱ�Ǻڿ����к�Ļָ�������
                                             //��2 m/s�ٶȣ���1�״����Ҫ0.5s��Ҳ����30��16ms��3m/s��Ӧ20��16ms.����Ӧȡ30�����ϡ��ٶȸ���ʱӦ��ȡ����
                                             //������ֱ�Ǻڿ�ǰһ�ξ���ͺ��п��ܱ������ˣ����Ծ��뱣��ֵ��Ӧ�üӳ���2m/sʱ��ȡ2m�ľ���ֵ60.
#define AngleZoneConfirmMatNum 6          //ֱ�Ǻڿ飬��־�洢����ĸ�����
//#define AngleZoneCheckColGapMin 48      //��ʼ�к���ֹ��֮�������ڵĿ�ȡ������м���������
                                        //1. ������ϰ����������45�У�Ҫ�ࡣ
                                        //2. Ҫ���ǵ�����ֱ��ʱ���е�������ȣ�����24��25����100�С�
                                        //3. Ҫ���ǵ���������������AngleZoneCheckRowCom��
                                        //4. Ҫ���ǵ����伴ֱ�Ǻڿ�ʱ�����ж�λ��ƫ����
                                        //Ҳ����˵��Ҫ����45�У�С��100-10*2=80�У�60�����ҡ�

//ֱ���䴦��
#define AngleConfirmMatNum 6          //ֱ�����־�洢����ĸ�����

///////�޸Ĵ�ֵ��ʱ��ע���޸�AngleSpeDealDeviNow��AngleSpeDealDeviNowLevel��AngleSpeDealSlopeC���������������
#define AngleSpeDealBackCountNum 15      //����ȷ��Ϊֱ�������൹����ô�����������ֱ��������⴦��
#define AngleWhiteAreaLimitVal 20       //ֱ�����ж���5����ɫ������ʱ������ıȰ�ɫ��ֵ�ٵ�ֵ��
#define AngleSpeDealStartHeadLine 40    //ֱ����ȷ�Ϻ󣬰�����ͷ���ڸ�ֵ�ſ�ʼ���⴦��
#define AngleSpeDealBackCountMin 8     //����Ҫ����AngleSpeDealBackCountMin��ǿ�ƿ��ơ�
#define AngelSpeDealExitSlope 3000     //б�ʾ���ֵС��AngelSpeDealExitSlope��Ҳ���԰ѿ���Ȩ������������ˡ�

//�ϰ�
#define BrickSpeDealBackCountNum 20      //����ȷ��Ϊ�ϰ�����൹����ô������������ϰ������⴦��
#define BrickConfirmMatNum 6          //�ϰ���־�洢����ĸ�����

#define BrickSpeDealStartJudgeRow 25   //�ϰ������ϰ������Խ�����У���������ƿ�ʼ��ȡֵ��Χ���Ϊ30-50����[BrickEndRow, CameraHight-BrickSlopeRowNum-1]
#define BrickSpeDealExitState1Val 65   //�ϰ����г��������ʱ����59���������С�ڸ�ֵ���ʾС����ǰ���ϰ�ƽ�С�
#define BrickSpeDealExitState2Val 75   //�ϰ����г��������ʱ����59�����������ڸ�ֵ���ʾС��ǰ���Ѿ�һ������Խ���ϰ���
//#define BrickSpeDealBias 8            //�ϰ����������ʱ��ƫ�Ƶ�����
#define BrickSpeDealCenChoose 0        //�ϰ�������ʱ�ο��ĺ�������ѡ��0δ���������飨��б�ģ���1����������飨����ֱ����

#define BrickEndRow 35            //�ϰ���ɨ����ʼ�У����С�����̫���Ա�֤����б�ʵĵ��㹻��
#define BrickHeadRow 15              //�ϰ���ɨ������У�Զ�С�Ҳ�Ƿ��ϰ�����ͷ����С�ڵ��С�
#define BrickScanColNum 60          //�ϰ���ɨ���������Ҫ��BrickLineBlackCountNum��������EndRow=30ʱ����Ӧ45��EndRow=35ʱ����Ӧ60��
#define BrickColCom 5               //�ϰ���ֱ�����εķ�ֱ�Ǳ������ĵ������У���ֹ�����Ϻڵ����Ч�ڵ����Ӱ�졣
#define BrickLineBlackCountNum 20   //�ϰ���������Ч������ڵĺڵ�����Ҫ��BrickScanColNum��һ��С��
#define BrickLineCountNum 3        //�ϰ�����Ч�д��ڸ������ж�Ϊ�ϰ���
#define BrickSlopeRowNum 8            //�ϰ���б�ʼ�����ڵ�������
#define BrickSpeDealServorLimit 30    //�ϰ�����������ڼ䣬�Զ����ǵ����ơ�


//���ߵذ崦��
#define SingleWhiteAvgNum 5            //�������Ұ׵�ȡ����ƽ��ֵʱ�����ڵ����ĵ�������̫�����ұ߽����п���С�ڸ�ֵ��
#define SingleAvgComVal 20             //�������Ұ׵�ȡ����ƽ��ֵʱ�����߲����ڴ˷�Χ�ڣ���Ϊ���ߣ������п����ǵذ塣
#define SingleFloorConfirmNum 2        //������֤�ذ�ʱ����֤�Ĵ�����
                                    
//б������
#define CurveStraightLimitL 30          //���������ж�ʱ��ͨ������������ж�����Ϊֱ������ֵ�������У��κ�Ӳ����ı�����ֶ��Ķ���ֵ��
#define CurveStraightLimitC 30          //���������ж�ʱ��ͨ�������������ж�����Ϊֱ������ֵ�������У��κ�Ӳ����ı�����ֶ��Ķ���ֵ��
#define CurveStraightLimitR 30          //���������ж�ʱ��ͨ���Һ��������ж�����Ϊֱ������ֵ�������У��κ�Ӳ����ı�����ֶ��Ķ���ֵ��
#define CurveGetCompen 2000             //������ȡʱ��Ϊ�˲�ʹ��̫С���˵Ĳ�������
#define SlopeLimitL 1500                //���������ж�ʱ������ߵ�б�ʵ���ֵ��
#define SlopeLimitC 1500                //���������ж�ʱ�������ߵ�б�ʵ���ֵ��
#define SlopeLimitR 1500                //���������ж�ʱ���Һ��ߵ�б�ʵ���ֵ��

//�������
#define BlackUdisFarLine 18            //���߻������ʱ��Զ�������м��еķֽ��С�
#define BlackUdisMiddleLine 38         //���߻������ʱ���м��кͽ����еķֽ��С�

//��б�ʼ��
//����б���������ֵ�������˶��б��ʮ�ֵ�ͼ�񣬷���������5500-10000֮�䣬������7000-8000.���Բ���5200.ʵ�����֣����ֵ��СS���ͼ�����н��١�
#define BlackLeftBigChangeSlopeLimit 4000   //��б�ʼ��ʱ��ǰ��б�ʲ����ֵ��    
#define BlackRightBigChangeSlopeLimit 4000   //��б�ʼ��ʱ��ǰ��б�ʲ����ֵ��


//�����⡣
#define BlackLeftRollSlopeLimit 2000         //�������ʱ������б�ʵ���ֵ������С��-BlackLeftRollSlopeLimit
#define BlackLeftRollLengthLimit 12          //�������ʱ�����߳��ȵ���ֵ������С��BlackLeftRollLengthLimit
#define BlackLeftRollSlopeRLimit 2000        //�������ʱ������б�ʵ���ֵ��Ҫ���ڸ�ֵ�����˶��270��ͼ�񣬷���ʵ����3500-4500֮�䡣
#define BlackRightRollSlopeLimit 2000        //�һ�����ʱ������б�ʵ���ֵ�����ܴ���BlackRightRollSlopeLimit
#define BlackRightRollLengthLimit 8         //�һ�����ʱ�����߳��ȵ���ֵ������С��BlackRightRollLengthLimit
#define BlackRightRollSlopeLLimit 2000       //�һ�����ʱ������б�ʵ���ֵ������ֵҪ���ڸ�ֵ�����˶��270��ͼ�񣬷���ʵ����3500-4500֮�䡣


//�������
#define RoadHalfWidthSingleLimit 75       //ͨ����������жϵ��ߴ���ʱ��ÿ����Ч˫�б�����ڵ��������ֵ��
#define RoadHalfWidthSingleGapLine 10     //ͨ����������жϵ��ߴ���ʱ����һ���������ȵ���ֵ�����������ù�С����Ȼ��Ӱ���������ߡ�
#define RoadHalfWidthLimitMin 70          //����������ʱ����Сֵ��
#define RoadHalfWidthLimitMax 100          //����������ʱ�����ֵ��


//���������ռ�⣨���ֱ�Ǻڿ飩
#define BlackBigChangeFinalCheckSwitch 1            //���������ռ�⿪��
#define BlackBigChangeFinalCheckSlopeLimit 2500 //5Slope����ǰ������ͬ���Ҳ�ֵ���ڵ������ֵʱ������ɾ������

//3. �������Ͷ���
typedef struct
{
  int32 x;  //��
  int32 y;  //��
}LocationUdis;  //����������λ��

//4. ��������
//extern uint8 ImgNew[CameraHight][CameraRealWidth];      //���´��������ݴ�������   
extern uint8 LimitLeftWMin;
extern uint8 LimitLeftWMax;
extern uint8 LimitLeftBMin;
extern uint8 LimitLeftBMax;
extern uint8 LimitLeftWBMin;
extern uint8 LimitLeftWBMax;

extern uint8 LimitRightWMin;
extern uint8 LimitRightWMax;
extern uint8 LimitRightBMin;
extern uint8 LimitRightBMax;
extern uint8 LimitRightWBMin;
extern uint8 LimitRightWBMax;

extern uint8 BlackLeftLoc[CameraHight][3];
extern uint8 BlackRightLoc[CameraHight][3];
extern int16 CenterLineLoc[CameraHight];      //������λ�ô洢����, 255Ϊ��Чֵ
extern int16 CURVEL;                          //������ȡʱ������ߵ����ʣ�˳ʱ��Ϊ������ʱ��Ϊ����
extern int16 CURVEC;                          //������ȡʱ�������ߵ����ʣ�˳ʱ��Ϊ������ʱ��Ϊ����
extern int16 CURVER;                          //������ȡʱ���Һ��ߵ����ʣ�˳ʱ��Ϊ������ʱ��Ϊ����
extern uint8 PathType;                        //��������
extern uint8 BlackLeftCrossDone;              //�����ʮ����ɱ�־0δ���� 1ʧ�� 2�ɹ�
extern uint8 BlackRightCrossDone;             //�Һ���ʮ����ɱ�־0δ���� 1ʧ�� 2�ɹ�
extern uint8 BlackLeftStep4Flag;              //�������Ҫִ�е�4�׶εı�־λ��0δ���룬1ʧ�ܣ�2�ɹ�
extern uint8 BlackRightStep4Flag;             //�Һ�����Ҫִ�е�4�׶εı�־λ��0δ���룬1ʧ�ܣ�2�ɹ�
extern uint8 BlackLeftHeadLine;
extern uint8 BlackRightHeadLine;
extern uint8 BlackLeftEndLine;
extern uint8 BlackRightEndLine;
//extern float SlopeC;                           //б����ȡʱ�������ߵ�б�ʡ�
//extern float SlopeLimitC;                      //���������ж�ʱ�������ߵ�б�ʵ���ֵ��

extern uint8 DeviNowLevel;                    //��ǰƫ��ľ���ֵ�ĵȼ���10���ȼ���0ƫ����С��9ƫ�����
extern uint8 DeviRowChosen;
extern int32 SlopeC;                  
extern uint8 ImgProSucceedFlag;
extern uint8 ImgBlackSucceedFlag;                 //������ȡ�ɹ���־λ��Ĭ��Ϊ1����������ȡʧ�ܣ�����0.
extern uint8 ImgCenterSucceedFlag;                //��������ȡ�ɹ���־λ��Ĭ��Ϊ1������������ȡʧ�ܣ�����0.
extern uint8 SingleDoneFlag;              //���ߴ���ʱ�����߳ɹ���־λ��
extern uint8 SingleFloorFlag;             //���ߴ���ʱ���ذ��жϳɹ���־λ��1�÷�ͼ�������ǵذ壬0���ǻ�û���жϡ�
extern uint8 SingleFloorConfirmCount;       //���ߴ���ʱ���ذ��ж�ȷ�ϼ���ֵ��ÿ��ͼ����һ�Ρ�
extern uint8 SingleFloorConfirmCountMax;   //���ߴ���ʱ���ذ��ж�ȷ�ϼ���ֵ�����ֵ������ȷ�����ȷ����ֵ��ÿ��ͼ����һ�Ρ�
extern uint8 PathSmallSDoneFlag;              //���������ж�ʱ��СS���жϳɹ���־λ��1�ɹ���0ʧ�ܡ�ÿ��ͼ���������ж�ʱ��ʼ��Ϊ0��
extern uint8 PathSmallSDir;                   //���������ж�ʱ��СS����ʼ����1
extern int32 DeviFuse;            //�����ںϺ��ƫ�
extern int32 Devi_near,Devi_far;      //��Զ��ƫ����
extern int32 DeviPre;                  //��һ��ƫ��
extern int32 DeviPrePre;              //���ϴ�ƫ��
extern int32 DeviPrePrePre;              //�����ϴ�ƫ��
extern uint8 FuzzyDegree;              //�����ȼ��㸨������


//ֱ�Ǻ�ɫ����
extern uint8 AngleZoneCheckRow0;     //ֱ�Ǻڿ飬������ͷѡ�е�Ҫ������֮һ��
extern uint8 AngleZoneCheckCol0L;    //ֱ�Ǻڿ飬������ͷѡ�е�Ҫ������֮һ�ļ����߽硣
extern uint8 AngleZoneCheckCol0R;    //ֱ�Ǻڿ飬������ͷѡ�е�Ҫ������֮һ�ļ����߽硣
extern uint8 AngleZoneCheckRow1;     //ֱ�Ǻڿ飬������ͷѡ�е�Ҫ������֮һ��
extern uint8 AngleZoneCheckCol1L;    //ֱ�Ǻڿ飬������ͷѡ�е�Ҫ������֮һ�ļ����߽硣
extern uint8 AngleZoneCheckCol1R;    //ֱ�Ǻڿ飬������ͷѡ�е�Ҫ������֮һ�ļ����߽硣
extern uint8 AngleZoneConfirmLockMeterCount; //ֱ�Ǻڿ飬�������е��ۼӼ���������ֱ�Ǻڿ����к�Ļָ�������

extern uint8 AngleZoneConfirmCount;   //��ֱ�Ǻڿ�ȷ�ϴ����ļ�����
extern uint8 AngleZoneConfirmLockFlag;    //ֱ�Ǻڿ��жϳɹ������־λ,ȷ����ֱ�Ǻڿ����λ��
                                       //������������㣬һ��֮�����ͷ����ɹ��󣬶���һ���������û�м�⵽��ͷ�
extern uint8 AngleZoneConfirmMat[AngleZoneConfirmMatNum];  //ֱ�Ǻڿ�ȷ�ϱ�־�洢���飬1��ʾ����Ϊֱ�Ǻڿ飬0��ʾ����ֱ�Ǻڿ顣
extern uint8 AngleZoneConfirmMatCollect;      //ֱ�Ǻڿ飬AngleZoneConfirmMat������1�ĸ�����

//ֱ���䴦��
extern uint8 AngleConfirmCount;   //��ֱ����ȷ�ϴ����ļ�����
extern uint8 AngleSpeDealBackCount;  //ֱ��������ȷ�Ϻ�������������ĵ���������
extern uint8 AngleSpeDealDir;        //ֱ���䷽���־��0��ֱ���䣬1��ֱ���䣬2����
extern uint8 AngleSpeDealFlag;       //ֱ�������⴦���־��1��ʾ�����ڽ�����ֱ�������⴦��0��ʾ������û�н���ֱ�������⴦��
extern uint16 AngleConfirmCountMax;   //��¼ʵ��ֱ����ȷ�ϴ��������ֵ�����������ֵ��
extern uint8 AngleConfirmLockFlag;    //ֱ�����жϳɹ������־λ,ȷ����ֱ�������λ������ȷ��ֱ�������⴦��ʼ��λ�á�
                                   //ֱ���������ڼ䣬���������������жϡ�
extern uint8 AngleSpeDealExitJudgeFlag;  //��ֱ�����жϱ�־��1�ѳ���0δ��
extern uint8 AngleConfirmMat0[AngleConfirmMatNum];  //ֱ����ȷ�ϱ�־�洢���飬1��ʾ����Ϊֱ�ǣ�0��ʾ����ֱ�ǡ�
extern uint8 AngleConfirmMatCollect0;      //ֱ���� ��AngleConfirmMat������1�ĸ�����
extern uint8 AngleConfirmMat1[AngleConfirmMatNum];  //ֱ����ȷ�ϱ�־�洢���飬1��ʾ����Ϊֱ�ǣ�0��ʾ����ֱ�ǡ�
extern uint8 AngleConfirmMatCollect1;      //ֱ���� ��AngleConfirmMat������1�ĸ�����

//�ϰ���
extern uint8 BrickConfirmCount;   //���ϰ���ȷ�ϴ����ļ�����
extern uint8 BrickSpeDealBackCount;  //�ϰ�������ȷ�Ϻ�������������ĵ���������
extern uint8 BrickSpeDealDir;        //�ϰ���λ�ã�0���ϰ��1���ϰ��2����
extern uint8 BrickSpeDealFlag;       //�ϰ������⴦���־��1��ʾ�����ڽ������ϰ������⴦��0��ʾ������û�н����ϰ������⴦��
extern uint16 BrickConfirmCountMax;   //��¼ʵ���ϰ���ȷ�ϴ��������ֵ�����������ֵ��
extern uint8 BrickConfirmLockFlag;    //�ϰ����жϳɹ������־λ,ȷ�����ϰ������λ������ȷ���ϰ������⴦��ʼ��λ�á�
                                   //�ϰ��������ڼ䣬���������������жϡ�
extern uint8 BrickSpeDealExitJudgeFlag;  //���ϰ����жϱ�־��1��ʾ��ʼ̬��2��ʾ��ǰ�Ѿ����ϰ�ƽ�У�0�˳�������ƣ��ѿ���Ȩ��������ͨ���ơ�
                                      //����ÿ��ͼ���£�ÿ�ι����ϰ������ֶ�д��1.
extern uint8 BrickConfirmMat[BrickConfirmMatNum];  //�ϰ���ȷ�ϱ�־�洢���飬1��ʾ����Ϊ�ϰ��0��ʾ�����ϰ��
extern uint8 BrickConfirmMatCollect;      //�ϰ���BrickConfirmMat������1�ĸ�����

extern uint8 BrickSpeDealStartJudgeCol;     //�ϰ����ж��Ƿ�ʼ�������ʱ���ض��ж�Ӧ����С���˷���������С�
extern uint8 BrickEndCol;    //�ϰ����ֱ�����Σ���ʼ�У����У��ڵ������С�
extern uint8 BrickHeadCol;   //�ϰ����ֱ�����Σ������У�Զ�У��ڵ������С�
extern uint8 BrickLeftCol;   //�ϰ����ֱ�����Σ����ϰ������߽硣
extern uint8 BrickRightCol;   //�ϰ����ֱ�����Σ����ϰ�����ұ߽硣

extern uint8 BrickLineCountNumRecord;

extern int16 ErrorCountNow5;
extern LocationUdis BlackUdisLeftLocation[CameraHight];  //�������������ߵ�λ�ô������顣���������������к��С�
extern LocationUdis BlackUdisRightLocation[CameraHight]; //�������������ߵ�λ�ô������顣���������������к��С�
extern uint8 BlackLeftDone;
extern uint8 BlackRightDone;
extern uint8 BlackLeftLastEdgeStartCol;
extern uint8 BlackRightLastEdgeStartCol;
extern uint8 BlackLeftEdgeStartCol;
extern uint8 BlackRightEdgeStartCol;
extern uint8 BlackCenEdgeStartCol;             //ɨ����㶨λ��
extern uint8 flag000;
extern int32 flag111;
extern int flag222;

extern uint8 BlackLeftContinueFlag;
extern uint8 BlackRightContinueFlag;
extern uint8 LimitLeftHeadWB;    
extern uint8 LimitLeftHeadW;      
extern uint8 LimitLeftHeadB;   
extern uint8 LimitRightHeadWB;    
extern uint8 LimitRightHeadW;      
extern uint8 LimitRightHeadB;   
extern uint8 countcount;
extern uint8 BrickSpeDealCenFlag;

//ֱ�Ǻڿ�
extern uint8 AngleZoneConfirmMatLimit;         //ֱ�Ǻڿ飬��־�洢������ֱ�Ǻڿ�ĸ������ڸ�ֵʱ��������Ϊֱ�Ǻڿ顣
//ֱ��
extern uint8 AngleConfirmMatLimit;         //ֱ�����־�洢������ֱ�ǵĸ������ڸ�ֵʱ��������Ϊֱ�ǡ�
extern uint8 AngleLongHeadLineStrategy;                //ֱ���䳤��ͷ���ԣ�1��ʾȥ������ͷ��0��ʾ��ȥ����ͷ��
extern uint8 AngleHeadLineNum;              //������ͷ֮����ڸ�ֵ�����п���Ϊֱ���䡣
//�ϰ�
extern uint8 BrickConfirmMatLimit;         //�ϰ���־�洢�������ϰ��ĸ������ڸ�ֵʱ��������Ϊ�ϰ���
extern uint8 BrickConfirmFinalColCom;     //�ϰ����ʱ��������������15Ϊ�㣬����Ҽӡ���
//��ֱ��
extern uint8 PathRealStraightFlag;        //��ֱ����־��1�ǳ�ֱ����0���ǡ�
extern uint8 PathRealStraightCountLimit;  //����ֱ��������ֵ�����ڸ�ֵ��ȷ��Ϊ��ֱ����

extern uint8 xiaoZhiDaoFlag;
extern uint8 ShiZhiFlag;
extern uint8 limitStopLineBlackXiu;


//extern uint16 SW0;
//extern uint16 SW1;
//extern uint16 SW2;
//extern uint16 SW3;
//extern uint16 SW4;
//extern uint16 SW5;
//extern uint16 SW6;
//extern uint16 SW7;
//extern uint16 SW8;


extern int32 SlopeL;                           //б����ȡʱ������ߵ�б�ʡ�
extern int32 SlopeC;                           //б����ȡʱ�������ߵ�б�ʡ�
extern int32 SlopeR;                           //б����ȡʱ���Һ��ߵ�б�ʡ�

extern uint8 StopLineCheckFlag;             //ͣ����
extern uint8 RunOutFlag;                    //�ܳ�������־
extern int32 DeviFuse_old;

//5. ��������
extern uint8 ImgNew[CameraHight][CameraRealWidth];
extern void ImaegExtract(uint8 *dst, uint8 *src, uint32 srclen);
extern uint8 ImagePro(void);
extern uint8 ImageSend(void);
extern uint8 VariablesInit(void);
extern int32 AbsInt(int32 val);
uint8 CurveSlopeGetLeft(void);
uint8 CurveSlopeGetRight(void);
uint8 BlackUdis(void);
extern uint8 BrickSpeDealServor(void);

//OV7725ͼ�����ݷ��ͺ���
//extern void SendImage(uint8 *imgaddr, uint32 imgsize);
//OV7620ͼ�����ݷ��ͺ���
//extern void SendImage(uint8 imgaddr[CameraHight][CameraWidth]);





#endif //end of __ImagePro_H__
