/******************************************************************************/
/*******************************************************************************
  �ļ�����ͼ��������ļ�ImagePro.c
  ��  �ܣ�ͼ����
  ��  �ڣ�2014.10.09
  ��  �ߣ�HJZ
  ��  ע��
*******************************************************************************/
/******************************************************************************/

#include "ImagePro.h"

//uint16 SW0;
//uint16 SW1;
//uint16 SW2;
//uint16 SW3;
//uint16 SW4;
//uint16 SW5;
//uint16 SW6;
//uint16 SW7;
//uint16 SW8;

uint8 limitStopLineBlackXiu = 30;       //��ͣ���ߺ�ɫ��ֵ�йصĲ���
uint8 ShiZhiFlag = 0;               //ʮ�ֱ�־
uint8 ShiZhiCount = 0;              //ʮ�ּ���
uint16 buXianCount = 0;             //������������


uint8 xiaoZhiDaoFlag = 0;                 //Сֱ��

uint8 ImgProFailCount = 0;          //ͼ��ʧ�ܼ���
uint8 RunOutFlag = 0;               //�ܳ�������־

uint8 StopLineCheckBeginFlag = 0;       //��ʼ�ж�ͣ���߱�־
uint8 StopLineCheckTimer = 0;           //ͣ���߼�ʱ
uint8 StopLineCheckFlag = 0;            //ͣ���߱�־
int16 ErrorCountNow5 = 0;
uint8 flag000;
int32 flag111;
int flag222;
//uint8 countcount;

int ServoPIDDGetVal;
int ServoPIDDGetValOld;

//��������ȡʱ��ʵ��������ȵ�һ���Ӧ�����ص������ǹ̶��ǶȺ��õ�ֵ��
uint8 const CenterLineHalfWidth[CameraHight] =  
{
64, 68, 72, 76, 80, 84, 88, 92, 96, 100,
104,108,112,116,120,124,128,132,136,140,
143,147,150,153,156,159,162,165,168,172,
177,179,181,183,185,187,189,191,193,195,
213,216,219,222,225,228,231,234,237,240,
100,100,100,100,100,100,100,100,100,100
};


uint8 const BlackLeftEdgeStartColOffset[CameraHight] = //�����������ص�ʱ����ʼ�����CameraRealWidth/2������ƫ�Ƶ����� 
{
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,         //Զ��20��
40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,         //�м�20��
43,43,45,45,48,48,50,50,53,53,55,55,58,58,60,60,63,63,65,65          //����20��
};


uint8 const BlackRightEdgeStartColOffset[CameraHight] = //���Ҽ�������ص�ʱ����ʼ�����CameraRealWidth/2������ƫ�Ƶ����� 
{
10,10,10,10,10,10,10,10,10,10,20,20,20,20,20,20,20,20,30,40,         //Զ��20��
40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,         //�м�20��
43,43,45,45,48,48,50,50,53,53,55,55,58,58,60,60,63,63,65,65          //����20��
};

//ֱ����
//ֱ�������⴦��ʱ����DeviNow�����⸳ֵ��Ӱ�������ơ�
//Ӧʹ֮�ϴ�ʹ�����ǽϴ�
//�����AngleSpeDealBackCountNumMax�Σ�Խ�����õĴ���Խ�١�
int16 const AngleSpeDealDeviNow[AngleSpeDealBackCountNum] = 
{
  //100, 100, 100, 100, 100,
  //100, 100, 100, 100, 100
50,100,130,130,130,
130,130,130,130,130,
130,130,100,100,100
};

//ֱ�������⴦��ʱ����DeviNowLevel�����⸳ֵ��0~6��0ƫ����С��6ƫ�����Ӱ�����͵�����ơ�
//Ӧʹ֮�ϴ�ʹ�ٶȽ�����
//�����AngleSpeDealBackCountNumMax�Σ�Խ�����õĴ���Խ�١�
/*
uint8 const AngleSpeDealDeviNowLevel[AngleSpeDealBackCountNum] = 
{
  6, 6, 6, 6, 6,
  6, 6, 6, 6, 6
};
*/

//ֱ�������⴦��ʱ����SlopeC�����⸳ֵ��Ӱ�������ơ�
//Ӱ��SlopeCLevel.0~5��0��ֱ��5��б��
//Ӧʹ֮��б��ʹ�ٶȽ�����
//�����AngleSpeDealBackCountNumMax�Σ�Խ�����õĴ���Խ�١�
int32 const AngleSpeDealSlopeC[AngleSpeDealBackCountNum] = 
{
  //3000, 3000, 3000, 3000, 3000,
  //3000, 3000, 3000, 3000, 3000
1500,2400,3000,3000,3000,
3000,3000,3000,2850,2550,
2250,2040,1950,1860,1800
};

//DeviNow��ͨ�˲�ʱ��Ȩ��,���֮��Ϊ100.�����޸ġ�
uint8 const DeviNowArrayWight[DeviNowArrayNum] = 
{
  0, 0, 100
};

//DeviNow��ͨ�˲�ʱ�Ĵ�������,��ʼ��Ϊ0;���޸ġ�
int16 DeviNowArray[DeviNowArrayNum] = 
{
  0, 0, 0
};


//���ߴ���
//���ߴ���ʱ������ĺ��߿�ȵ���Сֵ��ԽԶ��ԽС��
uint8 const SingleBlackWidthMin[CameraHight] = 
{
5,5,5,5,5,5,5,5,5,5,
5,5,5,5,5,5,5,5,5,5,
6,6,6,6,6,6,6,6,6,6,
6,6,6,6,6,6,6,6,6,6,
7,7,7,7,7,7,7,7,7,7,
7,7,7,7,7,7,7,7,7,7
};

//���ߴ���ʱ������ĺ��߿�ȵ����ֵ��ԽԶ��ԽС��
uint8 const SingleBlackWidthMax[CameraHight] = 
{
20,20,20,20,20,20,20,20,20,20,
20,20,20,20,20,20,20,20,20,20,
20,20,20,20,20,20,20,20,20,20,
20,20,20,20,20,20,20,20,20,20,
20,20,20,20,20,20,20,20,20,20,
20,20,20,20,20,15,15,15,15,15    //����ļ���15�о͹��ˣ�̫���˻�ɵ��Աߵ�������
};

/*
uint8 const SingleBlackWidthMax[CameraHight] = 
{
1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,
};
*/

//�������
 //Զ���ĺ��߻����������
int32 const BlackUdisMatrixFar[8] = 
{
        2950,
        4062,
     -243750,
           0,
       23420,
      -22387,
           0,
          32,
};
        //�м䴦�ĺ��߻����������
int32 const BlackUdisMatrixMiddle[8] = 
{
        2950,
        4062,
     -243750,
           0,
       23420,
      -22387,
           0,
          32,
};

        //�����ĺ��߻����������
int32 const BlackUdisMatrixLow[8] = 
{
       2950,
        4062,
     -243750,
           0,
       23420,
      -22387,
           0,
          32,
};

//������߲�ֵ��ֵ��΢������ΪԽԶ�ĵط���ֵ��ԽС��
uint8 const LimitLeftWBAdjust[CameraHight] = 
{
10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
 5,  5,  5,  5,  5,  5,  5,  5,  5,  5,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};

//���Һ��߲�ֵ��ֵ��΢������ΪԽԶ�ĵط���ֵ��ԽС��
uint8 const LimitRightWBAdjust[CameraHight] = 
{
10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
 5,  5,  5,  5,  5,  5,  5,  5,  5,  5,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};



uint8 CameraRealLeftCol = CameraWidth/2 - CameraRealWidth/2;    //ImgPut()�����У�320��ͼ��ȡ250�е�������ʼ�У�����������еƫ�
//ֻ��ͼ����ɹ��ˣ��Ż�������������жϣ��Ż����ƫ���ȡ������������ֵ�Ż���¡�
uint8 ImgProSucceedFlag = 1;                 //ͼ����ɹ���־λ��Ĭ��Ϊ1�������߻���������ȡʧ�ܣ�����0.
uint8 ImgBlackSucceedFlag = 1;                 //������ȡ�ɹ���־λ��Ĭ��Ϊ1����������ȡʧ�ܣ�����0.
uint8 ImgCenterSucceedFlag = 1;                //��������ȡ�ɹ���־λ��Ĭ��Ϊ1������������ȡʧ�ܣ�����0.

uint8 ImgNew[CameraHight][CameraRealWidth];       //������ͼ�����ݴ�������
uint8 BlackLeftLoc[CameraHight][3];       //�����λ�ô洢����,ÿ��3�����ɵ㣬 255Ϊ��Чֵ
uint8 BlackRightLoc[CameraHight][3];      //�Һ���λ�ô洢����,ÿ��3�����ɵ㣬 255Ϊ��Чֵ
//uint8 MaxValUint8 = 255;             //�Զ������Чֵ
uint8 CenterLineResult = 1;             //��������ȡ�ɹ���־
uint8 CenterKeyLine = 25;                  //�̶���Ҫѡȡ���С�
uint8 CenterLocStore = MaxValUint8;         //���Һ��߶���ȡ����ʱ�򣬱����CenterLineLoc[CameraHight - 1]��
uint8 CenterHeadLine = MaxValUint8;         //�����ߵ���ͷ��
uint8 CenterEndLine = MaxValUint8;          //�����ߵ���β��
uint8 BlackCenEdgeStartCol = 0;             //ɨ����㶨λ��
uint8 BlackGetPreDir;                       //����Ԥɨ�跽��0����ͷ�ɹ���1����ͷ�ɹ���2������ͷ��ʧ�ܡ�

uint8 CurveLineChosenC1 = 0;               //������ȡʱ��������ѡȡ�ĵ�1�С�
uint8 CurveLineChosenC2 = 0;               //������ȡʱ��������ѡȡ�ĵ�1�С�
uint8 CurveLineChosenC3 = 0;               //������ȡʱ��������ѡȡ�ĵ�1�С�
uint8 CurveLineChosenL1 = 0;               //������ȡʱ�������ѡȡ�ĵ�1�С�
uint8 CurveLineChosenL2 = 0;               //������ȡʱ�������ѡȡ�ĵ�1�С�
uint8 CurveLineChosenL3 = 0;               //������ȡʱ�������ѡȡ�ĵ�1�С�
uint8 CurveLineChosenR1 = 0;               //������ȡʱ���Һ���ѡȡ�ĵ�1�С�
uint8 CurveLineChosenR2 = 0;               //������ȡʱ���Һ���ѡȡ�ĵ�1�С�
uint8 CurveLineChosenR3 = 0;               //������ȡʱ���Һ���ѡȡ�ĵ�1�С�
int16 SABCL = 0;                          //������ȡʱ����������������ε������˳ʱ��Ϊ������ʱ��Ϊ����
int16 SABCC = 0;                          //������ȡʱ�����������������ε������˳ʱ��Ϊ������ʱ��Ϊ����
int16 SABCR = 0;                          //������ȡʱ���Һ������������ε������˳ʱ��Ϊ������ʱ��Ϊ����
int16 CURVEL = 0;                          //������ȡʱ������ߵ����ʣ�˳ʱ��Ϊ������ʱ��Ϊ����
int16 CURVEC = 0;                          //������ȡʱ�������ߵ����ʣ�˳ʱ��Ϊ������ʱ��Ϊ����
int16 CURVER = 0;                          //������ȡʱ���Һ��ߵ����ʣ�˳ʱ��Ϊ������ʱ��Ϊ����
//int16 CurveLeftLimitL = 8;               //���������ж�ʱ��ͨ������������ж�����Ϊ�������ֵ�������У��κ�Ӳ����ı�����ֶ��Ķ���ֵ��
//int16 CurveLeftLimitC = 10;              //���������ж�ʱ��ͨ�������������ж�����Ϊ�������ֵ�������У��κ�Ӳ����ı�����ֶ��Ķ���ֵ��
//int16 CurveLeftLimitR = 12;              //���������ж�ʱ��ͨ���Һ��������ж�����Ϊ�������ֵ�������У��κ�Ӳ����ı�����ֶ��Ķ���ֵ��
//int16 CurveRightLimitL = 12;             //���������ж�ʱ��ͨ������������ж�����Ϊ�������ֵ�������У��κ�Ӳ����ı�����ֶ��Ķ���ֵ��
//int16 CurveRightLimitC = 10;             //���������ж�ʱ��ͨ�������������ж�����Ϊ�������ֵ�������У��κ�Ӳ����ı�����ֶ��Ķ���ֵ��
//int16 CurveRightLimitR = 8;              //���������ж�ʱ��ͨ���Һ��������ж�����Ϊ�������ֵ�������У��κ�Ӳ����ı�����ֶ��Ķ���ֵ��
int32 SlopeL = MaxValInt16;                           //б����ȡʱ������ߵ�б�ʡ�
int32 SlopeC = MaxValInt16;                           //б����ȡʱ�������ߵ�б�ʡ�
int32 SlopeR = MaxValInt16;                           //б����ȡʱ���Һ��ߵ�б�ʡ�

uint8 CurveSlopeFlagL = 1;                  //��������ʡ�б����ȡ�ı�־λ��1�ɹ���0ʧ��(CURVE��Slope��������Чֵ)
uint8 CurveSlopeFlagC = 1;                  //���������ʡ�б����ȡ�ı�־λ��1�ɹ���0ʧ��(CURVE��Slope��������Чֵ)
uint8 CurveSlopeFlagR = 1;                  //�Һ������ʡ�б����ȡ�ı�־λ��1�ɹ���0ʧ��(CURVE��Slope��������Чֵ)

uint8 ErrorGetSelf;                 //ƽ��ֵ�������ƫ�Ҳ����curve
uint8 ErrorGetCen;                 //ƽ��ֵ�����������ߵ�ƫ�

//��
uint8 BlackLeftRealWB[2];                  //���ߵ�ʵ�ʺڰײ�ֵ�Ĵ洢���飬���ڼ���ʵ�ʺڰײ�ֵ����ֵ�����LimitLeftWB
uint8 BlackLeftRealB[2];                   //���ߵ�ʵ�ʺڵ�ֵ�洢���飬���ڼ���ʵ�ʺڵ���ֵ�����LimitLeftB
uint8 BlackLeftRealW[2];                   //���ߵ�ʵ�ʰ׵�ֵ�洢���飬���ڼ���ʵ�ʰ׵���ֵ�����LimitLeftW
//3���ؼ�ֵ�����½�
uint8 LimitLeftWBMin = 35;
uint8 LimitLeftWBMax = 90;
uint8 LimitLeftWMin = 90;
uint8 LimitLeftWMax = 140;
uint8 LimitLeftBMin = 80;
uint8 LimitLeftBMax = 110;


//��
uint8 BlackRightRealWB[2];                  //���ߵ�ʵ�ʺڰײ�ֵ�Ĵ洢���飬���ڼ���ʵ�ʺڰײ�ֵ����ֵ�����LimitRightWB
uint8 BlackRightRealB[2];                   //���ߵ�ʵ�ʺڵ�ֵ�洢���飬���ڼ���ʵ�ʺڵ���ֵ�����LimitRightB
uint8 BlackRightRealW[2];                   //���ߵ�ʵ�ʰ׵�ֵ�洢���飬���ڼ���ʵ�ʰ׵���ֵ�����LimitRightW
//3���ؼ�ֵ�����½�
uint8 LimitRightWBMin = 35;
uint8 LimitRightWBMax = 90;
uint8 LimitRightWMin = 90;
uint8 LimitRightWMax = 140;
uint8 LimitRightBMin = 80;
uint8 LimitRightBMax = 110;

 
//��
//С5��б�ʴ���
uint8 BlackLeft5SlopeIndex = 0;          //���ߵ�С5��б�ʴ���������±ꡣ
uint8 BlackLeft5SlopeRow[CameraHight];      //���ߵ�С5��б�ʴ��棬����С5��б��ʱ����Զ�������С�
int32 BlackLeft5Slope[CameraHight];      //���ߵ�С5��б�ʴ��棬�ӽ���Զ���档������㲻�ᴢ�������
//3���ؼ�ֵ�Ŀɸ�ֵ����������Ӧ���㷨���ġ�
uint8 LimitLeftWB;    //�ڰ����ص�Ĳ�ֵ��������Ĳ����Ҫ�������ֵ��������Ϊ�����䡣
uint8 LimitLeftW;      //�׵����Ҫ���ڴ�ֵ
uint8 LimitLeftB;      //�ڵ����ҪС�ڴ�ֵ

//ÿ����Чͼ���������ͷ��Ӧ��3����ֵ���������棬ÿ����Чͼ��ˢ��һ�Ρ�
uint8 LimitLeftHeadWB;    
uint8 LimitLeftHeadW;      
uint8 LimitLeftHeadB;      

uint8 BlackLeftCrossDone = 0;    //�����ʮ�ּ���־λ 0δ���� 1ʧ�� 2�ɹ�
uint8 BlackLeftDone = 1;          //�������ȡ�ɹ���ʾλ 1�ɹ� 0ʧ��
uint8 BlackLeft3ResetCount = 0;       //���ڹ��߱仯̫�������3���ؼ�ֵ���õĴ�����
uint8 BlackLeftCrossTooLowLine = 3;    //ʮ���ټ��ʱ�����ڸ��о�û��Ҫ�����ټ������ˡ�
uint8 BlackLeftStep4Flag = 0;          //�������Ҫִ�е�4�׶εı�־λ��0δ���룬1ʧ�ܣ�2�ɹ���3����
uint8 BlackLeftStep4StartLine = MaxValUint8;     //����ߵ�4�׶���ʼ��
uint8 BlackLeftHeadLine = MaxValUint8;   //����ߵ���ͷ���������¡�
uint8 BlackLeftEndLine = MaxValUint8;    //����ߵ���β���������¡�
uint8 BlackLeftWinPredictStore0 = 0;         //����ߴ����ڼ��ڵ�ʱ����ֹԤ������ʧ�ܶ������Ԥ���ֵ0.
uint8 BlackLeftWinPredictStore1 = 0;         //����ߴ����ڼ��ڵ�ʱ����ֹԤ������ʧ�ܶ������Ԥ���ֵ1.
uint8 BlackLeftWinPredictStore2 = 0;         //����ߴ����ڼ��ڵ�ʱ����ֹԤ������ʧ�ܶ������Ԥ���ֵ2.
uint8 BlackLeftContinueFlag = 1;           //����������Ա�־��1���������δ�ɹ���0��������2����
uint8 BlackLeftCrossConfirmFlag = 0;  //��ʮ����ͷ��־��0δ���룬1����Χ��2�ɹ���Ĭ��Ϊδ���롣  
uint8 BlackLeftEdgeStartCol;      //����߼��������ʱ����һ��ͼ����ʼ�У�ÿ��ͼ������һ����Чͼ�������ƣ���Ҫ���ǵ����ߵĿ�ȡ�
uint8 BlackLeftLastEdgeStartCol;  //����߼��������ʱ����һ��ͼ����ʼ�У�Ҳ������һ��ͼ����ÿ��ͼ������һ����Чͼ�������ƣ���Ҫ���ǵ����ߵĿ�ȡ�
uint8 BlackLeftStep1ScanRow;      //����ߵ�1�׶���ͷ���ʱ�ķ����С�
uint8 BlackLeftRow1RealLastLine;       //�����ʮ�ּ�⣬��1�κ��ߵ���ʵ�����У��п�����Ϊ�����䱻ɾ��������𲻻ᳬ��3�С�

//��
//С5��б�ʴ���
uint8 BlackRight5SlopeIndex = 0;          //���ߵ�С5��б�ʴ���������±ꡣ
uint8 BlackRight5SlopeRow[CameraHight];      //���ߵ�С5��б�ʴ��棬����С5��б��ʱ����Զ�������С�
int32 BlackRight5Slope[CameraHight];      //���ߵ�С5��б�ʴ��棬�ӽ���Զ���档������㲻�ᴢ�������
//3���ؼ�ֵ�Ŀɸ�ֵ����������Ӧ���㷨���ġ�
uint8 LimitRightWB;    //�ڰ����ص�Ĳ�ֵ��������Ĳ����Ҫ�������ֵ��������Ϊ�����䡣
uint8 LimitRightW;      //�׵����Ҫ���ڴ�ֵ
uint8 LimitRightB;      //�ڵ����ҪС�ڴ�ֵ

//ÿ����Чͼ���������ͷ��Ӧ��3����ֵ���������棬ÿ����Чͼ��ˢ��һ�Ρ�
uint8 LimitRightHeadWB;    
uint8 LimitRightHeadW;      
uint8 LimitRightHeadB;      
uint8 BlackRightCrossDone = 0;   //�Һ���ʮ�ּ���־λ 0δ���� 1ʧ�� 2�ɹ�
uint8 BlackRightDone = 1;          //�Һ�����ȡ�ɹ���ʾλ 1�ɹ� 0ʧ��
uint8 BlackRight3ResetCount = 0;       //���ڹ��߱仯̫�������3���ؼ�ֵ���õĴ�����
uint8 BlackRightCrossTooLowLine = 3;    //ʮ���ټ��ʱ�����ڸ��о�û��Ҫ�����ټ������ˡ�
uint8 BlackRightStep4Flag = 0;          //�Һ�����Ҫִ�е�4�׶εı�־λ��0δ���룬1ʧ�ܣ�2�ɹ���3����
uint8 BlackRightStep4StartLine = MaxValUint8;     //�Һ��ߵ�4�׶���ʼ��
uint8 BlackRightHeadLine = MaxValUint8;    //�Һ��ߵ���ͷ���������¡�
uint8 BlackRightEndLine = MaxValUint8;     //�Һ��ߵ���β���������¡�
uint8 BlackRightWinPredictStore0 = 0;         //�Һ��ߴ����ڼ��ڵ�ʱ����ֹԤ������ʧ�ܶ������Ԥ���ֵ0.
uint8 BlackRightWinPredictStore1 = 0;         //�Һ��ߴ����ڼ��ڵ�ʱ����ֹԤ������ʧ�ܶ������Ԥ���ֵ1.
uint8 BlackRightWinPredictStore2 = 0;         //�Һ��ߴ����ڼ��ڵ�ʱ����ֹԤ������ʧ�ܶ������Ԥ���ֵ2.
uint8 BlackRightContinueFlag = 1;           //�Һ��������Ա�־��1���������δ�ɹ���0��������2����
uint8 BlackRightCrossConfirmFlag = 0;  //��ʮ����ͷ��־��0δ���룬1����Χ��2�ɹ���Ĭ��Ϊδ���롣
uint8 BlackRightEdgeStartCol;      //�Һ��߼��������ʱ����һ��ͼ����ʼ�У�ÿ��ͼ������һ����Чͼ�������ƣ���Ҫ���ǵ����ߵĿ�ȡ�
uint8 BlackRightLastEdgeStartCol;  //�Һ��߼��������ʱ����һ��ͼ����ʼ�У�Ҳ������һ��ͼ����ÿ��ͼ������һ����Чͼ�������ƣ���Ҫ���ǵ����ߵĿ�ȡ�
uint8 BlackRightStep1ScanRow;      //�Һ��ߵ�1�׶���ͷ���ʱ�ķ����С�
uint8 BlackRightRow1RealLastLine;       //�Һ���ʮ�ּ�⣬��1�κ��ߵ���ʵ�����У��п�����Ϊ�����䱻ɾ��������𲻻ᳬ��3�С�

//����ͣ��
uint8 EmergencyStopCount = 0;     //����ͣ����������ÿ��ͼ����ʧ��ʱ��1��������EmergencyStopCountNum�����ñ�־λ��
uint8 EmergencyStopFlag = 0;      //����ͣ����־��1��ʾ����ͣ�����Ὣ��������0��ֻ�е����ؿ�������0.


//ƫ���ȡ
//int16 DeviNow = 0;                  //��ǰƫ��
uint8 DeviFlag = 0;                //ƫ����ȡ��־λ�����߳������Ӧ��д��ڼ���ƫ�
uint8 DeviRowChosen = 0;               //��ȡƫ��ʱѡȡ���У���ָ����Χûѡȡ��������Чֵ����ƫ���С������Ϊ0��
uint8 DeviNowLevel = 0;      //��ǰƫ��ľ���ֵ�ĵȼ���10���ȼ���0ƫ����С��9ƫ�����

//ֱ�Ǻ�ɫ����
//�ж�
uint8 AngleZoneJudgeRowL[AngleZoneJudgeRowNum];  //ֱ�Ǻڿ飬������ͷѡ�е�Ҫ���������С�
uint8 AngleZoneJudgeColL[AngleZoneJudgeRowNum];  //ֱ�Ǻڿ飬���߶�λ�������С�
uint8 AngleZoneJudgeColLFlag[AngleZoneJudgeRowNum]; //ֱ�Ǻڿ飬���߸��е���Ч�ڵ�����Ҫ��ʱ��λ��
uint8 AngleZoneJudgeCountColL[AngleZoneJudgeRowNum]; //ֱ�Ǻڿ飬���ߣ���¼���е���Ч�ڵ������Թ�ȷ�����ʵ���ֵ��
uint8 AngleZoneJudgeRowR[AngleZoneJudgeRowNum];  //ֱ�Ǻڿ飬������ͷѡ�е�Ҫ���������С�
uint8 AngleZoneJudgeColR[AngleZoneJudgeRowNum];  //ֱ�Ǻڿ飬���߶�λ�������С�
uint8 AngleZoneJudgeColRFlag[AngleZoneJudgeRowNum]; //ֱ�Ǻڿ飬���߸��е���Ч�ڵ�����Ҫ��ʱ��λ��
uint8 AngleZoneJudgeCountColR[AngleZoneJudgeRowNum]; //ֱ�Ǻڿ飬���ߣ���¼���е���Ч�ڵ������Թ�ȷ�����ʵ���ֵ��
//ȷ��
uint8 AngleZoneConfirmLockMeterCount = 0; //ֱ�Ǻڿ飬�������е��ۼӼ���������ֱ�Ǻڿ����к�Ļָ�������
uint8 AngleZoneConfirmCount = 0;   //��ֱ�Ǻڿ�ȷ�ϴ����ļ�����
uint8 AngleZoneConfirmLockFlag = 0;    //ֱ�Ǻڿ��жϳɹ������־λ,ȷ����ֱ�Ǻڿ����λ��
                                       //������������㣬һ��֮�����ͷ����ɹ��󣬶���һ���������û�м�⵽��ͷ�
uint8 AngleZoneConfirmMat[AngleZoneConfirmMatNum];  //ֱ�Ǻڿ�ȷ�ϱ�־�洢���飬1��ʾ����Ϊֱ�Ǻڿ飬0��ʾ����ֱ�Ǻڿ顣
uint8 AngleZoneConfirmMatCollect = 0;      //ֱ�Ǻڿ飬AngleZoneConfirmMat������1�ĸ�����
//���޸�
uint8 AngleZoneConfirmMatLimit = 3;         //ֱ�Ǻڿ飬��־�洢������ֱ�Ǻڿ�ĸ������ڸ�ֵʱ��������Ϊֱ�Ǻڿ顣

//ֱ���䴦��
uint8 AngleConfirmCount = 0;   //��ֱ����ȷ�ϴ����ļ�����
uint8 AngleSpeDealBackCount = 0;  //ֱ��������ȷ�Ϻ�������������ĵ���������
uint8 AngleSpeDealDir = 0;        //ֱ���䷽���־��0��ֱ���䣬1��ֱ���䣬2����
uint8 AngleSpeDealFlag = 0;       //ֱ�������⴦���־��1��ʾ�����ڽ�����ֱ�������⴦��0��ʾ������û�н���ֱ�������⴦��
uint16 AngleConfirmCountMax = 0;   //��¼ʵ��ֱ����ȷ�ϴ��������ֵ�����������ֵ��
uint8 AngleConfirmLockFlag = 0;    //ֱ�����жϳɹ������־λ,ȷ����ֱ�������λ������ȷ��ֱ�������⴦��ʼ��λ�á�
                                   //ֱ���������ڼ䣬���������������жϡ�
uint8 AngleSpeDealExitJudgeFlag = 0;  //��ֱ�����жϱ�־��1�ѳ���0δ��
uint8 AngleConfirmMat[AngleConfirmMatNum];  //ֱ����ȷ�ϱ�־�洢���飬1��ʾ����Ϊֱ�ǣ�0��ʾ����ֱ�ǡ�
uint8 AngleConfirmMatCollect = 0;      //ֱ���� ��AngleConfirmMat������1�ĸ�����

uint8 AngleConfirmMatLimit = 3;         //ֱ�����־�洢������ֱ�ǵĸ������ڸ�ֵʱ��������Ϊֱ�ǡ�
uint8 AngleLongHeadLineStrategy = 1;                //ֱ���䳤��ͷ���ԣ�1��ʾȥ������ͷ��0��ʾ��ȥ����ͷ��
uint8 AngleHeadLineNum = 5;              //������ͷ֮����ڸ�ֵ�����п���Ϊֱ���䡣


//ֱ������ϰ���ȷ�ϡ�
uint8 AngleStep1NotBrickEndColL;    //ֱ������ϰ���ȷ�ϣ���ֱ�����Σ���ʼ�У����У��ڵ������С�
uint8 AngleStep1NotBrickBorderColL; //ֱ������ϰ���ȷ�ϣ���ֱ�����Σ�ֱ�Ǳ������С�
uint8 AngleStep1NotBrickEndColR;    //ֱ������ϰ���ȷ�ϣ���ֱ�����Σ���ʼ�У����У��ڵ������С�
uint8 AngleStep1NotBrickBorderColR; //ֱ������ϰ���ȷ�ϣ���ֱ�����Σ�ֱ�Ǳ������С�

//�ϰ���
uint8 BrickConfirmCount = 0;   //���ϰ���ȷ�ϴ����ļ�����
uint8 BrickSpeDealBackCount = 0;  //�ϰ�������ȷ�Ϻ�������������ĵ���������
uint8 BrickSpeDealDir = 0;        //�ϰ���λ�ã�0���ϰ��1���ϰ��2����
uint8 BrickSpeDealFlag = 0;       //�ϰ������⴦���־��1��ʾ�����ڽ������ϰ������⴦��0��ʾ������û�н����ϰ������⴦��
uint16 BrickConfirmCountMax = 0;   //��¼ʵ���ϰ���ȷ�ϴ��������ֵ�����������ֵ��
uint8 BrickConfirmLockFlag = 0;    //�ϰ����жϳɹ������־λ,ȷ�����ϰ������λ������ȷ���ϰ������⴦��ʼ��λ�á�
                                   //�ϰ��������ڼ䣬���������������жϡ�
uint8 BrickSpeDealExitJudgeFlag = 1;  //���ϰ����жϱ�־��1��ʾ��ʼ̬��2��ʾ��ǰ�Ѿ����ϰ�ƽ�У�0�˳�������ƣ��ѿ���Ȩ��������ͨ���ơ�
                                      //����ÿ��ͼ���£�ÿ�ι����ϰ������ֶ�д��1.
uint8 BrickConfirmMat0[BrickConfirmMatNum];  //���ϰ���ȷ�ϱ�־�洢���飬1��ʾ����Ϊ�ϰ��0��ʾ�����ϰ��
uint8 BrickConfirmMatCollect0 = 0;      //���ϰ���BrickConfirmMat������1�ĸ�����
uint8 BrickConfirmMat1[BrickConfirmMatNum];  //���ϰ���ȷ�ϱ�־�洢���飬1��ʾ����Ϊ�ϰ��0��ʾ�����ϰ��
uint8 BrickConfirmMatCollect1 = 0;      //���ϰ���BrickConfirmMat������1�ĸ�����

uint8 BrickSpeDealStartJudgeCol;     //�ϰ����ж��Ƿ�ʼ�������ʱ���ض��ж�Ӧ����С���˷���������С�
uint8 BrickEndColL;    //�ϰ����ֱ�����Σ���ʼ�У����У��ڵ������С�
uint8 BrickHeadColL;   //�ϰ����ֱ�����Σ������У�Զ�У��ڵ������С�
uint8 BrickBorderColL; //�ϰ����ֱ�����Σ�ֱ�Ǳ������С�
uint8 BrickEndColR;    //�ϰ����ֱ�����Σ���ʼ�У����У��ڵ������С�
uint8 BrickHeadColR;   //�ϰ����ֱ�����Σ������У�Զ�У��ڵ������С�
uint8 BrickBorderColR; //�ϰ����ֱ�����Σ�ֱ�Ǳ������С�
uint8 BrickSpeDealCenFlag = 1; //�ϰ�����������⴦���־λ��ÿ��ͼ���Ԥ��1��1��ʾ�����⴦�����ɹ���0��ʾ����ʧ�ܡ�
uint8 BrickLineCountNumRecord;
//�ϰ����������ʱ��ƫ�Ƶ������������ִ�Ŀ�ʼִ�У�������С�ġ�
const int BrickSpeDealBias[BrickSpeDealBackCountNum] = 
{
  30,30,30,25,25,  
  25,25,25,20, 20,
   20, 15, 5, 0, -2,
   -5, -10, -10, -19, -19
};

uint8 BrickConfirmMatLimit = 3;         //�ϰ���־�洢�������ϰ��ĸ������ڸ�ֵʱ��������Ϊ�ϰ���
uint8 BrickConfirmFinalColCom = 50;     //�ϰ����ʱ��������������50Ϊ�㣬����Ҽӡ�����50С��ʾ�������߿�����50���ʾ�����ߡ�

//���ߴ���
uint8 SingleBlackAllFlag = 0;   //�ܷ�ͼ��ĵ��߱�־��ֻҪ��һ�м�ⵥ�߳ɹ�������1.ÿ��ͼ����ǰ��0.
uint8 SingleBlackLastAllFlag = 0;      //��һ��ͼ��ĵ��߱�־��
uint8 SingleDoneFlag = 0;              //���ߴ���ʱ�����߳ɹ���־λ��
                         //////////////////////Ŀǰ�������ƣ���ÿ����Ч����֤һ�Σ�һ�γɹ�����Ϊ�ɹ���
uint8 SingleFloorFlag = 0;             //���ߴ���ʱ���ذ��жϳɹ���־λ��1�÷�ͼ�������ǵذ壬0���ǻ�û���жϡ�
uint8 SingleFloorConfirmCount = 0;       //���ߴ���ʱ���ذ��ж�ȷ�ϼ���ֵ��ÿ��ͼ����һ�Ρ�
uint8 SingleFloorConfirmCountMax = 0;   //���ߴ���ʱ���ذ��ж�ȷ�ϼ���ֵ�����ֵ������ȷ�����ȷ����ֵ��ÿ��ͼ����һ�Ρ�
uint8 SingleBlackFlag[CameraHight];     //���ߴ���ʱ��ÿ�еĵ����жϳɹ���־��1����Ϊ���ߣ�0���в��ǵ��ߡ�ÿ��ͼ����ǰ����0.

//��������
uint8 PathJudgeDone = 1;                   //���������жϳɹ���־λ��1�ɹ���0ʧ�ܡ�
uint8 PathType = PathTypeUnknown;          //δ֪ ֱ�� ���� ���� ��ֱ ��ֱ СS
uint8 PathSmallSDoneFlag = 0;              //���������ж�ʱ��СS���жϳɹ���־λ��1�ɹ���0ʧ�ܡ�ÿ��ͼ���������ж�ʱ��ʼ��Ϊ0��
uint8 PathSmallSDir = 1;                   //���������ж�ʱ��СS����ʼ����

//�������
int16 CenterLineLoc[CameraHight];      //������λ�ô洢����, 255Ϊ��Чֵ
LocationUdis BlackUdisLeftLocation[CameraHight];  //�������������ߵ�λ�ô������顣���������������к��С�
LocationUdis BlackUdisRightLocation[CameraHight]; //�������������ߵ�λ�ô������顣���������������к��С�
//���п���
int32 DeviFuse = 0;            //�����ںϺ��ƫ�
int32 DeviFuse_old = 0;
uint32 DeviFuseArray[10];
int32 Devi_near,Devi_far;      //��Զ��ƫ����
int32 DeviPre = 0;                  //��һ��ƫ��
int32 DeviPrePre=0;              //���ϴ�ƫ��
int32 DeviPrePrePre=0;              //�����ϴ�ƫ��
int16 ControlRowDeviInit[4];    //�������еĳ�ʼƫ��,��һ��0~100,0~3�ֱ���base��low��middle��high
int16 ControlRowDeviOld[4]; 
uint8 BaseRowControlNum;        //���п�����ţ���Ӧ��Ȩ���������±�
uint8 FuzzyDegree;              //�����ȼ��㸨������
uint8 ControlRowWeight[4];      //������Ȩ��ϵ��,ģ������
uint16 Weight_sum = 0;            //Ȩ��ϵ���ĺ�



//��б�ʼ�⡣
uint8 BlackLeftBigChangeNumx[5];                     //��б�ʼ��ʱ��������X�Ĵ������顣�����кš�
uint8 BlackLeftBigChangeNumy[5];                     //��б�ʼ��ʱ��������X�Ĵ������顣������Ч�еĺڵ������С�
uint8 BlackLeftBigChangeFlag = 0;              //��б�ʼ��ʱ����⵽��б�ʵı�־��ÿ��ͼ������㣬��ֻҪ��һ�μ�⵽����λ��1�÷�ͼ���⵽��б�ʣ�0�÷�ͼ��û�м�⵽��
int32 BlackLeftBigChangeSlopeStore = MaxValInt16;    //��б�ʼ��ʱ���������һ�ε�б��ֵ��
uint8 BlackLeftBigChangeJumpFlag = 0;                //��б�ʼ��ʱ���������������ڵ�һ��Сѭ����

uint8 BlackRightBigChangeNumx[5];                     //��б�ʼ��ʱ��������X�Ĵ������顣�����кš�
uint8 BlackRightBigChangeNumy[5];                     //��б�ʼ��ʱ��������X�Ĵ������顣������Ч�еĺڵ������С�
uint8 BlackRightBigChangeFlag = 0;              //��б�ʼ��ʱ����⵽��б�ʵı�־��ÿ��ͼ������㣬��ֻҪ��һ�μ�⵽����λ��
int32 BlackRightBigChangeSlopeStore = MaxValInt16;    //��б�ʼ��ʱ���������һ�ε�б��ֵ��
uint8 BlackRightBigChangeJumpFlag = 0;                //��б�ʼ��ʱ���������������ڵ�һ��Сѭ����

uint8 BlackLeftBigChangeCheckRow[CameraHight];   //��б�ʼ��ʱ��ÿ�еı�־��1��ʾ���������δͨ���������⣬0��ʾͨ����
uint8 BlackLeftBigChangeCheckAllRow;             //��б�ʼ��ʱ��1�÷�ͼ�������ߴ�����ĳ��δͨ���������⣬0�÷�ͼ��ÿ������߾�ͨ���������⡣
uint8 BlackRightBigChangeCheckRow[CameraHight];  //��б�ʼ��ʱ��ÿ�еı�־��1��ʾ�����Һ���δͨ���������⣬0��ʾͨ����
uint8 BlackRightBigChangeCheckAllRow;            //��б�ʼ��ʱ��1�÷�ͼ����Һ��ߴ�����ĳ��δͨ���������⣬0�÷�ͼ��ÿ���Һ��߾�ͨ���������⡣

//������
uint8 BlackLeftRollCheckFlag = 0;             //�������־λ��0δ��⵽���䣬1��⵽���䡣
uint8 BlackRightRollCheckFlag = 0;             //�������־λ��0δ��⵽���䣬1��⵽���䡣



//ʮ����β
uint8 BlackLeftCrossTailFlag = 2;       //ʮ����β��־��0ʧ�ܣ�1ȷ�ϣ�2δ���롣
uint8 BlackLeftCrossTailEndLine;        //ʮ����β����ɾ������Զ�С�
uint8 BlackRightCrossTailFlag = 2;       //ʮ����β��־��0ʧ�ܣ�1ȷ�ϣ�2δ���롣
uint8 BlackRightCrossTailEndLine;        //ʮ����β����ɾ������Զ�С�

//����Ԥ��ֵ����
uint8 BlackLeftPredictL[CameraHight];          //����Ԥ��ֵ�����ߵ���߽硣
uint8 BlackLeftPredictR[CameraHight];          //����Ԥ��ֵ�����ߵ��ұ߽硣
uint8 BlackRightPredictL[CameraHight];          //����Ԥ��ֵ�����ߵ���߽硣
uint8 BlackRightPredictR[CameraHight];          //����Ԥ��ֵ�����ߵ��ұ߽硣

//�������
uint8 RoadHalfWidth;                              //˫���������
uint8 RoadHalfWidthLast;                          //��һ��ͼ���յ�˫���������
uint8 RoadHalfWidthRecord[CameraHight];           //˫����������¼
uint8 RoadHalfWidthSingle;                        //�����������
uint8 RoadHalfWidthWrongFlag = 2;                 //ͨ����������жϳ����ĵ��ߴ����־��2δ���룬1����0��ȷ��
uint8 RoadHalfWidthWrongDir;                      //���ߴ���ʱ��0�������գ�1�������ա�
float RoadHalfWidthCompen;                        //��˫���л�������ϵ��
uint8 RoadHalfWidthSwitch = 1;                        //·���أ�1������б�ʣ�ȡ���ֵ��0����ֱ�����ϴ�˫�ߵ�


//���ߴ���
uint8 BlackSingleFlag = 0;   //���ߴ����־��0û����1�д���ÿ��ͼ��ʼ��Ϊ0.
uint8 BlackSingleDir;        //���ߴ���ķ����־��0��ʾ�������գ�1��ʾ�������ա�

//���մ�������
uint8 BlackBigChangeFinalCheckFlag = 0;  //���մ��������־λ��0δ��⵽��û��Ҫ��⣬1��⵽�������մ����䣬2��⵽�������մ�����

//��ֱ��
uint8 PathRealStraightCount = 0;   //����ֱ������
uint8 PathRealStraightCountLimit = 10;  //����ֱ��������ֵ�����ڸ�ֵ��ȷ��Ϊ��ֱ����
uint8 PathRealStraightFlag = 0;        //��ֱ����־��1�ǳ�ֱ����0���ǡ�




//����ֵ��ȡ
int32 AbsInt(int32 val)
{
  if(val >= 0)
  {
    return val;
  }
  else
  {
    return (0-val);
  }
}

//���ұ߽�����
int32 BoundaryLimitRe(int32 x, int32 left, int32 right)
{
  if(x < left)
  {
    return left;
  }
  else if(x > right)
  {
    return right;
  }
  else
  {
    return x;
  }
}

//======================================================================
//��������MaxRe
//��  �ܣ���ȡ�������ֵ
//��  ������1����num1, ��2����num2��
//��  �أ�2�����е����ֵ
//Ӱ  �죺��
//˵  ����1. ��������������Ⱥ�˳��
//======================================================================
int32 MaxRe(int32 a, int32 b)
{
  return (a > b ? a : b);
}

//======================================================================
//��������MinRe
//��  �ܣ���ȡ������Сֵ
//��  ������1����num1, ��2����num2��
//��  �أ�2�����е���Сֵ
//Ӱ  �죺��
//˵  ����1. ��������������Ⱥ�˳��   
//======================================================================
int32 MinRe(int32 a, int32 b)
{
  return (a < b ? a : b);
}

//======================================================================
//��������AbsRe
//��  �ܣ���ȡ������ֵ�ľ���ֵ
//��  ������1����num1, ��2����num2��
//��  �أ�2�����ľ���ֵ��
//Ӱ  �죺��
//˵  ����1. ��������������Ⱥ�˳�� 
//======================================================================
int32 AbsRe(int32 num1, int32 num2)
{
  if(num1 >= num2)
  {
    return (num1 - num2);  
  }
  else
  {
    return (num2 - num1);  
  }
}



//ʮ�ּ��
int ShiZhiCheck()
{
    uint8 startRow = 59;
    uint8 row;
    uint8 col;
    uint32 limitL;
    uint32 limitR;
    uint32 limit;

    limitL = 0;
    limitR = 0;
    limit = 0;
    if(ShiZhiFlag==0)
    {
        //Ҫ��֤���߲ɼ��ɹ�
        if (BlackLeftDone != 1 || BlackRightDone != 1) { return 0; }
        //Ҫ��֤����ֱ��
        if (AbsInt(SlopeL) < 1700 && AbsInt(SlopeR) < 1700
            && BlackRightCrossDone != 2 && BlackLeftCrossDone != 2
                && BlackRightEndLine > 57 && BlackLeftEndLine > 57)
        {
            if (BlackRightHeadLine >= 15 && BlackLeftHeadLine >= 15 && BlackRightHeadLine <= 59 && BlackLeftHeadLine <= 59 && AbsInt(BlackLeftHeadLine - BlackRightHeadLine) <= 10) { }
            else { return 0; }
        }
        else { return 0; }

        if (BlackLeftHeadLine >= BlackLeftEndLine) { return 0; }
        //�����ڵ��б�����һ����Χ��
        for (row = BlackLeftEndLine; row >= BlackLeftHeadLine; row--)
        {
            if (BlackLeftLoc[row][0] < 10 || BlackLeftLoc[row][0] > 240) { return 0; }
            else
            {
                limitL += ImgNew[row][BlackLeftLoc[row][0] - 9];
            }
        }
        for (row = BlackRightEndLine ; row >= BlackRightHeadLine; row--)
        {
            if (BlackRightLoc[row][0] < 10 || BlackRightLoc[row][0] > 240) { return 0; }
            else
            {
                limitR += ImgNew[row][BlackRightLoc[row][0] + 9];
            }
        }

        limit = (limitL + limitR) / (BlackLeftEndLine - BlackLeftHeadLine + 1) / 2;
        startRow = MinRe(BlackLeftHeadLine, BlackRightHeadLine) - 3;
        limit = MaxRe(limit, LimitLeftB) + 10;

        for (row = startRow; row > startRow - 3; row--)
        {
            for (col = 30; col <= 220; col++)
            {
                if (ImgNew[row][col] <= limit) { return 0; }
            }
        }
        ShiZhiCount = 0;
        return 1;
    }
    else
    {
        if(BlackLeftLoc[20][0]!=MaxValUint8 && BlackRightLoc[20][0]!=MaxValUint8){return 0;}
        else if(BlackRightHeadLine<15 && BlackLeftHeadLine<15){return 0;}
        else if(++ShiZhiCount>=6){return 0;}
        else{return 1;}
    }
}




//�¼����ͣ���߼��
uint8 StopLineCheck()
{
    uint8 row;
    uint8 col;
    uint16 leftCount = 0;
    uint16 rightCount = 0;
    uint16 centerErrorCount = 0;
    uint32 limitStopLineBlack = 0;
    
    
    if(StopLineCheckBeginFlag == 0)
    {
        if(++StopLineCheckTimer >= 50)
        {
            StopLineCheckBeginFlag = 1;
        }
        else {return 0;}
    }

    
    limitStopLineBlack = 0;
    centerErrorCount = 0;
    //Ҫ��֤���߲ɼ��ɹ�
    if (BlackLeftDone != 1 || BlackRightDone != 1) { return 0; }
    //Ҫ��֤����ֱ��
    if (AbsInt(SlopeL) < 1500 && AbsInt(SlopeR) < 1500 && AbsInt(CURVEL) < 15 && AbsInt(CURVER) < 15
        && BlackRightCrossDone == 0 && BlackLeftCrossDone == 0
            && BlackRightHeadLine < 3 && BlackLeftHeadLine < 3 && BlackRightEndLine > 57 && BlackLeftEndLine > 57
                && BlackLeftCrossDone == 0 && BlackRightCrossDone == 0
                 && ShiZhiFlag == 0) { }
    else { return 0; }

    centerErrorCount = 0;
    //���20-35��֮����û�п��ɵ�ͣ����
    for (row = 59; row >= 20; row--)
    {
        //��ֹ������ж����
        if (BlackLeftLoc[row][0] == MaxValUint8 || BlackRightLoc[row][0] == MaxValUint8)
        {
            centerErrorCount++;
            if (centerErrorCount > 5)
            {
                return 0;
            }
            continue;
        }
        limitStopLineBlack += ImgNew[row][BlackLeftLoc[row][0]];
        limitStopLineBlack += ImgNew[row][BlackRightLoc[row][0]];
    }
    limitStopLineBlack /= (59 - 20 + 1 - centerErrorCount)*2;

    centerErrorCount = 0;
    //���20-35��֮����û�п��ɵ�ͣ����
    for (row = 55; row >= 40; row--)
    {
        //��ֹ������ж����
        if (ImgNew[row][BlackLeftLoc[row][0]] >= LimitLeftW || ImgNew[row][BlackRightLoc[row][0]] >= LimitRightW)
        {
            centerErrorCount++;
            if (centerErrorCount > 2)
            {
                return 0;
            }
            continue;
        }
    }

    centerErrorCount = 0;
    //���20-35��֮����û�п��ɵ�ͣ����
    for (row = 59; row >= 20; row--)
    {
        //��ֹ������ж����
        if (BlackLeftLoc[row][0] == MaxValUint8 || BlackRightLoc[row][0] == MaxValUint8)
        {
            centerErrorCount++;
            if (centerErrorCount > 5)
            {
                return 0;
            }
            continue;
        }
        //���м��ߵ�λ�ÿ�ʼ���ߣ�һֱ�ҵ��м���-40
        for (col = BlackLeftLoc[row][0] + 3; col <= (BlackLeftLoc[row][0] + BlackRightLoc[row][0]) / 2; col++)
        {
            if (ImgNew[row][col] < limitStopLineBlack+ limitStopLineBlackXiu)
            {
                leftCount++;
            }
        }

        //���м��ߵ�λ�ÿ�ʼ���ߣ�һֱ�ҵ��м���+40
        for (col = BlackRightLoc[row][0] - 3; col >= (BlackLeftLoc[row][0] + BlackRightLoc[row][0]) / 2; col--)
        {
            if (ImgNew[row][col] < limitStopLineBlack + limitStopLineBlackXiu)
            {
                rightCount++;
            }
        }
    }


    //�������ֹͣ�ߵ���ͷ�ǲ�������ˮƽ����Ҫ��
    if (leftCount + rightCount > 10 && leftCount >= 5 && rightCount >= 5)//(stopLineLeft!=MaxValUint8)&&(stopLineRight!=MaxValUint8)&&(stopLineRight-stopLineLeft<=40)&&(stopLineRight-stopLineLeft>=20)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}






//======================================================================
//��������LeastSquareInt16a1
//��  �ܣ����y��int16�����ݵ���С���˷���a1ֵ����ȡ
//��  ����x���飬y���飬num���ڵ���Ч���ݸ���
//��  �أ�a1
//Ӱ  �죺��
//˵  ����1. y = a0 + a1 * x;
//        2. a1 = (N * ��xy - ��x * ��y) / (N * ��x^2 - ��x * ��x);
//        3. a1������LeastSquareMulti����
//======================================================================
int32 LeastSquareInt16a1(uint8 x[], int16 y[], uint8 num)
{
  int32 andxy = 0, andx = 0, andy = 0, andx2 = 0;
  int32 a1;
  uint8 i;
 
  for(i = 0; i < num; i++)
  {
    andxy += x[i] * y[i];
    andx += x[i];
    andy += y[i];
    andx2 += x[i] * x[i];
  }
  
  //����ʱΪ���ͣ�����Ϊint32�ͣ��ҷŴ���LeastSquareMulti����
  a1 = (int32)(LeastSquareMulti * (num * andxy - andx * andy) / (num * andx2 - andx * andx));    
  
  return a1;  
  
}

//======================================================================
//��������LeastSquareInt16a0
//��  �ܣ����y��int16�����ݵ���С���˷���a0ֵ����ȡ
//��  ����x���飬y���飬a1������num���ڵ���Ч���ݸ���
//��  �أ�a0
//Ӱ  �죺��
//˵  ����1. y = a0 + a1 * x;
//        2. a0 = ��y / N - a1 * ��x / N;
//        3. a0������LeastSquareMulti����      
//======================================================================
int32 LeastSquareInt16a0(uint8 x[], int16 y[], int32 a1, uint8 num)
{
  int32 andx = 0, andy = 0;
  int32 a0;
  uint8 i;
  for(i = 0; i < num; i++)
  {
    andx += x[i];
    andy += y[i];
  }
  
  //����ʱΪ���ͣ�����Ϊint32�ͣ��ҷŴ���LeastSquareMulti����
  a0 = (int32)(LeastSquareMulti * andy / num - a1 * andx / num);
  return a0;
}

//======================================================================
//��������LeastSquarea1
//��  �ܣ���С���˷���a1ֵ����ȡ
//��  ����x���飬y���飬num���ڵ���Ч���ݸ���
//��  �أ�a1
//Ӱ  �죺��
//˵  ����1. y = a0 + a1 * x;
//        2. a1 = (N * ��xy - ��x * ��y) / (N * ��x^2 - ��x * ��x);
//        3. a1������LeastSquareMulti����
//======================================================================
int32 LeastSquarea1(uint8 x[], uint8 y[], uint8 num)
{
  int32 andxy = 0, andx = 0, andy = 0, andx2 = 0;
  int32 a1;
  uint8 i;
 
  for(i = 0; i < num; i++)
  {
    andxy += x[i] * y[i];
    andx += x[i];
    andy += y[i];
    andx2 += x[i] * x[i];
  }
  
  //����ʱΪ���ͣ�����Ϊint32�ͣ��ҷŴ���LeastSquareMulti����
  a1 = (int32)(LeastSquareMulti * (num * andxy - andx * andy) / (num * andx2 - andx * andx));    
  return a1;  
}


//======================================================================
//��������LeastSquarea0
//��  �ܣ���С���˷���a0ֵ����ȡ
//��  ����x���飬y���飬a1������num���ڵ���Ч���ݸ���
//��  �أ�a0
//Ӱ  �죺��
//˵  ����1. y = a0 + a1 * x;
//        2. a0 = ��y / N - a1 * ��x / N;
//        3. a0������LeastSquareMulti����      
//======================================================================
int32 LeastSquarea0(uint8 x[], uint8 y[], int32 a1, uint8 num)
{
  int32 andx = 0, andy = 0;
  int32 a0;
  uint8 i;
  for(i = 0; i < num; i++)
  {
    andx += x[i];
    andy += y[i];
  }
  
  //����ʱΪ���ͣ�����Ϊint32�ͣ��ҷŴ���LeastSquareMulti����
  a0 = (int32)(LeastSquareMulti * andy / num - a1 * andx / num);
  return a0;
}




/*
//��ֵ��ͼ���ѹ����
//dst             ͼ���ѹĿ�ĵ�ַ
//src             ͼ���ѹԴ��ַ
//srclen          ��ֵ��ͼ���ռ�ÿռ��С
void ImageExtract(uint8 *dst, uint8 *src, uint32 srclen)
{
    uint8 colour[2] = {255, 0}; //0 �� 1 �ֱ��Ӧ����ɫ
    //ע��ɽ�������ͷ 0 ��ʾ ��ɫ��1��ʾ ��ɫ
    uint8 tmpsrc;
    while(srclen --)
    {
        tmpsrc = *src++;
        *dst++ = colour[ (tmpsrc >> 7 ) & 0x01 ];
        *dst++ = colour[ (tmpsrc >> 6 ) & 0x01 ];
        *dst++ = colour[ (tmpsrc >> 5 ) & 0x01 ];
        *dst++ = colour[ (tmpsrc >> 4 ) & 0x01 ];
        *dst++ = colour[ (tmpsrc >> 3 ) & 0x01 ];
        *dst++ = colour[ (tmpsrc >> 2 ) & 0x01 ];
        *dst++ = colour[ (tmpsrc >> 1 ) & 0x01 ];
        *dst++ = colour[ (tmpsrc >> 0 ) & 0x01 ];
    }
}


*/

/*          //OV7725��ͼ���ͺ���
//ͼ���͵���λ��
void SendImage(uint8 *imgaddr, uint32 imgsize)
{                                                                                   
    uint8 cmd[4] = {0, 255, 1, 0 };    //yy_����ͷ���ڵ��� ʹ�õ�����

    //uint8 cmd[1] = {255};       //DEMOK��λ��ʹ�õ�����   
  
    uart_sendN(UART0, cmd, sizeof(cmd));    //�ȷ�������

    uart_sendN(UART0, imgaddr, imgsize); //�ٷ���ͼ��
}

*/

//======================================================================
//��������SendCenterLineLoc
//��  �ܣ����������鷢�ͺ���
//��  ����img�����͵�һάͼ������
//��  �أ���
//Ӱ  �죺��
//˵  ����1. ���������ͷ��ͼ�����鷢�ͺ���������ͷ��һ����
//      
//          
//======================================================================
void SendCenterLineLoc(uint8 img[CameraHight])
{
    uint8 i;
    uint8 cmd[4] = {0, 255, 1, 255 };   //���������������ͷ
    uart_sendN(UART0, cmd, sizeof(cmd));    //�ȷ�������
    for(i = 0; i < CameraHight; i++)
    {
      uart_send1(UART0, img[i]); //��������������
    }
    
}




//======================================================================
//��������SendImage
//��  �ܣ�OV7620��ͼ���ͺ���
//��  ���������͵Ķ�άͼ������imgaddr
//��  �أ���
//Ӱ  �죺��
//˵  ����1. �޸�ͼ�������Сʱ��Ҫ���ڲ�����for������Ҳ�ĵ�
//        2. ���������ͷ�����������鷢�ͺ���������ͷ��һ����
//          
//======================================================================
void SendImage(uint8 imgaddr[CameraHight][CameraRealWidth])
{                            
    uint16 i, j;
    uint8 cmd[4] = {0, 255, 1, 0 };    //ͼ�����������ͷ

    //uint8 cmd[1] = {255};       //DEMOK��λ��ʹ�õ�����   
  
    uart_sendN(UART0, cmd, sizeof(cmd));    //�ȷ�������
    
    //���ﲻ����uart_sendN(UART0, imgaddr, CameraSize)�����棬��Ϊuart_sendN�������buff[i].
    for(i = 0; i < CameraHight; i++)
        for(j = 0; j < CameraRealWidth; j++)
            uart_send1(UART0, imgaddr[i][j]); //����ͼ��
}



//====================================����������������������������������============================




//======================================================================
//��������BlackLeftRealClear
//��  �ܣ��������ȡ�У���3���ؼ�ֵ��ʵ��ֵ����
//��  ������
//��  �أ���
//Ӱ  �죺BlackLeftRealWB[], BlackLeftRealW[], BlackLeftRealB[]
//˵  ����
//      
//             
//======================================================================
void BlackLeftRealClear(void)
{
    BlackLeftRealWB[0] = 0;
    BlackLeftRealWB[1] = 0;
    BlackLeftRealW[0] = 0;
    BlackLeftRealW[1] = 0;
    BlackLeftRealB[0] = 0;
    BlackLeftRealB[1] = 0;
}


//������ȡ�ɹ���������ߵ���ͷ��β��
uint8 BlackLeftHeadEndSearch(void)
{
  uint8 i;
  //������ͷ����β�Ĳ���
  if(BlackLeftDone == 1)
  { //������ͷ�Ĳ��ҡ�
    for(i = 0; ; i++)
    {
      if(BlackLeftLoc[i][0] != MaxValUint8)
      { //�ҵ�����ͷ
        BlackLeftHeadLine = i;
        break;
      }
      if(i == CameraHight - 1) 
      { //ֱ�����һ�л�û���ҵ���ͷ
        BlackLeftHeadLine = MaxValUint8;
        break;
      }
    }
    
    //����ͷ�Ѿ�����ʧ�ܣ��Ͳ��ò�����β�ˡ�
    if(BlackLeftHeadLine == MaxValUint8)
    {
      BlackLeftEndLine = MaxValUint8;
      BlackLeftDone = 0;
    }
    //����ͷ���ҳɹ����Ϳ�ʼ����β��
    else
    {
      //������β�Ĳ��ҡ�
      for(i = CameraHight - 1; ; i--)
      { //������β���ҳɹ���
        if(BlackLeftLoc[i][0] != MaxValUint8)
        {
          BlackLeftEndLine = i;
          break;
        }
        //������β����ʧ�ܡ����߲�������ͷ��β�����Ծ�����Чֵ��
        if(i == BlackLeftHeadLine)
        {
          BlackLeftHeadLine = MaxValUint8;
          BlackLeftEndLine = MaxValUint8;
          break;
        }
      }
    }
  }
  //����������ȡʧ�ܣ��Ͳ�������ͷ����β�ˡ�
  else
  {
    BlackLeftHeadLine = MaxValUint8;
    BlackLeftEndLine = MaxValUint8;
  }
  
  //����ͼ���е���ʱ��ɾ����Զһ���㡣
  if(SingleBlackAllFlag == 1)
  {
    BlackLeftLoc[BlackLeftHeadLine][0] = MaxValUint8; //Udis���鲻�øģ���Ϊ��ͷ��β����֮����ֵ�����������
    BlackLeftHeadLine += 1;
  }
  else
  {
  }
  
  return 1;
}








//======================================================================
//��������BlackLeftBigChangeCheck
//��  �ܣ��������ȡʱ����б�ʼ�⡣
//��  ����newrow�¼ӽ�������Ҫ�ж��Ƿ���Ч����,use����ʱ������2�еĵڼ��С�
//��  �أ�1���к��߳ɹ���0���к���ʧ�ܡ�
//Ӱ  �죺
//˵  ����1. ������ֹ��б��ͻ��Ļ��㡣
//        2. ��5���У�ȡ1��3��5�н���б�ʼ��㣬ÿ��һ�����У��Ƴ�һ�����С�
//             
//======================================================================
uint8 BlackLeftBigChangeCheck(uint8 newrow, uint8 use)
{
  uint8 tempstorex, tempstorey;
  uint8 i;
  int32 tempslope1, tempslope2;
  
  //tempstorex�������潫Ҫ�Ƴ���һ�У��������ʧ��ʱ��ԭ5�����顣
  tempstorex = BlackLeftBigChangeNumx[0];
  BlackLeftBigChangeNumx[0] = BlackLeftBigChangeNumx[1];
  BlackLeftBigChangeNumx[1] = BlackLeftBigChangeNumx[2];
  BlackLeftBigChangeNumx[2] = BlackLeftBigChangeNumx[3];
  BlackLeftBigChangeNumx[3] = BlackLeftBigChangeNumx[4];
  BlackLeftBigChangeNumx[4] = newrow;

  tempstorey = BlackLeftBigChangeNumy[0];
  BlackLeftBigChangeNumy[0] = BlackLeftBigChangeNumy[1];
  BlackLeftBigChangeNumy[1] = BlackLeftBigChangeNumy[2];
  BlackLeftBigChangeNumy[2] = BlackLeftBigChangeNumy[3];
  BlackLeftBigChangeNumy[3] = BlackLeftBigChangeNumy[4];
  BlackLeftBigChangeNumy[4] = BlackLeftLoc[newrow][0];
  
  //ÿ��ͼ���ֻ��һ�����forѭ��������ʡʱ�䡣
  if(BlackLeftBigChangeJumpFlag == 0)
  {
    //�����������Ч���жϣ�������5���������޷����д�б�ʼ�⣬ֱ�ӷ��سɹ���
    for(i = 0; i <= 4; i++)
    {
      if(BlackLeftBigChangeNumx[i] == MaxValUint8)
      {
        return 1;
      }
    }
    //�ı��־λ���´ξͲ������ˡ�
    BlackLeftBigChangeJumpFlag = 1;
  }
  //�ߵ�����˵��ͨ����������Ч���жϡ�
  
  
  //ȡ1��3�����б�ʼ��㡣
  //��Ϊֻ�������㣬����б�ʵļ����ȡб�ʵĳ�ʼ����ķ�ʽ������ȡ��С���˷�������ʡ�ܶ�ʱ�䡣
  tempslope1 = (BlackLeftBigChangeNumy[2] - BlackLeftBigChangeNumy[0]) 
             * LeastSquareMulti   //��������ô�౶������С���˷�һ����
             / (BlackLeftBigChangeNumx[2] - BlackLeftBigChangeNumx[0]);
  tempslope2 = (BlackLeftBigChangeNumy[4] - BlackLeftBigChangeNumy[2]) 
             * LeastSquareMulti   //��������ô�౶������С���˷�һ����
             / (BlackLeftBigChangeNumx[4] - BlackLeftBigChangeNumx[2]);
  BlackLeftBigChangeSlopeStore = tempslope1;
  //С5��б�ʴ����������У����ڴ������tempslope1�����Դ�����㲻���¼������ֶ�����ֵͬ��
  BlackLeft5Slope[BlackLeft5SlopeIndex] = BlackLeftBigChangeSlopeStore;
  BlackLeft5SlopeRow[BlackLeft5SlopeIndex] = newrow;  //��¼����5��б�ʵ���Զ��������
  BlackLeft5SlopeIndex++;
  
  //1. ǰ�����ε�б�����෴�ġ�
  if(tempslope1 >= 0 && tempslope2 < 0)
  {
    //2. ���߲�ֵ�ܴ�ܴ�
    if(tempslope1 >= tempslope2 + BlackLeftBigChangeSlopeLimit)
    {
      //���߲�ֵ��ȷ�ܴ󡣲���ˢ�´���ֵ��
      //if(use == 2)                    //��һ�ַ�����������2�еĵ�2�е���ʱ���óɹ���־λ��
      //{
        //�óɹ���־λ��
        BlackLeftBigChangeFlag = 1;
      //}
      //else
      //{
      //}
      //�˴��в�������С�
      BlackLeftBigChangeNumx[4] = BlackLeftBigChangeNumx[3];
      BlackLeftBigChangeNumx[3] = BlackLeftBigChangeNumx[2];
      BlackLeftBigChangeNumx[2] = BlackLeftBigChangeNumx[1];
      BlackLeftBigChangeNumx[1] = BlackLeftBigChangeNumx[0];
      BlackLeftBigChangeNumx[0] = tempstorex;
      BlackLeftBigChangeNumy[4] = BlackLeftBigChangeNumy[3];
      BlackLeftBigChangeNumy[3] = BlackLeftBigChangeNumy[2];
      BlackLeftBigChangeNumy[2] = BlackLeftBigChangeNumy[1];
      BlackLeftBigChangeNumy[1] = BlackLeftBigChangeNumy[0];
      BlackLeftBigChangeNumy[0] = tempstorey;
      
      //��ǰ��3�������(��4��)��ֵ����Чֵ��ͼ���ϸ�������
      BlackLeftLoc[BlackLeftBigChangeNumx[4]][0] = MaxValUint8;
      BlackLeftLoc[BlackLeftBigChangeNumx[3]][0] = MaxValUint8;
      //BlackLeftLoc[BlackLeftBigChangeNumx[2]][0] = MaxValUint8;    
      
      return 0;
    }
    else
    {
      //ˢ��б�ʴ���ֵ��
      //BlackLeftBigChangeSlopeStore = tempslope;
      return 1;
    }
  }
  //1. ǰ�����ε�б�����෴�ġ�
  else if(tempslope1 < 0 && tempslope2 >= 0)
  {
    //2. ���߲�ֵ�ܴ�ܴ�
    if(tempslope2 >= tempslope1 + BlackLeftBigChangeSlopeLimit)
    {
      //���߲�ֵ��ȷ�ܴ󡣲���ˢ�´���ֵ��
      //if(use == 2)                    //��һ�ַ�����������2�еĵ�2�е���ʱ���óɹ���־λ��
      //{
        //�óɹ���־λ��
        BlackLeftBigChangeFlag = 1;
      //}
      //else
      //{
      //}
      //�˴��в�������С�
      BlackLeftBigChangeNumx[4] = BlackLeftBigChangeNumx[3];
      BlackLeftBigChangeNumx[3] = BlackLeftBigChangeNumx[2];
      BlackLeftBigChangeNumx[2] = BlackLeftBigChangeNumx[1];
      BlackLeftBigChangeNumx[1] = BlackLeftBigChangeNumx[0];
      BlackLeftBigChangeNumx[0] = tempstorex;
      BlackLeftBigChangeNumy[4] = BlackLeftBigChangeNumy[3];
      BlackLeftBigChangeNumy[3] = BlackLeftBigChangeNumy[2];
      BlackLeftBigChangeNumy[2] = BlackLeftBigChangeNumy[1];
      BlackLeftBigChangeNumy[1] = BlackLeftBigChangeNumy[0];
      BlackLeftBigChangeNumy[0] = tempstorey;
      
      //��ǰ��3�������(��4��)��ֵ����Чֵ��ͼ���ϸ�������
      BlackLeftLoc[BlackLeftBigChangeNumx[4]][0] = MaxValUint8;
      BlackLeftLoc[BlackLeftBigChangeNumx[3]][0] = MaxValUint8;
      //BlackLeftLoc[BlackLeftBigChangeNumx[2]][0] = MaxValUint8; 
      
      return 0;
    }
    else
    {
      //ˢ��б�ʴ���ֵ��
      //BlackLeftBigChangeSlopeStore = tempslope;
      return 1;
    }
  }
  //�����෴�����ж��޴�б�ʵ����䡣���سɹ���
  else
  {
    //ˢ��б�ʴ���ֵ��
    //BlackLeftBigChangeSlopeStore = tempslope;
    return 1;
  }
  
}


//�����ġ���������ġ�һ�������ڵġ�ɨ�������صĺ���.���Ծ���Step2Win, CrossSpeWin��������ݡ�
//���ص��������صİ׵�����λ�á�
uint8 BlackGetLeftJustWin(uint8 row, int32 colleft, int32 colright)
{
  uint8 temp1, abs1;
  uint8 tempadd1, tempadd2, tempadd3, tempadd4;
  
  //���ұ߽��޷�
  colleft = BoundaryLimitRe(colleft, 0, CameraRealWidth - 1);
  colright = BoundaryLimitRe(colright, 0, CameraRealWidth - 1);
  
  //�ж��������">"�ܹؼ���û��д">="�ǿ���temp = 0��������������Է�ֹ����������uint8��Ϊ��������������ѭ����
  for( ; colright > colleft; colright--) 
  {
    //�Ұ׵�������ߵĲ
    if(ImgNew[row][colright] > ImgNew[row][colright-1-BlackLeftEdgeNum])
    {
      abs1 = ImgNew[row][colright] - ImgNew[row][colright-1-BlackLeftEdgeNum];
    }
    else
    {
      abs1 = 0;
    }
   
    if( //�����صĵ�һ��������
        //�ڹ��ڣ��׹��ף����
        //�����3����ֵ������Ӧ֮�������ֵ
          (abs1 > LimitLeftWB - LimitLeftWBAdjust[row]) //���ߵĲ��
        &&(ImgNew[row][colright] > LimitLeftW)                     //�׵㹻��
        &&(ImgNew[row][colright-1-BlackLeftEdgeNum] < LimitLeftB)                   //�ڵ㹻��
       )
    {
            //�༸���׵��ȷ�ϡ�������ֹ�Һ����ұߵİױߡ�
            if(colright < CameraRealWidth - 1 - 6)
            {
              tempadd1 = (ImgNew[row][colright+3] > LimitLeftW);
              tempadd2 = (ImgNew[row][colright+4] > LimitLeftW);
              tempadd3 = (ImgNew[row][colright+5] > LimitLeftW);
              tempadd4 = (ImgNew[row][colright+6] > LimitLeftW);
            }
            else
            {
              tempadd1 = 1;
              tempadd2 = 1;
              tempadd3 = 1;
              tempadd4 = 1;
            }       
      
          //�������У�����3������Ϊ�ڵ㣬����4������Ϊ�׵㡣
          if(row > BlackMiddleLine)
          {                        
            temp1 = (
                      (ImgNew[row][colright-2-BlackLeftEdgeNum] < LimitLeftB)
                    &&(ImgNew[row][colright-3-BlackLeftEdgeNum] < LimitLeftB)
                    //&&(ImgNew[row][colright-4-BlackLeftEdgeNum] < LimitLeftB)
                    &&(ImgNew[row][colright+1] > LimitLeftW)
                    &&(ImgNew[row][colright+2] > LimitLeftW)
                    &&(tempadd1 == 1)
                    &&(tempadd2 == 1)
                    &&(tempadd3 == 1)
                    &&(tempadd4 == 1)
                    );
          }
          else
          {
            //�м���� ������2����Ϊ��Ϊ�ڵ㣬����4������Ϊ�׵㡣
            if(row > BlackFarLine)
            {
              temp1 = (
                        (ImgNew[row][colright-2-BlackLeftEdgeNum] < LimitLeftB)
                      //&&(ImgNew[row][colright-3-BlackLeftEdgeNum] < LimitLeftB)
                      &&(ImgNew[row][colright+1] > LimitLeftW)
                      &&(tempadd1 == 1)
                      &&(tempadd2 == 1)
                      &&(tempadd3 == 1)
                      &&(tempadd4 == 1)                        
                      );
            }
            else
            {
              if(row > BlackFarfarLine)
              {
                //Զ������ ������1����Ϊ��Ϊ�ڵ㣬����4������Ϊ�׵㡣
                temp1 = (
                        //(ImgNew[row][colright-2-BlackLeftEdgeNum] < LimitLeftB)
                        (tempadd1 == 1)
                      &&(tempadd2 == 1)
                      &&(tempadd3 == 1)
                      &&(tempadd4 == 1)
                        );                   
              }
              else
              {
                //��Զ�����У�ֻ���������Χ�׵���Ҫ�󣬶���Χ�ڵ�û��Ҫ��
                temp1 = (
                        (tempadd1 == 1)
                      &&(tempadd2 == 1)
                      &&(tempadd3 == 1)
                      &&(tempadd4 == 1)
                        );    
              }
                    
            }
          }
          
          //�����صĵڶ���������
          if(temp1 == 1)
          {
            //�������������㣬���ذ׵�λ�ã����Ǻڵ�λ�ã�           
            return colright;              
            
            //break;          
          }// end of �����ؼ��ĵ�2������
    }// end of �����ؼ��ĵ�1������
  }// end of forѭ��  
  
  
  
  //���һֱ����������߻�û���ҵ������أ�������Чֵ��
  return MaxValUint8;  
  
}




//======================================================================
//��������BlackGetLeftStep1Edge
//��  �ܣ��������ȡ�У���1�׶������⺯��,����������ߵĿ��ɺڵ�
//��  �����������к�row, �ڼ���ʹ��use, ����Ԥ�����־preflag(1��Ԥ����)
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺BlackLeftRealWB[], BlackLeftRealW[], BlackLeftRealB[]
//        BlackLeftLoc[][]
//˵  ����1. �Ե�row�е�����������а׵��ڼ�⣬�ɹ��͸���Ӧ��ֵ����3������ֵ����ʧ����255
//        2. ��������������ʱ������ɹ����������3��ֵ���м�¼���ֽ׶�ֻ�õ��˵�1��ֵ
//        3. �������漰3���ؼ�ֵ��ʵ��ֵ�ļ�¼��CrossFlag������Ͳ��ü�¼��Ҳ�Ͳ��ø��ģ�
//        4. ��1���ڵ�Ҳû�У����߳���3���ڵ㣬����ʧ�ܡ�
//        5. ��Ҫ�ĳɺڵ��׵ļ�⣬���������⣬ֻ����ĵ�һ���������ɣ��ܷ��㡣
//======================================================================
uint8 BlackGetLeftStep1Edge(uint8 row, uint8 use, uint8 preflag)
{
  uint8 index, col, temp1;
  uint8 abs1;
  uint8 tempadd1, tempadd2, tempadd3, tempadd4;
  uint8 avgr1, avgl1;
  uint8 i;
  
  //������һ����Чͼ���������Ԥ����һ��ͼ������Һ���ɨ����㣬���������Ҫ����������һ�����߿�ȡ� 
  col = (uint8)MinRe((int32)BlackLeftEdgeStartCol+10, CameraRealWidth - 1);

  //���߿�ʼɨ�衣
  //�����Ԥ����Ҳ���ÿ�����������ֱ�������߾ͺá�
  if((BlackGetPreDir == 1)
  &&(BlackRightLoc[row][0] != MaxValUint8)
  &&(preflag == 0)
    )
  {
    //�����һ��ͼ�ǵ��ߣ�������ɨ�������������ߵ��ұ�һ�����߿�ȡ�
    if(
      (row > CameraHight - 5)
    &&(SingleBlackLastAllFlag == 1)
       )
    {
      col = MaxRe(col, MinRe(CameraRealWidth - 1, BlackRightLoc[row][0] + SingleBlackWidthMax[row]));
    }
    //�����һ��ͼ���ǵ��ߣ����������û�вɼ������ߣ��Ǿ���Ϊ�����ܳ��ֵ��ߡ���������ɨ�������������ߵ����
    else if(
           (row <= CameraHight - 5)
         //&&(SingleBlackLastAllFlag == 0)
            )
    {
      col = MinRe(col, BlackRightLoc[row][0]);
    }
    else
    {
      col = MinRe(col, BlackRightLoc[row][0]);
    }
  }
  else
  {    
  }
  
  //����Ԥ��ֵ��¼
  BlackLeftPredictL[row] = 4 + BlackLeftEdgeNum;
  BlackLeftPredictR[row] = col;
  
  index = 0;         //���ɵ�����
  //���м䵽�����ɨ�裬��1�������
  for(; col >= 4+BlackLeftEdgeNum; col--) 
  {
      //�Ұ׵�����ڵ�Ĳ
      if(ImgNew[row][col] > ImgNew[row][col-1-BlackLeftEdgeNum])
      {
        abs1 = ImgNew[row][col] - ImgNew[row][col-1-BlackLeftEdgeNum];
      }
      else
      {
        abs1 = 0;
      }
      
      if( //�����صĵ�һ��������
          //�ڹ��ڣ��׹��ף����
          //�����3����ֵΪ��ʼֵ����������Ӧ֮�������ֵ��
          (abs1 > LimitLeftWB - LimitLeftWBAdjust[row]) //���ߵĲ��
        //��������������һ�£��Ϳ���ʵ�ֺڵ��׵������⣬���������⡣
        &&(ImgNew[row][col] > LimitLeftW)                     //�׵㹻��
        &&(ImgNew[row][col-1-BlackLeftEdgeNum] < LimitLeftB)                   //�ڵ㹻��
         )
      {
            //�༸���׵��ȷ�ϡ�������ֹ�Һ����ұߵİױߡ�
            if(col < CameraRealWidth - 1 - 6)
            {
              tempadd1 = (ImgNew[row][col+3] > LimitLeftW);
              tempadd2 = (ImgNew[row][col+4] > LimitLeftW);
              tempadd3 = (ImgNew[row][col+5] > LimitLeftW);
              tempadd4 = (ImgNew[row][col+6] > LimitLeftW);
            }
            else
            {
              tempadd1 = 1;
              tempadd2 = 1;
              tempadd3 = 1;
              tempadd4 = 1;
            }       
          //�����صĵڶ���������
          //�������У�����3������Ϊ�ڵ㣬����4������Ϊ�׵㡣
          if(row > BlackMiddleLine)
          {                                
            temp1 = (
                      (ImgNew[row][col-2-BlackLeftEdgeNum] < LimitLeftB)
                    &&(ImgNew[row][col-3-BlackLeftEdgeNum] < LimitLeftB)
                    &&(ImgNew[row][col-4-BlackLeftEdgeNum] < LimitLeftB)
                    &&(ImgNew[row][col+1] > LimitLeftW)
                    &&(ImgNew[row][col+2] > LimitLeftW)
                    &&(tempadd1 == 1)
                    &&(tempadd2 == 1)
                    &&(tempadd3 == 1)
                    &&(tempadd4 == 1)
                    );
          }          
          else
          {
            //Զ������ ������2����Ϊ��Ϊ�ڵ㣬����4������Ϊ�׵㡣
            if(row > BlackFarLine)
            {
              temp1 = (
                        (ImgNew[row][col-2-BlackLeftEdgeNum] < LimitLeftB)
                      &&(ImgNew[row][col-3-BlackLeftEdgeNum] < LimitLeftB)
                      &&(ImgNew[row][col+1] > LimitLeftW)
                      &&(tempadd1 == 1)
                      &&(tempadd2 == 1)
                      &&(tempadd3 == 1)
                      &&(tempadd4 == 1)
                      );
            }            
            else
            {
              if(row > BlackFarfarLine)
              {
                //Զ������ ������1����Ϊ��Ϊ�ڵ㣬����4������Ϊ�׵㡣
                temp1 = (
                        (ImgNew[row][col-2-BlackLeftEdgeNum] < LimitLeftB)
                      &&(tempadd1 == 1)
                      &&(tempadd2 == 1)
                      &&(tempadd3 == 1)
                      &&(tempadd4 == 1)
                        );
              }
              else
              {
                //��Զ���У������䣬����Χ�׵�ȷ�Ͼ��У�����Χ�ڵ�û��Ҫ��
                temp1 = (
                        (tempadd1 == 1)
                      &&(tempadd2 == 1)
                      &&(tempadd3 == 1)
                      &&(tempadd4 == 1)
                        );
              }
            }
          }

          if(temp1)
          {            
              //������ɹ���ȡ�ڵ�
              BlackLeftLoc[row][index] = col - 1 - BlackLeftEdgeNum;          
              index++;
              break;
            
          }    //end of �����صĵڶ�������
      }   //end of �����صĵ�һ������
  }// end of ���м䵽�����ɨ�裬��1�������
  
  //1�����ɺڵ�Ҳû�У��򱨴�
  if(index == 0)
  {
    //����Ǻ���Ԥ����ĵ��ã�Ҳ���ø����⼸��ֵ��
    if(preflag == 0)
    {
      //��3���ؼ�ֵ��ʵ��ֵ����
      BlackLeftRealClear();
    }
    //���ж�λ����ʧ�ܣ�����Чֵ
    BlackLeftLoc[row][0] = MaxValUint8;
    return 0;
  }
  
  //���Ǻ���Ԥ����ĵ��ã�����д�б�ʼ�⡣
  if(preflag == 0)
  {
    //���ȷ��ǰ����Ҫ���д�б�ʵļ�⡣�����ɹ�����˵����⵽���㡣
    if(BlackLeftBigChangeCheck(row, use) == 1)
    {
      //�����߿�ʼ��ɨ��
      //���Ѿ�ȷ��Ϊ�����ˣ��Ͳ����ٴ�ȷ���ˡ�
      if(
        (SingleBlackAllFlag == 0) 
      &&(BlackGetPreDir == 1)   
        )
      {
        //���������Һ��߾����ɹ��������������ߵ����һ����Χ�ڣ�������ж�Ϊ���ߡ�
        if((BlackLeftLoc[row][0] != MaxValUint8)
         &&(BlackRightLoc[row][0] != MaxValUint8)
         &&(BlackRightLoc[row][0] < BlackLeftLoc[row][0])
         &&(BlackRightLoc[row][0] - BlackLeftLoc[row][0] < SingleBlackWidthMax[row]) //����Ǹ���Ҳ�����㣬���Ա���С�ڡ�
        )
        {
          //���5���׵��ƽ��ֵ�Ƿ����������������ǵ��ߣ����������������Чֵ��
          if(
            (BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 5 < 0)
          ||(BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 5 > CameraRealWidth - 1)
            )
          {
            //����5���㡣
            //��Ϊ���й������䣬����Ҫ�����ֻ���������С�
            if(row > CameraHight - 5)
            {
                for(i = 0; i <= 4; i++)
                {
                    BlackLeftBigChangeNumx[i] = MaxValUint8;
                    BlackLeftBigChangeNumy[i] = MaxValUint8;
                }
                BlackLeftBigChangeJumpFlag = 0;
            }
            else
            {
            }
            
            //���ж�λ����ʧ�ܣ�����Чֵ
            BlackLeftLoc[row][0] = MaxValUint8;
            return 0;
          }
          else
          {
            //�������ߵİ׵�ƽ��ֵ
            avgr1 = (ImgNew[row][BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 1]
                   + ImgNew[row][BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 2]
                   + ImgNew[row][BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 3]
                   + ImgNew[row][BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 4]
                   + ImgNew[row][BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 5])
                   / 5;
            //�������ߵİ׵�ƽ��ֵ
            avgl1 = (ImgNew[row][BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 1]
                   + ImgNew[row][BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 2]
                   + ImgNew[row][BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 3]
                   + ImgNew[row][BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 4]
                   + ImgNew[row][BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 5])
                   / 5;    
            if(AbsInt(avgr1 - avgl1) < 20)
            {
              //5���׵�֮��Ĳ��С�������жϳɹ���
              SingleBlackFlag[row] = 1;      
              //SingleBlackAllFlag = 1;   //�ܷ�ͼ��ĵ��߱�־��ֻҪ��һ�м�ⵥ�߳ɹ�������1.
            }
            else
            {
              //5���׵�֮��Ĳ��̫�󣬵����ж�ʧ�ܡ�
              //��Ϊ���й������䣬����Ҫ�����ֻ���������С�
              if(row > CameraHight - 5)
              {
                  for(i = 0; i <= 4; i++)
                  {
                      BlackLeftBigChangeNumx[i] = MaxValUint8;
                      BlackLeftBigChangeNumy[i] = MaxValUint8;
                  }
                  BlackLeftBigChangeJumpFlag = 0;
              }
              else
              {
              }             
              
              //���ж�λ����ʧ�ܣ�����Чֵ
              BlackLeftLoc[row][0] = MaxValUint8;
              return 0;              
            }
          }          
        }
        else
        {
          //������е��߱�־Ϊ0.
          SingleBlackFlag[row] = 0;
        }
      }
      //�����߿�ʼ��ɨ�裬���߲��ü���Ƿ��е��ߣ�����ȥ��⼴�ɡ�
      else
      {
      }
      
      //û�б����ͻ��ߵ�����ڵ���ҳɹ�������1��2��3���ڵ�
      //return 1;
    }
    else
    {
      //ûͨ����б�ʼ�⡣
      BlackLeftBigChangeCheckRow[row] = 1;
      BlackLeftBigChangeCheckAllRow = 1;
      
      //return 1;    
      
      
      //���ж�λ����ʧ�ܣ�����Чֵ
      BlackLeftLoc[row][0] = MaxValUint8;
      return 0;    
    }
  }
  //���Ǻ���Ԥ����ĵ��ã�������д�б�ʼ�⣬ֱ�ӷ��سɹ���
  else
  {
    //return 1;    
  }
  
  //����Ǻ���Ԥ����Ҳ���ø����⼸��ֵ
  if(preflag == 0)
  {
    //��������˵�������صĶ������������㣬����ڵ��¼�׶�
    //��¼3���ؼ�ֵ��ʵ����Ϣ����Ϊ����Ĳο���
    if(use == 1)
    {
      BlackLeftRealWB[0] = ImgNew[row][col] - ImgNew[row][col-1-BlackLeftEdgeNum]; 
      BlackLeftRealW[0] = ImgNew[row][col];
      BlackLeftRealB[0] = ImgNew[row][col-1-BlackLeftEdgeNum];
    }
    else if(use == 2)
    {
      BlackLeftRealWB[1] = ImgNew[row][col] - ImgNew[row][col-1-BlackLeftEdgeNum]; 
      BlackLeftRealW[1] = ImgNew[row][col];
      BlackLeftRealB[1] = ImgNew[row][col-1-BlackLeftEdgeNum];
    }
    else
    {
    }
  }
  else
  {
  }
  
  return 1;
  
}



//======================================================================
//��������BlackGetLeftStep2Win
//��  �ܣ��������ȡ�У���2�׶δ����������⺯��
//��  �����������к�row, ���ڴ�Сwin, Ԥ���������λ��predict, �ڼ���ʹ��use
//��  �أ�1�ɹ�  0ʧ��
//Ӱ  �죺BlackLeftLoc[][0]
//˵  ����1. �����������������ܼ��ɹ���ֻ��һ����ļ�¼��
//        2. ������û�м�⵽������ʧ�ܡ�
//        3. ����С���Լ���һ����ʱ�䣬���������б�ʹ������������п��ܼ�ⲻ����     
//======================================================================
uint8 BlackGetLeftStep2Win(uint8 row, uint8 win, uint8 predict, uint8 use)
{
  uint8 col, temp;
  
  //�ڹ滮�õĴ����ڣ������������������
  //��ֹ���
  
  //����߽������
  if(predict <= win)
  {
    temp = 4 + BlackLeftEdgeNum;
  }  
  else
  {
    temp = predict - win;
    if(temp < 4 + BlackLeftEdgeNum)
    {
      temp = 4 + BlackLeftEdgeNum;
    }
    else 
    {
    } 
  }
  
  //���ұ߽������
  if(predict + win > CameraRealWidth - 1)
  {
    col = CameraRealWidth - 1;  
  }
  else
  {
    col = predict + win;  
  }
  
  //���߿�ʼɨ��ʱ�����ߵ�ɨ���ұ߽�����ڸ�����Ч�Һ��ߵ���ߡ�
  if((BlackGetPreDir == 1)
  &&(SingleBlackAllFlag == 0)   
  &&(BlackRightLoc[row][0] != MaxValUint8)
    )
  {
    col = MinRe(col, BlackRightLoc[row][0]);
  }
  else
  {
  }
  
  //����Ԥ��ֵ��¼
  BlackLeftPredictL[row] = temp;
  BlackLeftPredictR[row] = col;
  
  //�ұ߽�С����߽磬����ʧ��
  if(col <= temp) return 0;
  
  //����ɨ��������
  col = BlackGetLeftJustWin(row, temp, col);
  if(col != MaxValUint8)
  {
    //�������������㣬ֱ�Ӽ�¼�õ�Ϊ���ߣ����ؼ���
    BlackLeftLoc[row][0] = col - 1 - BlackLeftEdgeNum;

    //���ȷ��ǰ����Ҫ���д�б�ʵļ�⡣�����ɹ�����˵����⵽���㡣
    if(BlackLeftBigChangeCheck(row, use) == 0)
    {              
      //ûͨ����б�ʼ�⡣
      BlackLeftBigChangeCheckRow[row] = 1;
      BlackLeftBigChangeCheckAllRow = 1;
   
      
      //���ж�λ����ʧ�ܣ�����Чֵ
      BlackLeftLoc[row][0] = MaxValUint8;
      return 0;
    }
    else
    {
    }
    
    //ͨ���˴�б�ʼ�⡣
    //��¼3���ؼ�ֵ��ʵ����Ϣ����Ϊ����Ĳο���
    if(use == 1)
    {
      BlackLeftRealWB[0] = ImgNew[row][col] - ImgNew[row][col-1-BlackLeftEdgeNum]; 
      BlackLeftRealW[0] = ImgNew[row][col];
      BlackLeftRealB[0] = ImgNew[row][col-1-BlackLeftEdgeNum];
    }
    else if(use == 2)
    {
      BlackLeftRealWB[1] = ImgNew[row][col] - ImgNew[row][col-1-BlackLeftEdgeNum]; 
      BlackLeftRealW[1] = ImgNew[row][col];
      BlackLeftRealB[1] = ImgNew[row][col-1-BlackLeftEdgeNum];
    }
    else
    {
    }     
    
    return 1;                  
  }
  else
  {
    //������û��ɨ�赽�����أ����еĺ���λ�ü�Ϊ��Чֵ������0ʧ��.
    BlackLeftLoc[row][0] = MaxValUint8;
    return 0;   
  }
  
}


//======================================================================
//��������BlackGetLeftStep1Scan
//��  �ܣ��������ȡ�У���1�׶ε���ɨ�躯��
//��  ����ɨ����ʼ��FirstLine, ɨ�������LastLine
//��  �أ�0~CameraHight-1���� 255�ɼ�ʧ��
//Ӱ  �죺BlackLeftRealWB[], BlackLeftRealW[], BlackLeftRealB[], BlackLeftLoc[][],
//        LimitLeftWB, LimitLeftW, LimitLeftB
//˵  ����1. �����������ص�1�׶���ɨ�裬Ҳ������ʮ���ټ��ʱ����ɨ��
//        2. ������1�׶�ɨ��ʱ�������3���ؼ���ֵ��ֵ��
//             
//======================================================================
uint8 BlackGetLeftStep1Scan(uint8 FirstLine, uint8 LastLine, uint8 CrossFlag)
{
    uint8 row, temp1, temp2;
    uint8 abs1;
    uint8 tempWB, tempW, tempB;
    uint8 flag, i;
    
    flag = 0;
    //�����BlackStep1Size���ò�ֵ���Һ���
    for(row = FirstLine; row > LastLine; row -= 2)
    {
      //�ж��Ƿ��������м�⵽���䣬���ɺڵ���3���㣬��ȡ����һ�����Ǻ���Ԥ����
      temp1 = BlackGetLeftStep1Edge(row, 1, 0);
      temp2 = BlackGetLeftStep1Edge(row-1, 2, 0);
      if(temp1 == 1 && temp2 == 1)//���������ôд������Ƕ��if����Ϊ&&���ص�
      {
        abs1 = AbsRe(BlackLeftLoc[row-1][0], BlackLeftLoc[row][0]);
        //��һ���ж��������еĺڵ�ļ���Ƿ�С������ȡ��1�����ɺڵ㡣
        if(abs1 < BlackLeftStep1ScanMinus)
        {
          //��⵽�������ĺ��ߣ�ֹͣ��ֵ���������أ���ʡʱ�䣬��������2�׶�
          //�������ʮ���ټ���������͸���һ��ʵ�ʵ�3���ؼ�ֵ�����򲻸��¡�
          if(CrossFlag == 1)
            {
              //��ֵ�Ĵ�������ԣ�ȣ��������½硣
              tempWB = (BlackLeftRealWB[0] + BlackLeftRealWB[1]) / 2 - LimitLeftWBMargin; 
              if(tempWB < LimitLeftWBMin) tempWB = LimitLeftWBMin;
              else if(tempWB > LimitLeftWBMax) tempWB = LimitLeftWBMax;
              else ;
              LimitLeftWB = tempWB;
              
              //�׵�Ĵ�������ԣ�ȣ��������½硣
              tempW = (BlackLeftRealW[0] + BlackLeftRealW[1]) / 2 - LimitLeftWMargin;
              if(tempW < LimitLeftWMin) tempW = LimitLeftWMin;
              else if(tempW > LimitLeftWMax) tempW = LimitLeftWMax;
              else ;
              LimitLeftW = tempW;
              
              //�ڵ�Ĵ�������ԣ�ȣ��������½硣
              tempB = (BlackLeftRealB[0] + BlackLeftRealB[1]) / 2 + LimitLeftBMargin;
              if(tempB < LimitLeftBMin) tempB = LimitLeftBMin;
              else if(tempB > LimitLeftBMax) tempB = LimitLeftBMax;
              else ;
              //��ɫ��ֵ���ܳ�����ɫ
              if(tempB >= LimitLeftW)
              {
                tempB = LimitLeftW - 1;
              }
              else
              {
              }
              
              LimitLeftB = tempB;
            }
          break;
        }
        else
        {
          //�������кڵ���̫����Ϊ����ĵ㡣
          BlackLeftLoc[row][0] = MaxValUint8;
          BlackLeftLoc[row-1][0] = MaxValUint8;
          //������������ĸ�λ��
          BlackLeftBigChangeNumx[3] = MaxValUint8;
          BlackLeftBigChangeNumx[4] = MaxValUint8;
          BlackLeftBigChangeNumy[3] = MaxValUint8;
          BlackLeftBigChangeNumy[4] = MaxValUint8;
          BlackLeftBigChangeJumpFlag = 0;
        }
      }
      else if(temp1 == 0 && temp2 == 1)
      {
        //�ߵ����˵��˫���߼��ɹ�֮ǰ��˫��֮һ�ɼ��ɹ���
        flag = 1;
      }
      else if(temp1 == 1 && temp2 == 0)
      {
        //�ߵ����˵��˫���߼��ɹ�֮ǰ��˫��֮һ�ɼ��ɹ���
        flag = 1;
      }
      else
      {
      }
    }   
    
    //�����BlackStep1Size��Ҳû�м�⵽�����ĺ��ߣ�˵�����߼��ʧ��
    if(row <= LastLine)
    {
      return MaxValUint8;
    }               
    else
    {
        //˫���߼��ɹ� �� ˫���߼��ɹ�֮ǰ��˫��֮һ�ɼ��ɹ���
        if(flag == 1)
        {
            //��ǰ���˫��֮һ��ȥ����
            for(i = FirstLine; ; i--)
            {
                if(i == row) break;
                BlackLeftLoc[i][0] = MaxValUint8;                
            }
            
            //��һ��scan
            if(CrossFlag == 1)
            {
              //��ǰ3����б�ʼ�ⴢ��ֵ��ȥ��������2�����ã���Ϊ�ǶԵġ�
              for(i = 0; i <= 2; i++)
              {
                  BlackLeftBigChangeNumx[i] = MaxValUint8;
                  BlackLeftBigChangeNumy[i] = MaxValUint8;
                  BlackLeftBigChangeJumpFlag = 0;   //Сϸ��
              }
            }
            else
            {
            }
        }
        else
        {

        }
        
        return row;
    }
  
}

//======================================================================
//��������BlackLeftCrossStep3
//��  �ܣ�������ȡ�У�ʮ�ּ���3�׶Σ��Բ��ߺ���
//��  ������1����Ч���ߵ����һ��FirstLine�� ��2����Ч���ߵĵ�һ��LastLine
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺BlackLeftLoc[][0]
//˵  ����1. ������һЩ�������㣬��ռʱ�䣬�ڵ��ñ�����ʱҪ���أ�������Ҫ�á�
//        2. �������������ߵ�˼·�ܲ���floatǿת��uint8ǿת�õúܺá�
//             
//======================================================================
uint8 BlackLeftCrossStep3(uint8 FirstLine, uint8 LastLine)
{
  int32 delta_x, delta_y, delta, index;
  uint8 row, temp1, temp2;
  uint8 i;
  //uint8 temp3, temp4, flag1, flag2;
  
  //��ʼ�бȽ����л��ߣ�����
  if(LastLine >= FirstLine)
  {
    //uart_sendN(UART0, (uint8 *)"\nError In BlackLeftCrossStep3!", 30);
    return 0;  
  }
  
  //�п��ܳ��ֱ���б�ʼ��ɾ�����������������¸��к����ж�Ϊ���󣬾Ͳ�����ʮ�ֲ����ˡ�
  if(BlackLeftLoc[LastLine][0] == MaxValUint8)
  {
    //����ʧ��ǰɨƨ��
    for(i = FirstLine - 1; ; i--)
    {
      BlackLeftLoc[i][0] = MaxValUint8;
      if(i == 0) break;
    }
    
    return 0;
  }
  else
  {
  }
  
  temp1 = BlackLeftLoc[FirstLine][0];
  temp2 = BlackLeftLoc[LastLine][0];
  
  /*
  flag = 1;
  flag = 2;
  //ȷ������������ֱ�Ǵ��ĵ㣬Ҳ��������6������Ϊ�ڵ�
  if(temp1 <= (CameraRealWidth - 9))
  {
    temp3 = (
            (ImgNew[FirstLine+1][temp1+6] < LimitLeftB)
          &&(ImgNew[FirstLine+1][temp1+7] < LimitLeftB)
          &&(ImgNew[FirstLine+1][temp1+8] < LimitLeftB)
          );
    if(temp3)
    {
      flag1 = 0;  
    }
  }
  
  if(temp2 <= (CameraRealWidth - 9))
  {
    temp4 = (
            (ImgNew[LastLine-1][temp2+6] < LimitLeftB)
          &&(ImgNew[LastLine-1][temp2+7] < LimitLeftB)
          &&(ImgNew[LastLine-1][temp2+8] < LimitLeftB)
          );
    if(temp4)
    {
      flag2 = 0;  
    }
  }
  
  if((flag1 == 0) || (flag2 == 0))
  {
    return 0;  
  }
  
  */
  
  delta_y = FirstLine - LastLine;
  
  
  //б������
  if(temp1 < temp2)
  {
    //�Ŵ�BlackLeftCrossStep3Multi����
    delta_x = temp2 - temp1;  
    delta = delta_x * BlackLeftCrossStep3Multi / delta_y; 
    
    index = 1;
    for(row = FirstLine - 1; row >= LastLine + 1; row-- )
    {
      //ÿ������һ���
      BlackLeftLoc[row][0] = (uint8)(BlackLeftLoc[FirstLine][0] + delta * index / BlackLeftCrossStep3Multi);
      index += 1;
    }
  }
  //б������
  else if(temp1 > temp2)
  {
    //�Ŵ�BlackLeftCrossStep3Multi����
    delta_x = temp1 - temp2;
    delta = delta_x * BlackLeftCrossStep3Multi / delta_y;
    
    index = 1;
    for(row = FirstLine - 1; row >= LastLine + 1; row-- )
    {
      //ÿ������һ���
      BlackLeftLoc[row][0] = (uint8)(BlackLeftLoc[FirstLine][0] - delta * index / BlackLeftCrossStep3Multi);
      index += 1;
    }
  }
  //б��ֱ�ߣ������̫���ܳ���
  else
  {
    for(row = FirstLine - 1; row >= LastLine + 1; row-- )
    {
      //����ͬ��ֵ
      BlackLeftLoc[row][0] = temp1;
    }
  }
  
  return 1;
    
}

//======================================================================
//��������BlackLeftCrossConfirm
//��  �ܣ�ʮ���ټ��ʱ ����ͷ��Ч�Ե�ȷ�ϡ�
//��  ������1�κ��ߵ���ʵ������Row1RealLastLine����2�κ��ߵ���ʵ��ʼ��Row2RealFirstLine
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺��
//˵  ����1. Ϊ��Ӧ��270�����ʮ���������������д������û�й��࿼�����������
//      
//             
//======================================================================
uint8 BlackLeftCrossConfirm(uint8 Row1RealLastLine, uint8 Row2RealFirstLine)
{
  uint8 row, index;
  uint8 x[BlackCrossConfirmNum];
  uint8 y[BlackCrossConfirmNum];
  
  int32 a0, a1, temp;

  //1. �Ƚ��еڶ��κ�����ʼ�㷽���ж�������������ʮ�ָ��з������ж�Ϊ����㡣ֱ�ӷ���0.
  if(BlackLeftLoc[Row2RealFirstLine][0] > BlackLeftLoc[Row2RealFirstLine-1][0]) 
  {
    return 0;
  }
  //2. �ٽ��еڶ��κ�����ʼ�����б���ж���Ҳ���Ƕ�������в����޶���̫�����п����Ǵ�����䡣��Ի���ʮ���󲹡�
  else if((BlackLeftLoc[Row2RealFirstLine][0] < BlackLeftLoc[Row2RealFirstLine-1][0])
   &&(BlackLeftLoc[Row2RealFirstLine-1][0] - BlackLeftLoc[Row2RealFirstLine][0] >= 3)
     )
  {
    return 0;
  }
  //3. �ٶ���һ��ͼ������б�ʺ�����ͷ���м�顣���������б��������ͷ��Ϊ��û���£���������һ��ͼ�ġ���Ի���ʮ���󲹡�
  else if((SlopeR > BlackCrossConfirmSlopeLimit) //��һ��ͼ������б�ʺܴ�
   &&(BlackRightHeadLine < BlackCrossConfirmHeadLineLimit) //��һ��ͼ��������ͷ�Ƚϸߡ�����ֹ��Ϊ���ر�̶���ɵ�б�ʲ�׼ȷ��
     )
  {
    return 0;
  }
  else
  {
  }
  
  //��һ�κ���̫�̣��޷������ȷ��ʱ�����Ҫ�������ǲ��ǹ������������������Ϊ��ȷ��
  //if(Row1RealLastLine >= CameraHight - 5 && Row2RealFirstLine > Row1RealLastLine + BlackLeftCrossConfirmGapLine) return 1;
  //if(Row1RealLastLine >= CameraHight - 5) return 0;
  
  //�����Ͻ�Ϊԭ�㣬����Ϊx��������0~49��������Ϊy��������(0~249)
  index = 0;
  for(row = Row1RealLastLine; ; row++)
  {
    //��Ч�еļ�¼
    if(BlackLeftLoc[row][0] != MaxValUint8)
    {
      y[index] = BlackLeftLoc[row][0];
      x[index] = row;
      index++;
    }
    //�������࣬��������
    if(index == BlackCrossConfirmNum) break;
    //ֱ���������û�дչ��㹻�ĵ�����˵����һ����Ч����̫�̣��޷������ȷ�ԣ�ֱ�ӷ���1.
    if(row == CameraHight - 1) 
    {
      if(index == 0) return 0;
      //�жϵڶ��κڵ�����ǲ����ڵ�һ�κڵ�ĩβ���ұ�һ����Χ��
      if(BlackLeftLoc[Row2RealFirstLine][0] > y[0] && BlackLeftLoc[Row2RealFirstLine][0] - y[0] < 50)
      {
        return 1;
      }
      else
      {
        return 0;
      }      
    }
    else
    {
    }
  }
  
  //��С���˷�
  //y = a0 + a1 * x
  a1 = LeastSquarea1(x, y, BlackCrossConfirmNum);
  
  //�ж�б���ǲ��Ǵ����µ����ϣ�����ǣ��򷵻�ʧ�ܡ�
  if(a1 > BlackLeftCrossConfirmSlopeLimit) return 0;
  
  a0 = LeastSquarea0(x, y, a1, BlackCrossConfirmNum);
  
  //tempΪ��2�κ�����ʼ�б�Ӧ���ڵ�λ�á�
  temp = (a0 + a1 * Row2RealFirstLine) / LeastSquareMulti;

  //��������޶��ڴ���
  if(
    (BlackLeftLoc[Row2RealFirstLine][0] > temp - BlackCrossConfirmWin) 
  &&(BlackLeftLoc[Row2RealFirstLine][0] < temp + BlackCrossConfirmWin)  //���ҵ�ֵ̫��Ļ������ڡ���˫�ϵ�����ʱ�����ʮ�����ߡ�
    )
  {
    return 1;
  }
  else
  {
    return 0;
  }
    
   
}




//======================================================================
//��������BlackGetLeftCrossSpeWin
//��  �ܣ������ʮ���ټ��ʱ�����ڵ�����ɨ��
//��  �����������к�row, ������߽�colleft, �����ұ߽�colright, �ڼ���ʹ��use.
//��  �أ�1�ɹ�  0ʧ��
//Ӱ  �죺BlackLeftLoc[][0]
//˵  ����1. �����������������ܼ��ɹ���ֻ��һ����ļ�¼��
//        2. ������û�м�⵽������ʧ�ܡ�  
//        3. ����ͨ����ɨ�費һ����ǰ�����������Ԥ��ֵ�ʹ��ڴ�С�����������ұ߽硣
//======================================================================
uint8 BlackGetLeftCrossSpeWin(uint8 row, uint8 colleft, uint8 colright, uint8 use)
{
  uint8 col;
  
  //�ڹ滮�õĴ����ڣ������������������
  //��ֹ���
  
  //����߽������
  if(colleft < 4 + BlackLeftEdgeNum)
  {
    colleft = 4 + BlackLeftEdgeNum;
  }
  else 
  {
  } 

  //���ұ߽������
  if(colright > CameraRealWidth - 1)
  {
    colright = CameraRealWidth - 1;  
  }
  else
  {
  }
  
  //���߿�ʼɨ��ʱ������ɨ����ұ߽�����ڸ�����Ч�Һ��ߵ���ߡ�
  if((BlackGetPreDir == 1)
   &&(BlackRightLoc[row][0] != MaxValUint8)
     )
  {
    colright = MinRe(colright, BlackRightLoc[row][0]);
  }
  else
  {
  }
  
  //����Ԥ��ֵ��¼
  BlackLeftPredictL[row] = colleft;
  BlackLeftPredictR[row] = colright;
  
  //��߽����ұ߽��ұߣ�ֱ�ӷ���ʧ�ܡ�
  if(colleft >= colright) return 0;
  
  //����ɨ��������
  col = BlackGetLeftJustWin(row, colleft, colright);
  if(col != MaxValUint8)
  {
    //�������������㣬ֱ�Ӽ�¼�õ�Ϊ���ߣ����ؼ���
    BlackLeftLoc[row][0] = col - 1 - BlackLeftEdgeNum;

    //���ȷ��ǰ����Ҫ���д�б�ʵļ�⡣�����ɹ�����˵����⵽���㡣
    if(BlackLeftBigChangeCheck(row, use) == 0)
    {              
      //ûͨ����б�ʼ�⡣
      BlackLeftBigChangeCheckRow[row] = 1;
      BlackLeftBigChangeCheckAllRow = 1;
   
      
      //���ж�λ����ʧ�ܣ�����Чֵ
      BlackLeftLoc[row][0] = MaxValUint8;
      return 0;
    }
    else
    {
    }
    
    //ͨ���˴�б�ʼ�⡣
    //��¼3���ؼ�ֵ��ʵ����Ϣ����Ϊ����Ĳο���
    if(use == 1)
    {
      BlackLeftRealWB[0] = ImgNew[row][col] - ImgNew[row][col-1-BlackLeftEdgeNum]; 
      BlackLeftRealW[0] = ImgNew[row][col];
      BlackLeftRealB[0] = ImgNew[row][col-1-BlackLeftEdgeNum];
    }
    else if(use == 2)
    {
      BlackLeftRealWB[1] = ImgNew[row][col] - ImgNew[row][col-1-BlackLeftEdgeNum]; 
      BlackLeftRealW[1] = ImgNew[row][col];
      BlackLeftRealB[1] = ImgNew[row][col-1-BlackLeftEdgeNum];
    }
    else
    {
    }     
    
    return 1;   
  }
  else
  {
    //������û��ɨ�赽�����أ����еĺ���λ�ü�Ϊ��Чֵ������0ʧ��.
    BlackLeftLoc[row][0] = MaxValUint8;
    return 0; 
  }
}



//======================================================================
//��������BlackGetLeftCrossSpeScan
//��  �ܣ�ʮ���ټ��ʱ����ͷ������ɨ��
//��  ������2�κ��ߵ�Ԥ����ʼ��Row2FirstLine�� ��2�κ��ߵ�Ԥ�������Row2LastLine��
//        ���һ�εĴ���Ԥ��ֵLastWinPredict
//��  �أ�MaxValUint8ʧ�ܣ�����ɹ���
//Ӱ  �죺
//˵  ����
//      
//             
//======================================================================
uint8 BlackGetLeftCrossSpeScan(uint8 Row2FirstLine, uint8 Row2LastLine, uint8 LastWinPredict)
{
  uint8 row;
  uint8 temp1, temp2, temppredict, tempminus;
  uint8 colleft, colright;
  uint8 i;
  
  //���һ�εĴ���Ԥ��ֵ��
  temppredict = LastWinPredict;
  
  //colleft��ȷ��
  //���������ɨ�裬colleft��ʾ֮ǰ������Ч���ߵ�����㡣
  //�ҵ�1����Ч����ߡ�
  for(i = Row2FirstLine+1; ; i++)
  {
    if(BlackLeftLoc[i][0] != MaxValUint8)
    {
      colleft = BlackLeftLoc[i][0];
      break;
    }
    else
    {
    }
    //��һֱ�����һ����û����Ч����ߣ��򷵻�ʧ�ܡ������ϲ������ߵ����
    if(i == CameraHight - 1) return MaxValUint8;
  }
  //��ʱ��������ߵ�����ߣ�Ҳ���൱�������ұߵ�����ߡ�
//  //���������Ч����ߡ�
//  for( ; ; i++)
//  {
//    if(BlackLeftLoc[i][0] != MaxValUint8)
//    {
//      if(BlackLeftLoc[i][0] < colleft)
//      {
//        colleft = BlackLeftLoc[i][0];
//      }
//      else
//      {
//      }
//    }
//    else
//    { 
//    }
//    
//    if(i == CameraHight - 1) break;
//  }

  //���п���ɨ������ߡ�
  for(row = Row2FirstLine; ; row -= 2)
  {
    //colright��ȷ��
    colright = BoundaryLimitRe(temppredict + BlackLeftWinVal * 2,
                               0,
                               CameraRealWidth - 1);        
    
    //Ϊ�˷�ֹ�����д���������߲���С��BlackLeftEdgeStartColOffset��
    colright = MaxRe(colright, CameraRealWidth / 2 - 1 + BlackLeftEdgeStartColOffset[row]);
    
    //����2�м��ڵ�,���⿪��ɨ�衣
    temp1 = BlackGetLeftCrossSpeWin(row, colleft, colright, 1);
    temp2 = BlackGetLeftCrossSpeWin(row-1, colleft, colright, 2);
    //����2�п������ڵ�ɹ�������ͷ���ɹ���������
    if(temp1 == 1 && temp2 == 1)
    {
      return row;
    }
    //����2�п���������ʧ�ܣ��򴰿�Ԥ�������仯������������⡣
    else if(temp1 == 0 && temp2 == 0)
    {
      //Ԥ��㰴������ҲҪ�޷���
      tempminus = BoundaryLimitRe(BlackLeftWinPredictStore2 + BlackLeftWinPredictStore2 - BlackLeftWinPredictStore1,
                                  0,
                                  CameraRealWidth - 1);
      //temp�������ʾ����Ԥ���λ�á�
      temppredict = tempminus;
      BlackLeftWinPredictStore0 = BlackLeftWinPredictStore1;
      BlackLeftWinPredictStore1 = BlackLeftWinPredictStore2;
      BlackLeftWinPredictStore2 = temppredict;      
    }
    //����һ�п������ɹ����������ŵ㣬����Ԥ�������仯������������⡣
    else
    {
      //�������ŵ��˵���
      BlackLeftLoc[row][0] = MaxValUint8;
      BlackLeftLoc[row-1][0] = MaxValUint8;
      
      //Ԥ��㰴������ҲҪ�޷���
      tempminus = BoundaryLimitRe(BlackLeftWinPredictStore2 + BlackLeftWinPredictStore2 - BlackLeftWinPredictStore1,
                                  0,
                                  CameraRealWidth - 1);
      //temp�������ʾ����Ԥ���λ�á�
      temppredict = tempminus;
      BlackLeftWinPredictStore0 = BlackLeftWinPredictStore1;
      BlackLeftWinPredictStore1 = BlackLeftWinPredictStore2;
      BlackLeftWinPredictStore2 = temppredict;        
    }
      
      
      
    //һֱ����Row2LastLine��Ҳû������2�м��ɹ����򷵻�ʧ�ܡ�
    if(row == Row2LastLine) 
    {
      return MaxValUint8;
    }
    else
    {
    }
  }
 



}

//======================================================================
//��������BlackLeftAgainForCross
//��  �ܣ��������ȡ�У����ʮ�ֵ��ټ�����
//��  ������2�κ��ߵ�Ԥ����ʼ��Row2FirstLine�� ��2�κ��ߵ�Ԥ�������Row2LastLine��
//        ��1�κ��ߵ�ʵ�ʽ�����Row1RealLastLine�� ���һ�εĴ���Ԥ��ֵLastWinPredict
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺BlackLeftLoc[][]�� ������Ӱ���Ǽ�����ֵ����
//˵  ����1. ����������ø�������ĺ�����Ԥ�ƻ��ѽ϶�ʱ�䣬��������������
//        2. ��������Ӱ����BlackLeftLoc[][]���Ժ�ҲӦ�ñ��֡�
//             
//======================================================================
uint8 BlackLeftAgainForCross(uint8 Row2FirstLine, uint8 Row2LastLine, uint8 Row1RealLastLine, uint8 LastWinPredict)
{
    uint8 row, temp, temp1, temp2;
    uint8 Row2RealFirstLine; //��2�κ��ߵ���ʵ��ʼ��
    uint8 i;
    
    uint8 tempWB, tempW, tempB;
    uint8 tempminus;
    
    //��1�κ��ߵ���ʵ�������п�����Ϊ�����䱻ɾ����������Ҫ���²��Ҳ����¡�
    for(i = Row1RealLastLine; i <= CameraHight - 1; i++)
    {
      if(BlackLeftLoc[i][0] != MaxValUint8)
      {
        Row1RealLastLine = i;
        break;
      }
      else
      {
      }
    }
    //����ֱ�Ǻڿ鲻������ʮ���ٲ��ߣ����Ե���1�κ�����ʵ�����е�б�Ϸ��кڿ�ʱ���������ߡ�
    //ȡ5�С�
    for(i = 0; i <= 5; i++)
    {
      if(ImgNew[Row1RealLastLine - 4][BlackLeftLoc[Row1RealLastLine][0] + 5 + i] < LimitLeftB) //��Զ4�С�б���Ϸ���
      {
        return 0;
      }
      else if(ImgNew[Row1RealLastLine - 5][BlackLeftLoc[Row1RealLastLine][0] + 5 + i] < LimitLeftB) //��Զ5�С�б���Ϸ���
      {
        return 0;
      }
      else
      {
      }      
    }
    
    //ʮ���ټ���1�׶Σ�����ͷ��
    //temp = BlackGetLeftStep1Scan(Row2FirstLine, Row2LastLine, 0); //��3������0��ʾ��ʮ���ټ�⣬���ø���3���ؼ�ֵ
    
    //ʮ���ټ���1�׶Σ�����ͷ��������Scan�ķ�ʽ������Win�ķ�ʽ��
    temp = BlackGetLeftCrossSpeScan(Row2FirstLine, Row2LastLine, LastWinPredict);
    
    //��ͷ����ʧ�ܣ����ҵ���Զ���У�����ִ�к�������鳬�����ޣ�����ֱ���ж�Ϊʧ�ܡ�
    if(
      (temp == MaxValUint8)
    ||(temp <= 1)
    ||(BlackAgainForCrossFar10CutSwitch == 1 && temp <= 9)  //��Զ10��ɾ�����ؿ���ʱ����ʮ���ټ��ʱ�ĵ�2�κ�����ͷ����Զ��10�У���ʮ���ټ��ʧ�ܡ�
      )
    {
      //ɨƨ�ɹ�����       //i >= Row2LastLine
      for(i = Row2FirstLine; ; i--)
      {
        BlackLeftLoc[i][0] = MaxValUint8;
        if(i == 0) break;
      }
      return 0;  
    }
    else 
    {
      ////////////////���Ҫע�ͣ��ʹ����￪ʼע��
      
      //ʮ���ټ�����ͷ�����޶��ķ�Χ�ڣ���Ϊ�Ǹ��ŵ㣬����˳����ͷ�����ˣ�ֱ���˳���
      if(BlackLeftCrossConfirm(Row1RealLastLine+1, temp) == 0)
      { //ɨƨ�ɹ�����       //i >= (temp-1)
        BlackLeftCrossConfirmFlag = 1;  //��ʮ����ͷ��־ȷ��ʧ�ܣ�����Ԥ�뷶Χ��
        for(i = Row2FirstLine; ; i--)
        {
          BlackLeftLoc[i][0] = MaxValUint8;
          if(i == 0) break;
        }
        return 0;
      }
      //ʮ���ټ�����ͷ��ȷ���޶��ķ�Χ�ڣ����Լ�����
      else
      {
        BlackLeftCrossConfirmFlag = 2;  //��ʮ����ͷ��־ȷ�ϳɹ���
        row = temp;
      }
      
      ////////////////���Ҫע�ͣ��ʹ��������ע��
      
      //��ʱ����confirm���������Ҫ�õĻ� ���ͰѺ�����仰ȥ����ǰ��ע��ȥ����
      //row = temp;
    }
    
    Row2RealFirstLine = row; //��¼��2�κ��ߵ���ʵ��ʼ��
    
    //ʮ���ټ���2�׶Σ�˳����ͷ���ߡ�
    //tempΪԤ��ĺڵ�λ��
    temp = BoundaryLimitRe(BlackLeftLoc[row-1][0] + BlackLeftLoc[row-1][0] - BlackLeftLoc[row][0],
                           0,
                           CameraRealWidth - 1);
    //Ԥ��ֵ���º��ˢ��һ�ζ�ջ����ջ������ʧ��
    BlackLeftWinPredictStore0 = BlackLeftWinPredictStore1;
    BlackLeftWinPredictStore1 = BlackLeftWinPredictStore2;
    BlackLeftWinPredictStore2 = temp;    
    
    //���������֤�е�ȡ��Զ����
    for(row -= 2; ; row -= 2)
    {
      //����2�м��ڵ㡣
      temp1 = BlackGetLeftStep2Win(row, BlackLeftWinVal, temp, 1);
      temp2 = BlackGetLeftStep2Win(row-1, BlackLeftWinVal, temp, 2);
      
      //������2�кڵ���ɹ������3����ֵ���и��£��Ҹ���Ԥ���λ�á�
      if(temp1 && temp2) 
      {
        //��ֵ�Ĵ�������ԣ�ȣ��������½硣
        tempWB = (BlackLeftRealWB[0] + BlackLeftRealWB[1]) / 2 - LimitLeftWBMargin; 
        if(tempWB < LimitLeftWBMin) tempWB = LimitLeftWBMin;
        else if(tempWB > LimitLeftWBMax) tempWB = LimitLeftWBMax;
        else ;
        LimitLeftWB = tempWB;
        
        //�׵�Ĵ�������ԣ�ȣ��������½硣
        tempW = (BlackLeftRealW[0] + BlackLeftRealW[1]) / 2 - LimitLeftWMargin;
        if(tempW < LimitLeftWMin) tempW = LimitLeftWMin;
        else if(tempW > LimitLeftWMax) tempW = LimitLeftWMax;
        else ;
        LimitLeftW = tempW;
        
        //�ڵ�Ĵ�������ԣ�ȣ��������½硣
        tempB = (BlackLeftRealB[0] + BlackLeftRealB[1]) / 2 + LimitLeftBMargin;
        if(tempB < LimitLeftBMin) tempB = LimitLeftBMin;
        else if(tempB > LimitLeftBMax) tempB = LimitLeftBMax;
        else ;
        //��ɫ��ֵ���ܳ�����ɫ
        if(tempB >= LimitLeftW)
        {
          tempB = LimitLeftW - 1;
        }
        else
        {
        }
        LimitLeftB = tempB;
        
        //Ԥ�����£����޷�
        temp = BoundaryLimitRe(BlackLeftLoc[row-1][0] + BlackLeftLoc[row-1][0] - BlackLeftLoc[row][0],
                               0,
                               CameraRealWidth - 1);
        //Ԥ��ֵ���º��ˢ��һ�ζ�ջ����ջ������ʧ��
        BlackLeftWinPredictStore0 = BlackLeftWinPredictStore1;
        BlackLeftWinPredictStore1 = BlackLeftWinPredictStore2;
        BlackLeftWinPredictStore2 = temp;
      }
      //���û���������м��ڵ�ɹ���ԭ��������ԭλ�õ�Ԥ��㣬��������Ч�����ã����Ծ�����Ԥ���������ߡ�
      else
      {
        //Ԥ��㰴������ҲҪ�޷���
        tempminus = BoundaryLimitRe(BlackLeftWinPredictStore2 + BlackLeftWinPredictStore2 - BlackLeftWinPredictStore1,
                                    0,
                                    CameraRealWidth - 1);
        //temp�������ʾ����Ԥ���λ�á�
        temp = tempminus;
        BlackLeftWinPredictStore0 = BlackLeftWinPredictStore1;
        BlackLeftWinPredictStore1 = BlackLeftWinPredictStore2;
        BlackLeftWinPredictStore2 = temp;
      }       
      
      if((row == Row2LastLine) || (row == Row2LastLine+1)) break;      
    }
    
    //����Ƿ����б�ʶ�����ͷ������У������ͷ��λ�ã����û�У����������ߡ�
    if (BlackLeftLoc[Row1RealLastLine][0] == MaxValUint8)
    {

        //ͷ�㹻�ߣ��һ�ͷ��
        for (i = Row1RealLastLine; ; i++)
        {
            if (BlackLeftLoc[i][0] != MaxValUint8)
            {
                Row1RealLastLine = i;
                break;
            }
            else
            {
            }
            //ֱ�����һ��Ҳû���ҵ���Ч�У����ò��ߣ�ֱ�ӷ���1.
            if (i == CameraHight - 1) return 1;
        }

        //ʮ���ټ���3�׶Σ��Բ������ߵĽ��ߡ�
        if (BlackLeftCrossStep3(Row1RealLastLine, Row2RealFirstLine) == 0)
        {
            return 0;
        }

    }
    else
    {
        //û�б���б����ͷ��
        //ʮ���ټ���3�׶Σ��Բ������ߵĽ��ߡ�
        if (BlackLeftCrossStep3(Row1RealLastLine, Row2RealFirstLine) == 0)
        {
            return 0;
        }
    }

    
    return 1;
        
}

//======================================================================
//��������BlackLeftStep4BackLine
//��  �ܣ��������ȡ�У���4�׶�ʮ������ߺ�����
//��  ����Step4StartLine��ʼ�У�flag��־0��ʾ�������ã�1��ʾ���ߴ���ĵ���
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺BlackLeftLoc[][0]
//˵  ����1. ����������float�͵ĺ������п���ռ�ýϳ���ʱ�䡣
//        2. ��Ҫ����ʱ�䣬���԰Ѻ궨��BlackBackLineNum����3����2.
//        3. ���ߴ���ĵ���ʱ�����ü��ʮ����β     
//======================================================================
uint8 BlackLeftStep4BackLine(uint8 Step4StartLine, uint8 flag)
{
  uint8 row;
  uint8 i, index;
  uint8 x[BlackBackLineNum];   //ȡ���ٸ�����һ��ʼ�ж��塣
  uint8 y[BlackBackLineNum];
  uint8 j;
  uint8 temp1;
  uint8 tempend;
  
  int32 temp;
  int32 a0;
  int32 a1;
  
  //��������ʱ����Ҫ���ʮ����β
  if(flag == 0)
  {
    //ʮ����β����
    //��1�׶ε���ͷ�ȽϸߵĻ����Ϳ�ʼʮ����β��⡣�����ùܡ�
    if(BlackLeftStep1ScanRow < BlackLeftCrossTailRowLimit)
    {
      //�����ͷ����б���ǲ��Ǻܴ����ܴ�������ʮ����β�������ùܡ�
      //�����õ�б����ʮ����βר��б�ʡ�
      if(BlackLeft5Slope[0] + BlackLeftCrossTailSlopeLimit < 0 || AbsInt(BlackLeft5Slope[0])>BlackLeftCrossTailSlopeLimit)
      {
        //ʮ����β��־��λ��
        BlackLeftCrossTailFlag = 1;
        BlackLeftHeadEndSearch();
        if (BlackLeftEndLine - BlackLeftHeadLine<=8 && BlackLeftHeadLine!=MaxValUint8 && BlackLeftEndLine!=MaxValUint8)
        {
            //��������п����ǻ��䵼�µģ����˵�
            for (i = BlackLeftHeadLine; i <= BlackLeftEndLine; i++)
            {
                BlackLeftLoc[i][0] = MaxValUint8;
            }
            return 0;
        }
        else if (BlackLeft5Slope[0] == MaxValInt16)
        {
            //��������п����ǻ��䵼�µģ����˵�
            for (i = 0; i <= 59; i++)
            {
                BlackLeftLoc[i][0] = MaxValUint8;
            }
            return 0;
        }
        //5Slope�����п����Ѿ�ɾ����һЩ�ڵ㣬����ҲҪ�ο�ʵ�ʵ���Ч�ڵ�����
        if(BlackLeftEndLine - BlackLeftHeadLine - 4 < 0 || BlackLeft5SlopeIndex - 1 < 0)
        {
          return 0;
        }
        else
        {
        }        
        tempend = MinRe(BlackLeftEndLine - BlackLeftHeadLine - 4, BlackLeft5SlopeIndex - 1);
        //��ʼ����ʮ����β����ʮ����β�Ĵ�����Զ�С�              
        for(i = 0; ; i++)
        {
          //��б����ֱ����Χ�ڵġ������õ�б�����ж�Ϊֱ����б�ʡ�
          if(BlackLeft5Slope[i] + PathJudgeStraightSlopeLimit > 0)
          {
            BlackLeftCrossTailEndLine = BlackLeft5SlopeRow[i];
            break;
          }
          
          if(i == tempend) return 0;  //һֱ����б�����п����ǻ��䣬ֱ�ӷ���ʧ�ܡ�
          //����˵�����ߵ������Ϊ����ᵼ������߳�������߳�������������ʱ���ȼ������ԭ��BlackLeftStep4ErrorCheck()������б���ǲ��Ƕ���ֱ�ߣ��������򲻻������
        }
        //�����4���㣬Ҳ���ǡ�5����б�ʵļ���ĩβ��
        BlackLeftCrossTailEndLine += 4;
        //ȡ���Ȳɼ������С�
        i = MinRe(BlackLeft5SlopeRow[0] + 4, CameraHight - 1);
        i = MaxRe(BlackLeftStep1ScanRow, i);
        if(i >= BlackLeftCrossTailEndLine)
        {
          //��ʼɾ��ʮ����β��
          for(; ; i--)
          {
            BlackLeftLoc[i][0] = MaxValUint8;
            if(i == BlackLeftCrossTailEndLine) break;
          }
          //�޸�����ߵ���㡣
          Step4StartLine = BlackLeftCrossTailEndLine - 1;
        }
        else
        {
        }
      }
      else
      {
        //û��ʮ����β��
        BlackLeftCrossTailFlag = 0;      
      }
    }
    else
    {    
      //û��ʮ����β��
      BlackLeftCrossTailFlag = 0;
    }
  }
  //���ߴ������ʱ���Ͳ��ü��ʮ����β�ˡ�
  else
  {
  }
 
  //������ʮ������ߡ�
  if(Step4StartLine - BlackBackLineNum - BlackBackLineNum < 0)
  {
    temp1 = 0;    
  }
  else
  {
    temp1 = Step4StartLine - BlackBackLineNum - BlackBackLineNum;
  }
  
  //ȡBlackBackLineNum������Ϊ��С���˷��Ļ�׼�㡣
  //�����Ͻ�Ϊԭ�㣬����Ϊx������������Ϊy��������
  index = 0;
  for(i = Step4StartLine; ; i--)
  {
    if(BlackLeftLoc[i][0] != MaxValUint8)
    {
      y[index] = BlackLeftLoc[i][0];
      x[index] = i;
      index++;
    }
    if(index == BlackBackLineNum)
    {
      break;  
    }
    if(i == temp1)
    {
      return 0;
    }
  }
  
  //��С���˷�
  //y = a0 + a1 * x
  a1 = LeastSquarea1(x, y, BlackBackLineNum);
  /*
  //���ֱ���Ǵ����ϵ����£���˵����ȡ���˴�����ߣ������ٲ��ߣ�ȫ�������㡣
  if(a1 > BlackLeftBackLineSlope)
  {
    for(row = Step4StartLine; ; row--)
    {
      BlackLeftLoc[row][0] = MaxValUint8;
      if(row == 0) break;
    }
    return 0;
  }
  //���������
  else
  {
  }
  */
  
  
  //ֱ�Ų�������˳�Ų���
  /*
  for (row = Step4StartLine + 1; row <= CameraHight - 1; row++)
  {
    BlackLeftLoc[row][0] = BlackLeftLoc[Step4StartLine][0];
  }
  */
  
  //˳�Ų�������ֱ�Ų���
  a0 = LeastSquarea0(x, y, a1, BlackBackLineNum);
  
  for(row = Step4StartLine + 1; row <= CameraHight - 1; row++)
  {
    //����Ҳ�и��ȣ��������Ҷ����ܲ�����Χ��
    temp = (a0 + a1 * row) / LeastSquareMulti;
    if(temp >= CameraRealWidth-1)
    {
      //BlackLeftLoc[row][0] = CameraRealWidth - 1;
      //�������ҽ���ʱ��ԭ����Ϊ�ñ߽�ֵ�����ڵĲ����ǴӸ���������Чֵ��
      for(j = row; ; j++)
      {
        BlackLeftLoc[j][0] = CameraRealWidth-1;
        if(j == CameraHight - 1) break;
      }
      break;
    }
    else if(temp <= 0)
    {
      //BlackLeftLoc[row][0] = 0;
      //�������ҽ���ʱ��ԭ����Ϊ�ñ߽�ֵ�����ڵĲ����ǴӸ���������Чֵ��
      for(j = row; ; j++)
      {
        BlackLeftLoc[j][0] = 0;
        if(j == CameraHight - 1) break;
      }
      break;
    }
    else
    {
      BlackLeftLoc[row][0] = (uint8)(temp); 
    }
  }
  
  
  
  return 1;
  
}




//����������Բ���
uint8 BlackLeftContinueAdd(void)
{
    uint8 row, i, j;
    uint8 tempfirst, templast;
    uint8 fangHuiWanFlag =0;
    uint8 fangDuanLieFlag = 0;
    
    //����������Բ���
    //ֻ������߲ɼ��ɹ��Ų���
    if(BlackLeftDone == 1)
    {        
        //����β
        for(row = CameraHight - 1; ; row--)
        {
          if(BlackLeftLoc[row][0] != MaxValUint8)
          {
            break;
          }
          else
          {
          }
          
          if(row == 0)
          {
            BlackLeftDone = 0;
            return 0;
          }
        }
        
        //����ͷ��β��ʼ��Ϊ��Чֵ��
        tempfirst = MaxValUint8;
        templast = MaxValUint8;
                
        //��ʼ����
        for (; ; row--)
        {
            if (BlackLeftLoc[row][0] == MaxValUint8)
            {
                if (tempfirst == MaxValUint8)
                {
                    //����ͷΪ��Чֵ���ͼ�¼Ϊ��ͷ��
                    tempfirst = row + 1;
                }
                else
                {
                }
            }
            else
            {
                if (tempfirst != MaxValUint8)
                {
                    //����ͷ�Ѿ��и�ֵ����ʼ��¼��β��
                    templast = row;
                    if(templast > 5)
                    {
                        if (BlackLeftLoc[templast - 1][0] != MaxValUint8 && BlackLeftLoc[templast - 2][0] != MaxValUint8 && BlackLeftLoc[templast - 3][0] != MaxValUint8
                            && BlackLeftLoc[templast - 4][0] != MaxValUint8)
                        {
                            fangDuanLieFlag = 0;
                        }
                        else
                        {
                            fangDuanLieFlag = 1;
                        }
                    }
                    else
                    {
                        fangDuanLieFlag = 1;
                    }
                    
                    if (templast >= 8)
                    {
                        if (BlackLeftLoc[templast - 1][0] != MaxValUint8 && BlackLeftLoc[templast - 2][0] != MaxValUint8 && BlackLeftLoc[templast - 3][0] != MaxValUint8
                            && BlackLeftLoc[templast - 4][0] != MaxValUint8 && BlackLeftLoc[templast - 5][0] != MaxValUint8
                                && BlackLeftLoc[templast - 6][0] != MaxValUint8 && BlackLeftLoc[templast - 7][0] != MaxValUint8 && BlackLeftLoc[templast - 8][0] != MaxValUint8)
                        {
                            fangHuiWanFlag = 0;
                        }
                        else
                        {
                            fangHuiWanFlag = 1;
                        }
                    }
                    else
                    {
                        fangHuiWanFlag = 1;
                    }
                    
                    if ((BlackLeftLoc[tempfirst][0]<=15 && BlackLeftLoc[templast][0]<=15) && (tempfirst - templast) <= 12)
                    {
                        //��������Ƿ�ֹ����̫����ͷ�߽絼�º��߲��ɹ���
                        for (j = tempfirst - 1; ; j--)
                        {
                            BlackLeftLoc[j][0] = (BlackLeftLoc[tempfirst][0] + BlackLeftLoc[templast][0]) / 2;
                            if (j == templast + 1) break;
                        }
                    }
                    else if ((BlackLeftLoc[tempfirst][0] <= 15 && BlackLeftLoc[templast][0] <= 15) && (tempfirst - templast) <20
                                && (BlackLeftLoc[10][0] != MaxValUint8 || BlackLeftLoc[9][0] != MaxValUint8 || BlackLeftLoc[8][0] != MaxValUint8 || BlackLeftLoc[7][0] != MaxValUint8 || BlackLeftLoc[6][0] != MaxValUint8)
                                && fangHuiWanFlag == 0)
                    {
                        //��������Ƿ�ֹ����̫����ͷ�߽絼�º��߲��ɹ���
                        for (j = tempfirst - 1; ; j--)
                        {
                            BlackLeftLoc[j][0] = (BlackLeftLoc[tempfirst][0] + BlackLeftLoc[templast][0]) / 2;
                            if (j == templast + 1) break;
                        }
                    }
                    else if ((BlackLeftLoc[tempfirst][0] <= 15 && BlackLeftLoc[templast][0] <= 15) && (tempfirst - templast) <= 35
                                && (BlackLeftLoc[6][0] != MaxValUint8 || BlackLeftLoc[7][0] != MaxValUint8 || BlackLeftLoc[8][0] != MaxValUint8 || BlackLeftLoc[10][0] != MaxValUint8 || BlackLeftLoc[9][0] != MaxValUint8)
                                && fangHuiWanFlag == 0)
                    {
                        //��������Ƿ�ֹ����̫����ͷ�߽絼�º��߲��ɹ���
                        for (j = tempfirst - 1; ; j--)
                        {
                            BlackLeftLoc[j][0] = (BlackLeftLoc[tempfirst][0] + BlackLeftLoc[templast][0]) / 2;
                            if (j == templast + 1) break;
                        }
                    }
                    //�����߶��ѵ�
                    else if (tempfirst - templast <= 5 && fangDuanLieFlag == 0)
                    {
                        for (j = tempfirst - 1; ; j--)
                        {
                            BlackLeftLoc[j][0] = (BlackLeftLoc[tempfirst][0] + BlackLeftLoc[templast][0]) / 2;
                            if (j == templast + 1) break;
                        }
                    }
                    else if(tempfirst - templast >= 3) 
                    {
                      //�������̫�࣬��������ȫ����Ϊ����
                      for(i = tempfirst - 1; ; i--)
                      {
                        BlackLeftLoc[i][0] = MaxValUint8;
                        if(i == 0) break;
                      }
                      //����������Ա�־����
                      BlackLeftContinueFlag = 2;
                      return 0;
                    }
                    else
                    {
                      //һ����1��2���㣬ֱ�Ӳ�ֵ���С�
                      for(j = tempfirst - 1; ; j--)
                      {
                        BlackLeftLoc[j][0] = (BlackLeftLoc[tempfirst][0] + BlackLeftLoc[templast][0]) / 2;
                        if(j == templast + 1) break;
                      }
                    }
                    tempfirst = MaxValUint8;
                    templast = MaxValUint8;
                    //����������Ա�־��0����������
                    BlackLeftContinueFlag = 0;
                }
                else
                {
                }
            }

            if (row == 0) break;
        }
    }
    else
    {
    }    
    
    return 1;
}






//����ߵĻ��������⡣����ǰBlackLeftDone�Ѿ���Ϊ1�ˡ�
//����ǰ�Ѿ��������Һ��ߵ�б���ʼ�⡣
uint8 BlackLeftRollCheck(void)
{
  uint8 temp1, temp2, temp3;
  
  //��ǰΪ���ߣ������л��������⡣
  if(SingleBlackAllFlag == 1) return 1;
  
  //б��ȷ�ϡ�
  //����Ч��ֱ��ȷ�ϡ�
  if(SlopeL == MaxValInt16)
  {
    temp1 = 1;
  }
  else
  {
    //б�ʵ�ȷ̫��
    if(SlopeL + BlackLeftRollSlopeLimit < 0)
    {
      temp1 = 1;
    }
    //б�ʲ���
    else
    {
      temp1 = 0;
    }
  }
  
  //�߳���ȷ�ϡ�
  //����Ч��ֱ��ȷ�ϡ�
  if(BlackLeftHeadLine == MaxValUint8 || BlackLeftEndLine == MaxValUint8)
  {
    temp2 = 1;
  }
  else
  {
    //��ȷʵ�̡ܶ�
    if(BlackLeftEndLine - BlackLeftHeadLine < BlackLeftRollLengthLimit)
    {
      temp2 = 1;
    }
    //�ߺܳ���
    else
    {
      temp2 = 0;
    }
  }
  
  /*
  //����б��ȷ�ϡ�
  //���߱��������ϵ����µģ�Ҳ��������б�ʡ�����б��Ҫ��Ƚϴ󡣲���˵����270�ȴ��䡣
  if(SlopeR == MaxValInt16)
  {
    temp3 = 1;    
  }
  else
  {
    if(SlopeR > BlackLeftRollSlopeRLimit)
    {
      temp3 = 1;
    }
    else
    {
      temp3 = 0;
    }
  }
  */
  temp3 = 1;

  if(
    (BlackLeftStep4Flag == 3 || SingleBlackLastAllFlag == 1)   //������߱�־������������Ϊ�Ϸ�ͼ���ǵ��ߣ��޷�����ʮ�֣��޷�������߳���
  &&(BlackLeftCrossDone == 1 || BlackLeftCrossDone == 0)   //��ʮ�ֱ�־��ʧ�ܡ�����δ���루��β���߲������ʮ���ټ�⣩��
  &&(temp1 == 1)                //б�ʺܴ�
  &&(temp2 == 1)                //�ߺ̡ܶ�
  &&(temp3 == 1)                //����б�ʺܴ�
    )
  {
    //��⵽���䣬����0.
    return 0;   
  }
  else
  {
    //û��⵽���䣬����1.
    return 1;
  }

}

//����߱�־����ʱ�ļ�飬��������Ƿ�ֹ����ĺ���Ҫ�ĺ�����
uint8 BlackLeftStep4ErrorCheck(void)
{
  uint8 i;
  
  //���б���ǲ��Ƕ�����ֱ��
  for(i = 0; ; i++)
  {
    if(BlackLeft5Slope[i] == MaxValInt16) return 0;
    
    if(AbsInt(BlackLeft5Slope[i]) > PathJudgeStraightSlopeLimit)
    {
      return 0;
    }
    else
    {      
    }
    
    if(i == 5) break;
  }
  
  return 1;
  
}


//�������ȡǰ�Ĳ�����ʼ����ֵ
uint8 BlackGetLeftParaInit(void)
{
  uint8 i;
  
  //���������Ա�־��Ĭ��Ϊ1������
  BlackLeftContinueFlag = 1;  
  
  //�ɼ��ɹ���־λ
  BlackLeftDone = 1;  
 
  //��ʮ����ͷ��־��0δ���룬1����Χ��2�ɹ���
  BlackLeftCrossConfirmFlag = 0;  //Ĭ��Ϊδ���롣  
  
  //С5��б�ʴ��������ó�ʼֵ��
  BlackLeft5SlopeIndex = 0;  
  for(i = 0; ; i++)
  {
      BlackLeft5Slope[i] = MaxValInt16;
      BlackLeft5SlopeRow[i] = MaxValUint8;
      if(i == CameraHight - 1) break;
  }  
  
  //������
  BlackLeftRollCheckFlag = 0;        //��⵽���䡣
  BlackLeftBigChangeJumpFlag = 0;    //����������־��

  //��б�ʼ��ʱ��ÿ��ͼ��ĳ�ʼֵ��ʼ��Ϊ��Чֵ��
  for(i = 0; i <= 4; i++)
  {
    BlackLeftBigChangeNumx[i] = MaxValUint8;
    BlackLeftBigChangeNumy[i] = MaxValUint8; 
  }
  BlackLeftBigChangeFlag = 0;
  BlackLeftBigChangeSlopeStore = MaxValInt16;

  //��б�ʼ��ʱ��ÿ�еĴ������־��0.
  for(i = 0; ; i++)
  {
    BlackLeftBigChangeCheckRow[i] = 0;
    if(i == CameraHight - 1) break;
  }
  BlackLeftBigChangeCheckAllRow = 0;

  //����ߴ��������ʼ��Ϊ��Чֵ��
  for(i = 0; ; i++)
  {
    BlackLeftLoc[i][0] = MaxValUint8;
    if(i == CameraHight - 1) break;
  }

  //ʮ����β
  BlackLeftCrossTailFlag = 2;       //ʮ����β��־��0ʧ�ܣ�1ȷ�ϣ�2δ���롣

  //����Ԥ��ֵ����
  for(i = 0; ; i++)
  {
    BlackLeftPredictL[i] = MaxValUint8;
    BlackLeftPredictR[i] = MaxValUint8; 
    if(i == CameraHight - 1) break;
  }
  
  //����Ԥ�ⴢ��ֵ
  BlackLeftWinPredictStore0 = MaxValUint8;
  BlackLeftWinPredictStore1 = MaxValUint8;
  BlackLeftWinPredictStore2 = MaxValUint8;

  //��4�׶ν����־��Ϊδ����
  BlackLeftStep4Flag = 0;
  BlackLeftStep4StartLine = MaxValUint8;
  //Ĭ��ʮ�ּ���־��Ϊδ���롣
  BlackLeftCrossDone = 0;
  
  return 1;
}






//======================================================================
//��������BlackGetLeft
//��  �ܣ��������ȡ�㷨
//��  ������
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺BlackLeftCrossDone��BlackLeftLoc[][],
//        BlackLeftRealWB[], BlackLeftRealW[], BlackLeftRealB[],
//        LimitLeftWB, LimitLeftW, LimitLeftB
//˵  ����1. ��ʱ���Դ���ֱ���������ʮ��·��3�������2014.11.10
//      
//             
//======================================================================
uint8 BlackGetLeft(void)
{
    uint8 row, temp, temp1, temp2, temp3, i;
    uint8 GapCount, Row1RealLastLine, index, index1;
    uint8 tempWB, tempW, tempB;
    uint8 tempminus;
    uint8 successRow = MaxValUint8;
    
    int temp001;
    
    //�������ȡǰ�Ĳ�����ʼ����ֵ
    BlackGetLeftParaInit();
    
    //��1�׶Ρ���1�׶��п��ܻ᷵�غ�����ȡʧ��
    
    //ÿ����Чͼ�����ͷ��3����ֵ�������档Step1Scanǰ����ǰһ����Чͼ�񱣴��3����ֵ��
    LimitLeftWB = LimitLeftHeadWB;
    LimitLeftW = LimitLeftHeadW;
    LimitLeftB = LimitLeftHeadB;
    
    temp = BlackGetLeftStep1Scan(CameraHight - 1, CameraHight - BlackStep1Size - 1, 1);
    BlackLeftStep1ScanRow = temp;
    
    //���߿�ʼɨ�������£�����β������ͷ�ߣ�ֱ�ӷ���ʧ�ܡ����Ӻ������������Ϊ�˷�ֹʮ�����С�
    if(
       (BlackGetPreDir == 1)
     &&(temp <= BlackRightHeadLine)
     &&(BlackRightHeadLine < CameraHight - 7)
      )
    {
        BlackLeftLoc[temp][0] = MaxValUint8;
        BlackLeftLoc[temp - 1][0] = MaxValUint8;
        return 0;
    }
    else
    {
    }
    
    if(temp == MaxValUint8)
    {
      return 0;
    }    
    else 
    {     
              
      //ÿ����Чͼ�����ͷ��3����ֵ�������档����ͷ��ȡ�ɹ�����÷�ͼ����Ч����ͷ3����ֵ���¡�
      LimitLeftHeadWB = LimitLeftWB;
      LimitLeftHeadW = LimitLeftW;
      LimitLeftHeadB = LimitLeftB;
      
      row = temp;
      //�����ʼ��ͷ��λ�÷ǳ��ߣ�����Ϊ��ʮ�ֵ�ǰ�����ǣ���Ҫ�����4�׶�����ߡ�    
      if(row < CameraHight - BlackLeftBackLineStart)
      {
        BlackLeftStep4Flag = 1;               //Ĭ��Ϊʧ��
        BlackLeftStep4StartLine = row;
      }
    }
    
    //��2�׶Ρ�������һ�׶Σ��Ѿ����᷵�غ�����ȡʧ�� 
    //tempΪԤ��ĺڵ�λ��   

    //��Ԥ��ֵ�Ĵ�С�޶�
    temp = BoundaryLimitRe(BlackLeftLoc[row-1][0] + BlackLeftLoc[row-1][0] - BlackLeftLoc[row][0], 
                           0, 
                           CameraRealWidth - 1);
    //Ԥ��ֵ���º��ˢ��һ�ζ�ջ����ջ������ʧ��
    BlackLeftWinPredictStore0 = BlackLeftWinPredictStore1;
    BlackLeftWinPredictStore1 = BlackLeftWinPredictStore2;
    BlackLeftWinPredictStore2 = temp;

    index = 0;
    index1 = 0;
    
    GapCount = 0;  //����������û�вɼ�������
    successRow = MaxValUint8; //��¼���һ�γɹ�����
    //���������֤�е�ȡ��Զ����
    for(row -= 2; ; row -= 2)
    {      
      //����2�м��ڵ㡣
      temp1 = BlackGetLeftStep2Win(row, BlackLeftWinVal, temp, 1);
      temp2 = BlackGetLeftStep2Win(row-1, BlackLeftWinVal, temp, 2);
      
      temp3 = (
              (temp1 == 0)
            &&(temp2 == 0)
            //&&(BlackLeftStep4Flag == 0)
              );
      
      //������2�кڵ���ɹ������3����ֵ���и��£��Ҹ���Ԥ���λ�á�
      if(temp1 == 1 && temp2 == 1) 
      {
        //ֻҪ�����ɼ���˫���ߣ���������־λ����Ϊ0.
        index = 0;
        index1 = 0;
        successRow = row;
        
        //��ֵ�Ĵ�������ԣ�ȣ��������½硣
        tempWB = (BlackLeftRealWB[0] + BlackLeftRealWB[1]) / 2 - LimitLeftWBMargin; 
        if(tempWB < LimitLeftWBMin) tempWB = LimitLeftWBMin;
        else if(tempWB > LimitLeftWBMax) tempWB = LimitLeftWBMax;
        else ;
        LimitLeftWB = tempWB;
        
        //�׵�Ĵ�������ԣ�ȣ��������½硣
        tempW = (BlackLeftRealW[0] + BlackLeftRealW[1]) / 2 - LimitLeftWMargin;
        if(tempW < LimitLeftWMin) tempW = LimitLeftWMin;
        else if(tempW > LimitLeftWMax) tempW = LimitLeftWMax;
        else ;
        LimitLeftW = tempW;
        
        //�ڵ�Ĵ�������ԣ�ȣ��������½硣
        tempB = (BlackLeftRealB[0] + BlackLeftRealB[1]) / 2 + LimitLeftBMargin;
        if(tempB < LimitLeftBMin) tempB = LimitLeftBMin;
        else if(tempB > LimitLeftBMax) tempB = LimitLeftBMax;
        else ;
        //��ɫ��ֵ���ܳ�����ɫ
        if(tempB >= LimitLeftW)
        {
          tempB = LimitLeftW - 1;
        }
        else
        {
        }
        LimitLeftB = tempB; 
         
        //��Ԥ��ֵ�Ĵ�С�޶�
        temp = BoundaryLimitRe(BlackLeftLoc[row-1][0] + BlackLeftLoc[row-1][0] - BlackLeftLoc[row][0], 
                               0, 
                               CameraRealWidth - 1);
        
        //Ԥ��ֵ���º��ˢ��һ�ζ�ջ����ջ������ʧ��
        BlackLeftWinPredictStore0 = BlackLeftWinPredictStore1;
        BlackLeftWinPredictStore1 = BlackLeftWinPredictStore2;
        BlackLeftWinPredictStore2 = temp;
      }
      //���û���������м��ڵ�ɹ���ԭ��������ԭλ�õ�Ԥ��㣬��������Ч�����ã����Ծ�����Ԥ���������ߡ�
      //����������о��ɼ�����ʧ�ܣ���������ǵ�һ��ֵ������һ��Step1
      //�����4�׶μ���־��λ���Ͳ��ý���ʮ�ּ���ˡ�
      else if(temp3 == 1)
      {        
        //����һ��ͼ�ǵ��ߣ���������ʮ�֡�
        if(SingleBlackLastAllFlag == 1) break;        
        //ֱ�Ǻڿ������ڼ䣬Ϊ�˷�ֹһ��ʮ�ֳɹ���һ�߲��ɹ���ɵ���������б�����Բ�������ʮ�֡�
        if(AngleZoneConfirmLockFlag == 1) break;
        
        //��һ�μ�⵽˫��ʧ��ʱ�����ļ����߿����Ѿ���̫��ȷ��
        if(index1 == 0)
        {
          //��������3��ֵ������ͬ��Ҳ���Ǳ仯��ͬ�ţ���ô�Ͱ������������������Ϊ���һ��ֵ�Ѿ�����
          if(row <= CameraHight - 3)
          {
              //��ǰ������û�б�������ɾ������
              if (BlackLeftLoc[row + 1][0] != MaxValUint8 && BlackLeftLoc[row + 2][0] != MaxValUint8)
              {


                  //������ߵ㹻����û��Ǹ���ʵ�ʵĺڵ������´���ֵ��
                  tempminus = BoundaryLimitRe(BlackLeftLoc[row + 1][0] * 3 - BlackLeftLoc[row + 2][0] * 2,
                                              0,
                                              CameraRealWidth - 1);
                  //б��ʮ�ֲ�����ô�ڣ���ʮ�ֵ��϶���һ�����¶��ߵ��ұߡ�
                  tempminus = MaxRe(tempminus, BlackLeftLoc[row + 1][0]);
              }
              else
              {
                  temp001 = BlackLeftWinPredictStore1 - BlackLeftWinPredictStore0;
                  BlackLeftWinPredictStore0 += temp001;
                  BlackLeftWinPredictStore1 += temp001;
                  BlackLeftWinPredictStore2 = BlackLeftWinPredictStore1 + BlackLeftWinPredictStore1 - BlackLeftWinPredictStore0;
                  tempminus = BoundaryLimitRe(BlackLeftWinPredictStore2 + BlackLeftWinPredictStore2 - BlackLeftWinPredictStore1,
                                              0,
                                              CameraRealWidth - 1);       
              }
          }
          else
          {
              //�����ϲ����ߵ����
              return 0;
          }
          
          //����һ�κ����Ҳ�������ˡ�
          index1++;          
        }
        else
        {
          //Ԥ��㰴������ҲҪ�޷���
          tempminus = BoundaryLimitRe(BlackLeftWinPredictStore2 + BlackLeftWinPredictStore2 - BlackLeftWinPredictStore1,
                                      0,
                                      CameraRealWidth - 1);          
        }
        //temp�������ʾ����Ԥ���λ�á�
        temp = tempminus;
        BlackLeftWinPredictStore0 = BlackLeftWinPredictStore1;
        BlackLeftWinPredictStore1 = BlackLeftWinPredictStore2;
        BlackLeftWinPredictStore2 = temp;
              
        //Row1RealLastLine��¼��1�κ��ߵ����һ�С�
        if(index == 0)
        {
          //����һ�κ󣬾���Ҳ��������ˡ�
          index++;
          for(i = row; i <= CameraHight - 1; i++)
          {
            if(BlackLeftLoc[i][0] != MaxValUint8)
            {
              Row1RealLastLine = i;
              break;
            }
          }
          if(Row1RealLastLine >= CameraHight - 1)
          {
            Row1RealLastLine = CameraHight - 1;
          }
          else
          {
          }
          //��¼Ϊȫ�ֱ���
          BlackLeftRow1RealLastLine = Row1RealLastLine;
        }
        
        GapCount += 2;
        if (successRow != MaxValUint8 && BlackLeftLoc[successRow][0]<10 && BlackLeftLoc[successRow - 1][0]<10) { }
        ///////////////////////////////����ʮ�����¼���������Ҫ���ϸ�һЩ������û��Ҫ��ʱ�䣬����˵ǰ�����ֻ�����⵽�����С�
        else if(GapCount > BlackCrossGapLine)
        {
          //�ټ��ʱ����̫Զ�ˣ���û��Ҫ����ˡ�
          if(row < BlackLeftCrossTooLowLine)
          {
            //ɨƨ�ɡ�
            for(i = row; ; i--)
            {
              BlackLeftLoc[i][0] = MaxValUint8;
              if(i == 0) break;
            }
            //��������
            break;
          }
          else
          {
          }
          
          //����ʮ�����¼��󣬾Ͳ�������ֵ�4�׶�����ߵ������
          if(BlackLeftStep4Flag == 1)
          {
            BlackLeftStep4Flag = 3;   //����߳���
          }
          else
          {
          }
          
          //ʮ���ټ��Ļ���Step1Scan����ͷ���빻����
          //���ֻʣ��0��1��û�м��Ļ����Ͳ��ÿ���ʮ���ټ���ˡ�
          if(BlackLeftStep1ScanRow >= CameraHight - 3 && row > 3)
          {            
            //������ʮ���ټ�⡣
            if(BlackLeftAgainForCross(row - 2, 1, Row1RealLastLine, temp) == 0)
            {
              BlackLeftCrossDone = 1;  //ʮ�ּ��ʧ��           
            }
            else
            {
              BlackLeftCrossDone = 2;  //ʮ�ּ��ɹ�
            }
            break;  //ʮ���ټ����Ὺ����⵽ָ�������һ�У����Բ�����ѭ���ˣ�ֱ������
          }
          //��ͷ̫Զ������ֻʣ��0��1�е�ʱ��ֱ��break�ͺã�Զ�������ڳ�ʼ��ʱ�Ѿ���Ϊ��Чֵ��
          else
          {
            break;
          }
          
        }
        else
        {
          BlackLeftCrossDone = 0;   //ʮ�ּ��δ����
        }
      }
      //��������ֻ��һ�߼��ɹ����������ȻҪ�����Ƹ��´���Ԥ��ֵ��
      else if((temp1 == 1 && temp2 == 0) || (temp1 == 0 && temp2 == 1)) 
      {        
        
        //��һ�μ�⵽�е�����ʧ��ʱ�����ļ����߿����Ѿ���̫��ȷ��
        if(index1 == 0)
        {
          //��������3��ֵ������ͬ��Ҳ���Ǳ仯��ͬ�ţ���ô�Ͱ������������������Ϊ���һ��ֵ�Ѿ�����
          if(row <= CameraHight - 3)
          {
              //��ǰ������û�б�������ɾ������
              if (BlackLeftLoc[row + 1][0] != MaxValUint8 && BlackLeftLoc[row + 2][0] != MaxValUint8)
              {


                  //������ߵ㹻����û��Ǹ���ʵ�ʵĺڵ������´���ֵ��
                  tempminus = BoundaryLimitRe(BlackLeftLoc[row + 1][0] * 3 - BlackLeftLoc[row + 2][0] * 2,
                                              0,
                                              CameraRealWidth - 1);
                  //б��ʮ�ֲ�����ô�ڣ���ʮ�ֵ��϶���һ�����¶��ߵ��ұߡ�
                  tempminus = MaxRe(tempminus, BlackLeftLoc[row + 1][0]);
              }
              else
              {
                  temp001 = BlackLeftWinPredictStore1 - BlackLeftWinPredictStore0;
                  BlackLeftWinPredictStore0 += temp001;
                  BlackLeftWinPredictStore1 += temp001;
                  BlackLeftWinPredictStore2 = BlackLeftWinPredictStore1 + BlackLeftWinPredictStore1 - BlackLeftWinPredictStore0;
                  tempminus = BoundaryLimitRe(BlackLeftWinPredictStore2 + BlackLeftWinPredictStore2 - BlackLeftWinPredictStore1,
                                              0,
                                              CameraRealWidth - 1);       
              }
          }
          else
          {
              //�����ϲ����ߵ����
              return 0;
          }
          
          //����һ�κ����Ҳ�������ˡ�
          index1++;          
        }
        else
        {
          //Ԥ��㰴������ҲҪ�޷���
          tempminus = BoundaryLimitRe(BlackLeftWinPredictStore2 + BlackLeftWinPredictStore2 - BlackLeftWinPredictStore1,
                                      0,
                                      CameraRealWidth - 1);          
        }
        //temp�������ʾ����Ԥ���λ�á�
        temp = tempminus;
        BlackLeftWinPredictStore0 = BlackLeftWinPredictStore1;
        BlackLeftWinPredictStore1 = BlackLeftWinPredictStore2;
        BlackLeftWinPredictStore2 = temp;
      }
      //�����ϲ����ߵ����
      else
      {
      }
      
      if((row == 0) || (row == 1)) break;
      
    }
    
    //��4�׶Σ��ɼ���ʮ�ֵ�ǰ�����ǣ�����ߡ������и������㣬Ҫ�ϸ���Ƶ��á�
    //�����ʱ�����뿼�ǵľ���ʮ����β�����⡣
    if(BlackLeftStep4Flag == 1)
    {
      if(BlackLeftStep4BackLine(BlackLeftStep4StartLine, 0) == 0)
      {
        BlackLeftStep4Flag = 1;    //�����ʧ�ܣ��п����ǵ�ȡ�������п�����б�ʲ��ԡ�
        //return 0;  
      }
      else
      {
        BlackLeftStep4Flag = 2;    // ����߳ɹ���
      }
    }
    //BlackLeftStep4Flag����������
    else if(BlackLeftStep4Flag == 3)
    {
      //����������Ϊʲô
      if(BlackLeftStep4ErrorCheck() == 1)
      {        
        if(BlackLeftStep4BackLine(BlackLeftStep4StartLine, 0) == 0)
        {
          //BlackLeftStep4Flag = 1;    //�����ʧ�ܣ��п����ǵ�ȡ�������п�����б�ʲ��ԡ�
          //return 0;  
        }
        else
        {
          BlackLeftStep4Flag = 2;    // ����߳ɹ���
        }
      }
      else
      {
      }
      
    }
    //BlackLeftStep4Flagδ����������
    else
    {       
    }

    return 1;
}



//====================================����������������������������������============================

//======================================================================
//��������BlackRightRealClear
//��  �ܣ��Һ�����ȡ�У���3���ؼ�ֵ��ʵ��ֵ����
//��  ������
//��  �أ���
//Ӱ  �죺BlackRightRealWB[], BlackRightRealW[], BlackRightRealB[]
//˵  ����
//      
//             
//======================================================================
void BlackRightRealClear(void)
{
    BlackRightRealWB[0] = 0;
    BlackRightRealWB[1] = 0;
    BlackRightRealW[0] = 0;
    BlackRightRealW[1] = 0;
    BlackRightRealB[0] = 0;
    BlackRightRealB[1] = 0;
}




//������ȡ�ɹ������Һ��ߵ���ͷ��β��
uint8 BlackRightHeadEndSearch(void)
{
  uint8 i;
  //������ͷ����β�Ĳ���
  if(BlackRightDone == 1)
  { //������ͷ�Ĳ��ҡ�
    for(i = 0; ; i++)
    { //�ҵ���������ͷ��
      if(BlackRightLoc[i][0] != MaxValUint8)
      {
        BlackRightHeadLine = i;
        break;
      }
      //ֱ�����һ����û���ҵ���ͷ�������ʧ�ܡ�
      if(i == CameraHight - 1) 
      {
        BlackRightHeadLine = MaxValUint8;
        break;
      }
    }
    //��������ͷ����ʧ�ܣ��Ͳ�����������β�ˡ�
    if(BlackRightHeadLine == MaxValUint8)
    {
      BlackRightEndLine = MaxValUint8;
      BlackRightDone = 0;
    }
    //��������ͷ���ҳɹ�����ʼ��������β��
    else
    {
      for(i = CameraHight - 1; ; i--)
      { //�ҵ������ߵ���β��
        if(BlackRightLoc[i][0] != MaxValUint8)
        {
          BlackRightEndLine = i;
          break;
        }
        //û�ҵ����ߵ���β�����߲�������ͷ��β�����Ծ�����Чֵ��
        if(i == BlackRightHeadLine) 
        {
          BlackRightHeadLine = MaxValUint8;
          BlackRightEndLine = MaxValUint8;
          break;
        }
      }
    }
  }
  //�����ߺ�����ȡʧ�ܣ��Ͳ�������ͷ����β�ˡ�
  else
  {
    BlackRightHeadLine = MaxValUint8;
    BlackRightEndLine = MaxValUint8;
  }
  
  //����ͼ���е���ʱ��ɾ����Զһ���㡣
  if(SingleBlackAllFlag == 1)
  {
    BlackRightLoc[BlackRightHeadLine][0] = MaxValUint8; //Udis���鲻�øģ���Ϊ��ͷ��β����֮����ֵ�����������
    BlackRightHeadLine += 1;
  }
  else
  {
  }
  
  return 1;
}


//======================================================================
//��������BlackRightBigChangeCheck
//��  �ܣ��Һ�����ȡʱ����б�ʼ�⡣
//��  ����newrow�¼ӽ�������Ҫ�ж��Ƿ���Ч����, use����ʱ������2�еĵڼ��С�
//��  �أ�1���к��߳ɹ���0���к���ʧ�ܡ�
//Ӱ  �죺
//˵  ����1. ������ֹ��б��ͻ��Ļ��㡣
//        2. ��5���У�ȡ1��3��5�н���б�ʼ��㣬ÿ��һ�����У��Ƴ�һ�����С�
//             
//======================================================================
uint8 BlackRightBigChangeCheck(uint8 newrow, uint8 use)
{
  uint8 tempstorex, tempstorey;
  uint8 i;
  int32 tempslope1, tempslope2;
  
  //tempstorex�������潫Ҫ�Ƴ���һ�У��������ʧ��ʱ��ԭ5�����顣
  tempstorex = BlackRightBigChangeNumx[0];
  BlackRightBigChangeNumx[0] = BlackRightBigChangeNumx[1];
  BlackRightBigChangeNumx[1] = BlackRightBigChangeNumx[2];
  BlackRightBigChangeNumx[2] = BlackRightBigChangeNumx[3];
  BlackRightBigChangeNumx[3] = BlackRightBigChangeNumx[4];
  BlackRightBigChangeNumx[4] = newrow;

  tempstorey = BlackRightBigChangeNumy[0];
  BlackRightBigChangeNumy[0] = BlackRightBigChangeNumy[1];
  BlackRightBigChangeNumy[1] = BlackRightBigChangeNumy[2];
  BlackRightBigChangeNumy[2] = BlackRightBigChangeNumy[3];
  BlackRightBigChangeNumy[3] = BlackRightBigChangeNumy[4];
  BlackRightBigChangeNumy[4] = BlackRightLoc[newrow][0];

  //ÿ��ͼ���ֻ��һ�����forѭ��������ʡʱ�䡣
  if(BlackRightBigChangeJumpFlag == 0)
  {  
    //�����������Ч���жϣ�������5���������޷����д�б�ʼ�⣬ֱ�ӷ��سɹ���
    for(i = 0; i <= 4; i++)
    {
      if(BlackRightBigChangeNumx[i] == MaxValUint8)
      {
        return 1;
      }
    }
    //�ı��־λ���´ξͲ������ˡ�
    BlackRightBigChangeJumpFlag = 1;   
  }
  //�ߵ�����˵��ͨ����������Ч���жϡ�
  
  //ȡ1��3��5�����б�ʼ��㡣
  //��Ϊֻ�������㣬����б�ʵļ����ȡб�ʵĳ�ʼ����ķ�ʽ������ȡ��С���˷�������ʡ�ܶ�ʱ�䡣
  tempslope1 = (BlackRightBigChangeNumy[2] - BlackRightBigChangeNumy[0]) 
            * LeastSquareMulti   //��������ô�౶������С���˷�һ����
            / (BlackRightBigChangeNumx[2] - BlackRightBigChangeNumx[0]);
  tempslope2 = (BlackRightBigChangeNumy[4] - BlackRightBigChangeNumy[2]) 
            * LeastSquareMulti   //��������ô�౶������С���˷�һ����
            / (BlackRightBigChangeNumx[4] - BlackRightBigChangeNumx[2]);
  BlackRightBigChangeSlopeStore = tempslope1;
  //С5��б�ʴ����������У����ڴ������tempslope1�����Դ�����㲻���¼������ֶ�����ֵͬ��
  BlackRight5Slope[BlackRight5SlopeIndex] = BlackRightBigChangeSlopeStore;
  BlackRight5SlopeRow[BlackRight5SlopeIndex] = newrow;
  BlackRight5SlopeIndex++;  
  //1. ǰ�����ε�б�����෴�ġ�
  if(tempslope1 >= 0 && tempslope2 < 0)
  {
    //2. ���߲�ֵ�ܴ�ܴ�
    if(tempslope1 >= tempslope2 + BlackRightBigChangeSlopeLimit)
    {
      //���߲�ֵ��ȷ�ܴ󡣲���ˢ�´���ֵ��
      //if(use == 2)                    //��һ�ַ�����������2�еĵ�2�е���ʱ���óɹ���־λ��
      //{
        //�óɹ���־λ��
        BlackRightBigChangeFlag = 1;
      //}
      //else
      //{
      //}
      //�˴��в�������С�
      BlackRightBigChangeNumx[4] = BlackRightBigChangeNumx[3];
      BlackRightBigChangeNumx[3] = BlackRightBigChangeNumx[2];
      BlackRightBigChangeNumx[2] = BlackRightBigChangeNumx[1];
      BlackRightBigChangeNumx[1] = BlackRightBigChangeNumx[0];
      BlackRightBigChangeNumx[0] = tempstorex;
      BlackRightBigChangeNumy[4] = BlackRightBigChangeNumy[3];
      BlackRightBigChangeNumy[3] = BlackRightBigChangeNumy[2];
      BlackRightBigChangeNumy[2] = BlackRightBigChangeNumy[1];
      BlackRightBigChangeNumy[1] = BlackRightBigChangeNumy[0];
      BlackRightBigChangeNumy[0] = tempstorey;

      //��ǰ��3���Һ���(��4��)��ֵ����Чֵ��ͼ���ϸ�������
      BlackRightLoc[BlackRightBigChangeNumx[4]][0] = MaxValUint8;
      BlackRightLoc[BlackRightBigChangeNumx[3]][0] = MaxValUint8;
      //BlackRightLoc[BlackRightBigChangeNumx[2]][0] = MaxValUint8;
      
      return 0;
    }
    else
    {
      //ˢ��б�ʴ���ֵ��
      //BlackRightBigChangeSlopeStore = tempslope;
      return 1;
    }
  }
  //1. ǰ�����ε�б�����෴�ġ�
  else if(tempslope1 < 0 && tempslope2 >= 0)
  {
    //2. ���߲�ֵ�ܴ�ܴ�
    if(tempslope2 >= tempslope1 + BlackRightBigChangeSlopeLimit)
    {
      //���߲�ֵ��ȷ�ܴ󡣲���ˢ�´���ֵ��
      //if(use == 2)                    //��һ�ַ�����������2�еĵ�2�е���ʱ���óɹ���־λ��
      //{
        //�óɹ���־λ��
        BlackRightBigChangeFlag = 1;
      //}
      //else
      //{
      //}
      //�˴��в�������С�
      BlackRightBigChangeNumx[4] = BlackRightBigChangeNumx[3];
      BlackRightBigChangeNumx[3] = BlackRightBigChangeNumx[2];
      BlackRightBigChangeNumx[2] = BlackRightBigChangeNumx[1];
      BlackRightBigChangeNumx[1] = BlackRightBigChangeNumx[0];
      BlackRightBigChangeNumx[0] = tempstorex;
      BlackRightBigChangeNumy[4] = BlackRightBigChangeNumy[3];
      BlackRightBigChangeNumy[3] = BlackRightBigChangeNumy[2];
      BlackRightBigChangeNumy[2] = BlackRightBigChangeNumy[1];
      BlackRightBigChangeNumy[1] = BlackRightBigChangeNumy[0];
      BlackRightBigChangeNumy[0] = tempstorey;
      
      //��ǰ��3���Һ���(��4��)��ֵ����Чֵ��ͼ���ϸ�������
      BlackRightLoc[BlackRightBigChangeNumx[4]][0] = MaxValUint8;
      BlackRightLoc[BlackRightBigChangeNumx[3]][0] = MaxValUint8;
      //BlackRightLoc[BlackRightBigChangeNumx[2]][0] = MaxValUint8;   
      
      return 0;
    }
    else
    {
      //ˢ��б�ʴ���ֵ��
      //BlackRightBigChangeSlopeStore = tempslope;
      return 1;
    }    
  }
  //�����෴�����ж��޴�б�ʵ����䡣���سɹ���
  else
  {
    //ˢ��б�ʴ���ֵ��
    //BlackRightBigChangeSlopeStore = tempslope;
    return 1;
  }
  
}


//�����ġ��������ҵġ�һ�������ڵġ�ɨ�������صĺ���.���Ծ���Step2Win, CrossSpeWin��������ݡ�
//���ص��������صİ׵�����λ�á�
uint8 BlackGetRightJustWin(uint8 row, int32 colleft, int32 colright)
{
  uint8 abs1;
  uint8 tempwhite;
  uint8 temp1;
  
  //���ұ߽��޷�
  colleft = BoundaryLimitRe(colleft, 0, CameraRealWidth - 1);
  colright = BoundaryLimitRe(colright, 0, CameraRealWidth - 1);
  
  for(; colleft < colright; colleft++) 
  {
    //��׵����Һڵ�����ز�
    if(ImgNew[row][colleft] > ImgNew[row][colleft+1+BlackRightEdgeNum])
    {
      abs1 = ImgNew[row][colleft] - ImgNew[row][colleft+1+BlackRightEdgeNum];
    }
    else
    {
      abs1 = 0;
    }

    if( //�����صĵ�һ��������
        //�ڹ��ڣ��׹��ף����
        //�����3����ֵ������Ӧ֮�������ֵ
          (abs1 > LimitRightWB - LimitRightWBAdjust[row]) //���ߵĲ��
        &&(ImgNew[row][colleft] > LimitRightW)                     //�׵㹻��
        &&(ImgNew[row][colleft+1+BlackRightEdgeNum] < LimitRightB)                   //�ڵ㹻��
       )
    {
          //�����߰׵㲻�������Ͳ����жϰ׵��Ƿ�������ֵ�ˡ�
          if(colleft > 2)
          {
            tempwhite = ((ImgNew[row][colleft-1] > LimitRightW) && (ImgNew[row][colleft-2] > LimitRightW));
          }
          else
          {
            tempwhite = 1;
          }
          
          //�������У�����3������Ϊ�ڵ㣬����2������Ϊ�׵㡣
          if(row > BlackMiddleLine)
          {
            temp1 = (
                      (ImgNew[row][colleft+2+BlackRightEdgeNum] < LimitRightB)
                    &&(ImgNew[row][colleft+3+BlackRightEdgeNum] < LimitRightB)
                    //&&(ImgNew[row][colleft+4+BlackRightEdgeNum] < LimitRightB)
                    &&(tempwhite == 1)
                    );
          }
          else
          {
            //�м���� ������2����Ϊ��Ϊ�ڵ㣬����1������Ϊ�׵㡣
            if(row > BlackFarLine)
            {
              temp1 = (
                        (ImgNew[row][colleft+2+BlackRightEdgeNum] < LimitRightB)
                      //&&(ImgNew[row][colleft+3+BlackRightEdgeNum] < LimitRightB)
                      &&(tempwhite == 1)
                      );
            }          
            else
            {
              //Զ�����У�����1������Ϊ�ڵ㣬����0������Ϊ�׵㡣
              if(row > BlackFarfarLine)
              {
                //temp1 = (ImgNew[row][colleft+2+BlackRightEdgeNum] < LimitRightB);
                temp1 = 1;
              }
              //��Զ�����У�ֻ��������Ҫ�󣬶���Χ�ڵ���Ҫ��
              else
              {
                temp1 = 1;
              }
            }
          }
          
          //�����صĵڶ���������
          if(temp1 == 1)
          {
            //�������������㣬���ذ׵�λ�ã����Ǻڵ�λ�ã�
            return colleft;
            
          //break;               
          }// end of �����ؼ��ĵ�2������
    }// end of �����ؼ��ĵ�1������
    
    
    
  }// end of forѭ��
  
  //���һֱ����������߻�û���ҵ������أ�������Чֵ��
  return MaxValUint8;
    
}


//======================================================================
//��������BlackGetRightStep1Edge
//��  �ܣ��Һ�����ȡ�У���1�׶������⺯��,����������ߵĿ��ɺڵ�
//��  �����������к�row, �ڼ���ʹ��use, ����Ԥ�����־preflag(1��Ԥ����)
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺BlackRightRealWB[], BlackRightRealW[], BlackRightRealB[]
//        BlackRightLoc[][]
//˵  ����1. �Ե�row�е��������ҽ��м�⣬�ɹ��͸���Ӧ��ֵ����3������ֵ����ʧ����255
//        2. ��������������ʱ������ɹ����������3��ֵ���м�¼���ֽ׶�ֻ�õ��˵�1��ֵ
//        3. �������漰3���ؼ�ֵ��ʵ��ֵ�ļ�¼��CrossFlag������Ͳ��ü�¼��Ҳ�Ͳ��ø��ģ�
//        4. ��1���ڵ�Ҳû�У����߳���3���ڵ㣬����ʧ�ܡ�
//        5. ��Ҫ���ڵ��׵����䣬�����������䣬�ı��һ���������ɡ�
//======================================================================
uint8 BlackGetRightStep1Edge(uint8 row, uint8 use, uint8 preflag)
{
  uint8 index, col, temp1;
  uint8 abs1;
  uint8 RightBeginCol; //�������������
  uint8 tempwhite;
  uint8 avgr1, avgl1;
  uint8 i;
    
  //������һ����Чͼ���������Ԥ����һ��ͼ������Һ���ɨ����㣬���������Ҫ����������һ�����߿�ȡ� 
  RightBeginCol = (uint8)MaxRe((int32)BlackRightEdgeStartCol-10,0);
  
  //���߿�ʼɨ�衣
  //�����Ԥ����Ҳ���ÿ�����������ֱ�������߾ͺá�
  if((BlackGetPreDir == 0 || BlackGetPreDir == 2)
  &&(BlackLeftLoc[row][0] != MaxValUint8)
  &&(preflag == 0)
    )
  {
    //�����һ��ͼ�ǵ��ߣ�������ɨ�������������ߵ����һ�����߿�ȡ�
    if(
      (row > CameraHight - 5)
    &&(SingleBlackLastAllFlag == 1)
       )
    {
      RightBeginCol = MinRe(RightBeginCol, MaxRe(0, BlackLeftLoc[row][0] - SingleBlackWidthMax[row]));
    }
    //�����һ��ͼ���ǵ��ߣ����������û�вɼ������ߣ��Ǿ���Ϊ�����ܳ��ֵ��ߡ���������ɨ�������������ߵ��ұ�
    else if(
           (row <= CameraHight - 5)
         //&&(SingleBlackLastAllFlag == 0)
            )
    {
      RightBeginCol = MaxRe(RightBeginCol, BlackLeftLoc[row][0]);
    }
    else
    {
      RightBeginCol = MaxRe(RightBeginCol, BlackLeftLoc[row][0]);
    }
    
  }
  else
  {    
  }
  
  //����Ԥ��ֵ��¼
  BlackRightPredictL[row] = RightBeginCol;
  BlackRightPredictR[row] = CameraRealWidth - 5 - BlackRightEdgeNum;
  
  index = 0;         //���ɵ�����
  //���м䵽���ұ�ɨ�裬��1�������
  for(col = RightBeginCol; col <= CameraRealWidth - 5 - BlackRightEdgeNum; col++) 
  {
      //��׵����Һڵ�����ز�
      if(ImgNew[row][col] > ImgNew[row][col+1+BlackRightEdgeNum])
      {
        abs1 = ImgNew[row][col] - ImgNew[row][col+1+BlackRightEdgeNum];
      }
      else
      {
        abs1 = 0;
      }
      
      if( //�����صĵ�һ��������
          //�ڹ��ڣ��׹��ף����
          //�����3����ֵΪ��ʼֵ����������Ӧ֮�������ֵ��
          (abs1 > LimitRightWB - LimitRightWBAdjust[row]) //���ߵĲ��
        &&(ImgNew[row][col] > LimitRightW)                     //�׵㹻��
        &&(ImgNew[row][col+1+BlackRightEdgeNum] < LimitRightB) //�ڵ㹻��
         )
      {         
          //���û�а׵�Ļ��Ͳ����жϰ׵��Ƿ�������ֵ�ˡ�
          if(col > 2)
          {
            tempwhite = ((ImgNew[row][col-1] > LimitRightW) && (ImgNew[row][col-2] > LimitRightW));
          }
          else
          {
            tempwhite = 1;
          }
          
          //�����صĵڶ���������
          //�������У�����3������Ϊ�ڵ㣬����2������Ϊ�׵㡣
          if(row > BlackMiddleLine)
          {
            temp1 = (
                      (ImgNew[row][col+2+BlackRightEdgeNum] < LimitRightB)
                    &&(ImgNew[row][col+3+BlackRightEdgeNum] < LimitRightB)
                    &&(ImgNew[row][col+4+BlackRightEdgeNum] < LimitRightB)
                    &&(tempwhite == 1)
                    );
          }
          else
          {
            if(row > BlackFarLine)
            {
              //�м���У�����2������Ϊ�ڵ㣬����1������Ϊ�׵㡣
              temp1 = (
                        (ImgNew[row][col+2+BlackRightEdgeNum] < LimitRightB)
                      &&(ImgNew[row][col+3+BlackRightEdgeNum] < LimitRightB)
                      &&(tempwhite == 1)
                      );
            }
            else
            {
              //Զ�����У�����1������Ϊ�ڵ㣬����0������Ϊ�׵㡣
              if(row > BlackFarfarLine)
              {
                temp1 = (ImgNew[row][col+2+BlackRightEdgeNum] < LimitRightB);
              }
              //��Զ�����У�ֻ��������Ҫ�󣬶���Χ�ڵ���Ҫ��
              else
              {
                temp1 = 1;
              }             
            }
          }
          
          if(temp1)
          {
              //������ɹ���ȡ�ڵ�
              BlackRightLoc[row][index] = col + 1 + BlackRightEdgeNum;          
              index++;
              break;
            
          }    //end of �����صĵڶ�������
      }   //end of �����صĵ�һ������
  }// end of ���м䵽�����ɨ�裬��1�������
  
  //1�����ɺڵ�Ҳû�У��򱨴�
  if(index == 0)
  {
    //����Ǻ���Ԥ����ĵ��ã�Ҳ���ø����⼸��ֵ��
    if(preflag == 0)
    {
      //��3���ؼ�ֵ��ʵ��ֵ����
      BlackRightRealClear();
    }
      
    //���ж�λ����ʧ�ܣ�����Чֵ
    BlackRightLoc[row][0] = MaxValUint8;
    return 0;
  }
  
  //���Ǻ���Ԥ����ĵ��ã�����Ҫ���д�����ļ�⡣
  if(preflag == 0)
  {
    //����ȷ��ǰ����Ҫ�Դ�б�ʽ��м�⡣
    if(BlackRightBigChangeCheck(row, use) == 1)
    {
      //�����߿�ʼ��ɨ�衣����һ��������BlackGetPreDir == 0�������
      //���Ѿ�ȷ��Ϊ�����ˣ��Ͳ����ٴ�ȷ���ˡ�
      if(
        (SingleBlackAllFlag == 0) 
      &&(BlackGetPreDir == 0 || BlackGetPreDir == 2)   //0713�ļ������error002.txt��ĵ�31��ͼ���ɵ���32��ͼʱ����BlackGetPreDir������2�Ļ���������⡣
        )
      {
        //���������Һ��߾����ɹ��������������ߵ����һ����Χ�ڣ�������ж�Ϊ���ߡ�
        if((BlackLeftLoc[row][0] != MaxValUint8)
         &&(BlackRightLoc[row][0] != MaxValUint8)
         &&(BlackRightLoc[row][0] < BlackLeftLoc[row][0])
         &&(BlackRightLoc[row][0] - BlackLeftLoc[row][0] < SingleBlackWidthMax[row]) //����Ǹ���Ҳ�����㣬���Ա���С�ڡ�
        )
        {
          //���5���׵��ƽ��ֵ�Ƿ����������������ǵ��ߣ����������������Чֵ��
          if(
            (BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 5 < 0)
          ||(BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 5 > CameraRealWidth - 1)
            )
          {
            //����5���㡣
            //��Ϊ���й������䣬����Ҫ�����ֻ���������С�
            if(row > CameraHight - 5)
            {
                for(i = 0; i <= 4; i++)
                {
                    BlackRightBigChangeNumx[i] = MaxValUint8;
                    BlackRightBigChangeNumy[i] = MaxValUint8;
                }
                BlackRightBigChangeJumpFlag = 0;
            }
            else
            {
            }
            //���ж�λ����ʧ�ܣ�����Чֵ
            BlackRightLoc[row][0] = MaxValUint8;
            return 0;
          }
          else
          {
            //�������ߵİ׵�ƽ��ֵ
            avgr1 = (ImgNew[row][BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 1]
                   + ImgNew[row][BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 2]
                   + ImgNew[row][BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 3]
                   + ImgNew[row][BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 4]
                   + ImgNew[row][BlackRightLoc[row][0] - 1 - BlackRightEdgeNum - 5])
                   / 5;
            //�������ߵİ׵�ƽ��ֵ
            avgl1 = (ImgNew[row][BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 1]
                   + ImgNew[row][BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 2]
                   + ImgNew[row][BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 3]
                   + ImgNew[row][BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 4]
                   + ImgNew[row][BlackLeftLoc[row][0] + 1 + BlackLeftEdgeNum + 5])
                   / 5;    
            if(AbsInt(avgr1 - avgl1) < 20)
            {
              //5���׵�֮��Ĳ��С�������жϳɹ���
              SingleBlackFlag[row] = 1;      
              //SingleBlackAllFlag = 1;   //�ܷ�ͼ��ĵ��߱�־��ֻҪ��һ�м�ⵥ�߳ɹ�������1.
            }
            else
            {
              //5���׵�֮��Ĳ��̫�󣬵����ж�ʧ�ܡ�
              //��Ϊ���й������䣬����Ҫ�����ֻ���������С�
              if(row > CameraHight - 5)
              {
                  for(i = 0; i <= 4; i++)
                  {
                      BlackRightBigChangeNumx[i] = MaxValUint8;
                      BlackRightBigChangeNumy[i] = MaxValUint8;
                  }
                  BlackRightBigChangeJumpFlag = 0;
              }
              else
              {
              }
              
              //���ж�λ����ʧ�ܣ�����Чֵ
              BlackRightLoc[row][0] = MaxValUint8;
              return 0;              
            }
          }          
        }
        else
        {
          //������е��߱�־Ϊ0.
          SingleBlackFlag[row] = 0;
        }
      }
      //�����߿�ʼ��ɨ�裬���߲��ü���Ƿ��е��ߣ�����ȥ��⼴�ɡ�
      else
      {
      }
      
      //û�б����ͻ��ߵ�����ڵ���ҳɹ�������1��2��3���ڵ�
      //return 1;
    }
    else
    {
      //ûͨ���������⡣
      BlackRightBigChangeCheckRow[row] = 1;
      BlackRightBigChangeCheckAllRow = 1;
      
      //return 1;
      
      //���ж�λ����ʧ�ܣ�����Чֵ
      BlackRightLoc[row][0] = MaxValUint8;
      return 0;
    }
  }
  //�Ǻ���Ԥ����ĵ��ã����������ļ�⣬ֱ�ӷ��سɹ���
  else
  {
    //return 1;
  }

  //����Ǻ���Ԥ����ĵ��ã�Ҳ���ø����⼸��ֵ��
  if(preflag == 0)
  {
    //��������˵�������صĶ������������㣬����ڵ��¼�׶�
    //��¼3���ؼ�ֵ��ʵ����Ϣ����Ϊ����Ĳο���
    if(use == 1)
    {
      BlackRightRealWB[0] = ImgNew[row][col] - ImgNew[row][col+1+BlackRightEdgeNum]; 
      BlackRightRealW[0] = ImgNew[row][col];
      BlackRightRealB[0] = ImgNew[row][col+1+BlackRightEdgeNum];
    }
    else if(use == 2)
    {
      BlackRightRealWB[1] = ImgNew[row][col] - ImgNew[row][col+1+BlackRightEdgeNum]; 
      BlackRightRealW[1] = ImgNew[row][col];
      BlackRightRealB[1] = ImgNew[row][col+1+BlackRightEdgeNum];
    }
    else
    {
    }
  }
  
  return 1;
}


//======================================================================
//��������BlackGetRightStep2Win
//��  �ܣ��Һ�����ȡ�У���2�׶δ����������⺯��
//��  �����������к�row, ���ڴ�Сwin, Ԥ���������λ��predict, �ڼ���ʹ��use.
//��  �أ�1�ɹ�  0ʧ��
//Ӱ  �죺BlackRightLoc[][0]
//˵  ����1. �����������������ܼ��ɹ���ֻ��һ����ļ�¼��
//        2. ������û�м�⵽������ʧ�ܡ�
//        3. ����С���Լ���һ����ʱ�䣬���������б�ʹ������������п��ܼ�ⲻ����     
//======================================================================
uint8 BlackGetRightStep2Win(uint8 row, uint8 win, uint8 predict, uint8 use)
{
  uint8 col, temp;

  //�ڹ滮�õĴ����ڣ��������Ҳ���������
  //��ֹ���
  //���ұ߽������ 
  if((predict + win) >= (CameraRealWidth - 5 - BlackRightEdgeNum)) 
  {
    temp = CameraRealWidth - 5 - BlackRightEdgeNum;
  }  
  else
  {
    temp = predict + win;
  }
  //����߽������
  if(predict <= win)
  {
    col = 0;
  }
  else
  {
    col = predict - win;  
  }
  //���߿�ʼɨ����û�г��ֵ���ʱ�����ߵ�ɨ����߽�����ڸ�����Ч����ߵ��ұߡ�
  if((BlackGetPreDir == 0 || BlackGetPreDir == 2)
  &&(SingleBlackAllFlag == 0)
  &&(BlackLeftLoc[row][0] != MaxValUint8)
    )
  {
    col = MaxRe(col, BlackLeftLoc[row][0]);
  }
  else
  {
  }
  
  //����Ԥ��ֵ��¼
  BlackRightPredictL[row] = col;
  BlackRightPredictR[row] = temp;
  
  //��߽����ұ߽���ұߣ�ֱ�ӷ���ʧ�ܡ�
  if(col >= temp) return 0;
   
  //����ɨ��������
  col = BlackGetRightJustWin(row, col, temp);
  if(col != MaxValUint8)
  {
    //�������������㣬ֱ�Ӽ�¼�õ�Ϊ���ߣ����ؼ���
    BlackRightLoc[row][0] = col + 1 + BlackRightEdgeNum;
             
    //����ȷ��ǰ����Ҫ�Դ�б�ʽ��м�⡣
    if(BlackRightBigChangeCheck(row, use) == 0)
    {
      //ûͨ���������⡣
      BlackRightBigChangeCheckRow[row] = 1;
      BlackRightBigChangeCheckAllRow = 1;             
      
      BlackRightLoc[row][0] = MaxValUint8;
      return 0;
    }
    else
    {
    }
    
    
    //��¼3���ؼ�ֵ��ʵ����Ϣ����Ϊ����Ĳο���
    if(use == 1)
    {
      BlackRightRealWB[0] = ImgNew[row][col] - ImgNew[row][col+1+BlackRightEdgeNum]; 
      BlackRightRealW[0] = ImgNew[row][col];
      BlackRightRealB[0] = ImgNew[row][col+1+BlackRightEdgeNum];
    }
    else if(use == 2)
    {
      BlackRightRealWB[1] = ImgNew[row][col] - ImgNew[row][col+1+BlackRightEdgeNum]; 
      BlackRightRealW[1] = ImgNew[row][col];
      BlackRightRealB[1] = ImgNew[row][col+1+BlackRightEdgeNum];
    }
    else
    {
    }
      
    return 1;   
  }
  else
  {
    //������û��ɨ�赽�����أ����еĺ���λ�ü�Ϊ��Чֵ������0ʧ��.
    BlackRightLoc[row][0] = MaxValUint8;
    return 0;
  }
}



//======================================================================
//��������BlackGetRightStep1Scan
//��  �ܣ��Һ�����ȡ�У���1�׶ε���ɨ�躯��
//��  ����ɨ����ʼ��FirstLine, ɨ�������LastLine
//��  �أ�0~CameraHight - 1���� 255�ɼ�ʧ��
//Ӱ  �죺BlackRightRealWB[], BlackRightRealW[], BlackRightRealB[], BlackRightLoc[][],
//        LimitRightWB, LimitRightW, LimitRightB
//˵  ����1. �����������ص�1�׶���ɨ�裬Ҳ������ʮ���ټ��ʱ����ɨ��
//        2. ������1�׶�ɨ��ʱ�������3���ؼ���ֵ��ֵ��
//             
//======================================================================
uint8 BlackGetRightStep1Scan(uint8 FirstLine, uint8 LastLine, uint8 CrossFlag)
{
    uint8 row, temp1, temp2;
    uint8 abs1;
    uint8 tempWB, tempW, tempB;
    uint8 flag, i;
    
    flag = 0;
    //�����BlackStep1Size���ò�ֵ���Һ���
    for(row = FirstLine; row > LastLine; row -= 2)
    {
      //�ж��Ƿ��������м�⵽���䣬���ɺڵ���3���㣬��ȡ����һ��
      temp1 = BlackGetRightStep1Edge(row, 1, 0);
      temp2 = BlackGetRightStep1Edge(row-1, 2, 0);
      if(temp1 == 1 && temp2 == 1)//���������ôд������Ƕ��if����Ϊ&&���ص�
      {
        abs1 = AbsRe(BlackRightLoc[row-1][0], BlackRightLoc[row][0]);
        //��һ���ж��������еĺڵ�ļ���Ƿ�С������ȡ��1�����ɺڵ㡣
        if(abs1 < BlackRightStep1ScanMinus)
        {
          //��⵽�������ĺ��ߣ�ֹͣ��ֵ���������أ���ʡʱ�䣬��������2�׶�                                     
          //�������ʮ���ټ���������͸���һ��ʵ�ʵ�3���ؼ�ֵ�����򲻸��¡�
          if(CrossFlag == 1)
            {           
              //��ֵ�Ĵ�������ԣ�ȣ��������½硣
              tempWB = (BlackRightRealWB[0] + BlackRightRealWB[1]) / 2 - LimitRightWBMargin; 
              if(tempWB < LimitRightWBMin) tempWB = LimitRightWBMin;
              else if(tempWB > LimitRightWBMax) tempWB = LimitRightWBMax;
              else ;
              LimitRightWB = tempWB;
              
              //�׵�Ĵ�������ԣ�ȣ��������½硣
              tempW = (BlackRightRealW[0] + BlackRightRealW[1]) / 2 - LimitRightWMargin;
              if(tempW < LimitRightWMin) tempW = LimitRightWMin;
              else if(tempW > LimitRightWMax) tempW = LimitRightWMax;
              else ;
              LimitRightW = tempW;
              
              //�ڵ�Ĵ�������ԣ�ȣ��������½硣
              tempB = (BlackRightRealB[0] + BlackRightRealB[1]) / 2 + LimitRightBMargin;
              if(tempB < LimitRightBMin) tempB = LimitRightBMin;
              else if(tempB > LimitRightBMax) tempB = LimitRightBMax;
              else ;
              //��ɫ��ֵ���ܳ�����ɫ
              if(tempB >= LimitRightW)
              {
                tempB = LimitRightW - 1;
              }
              else
              {
              }             
              LimitRightB = tempB;           
            }
          break;
        }
        else
        {
          //��������������̫����Ϊ����㡣
          BlackRightLoc[row][0] = MaxValUint8;
          BlackRightLoc[row-1][0] = MaxValUint8;
          //������������ĸ�λ��
          BlackRightBigChangeNumx[3] = MaxValUint8;
          BlackRightBigChangeNumx[4] = MaxValUint8;
          BlackRightBigChangeNumy[3] = MaxValUint8;
          BlackRightBigChangeNumy[4] = MaxValUint8;
          BlackRightBigChangeJumpFlag = 0;
        }
      }
      else if(temp1 == 0 && temp2 == 1)
      {
        //�ߵ����˵��˫���߼��ɹ�֮ǰ��˫��֮һ�ɼ��ɹ���
        flag = 1;
      }
      else if(temp1 == 1 && temp2 == 0)
      {
        //�ߵ����˵��˫���߼��ɹ�֮ǰ��˫��֮һ�ɼ��ɹ���
        flag = 1;
      }
      else
      {
      }
    }   
    
    //�����BlackStep1Size��Ҳû�м�⵽�����ĺ��ߣ�˵�����߼��ʧ��
    if(row <= LastLine)
    {
      return MaxValUint8;
    }               
    else
    {
        //˫���߼��ɹ� �� ˫���߼��ɹ�֮ǰ��˫��֮һ�ɼ��ɹ���
        if(flag == 1)
        {
            //��ǰ���˫��֮һ��ȥ����
            for(i = FirstLine; ; i--)
            {
                if(i == row) break;
                BlackRightLoc[i][0] = MaxValUint8;
                
            }
            
            //��һ��scan
            if(CrossFlag == 1)
            {
              //��ǰ3����б�ʼ�ⴢ��ֵ��ȥ��������2�����ã���Ϊ�ǶԵġ�
              for(i = 0; i <= 2; i++)
              {
                  BlackRightBigChangeNumx[i] = MaxValUint8;
                  BlackRightBigChangeNumy[i] = MaxValUint8;
                  BlackRightBigChangeJumpFlag = 0; //Сϸ�ڡ�
              }
            }
            else
            {
            }
            
        }
        else
        {

        }
        
        return row;
    }
  
}


//======================================================================
//��������BlackRightCrossStep3
//��  �ܣ�������ȡ�У�ʮ�ּ���3�׶Σ��Բ��ߺ���
//��  ������1����Ч���ߵ����һ��FirstLine�� ��2����Ч���ߵĵ�һ��LastLine
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺BlackRightLoc[][0]
//˵  ����1. ������һЩ�������㣬��ռʱ�䣬�ڵ��ñ�����ʱҪ���أ�������Ҫ�á�
//        2. �������������ߵ�˼·�ܲ���floatǿת��uint8ǿת�õúܺá�
//             
//======================================================================
uint8 BlackRightCrossStep3(uint8 FirstLine, uint8 LastLine)
{
  int32 delta_x, delta_y, delta, index;
  uint8 row, temp1, temp2;
  uint8 i;
  //uint8 temp3, temp4, flag1, flag2;
  
  //��ʼ�бȽ����л��ߣ�����
  if(LastLine >= FirstLine)
  {
    //uart_sendN(UART0, (uint8 *)"\nError In BlackRightCrossStep3!", 31);
    return 0;  
  }
  
  //�п��ܳ��ֱ���б�ʼ��ɾ�����������������¸��к����ж�Ϊ���󣬾Ͳ�����ʮ�ֲ����ˡ�
  if(BlackRightLoc[LastLine][0] == MaxValUint8)
  {
    //����ʧ��ǰɨƨ��
    for(i = FirstLine - 1; ; i--)
    {
      BlackRightLoc[i][0] = MaxValUint8;
      if(i == 0) break;
    }
    
    return 0;
  }
  else
  {
  }
  
  temp1 = BlackRightLoc[FirstLine][0];
  temp2 = BlackRightLoc[LastLine][0];
  
  /*
  flag1 = 1;
  flag2 = 1;
  //ȷ������������ֱ�Ǵ��ĵ㣬Ҳ��������6������Ϊ�ڵ�
  if(temp1 <= (CameraRealWidth - 9))
  {
    temp3 = (
            (ImgNew[FirstLine+1][temp1+6] < LimitRightB)
          &&(ImgNew[FirstLine+1][temp1+7] < LimitRightB)
          &&(ImgNew[FirstLine+1][temp1+8] < LimitRightB)
          );
    if(temp3)
    {
      flag1 = 0;  
    }
  }
  
  if(temp2 <= (CameraRealWidth - 9))
  {
    temp4 = (
            (ImgNew[LastLine-1][temp2+6] < LimitRightB)
          &&(ImgNew[LastLine-1][temp2+7] < LimitRightB)
          &&(ImgNew[LastLine-1][temp2+8] < LimitRightB)
          );
    if(temp4)
    {
      flag2 = 0;  
    }
  }
  
  if((flag1 == 0) || (flag2 == 0))
  {
    return 0;  
  }
  
  */
  
  delta_y = FirstLine - LastLine;
  
  
  //б������
  if(temp1 < temp2)
  {
    //�Ŵ�BlackRightCrossStep3Multi��
    delta_x = temp2 - temp1;
    delta = delta_x * BlackRightCrossStep3Multi / delta_y; 
    
    index = 1;
    for(row = FirstLine - 1; row >= LastLine + 1; row-- )
    {
      //ÿ������һ���
      BlackRightLoc[row][0] = (uint8)(BlackRightLoc[FirstLine][0] + delta * index / BlackRightCrossStep3Multi);
      index += 1;
    }
  }
  //б������
  else if(temp1 > temp2)
  {
    //�Ŵ�BlackRightCrossStep3Multi��
    delta_x = temp1 - temp2;
    delta = delta_x * BlackRightCrossStep3Multi / delta_y;
    
    index = 1;
    for(row = FirstLine - 1; row >= LastLine + 1; row-- )
    {
      //ÿ������һ���
      BlackRightLoc[row][0] = (uint8)(BlackRightLoc[FirstLine][0] - delta * index / BlackRightCrossStep3Multi);
      index += 1;
    }
  }
  //б��ֱ�ߣ������̫���ܳ���
  else
  {
    for(row = FirstLine - 1; row >= LastLine + 1; row-- )
    {
      //����ͬ��ֵ
      BlackRightLoc[row][0] = temp1;
    }
  }
  
  return 1;
    
}

//======================================================================
//��������BlackRightCrossConfirm
//��  �ܣ�ʮ���ټ��ʱ ����ͷ��Ч�Ե�ȷ�ϡ�
//��  ������1�κ��ߵ���ʵ������Row1RealLastLine����2�κ��ߵ���ʵ��ʼ��Row2RealFirstLine
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺��
//˵  ����1. Ϊ��Ӧ��270�����ʮ���������������д������û�й��࿼�����������
//      
//             
//======================================================================
uint8 BlackRightCrossConfirm(uint8 Row1RealLastLine, uint8 Row2RealFirstLine)
{
  uint8 row, index;
  uint8 x[BlackCrossConfirmNum];
  uint8 y[BlackCrossConfirmNum];
  
  int32 a0, a1, temp;
  
  //1. �Ƚ��еڶ��κ�����ʼ�㷽���ж�������������ʮ�ָ��з������ж�Ϊ����㡣ֱ�ӷ���0.
  if(BlackRightLoc[Row2RealFirstLine][0] < BlackRightLoc[Row2RealFirstLine-1][0]) 
  {
    return 0;
  }
  //2. �ٽ��еڶ��κ�����ʼ�����б���ж���Ҳ���Ƕ�������в����޶���̫�����п����Ǵ�����䡣��Ի���ʮ���󲹡�
  else if((BlackRightLoc[Row2RealFirstLine][0] > BlackRightLoc[Row2RealFirstLine-1][0])
   &&(BlackRightLoc[Row2RealFirstLine][0] - BlackRightLoc[Row2RealFirstLine-1][0] >= 3)
    )
  {
    return 0;
  }
  //3. �ٶ���һ��ͼ������б�ʺ�����ͷ���м�顣���������б��������ͷ��Ϊ��û���£���������һ��ͼ�ġ���Ի���ʮ���󲹡�
  else if((SlopeL + BlackCrossConfirmSlopeLimit < 0) //��һ��ͼ������б�ʺܴ�
   &&(BlackLeftHeadLine < BlackCrossConfirmHeadLineLimit) //��һ��ͼ��������ͷ�Ƚϸߡ�����ֹ��Ϊ���ر�̶���ɵ�б�ʲ�׼ȷ��
     )
  {
    return 0;
  }
  else
  {
  }
  
  //��һ�κ���̫�̣��޷������ȷ��ʱ�����Ҫ�������ǲ��ǹ������������������Ϊ��ȷ��
  //if(Row1RealLastLine >= CameraHight - 5 && Row2RealFirstLine > Row1RealLastLine + BlackRightCrossConfirmGapLine) return 1;
  //if(Row1RealLastLine >= CameraHight - 5) return 0;
  
  //�����Ͻ�Ϊԭ�㣬����Ϊx��������0~49��������Ϊy��������(0~249)
  index = 0;
  for(row = Row1RealLastLine; ; row++)
  {
    //��Ч�еļ�¼
    if(BlackRightLoc[row][0] != MaxValUint8)
    {
      y[index] = BlackRightLoc[row][0];
      x[index] = row;
      index++;
    }
    //�������࣬��������
    if(index == BlackCrossConfirmNum) break;
    //ֱ���������û�дչ��㹻�ĵ�����˵����һ����Ч����̫��.
    if(row == CameraHight - 1) 
    {
      if(index == 0) return 0;
      //�жϵڶ��κڵ�����ǲ����ڵ�һ�κڵ�ĩβ�����һ����Χ��
      if(BlackRightLoc[Row2RealFirstLine][0] < y[0] && y[0] - BlackRightLoc[Row2RealFirstLine][0] < 50)
      {
        return 1;
      }
      else
      {
        return 0;
      }      
    }
    else
    {
    }
  }
  
  //��С���˷�
  //y = a0 + a1 * x
  a1 = LeastSquarea1(x, y, BlackCrossConfirmNum);
  
  //�ж�б���ǲ��Ǵ����µ����ϣ�����ǣ��򷵻�ʧ�ܡ�
  if(a1 + BlackRightCrossConfirmSlopeLimit < 0) return 0;
  
  a0 = LeastSquarea0(x, y, a1, BlackCrossConfirmNum);
  
  //tempΪ��2�κ�����ʼ�б�Ӧ���ڵ�λ�á�
  temp = (a0 + a1 * Row2RealFirstLine) / LeastSquareMulti;

  //��������޶��ڴ���
  if(
    (BlackRightLoc[Row2RealFirstLine][0] > temp - BlackCrossConfirmWin)  //�����ֵ̫��Ļ������ڡ���˫�ϵ�����ʱ�����ʮ�����ߡ�
  &&(BlackRightLoc[Row2RealFirstLine][0] < temp + BlackCrossConfirmWin)  
    )
  {
    return 1;
  }
  else
  {
    return 0;
  }
    
  
}



//======================================================================
//��������BlackGetRightCrossSpeWin
//��  �ܣ��Һ���ʮ���ټ��ʱ�����ڵ�����ɨ��
//��  �����������к�row, ������߽�colleft, �����ұ߽�colright, �ڼ���ʹ��use.
//��  �أ�1�ɹ�  0ʧ��
//Ӱ  �죺BlackRightLoc[][0]
//˵  ����1. �����������������ܼ��ɹ���ֻ��һ����ļ�¼��
//        2. ������û�м�⵽������ʧ�ܡ�
//        3. ����ͨ����ɨ�費һ����ǰ�����������Ԥ��ֵ�ʹ��ڴ�С�����������ұ߽硣  
//======================================================================
uint8 BlackGetRightCrossSpeWin(uint8 row, uint8 colleft, uint8 colright, uint8 use)
{
  uint8 col;

  //�ڹ滮�õĴ����ڣ��������Ҳ���������
  //��ֹ���
  //���ұ߽������ 
  if(colright >= (CameraRealWidth - 5 - BlackRightEdgeNum)) 
  {
    colright = CameraRealWidth - 5 - BlackRightEdgeNum;
  }  
  else
  {
  }
  
  //���߿�ʼɨ��ʱ�����÷�ͼ��û�е��ߣ�������ɨ�����߽�����ڸ�����Ч����ߵ��ұߡ�
  if((BlackGetPreDir == 0 || BlackGetPreDir == 2)
   &&(SingleBlackAllFlag == 0)
   &&(BlackLeftLoc[row][0] != MaxValUint8)
     )
  {
    colleft = MaxRe(colleft, BlackLeftLoc[row][0]);
  }
  else
  {
  }
  
  //����Ԥ��ֵ��¼
  BlackRightPredictL[row] = colleft;
  BlackRightPredictR[row] = colright;
  
  //����߽����ұ߽��ұߣ�ֱ�ӷ���ʧ�ܡ�
  if(colleft >= colright) return 0;
  
  //����ɨ��������
  col = BlackGetRightJustWin(row, colleft, colright);
  if(col != MaxValUint8)
  {
    //�������������㣬ֱ�Ӽ�¼�õ�Ϊ���ߣ����ؼ���
    BlackRightLoc[row][0] = col + 1 + BlackRightEdgeNum;
    
    //����ȷ��ǰ����Ҫ�Դ�б�ʽ��м�⡣
    if(BlackRightBigChangeCheck(row, use) == 0)
    {
      //ûͨ���������⡣
      BlackRightBigChangeCheckRow[row] = 1;
      BlackRightBigChangeCheckAllRow = 1;             
      
      BlackRightLoc[row][0] = MaxValUint8;
      return 0;
    }
    else
    {
    }
    
    //��¼3���ؼ�ֵ��ʵ����Ϣ����Ϊ����Ĳο���
    if(use == 1)
    {
      BlackRightRealWB[0] = ImgNew[row][col] - ImgNew[row][col+1+BlackRightEdgeNum]; 
      BlackRightRealW[0] = ImgNew[row][col];
      BlackRightRealB[0] = ImgNew[row][col+1+BlackRightEdgeNum];
    }
    else if(use == 2)
    {
      BlackRightRealWB[1] = ImgNew[row][col] - ImgNew[row][col+1+BlackRightEdgeNum]; 
      BlackRightRealW[1] = ImgNew[row][col];
      BlackRightRealB[1] = ImgNew[row][col+1+BlackRightEdgeNum];
    }
    else
    {
    }
      
    return 1;
  }
  else
  {
    //������û�м�⵽�����أ����к�������Чֵ������0ʧ�ܡ�
    BlackRightLoc[row][0] = MaxValUint8;
    return 0;   
  }

}



//======================================================================
//��������BlackGetRightCrossSpeScan
//��  �ܣ�ʮ���ټ��ʱ������ͷ������ɨ��
//��  ������2�κ��ߵ�Ԥ����ʼ��Row2FirstLine�� ��2�κ��ߵ�Ԥ�������Row2LastLine��
//        ���һ�εĴ���Ԥ��ֵLastWinPredict
//��  �أ�MaxValUint8ʧ�ܣ�����ɹ���
//Ӱ  �죺
//˵  ����
//      
//             
//======================================================================
uint8 BlackGetRightCrossSpeScan(uint8 Row2FirstLine, uint8 Row2LastLine, uint8 LastWinPredict)
{
  uint8 row;
  uint8 temp1, temp2, temppredict, tempminus;
  uint8 colleft, colright;
  uint8 i;
  
  //���һ�εĴ���Ԥ��ֵ��
  temppredict = LastWinPredict;
  
  //colright��ȷ��
  //�����Һ���ɨ�裬colright��ʾ֮ǰ������Ч�Һ��ߵ����ҵ㡣
  //�ҵ�1����Ч�Һ��ߡ�
  for(i = Row2FirstLine+1; ; i++)
  {
    if(BlackRightLoc[i][0] != MaxValUint8)
    {
      colright = BlackRightLoc[i][0];
      break;
    }
    else
    {
    }
    //��һֱ�����һ����û����Ч����ߣ��򷵻�ʧ�ܡ������ϲ������ߵ����
    if(i == CameraHight - 1) return MaxValUint8;
  }
  //��ʱ�������ұߵ�����ߣ�Ҳ���൱��������ߵ�����ߡ�
//  //�����ҵ���Ч�Һ��ߡ�
//  for( ; ; i++)
//  {
//    if(BlackRightLoc[i][0] != MaxValUint8)
//    {
//      if(BlackRightLoc[i][0] > colright)
//      {
//        colright = BlackRightLoc[i][0];
//      }
//      else
//      {
//      }
//    }
//    else
//    {
//    }
//    
//    if(i == CameraHight - 1) break;
//  }
  
  for(row = Row2FirstLine; ; row -= 2)
  {
    //colleft��ȷ��
    colleft = BoundaryLimitRe(temppredict - BlackRightWinVal * 2,
                              0,
                              CameraRealWidth - 1); 
    //Ϊ�˷�ֹ�����д��������ұ߲��ô���BlackRightEdgeStartColOffset��
    colleft = MinRe(colleft, CameraRealWidth / 2 - 1 - BlackRightEdgeStartColOffset[row]);
    
    //����2�м��ڵ㡣
    temp1 = BlackGetRightCrossSpeWin(row, colleft, colright, 1);
    temp2 = BlackGetRightCrossSpeWin(row-1, colleft, colright, 2);
    //����2�п������ڵ�ɹ�������ͷ���ɹ���������
    if(temp1 == 1 && temp2 == 1)
    {
      return row;
    }
    //����2�п���������ʧ�ܣ��򴰿�Ԥ�������仯������������⡣
    else if(temp1 == 0 && temp2 == 0)
    {
      //Ԥ��㰴������ҲҪ�޷���
      tempminus = BoundaryLimitRe(BlackRightWinPredictStore2 + BlackRightWinPredictStore2 - BlackRightWinPredictStore1,
                                  0,
                                  CameraRealWidth - 1);
      //temp�������ʾ����Ԥ���λ�á�
      temppredict = tempminus;
      BlackRightWinPredictStore0 = BlackRightWinPredictStore1;
      BlackRightWinPredictStore1 = BlackRightWinPredictStore2;
      BlackRightWinPredictStore2 = temppredict;      
    }
    //����һ�п������ɹ����������ŵ㣬����Ԥ�������仯������������⡣
    else
    {
      //�������ŵ��˵���
      BlackRightLoc[row][0] = MaxValUint8;
      BlackRightLoc[row-1][0] = MaxValUint8;
      
      //Ԥ��㰴������ҲҪ�޷���
      tempminus = BoundaryLimitRe(BlackRightWinPredictStore2 + BlackRightWinPredictStore2 - BlackRightWinPredictStore1,
                                  0,
                                  CameraRealWidth - 1);
      //temp�������ʾ����Ԥ���λ�á�
      temppredict = tempminus;
      BlackRightWinPredictStore0 = BlackRightWinPredictStore1;
      BlackRightWinPredictStore1 = BlackRightWinPredictStore2;
      BlackRightWinPredictStore2 = temppredict;         
    }
      
      
      
    //һֱ����Row2LastLine��Ҳû������2�м��ɹ����򷵻�ʧ�ܡ�
    if(row == Row2LastLine) 
    {
      return MaxValUint8;
    }
    else
    {
    }
  }
 

}




//======================================================================
//��������BlackRightAgainForCross
//��  �ܣ��Һ�����ȡ�У����ʮ�ֵ��ټ�����
//��  ������2�κ��ߵ�Ԥ����ʼ��Row2FirstLine�� ��2�κ��ߵ�Ԥ�������Row2LastLine��
//        ��1�κ��ߵ�ʵ�ʽ�����Row1RealLastLine, ���һ�εĴ���Ԥ��ֵLastWinPredict
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺BlackRightLoc[][]�� ������Ӱ���Ǽ�����ֵ����
//˵  ����1. ����������ø�������ĺ�����Ԥ�ƻ��ѽ϶�ʱ�䣬��������������
//        2. ��������Ӱ����BlackRightLoc[][]���Ժ�ҲӦ�ñ��֡�
//             
//======================================================================
uint8 BlackRightAgainForCross(uint8 Row2FirstLine, uint8 Row2LastLine, uint8 Row1RealLastLine, uint8 LastWinPredict)
{
    uint8 row, temp, temp1, temp2;
    uint8 Row2RealFirstLine; //��2�κ��ߵ���ʵ��ʼ��
    uint8 i;
    
    uint8 tempWB, tempW, tempB;
    uint8 tempminus;
    
    //��1�κ��ߵ���ʵ�������п�����Ϊ�����䱻ɾ����������Ҫ���²��Ҳ����¡�
    for(i = Row1RealLastLine; i <= CameraHight - 1; i++)
    {
      if(BlackRightLoc[i][0] != MaxValUint8)
      {
        Row1RealLastLine = i;
        break;
      }
      else
      {
      }
    }
    //����ֱ�Ǻڿ鲻������ʮ���ٲ��ߣ����Ե���1�κ�����ʵ�����е�б�Ϸ��кڿ�ʱ���������ߡ�
    //ȡ5�С�
    for(i = 0; i <= 5; i++)
    {
      if(ImgNew[Row1RealLastLine - 4][BlackRightLoc[Row1RealLastLine][0] - 5 - i] < LimitRightB) //��Զ5�С�б���Ϸ���
      {
        return 0;
      }
      else if(ImgNew[Row1RealLastLine - 5][BlackRightLoc[Row1RealLastLine][0] - 5 - i] < LimitRightB) //��Զ5�С�б���Ϸ���
      {
        return 0;
      }
      else
      {
      }      
    }
    
    //ʮ���ټ���1�׶Σ�����ͷ��
    //temp = BlackGetRightStep1Scan(Row2FirstLine, Row2LastLine, 0); //��3������0��ʾ��ʮ���ټ�⣬���ø���3���ؼ�ֵ
    
    //ʮ���ټ���1�׶Σ�����ͷ��������Scan�ķ�ʽ������Win�ķ�ʽ��
    temp = BlackGetRightCrossSpeScan(Row2FirstLine, Row2LastLine, LastWinPredict);
    
    //��ͷ����ʧ�ܣ����ҵ���Զ���У�����ִ�к�������鳬�����ޣ�����ֱ���ж�Ϊʧ�ܡ�
    if(
      (temp == MaxValUint8)
    ||(temp <= 1)
    ||(BlackAgainForCrossFar10CutSwitch == 1 && temp <= 9)  //��Զ10��ɾ�����ؿ���ʱ����ʮ���ټ��ʱ�ĵ�2�κ�����ͷ����Զ��10�У���ʮ���ټ��ʧ�ܡ�
      )
    {
      //ɨƨ�ɹ�����        //i >= Row2LastLine
      for(i = Row2FirstLine; ; i--)
      {
        BlackRightLoc[i][0] = MaxValUint8;
        if(i == 0) break;
      }
      return 0;  
    }
    else 
    {
      ////////////////���Ҫע�ͣ��ʹ����￪ʼע��
      
      //ʮ���ټ�����ͷ�����޶��ķ�Χ�ڣ���Ϊ�Ǹ��ŵ㣬����˳����ͷ�����ˣ�ֱ���˳���
      if(BlackRightCrossConfirm(Row1RealLastLine+1, temp) == 0)
      { //ɨƨ�ɹ�����         //i >= (temp-1)
        BlackRightCrossConfirmFlag = 1;  //��ʮ����ͷ��־ȷ��ʧ�ܣ�����Ԥ�뷶Χ��
        for(i = Row2FirstLine; ; i--)
        {
          BlackRightLoc[i][0] = MaxValUint8;
          if(i == 0) break;
        }
        return 0;
      }
      //ʮ���ټ�����ͷ��ȷ���޶��ķ�Χ�ڣ����Լ�����
      else
      {
        BlackRightCrossConfirmFlag = 2;  //��ʮ����ͷ��־ȷ�ϳɹ���
        row = temp;
      }
      
      ////////////////���Ҫע�ͣ��ʹ��������ע��
      
      //��ʱ����confirm���������Ҫ�õĻ� ���ͰѺ�����仰ȥ����ǰ��ע��ȥ����
      //row = temp;
    }
    
    Row2RealFirstLine = row; //��¼��2�κ��ߵ���ʵ��ʼ��
    
    //ʮ���ټ���2�׶Σ�˳����ͷ���ߡ�
    //tempΪԤ��ĺڵ�λ��
    temp = BoundaryLimitRe(BlackRightLoc[row-1][0] + BlackRightLoc[row-1][0] - BlackRightLoc[row][0],
                           0,
                           CameraRealWidth - 1);
    //Ԥ��ֵ���º��ˢ��һ�ζ�ջ����ջ������ʧ��
    BlackRightWinPredictStore0 = BlackRightWinPredictStore1;
    BlackRightWinPredictStore1 = BlackRightWinPredictStore2;
    BlackRightWinPredictStore2 = temp;
    
    //���������֤�е�ȡ��Զ����
    for(row -= 2; ; row -= 2)
    {
      //����2�м��ڵ�
      temp1 = BlackGetRightStep2Win(row, BlackRightWinVal, temp, 1);
      temp2 = BlackGetRightStep2Win(row-1, BlackRightWinVal, temp, 2);
      
      //������2�еĺڵ���ɹ��������3����ֵ������Ԥ����λ��
      if(temp1 && temp2) 
      {
        //��ֵ�Ĵ�������ԣ�ȣ��������½硣
        tempWB = (BlackRightRealWB[0] + BlackRightRealWB[1]) / 2 - LimitRightWBMargin; 
        if(tempWB < LimitRightWBMin) tempWB = LimitRightWBMin;
        else if(tempWB > LimitRightWBMax) tempWB = LimitRightWBMax;
        else ;
        LimitRightWB = tempWB;
        
        //�׵�Ĵ�������ԣ�ȣ��������½硣
        tempW = (BlackRightRealW[0] + BlackRightRealW[1]) / 2 - LimitRightWMargin;
        if(tempW < LimitRightWMin) tempW = LimitRightWMin;
        else if(tempW > LimitRightWMax) tempW = LimitRightWMax;
        else ;
        LimitRightW = tempW;
        
        //�ڵ�Ĵ�������ԣ�ȣ��������½硣
        tempB = (BlackRightRealB[0] + BlackRightRealB[1]) / 2 + LimitRightBMargin;
        if(tempB < LimitRightBMin) tempB = LimitRightBMin;
        else if(tempB > LimitRightBMax) tempB = LimitRightBMax;
        else ;
        //��ɫ��ֵ���ܳ�����ɫ
        if(tempB >= LimitRightW)
        {
          tempB = LimitRightW - 1;
        }
        else
        {
        }              
        LimitRightB = tempB;     
        
        //��Ԥ��ֵ�ĸ��¡�
        temp = BoundaryLimitRe(BlackRightLoc[row - 1][0] + BlackRightLoc[row - 1][0] - BlackRightLoc[row][0],
                               0,
                               CameraRealWidth - 1);
        //Ԥ��ֵ���º��ˢ��һ�ζ�ջ����ջ������ʧ��
        BlackRightWinPredictStore0 = BlackRightWinPredictStore1;
        BlackRightWinPredictStore1 = BlackRightWinPredictStore2;
        BlackRightWinPredictStore2 = temp;
      }
      //���û���������м��ڵ�ɹ���ԭ��������ԭλ�õ�Ԥ��㣬��������Ч�����ã����Ծ�����Ԥ���������ߡ�
      else
      {        
        //Ԥ��㰴������ҲҪ�޷���
        tempminus = BoundaryLimitRe(BlackRightWinPredictStore2 + BlackRightWinPredictStore2 - BlackRightWinPredictStore1,
                                    0,
                                    CameraRealWidth - 1);
        //temp�������ʾ����Ԥ���λ�á�
        temp = tempminus;
        BlackRightWinPredictStore0 = BlackRightWinPredictStore1;
        BlackRightWinPredictStore1 = BlackRightWinPredictStore2;
        BlackRightWinPredictStore2 = temp;
      }
      
      if((row == Row2LastLine) || (row == Row2LastLine+1)) break;      
    }
    
    //����Ƿ����б�ʶ�����ͷ������У������ͷ��λ�ã����û�У����������ߡ�
    if (BlackRightLoc[Row1RealLastLine][0] == MaxValUint8)
    {

        //ͷ�㹻�ߣ��һ�ͷ��
        for (i = Row1RealLastLine; ; i++)
        {
            if (BlackRightLoc[i][0] != MaxValUint8)
            {
                Row1RealLastLine = i;
                break;
            }
            else
            {
            }
            //ֱ�����һ��Ҳû���ҵ���Ч�У����ò��ߣ�ֱ�ӷ���1.
            if (i == CameraHight - 1) return 1;
        }

        //ʮ���ټ���3�׶Σ��Բ������ߵĽ��ߡ�
        if (BlackRightCrossStep3(Row1RealLastLine, Row2RealFirstLine) == 0)
        {
            return 0;
        }

    }
    else
    {
        //û�б���б����ͷ��
        //ʮ���ټ���3�׶Σ��Բ������ߵĽ��ߡ�
        if (BlackRightCrossStep3(Row1RealLastLine, Row2RealFirstLine) == 0)
        {
            return 0;
        }
    }
    
    return 1;
        
}


//======================================================================
//��������BlackRightStep4BackLine
//��  �ܣ��Һ�����ȡ�У���4�׶�ʮ������ߺ�����
//��  ����Step4StartLine��ʼ��,flag��־0��ʾ�������ã�1��ʾ���ߴ���ĵ���
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺BlackRightLoc[][0]
//˵  ����1. ����������float�͵ĺ������п���ռ�ýϳ���ʱ�䡣
//        2. ��Ҫ����ʱ�䣬���԰Ѻ궨��BlackBackLineNum����3����2.
//        3. ���ߴ���ĵ���ʱ�����ü��ʮ����β
//======================================================================
uint8 BlackRightStep4BackLine(uint8 Step4StartLine, uint8 flag)
{
  uint8 row;
  uint8 i, index;
  uint8 x[BlackBackLineNum];   //ȡ���ٸ�����һ��ʼ�ж��塣
  uint8 y[BlackBackLineNum];
  uint8 j;
  uint8 temp1;
  uint8 tempend;
  
  int32 temp;
  int32 a0;
  int32 a1;
  
  //��������ʱ����Ҫ���ʮ����β
  if(flag == 0)
  {
    //ʮ����β����
    //��1�׶ε���ͷ�ȽϸߵĻ����Ϳ�ʼʮ����β��⡣�����ùܡ�
    if(BlackRightStep1ScanRow < BlackRightCrossTailRowLimit)
    {
      //�����ͷ����б���ǲ��Ǻܴ����ܴ�������ʮ����β�������ùܡ�
      //�����õ�б����ʮ����βר��б�ʡ�
      if(BlackRight5Slope[0] > BlackRightCrossTailSlopeLimit)
      {
        //ʮ����β��־��λ��
        BlackRightCrossTailFlag = 1;
        BlackRightHeadEndSearch();
        if (BlackRightEndLine - BlackRightHeadLine <= 5 && BlackLeftHeadLine != MaxValUint8 && BlackLeftEndLine != MaxValUint8)
        {
            //��������п����ǻ��䵼�µģ����˵�
            for (i = BlackRightHeadLine; i <= BlackRightEndLine; i++)
            {
                BlackRightLoc[i][0] = MaxValUint8;
            }
            return 0;
        }
        else if (BlackRight5Slope[0] == MaxValInt16)
        {
            //��������п����ǻ��䵼�µģ����˵�
            for (i = 0; i <= 59; i++)
            {
                BlackRightLoc[i][0] = MaxValUint8;
            }
            return 0;
        }
        //5Slope�����п����Ѿ�ɾ����һЩ�ڵ㣬����ҲҪ�ο�ʵ�ʵ���Ч�ڵ�����
        if(BlackRightEndLine - BlackRightHeadLine - 4 < 0 || BlackRight5SlopeIndex - 1 < 0)
        {
          return 0;
        }
        else
        {
        }        
        tempend = MinRe(BlackRightEndLine - BlackRightHeadLine - 4, BlackRight5SlopeIndex - 1);
        //��ʼ����ʮ����β����ʮ����β�Ĵ�����Զ�С�
        for(i = 0; ; i++)
        {
          //��б����ֱ����Χ�ڵġ������õ�б�����ж�Ϊֱ����б�ʡ�
          if(BlackRight5Slope[i] < PathJudgeStraightSlopeLimit)
          {
            BlackRightCrossTailEndLine = BlackRight5SlopeRow[i];
            break;
          }
          
          if(i == tempend) return 0;  //һֱ����б�����п����ǻ��䣬ֱ�ӷ���ʧ�ܡ�
          //����˵�����ߵ������Ϊ����ᵼ������߳�������߳�������������ʱ���ȼ������ԭ��BlackRightStep4ErrorCheck()������б���ǲ��Ƕ���ֱ�ߣ��������򲻻������
        }
        //�����4���㣬Ҳ���ǡ�5����б�ʵļ���ĩβ��
        BlackRightCrossTailEndLine += 4;
        //ȡ�ʼ�ɵ�����
        i = MinRe(BlackRight5SlopeRow[0] + 4, CameraHight - 1);
        i = MaxRe(BlackRightStep1ScanRow, i);
        if(i >= BlackRightCrossTailEndLine)
        {
          //��ʼɾ��ʮ����β��
          for(; ; i--)
          {
            BlackRightLoc[i][0] = MaxValUint8;
            if(i == BlackRightCrossTailEndLine) break;
          }
          //�޸�����ߵ���㡣
          Step4StartLine = BlackRightCrossTailEndLine - 1;
        }
        else
        {
        }
      }
      else
      {
        //û��ʮ����β��
        BlackRightCrossTailFlag = 0;      
      }
    }
    else
    {    
      //û��ʮ����β��
      BlackRightCrossTailFlag = 0;
    }
  }
  //���ߴ������ʱ���Ͳ��ü��ʮ����β�ˡ�
  else
  {
  }  
  

  //������ʮ�������
  if(Step4StartLine - BlackBackLineNum - BlackBackLineNum < 0)
  {
    temp1 = 0;  
  }
  else
  {
    temp1 = Step4StartLine - BlackBackLineNum - BlackBackLineNum;
  }
  
  //ȡBlackBackLineNum������Ϊ��С���˷��Ļ�׼�㡣
  //�����Ͻ�Ϊԭ�㣬����Ϊx������������Ϊy��������
  index = 0;
  for(i = Step4StartLine; ; i--)
  {
    if(BlackRightLoc[i][0] != MaxValUint8)
    {
      y[index] = BlackRightLoc[i][0];
      x[index] = i;
      index++;
    }
    if(index == BlackBackLineNum)
    {
      break;  
    }
    if(i == temp1)
    {
      return 0;
    }
  }
  
  //��С���˷�
  //y = a0 + a1 * x
  a1 = LeastSquarea1(x, y, BlackBackLineNum);
  /*
   //���ֱ���Ǵ����ϵ����£���˵����ȡ���˴�����ߣ������ٲ��ߣ�ȫ�������㡣
  if(a1 + BlackRightBackLineSlope < 0)
  {
    for(row = Step4StartLine; ; row--)
    {
      BlackRightLoc[row][0] = MaxValUint8;
      if(row == 0) break;
    }
    return 0;
  }
  //���������
  else
  {
  }
  */
  
  //ֱ�Ų�������˳�Ų���
  /*
  for (row = Step4StartLine + 1; row <= CameraHight - 1; row++)
  {
    BlackRightLoc[row][0] = BlackRightLoc[Step4StartLine][0];
  }
  */
  
  //˳�Ų�������ֱ�Ų���
  a0 = LeastSquarea0(x, y, a1, BlackBackLineNum);
  
  for(row = Step4StartLine + 1; row <= CameraHight - 1; row++)
  {
    //����Ҳ�и��ȣ����Һ����󶼲��ܲ�����Χ��
    temp = (a0 + a1 * row) / LeastSquareMulti;
    if(temp >= CameraRealWidth-1)
    {
      //BlackRightLoc[row][0] = CameraRealWidth - 1;
      //�������ҽ���ʱ��ԭ����Ϊ�ñ߽�ֵ�����ڵĲ����ǴӸ���������Чֵ��
      for(j = row; ; j++)
      {
        BlackRightLoc[j][0] = CameraRealWidth-1;
        if(j == CameraHight - 1) break;
      }
      break;
    }
    else if(temp <= 0)
    {
      //BlackRightLoc[row][0] = 0;
      //�������ҽ���ʱ��ԭ����Ϊ�ñ߽�ֵ�����ڵĲ����ǴӸ���������Чֵ����
      for(j = row; ; j++)
      {
        BlackRightLoc[j][0] = 0;
        if(j == CameraHight - 1) break;
      }
      break;
    }
    else
    {
      BlackRightLoc[row][0] = (uint8)(temp); 
    }
  }
  
  
  
  return 1;
  
}




//�Һ��������Բ���
uint8 BlackRightContinueAdd(void)
{
    uint8 row, i, j;
    uint8 tempfirst, templast;
    uint8 fangHuiWanFlag = 0;
    uint8 fangDuanLieFlag = 0;
    
    //�Һ��������Բ���
    //ֻ���Һ��߲ɼ��ɹ��Ų���
    if(BlackRightDone == 1)
    {        
        //����β
        for(row = CameraHight - 1; ; row--)
        {
          if(BlackRightLoc[row][0] != MaxValUint8)
          {
            break;
          }
          else
          {
          }
          
          if(row == 0)
          {
            BlackRightDone = 0;
            return 0;
          }
        }
        
        //����ͷ��β��ʼ��Ϊ��Чֵ��
        tempfirst = MaxValUint8;
        templast = MaxValUint8;
                
        //��ʼ����
        for (; ; row--)
        {
            if (BlackRightLoc[row][0] == MaxValUint8)
            {
                if (tempfirst == MaxValUint8)
                {
                    //����ͷΪ��Чֵ���ͼ�¼Ϊ��ͷ��
                    tempfirst = row + 1;
                    break;
                }
                else
                {
                }
            }
            else
            {
                if (tempfirst != MaxValUint8)
                {
                    //����ͷ�Ѿ��и�ֵ����ʼ��¼��β��
                    templast = row;
                    
                    if (templast > 5)
                    {
                        if (BlackRightLoc[templast - 1][0] != MaxValUint8 && BlackRightLoc[templast - 2][0] != MaxValUint8 && BlackRightLoc[templast - 3][0] != MaxValUint8
                            && BlackRightLoc[templast - 4][0] != MaxValUint8 )
                        {
                            fangDuanLieFlag = 0;
                        }
                        else
                        {
                            fangDuanLieFlag = 1;
                        }
                    }
                    else
                    {
                        fangDuanLieFlag = 1;
                    }
                    if (templast >= 8)
                    {
                        if (BlackRightLoc[templast - 1][0] != MaxValUint8 && BlackRightLoc[templast - 2][0] != MaxValUint8 && BlackRightLoc[templast - 3][0] != MaxValUint8
                            && BlackRightLoc[templast - 4][0] != MaxValUint8 && BlackRightLoc[templast - 5][0] != MaxValUint8
                                && BlackRightLoc[templast - 6][0] != MaxValUint8 && BlackRightLoc[templast - 7][0] != MaxValUint8 && BlackRightLoc[templast - 8][0] != MaxValUint8)
                        {
                            fangHuiWanFlag = 0;
                        }
                        else
                        {
                            fangHuiWanFlag = 1;
                        }
                    }
                    else
                    {
                        fangHuiWanFlag = 1;
                    }
                    
                    if((BlackRightLoc[tempfirst][0]>=235&&BlackRightLoc[templast][0]>=235) && (tempfirst - templast) <= 12)
                    {
                        //��������Ƿ�ֹ����̫����ͷ�߽絼�º��߲��ɹ���
                        for (j = tempfirst - 1; ; j--)
                        {
                            BlackRightLoc[j][0] = (BlackRightLoc[tempfirst][0] + BlackRightLoc[templast][0]) / 2;
                            if (j == templast + 1) break;
                        }
                    }
                    else if ((BlackRightLoc[tempfirst][0] >= 235 && BlackRightLoc[templast][0] >= 235) && (tempfirst - templast) <20
                             && (BlackRightLoc[10][0] != MaxValUint8 || BlackRightLoc[9][0] != MaxValUint8 || BlackRightLoc[8][0] != MaxValUint8 || BlackRightLoc[7][0] != MaxValUint8 || BlackRightLoc[6][0] != MaxValUint8)
                             && fangHuiWanFlag == 0)
                    {
                        //��������Ƿ�ֹ����̫����ͷ�߽絼�º��߲��ɹ���
                        for (j = tempfirst - 1; ; j--)
                        {
                            BlackRightLoc[j][0] = (BlackRightLoc[tempfirst][0] + BlackRightLoc[templast][0]) / 2;
                            if (j == templast + 1) break;
                        }
                    }
                    else if ((BlackRightLoc[tempfirst][0] >= 235 && BlackRightLoc[templast][0] >= 235) && (tempfirst - templast) <= 35
                             && (BlackRightLoc[6][0] != MaxValUint8 || BlackRightLoc[7][0] != MaxValUint8 || BlackRightLoc[8][0] != MaxValUint8 || BlackRightLoc[10][0] != MaxValUint8 || BlackRightLoc[9][0] != MaxValUint8)
                             && fangHuiWanFlag == 0)
                    {
                        //��������Ƿ�ֹ����̫����ͷ�߽絼�º��߲��ɹ���
                        for (j = tempfirst - 1; ; j--)
                        {
                            BlackRightLoc[j][0] = (BlackRightLoc[tempfirst][0] + BlackRightLoc[templast][0]) / 2;
                            if (j == templast + 1) break;
                        }
                    }
                    //�����߶��ѵ�
                    else if (tempfirst - templast <= 5 && fangDuanLieFlag == 0)
                    {
                        for (j = tempfirst - 1; ; j--)
                        {
                            BlackRightLoc[j][0] = (BlackRightLoc[tempfirst][0] + BlackRightLoc[templast][0]) / 2;
                            if (j == templast + 1) break;
                        }
                    }
                    else if(tempfirst - templast >= 3) 
                    {
                      //�������̫�࣬��������ȫ����Ϊ����
                      for(i = tempfirst - 1; ; i--)
                      {
                        BlackRightLoc[i][0] = MaxValUint8;
                        if(i == 0) break;
                      }
                      //�Һ��������Ա�־����
                      BlackRightContinueFlag = 2;
                      return 0;
                    }
                    else
                    {
                      //һ����1��2���㣬ֱ�Ӳ�ֵ���С�
                      for(j = tempfirst - 1; ; j--)
                      {
                        BlackRightLoc[j][0] = (BlackRightLoc[tempfirst][0] + BlackRightLoc[templast][0]) / 2;
                        if(j == templast + 1) break;
                      }
                    }
                    tempfirst = MaxValUint8;
                    templast = MaxValUint8;
                    //�Һ��������Ա�־��0����������
                    BlackRightContinueFlag = 0;
                }
                else
                {
                }
            }

            if (row == 0) break;
        }
    }
    else
    {
    }    
    
    return 1;
}



//�Һ��ߵĻ��������⡣����ǰBlackRightDone�Ѿ���Ϊ1�ˡ�
//����ǰ�Ѿ��������Һ��ߵ�б���ʼ�⡣
uint8 BlackRightRollCheck(void)
{
  uint8 temp1, temp2, temp3;
  
  //��ǰΪ���ߣ������л��������⡣
  if(SingleBlackAllFlag == 1) return 1;
  
  //б��ȷ�ϡ�
  //����Ч��ֱ��ȷ�ϡ�
  if(SlopeR == MaxValInt16)
  {
    temp1 = 1;
  }
  else
  {
    //б�ʵ�ȷ̫��
    if(SlopeR > BlackRightRollSlopeLimit)
    {
      temp1 = 1;
    }
    //б�ʲ���
    else
    {
      temp1 = 0;
    }
  }
  
  //�߳���ȷ�ϡ�
  //����Ч��ֱ��ȷ�ϡ�
  if(BlackRightHeadLine == MaxValUint8 || BlackRightEndLine == MaxValUint8)
  {
    temp2 = 1;
  }
  else
  {
    //��ȷʵ�̡ܶ�
    if(BlackRightEndLine - BlackRightHeadLine < BlackRightRollLengthLimit)
    {
      temp2 = 1;
    }
    //�ߺܳ���
    else
    {
      temp2 = 0;
    }
  }
  
  /*
  //����б��ȷ�ϡ�
  //���߱��������ϵ����µģ�Ҳ���Ǹ���б�ʡ�����б��Ҫ�����ֵ�Ƚϴ󡣲���˵����270�ȴ��䡣
  if(SlopeL == MaxValInt16)
  {
    temp3 = 1;    
  }
  else
  {
    if(SlopeL + BlackRightRollSlopeLLimit < 0)
    {
      temp3 = 1;
    }
    else
    {
      temp3 = 0;
    }
  }  
  */
  temp3 = 1;
  
  if(
    (BlackRightStep4Flag == 3 || SingleBlackLastAllFlag == 1)   //������߱�־������������Ϊ�Ϸ�ͼ���ǵ��ߣ��޷�����ʮ�֣��޷�������߳���
  &&(BlackRightCrossDone == 1 || BlackRightCrossDone == 0)   //��ʮ�ֱ�־��ʧ�ܡ�����δ���루��β���߲������ʮ���ټ�⣩��
  &&(temp1 == 1)                //б�ʺܴ�
  &&(temp2 == 1)                //�ߺ̡ܶ�
  &&(temp3 == 1)                //����
    )
  {
    //��⵽���䣬����0.
    return 0;   
  }
  else
  {
    //û��⵽���䣬����1.
    return 1;
  }

}

//����߱�־����ʱ�ļ�飬��������Ƿ�ֹ����ĺ���Ҫ�ĺ�����
uint8 BlackRightStep4ErrorCheck(void)
{
  uint8 i;
  
  //���б���ǲ��Ƕ�����ֱ��
  for(i = 0; ; i++)
  {
    if(BlackRight5Slope[i] == MaxValInt16) return 0;
    
    if(AbsInt(BlackRight5Slope[i]) > PathJudgeStraightSlopeLimit)
    {
      return 0;
    }
    else
    {      
    }
    
    if(i == 5) break;
  }
  
  return 1;
  
}



//�Һ�����ȡǰ�Ĳ�����ʼ����ֵ
uint8 BlackGetRightParaInit(void)
{
  uint8 i;  
  
  //���������Ա�־��Ĭ��Ϊ1������
  BlackRightContinueFlag = 1;  
  
  //�ɼ��ɹ���־λ
  BlackRightDone = 1;  
 
  //��ʮ����ͷ��־��0δ���룬1����Χ��2�ɹ���
  BlackRightCrossConfirmFlag = 0;  //Ĭ��Ϊδ���롣  
  
  //С5��б�ʴ��������ó�ʼֵ��
  BlackRight5SlopeIndex = 0;  
  for(i = 0; ; i++)
  {
      BlackRight5Slope[i] = MaxValInt16;
      BlackRight5SlopeRow[i] = MaxValUint8;
      if(i == CameraHight - 1) break;
  }  
  
  //������
  BlackRightRollCheckFlag = 0;        //��⵽���䡣
  BlackRightBigChangeJumpFlag = 0;    //����������־��

  //��б�ʼ��ʱ��ÿ��ͼ��ĳ�ʼֵ��ʼ��Ϊ��Чֵ��
  for(i = 0; i <= 4; i++)
  {
    BlackRightBigChangeNumx[i] = MaxValUint8;
    BlackRightBigChangeNumy[i] = MaxValUint8; 
  }
  BlackRightBigChangeFlag = 0;
  BlackRightBigChangeSlopeStore = MaxValInt16;

  //��б�ʼ��ʱ��ÿ�еĴ������־��0.
  for(i = 0; ; i++)
  {
    BlackRightBigChangeCheckRow[i] = 0;
    if(i == CameraHight - 1) break;
  }
  BlackRightBigChangeCheckAllRow = 0;

  //�Һ��ߴ��������ʼ��Ϊ��Чֵ��
  for(i = 0; ; i++)
  {
    BlackRightLoc[i][0] = MaxValUint8;
    if(i == CameraHight - 1) break;
  }

  //ʮ����β
  BlackRightCrossTailFlag = 2;       //ʮ����β��־��0ʧ�ܣ�1ȷ�ϣ�2δ���롣

  //����Ԥ��ֵ����
  for(i = 0; ; i++)
  {
    BlackRightPredictL[i] = MaxValUint8;
    BlackRightPredictR[i] = MaxValUint8; 
    if(i == CameraHight - 1) break;
  }

  //����Ԥ�ⴢ��ֵ
  BlackRightWinPredictStore0 = MaxValUint8;
  BlackRightWinPredictStore1 = MaxValUint8;
  BlackRightWinPredictStore2 = MaxValUint8;
  
  //��4�׶ν����־��Ϊδ���롣
  BlackRightStep4Flag = 0;
  BlackRightStep4StartLine = MaxValUint8;
  //Ĭ��ʮ�ּ���־��Ϊδ���롣
  BlackRightCrossDone = 0;
    
  return 1;
}


//======================================================================
//��������BlackGetRight
//��  �ܣ��Һ�����ȡ�㷨
//��  ������
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺BlackRightCrossDone��BlackRightLoc[][],
//        BlackRightRealWB[], BlackRightRealW[], BlackRightRealB[],
//        LimitRightWB, LimitRightW, LimitRightB
//˵  ����1. ��ʱ���Դ���ֱ���������ʮ��·��3�������2014.11.10
//      
//       
//       
//======================================================================
uint8 BlackGetRight(void)
{
    uint8 row, temp, temp1, temp2, temp3, i;
    uint8 GapCount, Row1RealLastLine, index, index1;
    uint8 tempWB, tempW, tempB;
    uint8 tempminus;
    uint8 successRow = MaxValUint8;
    
    int temp001;
    
    //�Һ�����ȡʱ�Ĳ�����ʼ����ֵ
    BlackGetRightParaInit();     
    
    //��1�׶Ρ���1�׶��п��ܻ᷵�غ�����ȡʧ��
    
    //ÿ����Чͼ�����ͷ��3����ֵ�������档Step1Scanǰ����ǰһ����Чͼ�񱣴��3����ֵ��
    LimitRightWB = LimitRightHeadWB;
    LimitRightW = LimitRightHeadW;
    LimitRightB = LimitRightHeadB;
            
    temp = BlackGetRightStep1Scan(CameraHight - 1, CameraHight - BlackStep1Size - 1, 1);
    BlackRightStep1ScanRow = temp;
    
    //���߿�ʼɨ�������£�����β������ͷ�ߣ�ֱ�ӷ���ʧ�ܡ����Ӻ������������Ϊ�˷�ֹʮ�����С�
//    if(
//       (BlackGetPreDir == 0 || BlackGetPreDir == 2)
//     &&(temp <= BlackLeftHeadLine)
//     &&(BlackLeftHeadLine < CameraHight - 7)
//      )
//    {
//        BlackRightLoc[temp][0] = MaxValUint8;
//        BlackRightLoc[temp - 1][0] = MaxValUint8;
//        return 0;
//    }
//    else
//    {
//    }
    
    if(temp == MaxValUint8)
    {
      return 0;
    }
    else
    {   
      //ÿ����Чͼ�����ͷ��3����ֵ�������档����ͷ��ȡ�ɹ�����÷�ͼ����Ч����ͷ3����ֵ���¡�
      LimitRightHeadWB = LimitRightWB;
      LimitRightHeadW = LimitRightW;
      LimitRightHeadB = LimitRightB;
      
      row = temp;
      //�����ʼ��ͷ��λ�÷ǳ��ߣ�����Ϊ��ʮ�ֵ�ǰ�����ǣ���Ҫ�����4�׶�����ߡ�    
      if(row < CameraHight - BlackRightBackLineStart)
      {
        BlackRightStep4Flag = 1;             //Ĭ��Ϊʧ�ܡ�
        BlackRightStep4StartLine = row;
      }

    }
      
    //��2�׶Ρ�������һ�׶Σ��Ѿ����᷵�غ�����ȡʧ�� 
    //���濪ʼ����б���Һڵ㡣
    //�ϴ��Ѿ��������˵�row-1�У���һ��Ҫ�����row-2��
    //BlackRightSlope();
    
    //tempΪԤ��ĺڵ�λ��
    //��Ԥ��ֵ�����޶���
    temp = BoundaryLimitRe(BlackRightLoc[row - 1][0] + BlackRightLoc[row - 1][0] - BlackRightLoc[row][0],
                           0,
                           CameraRealWidth - 1);    
    //Ԥ��ֵ���º��ˢ��һ�ζ�ջ����ջ������ʧ��
    BlackRightWinPredictStore0 = BlackRightWinPredictStore1;
    BlackRightWinPredictStore1 = BlackRightWinPredictStore2;
    BlackRightWinPredictStore2 = temp;
        
    index = 0;
    index1 = 0;
    
    GapCount = 0;  //����������û�вɵ�����
    successRow = MaxValUint8; //��¼���һ�γɹ�����
    //���������֤�е�ȡ��Զ����
    for(row -= 2; ; row -= 2)
    {  
      //����2�м��ڵ�λ�á�     
      //���������Ѿ������߱�־��λ�����⵽�����ͷ���ɷ��ء�
      if(SingleBlackAllFlag == 1 && row < BlackLeftHeadLine) return 1;
      temp1 = BlackGetRightStep2Win(row, BlackRightWinVal, temp, 1);
      if(SingleBlackAllFlag == 1 && row - 1 < BlackLeftHeadLine) return 1;
      temp2 = BlackGetRightStep2Win(row-1, BlackRightWinVal, temp, 2);
      
      temp3 = (
              (temp1 == 0)
            &&(temp2 == 0)
            //&&(BlackRightStep4Flag == 0)
              );
      //������2�еĺڵ���ɹ��������3����ֵ������Ԥ����λ��
      if(temp1 == 1 && temp2 == 1) 
      {
        //ֻҪ�����ɼ���˫���ߣ���������־λ����Ϊ0.
        index = 0;
        index1 = 0;
        successRow = row;
      
        //��ֵ�Ĵ�������ԣ�ȣ��������½硣
        tempWB = (BlackRightRealWB[0] + BlackRightRealWB[1]) / 2 - LimitRightWBMargin; 
        if(tempWB < LimitRightWBMin) tempWB = LimitRightWBMin;
        else if(tempWB > LimitRightWBMax) tempWB = LimitRightWBMax;
        else ;
        LimitRightWB = tempWB;
        
        //�׵�Ĵ�������ԣ�ȣ��������½硣
        tempW = (BlackRightRealW[0] + BlackRightRealW[1]) / 2 - LimitRightWMargin;
        if(tempW < LimitRightWMin) tempW = LimitRightWMin;
        else if(tempW > LimitRightWMax) tempW = LimitRightWMax;
        else ;
        LimitRightW = tempW;
        
        //�ڵ�Ĵ�������ԣ�ȣ��������½硣
        tempB = (BlackRightRealB[0] + BlackRightRealB[1]) / 2 + LimitRightBMargin;
        if(tempB < LimitRightBMin) tempB = LimitRightBMin;
        else if(tempB > LimitRightBMax) tempB = LimitRightBMax;
        else ;
        //��ɫ��ֵ���ܳ�����ɫ
        if(tempB >= LimitRightW)
        {
          tempB = LimitRightW - 1;
        }
        else
        {
        }             
        LimitRightB = tempB;   
         
        //��Ԥ��ֵ�����޶���
        temp = BoundaryLimitRe(BlackRightLoc[row - 1][0] + BlackRightLoc[row - 1][0] - BlackRightLoc[row][0],
                               0,
                               CameraRealWidth - 1); 
        //Ԥ��ֵ���º��ˢ��һ�ζ�ջ����ջ������ʧ��
        BlackRightWinPredictStore0 = BlackRightWinPredictStore1;
        BlackRightWinPredictStore1 = BlackRightWinPredictStore2;
        BlackRightWinPredictStore2 = temp;        
      }
      //���û���������м��ڵ�ɹ���ԭ��������ԭλ�õ�Ԥ��㣬��������Ч�����ã����Ծ�����Ԥ���������ߡ�
      //����������о��ɼ�����ʧ�ܣ���������ǵ�һ��ֵ������һ��Step1
      //�����4�׶μ���־��λ���Ͳ��ý���ʮ�ּ���ˡ�
      else if(temp3 == 1)
      {
        //����һ��ͼ�ǵ��ߣ���������ʮ�֡�
        if(SingleBlackLastAllFlag == 1) break;        
        //ֱ�Ǻڿ������ڼ䣬Ϊ�˷�ֹһ��ʮ�ֳɹ���һ�߲��ɹ���ɵ���������б�����Բ�������ʮ�֡�
        if(AngleZoneConfirmLockFlag == 1) break;
        
        //��һ�μ�⵽˫��ʧ��ʱ�����ļ����߿����Ѿ���̫��ȷ��
        if(index1 == 0)
        {
          //��������3��ֵ������ͬ��Ҳ���Ǳ仯��ͬ�ţ���ô�Ͱ������������������Ϊ���һ��ֵ�Ѿ�����
          if(row <= CameraHight - 3)
          {
              if (BlackRightLoc[row + 1][0] != MaxValUint8 && BlackRightLoc[row + 2][0] != MaxValUint8)
              {
                  //������ߵ㹻����û��Ǹ���ʵ�ʵĺڵ������´���ֵ��
                  tempminus = BoundaryLimitRe(BlackRightLoc[row + 1][0] * 3 - BlackRightLoc[row + 2][0] * 2,
                                              0,
                                              CameraRealWidth - 1);
                  //б��ʮ�ֲ�����ô�ڣ���ʮ�ֵ��϶���һ�����¶��ߵ���ߡ�
                  tempminus = MinRe(tempminus, BlackRightLoc[row + 1][0]);
              }
              else
              {
                  temp001 = BlackRightWinPredictStore1 - BlackRightWinPredictStore0;
                  BlackRightWinPredictStore0 += temp001;
                  BlackRightWinPredictStore1 += temp001;
                  BlackRightWinPredictStore2 = BlackRightWinPredictStore1 + BlackRightWinPredictStore1 - BlackRightWinPredictStore0;
                  tempminus = BoundaryLimitRe(BlackRightWinPredictStore2 + BlackRightWinPredictStore2 - BlackRightWinPredictStore1,
                                              0,
                                              CameraRealWidth - 1);
              }
          }
          else
          {
              //�����ϲ����ߵ����
              return 0;
              
              /*
              //ʵ�ڲ��о͸���Store��ֵ�����°ɡ�
              //�����ϴεĴ���Ԥ��ֵΪ��׼������2�����ϴκ������ϴεĲ
              tempminus = BoundaryLimitRe(BlackRightWinPredictStore1 * 3 - BlackRightWinPredictStore0 * 2,
                                          0,
                                          CameraRealWidth - 1);
              //б��ʮ�ֲ�����ô�ڣ���ʮ�ֵ��϶���һ�����¶��ߵ���ߡ�
              tempminus = MinRe(tempminus, BlackRightLoc[row + 1][0]);
            */
          }
          
          //����һ�κ����Ҳ�������ˡ�
          index1++;          
        }
        else
        {
          //Ԥ��㰴������ҲҪ�޷���
          tempminus = BoundaryLimitRe(BlackRightWinPredictStore2 + BlackRightWinPredictStore2 - BlackRightWinPredictStore1,
                                      0,
                                      CameraRealWidth - 1);          
        }
        //temp�������ʾ����Ԥ���λ�á�
        temp = tempminus;
        BlackRightWinPredictStore0 = BlackRightWinPredictStore1;
        BlackRightWinPredictStore1 = BlackRightWinPredictStore2;
        BlackRightWinPredictStore2 = temp;        
        
        //Row1RealLastLine��¼��1�κ��ߵ����һ�С�
        if(index == 0)
        {          
          //����һ�κ󣬾���Ҳ��������ˡ�
          index++;
          for(i = row; i <= CameraHight - 1; i++)
          {
            if(BlackRightLoc[i][0] != MaxValUint8)
            {
              Row1RealLastLine = i;
              break;
            }
          }
          if(Row1RealLastLine >= CameraHight - 1)
          {
            Row1RealLastLine = CameraHight - 1;
          }
          else
          {
          }
          //��¼Ϊȫ�ֱ���
          BlackRightRow1RealLastLine = Row1RealLastLine;
        }
        
        GapCount += 2;
        if (successRow != MaxValUint8 && BlackRightLoc[successRow][0] >240 && BlackRightLoc[successRow - 1][0] >240) { }
        ///////////////////////////////����ʮ�����¼���������Ҫ���ϸ�һЩ������û��Ҫ��ʱ�䣬����˵ǰ�����ֻ�����⵽�����С�
        else if(GapCount > BlackCrossGapLine)
        {
          //�ټ��ʱ����̫Զ�ˣ���û��Ҫ����ˡ�
          if(row < BlackRightCrossTooLowLine)
          {
            //ɨƨ�ɡ�
            for(i = row; ; i--)
            {
              BlackRightLoc[i][0] = MaxValUint8;
              if(i == 0) break;
            }
            //��������
            break;
          }
          else
          {
          }
          
          //����ʮ�����¼��󣬾Ͳ�������ֵ�4�׶�����ߵ������
          if(BlackRightStep4Flag == 1)
          {
            //BlackRightStep4Flag = 3;   //����߳���
            
            //ֱ������������������̫�á�
            /*
            BlackRightCrossDone = 1;   //ʮ�ּ��ʧ�ܡ�
            //ɨƨ�ɡ�
            for(i = row; ; i--)
            {
              BlackRightLoc[i][0] = MaxValUint8;
              if(i == 0) break;
            }
            //��������
            break;
            */
          }
          else
          {
          }
          
          //ʮ���ټ��Ļ���Step1Scan����ͷ���빻����
          //���ֻʣ��0��1��û�м��Ļ����Ͳ��ÿ���ʮ���ټ���ˡ�
          if(BlackRightStep1ScanRow >= CameraHight - 3 && row > 3)
          {
            //������ʮ���ټ�⡣
            if(BlackRightAgainForCross(row - 2, 1, Row1RealLastLine, temp) == 0)
            {
              BlackRightCrossDone = 1;  //ʮ�ּ��ʧ��            
            }
            else
            {
              BlackRightCrossDone = 2;  //ʮ�ּ��ɹ�
            }
            break;  //ʮ���ټ����Ὺ����⵽ָ�������һ�У����Բ�����ѭ���ˣ�ֱ������
          }
          //��ͷ̫Զ������ֻʣ��0��1�е�ʱ��ֱ��break�ͺã�Զ�������ڳ�ʼ��ʱ�Ѿ���Ϊ��Чֵ��
          else
          {
            break;
          }
        }
        else
        {
           BlackRightCrossDone = 0;    //ʮ�ּ��δ����
        }
      
      }
      //��������ֻ��һ�߼��ɹ����������ȻҪ�����Ƹ��´���Ԥ��ֵ��
      else if((temp1 == 1 && temp2 == 0) || (temp1 == 0 && temp2 == 1)) 
      {   
        //��һ�μ�⵽�е���ʧ��ʱ�����ļ����߿����Ѿ���̫��ȷ��
        if(index1 == 0)
        {
          //��������3��ֵ������ͬ��Ҳ���Ǳ仯��ͬ�ţ���ô�Ͱ������������������Ϊ���һ��ֵ�Ѿ�����
          if(row <= CameraHight - 3)
          {
              if (BlackRightLoc[row + 1][0] != MaxValUint8 && BlackRightLoc[row + 2][0] != MaxValUint8)
              {
                  //������ߵ㹻����û��Ǹ���ʵ�ʵĺڵ������´���ֵ��
                  tempminus = BoundaryLimitRe(BlackRightLoc[row + 1][0] * 3 - BlackRightLoc[row + 2][0] * 2,
                                              0,
                                              CameraRealWidth - 1);
                  //б��ʮ�ֲ�����ô�ڣ���ʮ�ֵ��϶���һ�����¶��ߵ���ߡ�
                  tempminus = MinRe(tempminus, BlackRightLoc[row + 1][0]);
              }
              else
              {
                  temp001 = BlackRightWinPredictStore1 - BlackRightWinPredictStore0;
                  BlackRightWinPredictStore0 += temp001;
                  BlackRightWinPredictStore1 += temp001;
                  BlackRightWinPredictStore2 = BlackRightWinPredictStore1 + BlackRightWinPredictStore1 - BlackRightWinPredictStore0;
                  tempminus = BoundaryLimitRe(BlackRightWinPredictStore2 + BlackRightWinPredictStore2 - BlackRightWinPredictStore1,
                                              0,
                                              CameraRealWidth - 1);
              }
          }
          else
          {
              //�����ϲ����ߵ����
              return 0;
              
              /*
              //ʵ�ڲ��о͸���Store��ֵ�����°ɡ�
              //�����ϴεĴ���Ԥ��ֵΪ��׼������2�����ϴκ������ϴεĲ
              tempminus = BoundaryLimitRe(BlackRightWinPredictStore1 * 3 - BlackRightWinPredictStore0 * 2,
                                          0,
                                          CameraRealWidth - 1);
              //б��ʮ�ֲ�����ô�ڣ���ʮ�ֵ��϶���һ�����¶��ߵ���ߡ�
              tempminus = MinRe(tempminus, BlackRightLoc[row + 1][0]);
              */
          }
          
          //����һ�κ����Ҳ�������ˡ�
          index1++;          
        }
        else
        {
          //Ԥ��㰴������ҲҪ�޷���
          tempminus = BoundaryLimitRe(BlackRightWinPredictStore2 + BlackRightWinPredictStore2 - BlackRightWinPredictStore1,
                                      0,
                                      CameraRealWidth - 1);          
        }
        //temp�������ʾ����Ԥ���λ�á�
        temp = tempminus;
        BlackRightWinPredictStore0 = BlackRightWinPredictStore1;
        BlackRightWinPredictStore1 = BlackRightWinPredictStore2;
        BlackRightWinPredictStore2 = temp;
      }
      //�����ϲ����ߵ����
      else
      {       
      }
      
      
      if((row == 0) || (row == 1)) break;
      
    }
    
    
    //��4�׶Σ��ɼ���ʮ�ֵ�ǰ�����ǣ�����ߡ������и������㣬Ҫ�ϸ���Ƶ��á�
    if(BlackRightStep4Flag == 1)
    {
      if(BlackRightStep4BackLine(BlackRightStep4StartLine, 0) == 0)
      {
        BlackRightStep4Flag = 1;   //�����ʧ�ܣ��п����ǵ�ȡ�������п�����б�ʲ��ԡ�
        //return 0;  
      }
      else
      {
        BlackRightStep4Flag = 2;   //����߳ɹ���
      }
    }
    //BlackRightStep4Flag����������
    else if(BlackRightStep4Flag == 3)
    {
      //�������߳�������Ϊʲô
      if(BlackRightStep4ErrorCheck() == 1)
      {      
        if(BlackRightStep4BackLine(BlackRightStep4StartLine, 0) == 0)
        {
          //BlackRightStep4Flag = 1;   //�����ʧ�ܣ��п����ǵ�ȡ�������п�����б�ʲ��ԡ�
          //return 0;  
        }
        else
        {
          BlackRightStep4Flag = 2;   //����߳ɹ���
        }
      }
      else
      {
      }
    }
    //BlackRightStep4Flagδ����������
    else
    {
    }

    return 1;

}




//������ȡԤ����
uint8 BlackGetPre(void)
{
  uint8 temp1, temp2;
  
  //������ϰ����⴦���ڼ䣬���ߴӿ����߿�ʼɨ�衣
  if(BrickSpeDealFlag == 1)
  {
    //���ϰ����̶������߿�ʼɨ�衣
    if(BrickSpeDealDir == 0)
    {
      BlackGetPreDir = 1;
    }
    //���ϰ����̶������߿�ʼɨ�衣
    else
    {
      BlackGetPreDir = 0;
    }
    
    return 1;
  }
  else
  {
  }
  
  //��Ԥɨ������
  BlackGetLeftParaInit();  //������ʼ��
  temp1 = BlackGetLeftStep1Edge(CameraHight - 1, 1, 1);  //����������1��ʾ�Ǻ���Ԥ����
  temp2 = BlackGetLeftStep1Edge(CameraHight - 2, 2, 1);  //����������1��ʾ�Ǻ���Ԥ����
  if(
    (temp1 == 1)
  &&(temp2 == 1)
  &&(AbsInt(BlackLeftLoc[CameraHight - 1][0] - BlackLeftLoc[CameraHight - 2][0]) < BlackLeftStep1ScanMinus)  //�����в��̫��
    )
  {
    //���߲ɼ���ͷ�ɹ��������߿�ʼɨ�衣 
    BlackGetPreDir = 0;
    return 1;
  }
  else
  {
    //�п���һ�вɼ��ɹ�������Ҫɨβ��
    BlackLeftLoc[CameraHight - 1][0] = MaxValUint8;
    BlackLeftLoc[CameraHight - 2][0] = MaxValUint8;
  }
  
  //����ͷɨ��ʧ�ܣ���ɨ������ͷ
  BlackGetRightParaInit();  //������ʼ��
  temp1 = BlackGetRightStep1Edge(CameraHight - 1, 1, 1);  //����������1��ʾ�Ǻ���Ԥ����
  temp2 = BlackGetRightStep1Edge(CameraHight - 2, 2, 1);  //����������1��ʾ�Ǻ���Ԥ����
  if(
    (temp1 == 1)
  &&(temp2 == 1)
  &&(AbsInt(BlackRightLoc[CameraHight - 1][0] - BlackRightLoc[CameraHight - 2][0]) < BlackRightStep1ScanMinus)  //�����в��̫��
    )
  {
    //����ͷ�ɼ��ɹ��������߿�ʼɨ�衣
    BlackGetPreDir = 1;
    return 1;    
  }
  else
  {
    //�п���һ�вɼ��ɹ�������Ҫɨβ��
    BlackRightLoc[CameraHight - 1][0] = MaxValUint8;
    BlackRightLoc[CameraHight - 2][0] = MaxValUint8;    
    
    //������ͷ���ɼ�ʧ�ܣ���Ӧ����ʮ�֣���Ȼ�����߿�ʼɨ�衣
    BlackGetPreDir = 2;
    return 1;
  }
}



//���߼�����һ�����ҵ��ߴ���///////////////////////////////���ּ�ⵥ�ߴ���ķ�����ǳɫ���߰�ɫ�ذ壬Ч����ܲ
//1������û��⵽���ߴ��󣬻��⵽���ߴ��󲢳ɹ�������0�������ͼ��ֱ�ӻ��ж�Ϊʧ�ܣ�
uint8 BlackSingleSpeCheck(void)   
{
  uint8 temp1, temp2, index1;
  uint8 tempstep1row = MaxValUint8;
  int avgr1, avgr2, avgl1, avgl2;
  int i;
  
  //���߶��ɹ������ǵ��ߡ�
  if(
     (BlackLeftDone == 1)
   &&(BlackRightDone == 1)
     )
  {
    //����������գ�ע�ⲻҪ��ʮ�����С�
    if(
       (BlackRightStep1ScanRow == CameraHight - 1 && BlackLeftStep1ScanRow < CameraHight - 1) //����β��Զ������β����С� 
     &&(BlackRightLoc[BlackRightStep1ScanRow][0] != MaxValUint8 && BlackLeftLoc[BlackLeftStep1ScanRow][0] != MaxValUint8) //û�б��������˵� 
     &&(BlackRightLoc[BlackRightStep1ScanRow-1][0] != MaxValUint8 && BlackLeftLoc[BlackLeftStep1ScanRow-1][0] != MaxValUint8) //û�б��������˵� 
     &&(BlackRightLoc[BlackRightStep1ScanRow-2][0] != MaxValUint8 && BlackLeftLoc[BlackLeftStep1ScanRow-2][0] != MaxValUint8) //û�б��������˵�   
       )
    {
      //1. ������ߵ����һ�����߿�����ǲ��������ߡ�      
      if(
        (BlackLeftLoc[BlackLeftStep1ScanRow-1][0] > SingleBlackWidthMax[BlackLeftStep1ScanRow-1] * 1)
      &&(BlackLeftLoc[BlackLeftStep1ScanRow-2][0] > SingleBlackWidthMax[BlackLeftStep1ScanRow-2] * 1) //����ͷ����̫��������Ҫ����1�����߿�ȡ� 
      &&(BlackLeftLoc[BlackLeftStep1ScanRow-1][0] < CameraRealWidth / 2 + 60)  
      &&(BlackLeftLoc[BlackLeftStep1ScanRow-2][0] < CameraRealWidth / 2 + 60)  //���߲���̫���ң�����Ҫ���������ڡ�
        )
      {
        //��һ�����߿�ȵĴ�������ǲ��������ߡ�temp1��temp2Ϊ�Һ��ߵİ׵�λ�á�
        temp1 = BlackGetRightJustWin(BlackLeftStep1ScanRow-1, 
                                     BlackLeftLoc[BlackLeftStep1ScanRow-1][0] - SingleBlackWidthMax[BlackLeftStep1ScanRow-1], //��������15�У�����20��Ӧ�ù���
                                     BlackLeftLoc[BlackLeftStep1ScanRow-1][0]);
        temp2 = BlackGetRightJustWin(BlackLeftStep1ScanRow-2, 
                                     BlackLeftLoc[BlackLeftStep1ScanRow-2][0] - SingleBlackWidthMax[BlackLeftStep1ScanRow-2], //��������15�У�����20��Ӧ�ù���
                                     BlackLeftLoc[BlackLeftStep1ScanRow-2][0]);
        //���������������Һ��ߡ����������ڵ������в������̫�� 
        if(temp1 != MaxValUint8 && temp2 != MaxValUint8 && AbsInt(temp1 - temp2) < 8)
        {          
          //��һ�����ߵİ׵�ƽ��ֵ
          avgr1 = (ImgNew[BlackLeftStep1ScanRow-1][temp1 - 1]
                 + ImgNew[BlackLeftStep1ScanRow-1][temp1 - 2]
                 + ImgNew[BlackLeftStep1ScanRow-1][temp1 - 3]
                 + ImgNew[BlackLeftStep1ScanRow-1][temp1 - 4]
                 + ImgNew[BlackLeftStep1ScanRow-1][temp1 - 5])
                 / 5;
          //��һ�����ߵİ׵�ƽ��ֵ
          avgl1 = (ImgNew[BlackLeftStep1ScanRow-1][BlackLeftLoc[BlackLeftStep1ScanRow-1][0] + 1 + BlackLeftEdgeNum + 1]
                 + ImgNew[BlackLeftStep1ScanRow-1][BlackLeftLoc[BlackLeftStep1ScanRow-1][0] + 1 + BlackLeftEdgeNum + 2]
                 + ImgNew[BlackLeftStep1ScanRow-1][BlackLeftLoc[BlackLeftStep1ScanRow-1][0] + 1 + BlackLeftEdgeNum + 3]
                 + ImgNew[BlackLeftStep1ScanRow-1][BlackLeftLoc[BlackLeftStep1ScanRow-1][0] + 1 + BlackLeftEdgeNum + 4]
                 + ImgNew[BlackLeftStep1ScanRow-1][BlackLeftLoc[BlackLeftStep1ScanRow-1][0] + 1 + BlackLeftEdgeNum + 5])
                 / 5;          
          //�ڶ������ߵİ׵�ƽ��ֵ
          avgr2 = (ImgNew[BlackLeftStep1ScanRow-2][temp2 - 1]
                 + ImgNew[BlackLeftStep1ScanRow-2][temp2 - 2]
                 + ImgNew[BlackLeftStep1ScanRow-2][temp2 - 3]
                 + ImgNew[BlackLeftStep1ScanRow-2][temp2 - 4]
                 + ImgNew[BlackLeftStep1ScanRow-2][temp2 - 5])
                 / 5;
          //�ڶ������ߵİ׵�ƽ��ֵ
          avgl2 = (ImgNew[BlackLeftStep1ScanRow-2][BlackLeftLoc[BlackLeftStep1ScanRow-2][0] + 1 + BlackLeftEdgeNum + 1]
                 + ImgNew[BlackLeftStep1ScanRow-2][BlackLeftLoc[BlackLeftStep1ScanRow-2][0] + 1 + BlackLeftEdgeNum + 2]
                 + ImgNew[BlackLeftStep1ScanRow-2][BlackLeftLoc[BlackLeftStep1ScanRow-2][0] + 1 + BlackLeftEdgeNum + 3]
                 + ImgNew[BlackLeftStep1ScanRow-2][BlackLeftLoc[BlackLeftStep1ScanRow-2][0] + 1 + BlackLeftEdgeNum + 4]
                 + ImgNew[BlackLeftStep1ScanRow-2][BlackLeftLoc[BlackLeftStep1ScanRow-2][0] + 1 + BlackLeftEdgeNum + 5])
                 / 5;          
          
          //���һ����ȷ�����ߵİ�ɫ���ƽ��ֵ���ǳ�С��  /////////////////////��ʱ���ذ�Ϊǳɫ���߰�ɫ���͹��ˡ�
          if(AbsInt(avgr1 - avgl1) < 15 && AbsInt(avgr2 - avgl2) < 15)
          {
            BlackSingleFlag = 1;        //���ߴ����־��λ��
            BlackSingleDir = 0;         //��ʾ���������յ������
          }
          else
          {
          }
        }
        else
        {
        }
      }
      else
      {
      }
      
      //�鿴���ߴ����־
      if(BlackSingleFlag == 1)
      {
        //ȷ���ǵ��ߴ�����Ȱ��Һ���ȫ����Чֵ��
        for(i = 0; ; i++)
        {
          BlackRightLoc[i][0] = MaxValUint8;           
          if(i == CameraHight - 1) break;
        }
        
        index1 = 0;
        //Ȼ�������β�����п�ʼ����ɨ���ߣ�һֱ������ͷ�����л�����δ�ɵ����С�
        for(i = BlackLeftStep1ScanRow; ; i--)
        {
          temp1 = BlackGetRightJustWin(i, 
                                       BlackLeftLoc[i][0] - SingleBlackWidthMax[i], //��������15�У�����20��Ӧ�ù���
                                       BlackLeftLoc[i][0]);            
          if(temp1 != MaxValUint8)
          {
            //����ɨ���Һ��߳ɹ�
            BlackRightLoc[i][0] = temp1 + 1 + BlackRightEdgeNum;
            //��¼�Һ���ɨ��ɹ�������С�
            if(index1 == 0)
            {
              tempstep1row = i;
              index1++;
            }
            else
            {
            }
          }
          else
          {
            //һ��û�вɵ�����Զ���оͲ�Ҫ�ˣ�ֱ���˳���
            break;
          }
          //������ͷ�ˣ��˳�
          if(i == BlackLeftHeadLine) break;
        }
        
        //��ⲻ����Ч�Һ��ߣ�����ʧ�ܡ�
        if(tempstep1row == MaxValUint8) return 0;
        
        //��Զ���п�ʼ������ߡ���2�����������1��
        //��������֮���������Ƿ�ɹ�����Ҫ��Զ�������������һ��
        if(BlackLeftStep4BackLine(BlackLeftStep1ScanRow - 2, 1) == 1 && BlackRightStep4BackLine(tempstep1row - 2, 1) == 1)
        {
        }
        else
        {
          //�������û�гɹ����п����ǵ�̫�٣����Ǿ�ֱ�ӷ���ʧ�ܣ����ͼ��ֱ���ж�Ϊʧ�ܡ�
          return 0;
        }           
        
        //�õ��߱�־λSingleBlackAllFlag(����CenterLineGet)��     
        //SingleBlackAllFlag = 1;     
        
      }
      //���ߴ����־û����λ���������κδ���
      else
      {
      }
        
    }
    //����������գ�ע�ⲻҪ��ʮ�����С�
    else if(
       (BlackLeftStep1ScanRow == CameraHight - 1 && BlackRightStep1ScanRow < CameraHight - 1) //����β��Զ������β����С� 
     &&(BlackRightLoc[BlackRightStep1ScanRow][0] != MaxValUint8 && BlackLeftLoc[BlackLeftStep1ScanRow][0] != MaxValUint8) //û�б��������˵� 
     &&(BlackRightLoc[BlackRightStep1ScanRow-1][0] != MaxValUint8 && BlackLeftLoc[BlackLeftStep1ScanRow-1][0] != MaxValUint8) //û�б��������˵� 
     &&(BlackRightLoc[BlackRightStep1ScanRow-2][0] != MaxValUint8 && BlackLeftLoc[BlackLeftStep1ScanRow-2][0] != MaxValUint8) //û�б��������˵�   
       )
    {
      //1. ������ߵ��ұ�һ�����߿�����ǲ��������ߡ�      
      if(
        (BlackRightLoc[BlackRightStep1ScanRow-1][0] < CameraRealWidth - 1 - SingleBlackWidthMax[BlackRightStep1ScanRow-1] * 1)
      &&(BlackRightLoc[BlackRightStep1ScanRow-2][0] < CameraRealWidth - 1 - SingleBlackWidthMax[BlackRightStep1ScanRow-2] * 1) //����ͷ����̫���ң�����Ҫ����1�����߿�ȡ� 
      &&(BlackRightLoc[BlackRightStep1ScanRow-1][0] > CameraRealWidth / 2 - 60)  
      &&(BlackRightLoc[BlackRightStep1ScanRow-2][0] > CameraRealWidth / 2 - 60)  //���߲���̫���󣬴���Ҫ���Ұ�����ڡ�
        )
      {
        //��һ�����߿�ȵĴ�������ǲ��������ߡ�temp1��temp2Ϊ����ߵİ׵�λ�á�
        temp1 = BlackGetLeftJustWin(BlackRightStep1ScanRow-1, 
                                     BlackRightLoc[BlackRightStep1ScanRow-1][0], //��������15�У�����20��Ӧ�ù���
                                     BlackRightLoc[BlackRightStep1ScanRow-1][0] + SingleBlackWidthMax[BlackRightStep1ScanRow-1]);
        temp2 = BlackGetLeftJustWin(BlackRightStep1ScanRow-2, 
                                     BlackRightLoc[BlackRightStep1ScanRow-2][0], //��������15�У�����20��Ӧ�ù���
                                     BlackRightLoc[BlackRightStep1ScanRow-2][0] + SingleBlackWidthMax[BlackRightStep1ScanRow-2]);
        //������������������ߡ����������ڵ������в������̫�� 
        if(temp1 != MaxValUint8 && temp2 != MaxValUint8 && AbsInt(temp1 - temp2) < 8)
        {          
          //��һ�����ߵİ׵�ƽ��ֵ
          avgr1 = (ImgNew[BlackRightStep1ScanRow-1][temp1 + 1]
                 + ImgNew[BlackRightStep1ScanRow-1][temp1 + 2]
                 + ImgNew[BlackRightStep1ScanRow-1][temp1 + 3]
                 + ImgNew[BlackRightStep1ScanRow-1][temp1 + 4]
                 + ImgNew[BlackRightStep1ScanRow-1][temp1 + 5])
                 / 5;
          //��һ�����ߵİ׵�ƽ��ֵ
          avgl1 = (ImgNew[BlackRightStep1ScanRow-1][BlackRightLoc[BlackRightStep1ScanRow-1][0] - 1 - BlackRightEdgeNum - 1]
                 + ImgNew[BlackRightStep1ScanRow-1][BlackRightLoc[BlackRightStep1ScanRow-1][0] - 1 - BlackRightEdgeNum - 2]
                 + ImgNew[BlackRightStep1ScanRow-1][BlackRightLoc[BlackRightStep1ScanRow-1][0] - 1 - BlackRightEdgeNum - 3]
                 + ImgNew[BlackRightStep1ScanRow-1][BlackRightLoc[BlackRightStep1ScanRow-1][0] - 1 - BlackRightEdgeNum - 4]
                 + ImgNew[BlackRightStep1ScanRow-1][BlackRightLoc[BlackRightStep1ScanRow-1][0] - 1 - BlackRightEdgeNum - 5])
                 / 5;
          //�ڶ������ߵİ׵�ƽ��ֵ
          avgr2 = (ImgNew[BlackRightStep1ScanRow-2][temp2 + 1]
                 + ImgNew[BlackRightStep1ScanRow-2][temp2 + 2]
                 + ImgNew[BlackRightStep1ScanRow-2][temp2 + 3]
                 + ImgNew[BlackRightStep1ScanRow-2][temp2 + 4]
                 + ImgNew[BlackRightStep1ScanRow-2][temp2 + 5])
                 / 5;
          //�ڶ������ߵİ׵�ƽ��ֵ
          avgl2 = (ImgNew[BlackRightStep1ScanRow-2][BlackRightLoc[BlackRightStep1ScanRow-2][0] - 1 - BlackRightEdgeNum - 1]
                 + ImgNew[BlackRightStep1ScanRow-2][BlackRightLoc[BlackRightStep1ScanRow-2][0] - 1 - BlackRightEdgeNum - 2]
                 + ImgNew[BlackRightStep1ScanRow-2][BlackRightLoc[BlackRightStep1ScanRow-2][0] - 1 - BlackRightEdgeNum - 3]
                 + ImgNew[BlackRightStep1ScanRow-2][BlackRightLoc[BlackRightStep1ScanRow-2][0] - 1 - BlackRightEdgeNum - 4]
                 + ImgNew[BlackRightStep1ScanRow-2][BlackRightLoc[BlackRightStep1ScanRow-2][0] - 1 - BlackRightEdgeNum - 5])
                 / 5;      
          
          //���һ����ȷ�����ߵİ�ɫ���ƽ��ֵ���ǳ�С��  /////////////////////��ʱ���ذ�Ϊǳɫ���߰�ɫ���͹��ˡ�
          if(AbsInt(avgr1 - avgl1) < 15 && AbsInt(avgr2 - avgl2) < 15)
          {
            BlackSingleFlag = 1;        //���ߴ����־��λ��
            BlackSingleDir = 1;         //��ʾ���������յ������
          }
          else
          {
          }
        }
        else
        {
        }
      }
      else
      {
      }
      
      //�鿴���ߴ����־
      if(BlackSingleFlag == 1)
      {
        //ȷ���ǵ��ߴ�����Ȱ������ȫ����Чֵ��
        for(i = 0; ; i++)
        {
          BlackLeftLoc[i][0] = MaxValUint8;           
          if(i == CameraHight - 1) break;
        }
        
        index1 = 0;
        //Ȼ�������β�����п�ʼ����ɨ���ߣ�һֱ������ͷ�����л�����δ�ɵ����С�
        for(i = BlackRightStep1ScanRow; ; i--)
        {
          temp1 = BlackGetLeftJustWin(i, 
                                      BlackRightLoc[i][0], //��������15�У�����20��Ӧ�ù���
                                      BlackRightLoc[i][0] + SingleBlackWidthMax[i]);            
          if(temp1 != MaxValUint8)
          {
            //����ɨ������߳ɹ�
            BlackLeftLoc[i][0] = temp1 - 1 - BlackLeftEdgeNum;
            //��¼�����ɨ��ɹ�������С�
            if(index1 == 0)
            {
              tempstep1row = i;
              index1++;
            }
            else
            {
            }
          }
          else
          {
            //һ��û�вɵ�����Զ���оͲ�Ҫ�ˣ�ֱ���˳���
            break;
          }
          //������ͷ�ˣ��˳�
          if(i == BlackRightHeadLine) break;
        }
        
        //��ⲻ����Ч����ߣ�����ʧ�ܡ�
        if(tempstep1row == MaxValUint8) return 0;
         
        //��Զ���п�ʼ������ߡ���2�����������1��
        //��������֮���������Ƿ�ɹ�����Ҫ��Զ�������������һ��
        if(BlackRightStep4BackLine(BlackRightStep1ScanRow - 2, 1) == 1 && BlackLeftStep4BackLine(tempstep1row - 2, 1) == 1)
        {
        }
        else
        {
          //�������û�гɹ����п����ǵ�̫�٣����Ǿ�ֱ�ӷ���ʧ�ܣ����ͼ��ֱ���ж�Ϊʧ�ܡ�
          return 0;
        }           
        
        //�õ��߱�־λSingleBlackAllFlag(����CenterLineGet)��     
        //SingleBlackAllFlag = 1;
        
      }
      //���ߴ����־û����λ���������κδ���
      else
      {
      }
    }
    else
    {
    }
  }
  else
  {
  }
  
  return 1;
}
 



//���������ռ�⣬�����������ֱ�Ǻڿ�б�롣
//����1��ʾ��⵽�����䣬0��ʾû�м�⵽��û��Ҫ��⡣ 
//��FLASH��д�����Ŀ��ؿ��ƣ�������ֱ���������ֱ�Ǻڿ����û��б���������Ǿ͹ص���
//ֱ�Ǻڿ�����
//1. 5Slope���飬ͬ�ţ�����ͬΪ���ţ�����ͬΪ���ţ����������ڵ���2500��
//   ��ֱ�Ǻڿ�ȽϽ���ʱ��һ�����3000�����ϣ�����ñȽ�Զ��ʱ���п������2500��
//2. ��5SlopeRow����������ҵ���Ӧ���У��Ӹ��У�����˵�ǵ�13�У�������ð�13��14��15��16��17����ɾ����
uint8 BlackBigChangeFinalCheck(void)
{
  //BlackLeft5Slope[]�����BlackLeft5SlopeRow[]������±�Ϊ0~BlackLeft5SlopeIndex-1
  //��ͨ��BigChange�У��������ֵ��BlackLeftBigChangeSlopeLimit=4000���ң����Ǿ���ֵ֮���������֮���
  uint8 i, row;
  uint8 tempend1, tempend2;
  
  return 0;         //����Ҫ�������ˣ����Թر�
  
  //1. Ҫ�����߶��ɹ�
  if(BlackLeftDone == 1 && BlackRightDone == 1)
  {
  }
  else
  {
    return 0;
  }
  
  //2. Ҫ����ͷ���붼������С�
  //���߿�ʼɨ��ʱ
  if(BlackGetPreDir == 0 || BlackGetPreDir == 2)
  {
    if(BlackLeftStep1ScanRow == CameraHight - 1 && BlackRightStep1ScanRow >= CameraHight - 5)
    {
    }
    else
    {
      //��ͷ̫�ߣ����ü����������
      return 0;
    }
  }
  //���߿�ʼɨ��ʱ
  else
  {
    if(BlackRightStep1ScanRow == CameraHight - 1 && BlackLeftStep1ScanRow >= CameraHight - 5)
    {
    }
    else
    {
      //��ͷ̫�ߣ����ü����������
      return 0;
    }    
  }
  
  //����
  //���߳���ֱ�Ǻڿ�Ĵ����䣬����һ�������ϵ����¡�б��һ���Ǹ��ġ�
  if(SlopeL < 0 && BlackLeftEndLine - BlackLeftHeadLine - 5 > 0 && BlackLeft5SlopeIndex - 2 > 0)
  {
    //5Slope�����п����Ѿ�ɾ����һЩ�ڵ㣬����ҲҪ�ο�ʵ�ʵ���Ч�ڵ�����
    tempend1 = MinRe(BlackLeftEndLine - BlackLeftHeadLine - 5, BlackLeft5SlopeIndex - 2);
    //��ѯ5Slope����
    for(i = 0; ; i++)
    {
      //���ߵ�ֱ�Ǻڿ����ж��Ǹ��š�
      if(
        (BlackLeft5Slope[i] < 0)
      &&(BlackLeft5Slope[i+1] < 0)
      &&(BlackLeft5Slope[i] - BlackLeft5Slope[i+1] >= BlackBigChangeFinalCheckSlopeLimit)     //i+1��iС2500���ϡ�������">"
        )
      {
        //��⵽ֱ�Ǻڿ�����䣬������
        break;
      }
      else
      {      
      }
      
      //���������һ����������
      if(i == tempend1) break;
    }
    
    //��⵽ֱ�Ǻڿ�����䡣
    if(i != tempend1)
    {
      //Ҫɾ��4�У�����Ҫ��4�С�
      if(i > 4)
      {
        row = BlackLeft5SlopeRow[i+1] + 3;
        //ʮ�ּ��δ�����ʧ��ʱ������Ҫ������մ�����ġ�
        //��ʮ�ּ��ɹ�����row�ڵ�1�κ�����ʵ�����е�Զ��ʱ������Ҫ��⣬��ֹ��ʮ�ֲ��ߴ�����б��ͻ�䡣
        if(BlackLeftCrossDone == 2 && row < BlackLeftRow1RealLastLine)
        {
          //���ز���Ҫ���
          return 0;
        }
        else
        {
        }
        
        //ɾ���ӵ���4�п�ʼ����Զ���������С�
        for(; ; row--)
        {
          BlackLeftLoc[row][0] = MaxValUint8;
          
          if(row == 0) break;
        }
  
        //�ñ�־λ���������մ����䡣
        BlackBigChangeFinalCheckFlag = 1;
        //����1���ɹ���
        return 1;
      }
      else
      {     
      }
    }
    //û��⵽ֱ�Ǻڿ�����䣬�����κδ���
    else
    {    
    }
  }
  else
  {
  }
  
  //����
  //���߳���ֱ�Ǻڿ�Ĵ����䣬����һ�������ϵ����¡�б��һ�������ġ�
  if(SlopeR > 0 && BlackRightEndLine - BlackRightHeadLine - 5 > 0 && BlackRight5SlopeIndex - 2 > 0)
  {
    //5Slope�����п����Ѿ�ɾ����һЩ�ڵ㣬����ҲҪ�ο�ʵ�ʵ���Ч�ڵ�����
    tempend2 = MinRe(BlackRightEndLine - BlackRightHeadLine - 5, BlackRight5SlopeIndex - 2);
    //��ѯ5Slope����
    for(i = 0; ; i++)
    {
      //���ߵ�ֱ�Ǻڿ����ж������š�
      if(
        (BlackRight5Slope[i] > 0)
      &&(BlackRight5Slope[i+1] > 0)
      &&(BlackRight5Slope[i+1] - BlackRight5Slope[i] >= BlackBigChangeFinalCheckSlopeLimit)     //i+1��i��2500���ϡ�������">"
        )
      {
        //��⵽ֱ�Ǻڿ�����䣬������
        break;
      }
      else
      {      
      }
      
      //���������һ����������
      if(i == tempend2) break;
    }
    
    //��⵽ֱ�Ǻڿ�����䡣
    if(i != tempend2)
    {
      //Ҫɾ��4�У�����Ҫ��4�С�
      if(i > 4)
      {        
        row = BlackRight5SlopeRow[i+1] + 3;
        //ʮ�ּ��δ�����ʧ��ʱ������Ҫ������մ�����ġ�
        //��ʮ�ּ��ɹ�����row�ڵ�1�κ�����ʵ�����е�Զ��ʱ������Ҫ��⣬��ֹ��ʮ�ֲ��ߴ�����б��ͻ�䡣
        if(BlackRightCrossDone == 2 && row < BlackRightRow1RealLastLine)
        {
          //���ز���Ҫ���
          return 0;
        }
        else
        {
        }
        
        //ɾ���ӵ���4�п�ʼ����Զ���������С�
        for(; ; row--)
        {
          BlackRightLoc[row][0] = MaxValUint8;
          
          if(row == 0) break;
        }
        
        //�ñ�־λ���������մ����䡣
        BlackBigChangeFinalCheckFlag = 2;
        //����1���ɹ���      
        return 1;
      }
      else
      {     
      }
    }
    //û��⵽ֱ�Ǻڿ�����䣬�����κδ���
    else
    {    
    }  
  }
  else
  {
  }
  
  //��̬Ϊ0����û��⵽��û��Ҫ���
  return 0;
}


////б��ֱ�Ǻڿ�
////����1��ʾ��⵽��0��ʾû�м�⵽��
//uint8 BlackAngleZoneSpeCheck(void)
//{
//  uint8 temp1, temp2, i;
//  
//  //�ȼ���ұ���û��б���ֱ�Ǻڿ顣
//  //1. �������
//  if(
//    (BlackLeftDone == 1 && BlackRightDone == 1)
//  &&(SlopeL + 3000 < 0)
//  &&(SlopeR > 0)
//  &&(CURVEL > 0)
//  &&(CURVER < 0)
//  &&(BlackGetPreDir == 0)
//  &&(BlackLeftStep1ScanRow == CameraHight - 1)
//  &&(AbsInt(BlackLeftHeadLine - BlackRightHeadLine) < 5)
//    )
//  {
//    //2. ����ͷ֮ǰ��5Slope��Ϊ��
//    //����
//    //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
//    if(BlackLeftEndLine - BlackLeftHeadLine - 4 < 0 || BlackLeft5SlopeIndex - 1 < 0)
//    {
//      return 0;
//    }
//    else
//    {        
//    }
//    temp1 = MinRe(BlackLeftEndLine - BlackLeftHeadLine - 4, BlackLeft5SlopeIndex - 1);
//    
//    //����ж�С5��б���Ƿ���������
//    for(i = 0; ; i++)
//    {
//      if(BlackLeft5Slope[i] > 0) //һ�������ģ����Ϸ���ʧ�ܡ�
//      {
//        return 0;
//      }
//
//      if(i == temp1) break;
//    }
//    //3. ����ͷ֮ǰ��5Slope��Ϊ��
//    //����
//    //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
//    if(BlackRightEndLine - BlackRightHeadLine - 4 < 0 || BlackRight5SlopeIndex - 1 < 0)
//    {
//      return 0;
//    }
//    else
//    {        
//    }
//    temp2 = MinRe(BlackRightEndLine - BlackRightHeadLine - 4, BlackRight5SlopeIndex - 1);
//    
//    //����ж�С5��б���Ƿ���������
//    for(i = 0; ; i++)
//    {
//      if(BlackRight5Slope[i] < 0) //һ���и��ģ����Ϸ���ʧ�ܡ�
//      {
//        return 0;
//      }
//
//      if(i == temp2) break;
//    }
//    //4. �������еĿ�Ⱥ�С��
//    temp1 = MinRe(BlackLeftEndLine, BlackRightEndLine);   //β
//    temp2 = MaxRe(BlackLeftHeadLine, BlackRightHeadLine); //ͷ
//    if(temp1 < temp2) 
//    {
//      return 0;
//    }
//    else
//    {
//      for(i = temp1; ; i--)
//      {
//        if(BlackRightLoc[i][0] - BlackLeftLoc[i][0] < 80) break;
//        
//        if(i == temp2) break;
//      }
//      
//      //ȷ�ϴ��ڿ�Ⱥ�С����
//      if(i != temp2)
//      {
//        BlackAngleZoneSpeCheckFlag = 1; //��־λ
//        BlackAngleZoneSpeCheckDir = 1;  //�ұ������������
//        return 1;
//      }
//      else
//      {
//      }
//    }
//  }
//  //�ұ�û��б��ĺڿ飬���ż�������û��б��ĺڿ顣
//  else
//  {
//  }
//  
//
//  //�ȼ�������û��б���ֱ�Ǻڿ顣
//  //1. �������
//  if(
//    (BlackLeftDone == 1 && BlackRightDone == 1)
//  &&(SlopeL < 0)
//  &&(SlopeR > 3000)
//  &&(CURVEL > 0)
//  &&(CURVER < 0)
//  &&(BlackRightStep1ScanRow >= CameraHight - 5)
//  &&(AbsInt(BlackLeftHeadLine - BlackRightHeadLine) < 5)
//    )
//  {
//    //2. ����ͷ֮ǰ��5Slope��Ϊ��
//    //����
//    //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
//    if(BlackLeftEndLine - BlackLeftHeadLine - 4 < 0 || BlackLeft5SlopeIndex - 1 < 0)
//    {
//      return 0;
//    }
//    else
//    {        
//    }
//    temp1 = MinRe(BlackLeftEndLine - BlackLeftHeadLine - 4, BlackLeft5SlopeIndex - 1);
//    
//    //����ж�С5��б���Ƿ���������
//    for(i = 0; ; i++)
//    {
//      if(BlackLeft5Slope[i] > 0) //һ�������ģ����Ϸ���ʧ�ܡ�
//      {
//        return 0;
//      }
//
//      if(i == temp1) break;
//    }
//    //3. ����ͷ֮ǰ��5Slope��Ϊ��
//    //����
//    //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
//    if(BlackRightEndLine - BlackRightHeadLine - 4 < 0 || BlackRight5SlopeIndex - 1 < 0)
//    {
//      return 0;
//    }
//    else
//    {        
//    }
//    temp2 = MinRe(BlackRightEndLine - BlackRightHeadLine - 4, BlackRight5SlopeIndex - 1);
//    
//    //����ж�С5��б���Ƿ���������
//    for(i = 0; ; i++)
//    {
//      if(BlackRight5Slope[i] < 0) //һ���и��ģ����Ϸ���ʧ�ܡ�
//      {
//        return 0;
//      }
//
//      if(i == temp2) break;
//    }
//    //4. �������еĿ�Ⱥ�С��
//    temp1 = MinRe(BlackLeftEndLine, BlackRightEndLine);   //β
//    temp2 = MaxRe(BlackLeftHeadLine, BlackRightHeadLine); //ͷ
//    if(temp1 < temp2) 
//    {
//      return 0;
//    }
//    else
//    {
//      for(i = temp1; ; i--)
//      {
//        if(BlackRightLoc[i][0] - BlackLeftLoc[i][0] < 80) break;
//        
//        if(i == temp2) break;
//      }
//      
//      //ȷ�ϴ��ڿ�Ⱥ�С����
//      if(i != temp2)
//      {
//        BlackAngleZoneSpeCheckFlag = 1; //��־λ
//        BlackAngleZoneSpeCheckDir = 0;  //��������������
//        return 1;
//      }
//      else
//      {
//      }
//    }
//  }
//  //�ұ�û��б��ĺڿ飬���ż�������û��б��ĺڿ顣
//  else
//  {
//  }
//  
//  
//  //��̬Ϊû��⵽��
//  return 0;
//}



//======================================================================
//��������BlackGet
//��  �ܣ�������ȡ����
//��  ������
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺����������Һ����㷨
//˵  ����1. ѧ���ĺ�����ȡ�㷨�кܶ�������������ԶԲ�ͬ�����µĺ��߽�����ȡ������Ч��
//        2. ���Һ��߷ֿ���ȡ�����Һ�����ȡ����ʼ�����������ȡ�Ľ��Ϊ׼��ǰ�����������ȡ�ɹ�����
//        3. Ϊ�˷�ֹ���ߵ�ͻ�䣬���Һ��߸���2�λ��ᣬ��2�λ��Ὣ���3���ؼ�ֵ����ԭʼֵ����һ�Ρ�
//           ������ǹ��ߵ�ԭ��3���ؼ�ֵ��������
//======================================================================
uint8 BlackGet(void)
{
    uint8 i;
    uint8 tempBlackAngleZoneSpeCheck;       //б��ֱ�Ǻڿ鴢��λ
    uint8 tempBlackBigChangeFinalCheck; //���մ������ⴢ��λ��
    uint8 tempBlackSingleSpeCheck;      //���ߴ����ⴢ��λ��
    //uint8 tempLWB, tempLW, tempLB;
    //uint8 tempRWB, tempRW, tempRB;

    //������ȡԤ����������ɨ��������
    BlackGetPre();    
    
    //Ԥ��������ͷ�ɹ���������ͷ��ʧ��ʱ�������߿�ʼɨ�衣
    if(BlackGetPreDir == 0 || BlackGetPreDir == 2)
    {
      //�������ȡ���ɹ��򷵻�1��ʧ���򷵻�0.
      if(BlackGetLeft() == 0)
      {
        BlackLeftDone = 0;                  //�������ȡʧ��
        BlackLeftHeadLine = MaxValUint8;    //����ͷ����Чֵ��
        BlackLeftEndLine = MaxValUint8;    //����β����Чֵ��
      }
      else
      {
        //�Ƚ�������������Բ���
        BlackLeftContinueAdd();
        //�ٽ����������ͷ��β����
        BlackLeftHeadEndSearch();
  
      }    
      
      //�Һ�����ȡ���ɹ��򷵻�1��ʧ���򷵻�0.
      //��������ϰ����⴦�����Һ��ߺ�������ִ�У�ֱ����Ϊʧ�ܡ�
      if(
        (BrickSpeDealFlag == 1 && BrickSpeDealDir == 1)
      ||(BlackGetRight() == 0)
        )
      {
        BlackRightDone = 0;                  //�Һ�����ȡʧ��
        BlackRightHeadLine = MaxValUint8;    //����ͷ����Чֵ��      
      }
      else
      {
        //�Ƚ����Һ��������Բ���
        BlackRightContinueAdd();
        //�ٽ����Һ�����ͷ��β����
        BlackRightHeadEndSearch();
      }
    }
    //����ͷ�ɹ��������߿�ʼɨ�衣
    else
    {
      //�Һ�����ȡ���ɹ��򷵻�1��ʧ���򷵻�0.
      if(BlackGetRight() == 0)
      {
        BlackRightDone = 0;                  //�Һ�����ȡʧ��
        BlackRightHeadLine = MaxValUint8;    //����ͷ����Чֵ��      
      }
      else
      {
        //�Ƚ����Һ��������Բ���
        BlackRightContinueAdd();
        //�ٽ����Һ�����ͷ��β����
        BlackRightHeadEndSearch();
      }
      
      //�������ȡ���ɹ��򷵻�1��ʧ���򷵻�0.
      //��������ϰ����⴦��������ߺ�������ִ�У�ֱ����Ϊʧ�ܡ�
      if(
        (BrickSpeDealFlag == 1 && BrickSpeDealDir == 0)
      ||(BlackGetLeft() == 0)
        )
      {
        BlackLeftDone = 0;                  //�������ȡʧ��
        BlackLeftHeadLine = MaxValUint8;    //����ͷ����Чֵ��
        BlackLeftEndLine = MaxValUint8;    //����β����Чֵ��
      }
      else
      {
        //�Ƚ�������������Բ���
        BlackLeftContinueAdd();
        //�ٽ����������ͷ��β����
        BlackLeftHeadEndSearch();
  
      }
    }
     
    //���Һ��߾���ȡʧ�ܣ��������ȡʧ�ܡ�
    if((BlackLeftDone == 0) && (BlackRightDone == 0))
    {
      return 0;
    }
    else
    {
      //���Һ��߻������
      BlackUdis();
      
      //ֻҪ��һ�߳ɹ��Ϳ��Խ�����
      //���ڻ���Ҫ�õ�б�ʣ�������ǰ���㡣
      //���ʡ�б����ȡ�ı�־λ��1�ɹ���0ʧ�ܡ�
      CurveSlopeFlagL = 1;
      CurveSlopeFlagR = 1;
      //����ߵ����ʡ�б�ʵ���ȡ��  
      if(CurveSlopeGetLeft() == 0)
      {
        CurveSlopeFlagL = 0;
        //uart_sendN(UART0, (uint8 *)"\nCurveSlopeGetLeft() Failed!", 28);
      }
      else
      {
      }
      
      //�Һ��ߵ����ʡ�б�ʵ���ȡ��  
      if(CurveSlopeGetRight() == 0)
      {
        CurveSlopeFlagR = 0;
        //uart_sendN(UART0, (uint8 *)"\nCurveSlopeGetRight() Failed!", 29);
      }
      else
      {
      }
      
      //������ȡ�ɹ�������������
      if(BlackLeftDone == 1)
      {
        //����������⡣
        if(BlackLeftRollCheck() == 0)
        {
          BlackLeftRollCheckFlag = 1;         //��⵽���䡣
          BlackLeftDone = 0;                  //�������ȡʧ��
          //�������ֵ��
          for(i = BlackLeftEndLine; ; i--)
          {
            BlackLeftLoc[i][0] = MaxValUint8;
            if(i == BlackLeftHeadLine) break;
          }
          BlackLeftHeadLine = MaxValUint8;    //����ͷ����Чֵ��
          BlackLeftEndLine = MaxValUint8;     //����β����Чֵ��
        }
        else
        {
        }
      }
      //������ȡʧ�ܾͲ��ý������������
      else
      {
      }
      
      //������ȡ�ɹ�������һ�����
      if(BlackRightDone == 1)
      {
        //�һ��������⡣
        if(BlackRightRollCheck() == 0)
        {
          BlackRightRollCheckFlag = 1;         //��⵽���䡣
          BlackRightDone = 0;                  //�Һ�����ȡʧ��
          //�������ֵ��
          for(i = BlackRightEndLine; ; i--)
          {
            BlackRightLoc[i][0] = MaxValUint8;
            if(i == BlackRightHeadLine) break;
          }
          BlackRightHeadLine = MaxValUint8;    //����ͷ����Чֵ��
          BlackRightEndLine = MaxValUint8;     //����β����Чֵ��
        }
        else
        {
        }
      }
      //������ȡʧ�ܾͲ��ý����һ�������
      else
      {
      }
      
    }
    
    //���������������������������ƽ׶Σ����ý��д��������ռ�� �� ���ߴ�����
    if(AngleConfirmLockFlag == 1 || AngleSpeDealFlag == 1 || BrickConfirmLockFlag == 1 || BrickSpeDealFlag == 1)
    {
    }
    else
    {
      //б��ֱ�Ǻڿ���
      tempBlackAngleZoneSpeCheck = 0;
//      if(BlackAngleZoneSpeCheckSwitch == 1)
//      {
//        //1��ʾ��⵽б��ֱ�Ǻڿ飬0��ʾû�м�⵽��
//        tempBlackAngleZoneSpeCheck = BlackAngleZoneSpeCheck();
//      }
//      else
//      {
//      }

      //���������ռ��.
      tempBlackBigChangeFinalCheck = 0;
      if(tempBlackAngleZoneSpeCheck == 0 && BlackBigChangeFinalCheckSwitch == 1)
      {
        //1��ʾ��⵽��0��ʾû��⵽��
        tempBlackBigChangeFinalCheck = BlackBigChangeFinalCheck();
        //��������ɹ�����������ͷ��β����������������������ߵ�б�ʡ����ʣ�
        if(tempBlackBigChangeFinalCheck == 1)
        {
          //�������ͷ��β����
          BlackLeftHeadEndSearch();
          //�Һ�����ͷ��β����
          BlackRightHeadEndSearch();
          
          //���Һ��߻������
          BlackUdis();
          
          //ֻҪ��һ�߳ɹ��Ϳ��Խ�����
          //���ڻ���Ҫ�õ�б�ʣ�������ǰ���㡣
          //���ʡ�б����ȡ�ı�־λ��1�ɹ���0ʧ�ܡ�
          CurveSlopeFlagL = 1;
          CurveSlopeFlagR = 1;
          //����ߵ����ʡ�б�ʵ���ȡ��  
          if(CurveSlopeGetLeft() == 0)
          {
            CurveSlopeFlagL = 0;
            //uart_sendN(UART0, (uint8 *)"\nCurveSlopeGetLeft() Failed!", 28);
          }
          else
          {
          }
          
          //�Һ��ߵ����ʡ�б�ʵ���ȡ��  
          if(CurveSlopeGetRight() == 0)
          {
            CurveSlopeFlagR = 0;
            //uart_sendN(UART0, (uint8 *)"\nCurveSlopeGetRight() Failed!", 29);
          }
          else
          {
          }          
        }
        else
        {
        }
      }
      else
      {        
      }
      
      if(tempBlackAngleZoneSpeCheck == 1 || tempBlackBigChangeFinalCheck == 1)
      {
        //ǰ���б��ֱ�Ǻڿ��������Ѿ����ɹ��ˣ��Ͳ��ü�ⵥ�ߴ���������Ե������ȫ��ͬ���ؼ�������ͷ��β�����������б���ʼ�����ò�Ҫ�ظ����˷�ʱ�䡣
      }
      /*
      else
      {
        //���߼�����һ�����ҵ��ߴ���
        //���ߴ���Ƚϲ�������ˣ����ͼ��ֱ���ж�Ϊ��ͼ��   
        tempBlackSingleSpeCheck = BlackSingleSpeCheck();
        if(tempBlackSingleSpeCheck == 0)
        {
          BlackLeftDone = 0;
          BlackLeftHeadLine = MaxValUint8;
          BlackLeftEndLine = MaxValUint8;
          BlackRightDone = 0;
          BlackRightHeadLine = MaxValUint8;
          BlackRightEndLine = MaxValUint8;          
          
          return 0;
        }
        else
        {
          //��⵽�˵��ߴ�����������ͷ��β����������������������ߵ�б�ʡ����ʣ�
          if(BlackSingleFlag == 1)
          {
            //�������ͷ��β����
            BlackLeftHeadEndSearch();
            //�Һ�����ͷ��β����
            BlackRightHeadEndSearch();
            
            //���Һ��߻������
            BlackUdis();
            
            //ֻҪ��һ�߳ɹ��Ϳ��Խ�����
            //���ڻ���Ҫ�õ�б�ʣ�������ǰ���㡣
            //���ʡ�б����ȡ�ı�־λ��1�ɹ���0ʧ�ܡ�
            CurveSlopeFlagL = 1;
            CurveSlopeFlagR = 1;
            //����ߵ����ʡ�б�ʵ���ȡ��  
            if(CurveSlopeGetLeft() == 0)
            {
              CurveSlopeFlagL = 0;
              //uart_sendN(UART0, (uint8 *)"\nCurveSlopeGetLeft() Failed!", 28);
            }
            else
            {
            }
            
            //�Һ��ߵ����ʡ�б�ʵ���ȡ��  
            if(CurveSlopeGetRight() == 0)
            {
              CurveSlopeFlagR = 0;
              //uart_sendN(UART0, (uint8 *)"\nCurveSlopeGetRight() Failed!", 29);
            }
            else
            {
            }
          }
          //û�м�⵽���ߴ��󣬲���������
          else
          {
          }
        }
      }*/          
    }

    
    return 1;
}


//��Ե��ߴ�������������´���
uint8 CenterLineGetSingleWrongAdd(void)
{
  uint8 row, i;
  uint8 temp;
  uint8 flag1, flag2;
  uint8 tempflag1;
  uint8 tempway1;
  uint8 x[CenterForwardLineNum];   //��������ǰ���߼���б��ʱ��x���꣬��ʾ�ڼ��С���
  int16 y[CenterForwardLineNum];   //��������ǰ���߼���б��ʱ��y���꣬��ʾ������λ�á�
  int32 a1, a0;    //��������ǰ����ʱ����С���˷���б�ʺ��ݽؾࡣ
  
  float slope;
  
  //��������������³�ʼ��
  for(i = 0; ; i++)
  {
    CenterLineLoc[i] = MaxValInt16;
    if(i == CameraHight - 1) break;
  }
  
  //�������գ�������Ч��
  if(RoadHalfWidthWrongDir == 0)
  {
    //�����ߵ���ͷ��β��Ч����ֱ�ӷ���ʧ�ܡ�
    if(BlackRightHeadLine == MaxValUint8 || BlackRightEndLine == MaxValUint8)
    {
      return 0;
    }
    else
    {
    }
       
    flag1 = 1;
    flag2 = 1;
    
    //�����ߵ���βȡ���ߵ���β���ɡ�
    CenterHeadLine = BlackRightHeadLine;   //��ͷȡ���ߵ���ͷ��ע���ⲻ��ʵ�ʵ���ͷ��
    //CenterHeadLine = 0;                    //��ͷ��ΪҪ�̶�������0�У�����ֱ����0.
    CenterEndLine = BlackRightEndLine;
    
    //���ȿ���ͷ�Ƿ����BlackControlLineLow��
    if(BlackRightHeadLine >= BlackControlLineLow)
    {
      flag1 = 0;     
    }
    else
    {
    }
    
    //����βС��CameraHight - 1�С�
    if(BlackRightEndLine < CameraHight - 1)
    {
      //ֻ�����߳ɹ�����������β����ôԶ������û��������ֱ�ӷ���ʧ�ܡ�
      //if(BlackRightEndLine < CameraHight - 1 - BlackRightBackLineStart)
      if(BlackRightEndLine <= BlackControlLineLow)  
      {
        flag2 = 0;
        return 0;
      }
      //����β��һ����Χ�ڡ���������ѵ�59����ǰ�Ƽ��С�ֱ��ȡBlackRightEndLine��
      else
      {
      }
    }
    //����β����CameraHight - 1��ֱ��ȡBlackRightEndLine
    else
    {
    }
    
    //��ʧ��һ���ߵ�ʱ���ȸ���б�ʹ���������û����һ��˫��ͼ��ʱ������������ֱ������һ��˫�ߵ��������
    //��5�е�б�ʡ�
    if(BlackRightEndLine - BlackRightHeadLine > 5)
    {
      slope = 1.0 * (BlackUdisRightLocation[BlackRightEndLine].x - BlackUdisRightLocation[BlackRightEndLine-4].x) / 
                    (BlackUdisRightLocation[BlackRightEndLine].y - BlackUdisRightLocation[BlackRightEndLine-4].y);
    }
    else
    {
      slope = 0;
    }
    //�������
    temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
    //ȡ���ֵ
    RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
    
    tempflag1 = 0;
    tempway1 = 0;
    //����������ȹ��Ƴ������ߵ���ͷ��
    CenterLineLoc[BlackRightEndLine] = BlackUdisRightLocation[BlackRightEndLine].x - RoadHalfWidth;
    //�������ߵ����ƹ��Ƴ������ߡ��������Ǹ�int16�;�����������
    for(row = BlackRightEndLine - 1; ;row--)
    {
      //������Чʱ���������ߵ����Ʋ��ߡ�
      if(BlackRightLoc[row][0] != MaxValUint8)
      {
        tempflag1 = 0;
        CenterLineLoc[row] = CenterLineLoc[row+1] + BlackUdisRightLocation[row].x - BlackUdisRightLocation[row+1].x;
      }
      //������Чʱ������������е����������Ʋ��ߡ�
      else
      {
          //��������Чʱ�����Բ�������������Ʋ��ߣ�Ҳ���Ը������CenterForwardLineNum����С���˷����Ʋ��ߡ�
          if(tempflag1 == 0)
          {
            //ÿ��ͼֻ����һ�Σ�����ȷ�����߷�ʽ���Ժ�Ͳ����ٽ����ˡ�
            tempflag1 = 1;
            //������������࣬���Բ�����С���˷��ķ�ʽ��
            if(row + CenterForwardLineNum <= CameraHight - 1)
            {
              tempway1 = 0;
              //������С���˷�ϵ���ļ��㡣
              for(i = 0; i < CenterForwardLineNum; i++)
              {
                x[i] = row + i + 1;
                y[i] = CenterLineLoc[row + i + 1];
              }
              a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
              a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣
            }
            //����е����������࣬��������������Ʋ��ߵķ�ʽ��
            else
            {
              tempway1 = 1;
            }
          }
          else
          {
          }
        
          //ȷ�ϲ��߷�ʽ�󣬿�ʼ���ߡ�
          if(tempway1 == 0)
          {
            //��С���˷��ķ�ʽ��
            CenterLineLoc[row] = (a0 + a1 * row) / LeastSquareMulti;
          }
          else
          {
            //���2�С�
            if(row == CameraHight - 1 || row == CameraHight - 2)
            {
              CenterLineLoc[row] = BlackUdisRightLocation[row].x - RoadHalfWidth;
            }
            //�������2�С�
            else
            {
              //������еķ�ʽ��
              CenterLineLoc[row] = CenterLineLoc[row+1] + CenterLineLoc[row+1] - CenterLineLoc[row+2];
            }
          }
        }
      
        if(row == 0) break;
      }
    
      
    
    //��δ������е�����������Чֵ��
    //�ײ�����Чֵ���������ô���
    if(CenterEndLine != CameraHight - 1)
    {
      for(row = CameraHight - 1; ; row--)
      {
        if(row == CenterEndLine) break;       
        CenterLineLoc[row] = MaxValInt16;
      }
    }
    else
    {
    }
  }
  //�������գ�������Ч��
  else
  {
    //�����ߵ���ͷ��β��Ч����ֱ�ӷ���ʧ�ܡ�
    if(BlackLeftHeadLine == MaxValUint8 || BlackLeftEndLine == MaxValUint8)
    {
      return 0;
    }
    else
    {
    }
    
    flag1 = 1;
    flag2 = 1;
    
    //�����ߵ���βȡ���ߵ���β���ɡ�
    CenterHeadLine = BlackLeftHeadLine;     //��ͷȡ���ߵ���ͷ��ע���ⲻ��ʵ�ʵ���ͷ��
    //CenterHeadLine = 0;   //��ͷ��ΪҪ�̶�������0�У�����ֱ����0.
    CenterEndLine = BlackLeftEndLine;
    
    //���ȿ���ͷ�Ƿ����BlackControlLineLow��
    if(BlackLeftHeadLine >= BlackControlLineLow)
    {
      flag1 = 0;
    }
    else
    {
    }
    
    //����βС��CameraHight - 1�С�
    if(BlackLeftEndLine < CameraHight - 1)
    {
      //ֻ�����߳ɹ�����������β����ôԶ������û��������ֱ�ӷ���ʧ�ܡ�
      //if(BlackLeftEndLine < CameraHight - 1 - BlackLeftBackLineStart)
      if(BlackLeftEndLine <= BlackControlLineLow)
      {
        flag2 = 0;
        return 0;       
      }
      //����β��һ����Χ�ڡ���������ѵ�59����ǰ�Ƽ��С�ֱ��ȡBlackLeftEndLine��
      else
      {
      }
    }
    //����β����CameraHight - 1��ֱ��ȡBlackLeftEndLine
    else
    {
    }
    
    //��ʧ��һ���ߵ�ʱ���ȸ���б�ʹ���������û����һ��˫��ͼ��ʱ������������ֱ������һ��˫�ߵ��������
    //��5�е�б�ʡ�
    if(BlackLeftEndLine - BlackLeftHeadLine > 5)
    {
      slope = 1.0 * (BlackUdisLeftLocation[BlackLeftEndLine].x - BlackUdisLeftLocation[BlackLeftEndLine-4].x) / 
                    (BlackUdisLeftLocation[BlackLeftEndLine].y - BlackUdisLeftLocation[BlackLeftEndLine-4].y);
    }
    else
    {
      slope = 0;
    }
    //�������
    temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
    //ȡ���ֵ
    RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
    
    //����������ȹ��Ƴ������ߵ���ͷ��
    CenterLineLoc[BlackLeftEndLine] = BlackUdisLeftLocation[BlackLeftEndLine].x + RoadHalfWidth;
    
    tempflag1 = 0;
    tempway1 = 0;
    //�������ߵ����ƹ��Ƴ������ߡ��������Ǹ�int16�;�����������
    for(row = BlackLeftEndLine - 1; ;row--)
    {
      //������Чʱ���������ߵ����Ʋ��ߡ�
      if(BlackLeftLoc[row][0] != MaxValUint8)
      {
        tempflag1 = 0;
        CenterLineLoc[row] = CenterLineLoc[row+1] + BlackUdisLeftLocation[row].x - BlackUdisLeftLocation[row+1].x;
      }
      //������Чʱ������������е����������Ʋ��ߡ�
      else
      {
        //��������Чʱ�����Բ�������������Ʋ��ߣ�Ҳ���Ը������CenterForwardLineNum����С���˷����Ʋ��ߡ�
        if(tempflag1 == 0)
        {
          //ÿ��ͼֻ����һ�Σ�����ȷ�����߷�ʽ���Ժ�Ͳ����ٽ����ˡ�
          tempflag1 = 1;
          //������������࣬���Բ�����С���˷��ķ�ʽ��
          if(row + CenterForwardLineNum <= CameraHight - 1)
          {
            tempway1 = 0;
            //������С���˷�ϵ���ļ��㡣
            for(i = 0; i < CenterForwardLineNum; i++)
            {
              x[i] = row + i + 1;
              y[i] = CenterLineLoc[row + i + 1];
            }
            a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
            a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣
          }
          //����е����������࣬��������������Ʋ��ߵķ�ʽ��
          else
          {
            tempway1 = 1;
          }
        }
        else
        {
        }
        
        //ȷ�ϲ��߷�ʽ�󣬿�ʼ���ߡ�
        if(tempway1 == 0)
        {
          //��С���˷��ķ�ʽ��
          CenterLineLoc[row] = (a0 + a1 * row) / LeastSquareMulti;
        }
        else
        {
          //��������2�С�
          if(row == CameraHight -1  || row == CameraHight - 2)
          {
            CenterLineLoc[row] = BlackUdisLeftLocation[row].x + RoadHalfWidth;
          }
          //�������2�С�
          else
          {
            //������еķ�ʽ��
            CenterLineLoc[row] = CenterLineLoc[row+1] + CenterLineLoc[row+1] - CenterLineLoc[row+2];            
          }
        }
      }
      
      //һֱ��������С�
      if(row == 0) break;
    }
    
    //��δ������е�����������Чֵ��
    //�ײ�����Чֵ���������ô���
    if(CenterEndLine != CameraHight - 1)
    {
      for(row = CameraHight - 1; ; row--)
      {
        if(row == CenterEndLine) break;       
        CenterLineLoc[row] = MaxValInt16;
      }
    }
    else
    {
    }
  }
  
  return 1;
}



//��������������������ȡ����
//��������ȡ������ǰ���Һ��߾�������
//����ԭʼ�����Һ��ߣ���ʹ�ý���������Һ��ߡ�
uint8 CenterLineGetNormal(void)
{
    int black_row, i, j;
            uint8 temp;
            uint8 flag1, //����ͷ��־��Զ����
                flag2, //����β��־��������
                flag3, //����ͷ��־
                flag4;  //����β��־
            uint8 tempflag1=1;
            uint8 tempway1=1;
            uint8 x[CenterForwardLineNum];   //��������ǰ���߼���б��ʱ��x���꣬��ʾ�ڼ��С���
            int16 y[CenterForwardLineNum];   //��������ǰ���߼���б��ʱ��y���꣬��ʾ������λ�á�
            int32 a1 = 0, a0 = 0;    //��������ǰ����ʱ����С���˷���б�ʺ��ݽؾࡣ
            uint8 index;
            uint8 a[BlackBackLineNum];   //ȡ���ٸ�����һ��ʼ�ж��塣
            uint8 b[BlackBackLineNum];


            float slope;


            //������ȡ�ɹ���������ȡʧ�ܡ�
            if (BlackLeftDone == 1 && BlackRightDone == 0)
            {
                //�����ߵ���ͷ��β��Ч����ֱ�ӷ���ʧ�ܡ�
                if (BlackLeftHeadLine == MaxValUint8 || BlackLeftEndLine == MaxValUint8)
                {
                    return 0;
                }
                else
                {
                }

                flag1 = 1;
                flag2 = 1;

                //�����ߵ���βȡ���ߵ���β���ɡ�
                CenterHeadLine = BlackLeftHeadLine;   //��ͷȡ���ߵ���ͷ��ע���ⲻ��ʵ�ʵ���ͷ��
                                                       //CenterHeadLine = 0;                    //��ͷ��ΪҪ�̶�������0�У�����ֱ����0.
                CenterEndLine = BlackLeftEndLine;

                //���ȿ���ͷ�Ƿ����BlackControlLineLow��
                if (BlackLeftHeadLine >= 55)
                {
                    flag1 = 0;
                }
                else
                {
                }

                //����βС��CameraHight - 1�С�
                if (BlackLeftEndLine < CameraHight - 1)
                {
                    //ֻ�����߳ɹ�����������β����ôԶ������û��������ֱ�ӷ���ʧ�ܡ�
                    //if(BlackRightEndLine < CameraHight - 1 - BlackRightBackLineStart)
                    if (BlackLeftEndLine <= 5)
                    {
                        flag2 = 0;
                        return 0;
                    }
                    //����β��һ����Χ�ڡ���������ѵ�59����ǰ�Ƽ��С�ֱ��ȡBlackRightEndLine��
                    else
                    {
                    }
                }
                //����β����CameraHight - 1��ֱ��ȡBlackRightEndLine
                else
                {
                }

                //��ʧ��һ���ߵ�ʱ���ȸ���б�ʹ���������û����һ��˫��ͼ��ʱ������������ֱ������һ��˫�ߵ��������
                //��5�е�б�ʡ�
                for (black_row = BlackLeftHeadLine; ; black_row++)
                {
                    if (BlackLeftEndLine - BlackLeftHeadLine > 5)
                    {
                        if (BlackLeftLoc[black_row][ 0] != MaxValUint8)
                        {
                            slope = 1.0 * (BlackUdisLeftLocation[black_row + 4].x - BlackUdisLeftLocation[black_row].x) /
                                  (BlackUdisLeftLocation[black_row + 4].y - BlackUdisLeftLocation[black_row].y);
                            /* else
                             {
                               slope = 0;
                             }*/
                            //�������
                            temp = CenterLineHalfWidth[black_row];// (int)(1.0 * Math.Sqrt(slope * slope + 1) * CenterLineHalfWidth[black_row] / 2);
                            //ȡ���ֵ

                            RoadHalfWidth = temp;// MaxRe(temp, RoadHalfWidth);

                            tempflag1 = 0;
                            tempway1 = 0;
                            buXianCount = 0;
                            //����������ȹ��Ƴ������ߵ���ͷ��
                            CenterLineLoc[black_row] = BlackLeftLoc[black_row][ 0] + RoadHalfWidth;
                        }
                        //�������ߵ����ƹ��Ƴ������ߡ��������Ǹ�int16�;�����������

                        // CenterLineLoc[black_row] = CenterLineLoc[black_row + 1] + BlackRightLoc[black_row, 0] - BlackRightLoc[black_row + 1, 0];
                        //������Чʱ������������е����������Ʋ��ߡ�
                        else
                        {
                            //��������Чʱ�����Բ�������������Ʋ��ߣ�Ҳ���Ը������CenterForwardLineNum����С���˷����Ʋ��ߡ�
                            if (tempflag1 == 0)
                            {
                                //ÿ��ͼֻ����һ�Σ�����ȷ�����߷�ʽ���Ժ�Ͳ����ٽ����ˡ�
                                tempflag1 = 1;
                                //������������࣬���Բ�����С���˷��ķ�ʽ��
                                //���һ�л����о������ã���Ϊ�п����ǹյ㡣��Ҳ����̫����ȡ��б�ʾͲ����ˡ�
                                if (black_row + CenterForwardLineNum + 2 <= CameraHight - 1)
                                {
                                    tempway1 = 0;
                                    //������С���˷�ϵ���ļ��㡣
                                    for (i = 0; i < CenterForwardLineNum; i++)
                                    {
                                        x[i] = black_row - i - 3;
                                        y[i] = CenterLineLoc[black_row - i - 3];
                                    }
                                    a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
                                    a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣            
                                }
                                else if (black_row + CenterForwardLineNum + 1 <= CameraHight - 1)
                                {
                                    tempway1 = 0;
                                    //������С���˷�ϵ���ļ��㡣
                                    for (i = 0; i < CenterForwardLineNum; i++)
                                    {
                                        x[i] = black_row - i - 2;
                                        y[i] = CenterLineLoc[black_row - i - 2];
                                    }
                                    a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
                                    a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣                        
                                }
                                else if (black_row + CenterForwardLineNum <= CameraHight - 1)
                                {
                                    tempway1 = 0;
                                    //������С���˷�ϵ���ļ��㡣
                                    for (i = 0; i < CenterForwardLineNum; i++)
                                    {
                                        x[i] = black_row - i - 1;
                                        y[i] = CenterLineLoc[black_row - i - 1];
                                    }
                                    a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
                                    a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣
                                }
                                //����е����������࣬��������������Ʋ��ߵķ�ʽ��
                                else
                                {
                                    tempway1 = 1;
                                }
                            }
                            else
                            {
                            }

                            //ȷ�ϲ��߷�ʽ�󣬿�ʼ���ߡ�
                            if (tempway1 == 0)
                            {
                                //��С���˷��ķ�ʽ��
                                CenterLineLoc[black_row] = (a0 + a1 * black_row) / LeastSquareMulti;
                            }
                            else
                            {
                                /*//���2�С�
                                if(black_row == CameraHight - 1 || black_row == CameraHight - 2)
                                {
                                  CenterLineLoc[black_row] = BlackRightLoc[black_row,0] - RoadHalfWidth;
                                }
                                //�������2�С�
                                else
                                {
                                  //������еķ�ʽ��
                                  CenterLineLoc[black_row] = CenterLineLoc[black_row+1] + CenterLineLoc[black_row+1] - CenterLineLoc[black_row+2];
                                }
                                */
                            }
                        }
                    }
                    else
                    {
                        tempflag1 = 1;
                        tempway1 = 1;
                        temp = CenterLineHalfWidth[black_row];// (int)(1.0 * CenterLineHalfWidth[black_row] / 2);
                        RoadHalfWidth = temp;// MaxRe(temp, RoadHalfWidth);
                        CenterLineLoc[black_row] = BlackLeftLoc[black_row][ 0] + RoadHalfWidth;

                    }
                    if (CenterLineLoc[black_row] >= MaxValUint8)
                        CenterLineLoc[black_row] = MaxValUint8;
                    else if (CenterLineLoc[black_row] <= 0)
                        CenterLineLoc[black_row] = 0;
                    else
                    {
                    }
                    if (black_row >= 59) break;
                }



            }
            //������ȡ�ɹ���������ȡʧ�ܡ�
            else if (BlackLeftDone == 0 && BlackRightDone == 1)
            {
                //�����ߵ���ͷ��β��Ч����ֱ�ӷ���ʧ�ܡ�
                if (BlackRightHeadLine == MaxValUint8 || BlackRightEndLine == MaxValUint8)
                {
                    return 0;
                }
                else
                {
                }

                flag1 = 1;
                flag2 = 1;

                //�����ߵ���βȡ���ߵ���β���ɡ�
                CenterHeadLine = BlackRightHeadLine;   //��ͷȡ���ߵ���ͷ��ע���ⲻ��ʵ�ʵ���ͷ��
                                                       //CenterHeadLine = 0;                    //��ͷ��ΪҪ�̶�������0�У�����ֱ����0.
                CenterEndLine = BlackRightEndLine;

                //���ȿ���ͷ�Ƿ����BlackControlLineLow��
                if (BlackRightHeadLine >= 55)
                {
                    flag1 = 0;
                }
                else
                {
                }

                //����βС��CameraHight - 1�С�
                if (BlackRightEndLine < CameraHight - 1)
                {
                    //ֻ�����߳ɹ�����������β����ôԶ������û��������ֱ�ӷ���ʧ�ܡ�
                    //if(BlackRightEndLine < CameraHight - 1 - BlackRightBackLineStart)
                    if (BlackRightEndLine <= 5)
                    {
                        flag2 = 0;
                        return 0;
                    }
                    //����β��һ����Χ�ڡ���������ѵ�59����ǰ�Ƽ��С�ֱ��ȡBlackRightEndLine��
                    else
                    {
                    }
                }
                //����β����CameraHight - 1��ֱ��ȡBlackRightEndLine
                else
                {
                }

                //��ʧ��һ���ߵ�ʱ���ȸ���б�ʹ���������û����һ��˫��ͼ��ʱ������������ֱ������һ��˫�ߵ��������
                //��5�е�б�ʡ�
                for (black_row = BlackRightHeadLine; ; black_row++)
                {
                    if (BlackRightEndLine - BlackRightHeadLine > 5)
                    {
                        if (BlackRightLoc[black_row][ 0] != MaxValUint8)
                        {
                            slope = 1.0 * (BlackUdisRightLocation[black_row + 4].x - BlackUdisRightLocation[black_row].x) /
                                  (BlackUdisRightLocation[black_row + 4].y - BlackUdisRightLocation[black_row].y);
                            /* else
                             {
                               slope = 0;
                             }*/
                            //�������
                            temp = CenterLineHalfWidth[black_row];// (int)(1.0 * Math.Sqrt(slope * slope + 1) * CenterLineHalfWidth[black_row] / 2);
                            //ȡ���ֵ

                            RoadHalfWidth = temp;// MaxRe(temp, RoadHalfWidth);

                            tempflag1 = 0;
                            tempway1 = 0;
                            buXianCount = 0;
                            //����������ȹ��Ƴ������ߵ���ͷ��
                            CenterLineLoc[black_row] = BlackRightLoc[black_row][ 0] - RoadHalfWidth;
                        }
                        //�������ߵ����ƹ��Ƴ������ߡ��������Ǹ�int16�;�����������

                        // CenterLineLoc[black_row] = CenterLineLoc[black_row + 1] + BlackRightLoc[black_row, 0] - BlackRightLoc[black_row + 1, 0];
                        //������Чʱ������������е����������Ʋ��ߡ�
                        else
                        {
                            //��������Чʱ�����Բ�������������Ʋ��ߣ�Ҳ���Ը������CenterForwardLineNum����С���˷����Ʋ��ߡ�
                            if (tempflag1 == 0)
                            {
                                //ÿ��ͼֻ����һ�Σ�����ȷ�����߷�ʽ���Ժ�Ͳ����ٽ����ˡ�
                                tempflag1 = 1;
                                //������������࣬���Բ�����С���˷��ķ�ʽ��
                                //���һ�л����о������ã���Ϊ�п����ǹյ㡣��Ҳ����̫����ȡ��б�ʾͲ����ˡ�
                                if (black_row + CenterForwardLineNum + 2 <= CameraHight - 1)
                                {
                                    tempway1 = 0;
                                    //������С���˷�ϵ���ļ��㡣
                                    for (i = 0; i < CenterForwardLineNum; i++)
                                    {
                                        x[i] = black_row - i - 3;
                                        y[i] = CenterLineLoc[black_row - i - 3];
                                    }
                                    a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
                                    a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣            
                                }
                                else if (black_row + CenterForwardLineNum + 1 <= CameraHight - 1)
                                {
                                    tempway1 = 0;
                                    //������С���˷�ϵ���ļ��㡣
                                    for (i = 0; i < CenterForwardLineNum; i++)
                                    {
                                        x[i] = black_row - i - 2;
                                        y[i] = CenterLineLoc[black_row - i - 2];
                                    }
                                    a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
                                    a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣                        
                                }
                                else if (black_row + CenterForwardLineNum <= CameraHight - 1)
                                {
                                    tempway1 = 0;
                                    //������С���˷�ϵ���ļ��㡣
                                    for (i = 0; i < CenterForwardLineNum; i++)
                                    {
                                        x[i] = black_row - i - 1;
                                        y[i] = CenterLineLoc[black_row - i - 1];
                                    }
                                    a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
                                    a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣
                                }
                                //����е����������࣬��������������Ʋ��ߵķ�ʽ��
                                else
                                {
                                    tempway1 = 1;
                                }
                            }
                            else
                            {
                            }

                            //ȷ�ϲ��߷�ʽ�󣬿�ʼ���ߡ�
                            if (tempway1 == 0)
                            {
                                //��С���˷��ķ�ʽ��
                                CenterLineLoc[black_row] = (a0 + a1 * black_row) / LeastSquareMulti;
                            }
                            else
                            {
                                /*//���2�С�
                                if(black_row == CameraHight - 1 || black_row == CameraHight - 2)
                                {
                                  CenterLineLoc[black_row] = BlackRightLoc[black_row,0] - RoadHalfWidth;
                                }
                                //�������2�С�
                                else
                                {
                                  //������еķ�ʽ��
                                  CenterLineLoc[black_row] = CenterLineLoc[black_row+1] + CenterLineLoc[black_row+1] - CenterLineLoc[black_row+2];
                                }
                                */
                            }
                        }
                    }
                    else
                    {
                        tempflag1 = 1;
                        tempway1 = 1;
                        temp = CenterLineHalfWidth[black_row];// (int)(1.0 * CenterLineHalfWidth[black_row] / 2);
                        RoadHalfWidth = temp;// MaxRe(temp, RoadHalfWidth);
                        CenterLineLoc[black_row] = BlackRightLoc[black_row][ 0] - RoadHalfWidth;

                    }
                    if (CenterLineLoc[black_row] >= MaxValUint8)
                        CenterLineLoc[black_row] = MaxValUint8;
                    else if (CenterLineLoc[black_row] <= 0)
                        CenterLineLoc[black_row] = 0;
                    else
                    {
                    }
                    if (black_row >= 59) break;
                }


            }



            //��δ������е�����������Чֵ��
            //�ײ�����Чֵ���������ô���
            /* if(CenterEndLine != CameraHight - 1)
             {
               for(black_row = CameraHight - 1; ; black_row--)
               {
                 if(black_row == CenterEndLine) break;       
                 CenterLineLoc[black_row] = MaxValInt16;
               }
             }
             else
             {
             }*/

       

  //�����߾���ȡ�ɹ���
 else if(BlackLeftDone == 1 && BlackRightDone == 1)
  {
    CenterHeadLine = MinRe(BlackLeftHeadLine, BlackRightHeadLine);    //��ͷȡ���߽�С�ߡ�     
    //CenterHeadLine = 0;    //��Ϊ�̶�Ҫ������0�У����Թ̶�ȡ0.
    //��βȡ���߽ϴ��ߡ�
    CenterEndLine = MinRe(BlackLeftEndLine, BlackRightEndLine);             
    
    //���ǵ��ߵ������
    if(SingleBlackAllFlag == 0)
    {
    
      //�����߾���ȡ�ɹ�����ѡ�������ߵ������ߣ�ʵ�ڲ����ٸ���������ȹ��ơ�
      //������������Ԥ�⣬��Ϊ��������������Ѿ��������߲��ɶ�ֵ�ˣ����Բ�����ô�鷳��    
      
      //�ȼ�����ߣ����߲����������ټ�����ߡ����߲������ٷ���ʧ�ܡ�
      flag1 = 1;
      flag2 = 1;
      flag3 = 1;
      flag4 = 1;
      //ȡ�������ߵĵ�39����59�еĲȡ���ֵ��
      //���ȿ���ͷ�Ƿ����39�У�����39�о�ֱ�ӷ���ʧ�ܡ�
      if(BlackLeftHeadLine >= 55)
      {
        flag1 = 0;
      }
      else
      {
      }
      //����βС��CameraHight - 1�С�
      if(BlackLeftEndLine < CameraHight - 1)
      {
        //ֻ�����߳ɹ�����������β����ôԶ������û���������������ǲ���һ���������
        //if(BlackLeftEndLine < CameraHight - 1 - BlackLeftBackLineStart)
        if(BlackLeftEndLine <= CameraHight - BlackStep1Size - 1)
        {
          flag2 = 0;
        }
        //����β��һ����Χ�ڡ���������ѵ�59����ǰ�Ƽ��С�ֱ��ȡBlackLeftEndLine��
        else
        {
        }
      }
      //����β����CameraHight - 1��ֱ��ȡBlackLeftEndLine
      else
      {
      }
  
      //�������ߣ����߲�������������ֱ�ӷ���ʧ�ܡ�
      //���ȿ���ͷ�Ƿ����39�У�����39�о�ֱ�ӷ���ʧ�ܡ�
      if(BlackRightHeadLine >= 55)
      {
        flag3 = 0;
      }
      else
      {
      }    
      //����βС��CameraHight - 1�С�
      if(BlackRightEndLine < CameraHight - 1)
      {
        //ֻ�����߳ɹ�����������β����ôԶ������û��������ֱ�ӷ���ʧ�ܡ�
        //if(BlackRightEndLine < CameraHight - 1 - BlackRightBackLineStart)
        if(BlackRightEndLine <= CameraHight - BlackStep1Size - 1)
        {
          flag4 = 0;
          //���ζ���β��Զ��ֱ�ӷ���ʧ�ܡ�
          if(flag2 == 0) 
          {
            return 0;
          }
          else
          {
          }
        }
        //����β��һ����Χ�ڡ���������ѵ�59����ǰ�Ƽ��С�ֱ��ȡBlackRightEndLine��
        else
        {
        }
      }
      //����β����CameraHight - 1��ֱ��ȡBlackRightEndLine
      else
      {
      }
      
      //ֻ����������Ҫ����ֱ��ȡ���ߵ��в�ֵ����ֵ��
      if(
        (flag3 == 1 && flag4 == 1)
      &&((flag1 == 0 && flag2 == 0) || (flag1 == 1 && flag2 == 0) || (flag1 == 0 && flag2 == 1))
        )
      {
        //б�ʵķ�ʽ������������
        //��5�е�б�ʡ�
        if(BlackRightEndLine - BlackRightHeadLine > 5)
        {
          slope = 1.0 * (BlackUdisRightLocation[BlackRightEndLine].x - BlackUdisRightLocation[BlackRightEndLine-4].x) / 
                    (BlackUdisRightLocation[BlackRightEndLine].y - BlackUdisRightLocation[BlackRightEndLine-4].y);
        }
        else
        {
          slope = 0;
        }
        //�������
        temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
        RoadHalfWidthCompen = RoadHalfWidth / temp;
        if(RoadHalfWidthSwitch == 1)
        {
          RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
        }
        else
        {
        }
      }
      //ֻ����������Ҫ����ֱ��ȡ���ߵ��в�ֵ����ֵ��
      else if(
             (flag1 == 1 && flag2 == 1)
           &&((flag3 == 0 && flag4 == 0) || (flag3 == 1 && flag4 == 0) || (flag3 == 0 && flag4 == 1))
             )
      {
        //б�ʵķ�ʽ������������
        //��5�е�б�ʡ�
        if(BlackLeftEndLine - BlackLeftHeadLine > 5)
        {
          slope = 1.0 * (BlackUdisLeftLocation[BlackLeftEndLine].x- BlackUdisLeftLocation[BlackLeftEndLine-4].x) / 
                    (BlackUdisLeftLocation[BlackLeftEndLine].y - BlackUdisLeftLocation[BlackLeftEndLine-4].y);
        }
        else
        {
          slope = 0;
        }
        //�������
        temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
        RoadHalfWidthCompen = RoadHalfWidth / temp;
        if(RoadHalfWidthSwitch == 1)
        {
          RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
        }
        else
        {
        }
      }
      //�����߾�������������ȡ�в�ֵ����ֵ�ϴ�ġ�
      else if(flag1 == 1 && flag2 == 1 && flag3 == 1 && flag4 == 1)
      {
        //б�ʵķ�ʽ������������
        //��5�е�б�ʡ�
        if(BlackLeftEndLine - BlackLeftHeadLine > 5)
        {
          slope = 1.0 * (BlackUdisLeftLocation[BlackLeftEndLine].x - BlackUdisLeftLocation[BlackLeftEndLine-4].x) / 
                    (BlackUdisLeftLocation[BlackLeftEndLine].y - BlackUdisLeftLocation[BlackLeftEndLine-4].y);
        }
        else
        {
          slope = 0;
        }
        //�������
        temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
        
        //��5�е�б�ʡ�
        if(BlackRightEndLine - BlackRightHeadLine > 5)
        {
          slope = 1.0 * (BlackUdisRightLocation[BlackRightEndLine].x - BlackUdisRightLocation[BlackRightEndLine-4].x) / 
                    (BlackUdisRightLocation[BlackRightEndLine].y - BlackUdisRightLocation[BlackRightEndLine-4].y);
        }
        else
        {
          slope = 0;
        }
        //�������
        temp = MaxRe((uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2), temp);
        RoadHalfWidthCompen = RoadHalfWidth / temp;
        if(RoadHalfWidthSwitch == 1)
        {
          RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
        }
        else
        {
        }
      }
      //�����߾�������Ҫ��
      else
      {
        //�����߶��ڵ�BlackControlLineLow�е�Զ����ֱ�ӷ���ʧ�ܡ�
        if(flag2 == 0 && flag4 == 0)
        {
          return 0;
        }
        else
        {
          //�����ڵ�BlackControlLineLow�еĽ����������ڵ�BlackControlLineLow�е�Զ����������������
          if(flag1 == 1 && flag3 == 0)
          {
            //б�ʵķ�ʽ������������
            //��5�е�б�ʡ�
            if(BlackLeftEndLine - BlackLeftHeadLine > 5)
            {
              slope = 1.0 * (BlackUdisLeftLocation[BlackLeftEndLine].x - BlackUdisLeftLocation[BlackLeftEndLine-4].x) / 
                    (BlackUdisLeftLocation[BlackLeftEndLine].y - BlackUdisLeftLocation[BlackLeftEndLine-4].y);
            }
            else
            {
              slope = 0;
            }
            //�������
            temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
            RoadHalfWidthCompen = RoadHalfWidth / temp;
            if(RoadHalfWidthSwitch == 1)
            {
              RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
            }
            else
            {
            }
          }
          //�����ڵ�BlackControlLineLow�еĽ����������ڵ�BlackControlLineLow�е�Զ����������������
          else if(flag1 == 0 && flag3 == 1)
          {
            //б�ʵķ�ʽ������������
            //��5�е�б�ʡ�
            if(BlackRightEndLine - BlackRightHeadLine > 5)
            {
              slope = 1.0 * (BlackUdisRightLocation[BlackRightEndLine].x - BlackUdisRightLocation[BlackRightEndLine-4].x) / 
                    (BlackUdisRightLocation[BlackRightEndLine].y - BlackUdisRightLocation[BlackRightEndLine-4].y);
            }
            else
            {
              slope = 0;
            }
            //�������
            temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
            RoadHalfWidthCompen = RoadHalfWidth / temp;
            if(RoadHalfWidthSwitch == 1)
            {
              RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
            }
            else
            {
            }
          }
          //�����߶��ڵ��еĽ�������ȡ�ϴ�ֵ��
          else if(flag1 == 0 && flag3 == 0)
          {
            //б�ʵķ�ʽ������������
            //��5�е�б�ʡ�
            if(BlackLeftEndLine - BlackLeftHeadLine > 5)
            {
              slope = 1.0 * (BlackUdisLeftLocation[BlackLeftEndLine].x - BlackUdisLeftLocation[BlackLeftEndLine-4].x) / 
                    (BlackUdisLeftLocation[BlackLeftEndLine].y - BlackUdisLeftLocation[BlackLeftEndLine-4].y);
            }
            else
            {
              slope = 0;
            }
            //�������
            temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
            
            //��5�е�б�ʡ�
            if(BlackRightEndLine - BlackRightHeadLine > 5)
            {
              slope = 1.0 * (BlackUdisRightLocation[BlackRightEndLine].x - BlackUdisRightLocation[BlackRightEndLine-4].x) / 
                    (BlackUdisRightLocation[BlackRightEndLine].y - BlackUdisRightLocation[BlackRightEndLine-4].y);
            }
            else
            {
              slope = 0;
            }
            //�������
            temp = MaxRe((uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2), temp);
            RoadHalfWidthCompen = RoadHalfWidth / temp;
            if(RoadHalfWidthSwitch == 1)
            {
              RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
            }
            else
            {
            }
          }
          //�����ϲ������ߵ����
          else
          {
            return 0;
          }
        }
      }
      
      int temproad;  //����ͼ�����һ��˫����Ч·��������ͼ�ĵ��߲����á�
      temproad = RoadHalfWidth;
      
      tempflag1 = 0;
      tempway1 = 0;
    buXianCount = 0;

                    //��������Ѿ���ã����ڿ�ʼ�Ӹߵ����������ߡ�
                        for (black_row = CenterHeadLine; black_row <= CameraHight - 1; black_row++)
                        {
                            //��ǰ�����Һ��߾���Ч���������Ч������Udis���飬ֻ����ԭʼ�ĺ��ߴ������顣
                            if (BlackLeftLoc[black_row][ 0] != MaxValUint8 && BlackRightLoc[black_row][ 0] != MaxValUint8)
                            {
                                tempflag1 = 0;
                                //ȡ���Һ��ߵ�ƽ��ֵ��
                                CenterLineLoc[black_row] = (BlackLeftLoc[black_row][ 0] + BlackRightLoc[black_row][ 0]) / 2;
                                //ȡ���һ��������Ч���е����������Ϊ���µ��������
                                /*  

                                  //����ͼ�����һ��˫����Ч·��������ͼ�ĵ��߲����á�
                                  temproad = RoadHalfWidthRecord[black_row];*/
                                //��������¼.���CameraHight - 1�е������������һ��ͼ�á�
                                //�³����⣬�޸�����
                                /* if(black_row == CameraHight - 1) 
                                 {  
                                   if(RoadHalfWidthRecord[black_row] > RoadHalfWidthLimitMax)
                                   {
                                     RoadHalfWidth = RoadHalfWidthLimitMax;
                                   }
                                   else if(RoadHalfWidthRecord[black_row] < RoadHalfWidthLimitMin)
                                   {
                                     RoadHalfWidth = RoadHalfWidthLimitMin;
                                   }
                                   else
                                   {
                                     RoadHalfWidth = RoadHalfWidthRecord[black_row];
                                   }            
                                 }
                                 else
                                 {
                                 } */
                            }
                            //���л�������Ч�������ϰ�ε�����������ߡ�
                            else if (BlackLeftLoc[black_row][ 0] == MaxValUint8 || BlackRightLoc[black_row][ 0] == MaxValUint8)
                            {

                                if (BlackLeftCrossDone == 2 || BlackRightCrossDone == 2)
                                {
                                    buXianCount--;
                                }
                                else if (BlackRightHeadLine >= 25 && BlackLeftHeadLine >= 25) { buXianCount = 0; }
                                else if (BlackLeftHeadLine <= 20 && BlackRightHeadLine >= 50) { buXianCount = 0; }
                                else if ((CURVEL < 0 && CURVER > 0) || (CURVEL > 0 && CURVER < 0)) { buXianCount = 0; }
                                else if (BlackLeftHeadLine <= 5) { buXianCount = 0; }
                                else if (BlackLeftHeadLine <= 20 && BlackRightHeadLine >= 45) { buXianCount = 0; }
                                else if (((AbsInt(CURVEL) >= 20) && (AbsInt(CURVEL) <= 50)) || ((AbsInt(CURVER) >= 20) && (AbsInt(CURVER) <= 50)))
                                {
                                    buXianCount = 0;
                                }
                                else if (((AbsInt(CURVEL) > 50) && (AbsInt(CURVEL) <= 2000)) || ((AbsInt(CURVER) > 50) && (AbsInt(CURVER) <= 2000)))
                                {
                                    buXianCount = 0;
                                }
                                else if ((AbsInt(CURVEL) > 2000) || (AbsInt(CURVER) > 2000))
                                {
                                    buXianCount = 0;
                                }


                                tempflag1 = 0;
                                index = 0;
                                for (i = black_row - 1;i>=0 ; i--)
                                {
                                    if (CenterLineLoc[i] != MaxValUint8)
                                    {
                                        b[index] = CenterLineLoc[i];
                                        a[index] = i;
                                        index++;
                                    }
                                    if (index == BlackBackLineNum)
                                    {

                                        break;
                                    }

                                }

                                //��С���˷�
                                //y = a0 + a1 * x
                                a1 = LeastSquarea1(a, b, BlackBackLineNum);

                                a0 = LeastSquarea0(a, b, a1, BlackBackLineNum);


                                //����Ҳ�и��ȣ��������Ҷ����ܲ�����Χ��
                                temp = (a0 + a1 * black_row) / LeastSquareMulti;
                                if (temp >= CameraRealWidth - 1)
                                {
                                    //BlackLeftLoc[black_row,0] = CameraRealWidth - 1;
                                    //�������ҽ���ʱ��ԭ����Ϊ�ñ߽�ֵ�����ڵĲ����ǴӸ���������Чֵ��

                                    temp = CameraRealWidth - 1;
                                }
                                else if (temp <= 0)
                                {
                                    //BlackLeftLoc[black_row,0] = 0;
                                    //�������ҽ���ʱ��ԭ����Ϊ�ñ߽�ֵ�����ڵĲ����ǴӸ���������Чֵ��
                                    temp = 0;
                                }
                                CenterLineLoc[black_row] = (int)(temp);
                                //  CenterLineLoc[black_row] = BlackLeftLoc[black_row,0] + temproad + buXianCount;
                            }
                            //������Ч��������Ч���������м�ȥһ���������
                            /*else if(BlackLeftLoc[black_row,0] == MaxValUint8 && BlackRightLoc[black_row,0] != MaxValUint8)
                            {
                                if (BlackLeftCrossDone == 2 || BlackRightCrossDone == 2)
                                {
                                    buXianCount--;
                                }
                                else if (BlackRightHeadLine >= 25 && BlackLeftHeadLine >= 25) { buXianCount = 0; }
                                else if (BlackRightHeadLine <= 20 && BlackLeftHeadLine >= 50) { buXianCount = 0; }
                                else if ((CURVEL < 0 && CURVER > 0) || (CURVEL > 0 && CURVER < 0)) { buXianCount = 0; }
                                else if (BlackRightHeadLine <= 5) { buXianCount = 0; }
                                else if (BlackRightHeadLine <= 20 && BlackLeftHeadLine >= 45) { buXianCount = 0; }
                                else if (((AbsInt(CURVEL) >= 20) && (AbsInt(CURVEL) <= 50)) || ((AbsInt(CURVER) >= 20) && (AbsInt(CURVER) <= 50)))
                                {
                                    buXianCount=0;
                                }
                                else if (((AbsInt(CURVEL) > 50) && (AbsInt(CURVEL) <= 2000)) || ((AbsInt(CURVER) > 50) && (AbsInt(CURVER) <= 2000)))
                                {
                                    buXianCount =0;
                                }
                                else if ((AbsInt(CURVEL) > 2000) ||(AbsInt(CURVER) > 2000))
                                {
                                    buXianCount =0;
                                }


                                tempflag1 = 0;
                              CenterLineLoc[black_row] = BlackRightLoc[black_row,0] - temproad - buXianCount;
                            }
                            //�����о���Ч���������������߾�����ǰ�ߡ�
                            else if(BlackLeftLoc[black_row,0] == MaxValUint8 && BlackRightLoc[black_row,0] == MaxValUint8)
                            {
                              //�������߾���Чʱ�����Բ�������������Ʋ��ߣ�Ҳ���Ը������CenterForwardLineNum����С���˷����Ʋ��ߡ�
                              if(tempflag1 == 0)
                              {
                                //ÿ��ͼֻ����һ�Σ�����ȷ�����߷�ʽ���Ժ�Ͳ����ٽ����ˡ�
                                //�����ֳ�������Һ�����Ч����������ٴ�ˢ��б�ʡ�
                                tempflag1 = 1;
                                //������������࣬���Բ�����С���˷��ķ�ʽ��
                                //���һ�л����о������ã���Ϊ�п����ǹյ㡣��Ҳ����̫����ȡ��б�ʾͲ����ˡ�
                                if(black_row + CenterForwardLineNum + 2 <= CameraHight - 1)
                                {
                                  tempway1 = 0;
                                  //������С���˷�ϵ���ļ��㡣
                                  for(i = 0; i < CenterForwardLineNum; i++)
                                  {
                                    x[i] = black_row + i + 3;
                                    y[i] = CenterLineLoc[black_row + i + 3];
                                  }
                                  a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
                                  a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣            
                                }
                                else if(black_row + CenterForwardLineNum + 1 <= CameraHight - 1)
                                {
                                  tempway1 = 0;
                                  //������С���˷�ϵ���ļ��㡣
                                  for(i = 0; i < CenterForwardLineNum; i++)
                                  {
                                    x[i] = black_row + i + 2;
                                    y[i] = CenterLineLoc[black_row + i + 2];
                                  }
                                  a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
                                  a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣                        
                                }
                                else if(black_row + CenterForwardLineNum <= CameraHight - 1)
                                {
                                  tempway1 = 0;
                                  //������С���˷�ϵ���ļ��㡣
                                  for(i = 0; i < CenterForwardLineNum; i++)
                                  {
                                    x[i] = black_row + i + 1;
                                    y[i] = CenterLineLoc[black_row + i + 1];
                                  }
                                  a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
                                  a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣
                                }
                                //����е����������࣬��������������Ʋ��ߵķ�ʽ��
                                else
                                {
                                  tempway1 = 1;
                                }
                              }
                              else
                              {
                              }

                              //ȷ�ϲ��߷�ʽ�󣬿�ʼ���ߡ�
                              if(tempway1 == 0)
                              {
                                //��С���˷��ķ�ʽ��
                                CenterLineLoc[black_row] = (a0 + a1 * black_row) / LeastSquareMulti;
                              }
                              else
                              {
                                //������еķ�ʽ��
                                CenterLineLoc[black_row] = CenterLineLoc[black_row+1] + CenterLineLoc[black_row+1] - CenterLineLoc[black_row+2];
                              }

                            }*/
                            //�����ϲ����ߵ����
                            else
                            {
                            }

                        }
                    
      //��δ������е�����������Чֵ���Զ����Ĳ�������
      //�ײ�����Чֵ��
      /* if(CenterEndLine != CameraHight - 1)
       {
         for(black_row = CameraHight - 1; ; black_row--)
         {
           if(black_row == CenterEndLine) break;       
           CenterLineLoc[black_row] = MaxValInt16;
         }
       }
       else
       {
       }      */
    }
    //���ߵ������Ҳ����SingleBlackAllFlag==1�������
    else
    {
      tempflag1 = 0;
      tempway1 = 0;
      
      //��������Ѿ���ã����ڿ�ʼ�ӵ͵����������ߡ�
      for(black_row = CenterEndLine; ; black_row--)
      {
        //��ǰ�����Һ��߾���Ч���������Ч������Udis���飬ֻ����ԭʼ�ĺ��ߴ������顣
        if(BlackLeftLoc[black_row][0] != MaxValUint8 && BlackRightLoc[black_row][0] != MaxValUint8)
        {
          tempflag1 = 0;
          //ȡ���Һ��ߵ�ƽ��ֵ��
          CenterLineLoc[black_row] = (BlackLeftLoc[black_row][0] + BlackRightLoc[black_row][0]) / 2;
          //ȡ���һ��������Ч���е����������Ϊ���µ��������
          if(BlackLeftLoc[black_row,0] > BlackRightLoc[black_row,0])
          {
            RoadHalfWidthSingle = (BlackLeftLoc[black_row,0] - BlackRightLoc[black_row,0]) / 2;
          }
          else
          {
            RoadHalfWidthSingle = (BlackRightLoc[black_row,0] - BlackLeftLoc[black_row,0]) / 2;
          }        
        }
        //������Ч��������Ч���������м���һ���������
        else if(BlackLeftLoc[black_row][0] != MaxValUint8 && BlackRightLoc[black_row][0] == MaxValUint8)
        {
          tempflag1 = 0;
          CenterLineLoc[black_row] = BlackLeftLoc[black_row][0] - RoadHalfWidthSingle;    //��Ϊ�ǵ��ߣ������Ǽ��š�
        }
        //������Ч��������Ч���������м�ȥһ���������
        else if(BlackLeftLoc[black_row][0] == MaxValUint8 && BlackRightLoc[black_row][0] != MaxValUint8)
        {
          tempflag1 = 0;
          CenterLineLoc[black_row] = BlackRightLoc[black_row][0] + RoadHalfWidthSingle;   //��Ϊ�ǵ��ߣ������ǼӺš�
        }
        //�����о���Ч���������������߾�����ǰ�ߡ�
        else if(BlackLeftLoc[black_row][0] == MaxValUint8 && BlackRightLoc[black_row][0] == MaxValUint8)
        {
          //�������߾���Чʱ�����Բ�������������Ʋ��ߣ�Ҳ���Ը������CenterForwardLineNum����С���˷����Ʋ��ߡ�
          if(tempflag1 == 0)
          {
            //ÿ��ͼֻ����һ�Σ�����ȷ�����߷�ʽ���Ժ�Ͳ����ٽ����ˡ�
            //�����ֳ�������Һ�����Ч����������ٴ�ˢ��б�ʡ�
            tempflag1 = 1;
            //������������࣬���Բ�����С���˷��ķ�ʽ��
            //���һ�л����о������ã���Ϊ�п����ǹյ㡣��Ҳ����̫����ȡ��б�ʾͲ����ˡ�
            if(black_row + CenterForwardLineNum + 2 <= CameraHight - 1)
            {
              tempway1 = 0;
              //������С���˷�ϵ���ļ��㡣
              for(i = 0; i < CenterForwardLineNum; i++)
              {
                x[i] = black_row + i + 3;
                y[i] = CenterLineLoc[black_row + i + 3];
              }
              a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
              a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣            
            }
            else if(black_row + CenterForwardLineNum + 1 <= CameraHight - 1)
            {
              tempway1 = 0;
              //������С���˷�ϵ���ļ��㡣
              for(i = 0; i < CenterForwardLineNum; i++)
              {
                x[i] = black_row + i + 2;
                y[i] = CenterLineLoc[black_row + i + 2];
              }
              a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
              a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣                        
            }
            else if(black_row + CenterForwardLineNum <= CameraHight - 1)
            {
              tempway1 = 0;
              //������С���˷�ϵ���ļ��㡣
              for(i = 0; i < CenterForwardLineNum; i++)
              {
                x[i] = black_row + i + 1;
                y[i] = CenterLineLoc[black_row + i + 1];
              }
              a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
              a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣
            }
            //����е����������࣬��������������Ʋ��ߵķ�ʽ��
            else
            {
              tempway1 = 1;
            }
          }
          else
          {
          }
          
          //ȷ�ϲ��߷�ʽ�󣬿�ʼ���ߡ�
          if(tempway1 == 0)
          {
            //��С���˷��ķ�ʽ��
            CenterLineLoc[black_row] = (a0 + a1 * black_row) / LeastSquareMulti;
          }
          else
          {
            //������еķ�ʽ��
            CenterLineLoc[black_row] = CenterLineLoc[black_row+1] + CenterLineLoc[black_row+1] - CenterLineLoc[black_row+2];
          }
          
        }
        //�����ϲ����ߵ����
        else
        {
        }
        
        if(black_row == 0) break;
      }
         
      //��δ������е�����������Чֵ���Զ����Ĳ�������
      //�ײ�����Чֵ��
      if(CenterEndLine != CameraHight - 1)
      {
        for(black_row = CameraHight - 1; ; black_row--)
        {
          if(black_row == CenterEndLine) break;       
          CenterLineLoc[black_row] = MaxValInt16;
        }
      }
      else
      {
      }
    }
  }
  //�����ϲ����ߵ����
  else
  {
    //���Һ��߾���ȡʧ�ܣ�����0.
    return 0;
  }
       /*     if (BlackLeftLoc[CenterEndLine, 0] > BlackRightLoc[CenterEndLine, 0])
            {
                RoadHalfWidth = (BlackLeftLoc[CenterEndLine, 0] - BlackRightLoc[CenterEndLine, 0]) / 2;
            }
            else
            {
                RoadHalfWidth = (BlackRightLoc[CenterEndLine, 0] - BlackLeftLoc[CenterEndLine, 0]) / 2;
            }
            if (RoadHalfWidth > RoadHalfWidthLimitMax)
            {
                RoadHalfWidth = RoadHalfWidthLimitMax;
            }
            else if (RoadHalfWidth < RoadHalfWidthLimitMin)
            {
                RoadHalfWidth = RoadHalfWidthLimitMin;
            }
            else
            {
            }*/
            return 1;
}



//�ϰ������������ȷ���Ƿ�ʼ������ơ�����1��ʼ��0�ٵȵ�
uint8 BrickSpeDealStartJudge(void)
{
  uint8 col, count1, i, index;
  int32 a0, a1;
  uint8 x[BrickSlopeRowNum];   //ȡ���ٸ�����һ��ʼ�ж��塣
  uint8 y[BrickSlopeRowNum];
  
  return 1;   ///////////////���ȴ���ֱ��������ơ�
  
  //ͨ���ж��ϰ��ǲ��������Խ����ĳһ�У��Ӷ��ж��Ƿ�ʼ������ơ�
  
  //���ϰ�
  if(BrickSpeDealDir == 0)
  {
    //��С���˷�����ɨ����ʼ�кͽ����еĺڵ������С�
    //ȡBrickSlopeRowNum������Ϊ��С���˷��Ļ�׼�㡣
    //�����Ͻ�Ϊԭ�㣬����Ϊx������������Ϊy��������
    index = 0;
    for(i = CameraHight - 1; ; i--)
    {
      if(BlackLeftLoc[i][0] != MaxValUint8)
      {
        y[index] = BlackLeftLoc[i][0];
        x[index] = i;
        index++;
      }
      if(index == BrickSlopeRowNum)
      {
        break;
      }
      if(i == BrickSpeDealStartJudgeRow) //CameraHight-BrickSpeDealStartJudgeRow�����BrickSlopeRowNum��
      {
        return 0;
      }
    }
    //��С���˷�
    //y = a0 + a1 * x������������LeastSquareMulti����
    a1 = LeastSquarea1(x, y, BrickSlopeRowNum);
    a0 = LeastSquarea0(x, y, a1, BrickSlopeRowNum);
   
    //���ض�һ�еĴ���
    //���кڵ���������ϰ���������ɨ�衣
    count1 = 0;
    //��ǰ�е�ɨ����߽硣
    BrickSpeDealStartJudgeCol = (a0 + a1 * BrickSpeDealStartJudgeRow) / LeastSquareMulti;
    //����BrickScanColNum��Ϊ�ұ߽�
    for(col = BrickSpeDealStartJudgeCol + BrickScanColNum; ; col--)
    {
      if(ImgNew[BrickSpeDealStartJudgeRow][col] < LimitLeftB)  //����
      {
        count1++;
      }
      else
      {
      }
      //����ɨ������߽硣
      if(col <= BrickSpeDealStartJudgeCol || col == 0) break;
    }
    
    //���кڵ��������BrickLineBlackCountNum��ʱ�����м�����1.
    if(count1 > BrickLineBlackCountNum) 
    {
      return 1;
    }
    else
    {
    }
  }
  //���ϰ�
  else
  {
    //��С���˷�����ɨ����ʼ�кͽ����еĺڵ������С�
    //ȡBrickSlopeRowNum������Ϊ��С���˷��Ļ�׼�㡣
    //�����Ͻ�Ϊԭ�㣬����Ϊx������������Ϊy��������
    index = 0;
    for(i = CameraHight - 1; ; i--)
    {
      if(BlackRightLoc[i][0] != MaxValUint8)
      {
        y[index] = BlackRightLoc[i][0];
        x[index] = i;
        index++;
      }
      if(index == BrickSlopeRowNum)
      {
        break;
      }
      if(i == BrickSpeDealStartJudgeRow) //CameraHight-BrickSpeDealStartJudgeRow�����BrickSlopeRowNum��
      {
        return 0;
      }
    }
    //��С���˷�
    //y = a0 + a1 * x������������LeastSquareMulti����
    a1 = LeastSquarea1(x, y, BrickSlopeRowNum);
    a0 = LeastSquarea0(x, y, a1, BrickSlopeRowNum);
   
    //���ض�һ�еĴ���
    //���кڵ���������ϰ���������ɨ�衣
    count1 = 0;
    //��ǰ�е�ɨ����߽硣
    BrickSpeDealStartJudgeCol = (a0 + a1 * BrickSpeDealStartJudgeRow) / LeastSquareMulti;
    //����BrickScanColNum��Ϊ��߽�
    for(col = BrickSpeDealStartJudgeCol - BrickScanColNum; ; col++)
    {
      if(ImgNew[BrickSpeDealStartJudgeRow][col] < LimitRightB)  //����
      {
        count1++;
      }
      else
      {
      }
      //����ɨ�����ұ߽硣
      if(col >= BrickSpeDealStartJudgeCol || col >= CameraRealWidth - 1) break;
    }
    
    //���кڵ��������BrickLineBlackCountNum��ʱ�����м�����1.
    if(count1 > BrickLineBlackCountNum) 
    {
      return 1;
    }
    else
    {
    }
  }
  
  //��̬Ϊ�ٵȵȡ�
  return 0;
}



//�ϰ����������ʱ������ȷ���Ƿ��˳�������ơ�
//�ı�BrickSpeDealExitJudgeFlag��1~2����������ƣ�����1��ʾ��ʼ̬��2��ʾ��ǰ�Ѿ����ϰ�ƽ�У�0�˳�������ƣ��ѿ���Ȩ��������ͨ���ơ�
uint8 BrickSpeDealExitJudge(void)
{
  return 1;   //////////////���ı��˳���־λ��ֻͨ������ʱ������������ƵĴ�����
  
  
  //���ݵ�CameraHight - 1�е�������������ȱ����⵽С��65�����ӣ�Ȼ������⵽����75������65���з���ϵ������˼�������ӡ�
  //�����ϰ��������֣�û�б�Ҫ��

  //��ǰΪ��ʼ̬����Ҫ�ж��ǲ����Ѿ����ϰ���ƽ���ˡ�
  if(BrickSpeDealExitJudgeFlag == 1)
  {
    if(
       (BlackLeftLoc[CameraHight - 1][0] != MaxValUint8)
    && (BlackRightLoc[CameraHight - 1][0] != MaxValUint8)
    && (BlackRightLoc[CameraHight - 1][0] > BlackLeftLoc[CameraHight - 1][0]) //������Ч
    && (BlackRightLoc[CameraHight - 1][0] - BlackLeftLoc[CameraHight - 1][0] < BrickSpeDealExitState1Val * 2) //�������С��һ��ֵ
      )
    {
      //�����������������ɵ�״̬2����ʾ�Ѿ����ϰ���ƽ�С�
      BrickSpeDealExitJudgeFlag = 2;
    }
    else
    {
    }
  }
  //��ǰ�Ѿ����ϰ���ƽ���ˣ���Ҫ�ж��ǲ��ǳ�ǰ���Ѿ�Խ�����ϰ���Ӷ��˳�������ơ�
  else if(BrickSpeDealExitJudgeFlag == 2)
  {
    if(
       (BlackLeftLoc[CameraHight - 1][0] != MaxValUint8)
    && (BlackRightLoc[CameraHight - 1][0] != MaxValUint8)
    && (BlackRightLoc[CameraHight - 1][0] > BlackLeftLoc[CameraHight - 1][0]) //������Ч
    && (BlackRightLoc[CameraHight - 1][0] - BlackLeftLoc[CameraHight - 1][0] > BrickSpeDealExitState2Val * 2) //����������һ��ֵ
      )
    {
      //�����������������ɵ�״̬0����ʾ��ǰ���Ѿ�һ������Խ���ϰ���˳�������ơ�
      BrickSpeDealExitJudgeFlag = 0;
    }
    else
    {
    }
  }
  //�����ϲ��ᵽ���
  else
  {
  }

  return 1;
}



//�ϰ���Զ�������⴦��///////////////////////////��֪���ǲ��Ǽ���
uint8 BrickSpeDealServor(void)
{  
  //�������޷���
  //���ϰ����������Ҵ�̫�ࡣ
  if(BrickSpeDealFlag == 1 && BrickSpeDealCenFlag == 0 && BrickSpeDealDir == 0)
  {
    //ǿ����ת����ײ�ܱȳ��ߺá�
    ServoPIDInputVal = ServoPIDCen - 100;
    //ServoPIDInputVal = ServoPIDCen - 0;
    //StopFlag = 1;
  }
  //���ϰ������������̫�ࡣ
  else if(BrickSpeDealFlag == 1 && BrickSpeDealCenFlag == 0 && BrickSpeDealDir == 1)
  {
    //ǿ����ת����ײ�ܱȳ��ߺá�
    ServoPIDInputVal = ServoPIDCen + 100;  
    //ServoPIDInputVal = ServoPIDCen + 0;
    
    //StopFlag = 1;
  }
  //�����ϰ�����������
  else
  {    
  }

  return 1;
}




//�ϰ����������ߵ����⴦����ֱ���޸�DeviFuse������ĳһ�����߸���һ��������������ߡ�Ȼ����ImgProSucceedDeal()�������DeviFuse���º���ȥŪ��
//���CenterLineLoc[]�������Ӱ�졣
//����֮ǰ������һ���������ġ�����ֱ�Ӵ���β������ͷ���ɡ�
//���ֱ����BlackLoc���鲻̫���룬���Գ���ʹ�û������������飬���ֱ��/////////////////////////
uint8 BrickSpeDealCen(void)
{
  uint8 row;
  
  //���ϰ�������������һС�������ߡ�
  if(BrickSpeDealDir == 0)
  {
    //ͼ��ʧ�ܻ���ϰ���ʧ��ʱ���������ߣ�����ʧ�ܡ�֮��������һ��ͼ��DeviFuse��ǿ�Ƹ���
    if(ImgBlackSucceedFlag == 0 || BlackRightDone == 0)
    {
      return 0;
    }
    else
    {
    }
    
    //��ͷ��β
    //CenterHeadLine = BlackRightHeadLine;
    CenterHeadLine = 0;
    CenterEndLine = BlackRightEndLine;
    
    //����δ���������鹹�����������飬������
    if(BrickSpeDealCenChoose == 0)
    {
      //���в���
      for(row = BlackRightEndLine; ; row--)
      {
        CenterLineLoc[row] = BlackRightLoc[row][0] - BrickSpeDealBias[BrickSpeDealBackCount] + (BrickConfirmFinalColCom - 50); //BrickConfirmFinalColCom����OLED����
        
        if(row == BlackRightHeadLine) break;
      }
    }
    //���ý���������鹹�����������飬������
    else
    {
      //���в���
      for(row = BlackRightEndLine; ; row--)
      {
        CenterLineLoc[row] = BlackUdisRightLocation[row].x - BrickSpeDealBias[BrickSpeDealBackCount] + (BrickConfirmFinalColCom - 50); //BrickConfirmFinalColCom����OLED����
        
        if(row == BlackRightHeadLine) break;
      }      
    }
    
    //һֱ������С�
    if(BlackRightHeadLine != 0)
    {
      for(row = BlackRightHeadLine - 1; ; row--)
      {
        CenterLineLoc[row] = CenterLineLoc[row+1] + CenterLineLoc[row+1] - CenterLineLoc[row+2];
        
        if(row == 0) break;
      }
    }
    else
    {     
    }
    
  }
  //���ϰ�������������һС�������ߡ�
  else
  {
    //ͼ��ʧ�ܻ���ϰ���ʧ��ʱ���������ߣ�����ʧ�ܡ�֮��������һ��ͼ��DeviFuse��ǿ�Ƹ���
    if(ImgBlackSucceedFlag == 0 || BlackLeftDone == 0)
    {
      return 0;
    }
    else
    {
    }
    
    //��ͷ��β
    //CenterHeadLine = BlackLeftHeadLine;
    CenterHeadLine = 0;
    CenterEndLine = BlackLeftEndLine;
    
    //����δ���������鹹�����������飬������
    if(BrickSpeDealCenChoose == 0)
    {
      //���в���
      for(row = BlackLeftEndLine; ; row--)
      {
        CenterLineLoc[row] = BlackLeftLoc[row][0] + BrickSpeDealBias[BrickSpeDealBackCount] - (BrickConfirmFinalColCom - 50); //BrickConfirmFinalColCom����OLED����
        
        if(row == BlackLeftHeadLine) break;
      }
    }
    //���ý���������鹹�����������飬������
    else
    {
      //���в���
      for(row = BlackLeftEndLine; ; row--)
      {
        CenterLineLoc[row] = BlackUdisLeftLocation[row].x + BrickSpeDealBias[BrickSpeDealBackCount] - (BrickConfirmFinalColCom - 50); //BrickConfirmFinalColCom����OLED����
        
        if(row == BlackLeftHeadLine) break;
      }      
    }
    
    //һֱ������С�
    if(BlackLeftHeadLine != 0)
    {
      for(row = BlackLeftHeadLine - 1; ; row--)
      {
        CenterLineLoc[row] = CenterLineLoc[row+1] + CenterLineLoc[row+1] - CenterLineLoc[row+2];
        
        if(row == 0) break;
      }
    }
    else
    {     
    }
    
  }
  
  return 1;
}



//���ϳ���
uint8 BrickAvoid(void)
{
  uint8 i;
  
  ////�ϰ������־û�б���λ��ʱ��Ž����ϰ����������ѱ���λ�����ý����ϰ�������
  if(BrickConfirmLockFlag == 0)
  {
    //A�μ�������B���ϰ��ɹ������ж�Ϊ�ϰ��������ȳ����С�
    for(i = 0; ; i++)
    {
      BrickConfirmMat0[i] = BrickConfirmMat0[i + 1];
      BrickConfirmMat1[i] = BrickConfirmMat1[i + 1];
      if(i == BrickConfirmMatNum - 2) break;
    }
    //���ϰ��ɹ�
    if(PathType == PathBrickLeft)
    {
      //���ϰ�����������1.
      BrickConfirmMat0[BrickConfirmMatNum - 1] = 1;
      //���ϰ�����������0��
      BrickConfirmMat1[BrickConfirmMatNum - 1] = 0;
    }
    else if(PathType == PathBrickRight)
    {
      //���ϰ�����������1.
      BrickConfirmMat1[BrickConfirmMatNum - 1] = 1;
      //���ϰ�����������0��
      BrickConfirmMat0[BrickConfirmMatNum - 1] = 0;   
    }
    else
    {
      //�ж�Ϊ���ϰ���������ֵ��0.
      BrickConfirmMat0[BrickConfirmMatNum - 1] = 0;
      BrickConfirmMat1[BrickConfirmMatNum - 1] = 0;
    }
    
    //�ռ�BrickConfirmMat������1�ĸ�����
    BrickConfirmMatCollect0 = 0;
    for(i = 0; ; i++)
    {
      if(BrickConfirmMat0[i] == 1) BrickConfirmMatCollect0++;
      
      if(i == BrickConfirmMatNum - 1) break;
    }
    
    //�ռ�BrickConfirmMat������1�ĸ�����
    BrickConfirmMatCollect1 = 0;
    for(i = 0; ; i++)
    {
      if(BrickConfirmMat1[i] == 1) BrickConfirmMatCollect1++;
      
      if(i == BrickConfirmMatNum - 1) break;
    }
    
    //�������ɴΣ�������Ϊ���ϰ���
    if(BrickConfirmMatCollect0 >= BrickConfirmMatLimit)
    {
      //�����־λ��λ��
      BrickConfirmLockFlag = 1;
      //������գ���ֹ�ظ����档
      for(i = 0; ; i++)
      {
        BrickConfirmMat0[i] = 0;
        BrickConfirmMat1[i] = 0;
        if(i == BrickConfirmMatNum - 1) break;
      }
      //ȷ���ϰ��ķ���
      BrickSpeDealDir = 0;             //���ϰ�
    }
    else if(BrickConfirmMatCollect1 >= BrickConfirmMatLimit)
    {
      //�����־λ��λ��
      BrickConfirmLockFlag = 1;
      //������գ���ֹ�ظ����档
      for(i = 0; ; i++)
      {
        BrickConfirmMat0[i] = 0;
        BrickConfirmMat1[i] = 0;
        if(i == BrickConfirmMatNum - 1) break;
      }
      //ȷ���ϰ��ķ���
      BrickSpeDealDir = 1;             //���ϰ�      
    }
    else
    {
    }
  }
  //�ϰ������ѱ���λ�����ý����ϰ�������
  else
  {
  }
  
  //���ϰ������־λ��λ����ȴ����ߵ���ͷ���ͺ�ʼ�ϰ�����
  if(BrickConfirmLockFlag == 1)
  {
    light_control(PORTD, 15, Light_ON);
    //�жϿɷ�ʼ���⴦��
    if(BrickSpeDealStartJudge() == 1)
    {
      BrickSpeDealBackCount = BrickSpeDealBackCountNum;
    }
    else
    {
      //��û�����������ٵȵȡ�
    }
  }
  else
  {
  }

  //�˳��ϰ����⴦����жϡ�BrickSpeDealExitJudgeFlag����¡�
  BrickSpeDealExitJudge();
  
  //���˵��������󣬾Ϳ�ʼÿ�ε�����ֱ��Ϊ0���ж��Ѿ������ϰ�.
  if(BrickSpeDealBackCount != 0 && BrickSpeDealExitJudgeFlag != 0)
  {
    BrickConfirmLockFlag = 0;    //�ϰ�������ƿ����ɹ����������־λ���㡣
    
    //����ֵ��1��
    BrickSpeDealBackCount--;
    //��־λ˵���������ϰ������⴦��
    BrickSpeDealFlag = 1;
    
    //�������ߵ����⴦��������ʣBrickSpeDealBackCount�Ρ�
    BrickSpeDealCenFlag = BrickSpeDealCen();
    //�������Ѿ������ˣ�������ֹͣ������ƣ�����Ὣ���ǿ�ƴ������
    if(BrickSpeDealCenFlag == 0)
    {
      BrickSpeDealBackCount = 0;
    }
    else
    {
    }
    //��������ڼ䣬Ϊ�˷�ֹײ�ϰ���������������У����µ���ֹ���������жϱ�־��λ��������������0�������������±�־����������٣�����֤��λ��
    //�����������ڣ�����Ӧ���Ǳ��յġ�
    GyroResultForbidFlag = 0;
    GyroResultForbidBackCount = 0;
    
  }
  else
  {    
    //�����������㣬��ֹ�ٴ������ϰ����⴦��
    BrickSpeDealBackCount = 0;
    
    //��־λ˵��û�н����ϰ������⴦��
    BrickSpeDealFlag = 0;
    
    //�г���־�ó�ʼ״̬1.
    BrickSpeDealExitJudgeFlag = 1;
  }
  
  return 1;
}


//�����ߴ���������������ͷ���������
uint8 CenterLineGetRaw(void)
{
  uint8 flag;
  
  flag = 1;
  //ֱ���� ���� �� ǿ�ƿ����ڼ䣬�Ͳ��ý�����������������ȡ��
  //ImgProSucceedDeal()�����DeviFuse���º�����û���õģ���ΪAngleStep2Confirm()��ImgProSucceedDeal()�ĺ���ִ�У���ǿ�Ƹ���DeviFuse.
  if(AngleConfirmLockFlag == 1 || AngleSpeDealFlag == 1)
  {   
    //ֱ����������������ʱ��CenterLineLoc[]����һֱ����Чֵ��
  }
  //�ϰ���ǿ�ƿ����ڼ䣬��ִ����������������ȡ�����ǲ��õ����ߵ�������������ȡ������
  //����ֻ�Ǹ���һ��������������ߣ�������ImgProSucceedDeal()�����DeviFuse���º���ȥ�á�
  //�����ϰ��������ڼ䣬��Ȼ��������ȡ�����ߡ�
  else if(BrickSpeDealFlag == 1)
  {
    //��BrickAvoid()���Ѿ�ִ������������ȡ������
  }
  //��������������������������������ȡ���п��ܷ���ʧ�ܡ�
  else
  {
    flag = CenterLineGetNormal();
  }
  
  return flag;
}




//��������ȡ������ǰ���Һ��߾�������
uint8 CenterLineGet(void)
{
  uint8 row, i;
  uint8 temp;
  uint8 flag1, flag2, flag3, flag4;  
  uint8 tempflag1;
  uint8 tempway1;
  uint8 x[CenterForwardLineNum];   //��������ǰ���߼���б��ʱ��x���꣬��ʾ�ڼ��С���
  int16 y[CenterForwardLineNum];   //��������ǰ���߼���б��ʱ��y���꣬��ʾ������λ�á�
  int32 a1, a0;    //��������ǰ����ʱ����С���˷���б�ʺ��ݽؾࡣ
  
  float slope;
  
  
  //������ȡ�ɹ���������ȡʧ�ܡ�
  if(BlackLeftDone == 1 && BlackRightDone == 0)
  {
    //�����ߵ���ͷ��β��Ч����ֱ�ӷ���ʧ�ܡ�
    if(BlackLeftHeadLine == MaxValUint8 || BlackLeftEndLine == MaxValUint8)
    {
      return 0;
    }
    else
    {
    }
    
    flag1 = 1;
    flag2 = 1;
    
    //�����ߵ���βȡ���ߵ���β���ɡ�
    CenterHeadLine = BlackLeftHeadLine;     //��ͷȡ���ߵ���ͷ��ע���ⲻ��ʵ�ʵ���ͷ��
    //CenterHeadLine = 0;   //��ͷ��ΪҪ�̶�������0�У�����ֱ����0.
    CenterEndLine = BlackLeftEndLine;
    
    //���ȿ���ͷ�Ƿ����BlackControlLineLow��
    if(BlackLeftHeadLine >= BlackControlLineLow)
    {
      flag1 = 0;
    }
    else
    {
    }
    
    //����βС��CameraHight - 1�С�
    if(BlackLeftEndLine < CameraHight - 1)
    {
      //ֻ�����߳ɹ�����������β����ôԶ������û��������ֱ�ӷ���ʧ�ܡ�
      //if(BlackLeftEndLine < CameraHight - 1 - BlackLeftBackLineStart)
      if(BlackLeftEndLine <= BlackControlLineLow)
      {
        flag2 = 0;
        return 0;       
      }
      //����β��һ����Χ�ڡ���������ѵ�59����ǰ�Ƽ��С�ֱ��ȡBlackLeftEndLine��
      else
      {
      }
    }
    //����β����CameraHight - 1��ֱ��ȡBlackLeftEndLine
    else
    {
    }
    
    //��ʧ��һ���ߵ�ʱ���ȸ���б�ʹ���������û����һ��˫��ͼ��ʱ������������ֱ������һ��˫�ߵ��������
    //��5�е�б�ʡ�
    if(BlackLeftEndLine - BlackLeftHeadLine > 5)
    {
      slope = 1.0 * (BlackUdisLeftLocation[BlackLeftEndLine].x - BlackUdisLeftLocation[BlackLeftEndLine-4].x) / 
                    (BlackUdisLeftLocation[BlackLeftEndLine].y - BlackUdisLeftLocation[BlackLeftEndLine-4].y);
    }
    else
    {
      slope = 0;
    }
    //�������
    temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
    //ȡ���ֵ
    RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
    
    //����������ȹ��Ƴ������ߵ���ͷ��
    CenterLineLoc[BlackLeftEndLine] = BlackUdisLeftLocation[BlackLeftEndLine].x + RoadHalfWidth;
    
    tempflag1 = 0;
    tempway1 = 0;
    //�������ߵ����ƹ��Ƴ������ߡ��������Ǹ�int16�;�����������
    for(row = BlackLeftEndLine - 1; ;row--)
    {
      //������Чʱ���������ߵ����Ʋ��ߡ�
      if(BlackLeftLoc[row][0] != MaxValUint8)
      {
        tempflag1 = 0;
        CenterLineLoc[row] = CenterLineLoc[row+1] + BlackUdisLeftLocation[row].x - BlackUdisLeftLocation[row+1].x;
      }
      //������Чʱ������������е����������Ʋ��ߡ�
      else
      {
        //��������Чʱ�����Բ�������������Ʋ��ߣ�Ҳ���Ը������CenterForwardLineNum����С���˷����Ʋ��ߡ�
        if(tempflag1 == 0)
        {
          //ÿ��ͼֻ����һ�Σ�����ȷ�����߷�ʽ���Ժ�Ͳ����ٽ����ˡ�
          tempflag1 = 1;
          //������������࣬���Բ�����С���˷��ķ�ʽ��
          if(row + CenterForwardLineNum <= CameraHight - 1)
          {
            tempway1 = 0;
            //������С���˷�ϵ���ļ��㡣
            for(i = 0; i < CenterForwardLineNum; i++)
            {
              x[i] = row + i + 1;
              y[i] = CenterLineLoc[row + i + 1];
            }
            a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
            a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣
          }
          //����е����������࣬��������������Ʋ��ߵķ�ʽ��
          else
          {
            tempway1 = 1;
          }
        }
        else
        {
        }
        
        //ȷ�ϲ��߷�ʽ�󣬿�ʼ���ߡ�
        if(tempway1 == 0)
        {
          //��С���˷��ķ�ʽ��
          CenterLineLoc[row] = (a0 + a1 * row) / LeastSquareMulti;
        }
        else
        {
          //��������2�С�
          if(row == CameraHight -1  || row == CameraHight - 2)
          {
            CenterLineLoc[row] = BlackUdisLeftLocation[row].x + RoadHalfWidth;
          }
          //�������2�С�
          else
          {
            //������еķ�ʽ��
            CenterLineLoc[row] = CenterLineLoc[row+1] + CenterLineLoc[row+1] - CenterLineLoc[row+2];            
          }
        }
      }
      
      //һֱ��������С�
      if(row == 0) break;
    }
    
    //��δ������е�����������Чֵ��
    //�ײ�����Чֵ���������ô���
    if(CenterEndLine != CameraHight - 1)
    {
      for(row = CameraHight - 1; ; row--)
      {
        if(row == CenterEndLine) break;       
        CenterLineLoc[row] = MaxValInt16;
      }
    }
    else
    {
    }

    
  }
  //������ȡ�ɹ���������ȡʧ�ܡ�
  else if(BlackLeftDone == 0 && BlackRightDone == 1)
  {
    //�����ߵ���ͷ��β��Ч����ֱ�ӷ���ʧ�ܡ�
    if(BlackRightHeadLine == MaxValUint8 || BlackRightEndLine == MaxValUint8)
    {
      return 0;
    }
    else
    {
    }
       
    flag1 = 1;
    flag2 = 1;
    
    //�����ߵ���βȡ���ߵ���β���ɡ�
    CenterHeadLine = BlackRightHeadLine;   //��ͷȡ���ߵ���ͷ��ע���ⲻ��ʵ�ʵ���ͷ��
    //CenterHeadLine = 0;                    //��ͷ��ΪҪ�̶�������0�У�����ֱ����0.
    CenterEndLine = BlackRightEndLine;
    
    //���ȿ���ͷ�Ƿ����BlackControlLineLow��
    if(BlackRightHeadLine >= BlackControlLineLow)
    {
      flag1 = 0;     
    }
    else
    {
    }
    
    //����βС��CameraHight - 1�С�
    if(BlackRightEndLine < CameraHight - 1)
    {
      //ֻ�����߳ɹ�����������β����ôԶ������û��������ֱ�ӷ���ʧ�ܡ�
      //if(BlackRightEndLine < CameraHight - 1 - BlackRightBackLineStart)
      if(BlackRightEndLine <= BlackControlLineLow)  
      {
        flag2 = 0;
        return 0;
      }
      //����β��һ����Χ�ڡ���������ѵ�59����ǰ�Ƽ��С�ֱ��ȡBlackRightEndLine��
      else
      {
      }
    }
    //����β����CameraHight - 1��ֱ��ȡBlackRightEndLine
    else
    {
    }
    
    //��ʧ��һ���ߵ�ʱ���ȸ���б�ʹ���������û����һ��˫��ͼ��ʱ������������ֱ������һ��˫�ߵ��������
    //��5�е�б�ʡ�
    if(BlackRightEndLine - BlackRightHeadLine > 5)
    {
      slope = 1.0 * (BlackUdisRightLocation[BlackRightEndLine].x - BlackUdisRightLocation[BlackRightEndLine-4].x) / 
                    (BlackUdisRightLocation[BlackRightEndLine].y - BlackUdisRightLocation[BlackRightEndLine-4].y);
    }
    else
    {
      slope = 0;
    }
    //�������
    temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
    //ȡ���ֵ
    RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
    
    tempflag1 = 0;
    tempway1 = 0;
    //����������ȹ��Ƴ������ߵ���ͷ��
    CenterLineLoc[BlackRightEndLine] = BlackUdisRightLocation[BlackRightEndLine].x - RoadHalfWidth;
    //�������ߵ����ƹ��Ƴ������ߡ��������Ǹ�int16�;�����������
    for(row = BlackRightEndLine - 1; ;row--)
    {
      //������Чʱ���������ߵ����Ʋ��ߡ�
      if(BlackRightLoc[row][0] != MaxValUint8)
      {
        tempflag1 = 0;
        CenterLineLoc[row] = CenterLineLoc[row+1] + BlackUdisRightLocation[row].x - BlackUdisRightLocation[row+1].x;
      }
      //������Чʱ������������е����������Ʋ��ߡ�
      else
      {
          //��������Чʱ�����Բ�������������Ʋ��ߣ�Ҳ���Ը������CenterForwardLineNum����С���˷����Ʋ��ߡ�
          if(tempflag1 == 0)
          {
            //ÿ��ͼֻ����һ�Σ�����ȷ�����߷�ʽ���Ժ�Ͳ����ٽ����ˡ�
            tempflag1 = 1;
            //������������࣬���Բ�����С���˷��ķ�ʽ��
            if(row + CenterForwardLineNum <= CameraHight - 1)
            {
              tempway1 = 0;
              //������С���˷�ϵ���ļ��㡣
              for(i = 0; i < CenterForwardLineNum; i++)
              {
                x[i] = row + i + 1;
                y[i] = CenterLineLoc[row + i + 1];
              }
              a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
              a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣
            }
            //����е����������࣬��������������Ʋ��ߵķ�ʽ��
            else
            {
              tempway1 = 1;
            }
          }
          else
          {
          }
        
          //ȷ�ϲ��߷�ʽ�󣬿�ʼ���ߡ�
          if(tempway1 == 0)
          {
            //��С���˷��ķ�ʽ��
            CenterLineLoc[row] = (a0 + a1 * row) / LeastSquareMulti;
          }
          else
          {
            //���2�С�
            if(row == CameraHight - 1 || row == CameraHight - 2)
            {
              CenterLineLoc[row] = BlackUdisRightLocation[row].x - RoadHalfWidth;
            }
            //�������2�С�
            else
            {
              //������еķ�ʽ��
              CenterLineLoc[row] = CenterLineLoc[row+1] + CenterLineLoc[row+1] - CenterLineLoc[row+2];
            }
          }
        }
      
        if(row == 0) break;
      }
    
      
    
    //��δ������е�����������Чֵ��
    //�ײ�����Чֵ���������ô���
    if(CenterEndLine != CameraHight - 1)
    {
      for(row = CameraHight - 1; ; row--)
      {
        if(row == CenterEndLine) break;       
        CenterLineLoc[row] = MaxValInt16;
      }
    }
    else
    {
    }
   
  }
  //�����߾���ȡ�ɹ���
  else if(BlackLeftDone == 1 && BlackRightDone == 1)
  {
    CenterHeadLine = MinRe(BlackLeftHeadLine, BlackRightHeadLine);    //��ͷȡ���߽�С�ߡ�     
    //CenterHeadLine = 0;    //��Ϊ�̶�Ҫ������0�У����Թ̶�ȡ0.
    //��βȡ���߽ϴ��ߡ�
    CenterEndLine = MaxRe(BlackLeftEndLine, BlackRightEndLine);             
    
    //���ǵ��ߵ������
    if(SingleBlackAllFlag == 0)
    {
    
      //�����߾���ȡ�ɹ�����ѡ�������ߵ������ߣ�ʵ�ڲ����ٸ���������ȹ��ơ�
      //������������Ԥ�⣬��Ϊ��������������Ѿ��������߲��ɶ�ֵ�ˣ����Բ�����ô�鷳��    
      
      //�ȼ�����ߣ����߲����������ټ�����ߡ����߲������ٷ���ʧ�ܡ�
      flag1 = 1;
      flag2 = 1;
      flag3 = 1;
      flag4 = 1;
      //ȡ�������ߵĵ�39����59�еĲȡ���ֵ��
      //���ȿ���ͷ�Ƿ����39�У�����39�о�ֱ�ӷ���ʧ�ܡ�
      if(BlackLeftHeadLine >= BlackControlLineLow)
      {
        flag1 = 0;
      }
      else
      {
      }
      //����βС��CameraHight - 1�С�
      if(BlackLeftEndLine < CameraHight - 1)
      {
        //ֻ�����߳ɹ�����������β����ôԶ������û���������������ǲ���һ���������
        //if(BlackLeftEndLine < CameraHight - 1 - BlackLeftBackLineStart)
        if(BlackLeftEndLine <= BlackControlLineLow)
        {
          flag2 = 0;
        }
        //����β��һ����Χ�ڡ���������ѵ�59����ǰ�Ƽ��С�ֱ��ȡBlackLeftEndLine��
        else
        {
        }
      }
      //����β����CameraHight - 1��ֱ��ȡBlackLeftEndLine
      else
      {
      }
  
      //�������ߣ����߲�������������ֱ�ӷ���ʧ�ܡ�
      //���ȿ���ͷ�Ƿ����39�У�����39�о�ֱ�ӷ���ʧ�ܡ�
      if(BlackRightHeadLine >= BlackControlLineLow)
      {
        flag3 = 0;
      }
      else
      {
      }    
      //����βС��CameraHight - 1�С�
      if(BlackRightEndLine < CameraHight - 1)
      {
        //ֻ�����߳ɹ�����������β����ôԶ������û��������ֱ�ӷ���ʧ�ܡ�
        //if(BlackRightEndLine < CameraHight - 1 - BlackRightBackLineStart)
        if(BlackRightEndLine <= BlackControlLineLow)
        {
          flag4 = 0;
          //���ζ���β��Զ��ֱ�ӷ���ʧ�ܡ�
          if(flag2 == 0) 
          {
            return 0;
          }
          else
          {
          }
        }
        //����β��һ����Χ�ڡ���������ѵ�59����ǰ�Ƽ��С�ֱ��ȡBlackRightEndLine��
        else
        {
        }
      }
      //����β����CameraHight - 1��ֱ��ȡBlackRightEndLine
      else
      {
      }
      
      //ֻ����������Ҫ����ֱ��ȡ���ߵ��в�ֵ����ֵ��
      if(
        (flag3 == 1 && flag4 == 1)
      &&((flag1 == 0 && flag2 == 0) || (flag1 == 1 && flag2 == 0) || (flag1 == 0 && flag2 == 1))
        )
      {
        //б�ʵķ�ʽ������������
        //��5�е�б�ʡ�
        if(BlackRightEndLine - BlackRightHeadLine > 5)
        {
          slope = 1.0 * (BlackUdisRightLocation[BlackRightEndLine].x - BlackUdisRightLocation[BlackRightEndLine-4].x) / 
                        (BlackUdisRightLocation[BlackRightEndLine].y - BlackUdisRightLocation[BlackRightEndLine-4].y);
        }
        else
        {
          slope = 0;
        }
        //�������
        temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
        RoadHalfWidthCompen = RoadHalfWidth / temp;
        RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
      }
      //ֻ����������Ҫ����ֱ��ȡ���ߵ��в�ֵ����ֵ��
      else if(
             (flag1 == 1 && flag2 == 1)
           &&((flag3 == 0 && flag4 == 0) || (flag3 == 1 && flag4 == 0) || (flag3 == 0 && flag4 == 1))
             )
      {
        //б�ʵķ�ʽ������������
        //��5�е�б�ʡ�
        if(BlackLeftEndLine - BlackLeftHeadLine > 5)
        {
          slope = 1.0 * (BlackUdisLeftLocation[BlackLeftEndLine].x - BlackUdisLeftLocation[BlackLeftEndLine-4].x) / 
                        (BlackUdisLeftLocation[BlackLeftEndLine].y - BlackUdisLeftLocation[BlackLeftEndLine-4].y);
        }
        else
        {
          slope = 0;
        }
        //�������
        temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
        RoadHalfWidthCompen = RoadHalfWidth / temp;
        RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
      }
      //�����߾�������������ȡ�в�ֵ����ֵ�ϴ�ġ�
      else if(flag1 == 1 && flag2 == 1 && flag3 == 1 && flag4 == 1)
      {
        //б�ʵķ�ʽ������������
        //��5�е�б�ʡ�
        if(BlackLeftEndLine - BlackLeftHeadLine > 5)
        {
          slope = 1.0 * (BlackUdisLeftLocation[BlackLeftEndLine].x - BlackUdisLeftLocation[BlackLeftEndLine-4].x) / 
                        (BlackUdisLeftLocation[BlackLeftEndLine].y - BlackUdisLeftLocation[BlackLeftEndLine-4].y);
        }
        else
        {
          slope = 0;
        }
        //�������
        temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
        
        //��5�е�б�ʡ�
        if(BlackRightEndLine - BlackRightHeadLine > 5)
        {
          slope = 1.0 * (BlackUdisRightLocation[BlackRightEndLine].x - BlackUdisRightLocation[BlackRightEndLine-4].x) / 
                        (BlackUdisRightLocation[BlackRightEndLine].y - BlackUdisRightLocation[BlackRightEndLine-4].y);
        }
        else
        {
          slope = 0;
        }
        //�������
        temp = MaxRe((uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2), temp);
        RoadHalfWidthCompen = RoadHalfWidth / temp;
        RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
      }
      //�����߾�������Ҫ��
      else
      {
        //�����߶��ڵ�BlackControlLineLow�е�Զ����ֱ�ӷ���ʧ�ܡ�
        if(flag2 == 0 && flag4 == 0)
        {
          return 0;
        }
        else
        {
          //�����ڵ�BlackControlLineLow�еĽ����������ڵ�BlackControlLineLow�е�Զ����������������
          if(flag1 == 1 && flag3 == 0)
          {
            //б�ʵķ�ʽ������������
            //��5�е�б�ʡ�
            if(BlackLeftEndLine - BlackLeftHeadLine > 5)
            {
              slope = 1.0 * (BlackUdisLeftLocation[BlackLeftEndLine].x - BlackUdisLeftLocation[BlackLeftEndLine-4].x) / 
                            (BlackUdisLeftLocation[BlackLeftEndLine].y - BlackUdisLeftLocation[BlackLeftEndLine-4].y);
            }
            else
            {
              slope = 0;
            }
            //�������
            temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
            RoadHalfWidthCompen = RoadHalfWidth / temp;
            RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
          }
          //�����ڵ�BlackControlLineLow�еĽ����������ڵ�BlackControlLineLow�е�Զ����������������
          else if(flag1 == 0 && flag3 == 1)
          {
            //б�ʵķ�ʽ������������
            //��5�е�б�ʡ�
            if(BlackRightEndLine - BlackRightHeadLine > 5)
            {
              slope = 1.0 * (BlackUdisRightLocation[BlackRightEndLine].x - BlackUdisRightLocation[BlackRightEndLine-4].x) / 
                            (BlackUdisRightLocation[BlackRightEndLine].y - BlackUdisRightLocation[BlackRightEndLine-4].y);
            }
            else
            {
              slope = 0;
            }
            //�������
            temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
            RoadHalfWidthCompen = RoadHalfWidth / temp;
            RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
          }
          //�����߶��ڵ��еĽ�������ȡ�ϴ�ֵ��
          else if(flag1 == 0 && flag3 == 0)
          {
            //б�ʵķ�ʽ������������
            //��5�е�б�ʡ�
            if(BlackLeftEndLine - BlackLeftHeadLine > 5)
            {
              slope = 1.0 * (BlackUdisLeftLocation[BlackLeftEndLine].x - BlackUdisLeftLocation[BlackLeftEndLine-4].x) / 
                            (BlackUdisLeftLocation[BlackLeftEndLine].y - BlackUdisLeftLocation[BlackLeftEndLine-4].y);
            }
            else
            {
              slope = 0;
            }
            //�������
            temp = (uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2);
            
            //��5�е�б�ʡ�
            if(BlackRightEndLine - BlackRightHeadLine > 5)
            {
              slope = 1.0 * (BlackUdisRightLocation[BlackRightEndLine].x - BlackUdisRightLocation[BlackRightEndLine-4].x) / 
                            (BlackUdisRightLocation[BlackRightEndLine].y - BlackUdisRightLocation[BlackRightEndLine-4].y);
            }
            else
            {
              slope = 0;
            }
            //�������
            temp = MaxRe((uint8)(1.0 * sqrt(slope * slope + 1) * RoadWidth / 2), temp);
            RoadHalfWidthCompen = RoadHalfWidth / temp;
            RoadHalfWidth = MaxRe(temp, RoadHalfWidth);
          }
          //�����ϲ������ߵ����
          else
          {
            return 0;
          }
        }
      }
      
      uint8 temproad;  //����ͼ�����һ��˫����Ч·��������ͼ�ĵ��߲����á�
      temproad = RoadHalfWidth;
      
      tempflag1 = 0;
      tempway1 = 0;      
      //��������Ѿ���ã����ڿ�ʼ�ӵ͵����������ߡ�
      for(row = CenterEndLine; ; row--)
      {
        //��ǰ�����Һ��߾���Ч���������Ч������Udis���飬ֻ����ԭʼ�ĺ��ߴ������顣
        if(BlackLeftLoc[row][0] != MaxValUint8 && BlackRightLoc[row][0] != MaxValUint8)
        {
          tempflag1 = 0;
          //ȡ���Һ��ߵ�ƽ��ֵ��
          CenterLineLoc[row] = (BlackUdisLeftLocation[row].x + BlackUdisRightLocation[row].x) / 2;
          //ȡ���һ��������Ч���е����������Ϊ���µ��������
          if(BlackUdisLeftLocation[row].x > BlackUdisRightLocation[row].x)
          {
            RoadHalfWidthRecord[row] = (BlackUdisLeftLocation[row].x - BlackUdisRightLocation[row].x) / 2;           
          }
          else
          {
            RoadHalfWidthRecord[row] = (BlackUdisRightLocation[row].x - BlackUdisLeftLocation[row].x) / 2;
          }
          
          //����ͼ�����һ��˫����Ч·��������ͼ�ĵ��߲����á�
          temproad = RoadHalfWidthRecord[row];
          //��������¼.���CameraHight - 1�е������������һ��ͼ�á�
          //�³����⣬�޸�����
          if(row == CameraHight - 1) 
          {  
            if(RoadHalfWidthRecord[row] > RoadHalfWidthLimitMax)
            {
              RoadHalfWidth = RoadHalfWidthLimitMax;
            }
            else if(RoadHalfWidthRecord[row] < RoadHalfWidthLimitMin)
            {
              RoadHalfWidth = RoadHalfWidthLimitMin;
            }
            else
            {
              RoadHalfWidth = RoadHalfWidthRecord[row];
            }            
          }
          else
          {
          }
        }
        //������Ч��������Ч���������м���һ���������
        else if(BlackLeftLoc[row][0] != MaxValUint8 && BlackRightLoc[row][0] == MaxValUint8)
        {
          tempflag1 = 0;
          CenterLineLoc[row] = BlackUdisLeftLocation[row].x + temproad;
        }
        //������Ч��������Ч���������м�ȥһ���������
        else if(BlackLeftLoc[row][0] == MaxValUint8 && BlackRightLoc[row][0] != MaxValUint8)
        {
          tempflag1 = 0;
          CenterLineLoc[row] = BlackUdisRightLocation[row].x - temproad;
        }
        //�����о���Ч���������������߾�����ǰ�ߡ�
        else if(BlackLeftLoc[row][0] == MaxValUint8 && BlackRightLoc[row][0] == MaxValUint8)
        {
          //�������߾���Чʱ�����Բ�������������Ʋ��ߣ�Ҳ���Ը������CenterForwardLineNum����С���˷����Ʋ��ߡ�
          if(tempflag1 == 0)
          {
            //ÿ��ͼֻ����һ�Σ�����ȷ�����߷�ʽ���Ժ�Ͳ����ٽ����ˡ�
            //�����ֳ�������Һ�����Ч����������ٴ�ˢ��б�ʡ�
            tempflag1 = 1;
            //������������࣬���Բ�����С���˷��ķ�ʽ��
            if(row + CenterForwardLineNum <= CameraHight - 1)
            {
              tempway1 = 0;
              //������С���˷�ϵ���ļ��㡣
              for(i = 0; i < CenterForwardLineNum; i++)
              {
                x[i] = row + i + 1;
                y[i] = CenterLineLoc[row + i + 1];
              }
              a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
              a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣
            }
            //����е����������࣬��������������Ʋ��ߵķ�ʽ��
            else
            {
              tempway1 = 1;
            }
          }
          else
          {
          }
          
          //ȷ�ϲ��߷�ʽ�󣬿�ʼ���ߡ�
          if(tempway1 == 0)
          {
            //��С���˷��ķ�ʽ��
            CenterLineLoc[row] = (a0 + a1 * row) / LeastSquareMulti;
          }
          else
          {
            //������еķ�ʽ��
            CenterLineLoc[row] = CenterLineLoc[row+1] + CenterLineLoc[row+1] - CenterLineLoc[row+2];
          }
          
        }
        //�����ϲ����ߵ����
        else
        {
        }
        
        if(row == 0) break;
      }
         
      //��δ������е�����������Чֵ���Զ����Ĳ�������
      //�ײ�����Чֵ��
      if(CenterEndLine != CameraHight - 1)
      {
        for(row = CameraHight - 1; ; row--)
        {
          if(row == CenterEndLine) break;       
          CenterLineLoc[row] = MaxValInt16;
        }
      }
      else
      {
      }
      
      //���ߴ�����ʱ�����
      /*
      uint8 temphead;
      
      //��鵥�ߴ������ж��ǲ���һ�߳�ʼ�й��ߣ�һ�߳�ʼ�й��ͣ������ǣ�ֱ��������ʡʱ�䡣
      if(BlackLeftStep1ScanRow <= CameraHight - 3 && BlackRightStep1ScanRow >= CameraHight - 3)
      {
        //˫�߶��ɼ�����ʱ��������Ҫ���һ����������ǲ�����ȷ��
        //��һ���������Ч˫�к̣ܶ����ҷ�Χ�ڴ�����������С�ĵ㡣
        for(i = 0; ; i++)
        {
          if(RoadHalfWidthRecord[i] != MaxValUint8)
          {
            temphead = i;
            break;
          }
          
          //�����ϲ������ߵ�����
          if(i == CameraHight - 1) return 1;  //�޷���ⵥ�ߴ��󣬷���1.
        }
        
        //�����ǲ��ǹ�С��
        if(BlackLeftStep1ScanRow > temphead && BlackLeftStep1ScanRow - temphead < RoadHalfWidthSingleGapLine)
        {
          for(i = BlackLeftStep1ScanRow; ; i--)
          {
            if(RoadHalfWidthRecord[i] < RoadHalfWidthSingleLimit)
            {
              //���ڰ���С���У�ֱ���õ��ߴ����־λ�� 
              RoadHalfWidthWrongDir = 0;          //���ߴ���ʱ�������ա�
              RoadHalfWidthWrongFlag = 1;
              break;
            }            
            //�����ڰ���С���У����������еڶ�������ļ�⡣
            if(i == temphead)
            {
              break;
            }
          }
          
        }
        
        //��һ�����û�м������Ļ����ͼ��ڶ��������
        if(RoadHalfWidthWrongFlag == 2)
        {
          for(i = CameraHight - 1; ; i--)
          {
            //ֻҪ��Ч��˫�������κ�һ��������������ֵ�����ж�Ϊ���ǵ��ߴ���
            if(RoadHalfWidthRecord[i] != MaxValUint8 && RoadHalfWidthRecord[i] > RoadHalfWidthSingleLimit)
            {
              RoadHalfWidthWrongFlag = 0;
              break;
            }
            else
            {
            }
            
            //ֱ�����һ����Ȼ���������������ж�Ϊ���ߴ���
            if(i == 0)
            {
              RoadHalfWidthWrongDir = 0;          //���ߴ���ʱ�������ա�
              RoadHalfWidthWrongFlag = 1;
              break;
            }
            else
            {          
            }
          }
        }
        else
        {
        }        
      }
      else if(BlackRightStep1ScanRow <= CameraHight - 3 && BlackLeftStep1ScanRow >= CameraHight - 3)
      {
        //˫�߶��ɼ�����ʱ��������Ҫ���һ����������ǲ�����ȷ��
        //��һ���������Ч˫�к̣ܶ����ҷ�Χ�ڴ�����������С�ĵ㡣
        for(i = 0; ; i++)
        {
          if(RoadHalfWidthRecord[i] != MaxValUint8)
          {
            temphead = i;
            break;
          }
          
          //�����ϲ������ߵ�����
          if(i == CameraHight - 1) return 1;  //�޷���ⵥ�ߴ��󣬷���1.
        }
        
        //�����ǲ��ǹ�С��
        if(BlackRightStep1ScanRow > temphead && BlackRightStep1ScanRow - temphead < RoadHalfWidthSingleGapLine)
        {
          for(i = BlackRightStep1ScanRow; ; i--)
          {
            if(RoadHalfWidthRecord[i] < RoadHalfWidthSingleLimit)
            {
              //���ڰ���С���У�ֱ���õ��ߴ����־λ�� 
              RoadHalfWidthWrongDir = 1;          //���ߴ���ʱ�������ա�
              RoadHalfWidthWrongFlag = 1;
              break;
            }            
            //�����ڰ���С���У����������еڶ�������ļ�⡣
            if(i == temphead)
            {
              break;
            }
          }
          
        }
        
        //��һ�����û�м������Ļ����ͼ��ڶ��������
        if(RoadHalfWidthWrongFlag == 2)
        {
          for(i = CameraHight - 1; ; i--)
          {
            //ֻҪ��Ч��˫�������κ�һ��������������ֵ�����ж�Ϊ���ǵ��ߴ���
            if(RoadHalfWidthRecord[i] != MaxValUint8 && RoadHalfWidthRecord[i] > RoadHalfWidthSingleLimit)
            {
              RoadHalfWidthWrongFlag = 0;
              break;
            }
            else
            {
            }
            
            //ֱ�����һ����Ȼ���������������ж�Ϊ���ߴ���
            if(i == 0)
            {
              RoadHalfWidthWrongDir = 1;          //���ߴ���ʱ�������ա�
              RoadHalfWidthWrongFlag = 1;
              break;
            }
            else
            {          
            }
          }
        }
        else
        {
        }
        
      }
      //��ʼ�в���������������Ҫ��ⵥ�ߴ���
      else
      {      
      }
      
      //���ߴ���Ĵ�����ʱ�򵥴���Ϊ�����ߴ���Ҳ����ͼ�����Ϊ����ɨ����㱣��ԭ״��
      if(RoadHalfWidthWrongFlag == 1)
      {        
        RoadHalfWidth = RoadHalfWidthLast;  //��ε����������Ч����ԭΪ�Ϸ�ͼ�����յ��������
        //һ�ߵ����Ǵ���ġ�
        if(RoadHalfWidthWrongDir == 0)
        {
          BlackLeftDone = 0;
        }
        else
        {
          BlackRightDone = 0;
        }
        CenterLineGetSingleWrongAdd();      //��Ե��ߴ�������������´���
      }
      else
      {        
      }
      */
      
    }
    //���ߵ������Ҳ����SingleBlackAllFlag==1�������
    else
    {
      tempflag1 = 0;
      tempway1 = 0;
      
      //��������Ѿ���ã����ڿ�ʼ�ӵ͵����������ߡ�
      for(row = CenterEndLine; ; row--)
      {
        //��ǰ�����Һ��߾���Ч���������Ч������Udis���飬ֻ����ԭʼ�ĺ��ߴ������顣
        if(BlackLeftLoc[row][0] != MaxValUint8 && BlackRightLoc[row][0] != MaxValUint8)
        {
          tempflag1 = 0;
          //ȡ���Һ��ߵ�ƽ��ֵ��
          CenterLineLoc[row] = (BlackUdisLeftLocation[row].x + BlackUdisRightLocation[row].x) / 2;
          //ȡ���һ��������Ч���е����������Ϊ���µ��������
          if(BlackUdisLeftLocation[row].x > BlackUdisRightLocation[row].x)
          {
            RoadHalfWidthSingle = (BlackUdisLeftLocation[row].x - BlackUdisRightLocation[row].x) / 2;
          }
          else
          {
            RoadHalfWidthSingle = (BlackUdisRightLocation[row].x - BlackUdisLeftLocation[row].x) / 2;
          }        
        }
        //������Ч��������Ч���������м���һ���������
        else if(BlackLeftLoc[row][0] != MaxValUint8 && BlackRightLoc[row][0] == MaxValUint8)
        {
          tempflag1 = 0;
          CenterLineLoc[row] = BlackUdisLeftLocation[row].x - RoadHalfWidthSingle;    //��Ϊ�ǵ��ߣ������Ǽ��š�
        }
        //������Ч��������Ч���������м�ȥһ���������
        else if(BlackLeftLoc[row][0] == MaxValUint8 && BlackRightLoc[row][0] != MaxValUint8)
        {
          tempflag1 = 0;
          CenterLineLoc[row] = BlackUdisRightLocation[row].x + RoadHalfWidthSingle;   //��Ϊ�ǵ��ߣ������ǼӺš�
        }
        //�����о���Ч���������������߾�����ǰ�ߡ�
        else if(BlackLeftLoc[row][0] == MaxValUint8 && BlackRightLoc[row][0] == MaxValUint8)
        {
          //�������߾���Чʱ�����Բ�������������Ʋ��ߣ�Ҳ���Ը������CenterForwardLineNum����С���˷����Ʋ��ߡ�
          if(tempflag1 == 0)
          {
            //ÿ��ͼֻ����һ�Σ�����ȷ�����߷�ʽ���Ժ�Ͳ����ٽ����ˡ�
            //�����ֳ�������Һ�����Ч����������ٴ�ˢ��б�ʡ�
            tempflag1 = 1;
            //������������࣬���Բ�����С���˷��ķ�ʽ��
            if(row + CenterForwardLineNum <= CameraHight - 1)
            {
              tempway1 = 0;
              //������С���˷�ϵ���ļ��㡣
              for(i = 0; i < CenterForwardLineNum; i++)
              {
                x[i] = row + i + 1;
                y[i] = CenterLineLoc[row + i + 1];
              }
              a1 = LeastSquareInt16a1(x, y, CenterForwardLineNum);         //б�ʼ��㡣
              a0 = LeastSquareInt16a0(x, y, a1, CenterForwardLineNum);     //�ݽؾ���㡣
            }
            //����е����������࣬��������������Ʋ��ߵķ�ʽ��
            else
            {
              tempway1 = 1;
            }
          }
          else
          {
          }
          
          //ȷ�ϲ��߷�ʽ�󣬿�ʼ���ߡ�
          if(tempway1 == 0)
          {
            //��С���˷��ķ�ʽ��
            CenterLineLoc[row] = (a0 + a1 * row) / LeastSquareMulti;
          }
          else
          {
            //������еķ�ʽ��
            CenterLineLoc[row] = CenterLineLoc[row+1] + CenterLineLoc[row+1] - CenterLineLoc[row+2];
          }
          
        }
        //�����ϲ����ߵ����
        else
        {
        }
        
        if(row == 0) break;
      }
         
      //��δ������е�����������Чֵ���Զ����Ĳ�������
      //�ײ�����Чֵ��
      if(CenterEndLine != CameraHight - 1)
      {
        for(row = CameraHight - 1; ; row--)
        {
          if(row == CenterEndLine) break;       
          CenterLineLoc[row] = MaxValInt16;
        }
      }
      else
      {
      }
    }
  }
  //�����ϲ����ߵ����
  else
  {
    //���Һ��߾���ȡʧ�ܣ�����0.
    return 0;
  }
  
  return 1;
}





//��������ȡʱ����������ƫ�����ֵ����ȡ�������ȵĺ�����
//valΪ��39�����59����ƫ��ľ���ֵ��
//���ع��Ƴ������������ȡ�
uint8 CenterLineHalfWidthGet(uint8 val)
{
  uint8 temphalfwidth;
  
  if(val <= 25)
  {
    temphalfwidth = 100;
  }
  else
  {
    if(val <= 30)
    {
      //temphalfwidth = 95;
      temphalfwidth = 110;
    }
    else
    {
      if(val <= 35)
      {
        //temphalfwidth = 105;
        temphalfwidth = 120;
      }
      else
      {
          //temphalfwidth = 110;
          temphalfwidth = 130;
      }
    }
  }
  
  return temphalfwidth;
}




//ͼ�����¸�ֵ������ͷ��ת�汾��
void ImgReversePut(void)
{

    uint16 i, j, k, temp1, temp2;   
    
    temp1 = CameraRealLeftCol;
    temp2 = CameraRealLeftCol + CameraRealWidth;
    //temp1 = CameraWidth/2 - CameraRealWidth/2 - 1;
    //temp2 = CameraWidth/2 + CameraRealWidth/2 - 1;
    
    if (ImgPresent == ImgNO1)    //�����ǰ�ǵ�1��ͼ�����ڽ������ݣ�����2��ͼ�������ɣ�
    {
      for(i = 0; i < CameraHight; i++)
      {
        k = 0;
        for(j = temp1; j < temp2; j++)
        {
          ImgNew[CameraHight-1-i][CameraRealWidth-1-k] = ImgStore2[i][j];
          k++;
        }
      }
    }
    else if (ImgPresent == ImgNO2)  //�����ǰ�ǵ�2��ͼ�����ڽ������ݣ�����1��ͼ�������ɣ�
    {
      for(i = 0; i < CameraHight; i++)
      {
        k = 0;
        for(j = temp1; j < temp2; j++)
        {
          ImgNew[CameraHight-1-i][CameraRealWidth-1-k] = ImgStore1[i][j];
          k++;
        }
      }
    }
    else 
    {
        //uart_sendN(UART0, (uint8 *)"\nError In FieldIsr()!", 21);   //���󾯸�
    }
  
}



//ͼ�����¸�ֵ,�в��䣨����DMA�б仯��ѡȡ��Ҫ���У������޷���DMA�б仯����������仯��
///////////////////////////////////////////��������Ҫ��ʾ��������һ��ʱ�䣬���ǲ��Ǻķ���̫��ʱ�䡣
void ImgPut(void)
{
    uint16 i, j, k, temp1, temp2;   
    
    temp1 = CameraRealLeftCol;
    temp2 = CameraRealLeftCol + CameraRealWidth;
    //temp1 = CameraWidth/2 - CameraRealWidth/2 - 1;
    //temp2 = CameraWidth/2 + CameraRealWidth/2 - 1;
    
    if (ImgPresent == ImgNO1)    //�����ǰ�ǵ�1��ͼ�����ڽ������ݣ�����2��ͼ�������ɣ�
    {
      for(i = 0; i < CameraHight; i++)
      {
        k = 0;
        for(j = temp1; j < temp2; j++)
        {
          ImgNew[i][k] = ImgStore2[i][j];
          k++;
        }
      }
    }
    else if (ImgPresent == ImgNO2)  //�����ǰ�ǵ�2��ͼ�����ڽ������ݣ�����1��ͼ�������ɣ�
    {
      for(i = 0; i < CameraHight; i++)
      {
        k = 0;
        for(j = temp1; j < temp2; j++)
        {
          ImgNew[i][k] = ImgStore1[i][j];
          k++;
        }
      }
    }
    else 
    {
        //uart_sendN(UART0, (uint8 *)"\nError In FieldIsr()!", 21);   //���󾯸�
    }

}





//��������ɢ����ȡ�������������ɢ�̶ȣ��������ߵġ�
void ErrorGet(void)
{
  uint8 row;
  uint8 avg = 0;
  float temp;
  uint8 index;
  //��ȡƽ��ֵ
  temp = 0;
  index = 0;
  for(row = CameraHight - 1; ; row--)
  {
    if(CenterLineLoc[row] != MaxValUint8)
    {
      temp += CenterLineLoc[row];
      index++;
    }
    if(row == 0) break;
  }
  avg = (uint8)(temp / index);
  /*
  //1. ��ȡ��ͷ
  for(row = CameraHight - 1; ; row--)
  {
    if(CenterLineLoc[row] != MaxValUint8)
    {
      avg = CenterLineLoc[row];
      break;
    }
    if(row == 0) break;
  }
  //2. ������ƽ��
  for(row--; ; row--)
  {
    if(CenterLineLoc[row] != MaxValUint8)
    {
      avg = (avg + CenterLineLoc[row]) / 2;
    }
    if(row == 0) break;    
  }
  */
  

  temp = 0;
  index = 0;
  for(row = CameraHight - 1; ; row--)
  {
    if(CenterLineLoc[row] != MaxValUint8)
    {
      temp += AbsRe(CenterLineLoc[row], avg);
      index++;
    }
    if(row == 0) break;
  }
  ErrorGetSelf = (uint8)(temp / index);
  ErrorGetCen = AbsRe(avg, PhyCenterCol);
  
}



//����������
//��������������ȥ����uint16�͵ģ������ҵ��õ�ʱ��ֻ���õ�uint8�͵ģ��Ҳ��ᳬ��255.
uint16 MathSqrt(uint16 x1)
{
  uint8 ans = 0, p = 0x80;
  uint16 x = x1;
  
  while(p!=0)
  {
    ans += p;
    if(ans * ans > x) ans -=p;
    p = (uint8)(p / 2);
  }
  return ans;  
}

//���ߵ�������ȡ���������ҹգ�����Ϊ˳ʱ�뷽��ֲ���������Ϊ������������գ�����Ϊ��ʱ�ӷ���ֲ���������Ϊ��
//K = 4*SABC/AB/BC/AC
int16 CurveGet(int16 AX, uint8 AY, int16 BX, uint8 BY, int16 CX, uint8 CY)
{
  int16 SABC_temp; //�����ε��������������
  int16 tempab, tempbc, tempac;
  int16 AB, BC, AC; //�����εı߳�����Ϊ����
  int16 result;
  //int16 K;        //���ʽ������������
  
  SABC_temp = ((BX - AX) * (CY - AY) - (CX - AX) * (BY - AY));
  
  tempab = (BX - AX) * (BX - AX) + (BY - AY) * (BY - AY);
  if(tempab > 100) 
  {
    AB = MathSqrt(tempab / 100) * 10; //ʧ����λ�ľ��ȣ���Ϊ������㷶Χ�����ơ�
  }
  else
  {
    AB = MathSqrt(tempab);
  }
  
  tempbc = (BX - CX) * (BX - CX) + (BY - CY) * (BY - CY);
  if(tempbc > 100) 
  {
    BC = MathSqrt(tempbc / 100) * 10; //ʧ����λ�ľ��ȣ���Ϊ������㷶Χ�����ơ�
  }
  else
  {
    BC = MathSqrt(tempbc);
  }
  
  tempac = (CX - AX) * (CX - AX) + (CY - AY) * (CY - AY);
  if(tempac > 100) 
  {
    AC = MathSqrt(tempac / 100) * 10; //ʧ����λ�ľ��ȣ���Ϊ������㷶Χ�����ơ�
  }
  else
  {
    AC = MathSqrt(tempac);
  }
  
  result = CurveGetCompen * SABC_temp / AB / BC / AC;
  if(result >= MaxValUint8) 
  {
    result = MaxValUint8 - 1;           //���ܴ��MaxValUint8
  }
  else if(result + MaxValUint8 < 0)
  {
    result = 1 - MaxValUint8;           //����С��-MaxValUint8
  }
  else
  {
  }
  
  return result;
}



//SABC�������ȡ��˳ʱ���򷵻ظ�ֵ����ʱ���򷵻���ֵ��
//�����½�Ϊԭ�㣬����Ϊx��������(0~249)������Ϊy��������(0~49)��
int16 SABCGet(uint8 x1, uint8 y1, uint8 x2, uint8 y2, uint8 x3, uint8 y3)
{
  int16 SABC_temp;
  
  SABC_temp = ((x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1)) / 2;
  
  return SABC_temp;
}




//�����ߵ����ʺ�б����ȡ
uint8 CurveSlopeGetCenter(void)
{
  uint8 row;
  uint8 temp;
  uint8 tempslopex[3];
  int16 tempslopey[3];
  
  //1. 
  //���ʷ���Ԥ�����㡣
  CurveLineChosenC1 = MaxValUint8;
  CurveLineChosenC2 = MaxValUint8;
  CurveLineChosenC3 = MaxValUint8;
  
  if(CenterHeadLine == MaxValUint8 || CenterEndLine == MaxValUint8)
  {
    CURVEC = MaxValUint8;  //return 0֮ǰҪ����������������Чֵ��
    SlopeC = MaxValInt16;  //return 0֮ǰҪ��������б������Чֵ��
    return 0;
  }
  
  //���ʻ��ڵ���1 CurveLineChosen1���������ߵ���ͷ��
  if(CenterHeadLine >= CameraHight - 2)
  {
    CurveLineChosenC1 = MaxValUint8;  
    CURVEC = MaxValUint8;  //return 0֮ǰҪ����������������Чֵ��
    SlopeC = MaxValInt16;  //return 0֮ǰҪ��������б������Чֵ��
    return 0;    
  }
  else
  {
    CurveLineChosenC1 = CenterHeadLine;    
  }
  
  
  //�ѵ�1����Чֵ��CameraHight-1�ľ���ֳ�2�Ρ�
  temp = (CenterEndLine - 1 - CenterHeadLine) / 2;
  //2 * 2 + 1 = 5, �������Ч��ֻ��3�����ڵĻ����ͷ�����ȡ���ʺ�б�ʡ�����Ϊ��ܲ���ȷ��
  if(temp <= 2) 
  {
    CurveLineChosenC1 = MaxValUint8;
    CURVEC = MaxValUint8;  //return 0֮ǰҪ����������������Чֵ��
    SlopeC = MaxValInt16;  //return 0֮ǰҪ��������б������Чֵ��
    return 0;
  }
  
  //���ʻ��ڵ���2 CurveLineChosen2
  for(row = CurveLineChosenC1 + temp - 1; ; row++)
  {
    if(row > CenterEndLine - 1) 
    {
      CurveLineChosenC1 = MaxValUint8;
      CurveLineChosenC2 = MaxValUint8;
      CURVEC = MaxValUint8;  //return 0֮ǰҪ����������������Чֵ��
      SlopeC = MaxValInt16;  //return 0֮ǰҪ��������б������Чֵ��
      return 0;
    }
    //�����жϸ����ǲ�����Чֵ����Ϊ������������
    CurveLineChosenC2 = row;
    break;
    
  }
  
  //���ʻ��ڵ���3 CurveLineChosen3
  for(row = CurveLineChosenC2 + temp - 1; ; row++)
  {
    if(row > CenterEndLine) 
    {
      CurveLineChosenC1 = MaxValUint8;
      CurveLineChosenC2 = MaxValUint8;
      CurveLineChosenC3 = MaxValUint8;
      CURVEC = MaxValUint8;  //return 0֮ǰҪ����������������Чֵ��
      SlopeC = MaxValInt16;  //return 0֮ǰҪ��������б������Чֵ��      
      return 0;
    }
    //�����жϸ����ǲ�����Чֵ����Ϊ������������
    CurveLineChosenC3 = row;
    break;
  }
  //SABCC�����������������������ȡ
  //SABCC = SABCGet(CenterLineLoc[CurveLineChosenC1], CameraHight - 1 - CurveLineChosenC1,
  //                CenterLineLoc[CurveLineChosenC2], CameraHight - 1 - CurveLineChosenC2,
  //                CenterLineLoc[CurveLineChosenC3], CameraHight - 1 - CurveLineChosenC3
  //                );
  //������ȡ�����ֵ���ᳬ��MaxValUint8;
  CURVEC = CurveGet(CenterLineLoc[CurveLineChosenC1], CameraHight - 1 - CurveLineChosenC1,
                   CenterLineLoc[CurveLineChosenC2], CameraHight - 1 - CurveLineChosenC2,
                   CenterLineLoc[CurveLineChosenC3], CameraHight - 1 - CurveLineChosenC3
                   );
  //������б����ȡ�����Ͻ�Ϊԭ�㣬����X������Y��Ӧ�ò��ᳬ��MaxValUint8
  tempslopex[0] = CurveLineChosenC1;
  tempslopex[1] = CurveLineChosenC2;
  tempslopex[2] = CurveLineChosenC3;
  tempslopey[0] = CenterLineLoc[CurveLineChosenC1];
  tempslopey[1] = CenterLineLoc[CurveLineChosenC2];
  tempslopey[2] = CenterLineLoc[CurveLineChosenC3];
  SlopeC = LeastSquareInt16a1(tempslopex, tempslopey, 3);  //�Ѿ�������LeastSquareMulti����
  
  return 1;
  
}

//����ߵ����ʺ�б����ȡ
uint8 CurveSlopeGetLeft(void)
{
  uint8 row;
  uint8 temp;
  uint8 tempslopex[3];
  int16 tempslopey[3];
  
  //���Һ����п���ֻ��һ����ȡ�ɹ��������ɹ����Ͳ��÷�ʱ���ˡ�
  if(BlackLeftDone == 1)
  {
    //2. ��������ʷ�����ȡ
    //���ʷ���Ԥ�����㡣
    CurveLineChosenL1 = MaxValUint8;
    CurveLineChosenL2 = MaxValUint8;
    CurveLineChosenL3 = MaxValUint8;
    
    //���ʻ��ڵ���1 CurveLineChosen1����������ͷBlackLeftHeadLine.
    if(BlackLeftHeadLine == MaxValUint8 || BlackLeftEndLine == MaxValUint8)
    {
      CURVEL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ���������Чֵ��
      SlopeL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ�б������Чֵ��
      return 0;      
    }
    
    if(BlackLeftHeadLine >= CameraHight - 2)
    {
      CURVEL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ���������Чֵ��
      SlopeL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ�б������Чֵ��
      return 0;      
    }
    else
    {
      CurveLineChosenL1 = BlackLeftHeadLine;
    }

    //�ѵ�1����Чֵ��CameraHight-1�ľ���ֳ�2�Ρ�
    temp = (BlackLeftEndLine - 1 - BlackLeftHeadLine) / 2;
    //2 * 2 + 1 = 5, �������Ч��ֻ��3�����ڵĻ����ͷ�����ȡ���ʺ�б�ʡ�����Ϊ��ܲ���ȷ��
    if(temp <= 2) 
    {
      CurveLineChosenL1 = MaxValUint8;
      CURVEL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ���������Чֵ��
      SlopeL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ�б������Чֵ��      
      return 0;
    }
    
    //���ʻ��ڵ���2 CurveLineChosen2
    for(row = CurveLineChosenL1 + temp - 1; ; row++)
    {
      if (row > BlackLeftEndLine - 1) 
      {
        CurveLineChosenL1 = MaxValUint8;
        CurveLineChosenL2 = MaxValUint8;
        CURVEL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ���������Чֵ��
        SlopeL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ�б������Чֵ��     
        return 0;
      }
      //�����ж��ǲ�����Чֵ����Ϊ�����������
      CurveLineChosenL2 = row;
      break;
    }
    
    //���ʻ��ڵ���3 CurveLineChosen3
    for(row = CurveLineChosenL2 + temp - 1; ; row++)
    {
      if (row > BlackLeftEndLine) 
      {
        CurveLineChosenL1 = MaxValUint8;
        CurveLineChosenL2 = MaxValUint8;
        CurveLineChosenL3 = MaxValUint8;
        CURVEL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ���������Чֵ��
        SlopeL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ�б������Чֵ��        
        return 0;
      }
      //�����ж��ǲ�����Чֵ����Ϊ�����������
      CurveLineChosenL3 = row;
      break;
    }
    //SABCL����������������������ȡ
    //SABCL = SABCGet(BlackLeftLoc[CurveLineChosenL1,0], CameraHight - 1 - CurveLineChosenL1,
    //               BlackLeftLoc[CurveLineChosenL2,0], CameraHight - 1 - CurveLineChosenL2,
    //               BlackLeftLoc[CurveLineChosenL3,0], CameraHight - 1 - CurveLineChosenL3
    //               );
    
//    CURVEL = CurveGet(BlackUdisLeftLocation[CurveLineChosenL1].x, CameraHight - 1 - CurveLineChosenL1,
//                      BlackUdisLeftLocation[CurveLineChosenL2].x, CameraHight - 1 - CurveLineChosenL2,
//                      BlackUdisLeftLocation[CurveLineChosenL3].x, CameraHight - 1 - CurveLineChosenL3
//                      );
    
    CURVEL = CurveGet(BlackLeftLoc[CurveLineChosenL1][0], CameraHight - 1 - CurveLineChosenL1,
                      BlackLeftLoc[CurveLineChosenL2][0], CameraHight - 1 - CurveLineChosenL2,
                      BlackLeftLoc[CurveLineChosenL3][0], CameraHight - 1 - CurveLineChosenL3
                      );
    //�����б����ȡ�����Ͻ�Ϊԭ�㣬����X������Y��
    tempslopex[0] = CurveLineChosenL1;
    tempslopex[1] = CurveLineChosenL2;
    tempslopex[2] = CurveLineChosenL3;
    tempslopey[0] = BlackUdisLeftLocation[CurveLineChosenL1].x;
    tempslopey[1] = BlackUdisLeftLocation[CurveLineChosenL2].x;
    tempslopey[2] = BlackUdisLeftLocation[CurveLineChosenL3].x;
    SlopeL = LeastSquareInt16a1(tempslopex, tempslopey, 3);   //�Ѿ�������LeastSquareMulti����
    
    return 1;
  }
  //�������ȡʧ�ܣ�ֱ�ӷ���ʧ�ܡ�
  else
  {
    CURVEL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ���������Чֵ��
    SlopeL = MaxValInt16;       //return 0֮ǰ��Ҫ������ߵ�б������Чֵ��
    return 0;
  }
}



//�Һ��ߵ����ʺ�б����ȡ
uint8 CurveSlopeGetRight(void)
{
  uint8 row;
  uint8 temp;
  uint8 tempslopex[3];
  int16 tempslopey[3];

  //���Һ����п���ֻ��һ����ȡ�ɹ��������ɹ����Ͳ��÷�ʱ���ˡ�
  if(BlackRightDone == 1)
  {
    //3. �Һ������ʷ�����ȡ
    //���ʷ���Ԥ�����㡣
    CurveLineChosenR1 = MaxValUint8;
    CurveLineChosenR2 = MaxValUint8;
    CurveLineChosenR3 = MaxValUint8;
    
    //���ʻ��ڵ���1 CurveLineChosen1�����ϵ���ȡ��һ����Чֵ��
    if(BlackRightHeadLine == MaxValUint8 || BlackRightEndLine == MaxValUint8)
    {
      CURVER = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ���������Чֵ��   
      SlopeR = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ�б������Чֵ��        
      return 0;      
    }
    if(BlackRightHeadLine  >= CameraHight - 2)
    {
      CURVER = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ���������Чֵ��   
      SlopeR = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ�б������Чֵ��        
      return 0;      
    }
    else
    {
      CurveLineChosenR1 = BlackRightHeadLine;
    }

    //�ѵ�1����Чֵ��CameraHight-1�ľ���ֳ�2�Ρ�
    temp = (BlackRightEndLine - 1 - BlackRightHeadLine) / 2;
    //2 * 2 + 1 = 5, �������Ч��ֻ��3�����ڵĻ����ͷ�����ȡ���ʺ�б�ʡ�����Ϊ��ܲ���ȷ��
    if(temp <= 2)
    {
      CurveLineChosenR1 = MaxValUint8;
      CURVER = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ���������Чֵ��   
      SlopeR = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ�б������Чֵ��      
      return 0;
    }
    
    //���ʻ��ڵ���2 CurveLineChosen2
    for(row = CurveLineChosenR1 + temp - 1; ; row++)
    {
      if (row > BlackRightEndLine - 1) 
      {
        CurveLineChosenR1 = MaxValUint8;
        CurveLineChosenR2 = MaxValUint8;
        CURVER = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ���������Чֵ��   
        SlopeR = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ�б������Чֵ��      
        return 0;
      }
      //�����жϸ����ǲ�����Чֵ����Ϊ����������
      CurveLineChosenR2 = row;
      break;
    }
    
    //���ʻ��ڵ���3 CurveLineChosen3
    for(row = CurveLineChosenR2 + temp - 1; ; row++)
    {
      if (row > BlackRightEndLine) 
      {
        CurveLineChosenR1 = MaxValUint8;
        CurveLineChosenR2 = MaxValUint8;
        CurveLineChosenR3 = MaxValUint8;
        CURVER = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ���������Чֵ��   
        SlopeR = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ�б������Чֵ��        
        return 0;
      }
      //�����жϸ����ǲ�����Чֵ����Ϊ����������
      CurveLineChosenR3 = row;
      break;
    }   
    //SABCR�Һ��������������������ȡ
    //SABCR = SABCGet(BlackRightLoc[CurveLineChosenR1,0], CameraHight - 1 - CurveLineChosenR1, 
    //                BlackRightLoc[CurveLineChosenR2,0], CameraHight - 1 - CurveLineChosenR2, 
    //                BlackRightLoc[CurveLineChosenR3,0], CameraHight - 1 - CurveLineChosenR3
    //                );
    
//    CURVER = CurveGet(BlackUdisRightLocation[CurveLineChosenR1].x, CameraHight - 1 - CurveLineChosenR1,
//                      BlackUdisRightLocation[CurveLineChosenR2].x, CameraHight - 1 - CurveLineChosenR2,
//                      BlackUdisRightLocation[CurveLineChosenR3].x, CameraHight - 1 - CurveLineChosenR3
//                      );
    
    CURVER = CurveGet(BlackRightLoc[CurveLineChosenR1][0], CameraHight - 1 - CurveLineChosenR1,
                      BlackRightLoc[CurveLineChosenR2][0], CameraHight - 1 - CurveLineChosenR2,
                      BlackRightLoc[CurveLineChosenR3][0], CameraHight - 1 - CurveLineChosenR3
                      );
    
    //�Һ���б����ȡ�����Ͻ�Ϊԭ�㣬����X������Y��
    tempslopex[0] = CurveLineChosenR1;
    tempslopex[1] = CurveLineChosenR2;
    tempslopex[2] = CurveLineChosenR3;
    tempslopey[0] = BlackUdisRightLocation[CurveLineChosenR1].x;
    tempslopey[1] = BlackUdisRightLocation[CurveLineChosenR2].x;
    tempslopey[2] = BlackUdisRightLocation[CurveLineChosenR3].x;
    SlopeR = LeastSquareInt16a1(tempslopex, tempslopey, 3);         //�Ѿ�������LeastSquareMulti����
    
    return 1;
  }
  //�Һ�����ȡʧ�ܣ�ֱ�ӷ���ʧ�ܡ�
  else
  {
    CURVER = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ���������Чֵ��   
    SlopeR = MaxValInt16;      //return 0ǰ�Ȱ��Һ��ߵ�б������Чֵ��
    return 0;
  }
  
}





//���ʷ�����ȡ
//Ӱ�죺CurveSL, CurveSC, CurveSR, 0��Ч��1����2��
//      SABCL, SABCC, SABCR
uint8 CurveSlopeGet(void)
{
  //���Һ��ߵ�б������ȡ��BlackGet�������Ѿ����й��ˣ���Ӧ��־λҲ�Ѿ����¡�
  //���ʡ�б����ȡ�ı�־λ��1�ɹ���0ʧ�ܡ�Ĭ����Ϊ�ɹ���
  CurveSlopeFlagC = 1;  
  
  //�����ߵ����ʡ�б�ʵ���ȡ��
  if(CurveSlopeGetCenter() == 0)
  {
    CurveSlopeFlagC = 0;
    //uart_sendN(UART0, (uint8 *)"\nCurveSlopeGetCenter() Failed!", 30);
  }  
  
  //ֻ�е�3���ߵ����ʡ�б����ȡ��ʧ�ܵ�ʱ�򣬲ŷ���0���������Ѻ�����������Ͳ����ж��ˡ�
  if(CurveSlopeFlagL == 0 && CurveSlopeFlagC == 0 && CurveSlopeFlagR == 0)
  {
    return 0;
  }
  else
  {
    return 1;
  }
  
}


//ֱ����ͷ���жϵ�6�������ϰ�ȷ�ϡ�
//��ʵ��Ч���ϰ��ж��еķ��ϰ���ȷ�ϡ�
//���룺dir 0��ʾ�����ϰ�ȷ�ϣ�1��ʾ�����ϰ�ȷ��
//���أ�1�ɹ� 0ʧ��
uint8 AngleStep1JudgeNotBrick(uint8 dir)
{
  uint8 row;
  uint8 col;
  uint8 count3;
    
  int32 a0, a1;
  uint8 i, index, tempend;
  
  uint8 x[BrickSlopeRowNum];   //ȡ���ٸ�����һ��ʼ�ж��塣
  uint8 y[BrickSlopeRowNum];
  
  uint8 tempheadrow;
  
  //�����ϰ�ȷ��
  if(dir == 0)
  {
    //2. 1 ���ϰ�����С���˷�
    index = 0;    
    for(i = BrickEndRow + 1; ; i++)
    {
      if(BlackLeftLoc[i][0] != MaxValUint8)
      {
        y[index] = BlackLeftLoc[i][0];
        x[index] = i;
        index++;
      }
      if(index == BrickSlopeRowNum)
      {
        break;  
      }
      if(i == CameraHight - 1)
      {
        return 0;
      }
    }
    
    //��С���˷�
    //y = a0 + a1 * x������������LeastSquareMulti����
    a1 = LeastSquarea1(x, y, BrickSlopeRowNum);
    //��ߣ�б��Ӧ����-PathJudgeStraightSlopeLimit~0,����б�ʲ��ԣ�����ʧ�ܡ�
    if(a1 < 0 && a1 + PathJudgeStraightSlopeLimit > 0)
    {
    }
    else
    {
      return 0;
    }
    a0 = LeastSquarea0(x, y, a1, BrickSlopeRowNum);
    //ֱ�����ε�����ͻ������������
    //��ʼ�У����У��ڵ������С�
    AngleStep1NotBrickEndColL = (a0 + a1 * BrickEndRow) / LeastSquareMulti + BrickColCom;
    //ֱ�����ε�ֱ�Ǳ������С�
    //���ܱȸ�����Ч�Һ��߻���    
    if(BlackRightLoc[BrickEndRow][0] != MaxValUint8)
    {
      AngleStep1NotBrickBorderColL = MinRe(AngleStep1NotBrickEndColL + BrickScanColNum, BlackRightLoc[BrickEndRow][0]); //��������ϰ��߲�ͬ�����ϰ���BrickScanColNum / 2������Ϊ�˱��գ�ȡBrickScanColNum��
    }
    else
    {
    }

    //2.2 ���ϰ��ߣ���ʼɨ�裬�ҵ��ڵ������У������ϰ�ȷ��ʧ�ܡ�
    //Ϊ�˷�ֹ����ͷ��������Զ����Ҫ������ͷ�ҹ���
    //���ܱ�BrickEndRow������
    tempheadrow = MinRe(BrickEndRow, BlackLeftHeadLine);
    //���ܱ�BrickHeadRow��Զ��
    tempheadrow = MaxRe(BrickHeadRow, tempheadrow);    
    for(row = tempheadrow; ; row++)
    {
      //��ĳһ�еĴ���
      //���кڵ����
      count3 = 0;
      //��������ɨ�衣
      tempend = (a0 + a1 * row) / LeastSquareMulti + BrickColCom;   //�ǵó������ӵı���
      //�޷���
      tempend = MinRe(tempend, AngleStep1NotBrickBorderColL);
      //�ڵ�ɨ�衣
      for(col = AngleStep1NotBrickBorderColL; ; col--)
      {
        if(ImgNew[row][col] < LimitLeftB)  //����
        {
          count3++;
        }
        else
        {
        }
        //����ɨ�����߽�
        if(col <= tempend || col == 0) break;
      }
      //���кڵ��������BrickLineBlackCountNum��ʱ�����м�����1.
      if(count3 > BrickLineBlackCountNum) 
      {
        //�������кڵ���࣬��ֱ�ӷ���ʧ��
        return 0;
      }
      else
      {
      }
      
      if(row == BrickEndRow) break;
    }
    
    //3. ����ȷ�ϣ����سɹ���
    return 1;
       
  }
  //�����ϰ�ȷ��
  else if(dir == 1)
  {
    //1. ��С���˷�
    index = 0;    
    for(i = BrickEndRow + 1; ; i++)
    {
      if(BlackRightLoc[i][0] != MaxValUint8)
      {
        y[index] = BlackRightLoc[i][0];
        x[index] = i;
        index++;
      }
      if(index == BrickSlopeRowNum)
      {
        break;  
      }
      if(i == CameraHight - 1)
      {
        return 0;
      }
    }
    
    //��С���˷�
    //y = a0 + a1 * x������������LeastSquareMulti����
    a1 = LeastSquarea1(x, y, BrickSlopeRowNum);
    //�ұߣ�б��Ӧ����0~PathJudgeStraightSlopeLimit,����б�ʲ��ԣ�����ʧ�ܡ�
    if(a1 > 0 && a1 < PathJudgeStraightSlopeLimit)
    {
    }
    else
    {
      return 0;
    }
    a0 = LeastSquarea0(x, y, a1, BrickSlopeRowNum);
    //ֱ�����ε�����ͻ������������
    //��ʼ�У����У��ڵ������С�
    AngleStep1NotBrickEndColR = (a0 + a1 * BrickEndRow) / LeastSquareMulti - BrickColCom;   //�����иģ������ص���
    //ֱ�����ε�ֱ�Ǳ������С����ܱȵ�ǰ�е���Ч����߻�ҪС��
    if(BlackLeftLoc[BrickEndRow][0] != MaxValUint8)
    {
      AngleStep1NotBrickBorderColR = MaxRe(AngleStep1NotBrickEndColR - BrickScanColNum, BlackLeftLoc[BrickEndRow][0]);  //��������ϰ��߲�ͬ�����ϰ���BrickScanColNum / 2������Ϊ�˱��գ�ȡBrickScanColNum��
    }
    else
    {
    }
    
    //2.2 ���ϰ��ߣ���ʼɨ�裬�ҵ��ڵ������У������ϰ�ȷ��ʧ�ܡ��������ϰ�ɨ�衣
    //Ϊ�˷�ֹ����ͷ��������Զ����Ҫ������ͷ�ҹ���
    //���ܱ�BrickEndRow������
    tempheadrow = MinRe(BrickEndRow, BlackRightHeadLine);
    //���ܱ�BrickHeadRow��Զ��
    tempheadrow = MaxRe(BrickHeadRow, tempheadrow);    
    for(row = tempheadrow; ; row++)
    {
      //��ĳһ�еĴ���
      //���кڵ��������������ɨ�衣
      count3 = 0;
      //��ǰ�е�ɨ����ұ߽硣
      tempend = (a0 + a1 * row) / LeastSquareMulti - BrickColCom;   //�ǵó������ӵı���
      //�޷���
      tempend = MaxRe(tempend, AngleStep1NotBrickBorderColR);
      //�ڵ�ɨ�衣
      for(col = AngleStep1NotBrickBorderColR; ; col++)
      {
        if(ImgNew[row][col] < LimitRightB)  //����
        {
          count3++;
        }
        else
        {
        }
        //����ɨ�����߽�
        if(col >= tempend || col == CameraRealWidth - 1) break;
      }
      //���кڵ��������BrickLineBlackCountNum��ʱ�����м�����1.
      if(count3 > BrickLineBlackCountNum) 
      {
        //�������кڵ���࣬��ֱ�ӷ���ʧ��
        return 0;
      }
      else
      {
      }
      
      if(row == BrickEndRow) break;
    }
    
    //3. ����ȷ��
    //�ߵ�����˵��û�з��ϰ����ɹ������سɹ���
    return 1;
  }
  else
  {
  }

  
  //��̬Ϊ����ʧ�ܡ�
  return 0;
}



//======================================================================
//��������AngleStep1Judge
//��  �ܣ�ֱ��������ж�
//��  ����
//��  �أ�1�ɹ���0ʧ��
//Ӱ  �죺
//˵  ����1. ��ֻ�ǳ����жϣ���ȷ�϶�η���ȷ��Ϊֱ���䡣
//        2. ��ʵ��������ӵ�6�������ǰ��ߵ����ұ��к�ɫ����
//             
//======================================================================
uint8 AngleStep1Judge(void)
{
  uint8 i, j, col;
  uint8 errorcount;
  uint8 templ, tempr;
  uint8 check_row, leftborder, rightborder;
  uint8 leftbordercal, rightbordercal;
  //�������ڽ���֮ǰ����Ҫ�ж�ֱ����������Ҫ����һ��ֱ���������顣
  //���жϲ�׼�����Գ��԰�errorcount����ֵ��С��

  //1. ���Һ��߾���ȡ�ɹ�
  if(BlackLeftDone == 1 && BlackRightDone == 1)
  {
  }
  else
  {
    return 0;
  }
  
  //�������һ����Ҫ�жϵ�������
  //2. ��ͷ�и߶Ȳ�
  //����ͷ������ͷ�ߺܶ࣬���п�������ֱ���䡣
  if (BlackRightHeadLine >= BlackLeftHeadLine + AngleHeadLineNum)
  {
      //3. ����ʮ��״̬δ�����ʧ�ܣ��������ܳɹ�������β�ܽ�
      //   ����ʮ��״̬δ�����ʧ�ܣ��������ܳɹ�������β�ܽ�
      //BlackLeftCrossDone 0δ���룬1ʧ�ܣ�2�ɹ�
      //BlackLeftStep4Flag 0δ���룬1ʧ�ܣ�2�ɹ�
      if ((BlackLeftCrossDone != 2)
      //&& (BlackLeftEndLine > CameraHight - 5)
      && (BlackRightCrossDone != 2)
      //&& (BlackRightEndLine > CameraHight - 5)
      && (CURVEL <= 30 && CURVEL >= 0 - 30)      //������Ӧ���Ǹ�����ֵ��С��ֵ
      && (CURVER <= 30 && CURVER >= 0 - 40)      //��ֱ���� //������Ӧ���Ǹ�����ֵ��С��ֵ
        )
      {
          //3.5 �������ͷ����û��С���䣬�����С���䣬�򷵻�ʧ�ܡ�
          if(BlackRightLoc[BlackRightHeadLine][0] > BlackRightLoc[BlackRightHeadLine+1][0] && BlackRightLoc[BlackRightHeadLine+1][0] > BlackRightLoc[BlackRightHeadLine+2][0])
          {
            return 0;
          }
          else
          {
          }
          
          //4. ����5Slope�������С
          //����
          //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
          //ֱ���䳤��ͷ���ԣ�1��ʾȥ��������ͷ��
          if(AngleLongHeadLineStrategy == 1)
          {
            if(BlackLeftEndLine - BlackLeftHeadLine - 4 - AngleHeadLineNum < 0 || BlackLeft5SlopeIndex - 1 - AngleHeadLineNum < 0)
            {
              return 0;
            }
            else
            {        
            }
            templ = MinRe(BlackLeftEndLine - BlackLeftHeadLine - 4, BlackLeft5SlopeIndex - 1);               
          }
          //0��ʾ��ȥ����
          else
          {
            if(BlackLeftEndLine - BlackLeftHeadLine - 4 < 0 || BlackLeft5SlopeIndex - 1 < 0)
            {
              return 0;
            }
            else
            {        
            }
            templ = MinRe(BlackLeftEndLine - BlackLeftHeadLine - 4, BlackLeft5SlopeIndex - 1);            
          }
          //�����������
          errorcount = 0;
          //����ж�С5��б���Ƿ���������
          for(i = 0; ; i++)
          {
            if(BlackLeft5Slope[i] > 0 || BlackLeft5Slope[i] < 0 - PathJudgeStraightSlopeLimit) //���ϵ����µ�б���Ǹ��ġ� 
            {
              errorcount++;
              if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
            }
      
            if(i == templ) break;
          }
          //����������������ʧ�ܡ�
          if(i != templ) return 0;
          
          //����
          //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
          if(BlackRightEndLine - BlackRightHeadLine - 4 < 0 || BlackRight5SlopeIndex - 1 < 0)
          {
            return 0;
          }
          else
          {
          }
          tempr = MinRe(BlackRightEndLine - BlackRightHeadLine - 4, BlackRight5SlopeIndex - 1);
          //�����������
          errorcount = 0;
          //����ж�С5��б���Ƿ���������
          for(i = 0; ; i++)
          {
            if(BlackRight5Slope[i] < 0 || BlackRight5Slope[i] > PathJudgeStraightSlopeLimit) //���ϵ����µ�б�������ġ�
            {
              errorcount++;
              if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
            }
      
            if(i == tempr) break;
          }
          //����������������ʧ�ܡ�
          if(i != tempr) return 0;
          
          //���������߶�����Ҫ�󣬻���������ߡ�

          //5. ������ͷ����һЩ����а������⡣
          //5.1. һ��
          col = BlackRightLoc[BlackRightHeadLine][0];   //�������ԭʼ�ĺڵ㣬���ܲ��ý�����ġ�
          for(i = BlackRightHeadLine-3; i > (BlackRightHeadLine-AngleHeadLineNum); i--)
          {
            //�����߰׵���ֵ���бȽϣ�������ڰ׵���ֵ��
            if(ImgNew[i][col] < LimitRightW - AngleWhiteAreaLimitVal)
            {
              flag222 = 10;
              //ֻҪ��һ���㲻���㣬���ж�����ֱ���䡣
              break;
            }
            else
            {
              flag222 = 0;
            }
          }
          //���µ���һֱ����׵㣬���������������������ز�ֵ��С��
          if(
            (i <= BlackRightHeadLine-AngleHeadLineNum)
          &&(AbsInt(ImgNew[BlackRightHeadLine-3][col] - ImgNew[BlackRightHeadLine-AngleHeadLineNum][col]) < 2 * AngleWhiteAreaLimitVal)
            )
          {
            //5.2. һ��
            check_row = BlackRightHeadLine - AngleHeadLineNum / 2;
            //һ�����߽�
            //����С��ͼ����߽�
            leftborder = MaxRe(0, BlackRightLoc[BlackRightHeadLine][0] - 15);
            leftbordercal = MaxRe(0, BlackRightLoc[BlackRightHeadLine][0] - 15);
            //���ܱȸ�����Ч�����С��
            if(BlackLeftLoc[check_row][0] != MaxValUint8)
            {
              leftborder = MaxRe(BlackLeftLoc[check_row][0], leftborder);
              leftbordercal = MaxRe(BlackLeftLoc[check_row][0], leftbordercal);
            }
            else
            {
            } 
            //һ����ұ߽硣
            rightborder = MinRe(CameraRealWidth - 1, BlackRightLoc[BlackRightHeadLine][0] + 15);
            rightbordercal = MinRe(CameraRealWidth - 1, BlackRightLoc[BlackRightHeadLine][0] + 15);
            //�����ҽ��а׵���
            for(j = leftborder; j < rightborder; j++)
            {
              if(ImgNew[check_row][j] < LimitRightW - AngleWhiteAreaLimitVal) break;              
            }
            //������һֱ����׵㣬���������������ֵ��С�������6����
            if(
              (j >= rightborder) 
            &&(AbsInt(ImgNew[check_row][leftbordercal] - ImgNew[check_row][rightbordercal]) < 2 * AngleWhiteAreaLimitVal) //���ĵ�Ƚ϶࣬�����ֵ��΢��һЩ��
              )
            {
              //6. �����ϰ�ȷ�ϳɹ���������ȷ������ֱ�ǡ�
              if(AngleStep1JudgeNotBrick(1) == 1)
              {
                PathType = PathTypeAngleR;
              }
              else
              {
              }
            }
            else
            {
              
            }           
          }
          else
          {            
          }
      }
      //������Ϊֱ��
      else
      {
      }

  }
  //����ͷ������ͷ�ߺܶ࣬���п�������ֱ���䡣
  else if (BlackLeftHeadLine >= BlackRightHeadLine + AngleHeadLineNum)
  {
      //3. ����ʮ��״̬δ�����ʧ�ܣ��������ܳɹ�������β�ܽ�
      //   ����ʮ��״̬δ�����ʧ�ܣ��������ܳɹ�������β�ܽ�
      //BlackLeftCrossDone 0δ���룬1ʧ�ܣ�2�ɹ�
      //BlackLeftStep4Flag 0δ���룬1ʧ�ܣ�2�ɹ�
      if ((BlackLeftCrossDone != 2)
      //&& (BlackLeftEndLine > CameraHight - 5)
      && (BlackRightCrossDone != 2)
      //&& (BlackRightEndLine > CameraHight - 5)
      && (CURVEL <= 40 && CURVEL >= 0 - 30)      //��ֱ����//������Ӧ���Ǹ�����ֵ��С��ֵ
      && (CURVER <= 30 && CURVER >= 0 - 30)      //������Ӧ���Ǹ�����ֵ��С��ֵ
        )
      {
          //3.5 �������ͷ����û��С���䣬�����С���䣬�򷵻�ʧ�ܡ�
          if(BlackLeftLoc[BlackLeftHeadLine][0] < BlackLeftLoc[BlackLeftHeadLine+1][0] && BlackLeftLoc[BlackLeftHeadLine+1][0] < BlackLeftLoc[BlackLeftHeadLine+2][0])
          {
            return 0;
          }
          else
          {
          }

          //4. ����5Slope�������С
          //����
          //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
          if(BlackLeftEndLine - BlackLeftHeadLine - 4 < 0 || BlackLeft5SlopeIndex - 1 < 0)
          {
            return 0;
          }
          else
          {        
          }
          templ = MinRe(BlackLeftEndLine - BlackLeftHeadLine - 4, BlackLeft5SlopeIndex - 1);
          //�����������
          errorcount = 0;
          //����ж�С5��б���Ƿ���������
          for(i = 0; ; i++)
          {
            if(BlackLeft5Slope[i] > 0 || BlackLeft5Slope[i] < 0 - PathJudgeStraightSlopeLimit) //���ϵ����µ�б���Ǹ��ġ� 
            {
              errorcount++;
              if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
            }
      
            if(i == templ) break;
          }
          //����������������ʧ�ܡ�
          if(i != templ) return 0;
          
          //����
          //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
          //ֱ������ͷ����ԣ�1��ʾȥ�����ߵ���ͷ��
          if(AngleLongHeadLineStrategy == 1)
          {
            if(BlackRightEndLine - BlackRightHeadLine - 4 - AngleHeadLineNum < 0 || BlackRight5SlopeIndex - 1 - AngleHeadLineNum < 0)
            {
              return 0;
            }
            else
            {
            }
            tempr = MinRe(BlackRightEndLine - BlackRightHeadLine - 4 - AngleHeadLineNum, BlackRight5SlopeIndex - 1 - AngleHeadLineNum);
          }
          //0��ʾ��ȥ�����ߵ���ͷ��
          else
          {
            if(BlackRightEndLine - BlackRightHeadLine - 4 < 0 || BlackRight5SlopeIndex - 1 < 0)
            {
              return 0;
            }
            else
            {
            }
            tempr = MinRe(BlackRightEndLine - BlackRightHeadLine - 4, BlackRight5SlopeIndex - 1);
            
          }
          //�����������
          errorcount = 0;
          //����ж�С5��б���Ƿ���������
          for(i = 0; ; i++)
          {
            if(BlackRight5Slope[i] < 0 || BlackRight5Slope[i] > PathJudgeStraightSlopeLimit) //���ϵ����µ�б�������ġ�
            {
              errorcount++;
              if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
            }
      
            if(i == tempr) break;
          }
          //����������������ʧ�ܡ�
          if(i != tempr) return 0;
          
          //���������߶�����Ҫ�󣬻���������ߡ�        

          //5. ������ͷ����һЩ����а������⡣
          //5.1. һ��
          col = BlackLeftLoc[BlackLeftHeadLine][0];   //�������ԭʼ�ĺڵ㣬���ܲ��ý�����ġ�
          for(i = BlackLeftHeadLine-3; i > (BlackLeftHeadLine-AngleHeadLineNum); i--)
          {
            //�����߰׵���ֵ���бȽϣ�������ڰ׵���ֵ��
            if(ImgNew[i][col] < LimitLeftW - AngleWhiteAreaLimitVal)
            {
              flag222 = 10;
              //ֻҪ��һ���㲻���㣬���ж�����ֱ���䡣
              break;
            }
            else
            {
              flag222 = 0;
            }
          }
          //���µ���һֱ����׵㣬���������������������ز�ֵ��С��
          if(
            (i <= BlackLeftHeadLine-AngleHeadLineNum)
          &&(AbsInt(ImgNew[BlackLeftHeadLine-3][col] - ImgNew[BlackLeftHeadLine-AngleHeadLineNum][col]) < 2 * AngleWhiteAreaLimitVal) //���ĵ�Ƚ϶࣬�����ֵ��΢��һЩ��
            )
          {
            //5.2. һ��
            check_row = BlackLeftHeadLine - AngleHeadLineNum / 2;
            //һ�����߽�
            //����С��ͼ����߽�
            leftborder = MaxRe(0, BlackLeftLoc[BlackLeftHeadLine][0] - 15);
            leftbordercal = MaxRe(0, BlackLeftLoc[BlackLeftHeadLine][0] - 15);
            //һ����ұ߽硣
            rightborder = MinRe(CameraRealWidth - 1, BlackLeftLoc[BlackLeftHeadLine][0] + 15);
            rightbordercal = MinRe(CameraRealWidth - 1, BlackLeftLoc[BlackLeftHeadLine][0] + 15);
            //���ܱȸ�����Ч�Һ��߻���
            if(BlackRightLoc[check_row][0] != MaxValUint8)
            {
              rightborder = MinRe(BlackRightLoc[check_row][0], rightborder);
              rightbordercal = MinRe(BlackRightLoc[check_row][0], rightbordercal);
            }
            else
            {
            }
            //�����ҽ��а׵���
            for(j = leftborder; j < rightborder; j++)
            {
              if(ImgNew[check_row][j] < LimitLeftW - AngleWhiteAreaLimitVal) break;              
            }
            //������һֱ����׵㣬���������������ֵ��С�������6����
            if(
              (j >= rightborder) 
            &&(AbsInt(ImgNew[check_row][leftbordercal] - ImgNew[check_row][rightbordercal]) < 2 * AngleWhiteAreaLimitVal)
              )
            {
              //6. �����ϰ�ȷ�ϳɹ���������ȷ������ֱ�ǡ�
              if(AngleStep1JudgeNotBrick(0) == 1)
              {
                PathType = PathTypeAngleL;
              }
              else
              {
              }
            }
            else
            {
            }            
          }
          else
          {
          }
      }
      //������Ϊֱ��
      else
      {
      }
  }
  //���򱣳�ֱ�����䡣
  else
  {
  }
  return 1;
  
}




//======================================================================
//��������PathLCRAngle1Judge
//��  �ܣ�ֱ�������䡢�����жϣ�ֱ�����1�׶�Ԥ�С�
//��  ����
//��  �أ�1�ɹ���0ʧ�ܡ�
//Ӱ  �죺
//˵  ����1. ֻ����б������ȡʧ��ʱ�Ż᷵��0������ֻ�᷵��1. 
//        2. �����Һ��߶���ȡ�ɹ���ʱ�򣬻����ֱ�����1�׶�Ԥ�С�
//             
//======================================================================
uint8 PathLCRAngle1Judge(void)
{
  
  //ErrorGet();
  int32 AbsSlopeC;
  uint8 curvetempLL, curvetempLR, curvetempRL, curvetempRR;
  uint8 slopetempLL, slopetempLR, slopetempRL, slopetempRR;
  
  //������һ����б��Ϊ���������������жϷ���

  //��������PathType: 0δ֪ 1ֱ�� 2���� 3���� 4���� 5���� 6���� 7����
  PathType = PathTypeUnknown;
  //���ʷ��Ż�ȡ�ɹ�
  //���CurveSlopeGet()����0�������3���ߵ����ʡ�б�ʾ���ȡʧ�ܣ����ý���������жϡ�
  if(CurveSlopeGet() == 1)
  {
    //�Ƚ�����ֵ�����������Ͳ��÷���ʹ���ˡ�
    AbsSlopeC = AbsInt(SlopeC);
    //AbsSlopeL = AbsSelfFloat(SlopeL);
    //AbsSlopeR = AbsSelfFloat(SlopeR);
    //�����ж������߳ɹ����������˿϶��ǳɹ��ġ�
    //��ʱ�����ߵ����ʡ�б��һ�����ڣ����߻������߲�һ����
    //�����������򡱵�ʱ����,����������˵��������������б����˵�������Ҹ���
    curvetempRL = (CurveSlopeFlagL == 1 && (CURVEL > CurveStraightLimitL));        //�������������Ч����Ϊ0�������Ч�����п���Ϊ1.�����ж����������Ƿ��ҡ�
    curvetempRR = (CurveSlopeFlagR == 1 && (CURVER > CurveStraightLimitR));        //�������������Ч����Ϊ0�������Ч�����п���Ϊ1.�����ж����������Ƿ��ҡ�
    curvetempLL = (CurveSlopeFlagL == 1 && (CURVEL + CurveStraightLimitL < 0));    //�������������Ч����Ϊ0�������Ч�����п���Ϊ1.�����ж����������Ƿ���          
    curvetempLR = (CurveSlopeFlagR == 1 && (CURVER + CurveStraightLimitR < 0));    //�������������Ч����Ϊ0�������Ч�����п���Ϊ1.�����ж����������Ƿ���  
    slopetempRL = (CurveSlopeFlagL == 1 && (SlopeL + SlopeLimitL < 0));            //�������б����Ч����Ϊ0�������Ч�����п���Ϊ1.�����ж�����б���Ƿ��ҡ�
    slopetempRR = (CurveSlopeFlagR == 1 && (SlopeR + SlopeLimitR < 0));            //�������б����Ч����Ϊ0�������Ч�����п���Ϊ1.�����ж�����б���Ƿ��ҡ�
    slopetempLL = (CurveSlopeFlagL == 1 && (SlopeL > SlopeLimitL));                //�������б����Ч����Ϊ0�������Ч�����п���Ϊ1.�����ж�����б���Ƿ���
    slopetempLR = (CurveSlopeFlagR == 1 && (SlopeR > SlopeLimitR));                //�������б����Ч����Ϊ0�������Ч�����п���Ϊ1.�����ж�����б���Ƿ���
    //�����������롱��ʱ����
    /*
    tempRL = ((CurveSlopeFlagL && (CURVEL > CurveStraightLimitL)) //�������������Ч������߼����п�����0��
          ||(!CurveSlopeFlagL)                                   //�������������Ч������߼���һ����1.
            );
    tempRR = ((CurveSlopeFlagR && (CURVER > CurveStraightLimitR)) //�������������Ч������߼����п�����0��
          ||(!CurveSlopeFlagR)                                   //�������������Ч������߼���һ����1.
            );
    tempLL = ((CurveSlopeFlagL && (CURVEL + CurveStraightLimitL < 0)) //�������������Ч������߼����п�����0��
          ||(!CurveSlopeFlagL)                                   //�������������Ч������߼���һ����1.
            );
    tempLR = ((CurveSlopeFlagR && (CURVER + CurveStraightLimitR < 0)) //�������������Ч������߼����п�����0��
          ||(!CurveSlopeFlagR)                                   //�������������Ч������߼���һ����1.
            );
    */
      //1. ���Һ��߾���ȡ�ɹ��������
      if(BlackLeftDone == 1 && BlackRightDone == 1)
      {
      //1.1. ������б���㹻������һ��������270��������Сб�ʴ���ж�ʧ�����⡣
      if(AbsSlopeC <= SlopeLimitC)
      {
        //1.1.1. ������������ֻҪ��һ���Ƚϴ������ң���ô�ж�Ϊ���䡣        
        if(
           //(CURVEC > CurveStraightLimitC)
            (curvetempRL)
         || (curvetempRR)
           )
        {//1.1.1.1. ���Һ���б����ֻҪ��һ���Ƚϴ������ң���ô�ж�Ϊ���䡣
          if((slopetempRL)
          || (slopetempRR)
              )
          {
            PathType = PathTypeRight;
          }
          //1.1.1.2. ���Һ���б�ʶ����󣬾������ʱȽϴ�Ҳ�ж�Ϊֱ����
          else
          {
              PathType = PathTypeStraight;
          }
          
        }
        //1.1.2. ������������ֻҪ��һ���Ƚϴ���������ô�ж�Ϊ���䡣
        else if(
               //(CURVEC + CurveStraightLimitC < 0)
                 (curvetempLL)
              || (curvetempLR)
                )
        {   //1.1.2.1. ���Һ���б����ֻҪ��һ���Ƚϴ���������ô�ж�Ϊ���䡣
            if((slopetempLL)
            || (slopetempLR)
              )
            {
                PathType = PathTypeLeft;
            }
            //1.1.2.2. ���Һ���б�ʶ����󣬾���б�ʱȽϴ�Ҳ�ж�Ϊֱ����
            else
            {
                PathType = PathTypeStraight;
            }         
        }
        //1.1.3. ���������ʶ�������ô���ж�Ϊֱ����
        else
        {
          PathType = PathTypeStraight;
         
        }
      }
      //1.2. б������ƫ�����п��������������б����˵�����������������Ǹ���
      else if(SlopeC > SlopeLimitC)
      { //1.2.1. ����ֻҪ��һ�����ʱȽϴ������󣬾��ж�Ϊ�����
        //���Һ���б����ֻҪ��һ���Ƚϴ���������ô�ж�Ϊ���䡣
        if(
           //(CURVEC + CurveStraightLimitC < 0)
           (curvetempLL)
        || (curvetempLR)
        || (slopetempLL)
        || (slopetempLR)
          )
        {
          PathType = PathTypeLeft;
        }
        //1.2.2. �������ֱ����
        else
        {
          PathType = PathTypeStraight;
        }
      }
      //1.3. б������ƫ�����п������ҵ���
      else if(SlopeC + SlopeLimitC < 0)
      {
        //1.3.1. ����ֻҪ��һ�����ʱȽϴ������ң����ж�Ϊ�ҵ���
        //���Һ���б����ֻҪ��һ���Ƚϴ������ң���ô�ж�Ϊ���䡣
        if(
           //(CURVEC > CurveStraightLimitC)
            (curvetempRL)
         || (curvetempRR)
         || (slopetempRL)
         || (slopetempRR)
           )
        {
          PathType = PathTypeRight;
        }
        //1.3.2. �������ֱ����
        else
        {
          PathType = PathTypeStraight;
        }        
      }
      //1.4. �����ϲ����ߵ����
      else
      {
      }
      
      //���ж�Ϊֱ����������ֱ���䵥����⡣
      if(PathType == PathTypeStraight)
      {
        AngleStep1Judge();
      }
      else
      {
      }   
      
    }
    //2. ������ȡ�ɹ���������ȡʧ��
    else if(BlackLeftDone == 1 && BlackRightDone == 0)
    {
      
      //2.1. ������б���㹻����
      if(AbsSlopeC <= SlopeLimitC)
      {
        //2.1.1. ������������ֻҪ��һ���Ƚϴ������ң���ô�ж�Ϊ���䡣        
        if((CURVEC > CurveStraightLimitC)
         || (curvetempRL)
           )
        {   //2.1.1.1. ������б�ʽϴ������ң���ô�ж�Ϊ���䡣
            if (slopetempRL)
            {
                PathType = PathTypeRight;
            }
            //2.1.1.2. ������б�ʲ��󣬾������ʽϴ�Ҳ�ж�Ϊֱ����
            else
            {
                PathType = PathTypeStraight;
            }
          
        }
        //2.1.2. ������������ֻҪ��һ���Ƚϴ���������ô�ж�Ϊ���䡣
        else if((CURVEC + CurveStraightLimitC < 0)
              || (curvetempLL)
                )
        {   //2.1.2.1. ������б�ʽϴ���������ô���ж�Ϊ���䡣
            if (slopetempLL)
            {
                PathType = PathTypeLeft;
            }
            //2.1.2.2. ������б�ʲ��󣬾������ʽϴ�Ҳ�ж�Ϊֱ����
            else
            {
                PathType = PathTypeStraight;
            }          
        }
        //2.1.3. ���ʶ��������ֵ�Ƚ�С����ô���ж�Ϊֱ����
        else
        {
          PathType = PathTypeStraight;
        }
      }
      //2.2. б������ƫ�����п��������������б����˵�����������������Ǹ���
      else if(SlopeC > SlopeLimitC)
      { //2.2.1. ������ֻҪ��һ�����ʱȽϴ������󣬾��ж�Ϊ�����
        //������б�ʽϴ������󣬾��ж�Ϊ�����
        if((CURVEC + CurveStraightLimitC < 0)
        || (curvetempLL)
        || (slopetempLL)
          )
        {
          PathType = PathTypeLeft;
        }
        //2.2.2. �������ֱ����
        else
        {
          PathType = PathTypeStraight;
        }
      }
      //2.3. б������ƫ�����п������ҵ���
      else if(SlopeC + SlopeLimitC < 0)
      {
        //2.3.1. ������ֻҪ��һ�����ʱȽϴ������ң����ж�Ϊ�ҵ���
        //������б�ʽϴ������ң����ж�Ϊ�ҵ���
        if((CURVEC > CurveStraightLimitC)
         || (curvetempRL)
         || (slopetempRL)
           )
        {
          PathType = PathTypeRight;
        }
        //2.3.2. �������ֱ����
        else
        {
          PathType = PathTypeStraight;
        }        
      }
      //2.4. �����ϲ����ߵ����
      else
      {
      } 
    }
    //3. ������ȡʧ�ܣ�������ȡ�ɹ�
    else if(BlackLeftDone == 0 && BlackRightDone == 1)
    {             
      //3.1. ������б���㹻����
      if(AbsSlopeC <= SlopeLimitC)
      { 
        //3.1.1. ������������ֻҪ��һ���Ƚϴ������ң��Ǿ��ж�Ϊ���䡣        
        if((CURVEC > CurveStraightLimitC)
         || (curvetempRR)
           )
        {   //3.1.1.1. �������б�ʽϴ������ң��Ǿ��ж�Ϊ���䡣
            if (slopetempRR)
            {
                PathType = PathTypeRight;
            }
            //3.1.1.2. �������б�ʲ��󣬾������ʽϴ����ж�Ϊֱ����
            else
            {
                PathType = PathTypeStraight;
            }
          
        }
        //3.1.2. ������������ֻҪ��һ���Ƚϴ���������ô�п��������䡣
        else if((CURVEC + CurveStraightLimitC < 0)
              || (curvetempLR)
                )
        {   //3.1.2.1. �������б�ʽϴ��������Ǿ��ж�Ϊ���䡣
            if (slopetempLR)
            {
                PathType = PathTypeLeft;
            }
            //3.1.2.2. �������б�ʲ��󣬾������ʽϴ�Ҳ�ж�Ϊֱ����
            else
            {
                PathType = PathTypeStraight;
            }          
        }
        //3.1.3. ���ʶ��������ֵ�Ƚ�С����ô���ж�Ϊֱ����
        else
        {
          PathType = PathTypeStraight;
        }
      }
      //3.2. б������ƫ�����п��������������б����˵�����������������Ǹ���
      else if(SlopeC > SlopeLimitC)
      { //3.2.1. ������ֻҪ��һ�����ʱȽϴ������󣬾��ж�Ϊ�����
        //�������б�ʽϴ��������Ǿ��ж�Ϊ���䡣
        if((CURVEC + CurveStraightLimitC < 0)
        || (curvetempLR)
        || (slopetempLR)
          )
        {
          PathType = PathTypeLeft;
        }
        //3.2.2. �������ֱ����
        else
        {
          PathType = PathTypeStraight;
        }
      }
      //3.3. б������ƫ�����п������ҵ���
      else if(SlopeC + SlopeLimitC < 0)
      {
        //3.3.1. ������ֻҪ��һ�����ʱȽϴ������ң����ж�Ϊ�ҵ���
        //�������б�ʽϴ������ң��Ǿ��ж�Ϊ���䡣
        if((CURVEC > CurveStraightLimitC)
         || (curvetempRR)
         || (slopetempRR)
           )
        {
          PathType = PathTypeRight;
        }
        //3.3.2. �������ֱ����
        else
        {
          PathType = PathTypeStraight;
        }        
      }
      //3.4. �����ϲ����ߵ����
      else
      {
      }      
    }
    //4. �����ϲ���������������
    else 
    {
    }
    
    return 1;
    //ֱ�������䡢���䡢�ж���ϣ�ֱ����Ԥ����ϡ�
  }
  //3���ߵ����ʡ�б�ʾ���ȡʧ�ܣ�ֱ�ӷ���ʧ�ܡ�
  else
  {
    PathType = PathTypeUnknown;  
    return 0;
  }

}


//======================================================================
//��������PathSmallSJudgeStep2
//��  �ܣ����������ж�ʱ��СS���2���սǵ��жϡ�
//��  ����row��Ҫ�����ǰһ�У�sel ����0 ����1��dir Z����0 ��Z����1.
//��  �أ�1�ɹ���0ʧ�ܡ�
//Ӱ  �죺
//˵  ����1. ��2���ս��жϳɹ����򷵻�1�����򷵻�0.
//        2. ����ú���ǰ�������Ѿ�������
//             
//======================================================================
uint8 PathSmallSJudgeStep2(uint8 row, uint8 sel, uint8 dir)
{
  uint8 i;
  
  //����
  if(sel == 0)
  {
    //Z����
    if(dir == 0)
    {
      for(i = row + 1; i < BlackLeftEndLine - PathSmallSGapLine; i++)
      {
        //Z���Σ���Ҫ�������ϵ����µĹ켣��
        if(BlackLeftLoc[i][0] < BlackLeftLoc[i + 1 + PathSmallSGapLine][0])
        {
          return 1;
        }
        else
        {
        }
      }
    }
    //��Z����
    else
    {
      for(i = row + 1; i < BlackLeftEndLine - PathSmallSGapLine; i++)
      {
        //��Z���Σ���Ҫ�������ϵ����µĹ켣��
        if(BlackLeftLoc[i][0] >= BlackLeftLoc[i + 1 + PathSmallSGapLine][0])
        {
          return 1;
        }
        else
        {
        }
      }
    }
    
    //һֱ����Ч����ĩβ��δ��⵽��Ӧ�Ĺ켣����2���սǼ��ʧ�ܣ�����0��
    return 0;
  }
  //����
  else
  {
    //Z����
    if(dir == 0)
    {
      for(i = row + 1; i < BlackRightEndLine - PathSmallSGapLine; i++)
      {
        //Z���Σ���Ҫ�������ϵ����µĹ켣��
        if(BlackRightLoc[i][0] < BlackRightLoc[i + 1 + PathSmallSGapLine][0])
        {
          return 1;
        }
        else
        {
        }
      }
    }
    //��Z����
    else
    {
      for(i = row + 1; i < BlackRightEndLine - PathSmallSGapLine; i++)
      {
        //��Z���Σ���Ҫ�������ϵ����µĹ켣��
        if(BlackRightLoc[i][0] >= BlackRightLoc[i + 1 + PathSmallSGapLine][0])
        {
          return 1;
        }
        else
        {
        }
      }
    }
    
    //һֱ����Ч����ĩβ��δ��⵽��Ӧ�Ĺ켣����2���սǼ��ʧ�ܣ�����0��
    return 0;
  }

}


//======================================================================
//��������PathSmallSJudgeStep1
//��  �ܣ����������ж�ʱ��СS���1���սǵ��жϡ�
//��  ����
//��  �أ�1�ɹ���0ʧ�ܡ�
//Ӱ  �죺
//˵  ����1. ����1��0ֻ�Ǳ�ʾ�Ƿ�ΪСS�䡣
//        2. ����ú���ǰ�������Ѿ�������
//             
//======================================================================
uint8 PathSmallSJudgeStep1(void)
{
    uint8 i;
    uint8 signflag1 = 2;    //��ʼΪ2����Ϊ0Ҳ��Ϊ1.
    //1. ��ͷ���ߡ�2. �������µĲ����ֱ仯��

    //1. ���Һ��߾���ȡ�ɹ���
    if (BlackLeftDone == 1 && BlackRightDone == 1)
    {
        //1.1. ������ͷ���ߡ�
        if (
            (BlackLeftHeadLine < PathSmallSHeadLimit) 
         && (BlackLeftEndLine > BlackLeftHeadLine + PathSmallSGapLine + 1)
            )
        {
            //��ʼΪ2����Ϊ0Ҳ��Ϊ1.
            signflag1 = 2;
            
            //1.2. ������������ ���� ������ �ı仯�� 
            //����
            for (i = BlackLeftHeadLine; i < BlackLeftEndLine - PathSmallSGapLine; i++)
            {
                //������������⵽���䣬��;��return.
                if (BlackLeftLoc[i][0] >= BlackLeftLoc[i + 1 + PathSmallSGapLine][0])
                {
                    //��⵽����
                    if (signflag1 == 0)
                    {
                        //����СS��ĵ�2���սǵ�ʶ�����ߣ�Z���Ρ�
                        if(PathSmallSJudgeStep2(i, 0, 0) == 1)
                        {
                          PathSmallSDoneFlag = 1;   //СS���жϳɹ���
                          PathSmallSDir = 1;    //СS��������
                          PathType = PathTypeSmallSR;   //��S
                          return 1;
                        }
                        else
                        {
                          //���ߵ�2���ս�û�м��ɹ���û��ϵ�������������ߵļ�⡣
                          //return 0;
                        }
                    }
                    else
                    {
                    }
                    signflag1 = 1;
                }
                //��������
                else
                {   
                    //��⵽���䡣
                    if (signflag1 == 1)
                    { 
                        //����СS��ĵ�2���սǵ�ʶ�����ߣ���Z���Ρ�
                        if(PathSmallSJudgeStep2(i, 0, 1) == 1)
                        {
                          PathSmallSDoneFlag = 1;   //СS���жϳɹ���
                          PathSmallSDir = 0;    //СS��������
                          PathType = PathTypeSmallSL;  //��S
                          return 1;
                        }
                        else
                        {
                          //���ߵ�2���ս�û�м��ɹ���û��ϵ�������������ߵļ�⡣
                          //return 0;
                        }
                    }
                    else
                    {
                    }
                    signflag1 = 0;
                }
            }
            
            //������˵�����߲��ɹ�����û��ϵ�������������ߡ�
        }
        //������ͷ�����ߣ���ֱ���������������ߡ�
        else
        {
        }
        
        //������ͷҪ���ߡ�
        if(
            (BlackRightHeadLine < PathSmallSHeadLimit)
         && (BlackRightEndLine > BlackRightHeadLine + PathSmallSGapLine + 1)
           )
        {
          //��ʼΪ2����Ϊ0Ҳ��Ϊ1.
          signflag1 = 2;

          //���ߡ�������û��return���ͼ��������䡣
          for (i = BlackRightHeadLine; i < BlackRightEndLine - PathSmallSGapLine; i++)
          {
              //��������
              if (BlackRightLoc[i][0] >= BlackRightLoc[i + 1 + PathSmallSGapLine][0])
              {
                  //��⵽����
                  if (signflag1 == 0)
                  {
                      //����СS��ĵ�2���սǵ�ʶ�����ߣ�Z���Ρ�
                      if(PathSmallSJudgeStep2(i, 1, 0) == 1)
                      {
                        PathSmallSDoneFlag = 1;   //СS���жϳɹ���
                        PathSmallSDir = 1;    //СS��������
                        PathType = PathTypeSmallSR;   //��S
                        return 1;
                      }
                      else
                      {
                        return 0;
                      }
                  }
                  else
                  {
                  }
                  signflag1 = 1;
              }
              //��������
              else
              {
                  //��⵽���䡣
                  if (signflag1 == 1)
                  {
                      //����СS��ĵ�2���սǵ�ʶ�����ߣ���Z���Ρ�
                      if(PathSmallSJudgeStep2(i, 1, 1) == 1)
                      {
                        PathSmallSDoneFlag = 1;   //СS���жϳɹ���
                        PathSmallSDir = 0;    //СS��������
                        PathType = PathTypeSmallSL;   //��S
                        return 1;
                      }
                      else
                      {
                        return 0;
                      }
                  }
                  else
                  {
                  }
                  signflag1 = 0;
              }
          }

          //����������;��û��return 1���򷵻ؼ��ʧ�ܡ�
          return 0;
        }
        else
        {
          //������ͷ���ͣ�������СS�䡣����ʧ�ܡ�
          return 0;
        }
    }
    //2. ������ȡ�ɹ���������ȡʧ�ܡ�
    else if (BlackLeftDone == 1 && BlackRightDone == 0)
    {
        //2.1. ������ͷҪ�󹻸ߡ�
        if (BlackLeftHeadLine < PathSmallSHeadLimit && BlackLeftEndLine > BlackLeftHeadLine + PathSmallSGapLine + 1)
        {
            //2.2. ������䡣
            for (i = BlackLeftHeadLine; i < BlackLeftEndLine - PathSmallSGapLine; i++)
            {

                //������������⵽���䣬��;��return.
                if (BlackLeftLoc[i][0] >= BlackLeftLoc[i + 1 + PathSmallSGapLine][0])
                {
                    //��⵽����
                    if (signflag1 == 0)
                    {                           
                        //����СS��ĵ�2���սǵ�ʶ�����ߣ�Z���Ρ�
                        if(PathSmallSJudgeStep2(i, 0, 0) == 1)
                        {
                          PathSmallSDoneFlag = 1;   //СS���жϳɹ���
                          PathSmallSDir = 1;    //СS��������
                          PathType = PathTypeSmallSR;   //��S
                          return 1;
                        }
                        else
                        {
                          return 0;
                        }
                    }
                    else
                    {
                    }
                    signflag1 = 1;
                }
                //��������
                else
                {
                    //��⵽���䡣
                    if (signflag1 == 1)
                    {                           
                        //����СS��ĵ�2���սǵ�ʶ�����ߣ���Z���Ρ�
                        if(PathSmallSJudgeStep2(i, 0, 1) == 1)
                        {
                          PathSmallSDoneFlag = 1;   //СS���жϳɹ���
                          PathSmallSDir = 0;    //СS��������
                          PathType = PathTypeSmallSL;  //��S
                          return 1;
                        }
                        else
                        {
                          return 0;
                        }
                    }
                    else
                    {
                    }
                    signflag1 = 0;
                }
            }

            //��������;û��return���򷵻ؼ��ʧ�ܡ�
            return 0;
        }
        //��ͷ���ͣ�������СS�䡣����ʧ�ܡ�
        else
        {
            return 0;
        }
    }
    //3. ������ȡ�ɹ���������ȡʧ�ܡ�
    else if (BlackLeftDone == 0 && BlackRightDone == 1)
    {
        //3.1. ������ͷ��Ҫ���ߡ�
        if (BlackRightHeadLine < PathSmallSHeadLimit && BlackRightEndLine > BlackRightHeadLine + PathSmallSGapLine + 1)
        {
            //���ߡ�
            for (i = BlackRightHeadLine; i < BlackRightEndLine - PathSmallSGapLine; i++)
            {
                  //��������
                  if (BlackRightLoc[i][0] >= BlackRightLoc[i + 1 + PathSmallSGapLine][0])
                  {
                      //��⵽����
                      if (signflag1 == 0)
                      {                           
                          //����СS��ĵ�2���սǵ�ʶ�����ߣ�Z���Ρ�
                          if(PathSmallSJudgeStep2(i, 1, 0) == 1)
                          {
                            PathSmallSDoneFlag = 1;   //СS���жϳɹ���
                            PathSmallSDir = 1;    //СS��������
                            PathType = PathTypeSmallSR; //��S
                            return 1;
                          }
                          else
                          {
                            return 0;
                          }
                      }
                      else
                      {
                      }
                      signflag1 = 1;
                  }
                  //��������
                  else
                  {
                      //��⵽���䡣
                      if (signflag1 == 1)
                      {                           
                          //����СS��ĵ�2���սǵ�ʶ�����ߣ���Z���Ρ�
                          if(PathSmallSJudgeStep2(i, 1, 1) == 1)
                          {
                            PathSmallSDoneFlag = 1;   //СS���жϳɹ���
                            PathSmallSDir = 0;    //СS��������
                            PathType = PathTypeSmallSL;  //��S
                            return 1;
                          }
                          else
                          {
                            return 0;
                          }
                      }
                      else
                      {
                      }
                      signflag1 = 0;
                  }
            }

            //��������;û��return���򷵻ؼ��ʧ�ܡ�
            return 0;
        }
        //��ͷ���ͣ�������СS�䡣����ʧ�ܡ�
        else
        {
            return 0;
        }

    }
    //4. �����ϲ����ߵ����
    else
    {
        return 0;
    }

}



//���������ж�
//======================================================================
//��������PathJudge
//��  �ܣ����������ж�
//��  ������
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺PathType
//˵  ����1. �������ʺ�б�����жϡ�
//        2. PathType: 0δ֪ 1ֱ�� 2���� 3���� 4���� 5���� 6���� 7����
//             
//======================================================================
uint8 PathJudge(void)
{  
  uint8 flag1, flag2;
  
  
  //ֱ�������䡢�����жϣ�ֱ�����1�׶�Ԥ�С�
  //��б������ȡʧ��ʱ���᷵��0.
  flag1 = PathLCRAngle1Judge();

  //СS���жϡ���СS��᷵��0.
  //flag2 = PathSmallSJudgeStep1();
  flag2 = 1;
  
  if(flag1 == 0 && flag2 == 0)
  {
    return 0;
  }
  else
  {
    return 1;
  }
  
  //������һ��������Ϊ���������������жϷ�����
  /*
  //��������PathType: 0δ֪ 1ֱ�� 2���� 3���� 4���� 5���� 6���� 7����
  PathType = PathTypeUnknown;
  //���ʷ��Ż�ȡ�ɹ�
  //���CurveSlopeGet()����0�������3���ߵ����ʡ�б�ʾ���ȡʧ�ܣ����ý���������жϡ�
  if(CurveSlopeGet())
  {
    //�����ж������߳ɹ����������˿϶��ǳɹ��ġ�
    //���Һ��߾���ȡ�ɹ����������
    if(BlackLeftDone == 1 && BlackRightDone == 1)
    { //ȫ����ʱ�룬����ñȽ϶࣬��Ϊ���䣬������С�������������Ϊ���ĵ����䡣
      if(
         (CURVEL + CurveStraightLimitL < 0) 
       &&(CURVEC + CurveStraightLimitC < 0)
       &&(CURVER + CurveStraightLimitR < 0)       
         )
      {
        PathType = PathTypeLeftMiddle;
      }
      //ȫ��˳ʱ�룬��˳�ñȽ϶࣬��Ϊ���䣬������С�������������Ϊ���ĵ����䡣
      else if(CURVEL > CurveStraightLimitL && CURVEC > CurveStraightLimitC && CURVER > CurveStraightLimitR)
      {        
        PathType = PathTypeRightMiddle;
      }
      else
      {
        if(
          (AbsSelf(CURVEL) < CurveStraightLimitL)
        &&(AbsSelf(CURVEC) < CurveStraightLimitC)
        &&(AbsSelf(CURVER) < CurveStraightLimitR) //����ֵ�ľ���ֵ��С��
        &&(SlopeL + SlopeLimitL < 0)              //�����б��С��ĳ��ֵ
        &&(AbsSelfFloat(SlopeC) < SlopeLimitC)         //������б�ʾ���ֵ��С
        &&(SlopeR > SlopeLimitR)                  //�Һ���б�ʴ���ĳ��ֵ
          )
        { //��С����ֵ��Ϊֱ����
          PathType = PathTypeStraight;  
        }
        else
        {
          PathType = PathTypeUnknown; //δ֪�������͡�  
        }
      }
    }
    
    //�������ȡʧ�ܣ��Һ�����ȡ�ɹ����������
    if(BlackLeftDone == 0 && BlackRightDone == 1)
    { //������������
      if((CURVEC + CurveStraightLimitC < 0) 
       &&(CURVER + CurveStraightLimitR < 0)
         )
      {
        PathType = PathTypeLeftOut;
      }
      //��������ڵ���
      else if(CURVEC > CurveStraightLimitC && CURVER > CurveStraightLimitR)
      {
        PathType = PathTypeRightIn;
      }
      else
      {
        if(
          (AbsSelf(CURVEC) < CurveStraightLimitC)
        &&(AbsSelf(CURVER) < CurveStraightLimitR)
        &&(AbsSelfFloat(SlopeC) < SlopeLimitC)         //������б�ʾ���ֵ��С
        &&(SlopeR > SlopeLimitR)                  //�Һ���б�ʴ���ĳ��ֵ
          )
        { //��С����ֵ��Ϊֱ����
          PathType = PathTypeStraight;  
        }
        else
        {
          PathType = PathTypeUnknown; //δ֪�������͡�  
        }
      }
    }
    
    //�Һ�����ȡʧ�ܣ��������ȡ�ɹ����������
    if(BlackLeftDone == 1 && BlackRightDone == 0)
    { //��������ڵ���
      if((CURVEC + CurveStraightLimitC < 0)
       &&(CURVEL + CurveStraightLimitL < 0)
         )
      {
        PathType = PathTypeLeftIn;
      }
      //������������
      else if(CURVEC > CurveStraightLimitC && CURVEL > CurveStraightLimitL)
      {
        PathType = PathTypeRightOut;
      }
      else
      {
        if(
          (AbsSelf(CURVEC) < CurveStraightLimitC)
        &&(AbsSelf(CURVEL) < CurveStraightLimitL)
        &&(SlopeL + SlopeLimitL < 0)              //�����б��С��ĳ��ֵ
        &&(AbsSelfFloat(SlopeC) < SlopeLimitC)         //������б�ʾ���ֵ��С          
          )
        { //��С����ֵ��Ϊֱ����
          PathType = PathTypeStraight;  
        }
        else
        {
          PathType = PathTypeUnknown; //δ֪�������͡�  
        }
      }
    }
    
    return 1;
  }
  //3���ߵ����ʡ�б�ʾ���ȡʧ�ܣ�ֱ�ӷ���ʧ�ܡ�
  else
  {
    PathType = PathTypeUnknown;  
    return 0;
  }
  
  */   //end of ������Ϊ���������������жϷ�����
  
}








//ͼ��������
uint8 BlackUdis(void)
{
  uint8 row;
  
  //����
  //������ߵĻ������
  if(BlackLeftDone == 1)
  {
    //����β����ͷ��
    for(row = BlackLeftEndLine; ; row--)
    {
      //��������
      if(row > BlackUdisMiddleLine)
      {
        //��
        BlackUdisLeftLocation[row].x  = (BlackUdisMatrixLow[0] * BlackLeftLoc[row][0] + BlackUdisMatrixLow[1] * (row + 1) + BlackUdisMatrixLow[2]) 
                                      / (BlackUdisMatrixLow[6] * BlackLeftLoc[row][0] + BlackUdisMatrixLow[7] * (row + 1) + 1000);
        //��
        BlackUdisLeftLocation[row].y  = (BlackUdisMatrixLow[3] * BlackLeftLoc[row][0] + BlackUdisMatrixLow[4] * (row + 1) + BlackUdisMatrixLow[5]) 
                                      / (BlackUdisMatrixLow[6] * BlackLeftLoc[row][0] + BlackUdisMatrixLow[7] * (row + 1) + 1000);
      }
      else
      {
        //�м����
        if(row > BlackUdisFarLine)
        {
          //��
          BlackUdisLeftLocation[row].x  = (BlackUdisMatrixMiddle[0] * BlackLeftLoc[row][0] + BlackUdisMatrixMiddle[1] * (row + 1) + BlackUdisMatrixMiddle[2]) 
                                        / (BlackUdisMatrixMiddle[6] * BlackLeftLoc[row][0] + BlackUdisMatrixMiddle[7] * (row + 1) + 1000);
          //��
          BlackUdisLeftLocation[row].y  = (BlackUdisMatrixMiddle[3] * BlackLeftLoc[row][0] + BlackUdisMatrixMiddle[4] * (row + 1) + BlackUdisMatrixMiddle[5]) 
                                        / (BlackUdisMatrixMiddle[6] * BlackLeftLoc[row][0] + BlackUdisMatrixMiddle[7] * (row + 1) + 1000);     
        }
        //Զ������
        else
        {
          //��
          BlackUdisLeftLocation[row].x  = (BlackUdisMatrixFar[0] * BlackLeftLoc[row][0] + BlackUdisMatrixFar[1] * (row + 1) + BlackUdisMatrixFar[2]) 
                                        / (BlackUdisMatrixFar[6] * BlackLeftLoc[row][0] + BlackUdisMatrixFar[7] * (row + 1) + 1000);
          //��
          BlackUdisLeftLocation[row].y  = (BlackUdisMatrixFar[3] * BlackLeftLoc[row][0] + BlackUdisMatrixFar[4] * (row + 1) + BlackUdisMatrixFar[5]) 
                                        / (BlackUdisMatrixFar[6] * BlackLeftLoc[row][0] + BlackUdisMatrixFar[7] * (row + 1) + 1000);          
        }       
      }
      
      if(row == BlackLeftHeadLine) break;
    }
  }
  else
  {    
  }
  
  //���Һ��ߵĻ������
  if(BlackRightDone == 1)
  {
    //����β����ͷ��
    for(row = BlackRightEndLine; ; row--)
    {
      //��������
      if(row > BlackUdisMiddleLine)
      {
        //��
        BlackUdisRightLocation[row].x  = (BlackUdisMatrixLow[0] * BlackRightLoc[row][0] + BlackUdisMatrixLow[1] * (row + 1) + BlackUdisMatrixLow[2]) 
                                       / (BlackUdisMatrixLow[6] * BlackRightLoc[row][0] + BlackUdisMatrixLow[7] * (row + 1) + 1000);
        //��
        BlackUdisRightLocation[row].y  = (BlackUdisMatrixLow[3] * BlackRightLoc[row][0] + BlackUdisMatrixLow[4] * (row + 1) + BlackUdisMatrixLow[5]) 
                                       / (BlackUdisMatrixLow[6] * BlackRightLoc[row][0] + BlackUdisMatrixLow[7] * (row + 1) + 1000);
      }
      else
      {
        //�м����
        if(row > BlackUdisFarLine)
        {
          //��
          BlackUdisRightLocation[row].x  = (BlackUdisMatrixMiddle[0] * BlackRightLoc[row][0] + BlackUdisMatrixMiddle[1] * (row + 1) + BlackUdisMatrixMiddle[2]) 
                                         / (BlackUdisMatrixMiddle[6] * BlackRightLoc[row][0] + BlackUdisMatrixMiddle[7] * (row + 1) + 1000);
          //��
          BlackUdisRightLocation[row].y  = (BlackUdisMatrixMiddle[3] * BlackRightLoc[row][0] + BlackUdisMatrixMiddle[4] * (row + 1) + BlackUdisMatrixMiddle[5]) 
                                         / (BlackUdisMatrixMiddle[6] * BlackRightLoc[row][0] + BlackUdisMatrixMiddle[7] * (row + 1) + 1000);     
        }
        //Զ������
        else
        {
          //��
          BlackUdisRightLocation[row].x  = (BlackUdisMatrixFar[0] * BlackRightLoc[row][0] + BlackUdisMatrixFar[1] * (row + 1) + BlackUdisMatrixFar[2]) 
                                         / (BlackUdisMatrixFar[6] * BlackRightLoc[row][0] + BlackUdisMatrixFar[7] * (row + 1) + 1000);
          //��
          BlackUdisRightLocation[row].y  = (BlackUdisMatrixFar[3] * BlackRightLoc[row][0] + BlackUdisMatrixFar[4] * (row + 1) + BlackUdisMatrixFar[5]) 
                                         / (BlackUdisMatrixFar[6] * BlackRightLoc[row][0] + BlackUdisMatrixFar[7] * (row + 1) + 1000);          
        }       
      }
      
      if(row == BlackRightHeadLine) break;
    }
  }
  else
  {
  }
  
  return 1;
}


//ֱ����ʱ���������ߵ����⴦������
//����ImgProSucceedDeal()��������DeviFuse���º����ĺ��棬ǿ���޸�DeviFuse��ֵ����Ӱ��CenterLineLoc[]���顣
//ֱ����������������ʱ��CenterLineLoc[]����һֱ����Чֵ��
uint8 AngleSpeDealCen(uint8 dir)
{
  //��ֱ����
  if(dir == 0)
  {
    //��DeviNow�����⸳ֵ��Ӱ�������ơ�
    DeviFuse = AngleSpeDealDeviNow[AngleSpeDealBackCountNum-AngleSpeDealBackCount-1];
    //��DeviNowLevel�����⸳ֵ��Ӱ�����͵�����ơ�
    //DeviNowLevel = AngleSpeDealDeviNowLevel[AngleSpeDealBackCountNum-AngleSpeDealBackCount-1];
    ////��SlopeC�����⸳ֵ��Ӱ��SlopeCLevel��Ӱ�������ơ�
    SlopeC = AngleSpeDealSlopeC[AngleSpeDealBackCountNum-AngleSpeDealBackCount-1];
  }
  //��ֱ����
  else if(dir == 1)
  {
    //��DeviNow�����⸳ֵ��Ӱ�������ơ�
    DeviFuse = 0 - AngleSpeDealDeviNow[AngleSpeDealBackCountNum-AngleSpeDealBackCount-1];
    //��DeviNowLevel�����⸳ֵ��Ӱ�����͵�����ơ�
    //DeviNowLevel = AngleSpeDealDeviNowLevel[AngleSpeDealBackCountNum-AngleSpeDealBackCount-1];
    //��SlopeC�����⸳ֵ��Ӱ��SlopeCLevel��Ӱ�������ơ�
    SlopeC = AngleSpeDealSlopeC[AngleSpeDealBackCountNum-AngleSpeDealBackCount-1];    
  }
  //����
  else
  {    
  }
  
  return 1;
}


//��ֱ�����жϣ�1�ѳ���0δ��
uint8 AngleSpeDealExitJudge(void)
{
  //����Ҫ����AngleSpeDealBackCountMin��ǿ�ƿ��ơ�
  if(AngleSpeDealBackCountNum - AngleSpeDealBackCount < AngleSpeDealBackCountMin)
  {
    return 0;
  }
  else
  {
  }
  
  //�˳�ǿ�ƿ��Ƶ������������߾��ɹ�����������б�ʾ���ֵС��һ��ֵ��
  if(
     (BlackLeftDone == 1)
   &&(BlackRightDone == 1)
   &&(AbsInt(SlopeL) < AngelSpeDealExitSlope)
   &&(AbsInt(SlopeR) < AngelSpeDealExitSlope)
     )
  {
    return 1;
  }
  else
  {
    return 0;
  }
  
  /*
  //������2���ߣ������ж��Ѿ�����ֱ���䡣
  if(BlackLeftDone == 1 && BlackRightDone == 1)
  {
    return 1;
  }
  else
  {
  }
  
  //AngleSpeDealDir�����ߵ�б�ʳ�����AngelSpeDealExitSlope��Ҳ���԰ѿ���Ȩ������������ˡ�
  if(AngleSpeDealDir == 0)
  {
    //��ֱ���䡣
    if(SlopeR >= AngelSpeDealExitSlope)
    {
      return 1;
    }
    else
    {
    }
  }
  else if(AngleSpeDealDir == 1)
  {
    //��ֱ���䡣
    if(SlopeL >= AngelSpeDealExitSlope)
    {
      return 1;
    }
    else
    {
    }    
  }
  else
  {
  }

  return 0;
  */
}

//ֱ����ȷ�Ϻ�����ȷ�϶���ܲ�ȷ����ֱ���䣬������Ӧ������
uint8 AngleStep2Confirm(void)
{          
  uint8 i;
  
  //�õ�����һ�ε�ʵʱ�ٶȵȼ�ֵ����Ȼû����һ�εģ���ҲӦ�ò�𲻴�
  //QuadSpeedLevel��10���ȼ���0����9���١�Ŀǰȷ�ϴ���ֻ��2�������Լ���ϸ�֡�
  /*
  if(QuadSpeedLevel >= 5)
  {
    //���٣�ȷ�ϴ�����Խ��� ��
    realConfirmNum = 5;
  }
  else
  {
    //���٣�ȷ�ϴ�����Խ϶ࡣ
    realConfirmNum = 10;
  }
  */
  ///////////////////////////////////��ʱ�Ȳ��á��Ȳ���ֵ���������á�

  //A�μ�������B��ֱ�ǳɹ������ж�Ϊֱ���䡣�����ȳ����С�
  //ֱ������û����λʱ����ֱ�Ǽ��������ѱ���λ������ֱ�Ǽ�����
  if(AngleConfirmLockFlag == 0)
  {
    for(i = 0; ; i++)
    {
      AngleConfirmMat[i] = AngleConfirmMat[i + 1];
      if(i == AngleConfirmMatNum - 2) break;
    }
    //�ɹ�
    if(PathType == PathTypeAngleL || PathType == PathTypeAngleR)
    {
      //�ж�Ϊֱ����������ֵ��1��
      AngleConfirmMat[AngleConfirmMatNum - 1] = 1;
    }
    else
    {
      //�ж�Ϊ��ֱ����������ֵ��0.
      AngleConfirmMat[AngleConfirmMatNum - 1] = 0;
    }
    //�ռ�AngleConfirmMat������1�ĸ�����
    AngleConfirmMatCollect = 0;
    for(i = 0; ; i++)
    {
      if(AngleConfirmMat[i] == 1) AngleConfirmMatCollect++;
      
      if(i == AngleConfirmMatNum - 1) break;
    }
  }
  //ֱ�������־λ�ѱ���λ������ֱ�Ǽ�����
  else
  {
  }
  
  //�������ɴΣ�������Ϊֱ�ǡ�
  if(AngleConfirmMatCollect >= AngleConfirmMatLimit)
  {
    //�����־λ��λ��
    AngleConfirmLockFlag = 1;
    //������գ���ֹ�ظ����档
    for(i = 0; ; i++)
    {
      AngleConfirmMat[i] = 0;
      if(i == AngleConfirmMatNum - 1) break;
    }
    //ȷ��ֱ����ķ���
    if(PathType == PathTypeAngleL)
    {
      AngleSpeDealDir = 0;             //��ֱ����
    }
    else if(PathType == PathTypeAngleR)
    {
      AngleSpeDealDir = 1;             //��ֱ����
    }
    else
    {
      //AngleSpeDealDir = 2;             //����
    }
  }
  else
  {
  }
  
  //��ֱ���������־λ��λ����ȴ����ߵ���ͷ���ͺ�ʼֱ���䴦��
  if(AngleConfirmLockFlag == 1)
  {
    //ֱ�Ǻڿ������־λ���㡣����Ϊֱ��������λ������ֱ�Ǻڿ鲻����м�⡣
    AngleZoneConfirmLockFlag = 0;
    
    //��ֱ����
    if(AngleSpeDealDir == 0)
    {
      if(BlackLeftHeadLine >= AngleSpeDealStartHeadLine || BlackLeftHeadLine == MaxValUint8)
      {
        //����ͷ�������쵽ֱ���䣩��������ͷ��Ч���Ѿ�����ֱ���䣩����ʼֱ�������⴦��
        AngleSpeDealBackCount = AngleSpeDealBackCountNum;
      }
      else
      {
        //��û�����������ٵȵȡ�
      }
    }
    //��ֱ����
    else if(AngleSpeDealDir == 1)
    {
      if(BlackRightHeadLine >= AngleSpeDealStartHeadLine || BlackRightHeadLine == MaxValUint8)
      {
        //����ͷ�������쵽ֱ���䣩��������ͷ��Ч���Ѿ�����ֱ���䣩����ʼֱ�������⴦��
        AngleSpeDealBackCount = AngleSpeDealBackCountNum;
      }
      else
      {
        //��û�����������ٵȵȡ�
      }
    }
    else
    {
    }
  }
  else
  {
  }

  //�˳�ֱ�����⴦����жϡ�
  AngleSpeDealExitJudgeFlag = AngleSpeDealExitJudge();
  
  //���˵��������󣬾Ϳ�ʼÿ�ε�����ֱ��Ϊ0���ж��Ѿ�����ֱ�ǡ����������ơ�
  if(AngleSpeDealBackCount != 0 && AngleSpeDealExitJudgeFlag == 0)
  {
    AngleConfirmLockFlag = 0;    //ֱ�����жϳɹ������־λ���㡣
    
    //����ֵ��1��
    AngleSpeDealBackCount--;
    //�������ߵ����⴦��������ʣAngleSpeDealBackCount�Ρ�
    AngleSpeDealCen(AngleSpeDealDir);
    //��־λ˵��������ֱ��������⴦��
    AngleSpeDealFlag = 1;
    
    //ֱ�Ǻڿ������־λ���㡣����Ϊֱ��������λ������ֱ�Ǻڿ鲻����м�⡣
    AngleZoneConfirmLockFlag = 0;    
  }
  else
  {
    //�����������㣬��ֹ�ٴ�����ֱ�������⴦��
    AngleSpeDealBackCount = 0;
    
    //��־λ˵��û�н���ֱ��������⴦��
    AngleSpeDealFlag = 0;
  }
  
  return 1;
}









//���������ж��е�ֱ���ж�
//1��ֱ����0����ֱ��
uint8 PathJudgeNewStraight(void)
{
  uint8 templ, tempr;
  uint8 i;
  uint8 errorcount;
  
  
  //ֱ���ж�
  //1. ֱ�����жϺ��ϸ񣬱��������߾��ɹ���������С5��б���������С��
  if(BlackLeftDone == 1 && BlackRightDone == 1)
  {
    //2. ֱ��������Ҫ����ͷΪ����С����ǵ���56-59�л����ҵ��ߣ���һ���ܳɹ������Է���ʼɨ���߷ſ���55�С�
    if(BlackGetPreDir == 0 || BlackGetPreDir == 2)
    {
      if(BlackLeftStep1ScanRow == CameraHight - 1 && BlackRightStep1ScanRow >= CameraHight - 5)
      {
      }
      else
      {
        return 0;
      }
    }
    else
    {
      if (BlackLeftStep1ScanRow >= CameraHight - 5 && BlackRightStep1ScanRow == CameraHight - 1)
      {
      }
      else
      {
        return 0;
      }
    }
    //3. PathJudgeNewStraightChooseΪ0��ʾ�ж�ֱ��Ҫ�õ����еĵ㣬��������ͷ��
    //���ַ����Ƚ��ϸ񣬻��Сֱ���жϳɹ��ʣ��������׽������������г�ֱ����
    if(PathJudgeNewStraightChoose == 0)
    {
      errorcount = 0;
      //����
      //����С5��б�������ĩ��
      templ = BlackLeft5SlopeIndex - 1;
      //if(templ <= 10) return 0;
      
      //����ж�С5��б���Ƿ���������
      for(i = 0; ; i++)
      {
        if(BlackLeft5Slope[i] > 0 || BlackLeft5Slope[i] < 0 - PathJudgeStraightSlopeLimit) //���ϵ����µ�б���Ǹ��ġ� 
        {
          errorcount++;
          if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
        }
        
        //if(i == templ - 10) break;
        if(i == templ) break;
      }
      //if(i != templ - 10) 
      if(i != templ)
      {
        flag000 = 3;
        flag111 = BlackLeft5Slope[i];
        return 0;
      }
      
      errorcount = 0;
      //����
      //����С5��б�������ĩ��
      tempr = BlackRight5SlopeIndex - 1;
      //if(tempr <= 10) return 0;
      
      //����ж�С5��б���Ƿ���������
      for(i = 0; ; i++)
      {
        if(BlackRight5Slope[i] < 0 || BlackRight5Slope[i] > PathJudgeStraightSlopeLimit) //���ϵ����µ�б�������ġ�
        {
          errorcount++;
          if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
        }
        
        //if(i == tempr - 10) break;
        if(i == tempr) break;
      }
      //if(i != tempr - 10)
      if(i != tempr)
      {
        flag111 = BlackRight5Slope[i];
        flag000 = 5;
        return 0;
      }
      
      //�ߵ�����˵���ж�ֱ���ɹ���
      flag000 = 0;
      PathType = PathTypeStraight;
      return 1;
    
    }
    //3. PathJudgeNewStraightChooseΪ1��ʾ�ж�ֱ��ʱ������ͷ��ʼ�����е�10�У����жϡ�
    //���ַ���������ֱ���жϳɹ��ʣ������׽������������г�ֱ����
    else if(PathJudgeNewStraightChoose == 1)
    {
      errorcount = 0;
      //����
      //����С5��б�������ĩ��
      templ = BlackLeft5SlopeIndex - 1;
      if(templ <= 10) return 0; //
      
      //����ж�С5��б���Ƿ���������
      for(i = 0; ; i++)
      {
        if(BlackLeft5Slope[i] > 0 || BlackLeft5Slope[i] < 0 - PathJudgeStraightSlopeLimit) //���ϵ����µ�б���Ǹ��ġ� 
        {
          errorcount++;
          if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
        }
        
        if(i == templ - 10) break;
        //if(i == templ) break;
      }
      if(i != templ - 10) 
      //if(i != templ)
      {
        flag000 = 3;
        flag111 = BlackLeft5Slope[i];
        return 0;
      }
      
      errorcount = 0;
      //����
      //����С5��б�������ĩ��
      tempr = BlackRight5SlopeIndex - 1;
      if(tempr <= 10) return 0;  //
      
      //����ж�С5��б���Ƿ���������
      for(i = 0; ; i++)
      {
        if(BlackRight5Slope[i] < 0 || BlackRight5Slope[i] > PathJudgeStraightSlopeLimit) //���ϵ����µ�б�������ġ�
        {
          errorcount++;
          if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
        }
        
        if(i == tempr - 10) break;
        //if(i == tempr) break;
      }
      if(i != tempr - 10) 
      //if(i != tempr)
      {
        flag111 = BlackRight5Slope[i];
        flag000 = 5;
        return 0;
      }
      
      //�ߵ�����˵���ж�ֱ���ɹ���
      flag000 = 0;
      PathType = PathTypeStraight;
      return 1;      
    }
    //3. PathJudgeNewStraightChooseΪ2��ʾ�ж�ֱ��Ҫ�õ����еĵ㣬��������ͷ��
    //���ַ����Ƚ��ϸ񣬻��Сֱ���жϳɹ��ʣ��������׽������������г�ֱ����
    //���ַ���������֮�����ڿ��ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
    else
    {
      //���ǵ��ߵ����
      if(SingleBlackAllFlag == 0)
      {
        errorcount = 0;
        //����
        //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
        if(BlackLeftEndLine - BlackLeftHeadLine - 4 < 0 || BlackLeft5SlopeIndex - 1 < 0)
        {
          return 0;
        }
        else
        {        
        }
        templ = MinRe(BlackLeftEndLine - BlackLeftHeadLine - 4, BlackLeft5SlopeIndex - 1);
        //if(templ <= 10) return 0;
        
        //����ж�С5��б���Ƿ���������
        for(i = 0; ; i++)
        {
          if(BlackLeft5Slope[i] > 0 || BlackLeft5Slope[i] < 0 - PathJudgeStraightSlopeLimit) //���ϵ����µ�б���Ǹ��ġ� 
          {
            errorcount++;
            if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
          }
          
          //if(i == templ - 10) break;
          if(i == templ) break;
        }
        //if(i != templ - 10) 
        if(i != templ)
        {
          flag000 = 3;
          flag111 = BlackLeft5Slope[i];
          return 0;
        }
        
        errorcount = 0;
        
        //����
        //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
        if(BlackRightEndLine - BlackRightHeadLine - 4 < 0 || BlackRight5SlopeIndex - 1 < 0)
        {
          return 0;
        }
        else
        {
        }
        tempr = MinRe(BlackRightEndLine - BlackRightHeadLine - 4, BlackRight5SlopeIndex - 1);
        //if(tempr <= 10) return 0;
        
        //����ж�С5��б���Ƿ���������
        for(i = 0; ; i++)
        {
          if(BlackRight5Slope[i] < 0 || BlackRight5Slope[i] > PathJudgeStraightSlopeLimit) //���ϵ����µ�б�������ġ�
          {
            errorcount++;
            if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
          }
          
          //if(i == tempr - 10) break;
          if(i == tempr) break;
        }
        //if(i != tempr - 10)
        if(i != tempr)
        {
          flag111 = BlackRight5Slope[i];
          flag000 = 5;
          return 0;
        }
        
        //�ߵ�����˵���ж�ֱ���ɹ���
        flag000 = 0;
        PathType = PathTypeStraight;
        return 1;   
      }
      //���ߵ����
      else
      {
        errorcount = 0;
        //����
        //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
        if(BlackLeftEndLine - BlackLeftHeadLine - 4 < 0 || BlackLeft5SlopeIndex - 1 < 0)
        {
          return 0;
        }
        else
        {        
        }
        templ = MinRe(BlackLeftEndLine - BlackLeftHeadLine - 4, BlackLeft5SlopeIndex - 1);
        //if(templ <= 10) return 0;
        
        //����ж�С5��б���Ƿ���������
        for(i = 0; ; i++)
        {
          if(BlackLeft5Slope[i] > 1001 || BlackLeft5Slope[i] < 0 - 1000) //���ϵ����µ�б���Ǹ��ġ� 
          {
            errorcount++;
            if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
          }
          
          //if(i == templ - 10) break;
          if(i == templ) break;
        }
        //if(i != templ - 10) 
        if(i != templ)
        {
          flag000 = 3;
          flag111 = BlackLeft5Slope[i];
          return 0;
        }
        
        errorcount = 0;
        
        //����
        //���ǵ���Black5Slope����ĸ�������Ч�ڵ㲻һ����ͬ�������������еĻ��ʡ�
        if(BlackRightEndLine - BlackRightHeadLine - 4 < 0 || BlackRight5SlopeIndex - 1 < 0)
        {
          return 0;
        }
        else
        {
        }
        tempr = MinRe(BlackRightEndLine - BlackRightHeadLine - 4, BlackRight5SlopeIndex - 1);
        //if(tempr <= 10) return 0;
        
        //����ж�С5��б���Ƿ���������
        for(i = 0; ; i++)
        {
          if(BlackRight5Slope[i] < 0 - 1001 || BlackRight5Slope[i] > 1000) //���ϵ����µ�б�������ġ�
          {
            errorcount++;
            if(errorcount > 3) break;   //���������ɸ���б�ʳ�����Χ
          }
          
          //if(i == tempr - 10) break;
          if(i == tempr) break;
        }
        //if(i != tempr - 10)
        if(i != tempr)
        {
          flag111 = BlackRight5Slope[i];
          flag000 = 5;
          return 0;
        }
        
        //�ߵ�����˵���ж�ֱ���ɹ���
        flag000 = 0;
        PathType = PathTypeStraight;
        return 1;           
      }
    }
  }
  else
  {
    flag000 = 1;
    //��������ʲô�κ�һ�߲��ɹ����򲻿�����ֱ����ֱ�ӷ���0.
    return 0;
  }
  
}

//�ϰ��ж�
//������ǰ������������Ϊֱ��
uint8 BrickJudge(void)
{
  uint8 row;
  uint8 col;
  uint8 count1, count2, count3;
    
  int32 a0, a1;
  uint8 i, index, tempend;
  
  uint8 x[BrickSlopeRowNum];   //ȡ���ٸ�����һ��ʼ�ж��塣
  uint8 y[BrickSlopeRowNum];
  
  if(BlackLeftDone == 1 && BlackRightDone == 1)
  {
  }
  else
  {
    return 0;
  }
  
  
  //���ϰ����ң��ȿ��������������������
  if(
    (BlackRightHeadLine > BrickHeadRow)                                         //����ͷ̫��
  ||(BlackRightCrossDone != 0 && BlackRightRow1RealLastLine  > BrickHeadRow)    //���߿�����ʮ���ټ�⣬�ҵ�1�κ�����ʼ��̫����
    )
  {
    //������������������п��������ϰ���ֱ���������ϰ�ȥ������ϰ���
  }
  else
  {
    //1.1 �ϰ��ߣ���С���˷�����ɨ����ʼ�кͽ����еĺڵ������С�
    //ȡBrickSlopeRowNum������Ϊ��С���˷��Ļ�׼�㡣
    //�����Ͻ�Ϊԭ�㣬����Ϊx������������Ϊy��������
    index = 0;    
    for(i = BrickEndRow + 1; ; i++)
    {
      if(BlackLeftLoc[i][0] != MaxValUint8)
      {
        y[index] = BlackLeftLoc[i][0];
        x[index] = i;
        index++;
      }
      if(index == BrickSlopeRowNum)
      {
        break;  
      }
      if(i == CameraHight - 1)
      {
        return 0;
      }
    }
    
    //��С���˷�
    //y = a0 + a1 * x������������LeastSquareMulti����
    a1 = LeastSquarea1(x, y, BrickSlopeRowNum);
    //��ߣ�б��Ӧ����-PathJudgeStraightSlopeLimit~0,����б�ʲ��ԣ�����ʧ�ܡ�
    if(a1 < 0 && a1 + PathJudgeStraightSlopeLimit > 0)
    {
    }
    else
    {
      return 0;
    }
    a0 = LeastSquarea0(x, y, a1, BrickSlopeRowNum);
    //ֱ�����ε�����ͻ������������
    //��ʼ�У����У��ڵ������С�
    BrickEndColL = (a0 + a1 * BrickEndRow) / LeastSquareMulti + BrickColCom;
    //�����У�Զ�У��ڵ�������
    BrickHeadColL = (a0 + a1 * BrickHeadRow) / LeastSquareMulti + BrickColCom;
    //ֱ�����ε�ֱ�Ǳ������С����ϰ�ɨ����ұ߽硣��΢�޷�һ�¡�
    //���ܳ���ͼ���ұ߽�
    BrickBorderColL = MinRe(CameraRealWidth - 1, BrickEndColL + BrickScanColNum);
    //���ܳ����������ߺڵ㡣
    if(BlackRightLoc[BrickEndRow][0] != MaxValUint8)
    {
      BrickBorderColL = MinRe(BrickBorderColL, BlackRightLoc[BrickEndRow][0]);
    }
    else
    {
    }
    
    //1.2 �ϰ��ߣ���ʼɨ��
    count2 = 0;
    for(row = BrickHeadRow; ; row++)
    {
      //��ĳһ�еĴ���
      //���кڵ��������������ɨ�衣
      count1 = 0;
      //��ǰ�е�ɨ����߽硣
      tempend = (a0 + a1 * row) / LeastSquareMulti + BrickColCom;   //�ǵó������ӵı���
      for(col = BrickBorderColL; ; col--)
      {
        if(ImgNew[row][col] < LimitLeftB)  //����
        {
          count1++;
        }
        else
        {
        }
        //����ɨ�����߽硣
        if(col <= tempend || col == 0) break;
      }
      //���кڵ��������BrickLineBlackCountNum��ʱ�����м�����1.
      if(count1 > BrickLineBlackCountNum) 
      {
        count2++;
        BrickLineCountNumRecord = count2;
        //����ڵ����������BrickLineCountNum��ʱ��������ж�Ϊ���ϰ���
        if(count2 > BrickLineCountNum) 
        {
          //����ֱ�ӷ��سɹ�������Ҫ���ұ߽��м�⡣
          break;
        }
        else
        {      
        }
      }
      else
      {
      }
      if(row == BrickEndRow) break;
    }
    
    //2. ���ϰ���ȷ��
    if(row != BrickEndRow)
    {
      //2. 1 ���ϰ�����С���˷�
      index = 0;    
      for(i = BrickEndRow + 1; ; i++)
      {
        if(BlackRightLoc[i][0] != MaxValUint8)
        {
          y[index] = BlackRightLoc[i][0];
          x[index] = i;
          index++;
        }
        if(index == BrickSlopeRowNum)
        {
          break;  
        }
        if(i == CameraHight - 1)
        {
          return 0;
        }
      }
      
      //��С���˷�
      //y = a0 + a1 * x������������LeastSquareMulti����
      a1 = LeastSquarea1(x, y, BrickSlopeRowNum);
      //�ұߣ�б��Ӧ����0~PathJudgeStraightSlopeLimit,����б�ʲ��ԣ�����ʧ�ܡ�
      if(a1 > 0 && a1 < PathJudgeStraightSlopeLimit)
      {
      }
      else
      {
        return 0;
      }
      a0 = LeastSquarea0(x, y, a1, BrickSlopeRowNum);
      //ֱ�����ε�����ͻ������������
      //��ʼ�У����У��ڵ������С�
      BrickEndColR = (a0 + a1 * BrickEndRow) / LeastSquareMulti - BrickColCom;
      //�����У�Զ�У��ڵ�������
      BrickHeadColR = (a0 + a1 * BrickHeadRow) / LeastSquareMulti - BrickColCom;
      //ֱ�����ε�ֱ�Ǳ������С����ϰ��ķ��ϰ��ߣ�Ҳ�����ұ�ֱ�����ε�ֱ�Ǳߡ����ܱ���ֱ�����ε�ֱ�Ǳ߻�С��
      BrickBorderColR = MaxRe(BrickEndColR - BrickScanColNum / 2, BrickBorderColL);
   
      //2.2 ���ϰ��ߣ���ʼɨ�裬�ҵ��ڵ������У������ϰ�ȷ��ʧ�ܡ��������ϰ�ɨ�衣
      for(row = BrickHeadRow; ; row++)
      {
        //��ĳһ�еĴ���
        //���кڵ��������������ɨ�衣
        count3 = 0;
        //��ǰ�е�ɨ����ұ߽硣
        tempend = (a0 + a1 * row) / LeastSquareMulti - BrickColCom;   //�ǵó������ӵı���
        //�޷���
        tempend = MaxRe(tempend, BrickBorderColR);
        //�ڵ�ɨ�衣
        for(col = BrickBorderColR; ; col++)
        {
          if(ImgNew[row][col] < LimitRightB)  //����
          {
            count3++;
          }
          else
          {
          }
          //����ɨ�����߽�
          if(col >= tempend || col == CameraRealWidth - 1) break;
        }
        //���кڵ��������BrickLineBlackCountNum��ʱ�����м�����1.
        if(count3 > BrickLineBlackCountNum) 
        {
          //�������кڵ���࣬��ֱ��������
          break;
        }
        else
        {
        }
        
        if(row == BrickEndRow) break;
      }
      
      //3. ����ȷ��
      if(row == BrickEndRow)
      {
        //�����ϰ���־
        PathType = PathBrickLeft;
        return 1;
      }
      else
      {
      }
    }
    //��Ч�в��������ý����ұߵ�ȷ�ϣ�ֱ�ӽ������ϰ���⡣
    else
    {
    }

  }
  
  
  //���ϰ����Ҳ��ɹ�����Ҫ���ң���ʼ���ϰ����ҡ��ȿ����Ƿ��������������
  if(
    (BlackLeftHeadLine > BrickHeadRow)                                         //����ͷ̫��
  ||(BlackLeftCrossDone != 0 && BlackLeftRow1RealLastLine  > BrickHeadRow)    //���߿�����ʮ���ټ�⣬�ҵ�1�κ�����ʼ��̫����
    )
  {
    //��������������������ϰ��������ܣ������κμ�⡣ֱ�ӷ���ʧ�ܡ�
    return 0;
  }
  else
  {
    //1.1 �ϰ��ߣ��ұߡ���С���˷�����ɨ����ʼ�кͽ����еĺڵ������С�
    //ȡBrickSlopeRowNum������Ϊ��С���˷��Ļ�׼�㡣
    //�����Ͻ�Ϊԭ�㣬����Ϊx������������Ϊy��������
    index = 0;    
    for(i = BrickEndRow + 1; ; i++)
    {
      if(BlackRightLoc[i][0] != MaxValUint8)
      {
        y[index] = BlackRightLoc[i][0];
        x[index] = i;
        index++;
      }
      if(index == BrickSlopeRowNum)
      {
        break;  
      }
      if(i == CameraHight - 1)
      {
        return 0;
      }
    }
    
    //��С���˷�
    //y = a0 + a1 * x������������LeastSquareMulti����
    a1 = LeastSquarea1(x, y, BrickSlopeRowNum);
    //�ұߣ�б��Ӧ����0~PathJudgeStraightSlopeLimit,����б�ʲ��ԣ�����ʧ�ܡ�
    if(a1 > 0 && a1 < PathJudgeStraightSlopeLimit)
    {
    }
    else
    {
      return 0;
    }
    a0 = LeastSquarea0(x, y, a1, BrickSlopeRowNum);
    //ֱ�����ε�����ͻ������������
    //��ʼ�У����У��ڵ������С�
    BrickEndColR = (a0 + a1 * BrickEndRow) / LeastSquareMulti - BrickColCom;
    //�����У�Զ�У��ڵ�������
    BrickHeadColR = (a0 + a1 * BrickHeadRow) / LeastSquareMulti - BrickColCom;
    //ֱ�����ε�ֱ�Ǳ������С����ϰ�ɨ�����߽硣��΢�޷�һ�¡�
    //���ܳ���ͼ����߽�
    BrickBorderColR = MaxRe(0, BrickEndColR - BrickScanColNum);
    //���ܳ����������ߺڵ㡣
    if(BlackLeftLoc[BrickEndRow][0] != MaxValUint8)
    {
      BrickBorderColR = MaxRe(BrickBorderColR, BlackLeftLoc[BrickEndRow][0]);
    }
    else
    {
    }
    
    //1.2 �ϰ��ߣ���ʼɨ��
    count2 = 0;
    for(row = BrickHeadRow; ; row++)
    {
      //��ĳһ�еĴ���
      //���кڵ����
      count1 = 0;
      //��������ɨ�衣
      tempend = (a0 + a1 * row) / LeastSquareMulti - BrickColCom;   //�ǵó������ӵı���
      for(col = BrickBorderColR; ; col++)
      {
        if(ImgNew[row][col] < LimitRightB)  //����
        {
          count1++;
        }
        else
        {
        }
        //����ɨ�����߽硣
        if(col >= tempend || col == CameraRealWidth - 1) break;
      }
      //���кڵ��������BrickLineBlackCountNum��ʱ�����м�����1.
      if(count1 > BrickLineBlackCountNum) 
      {
        count2++;
        BrickLineCountNumRecord = count2;
        //����ڵ����������BrickLineCountNum��ʱ��������ж�Ϊ���ϰ���
        if(count2 > BrickLineCountNum) 
        {
          //����ֱ�ӷ��سɹ�������Ҫ����߽��м�⡣
          break;
        }
        else
        {      
        }
      }
      else
      {
      }
      if(row == BrickEndRow) break;
    }
    
    //2. ���ϰ���ȷ�ϣ���ߡ�
    if(row != BrickEndRow)
    {
      //2. 1 ���ϰ�����С���˷�
      index = 0;    
      for(i = BrickEndRow + 1; ; i++)
      {
        if(BlackLeftLoc[i][0] != MaxValUint8)
        {
          y[index] = BlackLeftLoc[i][0];
          x[index] = i;
          index++;
        }
        if(index == BrickSlopeRowNum)
        {
          break;  
        }
        if(i == CameraHight - 1)
        {
          return 0;
        }
      }
      
      //��С���˷�
      //y = a0 + a1 * x������������LeastSquareMulti����
      a1 = LeastSquarea1(x, y, BrickSlopeRowNum);
      //��ߣ�б��Ӧ����-PathJudgeStraightSlopeLimit~0,����б�ʲ��ԣ�����ʧ�ܡ�
      if(a1 < 0 && a1 + PathJudgeStraightSlopeLimit > 0)
      {
      }
      else
      {
        return 0;
      }
      a0 = LeastSquarea0(x, y, a1, BrickSlopeRowNum);
      //ֱ�����ε�����ͻ������������
      //��ʼ�У����У��ڵ������С�
      BrickEndColL = (a0 + a1 * BrickEndRow) / LeastSquareMulti + BrickColCom;
      //�����У�Զ�У��ڵ�������
      BrickHeadColL = (a0 + a1 * BrickHeadRow) / LeastSquareMulti + BrickColCom;
      //ֱ�����ε�ֱ�Ǳ������С����ϰ��ķ��ϰ��ߣ�Ҳ�������ֱ�����ε�ֱ�Ǳߡ����ܱ���ֱ�����ε�ֱ�Ǳ߻���
      BrickBorderColL = MinRe(BrickEndColL + BrickScanColNum / 2, BrickBorderColR);
   
      //2.2 ���ϰ��ߣ���ʼɨ�裬�ҵ��ڵ������У������ϰ�ȷ��ʧ�ܡ�
      for(row = BrickHeadRow; ; row++)
      {
        //��ĳһ�еĴ���
        //���кڵ����
        count3 = 0;
        //��������ɨ�衣
        tempend = (a0 + a1 * row) / LeastSquareMulti + BrickColCom;   //�ǵó������ӵı���
        //�޷���
        tempend = MinRe(tempend, BrickBorderColL);
        //�ڵ�ɨ�衣
        for(col = BrickBorderColL; ; col--)
        {
          if(ImgNew[row][col] < LimitLeftB)  //����
          {
            count3++;
          }
          else
          {
          }
          //����ɨ�����߽�
          if(col <= tempend || col == 0) break;
        }
        //���кڵ��������BrickLineBlackCountNum��ʱ�����м�����1.
        if(count3 > BrickLineBlackCountNum) 
        {
          //�������кڵ���࣬��ֱ��������
          break;
        }
        else
        {
        }
        
        if(row == BrickEndRow) break;
      }
      
      //3. ����ȷ��
      if(row == BrickEndRow)
      {
        //�����ϰ���־
        PathType = PathBrickRight;
        return 1;
      }
      else
      {
        return 0;
      }
    }
    //��Ч�в��������ý����ұߵ�ȷ�ϣ�ֱ�ӷ���ʧ�ܡ�
    else
    {
      return 0;
    }
  }
  
}



//ֱ�Ǻڿ��⡣0δ��⵽��1��⵽��
//ֱ�Ǻڿ��п��ܱ����г��ϰ������ϰ������ܱ����г�ֱ�Ǻڿ飬�����ȼ��ֱ�Ǻڿ顣
//�ж�����Ϊ������ͷ����4���ڣ��Ҷ��ڵ�25�е���40�У�������Զ��ͷ����Զ4�С�5�е������У���С���˷�������ÿ�������㣬
//���ڼ�ȥ5�����ҵ�ԣ����Ȼ������֮���ǲ��Ƕ�С�ںڵ���ֵ�����ǣ����жϳɹ���
uint8 AngleZoneJudge(void)
{
  uint8 countcol, count1, count2;
  
  int32 a0, a1;
  uint8 i, index;
  
  uint8 x[BrickSlopeRowNum];   //ȡ���ٸ�����һ��ʼ�ж��塣
  uint8 y[BrickSlopeRowNum];
  uint8 col;
  
  //��β�������жϣ�����ѧ��
  
  if(
    (BlackLeftDone == 1 && BlackRightDone == 1)
  &&(AbsInt(BlackLeftHeadLine - BlackRightHeadLine) <= AngleZoneHeadLineNum)      //��ͷ�������8����
  &&(BlackLeftHeadLine < AngleZoneJudgeRowNear && BlackLeftHeadLine > AngleZoneJudgeRowFar)  //��ͷ������ĳ����֮������򣬴����25-40��֮��
  &&(BlackRightHeadLine < AngleZoneJudgeRowNear && BlackRightHeadLine > AngleZoneJudgeRowFar)  //��ͷ������ĳ����֮������򣬴����25-40��֮��  
    )
  {
  }
  else
  {
    return 0;
  }
  
  //���մ������⣬���������д����䡣������ͷ������ͷ�ߡ�
  //�����߼���һЩ�ڿ飬���߼����һЩ�ڿ顣
  if(BlackBigChangeFinalCheckFlag == 1 || BlackRightHeadLine <= BlackLeftHeadLine)
  {
    //1. ���ߡ�����һЩ�ڿ顣
    //1.1 ȡ����ͷ��Զ��5�����ҡ�
    for(i = 0; ; i++)
    {
      AngleZoneJudgeRowR[i] = BlackRightHeadLine - i - 1;
        
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //1.2 ��С���˷�
    //ȡAngleZoneSlopeRowNum������Ϊ��С���˷��Ļ�׼�㡣
    //�����Ͻ�Ϊԭ�㣬����Ϊx������������Ϊy��������
    //���ǵ�ֱ�Ǻڿ���������ڻ��������˳����ˣ�����ֱ�Ǻڿ鶨λ��ʱ�򣬲�����ͷ���ҿ�ʼ��������8�У������������8�С�
    index = 0;
    for(i = BlackRightHeadLine + 2; ; i++)
    {
      if(BlackRightLoc[i][0] != MaxValUint8)
      {
        y[index] = BlackRightLoc[i][0];
        x[index] = i;
        index++;
      }
      if(index == AngleJudgeSlopeRowNum)
      {
        break;  
      }
      
      if(i == CameraHight - 1) return 0;
    }
    //��С���˷�
    //y = a0 + a1 * x������������LeastSquareMulti����
    a1 = LeastSquarea1(x, y, AngleJudgeSlopeRowNum);
    //�ұߣ�б��Ӧ����0~PathJudgeStraightSlopeLimit,����б�ʲ��ԣ�����ʧ�ܡ�
    if(a1 > 0 && a1 < PathJudgeStraightSlopeLimit)
    {
    }
    else
    {
      return 0;
    }
    a0 = LeastSquarea0(x, y, a1, AngleJudgeSlopeRowNum);
    //1.3 �������5�е��ұ߽硣��־λ���㡣
    //Ҫ���м���AngleZoneCheckRowCom�е�ԣ����
    for(i = 0; ; i++)
    {
      //������ͷ��������С���˷����ǱȽ�׼�ģ���������̫���С�
      AngleZoneJudgeColR[i] = (a0 + a1 * AngleZoneJudgeRowR[i]) / LeastSquareMulti - AngleZoneJudgeRowCom;  
      AngleZoneJudgeColRFlag[i] = 0;
      
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //1.4 �ұ߽�ȷ��������һ����������ڣ�ֻ���������ж��Ǻڵ㣬�����ֱ�Ǻڿ��жϳɹ���2�����Ҽ�������ȷ������OK��
    for(i = 0; ; i++)
    {
      //ÿ�е��кڵ�������㡣
      countcol = 0;
      //��������ɨһ��������ȡ��������Ԥ��Ϊ70�����ҡ�
      if(AngleZoneJudgeColR[i] - AngleZoneJudgeRoadWidth < 0)
      {
        return 0;
      }
      else
      {
      }      
      for(col = AngleZoneJudgeColR[i] - AngleZoneJudgeRoadWidth; ; col++)
      {
        //��⵽��Ч�ڵ㣬������1.
        if(ImgNew[AngleZoneJudgeRowR[i]][col] < LimitRightB) countcol++;
        //�����Һڵ㹻�ࡣ�ñ�־λ��������
        if(countcol >= AngleZoneJudgeBlackNumP)  //���Ʊ�ȡ45�����ң����ϰ���
        {
          AngleZoneJudgeColRFlag[i] = 1;
          break;
        }
        //ֱ����70��Ҳû�дչ��ڵ�����������
        if(col == AngleZoneJudgeColR[i]) break;
      }
      //��¼���е���Ч�ڵ������Թ�ȷ�����ʵ���ֵ��
      AngleZoneJudgeCountColR[i] = countcol;
        
      //�����һ���ˣ��˳���
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //1.5 ����ǲ���������2���������������У������������ߣ����ޣ���ֱ�ӷ���ʧ�ܡ�
    count1 = 0;
    for(i = 0; ; i++)
    {
      if(AngleZoneJudgeColRFlag[i] == 1) count1++;
      
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //��ʱ�����ԡ�����ͷ��ֵ�ϴ�ʱ�����Ʊߵ�45��ֻҪ��һ�С�����Ҫ��2�С�
    if(AbsInt(BlackLeftHeadLine - BlackRightHeadLine) > 5)
    {
      if(count1 >= 1)
      {
      }
      else
      {
        return 0;
      }
    }
    else
    {
      if(count1 >= 2)
      {
      }
      else
      {
        return 0;
      }
    }
    
    //2. ���ߡ������һЩ�ڿ顣
    //2.1 ȡ����ͷ��Զ��5�����ҡ����Ʊ���ͷ��ȥ�ĵ�һ��һ���ǲ���������ô��ڵ�ģ�����Ҫ�ٹ�ȥһ�С�
    for(i = 0; ; i++)
    {
      AngleZoneJudgeRowL[i] = BlackLeftHeadLine - i - 1 - 1;
        
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //2.2 ��С���˷�
    //ȡAngleZoneSlopeRowNum������Ϊ��С���˷��Ļ�׼�㡣
    //�����Ͻ�Ϊԭ�㣬����Ϊx������������Ϊy��������
    //���ǵ�ֱ�Ǻڿ���������ڻ��������˳����ˣ�����ֱ�Ǻڿ鶨λ��ʱ�򣬲�����ͷ���ҿ�ʼ��������8�У������������8�С�
    index = 0;
    for(i = BlackLeftHeadLine + 2; ; i++)
    {
      if(BlackLeftLoc[i][0] != MaxValUint8)
      {
        y[index] = BlackLeftLoc[i][0];
        x[index] = i;
        index++;
      }
      if(index == AngleJudgeSlopeRowNum)
      {
        break;  
      }
      
      if(i == CameraHight - 1) return 0;
    }
    //��С���˷�
    //y = a0 + a1 * x������������LeastSquareMulti����
    a1 = LeastSquarea1(x, y, AngleJudgeSlopeRowNum);
    //��ߣ�б��Ӧ����-PathJudgeStraightSlopeLimit~0,����б�ʲ��ԣ�����ʧ�ܡ�
    if(a1 < 0 && a1 + PathJudgeStraightSlopeLimit > 0)
    {
    }
    else
    {
      return 0;
    }
    a0 = LeastSquarea0(x, y, a1, AngleJudgeSlopeRowNum);
    //2.3 �������5�е���߽硣��־λ���㡣
    //Ҫ���м���AngleZoneCheckRowCom�е�ԣ����
    for(i = 0; ; i++)
    {
      //������ͷ��������С���˷����ǱȽ�׼�ģ���������̫���С�
      AngleZoneJudgeColL[i] = (a0 + a1 * AngleZoneJudgeRowL[i]) / LeastSquareMulti + AngleZoneJudgeRowCom;  
      AngleZoneJudgeColLFlag[i] = 0;
      
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //2.4 ��߽�ȷ��������һ����������ڣ�ֻ���������ж��Ǻڵ㣬�����ֱ�Ǻڿ��жϳɹ���2�����Ҽ�������ȷ������OK��
    for(i = 0; ; i++)
    {
      //ÿ�е��кڵ�������㡣
      countcol = 0;
      //��������ɨ���������ȡ��������Ԥ��Ϊ70�����ҡ�
      if(AngleZoneJudgeColL[i] + AngleZoneJudgeRoadWidth / 2 > CameraRealWidth - 1) //���Ʊ�ֻ����ɨ����������ȡ���ֹ�ϰ������г�ֱ�Ǻڿ顣
      {
        return 0;
      }
      else
      {
      }
      for(col = AngleZoneJudgeColL[i] + AngleZoneJudgeRoadWidth /2 ; ; col--) //���Ʊ�ֻ����ɨ����������ȡ���ֹ�ϰ������г�ֱ�Ǻڿ顣
      {
        //��⵽��Ч�ڵ㣬������1.
        if(ImgNew[AngleZoneJudgeRowL[i]][col] < LimitLeftB) countcol++;
        //�����Һڵ㹻�ࡣ�ñ�־λ��������
        if(countcol >= AngleZoneJudgeBlackNumN)  //���Ʊ�ȡ20�����ң��ȵ��߿�ȶࡣ
        {
          AngleZoneJudgeColLFlag[i] = 1;
          break;
        }
        //ֱ����70��Ҳû�дչ��ڵ�����������
        if(col == AngleZoneJudgeColL[i]) break;
      }
      //��¼���е���Ч�ڵ������Թ�ȷ�����ʵ���ֵ��
      AngleZoneJudgeCountColL[i] = countcol;
        
      //�����һ���ˣ��˳���
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //2.5 ����ǲ���������2���������������У���ȷ�����ͼ����ֱ�Ǻڿ飬�����������͡���ͷ�����سɹ������ޣ��򷵻�ʧ�ܡ�
    count2 = 0;
    for(i = 0; ; i++)
    {
      if(AngleZoneJudgeColLFlag[i] == 1) count2++;
      
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    if(count2 >= 2)
    {
      //�������ͣ�ֱ�Ǻ�ɫ����
      PathType = PathAngleZone; 
      
      //����ͷ������Զ��ͷ��������ͷ������ʹԶ�����в�����̫ƫ��
      //��ͷ��ͬ�����ô���
      if(BlackLeftHeadLine == BlackRightHeadLine)
      {
      }
      //����ͷ��Զ
      else if(BlackLeftHeadLine < BlackRightHeadLine)
      {
        //ɾ������ͷ��������ͷ�Ĳ��֡�
        for(i = BlackLeftHeadLine; ; i++)
        {
          if(i == BlackRightHeadLine) break;
          
          BlackLeftLoc[i][0] = MaxValUint8;
        }
        //����ͷ��ֵ���¡�
        BlackLeftHeadLine = BlackRightHeadLine;
      }
      //����ͷ��Զ
      else
      {
        //ɾ������ͷ��������ͷ�Ĳ��֡�
        for(i = BlackRightHeadLine; ; i++)
        {
          if(i == BlackLeftHeadLine) break;
          
          BlackRightLoc[i][0] = MaxValUint8;
        }
        //����ͷ��ֵ���¡�
        BlackRightHeadLine = BlackLeftHeadLine;        
      }
            
      return 1;
    }
    else
    {
      return 0;
    }

  }
  //���մ������⣬���������д����䡣������ͷ������ͷ�ߡ�
  //�����߼���һЩ�ڿ飬���߼����һЩ�ڿ顣
  else if(BlackBigChangeFinalCheckFlag == 2  || BlackLeftHeadLine < BlackRightHeadLine)
  {
    //1. ���ߡ�����һЩ�ڿ顣
    //2.1 ȡ����ͷ��Զ��5�����ҡ�
    for(i = 0; ; i++)
    {
      AngleZoneJudgeRowL[i] = BlackLeftHeadLine - i - 1;
        
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //1.2 ��С���˷�
    //ȡAngleZoneSlopeRowNum������Ϊ��С���˷��Ļ�׼�㡣
    //�����Ͻ�Ϊԭ�㣬����Ϊx������������Ϊy��������
    //���ǵ�ֱ�Ǻڿ���������ڻ��������˳����ˣ�����ֱ�Ǻڿ鶨λ��ʱ�򣬲�����ͷ���ҿ�ʼ��������8�У������������8�С�
    index = 0;
    for(i = BlackLeftHeadLine + 2; ; i++)
    {
      if(BlackLeftLoc[i][0] != MaxValUint8)
      {
        y[index] = BlackLeftLoc[i][0];
        x[index] = i;
        index++;
      }
      if(index == AngleJudgeSlopeRowNum)
      {
        break;  
      }
      
      if(i == CameraHight - 1) return 0;
    }
    //��С���˷�
    //y = a0 + a1 * x������������LeastSquareMulti����
    a1 = LeastSquarea1(x, y, AngleJudgeSlopeRowNum);
    //��ߣ�б��Ӧ����-PathJudgeStraightSlopeLimit~0,����б�ʲ��ԣ�����ʧ�ܡ�
    if(a1 < 0 && a1 + PathJudgeStraightSlopeLimit > 0)
    {
    }
    else
    {
      return 0;
    }
    a0 = LeastSquarea0(x, y, a1, AngleJudgeSlopeRowNum);
    //1.3 �������5�е���߽硣��־λ���㡣
    //Ҫ���м���AngleZoneCheckRowCom�е�ԣ����
    for(i = 0; ; i++)
    {
      //������ͷ��������С���˷����ǱȽ�׼�ģ���������̫���С�
      AngleZoneJudgeColL[i] = (a0 + a1 * AngleZoneJudgeRowL[i]) / LeastSquareMulti + AngleZoneJudgeRowCom;  
      AngleZoneJudgeColLFlag[i] = 0;
      
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //1.4 ��߽�ȷ��������һ����������ڣ�ֻ���������ж��Ǻڵ㣬�����ֱ�Ǻڿ��жϳɹ���2�����Ҽ�������ȷ������OK��
    for(i = 0; ; i++)
    {
      //ÿ�е��кڵ�������㡣
      countcol = 0;
      //��������ɨһ��������ȡ��������Ԥ��Ϊ70�����ҡ�
      if(AngleZoneJudgeColL[i] + AngleZoneJudgeRoadWidth > CameraRealWidth - 1)
      {
        return 0;
      }
      else
      {
      }
      for(col = AngleZoneJudgeColL[i] + AngleZoneJudgeRoadWidth; ; col--)
      {
        //��⵽��Ч�ڵ㣬������1.
        if(ImgNew[AngleZoneJudgeRowL[i]][col] < LimitLeftB) countcol++;
        //�����Һڵ㹻�ࡣ�ñ�־λ��������
        if(countcol >= AngleZoneJudgeBlackNumP)  //���Ʊ�ȡ45�����ң����ϰ��ࡣ
        {
          AngleZoneJudgeColLFlag[i] = 1;
          break;
        }
        //ֱ����70��Ҳû�дչ��ڵ�����������
        if(col == AngleZoneJudgeColL[i]) break;
      }
      //��¼���е���Ч�ڵ������Թ�ȷ�����ʵ���ֵ��
      AngleZoneJudgeCountColL[i] = countcol;
        
      //�����һ���ˣ��˳���
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //1.5 ����ǲ���������2���������������У������������ߣ����ޣ���ֱ�ӷ���ʧ�ܡ�
    count2 = 0;
    for(i = 0; ; i++)
    {
      if(AngleZoneJudgeColLFlag[i] == 1) count2++;
      
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //��ʱ�����ԡ�����ͷ��ֵ�ϴ�ʱ�����Ʊߵ�45��ֻҪ��һ�С�����Ҫ��2�С�
    if(AbsInt(BlackLeftHeadLine - BlackRightHeadLine) > 5)
    {
      if(count2 >= 1)
      {
      }
      else
      {
        return 0;
      }
    }
    else
    {
      if(count2 >= 2)
      {
      }
      else
      {
        return 0;
      }
    }
       
    //2. ���ߡ������һЩ�ڿ顣
    //2.1 ȡ����ͷ��Զ��5�����ҡ����Ʊ���ͷ��ȥ�ĵ�һ��һ���ǲ���������ô��ڵ�ģ�����Ҫ�ٹ�ȥһ�С�
    for(i = 0; ; i++)
    {
      AngleZoneJudgeRowR[i] = BlackRightHeadLine - i - 1 - 1;
        
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //2.2 ��С���˷�
    //ȡAngleZoneSlopeRowNum������Ϊ��С���˷��Ļ�׼�㡣
    //�����Ͻ�Ϊԭ�㣬����Ϊx������������Ϊy��������
    //���ǵ�ֱ�Ǻڿ���������ڻ��������˳����ˣ�����ֱ�Ǻڿ鶨λ��ʱ�򣬲�����ͷ���ҿ�ʼ��������8�У������������8�С�
    index = 0;
    for(i = BlackRightHeadLine + 2; ; i++)
    {
      if(BlackRightLoc[i][0] != MaxValUint8)
      {
        y[index] = BlackRightLoc[i][0];
        x[index] = i;
        index++;
      }
      if(index == AngleJudgeSlopeRowNum)
      {
        break;  
      }
      
      if(i == CameraHight - 1) return 0;
    }
    //��С���˷�
    //y = a0 + a1 * x������������LeastSquareMulti����
    a1 = LeastSquarea1(x, y, AngleJudgeSlopeRowNum);
    //�ұߣ�б��Ӧ����0~PathJudgeStraightSlopeLimit,����б�ʲ��ԣ�����ʧ�ܡ�
    if(a1 > 0 && a1 < PathJudgeStraightSlopeLimit)
    {
    }
    else
    {
      return 0;
    }
    a0 = LeastSquarea0(x, y, a1, AngleJudgeSlopeRowNum);
    //2.3 �������5�е��ұ߽硣��־λ���㡣
    //Ҫ���м���AngleZoneCheckRowCom�е�ԣ����
    for(i = 0; ; i++)
    {
      //������ͷ��������С���˷����ǱȽ�׼�ģ���������̫���С�
      AngleZoneJudgeColR[i] = (a0 + a1 * AngleZoneJudgeRowR[i]) / LeastSquareMulti - AngleZoneJudgeRowCom;  
      AngleZoneJudgeColRFlag[i] = 0;
      
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //2.4 �ұ߽�ȷ��������һ����������ڣ�ֻ���������ж��Ǻڵ㣬�����ֱ�Ǻڿ��жϳɹ���2�����Ҽ�������ȷ������OK��
    for(i = 0; ; i++)
    {
      //ÿ�е��кڵ�������㡣
      countcol = 0;
      //��������ɨ���������ȡ��������Ԥ��Ϊ70�����ҡ�
      if(AngleZoneJudgeColR[i] - AngleZoneJudgeRoadWidth / 2 < 0) //���Ʊ�ֻ����ɨ����������ȡ���ֹ�ϰ������г�ֱ�Ǻڿ顣
      {
        return 0;
      }
      else
      {
      }      
      for(col = AngleZoneJudgeColR[i] - AngleZoneJudgeRoadWidth / 2; ; col++) //���Ʊ�ֻ����ɨ����������ȡ���ֹ�ϰ������г�ֱ�Ǻڿ顣
      {
        //��⵽��Ч�ڵ㣬������1.
        if(ImgNew[AngleZoneJudgeRowR[i]][col] < LimitRightB) countcol++;
        //�����Һڵ㹻�ࡣ�ñ�־λ��������
        if(countcol >= AngleZoneJudgeBlackNumN)  //���Ʊ�ȡ20�����ң��ȵ��߿�ȶ�
        {
          AngleZoneJudgeColRFlag[i] = 1;
          break;
        }
        //ֱ����70��Ҳû�дչ��ڵ�����������
        if(col == AngleZoneJudgeColR[i]) break;
      }
      //��¼���е���Ч�ڵ������Թ�ȷ�����ʵ���ֵ��
      AngleZoneJudgeCountColR[i] = countcol;      
        
      //�����һ���ˣ��˳���
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    //2.5 ����ǲ���������2���������������У���ȷ�����ͼ����ֱ�Ǻڿ飬�����������͡���ͷ�����سɹ������ޣ��򷵻�ʧ�ܡ�
    count1 = 0;
    for(i = 0; ; i++)
    {
      if(AngleZoneJudgeColRFlag[i] == 1) count1++;
      
      if(i == AngleZoneJudgeRowNum - 1) break;
    }
    if(count1 >= 2)
    {
      //�������ͣ�ֱ�Ǻ�ɫ����
      PathType = PathAngleZone; 
      
      //����ͷ������Զ��ͷ��������ͷ������ʹԶ�����в�����̫ƫ��
      //��ͷ��ͬ�����ô���
      if(BlackLeftHeadLine == BlackRightHeadLine)
      {
      }
      //����ͷ��Զ
      else if(BlackLeftHeadLine < BlackRightHeadLine)
      {
        //ɾ������ͷ��������ͷ�Ĳ��֡�
        for(i = BlackLeftHeadLine; ; i++)
        {
          if(i == BlackRightHeadLine) break;
          
          BlackLeftLoc[i][0] = MaxValUint8;
        }
        //����ͷ��ֵ���¡�
        BlackLeftHeadLine = BlackRightHeadLine;
      }
      //����ͷ��Զ
      else
      {
        //ɾ������ͷ��������ͷ�Ĳ��֡�
        for(i = BlackRightHeadLine; ; i++)
        {
          if(i == BlackLeftHeadLine) break;
          
          BlackRightLoc[i][0] = MaxValUint8;
        }
        //����ͷ��ֵ���¡�
        BlackRightHeadLine = BlackLeftHeadLine;        
      }
            
      return 1;      
    }
    else
    {
      return 0;
    }
    
  }
  //�����ϲ����ߵ����������ͷһ���и��ߵ͡�
  else
  {
  }
  
  //��̬�Ǽ��ʧ�ܡ�
  return 0;
}


//ֱ�Ǻڿ�ȷ�Ϻ���
uint8 AngleZoneConfirm(void)
{
  
  uint8 i;
  
  //ֱ�Ǻڿ������־û�б���λ��ʱ��Ž���ֱ�Ǻڿ���������ѱ���λ�����ý���ֱ�Ǻڿ������
  if(AngleZoneConfirmLockFlag == 0)
  {
    //A�μ�������B��ֱ�Ǻڿ�ɹ������ж�Ϊֱ�Ǻڿ顣�����ȳ����С�
    for(i = 0; ; i++)
    {
      AngleZoneConfirmMat[i] = AngleZoneConfirmMat[i + 1];
      if(i == AngleZoneConfirmMatNum - 2) break;
    }
    //�ɹ�
    if(PathType == PathAngleZone)
    {
      //�ж�Ϊֱ�Ǻڿ���������ֵ��1��
      AngleZoneConfirmMat[AngleZoneConfirmMatNum - 1] = 1;
    }
    else
    {
      //�ж�Ϊ��ֱ�Ǻڿ���������ֵ��0.
      AngleZoneConfirmMat[AngleZoneConfirmMatNum - 1] = 0;
    }
    //�ռ�AngleZoneConfirmMat������1�ĸ�����
    AngleZoneConfirmMatCollect = 0;
    for(i = 0; ; i++)
    {
      if(AngleZoneConfirmMat[i] == 1) AngleZoneConfirmMatCollect++;
      
      if(i == AngleZoneConfirmMatNum - 1) break;
    }
    //�������ɴΣ�������Ϊֱ�Ǻڿ顣
    if(AngleZoneConfirmMatCollect >= AngleZoneConfirmMatLimit)
    {
      //�����־λ��λ��
      AngleZoneConfirmLockFlag = 1;
      //�����־λ��λʱ��ͬʱ��1�׾����ڵļ���ֵ���㡣
      AngleZoneConfirmLockMeterCount = 0;
      //������գ���ֹ�ظ����档
      for(i = 0; ; i++)
      {
        AngleZoneConfirmMat[i] = 0;
        if(i == AngleZoneConfirmMatNum - 1) break;
      }

      //PatyType��AngleZoneJudge���Ѿ����¡�
    }
    else
    {
    }
  }
  //ֱ�Ǻڿ������ѱ���λ�����ý���ֱ�Ǻڿ������
  else
  {
  }
  
  //��ֱ�Ǻڿ������־λ��λ�����1�׵ľ����ڱ������棬����⵽������ͷ�߶Ȳ���ͷš�
  //��2 m/s�ٶȣ���1�״����Ҫ0.5s��Ҳ����30��16ms��3m/s��Ӧ20��16ms.����Ӧȡ30�����ϡ�
  if(AngleZoneConfirmLockFlag == 1)
  {
    //ֱ�Ǻڿ������ڼ䣬����ͷ��С��4����Զ����ͷɾ��������ͷ��
    if(AbsInt(BlackLeftHeadLine - BlackRightHeadLine) < 4)
    {
      //��ͷ��ͬ�����ô���
      if(BlackLeftHeadLine == BlackRightHeadLine)
      {
      }
      //����ͷ��Զ
      else if(BlackLeftHeadLine < BlackRightHeadLine)
      {   
        //ɾ������ͷ��������ͷ�Ĳ��֡�
        for(i = BlackLeftHeadLine; ; i++)
        {
          if(i == BlackRightHeadLine) break;
          
          BlackLeftLoc[i][0] = MaxValUint8;
        }
        //����ͷ��ֵ���¡�
        BlackLeftHeadLine = BlackRightHeadLine;
      }
      //����ͷ��Զ
      else
      {
        //ɾ������ͷ��������ͷ�Ĳ��֡�
        for(i = BlackRightHeadLine; ; i++)
        {
          if(i == BlackLeftHeadLine) break;
          
          BlackRightLoc[i][0] = MaxValUint8;
        }
        //����ͷ��ֵ���¡�
        BlackRightHeadLine = BlackLeftHeadLine;        
      }
    }
    else
    {
    }
    
    //Count�����壺
    //1. ֱ�Ǻڿ�����ȷ�Ϻ�Count���㡣
    //2. ֱ�Ǻڿ������ڼ䣺2.1. ��û�м�⵽ �ϰ� ���� ֱ����ͷ��������1������������ֱ���ﵽ��ֵ�������Ӧ���ǳ�ֱ�ǵ�ֱ�Ǻڿ飬��������㣬�����ٴμ��ֱ�ǡ�
    //                     2.2. ����⵽�ˣ����������
    //3. ֱ�Ǻڿ�������ڼ䣺�����Լ������κδ���
    if(AngleZoneConfirmLockFlag == 1)
    {
      if(PathType == PathTypeAngleL || PathType == PathTypeAngleR || PathType == PathBrickLeft || PathType == PathBrickRight)
      {
        //��������
        AngleZoneConfirmLockMeterCount = 0;
      }
      else
      {
        AngleZoneConfirmLockMeterCount++;
        if(AngleZoneConfirmLockMeterCount > AngleZoneConfirmLockMeterCountLimit)
        {
          //1�����ҵľ�����û�м�⵽�߶Ȳ�ͷ������־λ���ٴμ��ֱ�Ǻڿ顣
          AngleZoneConfirmLockFlag = 0;
        }
        else
        {      
        }
      }
    }
    else
    {
    }
  }
  else
  {
  }

  
  return 1;

  
  
}


//���������ж�
//����0����1������
uint8 PathJudgeNew(void)
{
  
  //0. Ĭ����������δ֪��
  PathType = PathTypeUnknown;
  

  //1. ֱ����ͷ�� �� �ϰ� �� ���� �� ������� �ڼ䣬������ֱ�ǡ�ֱ�Ǻڿ顢�ϰ��ļ�� �Լ� ֱ�� �ļ�⡣
  if(
    (AngleConfirmLockFlag == 1)   //ֱ�������ڼ�
  ||(AngleSpeDealFlag == 1)       //ֱ��ǿ�ƿ����ڼ�
  ||(BrickConfirmLockFlag == 1)   //�ϰ������ڼ�
  ||(BrickSpeDealFlag == 1)       //�ϰ���������ڼ�
  ||(GyroResultForbidFlag == 1)   //�µ���ֹ���������ж��ڼ�
    )
  {
    //������ֱ���������㡣
    PathRealStraightCount = 0;
    //�������������ڼ䣬˵���ϰ���ֱ���Ѿ��жϳɹ������Խ�ֱ�Ǻڿ������־��λ�������ж�ֱ�Ǻڿ顣
    AngleZoneConfirmLockFlag = 0;
  }
  else
  {
    //�ж�ͣ����
    //if(StopLineCheck()){StopLineCheckFlag = 1;}
    //ʮ�ֵĶ����ж�
    //if(ShiZhiCheck()) { ShiZhiFlag = 1; } else {ShiZhiFlag = 0;}
    //2.1 ֱ�Ǻڿ�δ�����ڼ䣬���ֱ�Ǻڿ� �� �ϰ��� �� ֱ���� �����ֱ����ͷ�
    if(AngleZoneConfirmLockFlag == 0)
    {
      //2.1.1. �ж�ֱ����
      if(PathJudgeNewStraight() == 1)
      {
      }
      else
      {
      }

      //2.1.2. �ȼ��ֱ�Ǻڿ���    //��첻�����
      //AngleZoneJudge();
      //2.1.3. ��ֱ�Ǻڿ��ⲻ�ɹ����ټ���ϰ��
      if(PathType != PathAngleZone)
      {
        BrickJudge();
      }
      //ֱ�Ǻڿ���ɹ����Ͳ��ü���ϰ����ˡ�
      else
      {

      }    
    }
    //2.2 ֱ�Ǻڿ������ڼ䣬����ϰ��� �� ֱ����ͷ������ֱ�Ǻڿ� �� ֱ����
    else
    {
      //2.2.1�����ڼ䣬�ȼ���ϰ��
      BrickJudge();
      //2.2.2 �ϰ���δ���ɹ�������ֱ����ͷ� 
      if(PathType != PathBrickLeft && PathType != PathBrickRight)
      {
        //AngleStep1Judge();
        
      }
      //ȷ��Ϊ�ϰ���������ֱ����ͷ��ļ�⡣Ϊ�˱������ֱ����ͷ���л���������Ժڿ��ɨ�衣
      else
      {
      }      
      
    }
  }

  //3. ��ֱ���ж�
  if(PathType == PathTypeStraight)
  {
    //�¼����ͣ���ߵļ�⣬��ֱ�Ǻ��ϰ�����ⲻ��ʱ���
    //if(StopLineCheck()){StopLineCheckFlag = 1;light_control(PORTE, 26, Light_ON);}
    
    //������ֱ��������1��
    PathRealStraightCount++;
    //���������ﵽ��ֵ
    if(PathRealStraightCount > PathRealStraightCountLimit)
    {
      //��ֱ����־��1.
      PathRealStraightFlag = 1;
      //��������
      PathRealStraightCount = 0;
    }
    else if(PathRealStraightCount > 5)
    {
        xiaoZhiDaoFlag = 1;
    }
    else
    {
    }
    
  }
  else
  {
    //һ����⵽��ֱ������������㡣
    PathRealStraightCount = 0;
    //һ����⵽��ֱ������ֱ����־��λ��
    PathRealStraightFlag = 0;
    xiaoZhiDaoFlag = 0;
  }
  
  
  
  
  
//  //1. �ж�ֱ����
//  if(PathJudgeNewStraight() == 1)
//  {
//    //2. ֱ�������������ơ��ϰ��������������ڼ䣬������ֱ�ǡ�ֱ�Ǻڿ顢�ϰ��ļ�⡣
//    if(AngleConfirmLockFlag == 1 || AngleSpeDealFlag == 1 || BrickConfirmLockFlag == 1 || BrickSpeDealFlag == 1)
//    {
//    }
//    else
//    {
//      //3. ֱ�Ǻڿ�δ�����ڼ䣬���ֱ�Ǻڿ� �� �ϰ�������ֱ����ͷ�
//      if(AngleZoneConfirmLockFlag == 0)
//      {
//        //4. �ȼ��ֱ�Ǻڿ���
//        AngleZoneJudge();
//        //5. ��ֱ�Ǻڿ��ⲻ�ɹ����ټ���ϰ��
//        if(PathType != PathAngleZone)
//        {
//          BrickJudge();
//        }
//        //ֱ�Ǻڿ���ɹ����Ͳ��ü���ϰ����ˡ�
//        else
//        {
//        }    
//      }
//      //ֱ�Ǻڿ������ڼ䣬���ֱ����ͷ������ֱ�Ǻڿ� �� �ϰ��
//      else
//      {
//        AngleStep1Judge();
//      }
//    }
//  }
//  //����ֱ����ֱ���˳���
//  else
//  {
//  }      
      
      
      
      
//  //�ж�ֱ����
//  if(PathJudgeNewStraight() == 1)
//  {
//    //�ϰ���ֱ�ǵ������ǿ�ƿ����ڼ䣬����Ҫ�����ϰ���ֱ�Ǽ�⣬�������� �� �ظ����档
//    if(AngleConfirmLockFlag == 0 && AngleSpeDealFlag == 0
//    && BrickConfirmLockFlag == 0 && BrickSpeDealFlag == 0)
//    {
//      //�ϰ��ж�
//      BrickJudge();
//      if(PathType != PathBrickLeft && PathType != PathBrickRight)
//      {
//        //��������ϰ�������Խ�һ���ж��ǲ���ֱ���䡣
//        //ֱ����ȥ����ר�Ų�ש�顣   //AngleStep1Judge();
//      }
//      else
//      {
//      }
//    }
//    else
//    {
//    }
//  }
//  else
//  {
//  }
  
  return 1;
}


//���ֱ����ĳ�ʼ����ֵ����
uint8 VariablesInit(void)
{
  uint8 i;
  
  LimitLeftWB = LimitLeftWBMin;    //�ڰ����ص�Ĳ�ֵ��������Ĳ����Ҫ�������ֵ��������Ϊ�����䡣
  LimitLeftW  = LimitLeftWMin;      //�׵����Ҫ���ڴ�ֵ
  LimitLeftB  = LimitLeftBMax;      //�ڵ����ҪС�ڴ�ֵ

  //ÿ����Чͼ���������ͷ��Ӧ��3����ֵ���������棬ÿ����Чͼ��ˢ��һ�Ρ�
  LimitLeftHeadWB = LimitLeftWBMin;    
  LimitLeftHeadW  = LimitLeftWMin;      
  LimitLeftHeadB  = LimitLeftBMax;
  
  LimitRightWB = LimitRightWBMin;    //�ڰ����ص�Ĳ�ֵ��������Ĳ����Ҫ�������ֵ��������Ϊ�����䡣
  LimitRightW  = LimitRightWMin;      //�׵����Ҫ���ڴ�ֵ
  LimitRightB  = LimitRightBMax;      //�ڵ����ҪС�ڴ�ֵ

  //ÿ����Чͼ���������ͷ��Ӧ��3����ֵ���������棬ÿ����Чͼ��ˢ��һ�Ρ�
  LimitRightHeadWB = LimitRightWBMin;    
  LimitRightHeadW = LimitRightWMin;      
  LimitRightHeadB = LimitRightBMax;  
  
  //���Һ��������ؼ�����ʼ�С���Ҫ�����м䵥�ߵĿ�ȡ�
  BlackLeftLastEdgeStartCol = CameraRealWidth/2 + SingleBlackWidthMax[CameraHight-1];
  BlackLeftEdgeStartCol = CameraRealWidth/2 + SingleBlackWidthMax[CameraHight-1];
  
  BlackRightLastEdgeStartCol = CameraRealWidth/2 - SingleBlackWidthMax[CameraHight-1]; 
  BlackRightEdgeStartCol = CameraRealWidth/2 - SingleBlackWidthMax[CameraHight-1];
  
  //�����߻�ȡʱ�����������Ե��ߵ��������ʼ��Ϊһ�������߿�ȡ�
  RoadHalfWidthSingle = SingleBlackWidthMax[CameraHight - 1];
  
  //ֱ�����־�洢���飬��ʼ��Ϊ������ֱ�ǡ�
  for(i = 0; ; i++)
  {
    AngleConfirmMat[i] = 0;
    if(i == AngleConfirmMatNum - 1) break;
  }
  
  //˫�߰��
  RoadHalfWidth = 100;
  RoadHalfWidthLast = RoadHalfWidth;
  
  return 1;
}









//======================================================================
//��������ImageProParaInit
//��  �ܣ�ÿ��ͼ����֮ǰ�Ĳ�����ʼ������
//��  ����
//��  �أ�
//Ӱ  �죺
//˵  ����
//      
//             
//======================================================================
uint8 ImageProParaInit(void)
{
  uint8 i;
  
  //ͼ����ɹ���־λ��Ĭ����1.
  ImgBlackSucceedFlag = 1;
  ImgCenterSucceedFlag = 1;
  //СS���жϱ�־��ʼ��Ϊʧ�ܡ�
  PathSmallSDoneFlag = 0;
   
  //���������鸳��Чֵ��
  for(i = 0; ; i++)
  {
    CenterLineLoc[i] = MaxValInt16;
    if(i == CameraHight - 1) break;
  }

  //��������¼ֵ
  for(i = 0; ; i++)
  {
    RoadHalfWidthRecord[i] = MaxValUint8;
    if(i == CameraHight - 1) break;
  }
  
  //ͨ����������жϳ����ĵ��ߴ����־����ʼ��Ϊδ���롣
  RoadHalfWidthWrongFlag = 2;
  
  //���ߵذ�����Ĵ���
  SingleDoneFlag = 0;       
  SingleFloorFlag = 0;            
  SingleFloorConfirmCount = 0;     
  SingleFloorConfirmCountMax = 0;

  //ÿ�еĵ���ȷ�ϱ�־��ʼ��Ϊʧ�ܡ�
  for(i = 0; ; i++)
  {
    SingleBlackFlag[i] = 0;
    if(i == CameraHight - 1) break;
  }
  //�ܷ�ͼ��ĵ��߱�־���ȴ���һ�εı�־���ٳ�ʼ��Ϊ0.
  SingleBlackLastAllFlag = SingleBlackAllFlag;
  SingleBlackAllFlag = 0;
  
  //���ߴ����־��0û����1�д���ÿ��ͼ��ʼ��Ϊ0.
  BlackSingleFlag = 0;
  
  flag222 = 0;
  
  BrickLineCountNumRecord = 0;
  
  //���մ��������־λ
  BlackBigChangeFinalCheckFlag = 0;
  
  //ֱ�Ǻڿ�
  for(i = 0; ; i++)
  {
    AngleZoneJudgeRowL[i] = 0;  //ֱ�Ǻڿ飬������ͷѡ�е�Ҫ���������С�
    AngleZoneJudgeRowR[i] = 0;  //ֱ�Ǻڿ飬������ͷѡ�е�Ҫ���������С�
    AngleZoneJudgeColL[i] = 0;  //ֱ�Ǻڿ飬���߶�λ�������С�
    AngleZoneJudgeCountColL[i] = 0;
    AngleZoneJudgeColLFlag[i] = 0; //ֱ�Ǻڿ飬���߸��е���Ч�ڵ�����Ҫ��ʱ��λ��
    AngleZoneJudgeColR[i] = 0;  //ֱ�Ǻڿ飬���߶�λ�������С�
    AngleZoneJudgeColRFlag[i] = 0; //ֱ�Ǻڿ飬���߸��е���Ч�ڵ�����Ҫ��ʱ��λ�� 
    AngleZoneJudgeCountColR[i] = 0;
    
    if(i == AngleZoneJudgeRowNum - 1) break;   
  }
  
  //�ϰ�
  BrickEndColL = 0;    //�ϰ����ֱ�����Σ���ʼ�У����У��ڵ������С�
  BrickHeadColL = 0;   //�ϰ����ֱ�����Σ������У�Զ�У��ڵ������С�
  BrickBorderColL = 0; //�ϰ����ֱ�����Σ�ֱ�Ǳ������С�
  BrickEndColR = 0;    //�ϰ����ֱ�����Σ���ʼ�У����У��ڵ������С�
  BrickHeadColR = 0;   //�ϰ����ֱ�����Σ������У�Զ�У��ڵ������С�
  BrickBorderColR = 0; //�ϰ����ֱ�����Σ�ֱ�Ǳ������С�  
  BrickSpeDealCenFlag = 1;
  
  return 1;
  
}

//ͼ��ɹ���Ĵ���
//ֻ��ͼ����ɹ��ˣ��Ż�������������жϣ��Ż����ƫ���ȡ������������ֵ�Ż���¡�
uint8 ImgProSucceedDeal(void)
{
  uint8 startline;
  
  //��һ��ͼ���յ��������ͼ��ɹ��Ż��л���
  RoadHalfWidthLast = RoadHalfWidth;
  
  /*
  //���������ж�
  //������ʱ����������ȡ�ɹ������Һ���������һ����ȡ�ɹ���
  PathJudgeDone = 1; //���������жϱ�־λ��Ĭ�ϳɹ�
  if(!PathJudge())
  {
    PathJudgeDone = 0;  //���������жϱ�־λ���ж�ʧ�ܡ�
    PathType = 0;       //����������Ϊδ֪��
    //uart_sendN(UART0, (uint8 *)"\nPathJudge Failed!", 18);
    //return 0;         //���������ж�ʧ���˻��ܼ��������÷���0.
  }
  else
  {
  }
  */
  
  //�������������飬���÷���float�͵����ݣ�ͬ���Ĵ����������λ����ɡ�
  //SendCenterLineLoc(CenterLineLoc);
  
  //SendImage(ImgNew);  
  
  //��Ϊ���ö��п��ƣ����԰�СS���ƫ������⴦��ȥ���ˡ�
  /*
  //��СS������⴦��
  if(PathType == PathTypeSmallSL || PathType == PathTypeSmallSR)
  {
    //��ΪСS�䣬�����⴦��
    PathTypeSmallDeal();
  }
  else
  {
    //����ΪСS�䣬��������ȡƫ��
    DeviationGet();        
  }
  */
       
   //����ƫ���㷨��
  //BiasFuse();
  DeviationFuse();
  MtrGet();//����DeviFuse,DeviFuse_dot��������
  
  EmergencyStopCount = 0;
  
  //��һ��ͼ��ĺ�����ʼɨ���и��£�
  ////////////���뱣֤��CameraHight - 1����Ч��
  BlackLeftLastEdgeStartCol = BlackLeftEdgeStartCol;
  BlackRightLastEdgeStartCol = BlackRightEdgeStartCol;

//  //�ϰ���������ڼ䣬����Ҫ����ɨ����㡣
//  if(BrickSpeDealFlag == 1)
//  {
//    startline = BlackCenEdgeStartCol;
//  }
//  //�����ϰ�������ƣ�������ȡɨ����㡣
//  else
//  {
    //����CameraHight-1�е�������������Ч����ȡ����
    if(CenterLineLoc[CameraHight-1] != MaxValInt16)
    {
      startline = CenterLineLoc[CameraHight-1];
    }
    //����Ч����ȡ��CameraHight-7(����5�в��ܸ���б������)�ж�Ӧ�Ľ����е�BiasCal�ļ���ֵ������б�ʹ��㣩
    else
    {
      //startline = CameraRealWidth / 2 - BiasCal(BlackUdisLeftLocation[CameraHight-7].y);
      //�������һ����ʮ�֣���ʱ���ø���BiasCal�����㣬ֱ������һ��ͼ�ľͺá��������ú��ҡ� 
      startline = BlackCenEdgeStartCol;
    }
//  }
  
  //ɨ�����Ķ�λ��
  BlackCenEdgeStartCol = BoundaryLimitRe(startline,
                                         BlackCenEdgeStartColLimitL,
                                         BlackCenEdgeStartColLimitR
                                         );
  //����һ��ͼ�ǵ��ߣ����������߷ſ�2�����߿�ȡ�
  if(SingleBlackLastAllFlag == 1)
  {
    //BlackLeftEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] + SingleBlackWidthMax[CameraHight-1],
    //��ɨ�������ڶ�λ������2�����߿�ȡ�
    BlackLeftEdgeStartCol = BoundaryLimitRe(MinRe(CameraRealWidth - 1, BlackCenEdgeStartCol + 2 * SingleBlackWidthMax[CameraHight-1]),
                                            0,
                                            CameraRealWidth-1
                                            );
    //BlackRightEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] - SingleBlackWidthMax[CameraHight-1],
    //��ɨ�������ڶ�λ������2�����߿�ȡ�
    BlackRightEdgeStartCol = BoundaryLimitRe(MaxRe(0, BlackCenEdgeStartCol - 2 * SingleBlackWidthMax[CameraHight-1]),
                                             0,
                                             CameraRealWidth-1
                                            );        
  }
  //��һ��ͼ���ǵ��ߣ�˫����������
  else
  {
    //�����ϰ����⴦��׶Ρ����Ҹ�ȡ1�����߿�ȡ�
    if(BrickSpeDealFlag == 0)
    {
      //BlackLeftEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] + SingleBlackWidthMax[CameraHight-1],
      //��ɨ�������ڶ�λ������1�����߿�ȡ�
      BlackLeftEdgeStartCol = BoundaryLimitRe(MinRe(CameraRealWidth - 1, BlackCenEdgeStartCol + SingleBlackWidthMax[CameraHight-1]),
                                              0,
                                              CameraRealWidth-1
                                              );
      //BlackRightEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] - SingleBlackWidthMax[CameraHight-1],
      //��ɨ�������ڶ�λ������1�����߿�ȡ�
      BlackRightEdgeStartCol = BoundaryLimitRe(MaxRe(0, BlackCenEdgeStartCol - SingleBlackWidthMax[CameraHight-1]),
                                               0,
                                               CameraRealWidth-1
                                              );    
    }
    //�ϰ����⴦��׶�
    else
    {
      //���ϰ�������ɨ���������һ�����߿�ȣ�����ɨ������ȡ�����ߴ���
      if(BrickSpeDealDir == 0)
      {
        //BlackLeftEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] + SingleBlackWidthMax[CameraHight-1],
        //��ɨ�����ȡ��λ�㡣
        BlackLeftEdgeStartCol = BoundaryLimitRe(MinRe(CameraRealWidth - 1, BlackCenEdgeStartCol + 1),
                                                0,
                                                CameraRealWidth-1
                                                );
        //BlackRightEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] - SingleBlackWidthMax[CameraHight-1],
        //��ɨ�������ڶ�λ������3�����߿�ȡ�
        BlackRightEdgeStartCol = BoundaryLimitRe(MaxRe(0, BlackCenEdgeStartCol - 3 * SingleBlackWidthMax[CameraHight-1]),
                                                 0,
                                                 CameraRealWidth-1
                                                );
        //��ɨ���������������������3�����߿�ȡ�
        if(BlackRightLoc[CameraHight - 1][0] != MaxValUint8)
        {
          BlackRightEdgeStartCol = BoundaryLimitRe(MinRe(BlackRightEdgeStartCol, BlackRightLoc[CameraHight - 1][0] - 3 * SingleBlackWidthMax[CameraHight-1]),
                                                  0,
                                                  CameraRealWidth-1
                                                  );
        }
        else
        {
        }        
      }
      //���ϰ�������ɨ���������һ�����߿�ȣ�����ɨ������ȡ�����ߴ���
      else
      {
        //BlackLeftEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] + SingleBlackWidthMax[CameraHight-1],
        //��ɨ�������ڶ�λ������3�����߿��
        BlackLeftEdgeStartCol = BoundaryLimitRe(MinRe(CameraRealWidth - 1, BlackCenEdgeStartCol + 3 * SingleBlackWidthMax[CameraHight-1]),
                                                0,
                                                CameraRealWidth-1
                                                );
        //BlackRightEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] - SingleBlackWidthMax[CameraHight-1],
        //��ɨ�����ȡ��λ�㡣
        BlackRightEdgeStartCol = BoundaryLimitRe(MaxRe(0, BlackCenEdgeStartCol - 1),
                                                 0,
                                                 CameraRealWidth-1
                                                );
        
        //��ɨ�������������������ұ�3�����߿�ȡ�
        if(BlackLeftLoc[CameraHight - 1][0] != MaxValUint8)
        {
          BlackLeftEdgeStartCol = BoundaryLimitRe(MaxRe(BlackLeftEdgeStartCol, BlackLeftLoc[CameraHight - 1][0] + 3 * SingleBlackWidthMax[CameraHight-1]),
                                                  0,
                                                  CameraRealWidth-1
                                                  );
        }
        else
        {
        }
      }
    }
  }
  

  
  //����ɨ��������������ɨ��������
  BlackRightEdgeStartCol = MinRe(BlackRightEdgeStartCol, BlackLeftEdgeStartCol);

  return 1;
}


//ͼ��ʧ�ܺ�Ĵ���
uint8 ImgProFailDeal(void)
{
  uint8 startline;
  int tempB, tempW, tempWB;
  
  
  //ͼ��ʧ�ܣ�ƫ���Ը���
  /*
  DeviPrePrePre=DeviPrePre;
  DeviPrePre=DeviPre;
  DeviPre=DeviFuse;
  DeviFuse=DeviPre+((DeviPre-DeviPrePre)*7+(DeviPrePre-DeviPrePrePre)*3)/10;
  MtrGet();//����DeviFuse,DeviFuse_dot��������
  */
  
  //����ͣ����Σ�գ�������ɳ�����ѭ��������Ҫ���á��ÿ��ؿ����ò��á�
  if(EmergencyStopSwitch == 1)
  {
    //ͼ����ʧ�ܼ�������������ͣ����
    EmergencyStopCount++;
    if(EmergencyStopCount > EmergencyStopCountNum)
    {
      //���������㡣
      EmergencyStopCount = 0;
      //����ͣ����־λ��
      EmergencyStopFlag = 1;
      
      //����ͣ������������0������ѭ�����ȴ����硣
      FTM0_C4V = 0;
      FTM0_C5V = 0;
      FTM0_C6V = 0;
      FTM0_C7V = 0;
      //��ѭ��
      while(1) ;
    }
    else
    {
      
    }
  }
  else
  {
    
  }
  
  //��������жϳ��ĵ��ߴ����־��λʱ��ɨ����㸴λ��ֱ���䲻������¡�
  if(RoadHalfWidthWrongFlag == 1 && AngleSpeDealFlag == 0)
  {
    //��������
    if(RoadHalfWidthWrongDir == 0)
    {
      //�������п����ǵ��ߡ�
      if(BlackLeftLoc[BlackLeftStep1ScanRow][0] != MaxValUint8)
      {
        startline = BlackLeftLoc[BlackLeftStep1ScanRow][0];
      }
      else
      {
        startline = CameraRealWidth / 2;
      }
    }
    //��������
    else if(RoadHalfWidthWrongDir == 1)
    {
      //�������п����ǵ��ߡ�
      if(BlackRightLoc[BlackRightStep1ScanRow][0] != MaxValUint8)
      {
        startline = BlackRightLoc[BlackRightStep1ScanRow][0];
      }
      else
      {
        startline = CameraRealWidth / 2;
      }            
    }
    else 
    {    
      //�����ϲ������ߵ����
      startline = CameraRealWidth / 2;
    }
    
    //ɨ�����Ķ�λ��
    BlackCenEdgeStartCol = BoundaryLimitRe(startline,
                                           BlackCenEdgeStartColLimitL,
                                           BlackCenEdgeStartColLimitR
                                           );
    
    
    //BlackLeftEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] + SingleBlackWidthMax[CameraHight-1],
    //��ɨ�������ڶ�λ������1�����߿�ȡ�
    BlackLeftEdgeStartCol = BoundaryLimitRe(BlackCenEdgeStartCol + SingleBlackWidthMax[CameraHight-1],
                                            0,
                                            CameraRealWidth-1
                                            );
    //BlackRightEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] - SingleBlackWidthMax[CameraHight-1],
    //��ɨ�������ڶ�λ������1�����߿�ȡ�
    BlackRightEdgeStartCol = BoundaryLimitRe(BlackCenEdgeStartCol - SingleBlackWidthMax[CameraHight-1],
                                             0,
                                             CameraRealWidth-1
                                            );
    
    //����ɨ��������������ɨ��������
    BlackRightEdgeStartCol = MinRe(BlackRightEdgeStartCol, BlackLeftEdgeStartCol);
  }
  else
  {    
  }
  
  //ֻҪ����ֱ���䵼�µ�ͼ��ʧ�ܣ���²������ͼ����ͷ��ֵ̫�ϸ���ͷ��ֵ�ſ�һ��㡣 
  if(AngleSpeDealFlag == 0)
  {
    //������ͷ��ֵ�ſ�һ��㡣
    //��ֵ�Ĵ�������ԣ�ȣ��������½硣�ſ�һ��ԣ�ȡ�
    tempWB = LimitLeftHeadWB - LimitLeftWBMargin / 2; 
    if(tempWB < LimitLeftWBMin) tempWB = LimitLeftWBMin;
    else if(tempWB > LimitLeftWBMax) tempWB = LimitLeftWBMax;
    else ;
    LimitLeftHeadWB = tempWB;
    
    //�׵�Ĵ�������ԣ�ȣ��������½硣�ſ�һ��ԣ�ȡ�
    tempW = LimitLeftHeadW - LimitLeftWMargin / 2;
    if(tempW < LimitLeftWMin) tempW = LimitLeftWMin;
    else if(tempW > LimitLeftWMax) tempW = LimitLeftWMax;
    else ;
    LimitLeftHeadW = tempW;
    
    //�ڵ�Ĵ�������ԣ�ȣ��������½硣�ſ�һ��ԣ�ȡ�
    tempB = LimitLeftHeadB + LimitLeftBMargin / 2;
    if(tempB < LimitLeftBMin) tempB = LimitLeftBMin;
    else if(tempB > LimitLeftBMax) tempB = LimitLeftBMax;
    else ;
    //��ɫ��ֵ���ܳ�����ɫ
    if(tempB >= LimitLeftHeadW)
    {
      tempB = LimitLeftHeadW - 1;
    }
    else
    {
    }             
    LimitLeftHeadB = tempB;  
    
    
    //������ͷ��ֵ�ſ�һ��㡣
    //��ֵ�Ĵ�������ԣ�ȣ��������½硣�ſ�һ��ԣ�ȡ�
    tempWB = LimitRightHeadWB - LimitRightWBMargin / 2; 
    if(tempWB < LimitRightWBMin) tempWB = LimitRightWBMin;
    else if(tempWB > LimitRightWBMax) tempWB = LimitRightWBMax;
    else ;
    LimitRightHeadWB = tempWB;
    
    //�׵�Ĵ�������ԣ�ȣ��������½硣�ſ�һ��ԣ�ȡ�
    tempW = LimitRightHeadW - LimitRightWMargin / 2;
    if(tempW < LimitRightWMin) tempW = LimitRightWMin;
    else if(tempW > LimitRightWMax) tempW = LimitRightWMax;
    else ;
    LimitRightHeadW = tempW;
    
    //�ڵ�Ĵ�������ԣ�ȣ��������½硣�ſ�һ��ԣ�ȡ�
    tempB = LimitRightHeadB + LimitRightBMargin / 2;
    if(tempB < LimitRightBMin) tempB = LimitRightBMin;
    else if(tempB > LimitRightBMax) tempB = LimitRightBMax;
    else ;
    //��ɫ��ֵ���ܳ�����ɫ
    if(tempB >= LimitRightHeadW)
    {
      tempB = LimitRightHeadW - 1;
    }
    else
    {
    }             
    LimitRightHeadB = tempB;  
  }
  else
  {
  }
  
  
  
  //��һ��ͼ��ĺ�����ʼɨ���и��£���ʱ���ֲ��䡣
  BlackLeftLastEdgeStartCol = BlackLeftEdgeStartCol;
  BlackRightLastEdgeStartCol = BlackRightEdgeStartCol;
//  BlackLeftEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] + SingleBlackWidthMax[CameraHight-1],
//                                          0,
//                                          CameraRealWidth-1
//                                          );
//  BlackRightEdgeStartCol = BoundaryLimitRe(CenterLineLoc[CameraHight-1] - SingleBlackWidthMax[CameraHight-1],
//                                           0,
//                                           CameraRealWidth-1
//                                          );
  
  return 1;
}



//�µ���ֹ���������ж��ڼ����ͷƽ��
uint8 GyroResultForbidSpeDeal(void)
{
  uint8 row;
  
  //��־��λ�ڼ䣬����ͷƽ�롣
  if(GyroResultForbidFlag == 1 && BlackLeftDone == 1 && BlackRightDone == 1 && BlackLeftHeadLine != MaxValUint8 && BlackRightHeadLine != MaxValUint8)
  {
    //����ͷ�ߣ�������ͷ��𲻴�ʱ��
    if(BlackLeftHeadLine > BlackRightHeadLine && BlackLeftHeadLine <= BlackRightHeadLine + 5)
    {
      //������ͷ������
      for(row = BlackRightHeadLine; ; row++)
      {
        BlackRightLoc[row][0] = MaxValUint8;
        
        if(row == BlackLeftHeadLine) break;
      }
      //��������ͷ
      BlackRightHeadLine = BlackLeftHeadLine;
    }
    //����ͷ�ߣ�������ͷ��𲻴�ʱ��
    else if(BlackRightHeadLine > BlackLeftHeadLine && BlackRightHeadLine <= BlackLeftHeadLine + 5)
    {
      //������ͷ������
      for(row = BlackLeftHeadLine; ; row++)
      {
        BlackLeftLoc[row][0] = MaxValUint8;
        
        if(row == BlackRightHeadLine) break;
      }
      //��������ͷ
      BlackLeftHeadLine = BlackRightHeadLine;
    }
    //��������ͷƽ�봦��
    else
    {
    }
  }
  else
  {
  }
  
  
  return 1;
}


//======================================================================
//��������ImagePro
//��  �ܣ�ͼ��������ͼ��ߴ�������������ȡ����������ȡ��
//��  ������
//��  �أ�1�ɹ� 0ʧ��
//Ӱ  �죺
//˵  ����1. ������ȡʧ�ܺ󣬲���ִ����������ȡ����������ʧ�ܡ�
//        2. ������ȡʧ�ܺ󣬺�����˶����ƵĲ������ø��ģ�������һ�εĲ�����
//             
//======================================================================
uint8 ImagePro(void)
{
    ErrorCountNow5++;
  
    //ͼ��ȡ��Ҫ���У����¸�ֵ��Ϊ�˺���ı�̷��㡣
    ImgPut();

    //ͼ����֮ǰ�Ĳ�����ʼ����
    ImageProParaInit();
   
    //������ȡ����
    if(BlackGet() == 0)
    {
        //uart_sendN(UART0, (uint8 *)"\nBlackGet Failed!", 17);  
        CenterLineResult = 0;
        PathJudgeDone = 0;             //���������ж�ʧ�ܡ�
        PathType = PathTypeUnknown;    //����������Ϊδ֪��
        ImgBlackSucceedFlag = 0;
    }
    //������ȡ�ɹ���Ĵ���
    else
    {
    }

    //���������ж�
    //������ʱ�����Һ���������һ����ȡ�ɹ��������߻�û����ȡ��
    PathJudgeNew();
    
    //ֱ�Ǻڿ�ȷ�ϡ�//��첻ʹ��
    //AngleZoneConfirm();
    
    //�ϰ���ȷ�� �� ���ϴ�����ı�CenterLineLoc[]�����ֵ��
    BrickAvoid();
    
    //�µ���ֹ���������ж��ڼ����ͷƽ��
    GyroResultForbidSpeDeal();
 
    //��������ȡ�����������������ߵ���ͷ��β���ҡ�
    //����ͼ��̫�����ú��������ϲ��᷵��0.
    //������ȡʧ�ܺ󣬲�������������ȡ��
    CenterLineResult = 1;
    if(ImgBlackSucceedFlag == 0 || CenterLineGetRaw() == 0)
    {
      //uart_sendN(UART0, (uint8 *)"\nCenterLineGet Failed!", 22); 
      CenterHeadLine = MaxValUint8;
      CenterEndLine = MaxValUint8;
      CenterLineResult = 0; //
      PathJudgeDone = 0;   //���������ж�ʧ�ܡ�
      PathType = 0;        //����������Ϊδ֪��
      ImgCenterSucceedFlag = 0;
    }
    else
    {
    }
    
    //������ߺ������߶���ȡ�ɹ��������Ϊͼ����ɹ���
    if(ImgBlackSucceedFlag == 1 && ImgCenterSucceedFlag == 1)
    {
      GPIO_PDOR_REG(PORTA) |= (1<<17);
      ImgProSucceedFlag = 1;
    }
    else
    {
      GPIO_PDOR_REG(PORTA) &= ~(1<<17);
      ImgProSucceedFlag = 0;
    }
   
    
    if(ImgProSucceedFlag == 1)
    {
      //ͼ����ɹ���Ĵ���
      ImgProSucceedDeal();
    }
    else
    {
      //ͼ����ʧ�ܺ�Ĵ���
      ImgProFailDeal();
    }
    
    //�ж��Ƿ��ܳ�������10��ͼ��ʧ�ܾ���Ϊ�ܳ��������տ�ʼ�����Ľ׶���ע�͵���
    /*if(CenterHeadLine==MaxValUint8 && CenterEndLine==MaxValUint8)
    {
      if(++ImgProFailCount > 10)
      {
        RunOutFlag = 1;
      }
    }
    else
    {
        ImgProFailCount = 0;
    }*/
    
    //ƫ���˲���
    //DeviNowFilter();
    
    //ֱ����ȷ�Ϻ�������ƫ����ȡ���棬��Ϊ��ʱ�Ǿ���Ϲ�ۡ�
    //���ɴ�ֱ����ȷ�Ϻ󣬲Ż�����ȷ��Ϊֱ���䡣
    //����ȷ�Ϻ󣬻�������ɴε����⴦��
    //���⴦��ʱ������ͼ��ɹ���־λ��Ӱ�졣
    //���⴦��ʱ����Լ���Level��DeviNow�������⸳ֵ��
    //�����������һ����Ч��Devi���з�������⴦�����ƺ�û�б�Ҫ��
    
    //��첻��Ҫȷ��ֱ����
    //AngleStep2Confirm();
    
    return ImgProSucceedFlag;
}



//����ͼ��ʱר�õ�ͼ��������¡�
void ImgSendPut(void)
{
    uint16 i, j, k, temp1, temp2;   
    
    temp1 = CameraRealLeftCol;
    temp2 = CameraRealLeftCol + CameraRealWidth;
    //temp1 = CameraWidth/2 - CameraRealWidth/2 - 1;
    //temp2 = CameraWidth/2 + CameraRealWidth/2 - 1;
    
    for(i = 0; i < CameraHight; i++)
    {
      k = 0;
      for(j = temp1; j < temp2; j++)
      {
        ImgNew[i][k] = ImgRaw[i][j];
        k++;
      }
    }
}

//ͼ����ģʽר�ú���
uint8 ImageSend(void)
{
    //����ͼ��ʱר�õ�ͼ��������¡�
    ImgPut();
    
    //����ͼ��洢���鵽��λ��
    SendImage(ImgNew);      
    
    return 1;
}

