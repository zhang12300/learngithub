/******************************************************************************/
/*******************************************************************************
  文件名：运动控制C文件RunControl.c
  功  能：偏差求取，PID反馈，控制电机，控制舵机。
  日  期：2014.11.15
  作  者：YCR & HJZ
  备  注：
*******************************************************************************/
/******************************************************************************/
#include "RunControl.h"


uint8 DuZhuanFlag = 0;              //堵转标志
uint8 TimeOutFlag = 0;              //时间到标志
uint16 StopLineSpeed = 0;            //停车控制速度
uint8 StopLineControlFlag = 0;             //停车控制标志
uint8 StopLineSpeedControlPauseFlag = 0;          //停车的时候间隔一场图像的时间控一次，防止正反电压切换的时候出问题


uint16 SpeedXiaoZhiDao = 280;       //小直道
uint16 SpeedTargetValGryoUp = 200;  //上坡速度。
uint16 SpeedBrick = 200;            //障碍速度

uint16 StopFlagMaxCount = 0;      //停车标志置位后，停车计数，大于一定值后最终停车标志置位。
uint16 StopFlagMaxCountNum = 5;      //停车标志置位后，停车计数阈值，大于该值后，最终停车标志置位。1个单位是0.1秒。 

uint16 SpeedStrategyChosen = 0;     //速度策略的档位，0~4，0档最慢，4档最快。
uint16 MotorTakeOffQuadCountLimit = 0; //起飞控制时，转为正常电机PID控制前两轮编码器需要达到的脉冲数。
uint16 SpeedTargetValStraight = 350;      //长直道给定速度。
uint16 SpeedTargetValWaitStop = 20;     //灯塔等待停车速度。20代表2m/s。

uint8 StopRealFlag = 0;     //绝对停止标志。1表示绝对停止，电机一定输出0。

int32 ServoTemp = 0;
int32 DeltaVelocity = 0;   //差速计算验证。

int16 ErrorCountNow0 = 0;
int16 ErrorCountNow1 = 0;
int32 temp_speed_D;
int32 temp_speed_P;
uint8 MotorTakeOffFlag = 0;   //起飞控制标志位，1未起飞，0已起飞。初始化为未起飞。
uint8 SpeedTargetLevel;//目标速度等级，不模糊，分段求取
uint8 StopFlag=0;       // 停车标志，1表示停车




uint16 ServoPIDPMat[15] = 
{
 0,165,180,205,215,
 235,240,229,213,201,
 185,173,163,154,154
};
//舵机PID的P矩阵，行依据是当前偏差DeviFuse的绝对值的等级
//扩大了100倍。

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

//舵机D矩阵。
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
//实际目标脉冲数矩阵。

