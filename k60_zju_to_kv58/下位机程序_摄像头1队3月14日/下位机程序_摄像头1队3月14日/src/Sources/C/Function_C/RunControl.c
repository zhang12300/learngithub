/******************************************************************************/
/*******************************************************************************
  �ļ������˶�����C�ļ�RunControl.c
  ��  �ܣ�ƫ����ȡ��PID���������Ƶ�������ƶ����
  ��  �ڣ�2014.11.15
  ��  �ߣ�YCR & HJZ
  ��  ע��
*******************************************************************************/
/******************************************************************************/
#include "RunControl.h"


uint8 DuZhuanFlag = 0;              //��ת��־
uint8 TimeOutFlag = 0;              //ʱ�䵽��־
uint16 StopLineSpeed = 0;            //ͣ�������ٶ�
uint8 StopLineControlFlag = 0;             //ͣ�����Ʊ�־
uint8 StopLineSpeedControlPauseFlag = 0;          //ͣ����ʱ����һ��ͼ���ʱ���һ�Σ���ֹ������ѹ�л���ʱ�������


uint16 SpeedXiaoZhiDao = 280;       //Сֱ��
uint16 SpeedTargetValGryoUp = 200;  //�����ٶȡ�
uint16 SpeedBrick = 200;            //�ϰ��ٶ�

uint16 StopFlagMaxCount = 0;      //ͣ����־��λ��ͣ������������һ��ֵ������ͣ����־��λ��
uint16 StopFlagMaxCountNum = 5;      //ͣ����־��λ��ͣ��������ֵ�����ڸ�ֵ������ͣ����־��λ��1����λ��0.1�롣 

uint16 SpeedStrategyChosen = 0;     //�ٶȲ��Եĵ�λ��0~4��0��������4����졣
uint16 MotorTakeOffQuadCountLimit = 0; //��ɿ���ʱ��תΪ�������PID����ǰ���ֱ�������Ҫ�ﵽ����������
uint16 SpeedTargetValStraight = 350;      //��ֱ�������ٶȡ�
uint16 SpeedTargetValWaitStop = 20;     //�����ȴ�ͣ���ٶȡ�20����2m/s��

uint8 StopRealFlag = 0;     //����ֹͣ��־��1��ʾ����ֹͣ�����һ�����0��

int32 ServoTemp = 0;
int32 DeltaVelocity = 0;   //���ټ�����֤��

int16 ErrorCountNow0 = 0;
int16 ErrorCountNow1 = 0;
int32 temp_speed_D;
int32 temp_speed_P;
uint8 MotorTakeOffFlag = 0;   //��ɿ��Ʊ�־λ��1δ��ɣ�0����ɡ���ʼ��Ϊδ��ɡ�
uint8 SpeedTargetLevel;//Ŀ���ٶȵȼ�����ģ�����ֶ���ȡ
uint8 StopFlag=0;       // ͣ����־��1��ʾͣ��




uint16 ServoPIDPMat[15] = 
{
 0,165,180,205,215,
 235,240,229,213,201,
 185,173,163,154,154
};
//���PID��P�����������ǵ�ǰƫ��DeviFuse�ľ���ֵ�ĵȼ�
//������100����

uint16 Steer_kp[8] = 
{
  // 0,130,206,209,215,186,150,132
  //0,130,186,209,209,186,160,141
  //0,130,186,209,203,178,156,141 //2.1m
    //150,150,150,150,150,150,150,150 
   0,20,30,33,40,40,35,35
  // 0,115,150,183,196,178,158,141//2.2
  //0,90,120,153,176,178,158,141
   //0,40,60,70,80,80,70,70
};

//���D����
uint16 ServoPIDDMat[7] = 
{
//0  25   45  60  80  100  120  140
//   2,   4,   3,  2,  2 ,  1,   1,
 //25,   25,   25,   25,  25,   25,   25
 //12,   12,   12,   12,  12,   12,   12
// 15,   15,   15,   15,  15,   15,   15
 10,   10,   10,   10,   10,   10,   10
 //19,   19,   19,   19,  19,   19,   19
  //  50,   50,   50,  50,  50,   50,   50
//  20,   20,   20,   20,  20,   20,   20
 // 0,    0,    0,    0,   0,    0,   0
};
uint16 ServoPIDD2Mat[7] = 
{
// 0  25   45  60  80  100  120  140
  // 2,   3,   3, 3,  4 ,  3,   2,
//15,   15,   15,   15,  15,   15,   15
 // 19,   19,   19,   19,  19,   19,   19
//12,   12,   12,   12,  12,   12,   12 
  10,   10,   10,   10,   10,   10,   10
 //20,   20,   20,   20,  20,   20,   20
// 25,   25,   25,   25,  25,   25,   25
// 50,   50,   50,  50,  50,   50,   50
//    0,    0,    0,    0,   0,   0,    0
};
uint8 speedP_goal[11]=
{
    //-140 -110 -80 -50 -25  0   25  50    80     110  140
    //20,  23,  26, 29, 30, 33,  30,  29,   26,   23,  20, 
    // 24, 26,  30, 33, 35, 37,  35,  33,   30,   26,  24, 
    // 27, 29,  33, 36, 38, 41,  38,  36,   33,   29,  27,
     //30, 31,  34, 36, 38, 41,  38,  36,   34,   31,  30,
     //45, 48,  51, 53,  57, 60,  57,  53,   51,   48,  45, 
     //20,  20,   20,  20,  20,   20,  20,   20,  20,  20,
     10,10,10,10,10,10,10,10,10,10,10,
};
//ʵ��Ŀ������������

uint16 SpeedTargetMat[9][11]=
{
 //-140, -110, -80,  -50 , -25 ,  0  , 25  ,  50 ,  80  , 110 , 140,
 //190, 200, 210, 215, 220, 230, 220, 215, 210, 200, 190,    //0��
  10,10,10,10,10,10,10,10,10,10,10,
// 20,30,40,50,60,60,60,50,40,30,20,
   //60,80,100,120,140,140,140,120,100,80,60,
   //100, 120, 140, 180, 200, 200, 200, 180, 140, 120, 100,
   200, 200, 210, 220, 230, 240, 230, 220, 210, 200, 200,    //1��
   210, 210, 220, 230, 240, 260, 240, 230, 220, 210, 210,    //2�����Ƚ��ȶ�
   210, 220, 230, 240, 250, 280, 250, 240, 230, 220, 210,    //3����ֱ���ߣ������
   210, 225, 235, 250, 260, 280, 260, 250, 235, 225, 210,    //4����ֱ���ߣ������
   210, 210, 240, 250, 270, 300, 270, 250, 240, 210, 210,    //5����ֱ���ߣ������
   220, 230, 240, 260, 280, 300, 280, 260, 240, 230, 220,    //6����ֱ���ߣ������
   200, 210, 220, 240, 280, 330, 280, 240, 220, 210, 200,    //7����ֱ���ߣ������  
   210, 220, 230, 250, 280, 330, 280, 250, 230, 220, 210,    //8����ֱ���ߣ������
};
/*
uint16 SpeedTargetMat[11][9]=
{
  //-140 -110 -80  -50  -25   0   25   50   80   110  140
    200, 200, 200, 205, 210, 210, 210, 205,  200, 200, 200,  //-15
    200, 200, 200, 210, 210, 220, 210, 210,  200, 200, 200,  //-10
    200, 205, 210, 210, 220, 230, 220, 210,  210, 205, 200,  //-6
    200, 210, 210, 215, 230, 240, 230, 215,  210, 210, 200,  //-2
    200, 210, 220, 220, 240, 260, 240, 220,  220, 210, 200,  //0
    200, 210, 210, 215, 230, 240, 230, 215,  210, 210, 200,  //2
    200, 205, 210, 210, 220, 230, 220, 210,  210, 205, 200,  //6
    200, 200, 200, 210, 210, 220, 210, 210,  200, 200, 200,  //10
    200, 200, 200, 205, 210, 210, 210, 205,  200, 200, 200   //15
};
*/
//���PID��P���������ǵ�ǰƫ��devinow�ľ���ֵ�ĵȼ�
uint8 MotorPIDPMat[10] = 
{
60,65,70,70,70,
75,75,80,80,80
};

uint8 DoneFlag = 0;
uint8 QuadSpeedLevel = 0;    //������������ʵʱ�ٶȵ��ٶȵȼ���10���ȼ���0������9��졣
uint8 SlopeCLevel = 0;        //б�ʵľ���ֵ�ĵȼ���6���ȼ���0��ֱ��5��б

//���
uint16 ServoPIDP = 0;                   //���PIDѡȡ��Pֵ��
uint16 ServoPIDD = 0;                   //���PIDѡȡ��Dֵ��
uint32 ServoPIDInputVal = ServoPIDCen;            //ʵ�����뵽�����ֵ
uint32 ServoPIDInputValOld = ServoPIDCen;         //�ϴ����뵽�����ֵ
int32 ServoPIDInputValP = 0;            //ʵ�����뵽�����ֵ��P����
int32 ServoPIDInputValD = 0;            //ʵ�����뵽�����ֵ��D����

//uint32 ServoPIDVal = ServoPIDCen;     //���PID���ƺ������ֵ��
//���


uint32 SpeedTargetVal = 0;               //ƽ��Ŀ��������������ǰ��
uint32 SpeedLastTargetVal = 0;           //�ϴ�ƽ��Ŀ��������������ǰ��
uint16 SpeedTargetLeftVal = 0;           //����Ŀ�������������ٺ�
uint16 SpeedTargetRightVal = 0;          //�ҵ��Ŀ�������������ٺ�
uint16 SpeedLastTargetLeftVal = 0;       //��һ������Ŀ�������������ٺ�
uint16 SpeedLastTargetRightVal = 0;      //��һ���ҵ��Ŀ�������������ٺ�

uint16 SpeedPIDPVal = 25;                  //���PIDѡȡ��Pֵ
uint16 SpeedPIDDVal = 65;                   //���PIDѡȡ��Dֵ
uint16 SpeedPIDIVal = 0;                 //���PIDѡȡ��Iֵ
int32 speed_kp,speed_kd;

int32 SpeedLeftVal = 0;                //����ʵ�������FTMֵ��
int32 SpeedRightVal = 0;               //�ҵ��ʵ�������FTMֵ��
int32 SpeedLeftValP = 0;               //����ʵ�������FTMֵ��P������
int32 SpeedLeftValD = 0;               //����ʵ�������FTMֵ��D������
int32 SpeedRightValP = 0;              //�ҵ��ʵ�������FTMֵ��P������
int32 SpeedRightValD = 0;              //�ҵ��ʵ�������FTMֵ��D������

int16 temptempSpeedLeftVal;

uint8 SpeedDiffGetSwitch =0;          //���ٿ��ء�1�������١�0�رղ��١�

//�ٶȲ���ѡ��
uint8 StrategyLoadSpeedIndex = 1;      //�ٶȲ��ԣ�1��ѣ�2���٣�3���١�

//�µ��ĸ����ٶȣ�д��FLASH�У�ͨ��OLED�޸ġ�flash����ĳ���100�Ź��㵽ͳһ��λ
uint8 SpeedTargetValGryoResult = 0;

//ֱ��������ٶȣ�д��FLASH�У�ͨ��OLED�޸ġ�flash����ĳ���100�Ź��㵽ͳһ��λ
uint8 SpeedTargetValAngle = 150;

