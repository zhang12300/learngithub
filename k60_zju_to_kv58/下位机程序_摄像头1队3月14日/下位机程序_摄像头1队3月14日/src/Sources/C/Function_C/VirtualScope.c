/******************************************************************************/
/*******************************************************************************
  文件名：虚拟示波器C文件VirtualScope.c
  功  能：给虚拟示波器发送数据
  日  期：2014.11.18
  作  者：
  备  注：
*******************************************************************************/
/******************************************************************************/

#include "VirtualScope.h"

int16 ErrorCountNow6 = 0;

uint32 tic1;  //计时用起始数，记录定时器的值。
uint32 toc1;  //计时用终止数，记录定时器的值。
uint32 tic2;  //计时用起始数，记录定时器的值。
uint32 toc2;  //计时用终止数，记录定时器的值。
uint32 tic3;  //计时用起始数，记录定时器的值。
uint32 toc3;  //计时用终止数，记录定时器的值。
uint32 tic4;  //计时用起始数，记录定时器的值。
uint32 toc4;  //计时用终止数，记录定时器的值。
uint32 tic5;  //计时用起始数，记录定时器的值。
uint32 toc5;  //计时用终止数，记录定时器的值。
uint32 tic6;  //计时用起始数，记录定时器的值。
uint32 toc6;  //计时用终止数，记录定时器的值。
uint32 tic7;  //计时用起始数，记录定时器的值。
uint32 toc7;  //计时用终止数，记录定时器的值。


uint8 uSendBuf[UartDataNum*2]={0};
uint8 FreeCarsDataNum=UartDataNum*2;

float VirtualOutData[4] = { 0 };

unsigned short CRC_CHECK(unsigned char *Buf, unsigned char CRC_CNT)
{
    unsigned short CRC_Temp;
    unsigned char i,j;
    CRC_Temp = 0xffff;

    for (i=0;i<CRC_CNT; i++){      
        CRC_Temp ^= Buf[i];
        for (j=0;j<8;j++) {
            if (CRC_Temp & 0x01)
                CRC_Temp = (CRC_Temp >>1 ) ^ 0xa001;
            else
                CRC_Temp = CRC_Temp >> 1;
        }
    }
    return(CRC_Temp);
}

void VirtualOutPut_Data(void)
{
  int temp[4] = {0};
  unsigned int temp1[4] = {0};
  unsigned char databuf[10] = {0};
  unsigned char i;
  unsigned short CRC16 = 0;
  for(i=0;i<4;i++)
   {
    
    temp[i]  = (int)VirtualOutData[i];
    temp1[i] = (unsigned int)temp[i];
    
   }
   
  for(i=0;i<4;i++) 
  {
    databuf[i*2]   = (unsigned char)(temp1[i]%256);
    databuf[i*2+1] = (unsigned char)(temp1[i]/256);
  }
  
  CRC16 = CRC_CHECK(databuf,8);
  databuf[8] = CRC16%256;
  databuf[9] = CRC16/256;
  
  for(i=0;i<10;i++)
  uart_send1(UART0,databuf[i]);
}

void VirtualScopeSend(void)
{
  float temp1;  
  float temp2; 
  float temp3;

  if(tic1 > toc1)
  {
    temp1 = (tic1 - toc1) / 75 ;
  }
  else
  {
    temp1 = 100;
  }
  
  if(tic2 > toc2)
  {
    temp2 = (tic2 - toc2) / 75;
  }
  else
  {
    temp2 = 100;
  }
  
  if(tic3 > toc3)
  {
    temp3 = (tic3 - toc3) / 75;
  }
  else
  {
    temp3 = 100;
  }
  
  //ServoPercent = 
  
/*
  VirtualOutData[0] = PathType;                  //赛道类型 0未知 1直道 2左内 3左中 4左外 5右内 6右中 7右外
  VirtualOutData[1] = CURVEL;                    //左黑线的曲率，因为基于的点数会变化，所以有可能变化很大。
  VirtualOutData[2] = CURVEC;                    //中心线的曲率，因为基于的点数会变化，所以有可能变化很大。
  VirtualOutData[3] = CURVER;                    //右黑线的曲率，因为基于的点数会变化，所以有可能变化很大。
    */
/*
  VirtualOutData[0] = DeviRowChosen;                   //偏差求取时，选中的行号。
  VirtualOutData[1] = CenterLineLoc[DeviRowChosen];    //偏差求取时，选中的行号对应的中心线的值。
  VirtualOutData[2] = BlackLeftLoc[DeviRowChosen][0];  //偏差求取时，选中的行号对应的左黑线的值。
  VirtualOutData[3] = BlackRightLoc[DeviRowChosen][0]; //偏差求取时，选中的行号对应的右黑线的值。
  */
    /*
  VirtualOutData[0] = temp1;                      //采集图像所花的时间，单位为ms
  VirtualOutData[1] = temp2;                      //处理图像和反馈控制所花的总时间，单位为ms
  VirtualOutData[2] = DeviNow;                    //当前偏差。
  VirtualOutData[3] = ServoPercent;               //舵机打角的百分值，取值从-100到+100，左右不对称，左正右负。
*/
  /*
  VirtualOutData[0] = PathType;                 
  VirtualOutData[1] = SpeedFlag;                    
  VirtualOutData[2] = DeviNow;                    
  VirtualOutData[3] = ServoPercent;                   
  */
  
  VirtualOutData[0] = temp1;        
  VirtualOutData[1] = temp2;
  VirtualOutData[2] = temp3;
  VirtualOutData[3] = SlopeC;
  
  VirtualOutPut_Data();
}