uint16 SpeedTargetMat[9][11]=
{
 //-140, -110, -80,  -50 , -25 ,  0  , 25  ,  50 ,  80  , 110 , 140,
 //190, 200, 210, 215, 220, 230, 220, 215, 210, 200, 190,    //0档
  10,10,10,10,10,10,10,10,10,10,10,
// 20,30,40,50,60,60,60,50,40,30,20,
   //60,80,100,120,140,140,140,120,100,80,60,
   //100, 120, 140, 180, 200, 200, 200, 180, 140, 120, 100,
   200, 200, 210, 220, 230, 240, 230, 220, 210, 200, 200,    //1档
   210, 210, 220, 230, 240, 260, 240, 230, 220, 210, 210,    //2档，比较稳定
   210, 220, 230, 240, 250, 280, 250, 240, 230, 220, 210,    //3档，直道高，弯道低
   210, 225, 235, 250, 260, 280, 260, 250, 235, 225, 210,    //4档，直道高，弯道高
   210, 210, 240, 250, 270, 300, 270, 250, 240, 210, 210,    //5档，直道高，弯道低
   220, 230, 240, 260, 280, 300, 280, 260, 240, 230, 220,    //6档，直道高，弯道高
   200, 210, 220, 240, 280, 330, 280, 240, 220, 210, 200,    //7档，直道高，弯道低  
   210, 220, 230, 250, 280, 330, 280, 250, 230, 220, 210,    //8档，直道高，弯道高
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
//电机PID的P矩阵，依据是当前偏差devinow的绝对值的等级
uint8 MotorPIDPMat[10] = 
{
60,65,70,70,70,
75,75,80,80,80
};

uint8 DoneFlag = 0;
uint8 QuadSpeedLevel = 0;    //编码器测量的实时速度的速度等级，10个等级，0最慢，9最快。
uint8 SlopeCLevel = 0;        //斜率的绝对值的等级，6个等级，0最直，5最斜

//舵机
uint16 ServoPIDP = 0;                   //舵机PID选取的P值。
uint16 ServoPIDD = 0;                   //舵机PID选取的D值。
uint32 ServoPIDInputVal = ServoPIDCen;            //实际输入到舵机的值
uint32 ServoPIDInputValOld = ServoPIDCen;         //上次输入到舵机的值
int32 ServoPIDInputValP = 0;            //实际输入到舵机的值的P分量
int32 ServoPIDInputValD = 0;            //实际输入到舵机的值的D分量

//uint32 ServoPIDVal = ServoPIDCen;     //舵机PID控制后输入的值。
//电机


uint32 SpeedTargetVal = 0;               //平均目标脉冲数。差速前。
uint32 SpeedLastTargetVal = 0;           //上次平均目标脉冲数。差速前。
uint16 SpeedTargetLeftVal = 0;           //左电机目标脉冲数。差速后。
uint16 SpeedTargetRightVal = 0;          //右电机目标脉冲数。差速后。
uint16 SpeedLastTargetLeftVal = 0;       //上一次左电机目标脉冲数，差速后
uint16 SpeedLastTargetRightVal = 0;      //上一次右电机目标脉冲数，差速后

uint16 SpeedPIDPVal = 25;                  //电机PID选取的P值
uint16 SpeedPIDDVal = 65;                   //电机PID选取的D值
uint16 SpeedPIDIVal = 0;                 //电机PID选取的I值
int32 speed_kp,speed_kd;

int32 SpeedLeftVal = 0;                //左电机实际输入的FTM值。
int32 SpeedRightVal = 0;               //右电机实际输入的FTM值。
int32 SpeedLeftValP = 0;               //左电机实际输入的FTM值的P分量。
int32 SpeedLeftValD = 0;               //左电机实际输入的FTM值的D分量。
int32 SpeedRightValP = 0;              //右电机实际输入的FTM值的P分量。
int32 SpeedRightValD = 0;              //右电机实际输入的FTM值的D分量。

int16 temptempSpeedLeftVal;

uint8 SpeedDiffGetSwitch =0;          //差速开关。1开启差速。0关闭差速。

//速度策略选项
uint8 StrategyLoadSpeedIndex = 1;      //速度策略，1最佳，2高速，3低速。

//坡道的给定速度，写在FLASH中，通过OLED修改。flash里面的乘以100才归算到统一单位
uint8 SpeedTargetValGryoResult = 0;

//直角弯给定速度，写在FLASH中，通过OLED修改。flash里面的乘以100才归算到统一单位
uint8 SpeedTargetValAngle = 150;

//===================================舵机======================================
//////////////////////////////////舵机PID控制，后期需要放进PIT中断服务函数中
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
     DeviFuse_fu=750;//1000;//修改过
     //FTM0_C7V = 100;
  }
  
  ServoPIDP=(DeviFuse_fu*Steer_kp[DeviFuse_grade]+(750-DeviFuse_fu)*Steer_kp[DeviFuse_grade-1])/1000;
  //P分量。
  ServoPIDInputValP = ServoPIDP * DeviFuse / 10;
  //D分量
  
  if((AbsInt(DeviFuse)-AbsInt(DeviPre))>=0)
  {
   ServoPIDD=ServoPIDDMat[DeviFuse_grade-1];
  }
  else
  {
  ServoPIDD=ServoPIDD2Mat[DeviFuse_grade-1];
  }
  
  
  
  ServoPIDInputValD=ServoPIDD*(DeviFuse-DeviPre);
  //记录上一次的输入值。
  ServoPIDInputValOld = ServoPIDInputVal;

  //新的输入值
  ServoPIDInputVal = ServoPIDCen + ServoPIDInputValP + ServoPIDInputValD;
 
  //滤波
   ServoPIDInputVal = (ServoPIDInputValOld * 0 + ServoPIDInputVal * 10) / 10;
  /*
   //舵机跳变限幅
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
   
  //针对障碍的打角限制
  BrickSpeDealServor();
  
  //针对十字的打角限制，以及修改偏差
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
   
  //限幅。  
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

  //赋值给实际的舵机I/O口。
  //FTM1_C0V = 2100;右打死
  FTM1_C0V = (uint16)(2*ServoPIDCen-ServoPIDInputVal);
  return 1;
}

    
//======================================================================
//函数名：SpeedDiffGet
//功  能：左右电机的差速值计算。
//参  数：tempSpeedTarget预设速度值，num处理的电机编号0左1右
//返  回：tempSpeedTarget差速后的预设速度值
//影  响：
//说  明：1. MotorPID应该放在ServoPID后，即ServoPIDInputVal更新后。
//      
//             
//======================================================================
uint16 SpeedDiffGet(uint16 tempSpeedTarget, uint8 num)
{
  
  //int32 DeltaVelocity;
  //int32 ServoTemp = 0;
  uint32 val;
  
  //舵机偏量的绝对值
  ServoTemp = AbsInt(ServoPIDCen - ServoPIDInputVal);
 // DeltaVelocity = ((1000 * ServoTemp / 125) - (8 * ServoTemp * ServoTemp / 1000) + (71 * ServoTemp * ServoTemp * ServoTemp / 1000000))*30/10;//乘以目标速度转化成速度差,该值放大了10000倍
  DeltaVelocity = ((1000 * ServoTemp / 125)  + (71 * ServoTemp * ServoTemp * ServoTemp / 1000000))*13/10;//乘以目标速度转化成速度差,该值放大了10000倍
  //DeltaVelocity=(70200*ServoTemp-0*ServoTemp*ServoTemp+15*ServoTemp*ServoTemp*ServoTemp/10-345000)/10000;
 // DeltaVelocity=(70200*ServoTemp+2*ServoTemp*ServoTemp*ServoTemp)/10000;
  //当前右转。
  if(ServoPIDInputVal > ServoPIDCen)
  {
    //对左电机的处理，速度加大。
    if(num == 0)
    {    
     val = tempSpeedTarget + (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
    }
    //对右电机的处理，速度减小。
    else
    {
      val = tempSpeedTarget - (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
    }
  }
  //当前左转。
  else if(ServoPIDInputVal < ServoPIDCen)
  {
    //对左电机的处理，速度减小。
    if(num == 0)
    {
      val = tempSpeedTarget - (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
    }
    //对右电机的处理，速度加大。
    else
    {
      val = tempSpeedTarget + (uint16)(tempSpeedTarget * DeltaVelocity / 10000);
    }
  }
  //当前直走，不作任何处理。
  else
  {
    //val = tempSpeedTarget;
    val = tempSpeedTarget;
  }  
  
  return val;
}
//特殊赛道时，平均目标速度的特殊处理。
uint32 SpeedTargetValSpePathDeal(uint32 temp)
{
  uint32 val;
  
  //每次只允许有一种特殊赛道。
  if(StopFlag == 1)
  {
    val = 0;
  }
 /* else if(LightHouseWaitStopFlag != 0)
  {
    //val = SpeedTargetValWaitStop;
    light_control(PORTA, 17, Light_ON);
  }
  //直角
  else if(AngleConfirmLockFlag == 1)
  {
    //直角弯锁存等待时，减速处理。
    //val = SpeedTargetValAngle;
    light_control(PORTD, 15, Light_ON);
  }*/
  else if(BrickConfirmLockFlag == 1 || BrickSpeDealFlag == 1)
  {
    val = SpeedBrick;
  }
  //上坡速度。大的话就飞过，小的话就贴着过。
  else if(GyroResultFlag == 1)
  {
    val = SpeedTargetValGryoUp;
  }
  //下坡后的启动速度。
  else if(GyroResultFlag == 2)
  {
    //若在坡上，则将平均目标脉冲数赋值为较小的值。
    val = SpeedTargetValGryoResult;
  }
  //长直道
  else if(PathRealStraightFlag == 1)
  {
    //长直道，速度加快。
    val = SpeedTargetValStraight;
  }
  else if(xiaoZhiDaoFlag == 1)
  {
    val = SpeedXiaoZhiDao;
      //val = temp;
  }
  //无特殊赛道，返回原值。
  else
  {
    val = temp;
  }
  
  return val;
}
    


