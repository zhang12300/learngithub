/******************************************************************************/
/*******************************************************************************
  文件名：Fuzzy.c
  功  能：偏差处理，模糊控制
  日  期：2015.05.29
  作  者：YCR
  备  注：
*******************************************************************************/
/******************************************************************************/

#include "Fuzzy.h"

uint16 SpeedNowLeft = 0;                //左电机实时脉冲数，对应300线编码器的脉冲数。
uint16 SpeedNowRight = 0;               //右电机实时脉冲数，对应300线编码器的脉冲数。
uint16 SpeedLastLeft = 0;               //上一次左电机实时脉冲数，对应300线编码器的脉冲数。
uint16 SpeedLastRight = 0;              //上一次右电机实时脉冲数，对应300线编码器的脉冲数。
uint16 QuadLastLeftCount=0;
uint16 QuadLastRightCount=0;
uint16 speed_fu=0;                      //速度隶属度求取
uint8 speed_grade=0;                    //速度等级
int32 DeviFusemtr[11];             //偏差的隶属度
int32 DeviFuse_dotmtr[9];         //偏差变化率隶属度
int32 DeviFuse_dot;               //偏差的变化率
//多行控制的行的权重，控制量是近行偏差
uint8 ControlRow_Weight[2][6] =
{
30,40,60,80,100,100, //近行权重
20,16,12,7,5,0  //远行权重
//25,20,15,9,7,1  //远行权重
};


