/******************************************************************************/
/*******************************************************************************
  �ļ�����Fuzzy.c
  ��  �ܣ�ƫ���ģ������
  ��  �ڣ�2015.05.29
  ��  �ߣ�YCR
  ��  ע��
*******************************************************************************/
/******************************************************************************/

#include "Fuzzy.h"

uint16 SpeedNowLeft = 0;                //����ʵʱ����������Ӧ300�߱���������������
uint16 SpeedNowRight = 0;               //�ҵ��ʵʱ����������Ӧ300�߱���������������
uint16 SpeedLastLeft = 0;               //��һ������ʵʱ����������Ӧ300�߱���������������
uint16 SpeedLastRight = 0;              //��һ���ҵ��ʵʱ����������Ӧ300�߱���������������
uint16 QuadLastLeftCount=0;
uint16 QuadLastRightCount=0;
uint16 speed_fu=0;                      //�ٶ���������ȡ
uint8 speed_grade=0;                    //�ٶȵȼ�
int32 DeviFusemtr[11];             //ƫ���������
int32 DeviFuse_dotmtr[9];         //ƫ��仯��������
int32 DeviFuse_dot;               //ƫ��ı仯��
//���п��Ƶ��е�Ȩ�أ��������ǽ���ƫ��
uint8 ControlRow_Weight[2][6] =
{
30,40,60,80,100,100, //����Ȩ��
20,16,12,7,5,0  //Զ��Ȩ��
//25,20,15,9,7,1  //Զ��Ȩ��
};