void Virtual2DataPush(uint8 chanel,uint16 data)
{
    uSendBuf[chanel*2]=data/256;
    uSendBuf[chanel*2+1]=data%256;
}


void Virtual2Send(void)
{
  uint8 i,sum=0; 
  //使用轮询的方式发送数据，当数据未发送，程序停在此处直到发送完成
  uart_send1(UART0,251);
  uart_send1(UART0,109);
  uart_send1(UART0,37);
  sum+=(251);      //全部数据加入校验
  sum+=(109);
  sum+=(37);
  for(i=0;i<FreeCarsDataNum;i++)
  {
    uart_send1(UART0,uSendBuf[i]);
    sum+=uSendBuf[i];         //全部数据加入校验
  }
  uart_send1(UART0,sum);
}


void Virtual2SendData(void)
{
  uint16 temp1, temp2, temp3, temp4, temp5, temp6, temp7;
    
  ErrorCountNow6++;
  
  
  if(tic1 > toc1)
  {
    temp1 = (tic1 - toc1) / 75000;
  }
  else
  {
    temp1 = 50;
  }  
  
  
  if(tic2 > toc2)
  {
    temp2 = (tic2 - toc2) / 75000;
  }
  else
  {
    temp2 = 50;
  }
  
  if(tic3 > toc3)
  {
    temp3 = (tic3 - toc3) / 75000;
  }
  else
  {
    temp3 = 50;
  }  

  if(tic4 > toc4)
  {
    temp4 = (tic4 - toc4) / 75000;
  }
  else
  {
    temp4 = 50;
  }
  
  if(tic5 > toc5)
  {
    temp5 = (tic5 - toc5) / 75000;
  }
  else
  {
    temp5 = 50;
  }
  
  if(tic6 > toc6)
  {
    temp6 = (tic6 - toc6) / 75;
  }
  else
  {
    temp6 = 50;
  }
  
  if(tic7 > toc7)
  {
    temp7 = (tic7 - toc7) / 75;
  }
  else
  {
    temp7 = 50;
  }
    
  
  Virtual2DataPush( 0, ServoPIDInputVal-1000);
  Virtual2DataPush( 1, SpeedLeftVal);
  Virtual2DataPush( 2, SpeedTargetLeftVal);
  Virtual2DataPush( 3, SpeedNowLeft);
  Virtual2DataPush( 4, DeviFuse);
  Virtual2DataPush( 5, DeviFuse-DeviPre);
  Virtual2DataPush( 6, ShiZhiFlag*200);
  
  Virtual2DataPush( 7, PathType*300);
  Virtual2DataPush( 8, LightHouseWaitStopDelayFlag);

  Virtual2DataPush( 9, GyroResultFlag);
  Virtual2DataPush(10, BrickSpeDealCenFlag * 100);  
  Virtual2DataPush(11, StopFlag);
  Virtual2DataPush(12, StopRealFlag);
  Virtual2DataPush(13, BrickSpeDealFlag * 100);
  Virtual2DataPush(14, BrickSpeDealBackCount);  
  Virtual2DataPush(15, PathRealStraightFlag);
  Virtual2DataPush(16, PathType);
 
  
  
//    Virtual2DataPush( 0, DeviFuse);
//    Virtual2DataPush( 1, ImgProSucceedFlag * 100);
//    Virtual2DataPush( 2, ServoPIDInputVal - ServoPIDCen);
//    Virtual2DataPush( 3, BlackLeftHeadLine);
//    Virtual2DataPush( 4, BlackRightHeadLine);
//    Virtual2DataPush( 5, StopFlag);
//    Virtual2DataPush( 6, SpeedPIDDVal);  
//    Virtual2DataPush( 7, speed_kp);
//    Virtual2DataPush( 8, speed_kd);
//    
//    Virtual2DataPush( 9, SpeedNowLeft);
//    Virtual2DataPush(10, SpeedTargetLeftVal);  
//    Virtual2DataPush(11, SpeedLeftVal);
//    Virtual2DataPush(12, SpeedNowRight);
//    Virtual2DataPush(13, SpeedTargetRightVal);
//    Virtual2DataPush(14, SpeedRightVal);  
//    Virtual2DataPush(15, SpeedRightValP);
//    Virtual2DataPush(16, SpeedRightValD);
  
   /*
  Virtual2DataPush( 0, DeviFuse);
  Virtual2DataPush( 1, ImgProSucceedFlag * 100);
  Virtual2DataPush( 2, LimitLeftHeadWB);
  Virtual2DataPush( 3, LimitLeftHeadB);
  Virtual2DataPush( 4, LimitLeftHeadW);
  Virtual2DataPush( 5, flag000);
  Virtual2DataPush( 6, countcount);
  
  Virtual2DataPush( 7, CURVEL);
  Virtual2DataPush( 8, CURVER);
  
  Virtual2DataPush( 9, BlackRightHeadLine-BlackLeftHeadLine);
  Virtual2DataPush(10, PathType);  
  Virtual2DataPush(11, AngleConfirmCount);
  Virtual2DataPush(12, AngleConfirmCountMax);
  Virtual2DataPush(13, AngleConfirmLockFlag);
  Virtual2DataPush(14, AngleSpeDealBackCount);  
  Virtual2DataPush(15, AngleSpeDealDir);
  Virtual2DataPush(16, BlackRightContinueFlag);
   
  
 
 
 
   Virtual2DataPush( 5, BlackLeftHeadLine);
  Virtual2DataPush( 6, BlackRightHeadLine);
  
  Virtual2DataPush( 7, PathType);
  Virtual2DataPush( 8, flag000);

  Virtual2DataPush( 9, flag111);  
  Virtual2DataPush(10, temp3);  
  Virtual2DataPush(11, AngleConfirmCount);
  Virtual2DataPush(12, AngleConfirmCountMax);
  Virtual2DataPush(13, AngleConfirmFlag);
  Virtual2DataPush(14, AngleSpeDealDir);  
  Virtual2DataPush(15, AngleSpeDealBackCount);
  Virtual2DataPush(16, AngleSpeDealFlag);

  Virtual2DataPush( 0, DeviFuse);
  Virtual2DataPush( 1, ImgProSucceedFlag * 100);
  Virtual2DataPush( 2, ServoPIDInputVal-ServoPIDCen);
  Virtual2DataPush( 3, QuadRightCount);
  Virtual2DataPush( 4, SpeedTargetVal);
  Virtual2DataPush( 5, SpeedNowLeft);
  Virtual2DataPush( 6, SpeedTargetLeftVal);
  
  Virtual2DataPush( 7, SpeedLeftVal / 50);
  Virtual2DataPush( 8, SpeedNowRight);
  Virtual2DataPush( 9, BlackRightLoc[39][0]);
  Virtual2DataPush(10, BlackRightLoc[29][0]);  
  Virtual2DataPush(11, BlackRightLoc[19][0]);
  Virtual2DataPush(12, BlackRightLoc[14][0]);
  Virtual2DataPush(13, temptempSpeedLeftVal / 50);
  Virtual2DataPush(14, ADResult0);
  Virtual2DataPush(15, ADResult1);
  Virtual2DataPush(16, ADResult2);
  */
  
  /*
  Virtual2DataPush( 9, AngleConfirmFlag);           //直角弯最终确认标志，1确认，0否认
  Virtual2DataPush(10, AngleConfirmLockFlag);       //直角弯判断成功锁存标志位,确认是直角弯后置位，用以确认直角弯特殊处理开始的位置。
  Virtual2DataPush(11, AngleSpeDealDir);            //直角弯方向标志，0左直角弯，1右直角弯，2错误。
  Virtual2DataPush(12, AngleSpeDealBackCount);      //直角弯最终确认后，特殊情况次数的倒数计数。
  Virtual2DataPush(13, AngelSpeDealExitJudgeFlag);  //出直角弯判断标志，1已出，0未出
  Virtual2DataPush(14, AngleSpeDealFlag);           //1说明该幅图像进行了直角弯的特殊处理,0说明未进行。
  Virtual2DataPush(15, AngleConfirmCount);
  Virtual2DataPush(16, AngleConfirmCountMax);  
  
  //Virtual2DataPush(15, BlackLeftEndLine);
  //Virtual2DataPush(16, BlackRightEndLine);
  Virtual2DataPush(15, SpeedLeftVal);
  Virtual2DataPush(16, SpeedRightVal);
  Virtual2DataPush( 0, DeviFuse);

  Virtual2DataPush( 1, ImgBlackSucceedFlag * 100);
  Virtual2DataPush( 2, ErrorCountNow7);//场中断
  
  Virtual2DataPush( 3, ErrorCountNow8);     //行中断
  Virtual2DataPush( 4, ErrorCountNow9);     //DMA中断   
  Virtual2DataPush( 5, ErrorCountNow0);   //SERVO
  Virtual2DataPush( 6, ErrorCountNow1);   //MOTOR
  Virtual2DataPush( 7, ErrorCountNow5);   //IMAGEPRO
  Virtual2DataPush( 8, temp1);   //VIR
  Virtual2DataPush( 9, temp2);
  Virtual2DataPush(10, temp3);
  Virtual2DataPush(11, temp4);
  Virtual2DataPush(12, temp5);
  Virtual2DataPush(13, temp6);  
  Virtual2DataPush(14, temp7);
  Virtual2DataPush(15, QuadLeftCount);
  Virtual2DataPush(16, QuadRightCount);   
*/
  
 
  
  Virtual2Send();
}