//======================================================================
//函数名：BiasCal
//功  能：计算给定行的偏移量
//参  数：row给定的计算行(1到ROW_MAX_UNDIS)(注意取值范围)
//影  响：
//返  回：bias该行的偏差
//说  明：1. 这个函数在DeviationFuse函数中调用，也就是至少有一条线成功才有可能调用本函数。
//======================================================================
int32 BiasCal(int32 row)
{
  int32 searchline;  //搜索行
  int32 leftborder, rightborder; //左右边界
  int32 bias;       //偏差
  float offset;     //偏移量
  float slope;      //斜率
  
  //不用判断Done标志，因为只有黑线提取成功才不会是MaxValUint8，才有可能小于row.
  
  //左右黑线均有效
  
  if(BlackLeftDone == 1 && BlackRightDone == 1)
  {
    //左右黑线头均满足
    if(BlackUdisLeftLocation[BlackLeftHeadLine].y <= row && BlackUdisRightLocation[BlackRightHeadLine].y <= row)
    {
      //搜索该行在哪两行之间(这里直接搜索左线就行了，不用搜索右线)
      for(searchline = BlackLeftHeadLine; searchline <= CameraHight - 1; searchline++)
      {
        if(BlackUdisLeftLocation[searchline].y >= row)
        {
          break;
        }      
      }
      
      //左右边界求取
      //如果刚好在线头上，就直接按该线头所在列作为左右边界。
      if(searchline == BlackLeftHeadLine)
      {
        leftborder = BlackUdisLeftLocation[searchline].x;
        rightborder = BlackUdisRightLocation[searchline].x;
      }
      else
      {      
          if((BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y)!=0 && (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y)!=0)
          {
        //插值计算该行畸变矫正后的左边界
        leftborder = (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
                   / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y) + BlackUdisLeftLocation[searchline-1].x;
        //插值计算该行畸变矫正后的右边界
        rightborder = (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
                    / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y) + BlackUdisRightLocation[searchline-1].x;
          }
          else
          {
             //插值计算该行畸变矫正后的左边界
        leftborder = (int)((BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
                   / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y+0.1) + BlackUdisLeftLocation[searchline-1].x);
        //插值计算该行畸变矫正后的右边界
        rightborder = (int)((BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
                    / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y+0.1) + BlackUdisRightLocation[searchline-1].x);
          }
      }
      
      //偏差求取，物理中心点与实际中心点的差即为偏差
      bias = CameraRealWidth / 2 - (leftborder + rightborder) / 2;
      
    }
    //只有左线头满足
    else if(BlackUdisLeftLocation[BlackLeftHeadLine].y <= row)
    {
      //搜索该行在哪两行之间
      for(searchline = BlackLeftHeadLine; searchline <= CameraHight - 1; searchline++)
      {
        if(BlackUdisLeftLocation[searchline].y >= row)
        {
          break;
        }
      }
      
      //左边界求取
      if(searchline == BlackLeftHeadLine)
      {
        leftborder = BlackUdisLeftLocation[searchline].x;
      }
      else
      {     
        //插值计算该行畸变矫正后的左黑线的列
        leftborder = (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
                   / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y) + BlackUdisLeftLocation[searchline-1].x;
      }
      
      //偏移量求取，通过斜率估算偏移量。
      if(searchline <= CameraHight-5 && searchline == BlackLeftHeadLine)
      {
        slope = 1.0 * (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline+4].x) / 
                      (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline+4].y);
      }
      else if(searchline <= CameraHight-5)
      {
        slope = 1.0 * (BlackUdisLeftLocation[searchline-1].x - BlackUdisLeftLocation[searchline+4].x) / 
                      (BlackUdisLeftLocation[searchline-1].y - BlackUdisLeftLocation[searchline+4].y);
      }
      else
      {
        slope = 0;
      }
      //超然的计算公式
      offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
      
      //偏差求取
      bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //记得加括号
    }
    //只有右线头满足
    else if(BlackUdisRightLocation[BlackRightHeadLine].y <= row)
    {
      //搜索该行在哪两行之间
      for(searchline = BlackRightHeadLine; searchline <= CameraHight - 1; searchline++)
      {
        if(BlackUdisRightLocation[searchline].y >= row)
        {
          break;
        }
      }
      
      //右边界求取
      if(searchline == BlackRightHeadLine)
      {
        rightborder = BlackUdisRightLocation[searchline].x;
      }
      else
      {
        //插值计算该行畸变矫正后的左黑线的列
        rightborder = (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
                    / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y) + BlackUdisRightLocation[searchline-1].x;
      }
      
      //偏移量求取，通过斜率估算偏移量。
      if(searchline <= CameraHight-5 && searchline == BlackRightHeadLine)
      {
        slope = 1.0 * (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline+4].x) / 
                      (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline+4].y);
      }
      else if(searchline <= CameraHight-5)
      {
        slope = 1.0 * (BlackUdisRightLocation[searchline-1].x - BlackUdisRightLocation[searchline+4].x) / 
                      (BlackUdisRightLocation[searchline-1].y - BlackUdisRightLocation[searchline+4].y);
      }
      else
      {
        slope = 0;
      }
      //超然的计算公式
      offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
      
      //偏差求取
      bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //记得加括号
    }
    //左右线头均不满足
    else
    {
      
      //左线头比右线头远，同时也包括了左线成功右线失败的情况。(失败时是MaxValUint8)
      //
      if(BlackLeftHeadLine <= BlackRightHeadLine)
      {
        //直将把左线头作为基本计算行
        searchline = BlackLeftHeadLine;
              
        //计算斜率
        if(searchline <= CameraHight-5)
        {
          slope = 1.0 * (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline+4].x) / 
                        (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline+4].y);
        }
        
        else
        {
          slope = 0;
        }
        //计算偏移量
        offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
        //计算左边界
        leftborder = (int32)(BlackUdisLeftLocation[searchline].x + (row - BlackUdisLeftLocation[searchline].y) * slope); 
        //计算偏差
        bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //记得加括号
      }
      //右线头比左线头远，同时也包括了左线失败右线成功的情况。(失败时是MaxValUint8)
      else
      {
        //直将把右线头作为基本计算行
        searchline = BlackRightHeadLine;
       
       
        //计算斜率
        if(searchline <= CameraHight-5)
        {
          slope = 1.0 * (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline+4].x) / 
                        (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline+4].y);
        }
        else
        {
          slope = 0;
        }
        //计算偏移量
        offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
        //计算右边界
        rightborder = (int32)(BlackUdisRightLocation[searchline].x + (row - BlackUdisRightLocation[searchline].y) * slope); 
        //计算偏差
        bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //记得加括号
      }
    }
  }
  //只有左黑线有效
  else if(BlackLeftDone == 1)
  {
    //左线头满足条件
    if(BlackUdisLeftLocation[BlackLeftHeadLine].y <= row)
    {
      //搜索该行在哪两行之间
      for(searchline = BlackLeftHeadLine; searchline <= CameraHight - 1; searchline++)
      {
        if(BlackUdisLeftLocation[searchline].y >= row)
        {
          break;
        }
      }
      
      //左边界求取
      if(searchline == BlackLeftHeadLine)
      {
        leftborder = BlackUdisLeftLocation[searchline].x;
      }
      else
      {     
        //插值计算该行畸变矫正后的左黑线的列
        leftborder = (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
                   / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y) + BlackUdisLeftLocation[searchline-1].x;
      }
      
      //偏移量求取，通过斜率估算偏移量。
      if(searchline <= CameraHight-5 && searchline == BlackLeftHeadLine)
      {
        slope = 1.0 * (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline+4].x) / 
                      (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline+4].y);
      }
      else if(searchline <= CameraHight-5)
      {
        slope = 1.0 * (BlackUdisLeftLocation[searchline-1].x - BlackUdisLeftLocation[searchline+4].x) / 
                      (BlackUdisLeftLocation[searchline-1].y - BlackUdisLeftLocation[searchline+4].y);
      }
      else
      {
        slope = 0;
      }
      //超然的计算公式
      offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
      
      //偏差求取
      bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //记得加括号
    }
    //左线头不满足条件，不够远。
    else
    {
        //直将把左线头作为基本计算行
        searchline = BlackLeftHeadLine;
       
       
        
        //计算斜率
        if(searchline <= CameraHight-5)
        {
          slope = 1.0 * (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline+4].x) / 
                        (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline+4].y);
        }
        else
        {
          slope = 0;
        }
        //计算偏移量
        offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
        //计算左边界
        leftborder = (int32)(BlackUdisLeftLocation[searchline].x + (row - BlackUdisLeftLocation[searchline].y) * slope); 
        //计算偏差
        bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //记得加括号
    }
  }
  else if(BlackRightDone == 1)
  {
    //右线头满足条件
    if(BlackUdisRightLocation[BlackRightHeadLine].y <= row)
    {
      //搜索该行在哪两行之间
      for(searchline = BlackRightHeadLine; searchline <= CameraHight - 1; searchline++)
      {
        if(BlackUdisRightLocation[searchline].y >= row)
        {
          break;
        }
      }
      
      //右边界求取
      if(searchline == BlackRightHeadLine)
      {
        rightborder = BlackUdisRightLocation[searchline].x;
      }
      else
      {
        //插值计算该行畸变矫正后的左黑线的列
        rightborder = (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
                    / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y) + BlackUdisRightLocation[searchline-1].x;
      }
      
      //偏移量求取，通过斜率估算偏移量。
      if(searchline <= CameraHight-5 && searchline == BlackRightHeadLine)
      {
        slope = 1.0 * (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline+4].x) / 
                      (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline+4].y);
      }
      else if(searchline <= CameraHight-5)
      {
        slope = 1.0 * (BlackUdisRightLocation[searchline-1].x - BlackUdisRightLocation[searchline+4].x) / 
                      (BlackUdisRightLocation[searchline-1].y - BlackUdisRightLocation[searchline+4].y);
      }
      else
      {
        slope = 0;
      }
      //超然的计算公式
      offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
      
      //偏差求取
      bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //记得加括号
    }
    //右线头不满足条件，不够远
    else
    {
        //直将把右线头作为基本计算行
        searchline = BlackRightHeadLine;
        
       
        //计算斜率
        if(searchline <= CameraHight-5)
        {
          slope = 1.0 * (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline+4].x) / 
                        (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline+4].y);
        }
        else
        {
          slope = 0;
        }
        //计算偏移量
        offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
        //计算右边界
        rightborder = (int32)(BlackUdisRightLocation[searchline].x + (row - BlackUdisRightLocation[searchline].y) * slope); 
        //计算偏差
        bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //记得加括号
    }
  }
  //理论上不会走到这里
  else 
  {    
  }
  
  return bias;
}