//=========================电机========================================
//////////////////////////////////电机PID控制，后期需要放进PIT中断服务函数中
uint8 MotorPID(void)
{
  uint8 DeviFuseLevel;
  uint8 i;
  //uint8 j;     
  int32 temp_speed_bias;
  
  
  ErrorCountNow1++;  
  //起飞未完成前，按起飞的速度控制。
  if(MotorTakeOffFlag == 1)
  {
    //偏差等级的获取
    DeviFuseLevel = AbsInt(DeviFuse) / 10;
    if(DeviFuseLevel > 8)
    {
      //偏差等级的修正
      DeviFuseLevel = 9;
    }
    else
    { 
      
    }
    
    //模糊求取平均目标脉冲数
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
    
    
    
    //计算左电机应输入的值。
    //储存为上一次左电机的目标速度
    SpeedLastTargetLeftVal = SpeedTargetLeftVal;
    //左电机差速
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
    //左电机P分量
     temp_speed_bias=AbsInt (SpeedTargetLeftVal - SpeedNowLeft);
    
      speed_kd=SpeedPIDDVal;
      speed_kp=0;
     for(i = 0;i < 11; i++)
    {
      speed_kp += DeviFusemtr[i] * speedP_goal[i];      
    }
    speed_kp = speed_kp / 1000;
    SpeedPIDPVal=speed_kp;
    //speed_kp=SpeedPIDPVal;        //修改过
     SpeedLeftValP +=SpeedTargetLeftVal - SpeedNowLeft;
       //积分限幅
    if(SpeedLeftValP>800)
    {
      SpeedLeftValP=800;
    }
    else if(SpeedLeftValP<-800)
    {
       SpeedLeftValP=-800;
    }
    //左电机D分量
    SpeedLeftValD +=  (SpeedTargetLeftVal - SpeedNowLeft) - (SpeedLastTargetLeftVal - SpeedLastLeft);
    
    //左电机输入值。/////////////////////////////////////////////////增量式！！
    SpeedLeftVal = (speed_kp*SpeedLeftValP +speed_kd* SpeedLeftValD*10)/100;
   
    //左电机输入值的限幅。
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
    
      
    //计算右电机应输入的值。
    //储存为上一次右电机的目标速度
    SpeedLastTargetRightVal = SpeedTargetRightVal;
    //右电机差速
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
    //右电机P分量
    speed_kp=0;
    
     for(i = 0;i < 11; i++)
    {
      speed_kp += DeviFusemtr[i] * speedP_goal[i];      
    }
    speed_kp = speed_kp / 1000;
    SpeedPIDPVal=speed_kp;
    //speed_kp=SpeedPIDPVal;         //修改过
    SpeedRightValP +=  SpeedTargetRightVal - SpeedNowRight;

     //积分限幅
    if(SpeedRightValP>800)
    {
      SpeedRightValP=800;
    }
    else if(SpeedRightValP<-800)
    {
       SpeedRightValP=-800;
    }
    //右电机D分量
    SpeedRightValD +=   ((SpeedTargetRightVal - SpeedNowRight) - (SpeedLastTargetRightVal - SpeedLastRight));
    //右电机输入值。/////////////////////////////////////////////////增量式！！
    SpeedRightVal = (speed_kp *SpeedRightValP/10 + speed_kd*SpeedRightValD);
    //右电机输入值的限幅。
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
    
    //两轮速度都超过起飞阈值后，就转为正常的电机PID控制。
    if(SpeedNowLeft > MotorTakeOffQuadCountLimit)// && SpeedNowRight > MotorTakeOffQuadCountLimit
    {
      MotorTakeOffFlag = 0;
    }
    else
    {
      //没达到起飞脉冲数，则持续输出很高的速度。
      SpeedLeftVal = MotorTakeOffNum;
      SpeedRightVal = MotorTakeOffNum;
    }
    
    
    
  }
  //以下是起飞后的电机控制
  else
  {
    //偏差等级的获取
    DeviFuseLevel = AbsInt(DeviFuse) / 10;
    if(DeviFuseLevel > 8)
    {
      //偏差等级的修正
      DeviFuseLevel = 9;
    }
    else
    { 
    }
    
    
    //模糊求取平均目标脉冲数
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
//      //停车，目标速度置零
//    }

  
    //特殊赛道时，平均目标速度的特殊处理。
    SpeedTargetVal = SpeedTargetValSpePathDeal(SpeedTargetVal);
    
    //停车时的速度控制
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
        //提前把驱动板的使能去掉，便于加反电压
        FTM0_C4V = 0;
        FTM0_C5V = 0;
    }
    
    
     //计算左电机应输入的值。
    //储存为上一次左电机的目标速度
    SpeedLastTargetLeftVal = SpeedTargetLeftVal;
    //左电机差速
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
    
    //如果堵转的话就停下(需要编码器，刚开始做车的阶段关闭)
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
    
    //左电机D分量
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
   
      //积分限幅
    if(SpeedLeftValP>800)
    {
      SpeedLeftValP=800;
    }
    else if(SpeedLeftValP<-800)
    {
       SpeedLeftValP=-800;
    }
    
    //左电机D分量
    SpeedLeftValD +=  (SpeedTargetLeftVal - SpeedNowLeft) - (SpeedLastTargetLeftVal - SpeedLastLeft);
    
    //左电机输入值。/////////////////////////////////////////////////增量式！！
    SpeedLeftVal = (speed_kp*SpeedLeftValP +speed_kd* SpeedLeftValD*10)/100;
   
    //左电机输入值的限幅。
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

   
      
    //计算右电机应输入的值。
    //储存为上一次右电机的目标速度
    SpeedLastTargetRightVal = SpeedTargetRightVal;
    //右电机差速
    if(SpeedDiffGetSwitch == 1)
    {
      SpeedTargetRightVal = SpeedDiffGet(SpeedTargetVal, 1);   
      SpeedTargetRightVal=(SpeedTargetRightVal*9+SpeedLastTargetRightVal*1)/10;
    }
    else
    {
      SpeedTargetRightVal = SpeedTargetVal; 
    }
    //右电机P分量
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

     //积分限幅
    if(SpeedRightValP>800)
    {
      SpeedRightValP=800;
    }
    else if(SpeedRightValP<-800)
    {
       SpeedRightValP=-800;
    }
    //右电机D分量
    SpeedRightValD +=  ((SpeedTargetRightVal - SpeedNowRight) - (SpeedLastTargetRightVal - SpeedLastRight));
    //右电机输入值。/////////////////////////////////////////////////增量式！！
    SpeedRightVal = (speed_kp *SpeedRightValP/10 + speed_kd*SpeedRightValD);
    
    //右电机输入值的限幅。
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

      if(StopFlag == 1)   //确认完全停车后，输出为0
      {
          //停车保险计数
          StopFlagMaxCount++;
          //int32 speed;//车的中心速度，两轮速度的平均值
         //左右轮任何一个轮子速度低于某值，或到一定时间，则完全停车，停下电机。
         if(SpeedNowLeft < 20 || SpeedNowRight < 20 || StopFlagMaxCount > StopFlagMaxCountNum * 6) //16ms进来一次，乘以6表示以0.1s为单位。
         {
           StopRealFlag = 1;//完全停车，停下电机      
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
        //赋值给电机实际对应的I/O口。
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