//======================================================================
//��������BiasCal
//��  �ܣ���������е�ƫ����
//��  ����row�����ļ�����(1��ROW_MAX_UNDIS)(ע��ȡֵ��Χ)
//Ӱ  �죺
//��  �أ�bias���е�ƫ��
//˵  ����1. ���������DeviationFuse�����е��ã�Ҳ����������һ���߳ɹ����п��ܵ��ñ�������
//======================================================================
int32 BiasCal(int32 row)
{
  int32 searchline;  //������
  int32 leftborder, rightborder; //���ұ߽�
  int32 bias;       //ƫ��
  float offset;     //ƫ����
  float slope;      //б��
  
  //�����ж�Done��־����Ϊֻ�к�����ȡ�ɹ��Ų�����MaxValUint8�����п���С��row.
  
  //���Һ��߾���Ч
  
  if(BlackLeftDone == 1 && BlackRightDone == 1)
  {
    //���Һ���ͷ������
    if(BlackUdisLeftLocation[BlackLeftHeadLine].y <= row && BlackUdisRightLocation[BlackRightHeadLine].y <= row)
    {
      //����������������֮��(����ֱ���������߾����ˣ�������������)
      for(searchline = BlackLeftHeadLine; searchline <= CameraHight - 1; searchline++)
      {
        if(BlackUdisLeftLocation[searchline].y >= row)
        {
          break;
        }      
      }
      
      //���ұ߽���ȡ
      //����պ�����ͷ�ϣ���ֱ�Ӱ�����ͷ��������Ϊ���ұ߽硣
      if(searchline == BlackLeftHeadLine)
      {
        leftborder = BlackUdisLeftLocation[searchline].x;
        rightborder = BlackUdisRightLocation[searchline].x;
      }
      else
      {      
          if((BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y)!=0 && (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y)!=0)
          {
        //��ֵ������л�����������߽�
        leftborder = (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
                   / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y) + BlackUdisLeftLocation[searchline-1].x;
        //��ֵ������л����������ұ߽�
        rightborder = (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
                    / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y) + BlackUdisRightLocation[searchline-1].x;
          }
          else
          {
             //��ֵ������л�����������߽�
        leftborder = (int)((BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
                   / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y+0.1) + BlackUdisLeftLocation[searchline-1].x);
        //��ֵ������л����������ұ߽�
        rightborder = (int)((BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
                    / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y+0.1) + BlackUdisRightLocation[searchline-1].x);
          }
      }
      
      //ƫ����ȡ���������ĵ���ʵ�����ĵ�ĲΪƫ��
      bias = CameraRealWidth / 2 - (leftborder + rightborder) / 2;
      
    }
    //ֻ������ͷ����
    else if(BlackUdisLeftLocation[BlackLeftHeadLine].y <= row)
    {
      //����������������֮��
      for(searchline = BlackLeftHeadLine; searchline <= CameraHight - 1; searchline++)
      {
        if(BlackUdisLeftLocation[searchline].y >= row)
        {
          break;
        }
      }
      
      //��߽���ȡ
      if(searchline == BlackLeftHeadLine)
      {
        leftborder = BlackUdisLeftLocation[searchline].x;
      }
      else
      {     
        //��ֵ������л�������������ߵ���
        leftborder = (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
                   / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y) + BlackUdisLeftLocation[searchline-1].x;
      }
      
      //ƫ������ȡ��ͨ��б�ʹ���ƫ������
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
      //��Ȼ�ļ��㹫ʽ
      offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
      
      //ƫ����ȡ
      bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //�ǵü�����
    }
    //ֻ������ͷ����
    else if(BlackUdisRightLocation[BlackRightHeadLine].y <= row)
    {
      //����������������֮��
      for(searchline = BlackRightHeadLine; searchline <= CameraHight - 1; searchline++)
      {
        if(BlackUdisRightLocation[searchline].y >= row)
        {
          break;
        }
      }
      
      //�ұ߽���ȡ
      if(searchline == BlackRightHeadLine)
      {
        rightborder = BlackUdisRightLocation[searchline].x;
      }
      else
      {
        //��ֵ������л�������������ߵ���
        rightborder = (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
                    / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y) + BlackUdisRightLocation[searchline-1].x;
      }
      
      //ƫ������ȡ��ͨ��б�ʹ���ƫ������
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
      //��Ȼ�ļ��㹫ʽ
      offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
      
      //ƫ����ȡ
      bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //�ǵü�����
    }
    //������ͷ��������
    else
    {
      
      //����ͷ������ͷԶ��ͬʱҲ���������߳ɹ�����ʧ�ܵ������(ʧ��ʱ��MaxValUint8)
      //
      if(BlackLeftHeadLine <= BlackRightHeadLine)
      {
        //ֱ��������ͷ��Ϊ����������
        searchline = BlackLeftHeadLine;
              
        //����б��
        if(searchline <= CameraHight-5)
        {
          slope = 1.0 * (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline+4].x) / 
                        (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline+4].y);
        }
        
        else
        {
          slope = 0;
        }
        //����ƫ����
        offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
        //������߽�
        leftborder = (int32)(BlackUdisLeftLocation[searchline].x + (row - BlackUdisLeftLocation[searchline].y) * slope); 
        //����ƫ��
        bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //�ǵü�����
      }
      //����ͷ������ͷԶ��ͬʱҲ����������ʧ�����߳ɹ��������(ʧ��ʱ��MaxValUint8)
      else
      {
        //ֱ��������ͷ��Ϊ����������
        searchline = BlackRightHeadLine;
       
       
        //����б��
        if(searchline <= CameraHight-5)
        {
          slope = 1.0 * (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline+4].x) / 
                        (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline+4].y);
        }
        else
        {
          slope = 0;
        }
        //����ƫ����
        offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
        //�����ұ߽�
        rightborder = (int32)(BlackUdisRightLocation[searchline].x + (row - BlackUdisRightLocation[searchline].y) * slope); 
        //����ƫ��
        bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //�ǵü�����
      }
    }
  }
  //ֻ���������Ч
  else if(BlackLeftDone == 1)
  {
    //����ͷ��������
    if(BlackUdisLeftLocation[BlackLeftHeadLine].y <= row)
    {
      //����������������֮��
      for(searchline = BlackLeftHeadLine; searchline <= CameraHight - 1; searchline++)
      {
        if(BlackUdisLeftLocation[searchline].y >= row)
        {
          break;
        }
      }
      
      //��߽���ȡ
      if(searchline == BlackLeftHeadLine)
      {
        leftborder = BlackUdisLeftLocation[searchline].x;
      }
      else
      {     
        //��ֵ������л�������������ߵ���
        leftborder = (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline-1].x) * (row - BlackUdisLeftLocation[searchline-1].y)
                   / (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline-1].y) + BlackUdisLeftLocation[searchline-1].x;
      }
      
      //ƫ������ȡ��ͨ��б�ʹ���ƫ������
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
      //��Ȼ�ļ��㹫ʽ
      offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
      
      //ƫ����ȡ
      bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //�ǵü�����
    }
    //����ͷ����������������Զ��
    else
    {
        //ֱ��������ͷ��Ϊ����������
        searchline = BlackLeftHeadLine;
       
       
        
        //����б��
        if(searchline <= CameraHight-5)
        {
          slope = 1.0 * (BlackUdisLeftLocation[searchline].x - BlackUdisLeftLocation[searchline+4].x) / 
                        (BlackUdisLeftLocation[searchline].y - BlackUdisLeftLocation[searchline+4].y);
        }
        else
        {
          slope = 0;
        }
        //����ƫ����
        offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
        //������߽�
        leftborder = (int32)(BlackUdisLeftLocation[searchline].x + (row - BlackUdisLeftLocation[searchline].y) * slope); 
        //����ƫ��
        bias = CameraRealWidth / 2 - (int32)(leftborder + offset); //�ǵü�����
    }
  }
  else if(BlackRightDone == 1)
  {
    //����ͷ��������
    if(BlackUdisRightLocation[BlackRightHeadLine].y <= row)
    {
      //����������������֮��
      for(searchline = BlackRightHeadLine; searchline <= CameraHight - 1; searchline++)
      {
        if(BlackUdisRightLocation[searchline].y >= row)
        {
          break;
        }
      }
      
      //�ұ߽���ȡ
      if(searchline == BlackRightHeadLine)
      {
        rightborder = BlackUdisRightLocation[searchline].x;
      }
      else
      {
        //��ֵ������л�������������ߵ���
        rightborder = (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline-1].x) * (row - BlackUdisRightLocation[searchline-1].y)
                    / (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline-1].y) + BlackUdisRightLocation[searchline-1].x;
      }
      
      //ƫ������ȡ��ͨ��б�ʹ���ƫ������
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
      //��Ȼ�ļ��㹫ʽ
      offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
      
      //ƫ����ȡ
      bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //�ǵü�����
    }
    //����ͷ����������������Զ
    else
    {
        //ֱ��������ͷ��Ϊ����������
        searchline = BlackRightHeadLine;
        
       
        //����б��
        if(searchline <= CameraHight-5)
        {
          slope = 1.0 * (BlackUdisRightLocation[searchline].x - BlackUdisRightLocation[searchline+4].x) / 
                        (BlackUdisRightLocation[searchline].y - BlackUdisRightLocation[searchline+4].y);
        }
        else
        {
          slope = 0;
        }
        //����ƫ����
        offset = 1.0 * sqrt(slope * slope + 1) * RoadWidth / 2;
        //�����ұ߽�
        rightborder = (int32)(BlackUdisRightLocation[searchline].x + (row - BlackUdisRightLocation[searchline].y) * slope); 
        //����ƫ��
        bias = CameraRealWidth / 2 - (int32)(rightborder - offset); //�ǵü�����
    }
  }
  //�����ϲ����ߵ�����
  else 
  {    
  }
  
  return bias;
}