//------------------------------------------------------------------------------
//函数名：SpeedRealTimeGet
//功  能：实时速度获取，确定速度等级
//参  数：
//返  回：
//说  明：将脉冲数归算到实际速度，扩大1000陪.speed_fu为隶属度
//------------------------------------------------------------------------------
uint8 SpeedRealTimeGet(void)
{
  int32 speed;//车的中心速度，两轮速度的平均值
  //储存上一次的脉冲数
  SpeedLastLeft = SpeedNowLeft;          
  SpeedLastRight = SpeedNowRight;  
  //更新左右电机实时脉冲数，且进行了滤波操作。
  QuadLeftCount=(QuadLeftCount*3+QuadLastLeftCount*7)/10;
  QuadRightCount=(QuadRightCount*3+QuadLastRightCount*7)/10;
  
  QuadLastLeftCount=QuadLeftCount;
  QuadLastRightCount=QuadRightCount;
  
  SpeedNowLeft = QuadLeftCount*200*100/(3250*3);//脉冲数转化为实际速度，扩大了100倍。1m对应5260个脉冲，500/3对应6毫秒
  SpeedNowRight = QuadRightCount*200*100/(3250*3);//脉冲数转化为实际速度，扩大了100倍。1m对应5260个脉冲，500/3对应6毫秒
  
  speed=(SpeedNowLeft)*10;//平均速度

  //speed=2100;//速度给成定值，调试用
  if(speed<1000)
    {
      speed_grade = 1;
      speed_fu = 0;
    }
    else if(speed<1400)
    {
      speed_grade = 1;
      speed_fu = (speed - 1000)*1000 / (1400 - 1000);
    }
    else if(speed<1600)
    {
      speed_grade = 2;
      speed_fu = (speed - 1400)*1000 / (1600 - 1400);
    }
    else if(speed<1700)
    {
      speed_grade = 3;
      speed_fu = (speed - 1600)*1000 / (1700 - 1600);
    }
    else if(speed<1800)
    {
      speed_grade = 4;
      speed_fu = (speed - 1700)*1000 / (1800 - 1700);
    }
    else if(speed<1900)
    {
      speed_grade = 5;
      speed_fu = (speed - 1800)*1000 / (1900 - 1800);
    }
    else if(speed<2000)
    {
      speed_grade = 6;
      speed_fu = (speed - 1900)*1000 / (2000 - 1900);
    }
    else if(speed<2100)
    {
      speed_grade = 7;
      speed_fu = (speed - 2000)*1000 / (2100 - 2000);
    }
    else if(speed<2200)
    {
      speed_grade = 8;
      speed_fu = (speed - 2100)*1000 / (2200 - 2100);
    }
    else if(speed<2300)
    {
      speed_grade = 9;
      speed_fu = (speed - 2200)*1000 / (2300 - 2200);
    }
    else if(speed<2400)
    {
      speed_grade = 10;
      speed_fu = (speed - 2300)*1000 / (2400 - 2300);
    }
    else if(speed<2500)
    {
      speed_grade = 11;
      speed_fu = (speed - 2400)*1000 / (2500 - 2400);
    }
    else if(speed<2600)
    {
      speed_grade = 12;
      speed_fu = (speed - 2500)*1000 / (2600 - 2500);
    }
    else if(speed<2700)
    {
      speed_grade = 13;
      speed_fu = (speed - 2600)*1000 / (2700 - 2600);
    }
    else if(speed<2800)
    {
      speed_grade = 14;
      speed_fu = (speed - 2700)*1000 / (2800 - 2700);
    }
    else if(speed<2900)
    {
      speed_grade = 15;
      speed_fu = (speed - 2800)*1000 / (2900 - 2800);
    }
    else if(speed<3000)
    {
      speed_grade = 16;
      speed_fu = (speed - 2900)*1000 / (3000 - 2900);
    }
    else
    {
      speed_grade = 16;
      speed_fu = 1000;
    }
  return 1;
}