//===================================���======================================
//////////////////////////////////���PID���ƣ�������Ҫ�Ž�PIT�жϷ�������
uint8 ServoPID(void)
{ 
  int32 temp,DeviFuse_fu;
  uint8 DeviFuse_grade;
  
  DeviFuse = (DeviFuse*10 + DeviFuse_old*0)/10;
  DeviFuse_old = DeviFuse;
  
  
   
  temp=AbsInt(DeviFuse);
  
/*  if(temp > 45)
  {
    if(AbsInt(DeviFuse-DeviPre) > AbsInt(DeviPre)*0.2)
    {
        DeviFuse = (DeviFuse*3 + DeviPre*7)/10;
    }
  }*/
  
  if(temp<20)
  {
     DeviFuse_grade=1;
     DeviFuse_fu=(temp-0)*750/(20-0);
     //FTM0_C7V = 200;
  }
  else if(temp<30)
  {
     DeviFuse_grade=2;
     DeviFuse_fu=(temp-20)*750/(30-20);
     //FTM0_C7V = 170;
  }
   else if(temp<40)
  {
     DeviFuse_grade=3;
     DeviFuse_fu=(temp-30)*750/(40-30);
     //FTM0_C7V = 160;
  }
  else if(temp<50)
  {
     DeviFuse_grade=4;
     DeviFuse_fu=(temp-40)*750/(50-40);
     //FTM0_C7V = 150;
  }
  else if(temp<60)
  {
     DeviFuse_grade=5;
     DeviFuse_fu=(temp-50)*750/(60-50);
     //FTM0_C7V = 140;
  }
  else if(temp<80)
  {
     DeviFuse_grade=6;
     DeviFuse_fu=(temp-60)*750/(80-60);
     //FTM0_C7V = 120;
  }
   else if(temp<100)
  {
     DeviFuse_grade=7;
      DeviFuse_fu=(temp-80)*750/(100-80);
      //FTM0_C7V = 100;
  }
  else
  {
     DeviFuse_grade=7; 
     DeviFuse_fu=750;//1000;//�޸Ĺ�
     //FTM0_C7V = 100;
  }
  
  ServoPIDP=(DeviFuse_fu*Steer_kp[DeviFuse_grade]+(750-DeviFuse_fu)*Steer_kp[DeviFuse_grade-1])/1000;
  //P������
  ServoPIDInputValP = ServoPIDP * DeviFuse / 10;
  //D����
  
  if((AbsInt(DeviFuse)-AbsInt(DeviPre))>=0)
  {
   ServoPIDD=ServoPIDDMat[DeviFuse_grade-1];
  }
  else
  {
  ServoPIDD=ServoPIDD2Mat[DeviFuse_grade-1];
  }
  
  
  
  ServoPIDInputValD=ServoPIDD*(DeviFuse-DeviPre);
  //��¼��һ�ε�����ֵ��
  ServoPIDInputValOld = ServoPIDInputVal;

  //�µ�����ֵ
  ServoPIDInputVal = ServoPIDCen + ServoPIDInputValP + ServoPIDInputValD;
 
  //�˲�
   ServoPIDInputVal = (ServoPIDInputValOld * 0 + ServoPIDInputVal * 10) / 10;
  /*
   //��������޷�
  if(ServoPIDInputVal>(ServoPIDInputValOld+70))
  {
    ServoPIDInputVal=ServoPIDInputValOld+70;
  }
  else if(ServoPIDInputVal<(ServoPIDInputValOld-70))
  {
    ServoPIDInputVal=ServoPIDInputValOld-70;
  }
  else
  {
   
  }
  */
   
  //����ϰ��Ĵ������
  BrickSpeDealServor();
  
  //���ʮ�ֵĴ�����ƣ��Լ��޸�ƫ��
  if(ShiZhiFlag==1)
  {
      if(ServoPIDInputVal >= (ServoPIDMax-ServoPIDCen)/5+ServoPIDCen)
      {
        ServoPIDInputVal = (ServoPIDMax-ServoPIDCen)/5+ServoPIDCen;
      }
      
      else if(ServoPIDInputVal <= ServoPIDCen-(ServoPIDCen-ServoPIDMin)/5)
      {
        ServoPIDInputVal = ServoPIDCen-(ServoPIDCen-ServoPIDMin)/5;
      }
      DeviFuse = 0;
  }
   
  //�޷���  
  if(ServoPIDInputVal >= ServoPIDMax)
  {
    ServoPIDInputVal = ServoPIDMax;
  }
  
  else if(ServoPIDInputVal <= ServoPIDMin)
  {
    ServoPIDInputVal = ServoPIDMin;
  }
  
  else
  {
    
  } 

  //��ֵ��ʵ�ʵĶ��I/O�ڡ�
  //FTM1_C0V = 2100;�Ҵ���
  FTM1_C0V = (uint16)(2*ServoPIDCen-ServoPIDInputVal);
  return 1;
}

    
//======================================================================
//��������SpeedDiffGet
//��  �ܣ����ҵ���Ĳ���ֵ���㡣
//��  ����tempSpeedTargetԤ���ٶ�ֵ��num����ĵ�����0��1��
//��  �أ�tempSpeedTarget���ٺ��Ԥ���ٶ�ֵ
//Ӱ  �죺
//˵  ����1. MotorPIDӦ�÷���ServoPID�󣬼�ServoPIDInputVal���º�
//      
//             
//======================================================================
uint16 SpeedDiffGet(uint16 tempSpeedTarget, uint8 num)
{
  
  //int32 DeltaVelocity;
  //int32 ServoTemp = 0;
  uint32 val;
  
  //���ƫ���ľ���ֵ
  ServoTemp = AbsInt(ServoPIDCen - ServoPIDInputVal);
 // DeltaVelocity = ((1000 * ServoTemp / 125) - (8 * ServoTemp * ServoTemp / 1000) + (71 * ServoTemp * ServoTemp * ServoTemp / 1000000))*30/10;//����Ŀ���ٶ�ת�����ٶȲ�,��ֵ�Ŵ���10000��
  DeltaVelocity = ((1000 * ServoTemp / 125)  + (71 * ServoTemp * ServoTemp * ServoTemp / 1000000))*13/10;//����Ŀ���ٶ�ת�����ٶȲ�,��ֵ�Ŵ���10000��
  //DeltaVelocity=(70200*ServoTemp-0*ServoTemp*ServoTemp+15*ServoTemp*ServoTemp*ServoTemp/10-345000)/10000;
 // DeltaVelocity=(70200*ServoTemp+2*ServoTemp*ServoTemp*ServoTemp)/10000;
  //��ǰ��ת��
  if(ServoPIDInputVal > ServoPIDCen)
  {
    //�������Ĵ����ٶȼӴ�
    if(num == 0)
    {    
     val = tempSpeedTarget + (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
    }
    //���ҵ���Ĵ����ٶȼ�С��
    else
    {
      val = tempSpeedTarget - (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
    }
  }
  //��ǰ��ת��
  else if(ServoPIDInputVal < ServoPIDCen)
  {
    //�������Ĵ����ٶȼ�С��
    if(num == 0)
    {
      val = tempSpeedTarget - (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
    }
    //���ҵ���Ĵ����ٶȼӴ�
    else
    {
      val = tempSpeedTarget + (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
    }
  }
  //��ǰֱ�ߣ������κδ���
  else
  {
    //val = tempSpeedTarget;
    val = tempSpeedTarget;
  }  
  
  return val;
}
//��������ʱ��ƽ��Ŀ���ٶȵ����⴦��
uint32 SpeedTargetValSpePathDeal(uint32 temp)
{
  uint32 val;
  
  //ÿ��ֻ������һ������������
  if(StopFlag == 1)
  {
    val = 0;
  }
 /* else if(LightHouseWaitStopFlag != 0)
  {
    //val = SpeedTargetValWaitStop;
    light_control(PORTA, 17, Light_ON);
  }
  //ֱ��
  else if(AngleConfirmLockFlag == 1)
  {
    //ֱ��������ȴ�ʱ�����ٴ���
    //val = SpeedTargetValAngle;
    light_control(PORTD, 15, Light_ON);
  }*/
  else if(BrickConfirmLockFlag == 1 || BrickSpeDealFlag == 1)
  {
    val = SpeedBrick;
  }
  //�����ٶȡ���Ļ��ͷɹ���С�Ļ������Ź���
  else if(GyroResultFlag == 1)
  {
    val = SpeedTargetValGryoUp;
  }
  //���º�������ٶȡ�
  else if(GyroResultFlag == 2)
  {
    //�������ϣ���ƽ��Ŀ����������ֵΪ��С��ֵ��
    val = SpeedTargetValGryoResult;
  }
  //��ֱ��
  else if(PathRealStraightFlag == 1)
  {
    //��ֱ�����ٶȼӿ졣
    val = SpeedTargetValStraight;
  }
  else if(xiaoZhiDaoFlag == 1)
  {
    val = SpeedXiaoZhiDao;
      //val = temp;
  }
  //����������������ԭֵ��
  else
  {
    val = temp;
  }
  
  return val;
}
    


//=========================���========================================
//////////////////////////////////���PID���ƣ�������Ҫ�Ž�PIT�жϷ�������
uint8 MotorPID(void)
{
  uint8 DeviFuseLevel;
  uint8 i;
  //uint8 j;     
  int32 temp_speed_bias;
  
  
  ErrorCountNow1++;  
  //���δ���ǰ������ɵ��ٶȿ��ơ�
  if(MotorTakeOffFlag == 1)
  {
    //ƫ��ȼ��Ļ�ȡ
    DeviFuseLevel = AbsInt(DeviFuse) / 10;
    if(DeviFuseLevel > 8)
    {
      //ƫ��ȼ�������
      DeviFuseLevel = 9;
    }
    else
    { 
      
    }
    
    //ģ����ȡƽ��Ŀ��������
    SpeedTargetVal = 0;
   
    for(i = 0;i < 11; i++)
    {
//      for(j=0;j <9 ;j++)
//      {
//         SpeedTargetVal += DeviFusemtr[i]*DeviFuse_dotmtr[j] * SpeedTargetMat[i][j]/1000;      
//      }
      SpeedTargetVal += DeviFusemtr[i] * SpeedTargetMat[0][i]; 
    }
    SpeedTargetVal = SpeedTargetVal/ 1000;
    
    
    
    //��������Ӧ�����ֵ��
    //����Ϊ��һ��������Ŀ���ٶ�
    SpeedLastTargetLeftVal = SpeedTargetLeftVal;
    //��������
    if(SpeedDiffGetSwitch == 1)
    {
      SpeedTargetLeftVal = SpeedDiffGet(SpeedTargetVal, 0);   
      SpeedTargetLeftVal=(SpeedTargetLeftVal*9+SpeedLastTargetLeftVal*1)/10;
    }
    else
    {
      SpeedTargetLeftVal = SpeedTargetVal;
      SpeedTargetLeftVal=(SpeedTargetLeftVal*9+SpeedLastTargetLeftVal*1)/10; 
    }
    //����P����
     temp_speed_bias=AbsInt (SpeedTargetLeftVal - SpeedNowLeft);
    
      speed_kd=SpeedPIDDVal;
      speed_kp=0;
     for(i = 0;i < 11; i++)
    {
      speed_kp += DeviFusemtr[i] * speedP_goal[i];      
    }
    speed_kp = speed_kp / 1000;
    SpeedPIDPVal=speed_kp;
    //speed_kp=SpeedPIDPVal;        //�޸Ĺ�
     SpeedLeftValP +=SpeedTargetLeftVal - SpeedNowLeft;
       //�����޷�
    if(SpeedLeftValP>800)
    {
      SpeedLeftValP=800;
    }
    else if(SpeedLeftValP<-800)
    {
       SpeedLeftValP=-800;
    }
    //����D����
    SpeedLeftValD +=  (SpeedTargetLeftVal - SpeedNowLeft) - (SpeedLastTargetLeftVal - SpeedLastLeft);
    
    //��������ֵ��/////////////////////////////////////////////////����ʽ����
    SpeedLeftVal = (speed_kp*SpeedLeftValP +speed_kd* SpeedLeftValD*10)/100;
   
    //��������ֵ���޷���
    if(SpeedLeftVal >= MotorPIDMax)
    {
      SpeedLeftVal = MotorPIDMax;
    }
    else if(SpeedLeftVal <= MotorPIDMin)
    {
      SpeedLeftVal = MotorPIDMin;
    }
    else
    {
      
    }
    
      
    //�����ҵ��Ӧ�����ֵ��
    //����Ϊ��һ���ҵ����Ŀ���ٶ�
    SpeedLastTargetRightVal = SpeedTargetRightVal;
    //�ҵ������
    if(SpeedDiffGetSwitch == 1)
    {
      SpeedTargetRightVal = SpeedDiffGet(SpeedTargetVal, 1);  
      SpeedTargetRightVal=(SpeedTargetRightVal*9+SpeedLastTargetRightVal*1)/10;
    }
    else
    {
      SpeedTargetRightVal = SpeedTargetVal;
    }
    
      temp_speed_bias=AbsInt (SpeedTargetRightVal - SpeedNowRight);
    
    
    speed_kd=SpeedPIDDVal;
    //�ҵ��P����
    speed_kp=0;
    
     for(i = 0;i < 11; i++)
    {
      speed_kp += DeviFusemtr[i] * speedP_goal[i];      
    }
    speed_kp = speed_kp / 1000;
    SpeedPIDPVal=speed_kp;
    //speed_kp=SpeedPIDPVal;         //�޸Ĺ�
    SpeedRightValP +=  SpeedTargetRightVal - SpeedNowRight;

     //�����޷�
    if(SpeedRightValP>800)
    {
      SpeedRightValP=800;
    }
    else if(SpeedRightValP<-800)
    {
       SpeedRightValP=-800;
    }
    //�ҵ��D����
    SpeedRightValD +=   ((SpeedTargetRightVal - SpeedNowRight) - (SpeedLastTargetRightVal - SpeedLastRight));
    //�ҵ������ֵ��/////////////////////////////////////////////////����ʽ����
    SpeedRightVal = (speed_kp *SpeedRightValP/10 + speed_kd*SpeedRightValD);
    //�ҵ������ֵ���޷���
    if(SpeedRightVal >= MotorPIDMax)
    {
      SpeedRightVal = MotorPIDMax;
    }
    else if(SpeedRightVal <= MotorPIDMin)
    {
      SpeedRightVal = MotorPIDMin;
    }
    else
    {
    }
    
    //�����ٶȶ����������ֵ�󣬾�תΪ�����ĵ��PID���ơ�
    if(SpeedNowLeft > MotorTakeOffQuadCountLimit)// && SpeedNowRight > MotorTakeOffQuadCountLimit
    {
      MotorTakeOffFlag = 0;
    }
    else
    {
      //û�ﵽ��������������������ܸߵ��ٶȡ�
      SpeedLeftVal = MotorTakeOffNum;
      SpeedRightVal = MotorTakeOffNum;
    }
    
    
    
  }
  //��������ɺ�ĵ������
  else
  {
    //ƫ��ȼ��Ļ�ȡ
    DeviFuseLevel = AbsInt(DeviFuse) / 10;
    if(DeviFuseLevel > 8)
    {
      //ƫ��ȼ�������
      DeviFuseLevel = 9;
    }
    else
    { 
    }
    
    
    //ģ����ȡƽ��Ŀ��������
    SpeedTargetVal = 0;
//    if(StopFlag==0)
//    {
        for(i = 0;i < 11; i++)
       {
//          for(j=0;j <9 ;j++)
//          {
//             SpeedTargetVal += DeviFusemtr[i]*DeviFuse_dotmtr[j] * SpeedTargetMat[i][j]/1000;      
//          } 
         SpeedTargetVal += DeviFusemtr[i] * SpeedTargetMat[0][i]; 
        }
       SpeedTargetVal = SpeedTargetVal / 1000;
//    }
//    else
//    {
//      //ͣ����Ŀ���ٶ�����
//    }

  
    //��������ʱ��ƽ��Ŀ���ٶȵ����⴦��
    SpeedTargetVal = SpeedTargetValSpePathDeal(SpeedTargetVal);
    
    //ͣ��ʱ���ٶȿ���
    if(StopLineControlFlag==1 && StopRealFlag==0)
    {
        if(StopLineSpeed == 0)
        {
            StopLineSpeed = SpeedTargetVal - 10;
            StopLineSpeedControlPauseFlag = 1 - StopLineSpeedControlPauseFlag;
        } 
        else if(SpeedNowLeft < 50)
        {
            StopRealFlag = 1;
            StopLineSpeedControlPauseFlag = 1;
        }
        else
        {
            StopLineSpeed -= 10;
            if(StopLineSpeed<50)
            {
                StopLineSpeed = 50;
            }
            StopLineSpeedControlPauseFlag = 1 - StopLineSpeedControlPauseFlag;
        }
        SpeedTargetVal = StopLineSpeed;
        //��ǰ���������ʹ��ȥ�������ڼӷ���ѹ
        FTM0_C4V = 0;
        FTM0_C5V = 0;
    }
    
    
     //��������Ӧ�����ֵ��
    //����Ϊ��һ��������Ŀ���ٶ�
    SpeedLastTargetLeftVal = SpeedTargetLeftVal;
    //��������
    if(0)//if(SpeedDiffGetSwitch == 1)
    {
      SpeedTargetLeftVal = SpeedDiffGet(SpeedTargetVal, 0);   
      SpeedTargetLeftVal=(SpeedTargetLeftVal*9+SpeedLastTargetLeftVal*1)/10;
    }
    else
    {
      SpeedTargetLeftVal = SpeedTargetVal;
      SpeedTargetLeftVal=(SpeedTargetLeftVal*9+SpeedLastTargetLeftVal*1)/10;
    }
    
    //�����ת�Ļ���ͣ��(��Ҫ���������տ�ʼ�����Ľ׶ιر�)
    /*if(SpeedNowLeft<50)
    {
        StopFlagMaxCount++;
        if(StopFlagMaxCount >= 12)
        {
           DuZhuanFlag = 1;
        }
    }
    else
    {
        StopFlagMaxCount = 0;
    }*/
    
    //����D����
    temp_speed_bias= SpeedTargetLeftVal - SpeedNowLeft;
     speed_kd=SpeedPIDDVal;
    
    speed_kp=0;
     for(i = 0;i < 11; i++)
    {
      speed_kp += DeviFusemtr[i] * speedP_goal[i];      
    }
    speed_kp = speed_kp / 1000;
    

    speed_kp=SpeedPIDPVal;
    SpeedLeftValP +=SpeedTargetLeftVal - SpeedNowLeft;
   
      //�����޷�
    if(SpeedLeftValP>800)
    {
      SpeedLeftValP=800;
    }
    else if(SpeedLeftValP<-800)
    {
       SpeedLeftValP=-800;
    }
    
    //����D����
    SpeedLeftValD +=  (SpeedTargetLeftVal - SpeedNowLeft) - (SpeedLastTargetLeftVal - SpeedLastLeft);
    
    //��������ֵ��/////////////////////////////////////////////////����ʽ����
    SpeedLeftVal = (speed_kp*SpeedLeftValP +speed_kd* SpeedLeftValD*10)/100;
   
    //��������ֵ���޷���
    if(SpeedLeftVal >= MotorPIDMax)
    {
      SpeedLeftVal = MotorPIDMax;
    }
    else if(SpeedLeftVal <= MotorPIDMin)
    {
      SpeedLeftVal = MotorPIDMin;
    }
    else
    {
      
    }

   
      
    //�����ҵ��Ӧ�����ֵ��
    //����Ϊ��һ���ҵ����Ŀ���ٶ�
    SpeedLastTargetRightVal = SpeedTargetRightVal;
    //�ҵ������
    if(SpeedDiffGetSwitch == 1)
    {
      SpeedTargetRightVal = SpeedDiffGet(SpeedTargetVal, 1);   
      SpeedTargetRightVal=(SpeedTargetRightVal*9+SpeedLastTargetRightVal*1)/10;
    }
    else
    {
      SpeedTargetRightVal = SpeedTargetVal; 
    }
    //�ҵ��P����
     temp_speed_bias=SpeedTargetRightVal - SpeedNowRight;
 
    speed_kd=SpeedPIDDVal;
      speed_kp=0;
     for(i = 0;i < 11; i++)
    {
      speed_kp += DeviFusemtr[i] * speedP_goal[i];      
    }
    speed_kp = speed_kp / 1000;
   
      speed_kp=SpeedPIDPVal;
     SpeedRightValP +=  SpeedTargetRightVal - SpeedNowRight;

     //�����޷�
    if(SpeedRightValP>800)
    {
      SpeedRightValP=800;
    }
    else if(SpeedRightValP<-800)
    {
       SpeedRightValP=-800;
    }
    //�ҵ��D����
    SpeedRightValD +=  ((SpeedTargetRightVal - SpeedNowRight) - (SpeedLastTargetRightVal - SpeedLastRight));
    //�ҵ������ֵ��/////////////////////////////////////////////////����ʽ����
    SpeedRightVal = (speed_kp *SpeedRightValP/10 + speed_kd*SpeedRightValD);
    
    //�ҵ������ֵ���޷���
    if(SpeedRightVal >= MotorPIDMax)
    {
      SpeedRightVal = MotorPIDMax;
    }
    else if(SpeedRightVal <= MotorPIDMin)
    {
      SpeedRightVal = MotorPIDMin;
    }
    else
    {
      
    }

  }

      if(StopFlag == 1)   //ȷ����ȫͣ�������Ϊ0
      {
          //ͣ�����ռ���
          StopFlagMaxCount++;
          //int32 speed;//���������ٶȣ������ٶȵ�ƽ��ֵ
         //�������κ�һ�������ٶȵ���ĳֵ����һ��ʱ�䣬����ȫͣ����ͣ�µ����
         if(SpeedNowLeft < 20 || SpeedNowRight < 20 || StopFlagMaxCount > StopFlagMaxCountNum * 6) //16ms����һ�Σ�����6��ʾ��0.1sΪ��λ��
         {
           StopRealFlag = 1;//��ȫͣ����ͣ�µ��      
         }
         else
         {      
         }      
      }
      else
      {
      }  
  
      if(StopRealFlag == 0)
      {
        if(StopLineCheckFlag==1 && DuZhuanFlag==0 && TimeOutFlag==0 && RunOutFlag==0 && StopLineControlFlag == 0)
        {
            StopLineControlFlag = 1;LCD_CLS();LCD_P8x16Str(12,3,"StopLine");
        }
        else if(DuZhuanFlag==1 && StopLineCheckFlag==0 && TimeOutFlag==0 && RunOutFlag==0){StopRealFlag = 1;LCD_CLS();LCD_P8x16Str(12,3,"DuZhuan");}
        else if(DuZhuanFlag==0 && StopLineCheckFlag==0 && TimeOutFlag==1 &&  RunOutFlag==0){StopRealFlag = 1;}
        else if(DuZhuanFlag==0 && StopLineCheckFlag==0 && TimeOutFlag==0 &&  RunOutFlag==1){StopRealFlag = 1;LCD_CLS();LCD_P8x16Str(12,3,"RunOut");}
      }
      if(StopRealFlag == 1)
      {
        FTM0_C4V = 0;
        FTM0_C5V = 0;
        FTM0_C6V = 0;
        FTM0_C7V = 0;
      }
      else
      {
        //��ֵ�����ʵ�ʶ�Ӧ��I/O�ڡ�
        if(SpeedLeftVal>0)
        {
         // FTM0_C4V = 100;
         //FTM0_C5V = 100;
         FTM0_C5V = 300;
         FTM0_C4V = 100;//SpeedLeftVal;
    
          if(StopLineSpeedControlPauseFlag == 1)
          {
            FTM0_C4V = 1000;
            FTM0_C5V = 1000;
          }
        }
        else
        {
          
         // FTM0_C4V = 100;
         // FTM0_C5V = 100;
          FTM0_C5V = 300;
          FTM0_C4V = 100;//0-SpeedLeftVal;          
          if(StopLineSpeedControlPauseFlag == 1)
          {
            FTM0_C4V = 1000;
            FTM0_C5V = 1000;          
          }
        }
        
        if(SpeedRightVal>0)
        {
             
        // FTM0_C7V = 100;        
         // FTM0_C6V = 100;
          FTM0_C6V = 300;        
          FTM0_C7V = 100;//SpeedRightVal;
          if(StopLineSpeedControlPauseFlag == 1)
          {
            FTM0_C6V = 1000;
            FTM0_C7V = 1000;
          }
          //FTM0_C6V = SpeedRightVal;
          //FTM0_C7V = 0;  
        }
        else
        {
             
          //FTM0_C7V = 100;        
         // FTM0_C6V = 100;
         FTM0_C7V = 100;//0-SpeedRightVal;        
          FTM0_C6V = 300;
          if(StopLineSpeedControlPauseFlag == 1)
          {
            FTM0_C6V = 1000;
            FTM0_C7V = 1000;
          }
          //FTM0_C6V = 0;
          //FTM0_C7V = 0-SpeedRightVal;   
        }
      }
  return 1;
}