//------------------------------------------------------------------------------
//��������SpeedRealTimeGet
//��  �ܣ�ʵʱ�ٶȻ�ȡ��ȷ���ٶȵȼ�
//��  ����
//��  �أ�
//˵  ���������������㵽ʵ���ٶȣ�����1000��.speed_fuΪ������
//------------------------------------------------------------------------------
uint8 SpeedRealTimeGet(void)
{
  int32 speed;//���������ٶȣ������ٶȵ�ƽ��ֵ
  //������һ�ε�������
  SpeedLastLeft = SpeedNowLeft;          
  SpeedLastRight = SpeedNowRight;  
  //�������ҵ��ʵʱ���������ҽ������˲�������
  QuadLeftCount=(QuadLeftCount*3+QuadLastLeftCount*7)/10;
  QuadRightCount=(QuadRightCount*3+QuadLastRightCount*7)/10;
  
  QuadLastLeftCount=QuadLeftCount;
  QuadLastRightCount=QuadRightCount;
  
  SpeedNowLeft = QuadLeftCount*200*100/(3250*3);//������ת��Ϊʵ���ٶȣ�������100����1m��Ӧ5260�����壬500/3��Ӧ6����
  SpeedNowRight = QuadRightCount*200*100/(3250*3);//������ת��Ϊʵ���ٶȣ�������100����1m��Ӧ5260�����壬500/3��Ӧ6����
  
  speed=(SpeedNowLeft)*10;//ƽ���ٶ�

  //speed=2100;//�ٶȸ��ɶ�ֵ��������
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
//��������DeviationFuse
//��  �ܣ�����ƫ����ں�
//��  ����
//��  �أ�
//Ӱ  �죺
//˵  ���� 
//      
//             
//======================================================================
uint8 DeviationFuse(void)
{    
  //uint8 i;
 //int32 DeviPredict;
  
  //����ƫ���ں�Ԥ����
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
     line_far_index=15;    //���к�С������Զ����20
    }
  else 
    {
     line_far_index=15+(temp-15)/10; 
    }
  if(line_far_index>18) line_far_index=18;

  
  //��ǰ�ͺ��ˣ��������״�
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
    
    
  //��������̫����Ϊ�Ǵ����
  
  if(DeviFuse>DeviPre+100)      //������100
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
//��������MtrGet
//��  �ܣ������ȼ��㺯��
//��  ����
//��  �أ�
//Ӱ  �죺
//˵  ����������У���39��ƫ������ݽ���ƫ��ȷ����ͬ�е�Ȩ��
//      
//             
//======================================================================
uint8 MtrGet(void)
{
   uint8 i;
      //ƫ�������ȼ���,������
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

        DeviFuse_dot=DeviFuse-DeviPre;//��ȡƫ��仯��
        
      //����DeviFuse_dot��������
   
        for(i=0;i<9;i++)//����������
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