//======================================================================
//函数名：DeviationFuse
//功  能：多行偏差的融合
//参  数：
//返  回：
//影  响：
//说  明： 
//      
//             
//======================================================================
uint8 DeviationFuse(void)
{    
  //uint8 i;
 //int32 DeviPredict;
  
  //多行偏差融合预处理
  int32 near_p,far_p,temp,temp_far;
  int32 Devi_near_fu;
  uint8 Devi_near_grade;
  uint8 line_far_index;
  
  Devi_near=PhyCenterCol-(CenterLineLoc[BlackControlLineLow-2]+CenterLineLoc[BlackControlLineLow-1]+CenterLineLoc[BlackControlLineLow]+CenterLineLoc[BlackControlLineLow+1]+CenterLineLoc[BlackControlLineLow+2])/5;
  //Devi_far=PhyCenterCol-CenterLineLoc[BlackControlLineFar];
  
  if(Devi_near>140)
  {
    Devi_near=140;
  }
  else if(Devi_near<-140)
  {
    Devi_near=-140;  
  }
  
  temp=AbsInt(Devi_near);
  
  if(temp<20)
  {
    Devi_near_grade=1;
    Devi_near_fu=(temp-0)*1000/(20-0);
  }
  else if(temp<50)
  {
    Devi_near_grade=2;
    Devi_near_fu=(temp-20)*1000/(50-20);
  }
  else if(temp<70)
  {
     Devi_near_grade=3;
     Devi_near_fu=(temp-50)*1000/(70-50);
  }  
  else if(temp<90)
  {
     Devi_near_grade=4;
     Devi_near_fu=(temp-70)*1000/(90-70);
  }
  else if(temp<120)
  {
     Devi_near_grade=5;
     Devi_near_fu=(temp-90)*1000/(120-90);
  }
  else
  {
     Devi_near_grade=5;
     Devi_near_fu=1000;
  }
   
  if(temp<15)
    {
     line_far_index=15;    //近行很小，用最远的行20
    }
  else 
    {
     line_far_index=15+(temp-15)/10; 
    }
  if(line_far_index>18) line_far_index=18;

  
  //超前滞后滤，单行容易错
  temp_far=(CenterLineLoc[line_far_index-2]+CenterLineLoc[line_far_index-1]+CenterLineLoc[line_far_index]+CenterLineLoc[line_far_index+1]+CenterLineLoc[line_far_index+2])/5;
  
  Devi_far=PhyCenterCol-temp_far;
  if(Devi_far>140)
  {
    Devi_far=140;
  }
  else if(Devi_far<-140)
  {
    Devi_far=-140;  
  }
  
    
    near_p=(Devi_near_fu*ControlRow_Weight[0][Devi_near_grade]+(1000-Devi_near_fu)*ControlRow_Weight[0][Devi_near_grade-1])/1000;
    far_p=(Devi_near_fu*ControlRow_Weight[1][Devi_near_grade]+(1000-Devi_near_fu)*ControlRow_Weight[1][Devi_near_grade-1])/1000;
    DeviPrePrePre=DeviPrePre;
    DeviPrePre=DeviPre;
    DeviPre=DeviFuse;
    
    DeviFuse=(Devi_near*near_p+Devi_far*far_p)/(near_p+far_p);
    
    
  //两次跳变太大，认为是错误点
  
  if(DeviFuse>DeviPre+100)      //本来是100
  {
    DeviFuse=DeviPre;
  }
  else if(DeviFuse<DeviPre-100)
  {
     DeviFuse=DeviPre;
  } 
  /*
   int tempDeviJudge;
  tempDeviJudge=((DeviPre-DeviPrePre)*7+(DeviPrePre-DeviPrePrePre)*3)/10;
  if(tempDeviJudge>0)
  {
    if(DeviFuse-DeviPre<-45)
    {
       DeviFuse=DeviPre;
    }     
  }
 else
 {
   if(DeviFuse-DeviPre>45)
    {
       DeviFuse=DeviPre;
    }     
 }
*/
  return 1;
}//end of DeviationFuse





//======================================================================
//函数名：MtrGet
//功  能：隶属度计算函数
//参  数：
//返  回：
//影  响：
//说  明：输入近行（第39行偏差），根据近行偏差确定不同行的权重
//      
//             
//======================================================================
uint8 MtrGet(void)
{
   uint8 i;
      //偏差隶属度计算,先清零
      for(i=0;i<11;i++)
      {
        DeviFusemtr[i]=0;
      }
      
      
      if(DeviFuse<=0-80)
      {
        DeviFusemtr[0]=1000;
      }
       else if(DeviFuse<=0-60)
       {
          DeviFusemtr[0]=(-60-DeviFuse)*1000/(80-60);
          DeviFusemtr[1]=1000-DeviFusemtr[0];
       }
       else if(DeviFuse<=0-40)
        {
          DeviFusemtr[1]=(-40-DeviFuse)*1000/(60-40);
          DeviFusemtr[2]=1000-DeviFusemtr[1];
        }
        else if(DeviFuse<=0-20)
        {
          DeviFusemtr[2]=(-20-DeviFuse)*1000/(40-20);
          DeviFusemtr[3]=1000-DeviFusemtr[2];
        } 
        else if(DeviFuse<=0-10)
        {
          DeviFusemtr[3]=(-10-DeviFuse)*1000/(20-10);
          DeviFusemtr[4]=1000-DeviFusemtr[3];
        } 
        else if(DeviFuse<=0)
        {
          DeviFusemtr[4]=(-0-DeviFuse)*1000/(10-0);
          DeviFusemtr[5]=1000-DeviFusemtr[4];
        } 
        else if(DeviFuse<=10)
        {
          DeviFusemtr[5]=(10-DeviFuse)*1000/(10-0);
          DeviFusemtr[6]=1000-DeviFusemtr[5];

        } 
        else if(DeviFuse<=20)
        {
          DeviFusemtr[6]=(20-DeviFuse)*1000/(20-10);
          DeviFusemtr[7]=1000-DeviFusemtr[6];
        } 
        else if(DeviFuse<=40)
        {
          DeviFusemtr[7]=(40-DeviFuse)*1000/(40-20);
          DeviFusemtr[8]=1000-DeviFusemtr[7];
        } 
        else if(DeviFuse<=60)
        {
          DeviFusemtr[8]=(60-DeviFuse)*1000/(60-40);
          DeviFusemtr[9]=1000-DeviFusemtr[8];
        } 
        else if(DeviFuse<=80)
        {
          DeviFusemtr[9]=(80-DeviFuse)*1000/(80-60);
          DeviFusemtr[10]=1000-DeviFusemtr[9];
        }        
        else
        {
          DeviFusemtr[10]=1000;
         
        }

        DeviFuse_dot=DeviFuse-DeviPre;//求取偏差变化率
        
      //计算DeviFuse_dot的隶属度
   
        for(i=0;i<9;i++)//隶属度清零
        {
          DeviFuse_dotmtr[i]=0;
        }
        
        if(DeviFuse_dot<=-15)
        {
          DeviFuse_dotmtr[0]=1000;
        }
        else if(DeviFuse_dot<=-10)
        {
          DeviFuse_dotmtr[0]=(-10-DeviFuse_dot)*200;
          DeviFuse_dotmtr[1]=1000-DeviFuse_dotmtr[0];
        }
          else if(DeviFuse_dot<=-6)
        {
          DeviFuse_dotmtr[1]=(-6-DeviFuse_dot)*250;
          DeviFuse_dotmtr[2]=1000-DeviFuse_dotmtr[1];
        }
          else if(DeviFuse_dot<=-2)
        {
          DeviFuse_dotmtr[2]=(-2-DeviFuse_dot)*250;
          DeviFuse_dotmtr[3]=1000-DeviFuse_dotmtr[2];
        }
        else if(DeviFuse_dot<=0)
        {
          DeviFuse_dotmtr[3]=(0-DeviFuse_dot)*500;
          DeviFuse_dotmtr[4]=1000-DeviFuse_dotmtr[3];
        }
        else if(DeviFuse_dot<=2)
        {
          DeviFuse_dotmtr[4]=(2-DeviFuse_dot)*500;
          DeviFuse_dotmtr[5]=1000-DeviFuse_dotmtr[4];
        }
        else if(DeviFuse_dot<=6)
        {
          DeviFuse_dotmtr[5]=(6-DeviFuse_dot)*250;
          DeviFuse_dotmtr[6]=1000-DeviFuse_dotmtr[5];
        }
        else if(DeviFuse_dot<=10)
        {
          DeviFuse_dotmtr[6]=(10-DeviFuse_dot)*250;
          DeviFuse_dotmtr[7]=1000-DeviFuse_dotmtr[6];
        }
        else if(DeviFuse_dot<=15)
        {
          DeviFuse_dotmtr[7]=(15-DeviFuse_dot)*200;
          DeviFuse_dotmtr[8]=1000-DeviFuse_dotmtr[7];
        }
        else 
        {
          DeviFuse_dotmtr[8]=1000;
        }
      
        return 1;
}
