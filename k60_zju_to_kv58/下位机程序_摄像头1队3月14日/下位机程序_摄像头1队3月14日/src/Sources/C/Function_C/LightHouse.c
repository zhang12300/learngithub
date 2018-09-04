/******************************************************************************/
/*******************************************************************************
  �ļ��������������ļ�LightHouse.c
  ��  �ܣ���������
  ��  �ڣ�2015.05.11
  ��  �ߣ�HJZ
  ��  ע��
*******************************************************************************/
/******************************************************************************/

#include "LightHouse.h"
uint8 LightHouseStateR0 = 0;    //��������ģ��0��״̬
uint8 LightHouseStateR1 = 0;    //��������ģ��1��״̬
uint8 LightHouseOn2OffFlag = 0;  //�����������ı�־����0��x�仯����ʼ��Ϊ0.
uint8 LightHouseOff2OnFlag = 0;  //�����������ı�־����0��x�仯����ʼ��Ϊ0.
uint8 LightHouseWaitStopFlag = 0;

  
uint8 LightHouseWaitStartGapCount;  //�����������ֵ
uint8 LightHouseWaitStopGapCount;   //ͣ���������ֵ
uint16 LightHouseWaitStopDelayCount;  //ͣ����ʱ�жϼ���ֵ
uint8 LightHouseWaitStopDelayFlag;  //ͣ����ʱ�жϱ�־λ
uint8 LightHouseWaitStopLockFlag;   //ͣ��ȷ�������־λ

uint16 LightHouseWaitStartMaxTime = 50;         //��0.1sΪ��λ��50����5�롣��ô����󣬲�����û�м�⵽������ֱ�ӷ�����
uint16 LightHouseWaitStopDelayCountLimit = 70;  //ͣ����ʱ�ж���ֵ������ô���16ms�ſ�ʼͣ���ж�
uint16 LightHouseWaitStopGapCountLimit = 10;   //ͣ�����������ֵ��ÿ����ô���16ms�͸���һ�ε����ɼ�ֵ��һ�㲻Ҫ����

uint16 LightHouseWaitStopOnCount = 0;         //ͣ��ʱ�ģ�����������
uint16 LightHouseWaitStopOnCountLimit = 2;    //ͣ��ʱ����������������ֵ����ͣ����������йأ������ȱ������0.016*LightHouseWaitStopGapCountLimit*LightHouseWaitStopOnCountLimit�롣����Ҫ̫��
uint16 LightHouseNoStopFlag = 0;              //������ͣ����־��1��������ģʽ�������ݵ���ͣ����ֱ�ӳ��ȥ��0�ر�����ģʽ�����ݵ���ͣ����


//�������������ļ�⣬��⵽�����򷵻�1�����򷵻�0.
uint8 LightHouseOn2Off(void)
{
  if(LightHouseStateR0 == 0) //0��ʾ��
  {
    //��ʼ״̬��0��ȷ�϶��������
    if(LightHouseOn2OffFlag == 0)
    {
      LightHouseOn2OffFlag = 1;
    }
    //ȷ��һֱ�������򱣳����״̬��
    else if(LightHouseOn2OffFlag == 1)
    {
      LightHouseOn2OffFlag = 1;
    }
    //������״̬ȷ�ϵ������򷵻س�ʼ״̬��
    else
    {
      LightHouseOn2OffFlag = 0;
    }
  }
  else   //1��ʾ��
  {
    if(LightHouseOn2OffFlag == 1)
    {
      LightHouseOn2OffFlag = 2;
    }
    else if(LightHouseOn2OffFlag == 2)
    {
      LightHouseOn2OffFlag = 0;
      return 1;
    }
    else
    {
      LightHouseOn2OffFlag = 0;
    }
  }
  
  return 0;
  
}

//�����İ������ļ��,��⵽�����򷵻�1�����򷵻�0.
uint8 LightHouseOff2On(void)
{
  if(LightHouseStateR0 == 1) //1��ʾ��
  {
    //��ʼ״̬��0��ȷ�϶���ǰ���
    if(LightHouseOff2OnFlag == 0)
    {
      LightHouseOff2OnFlag = 1;
    }
    //ȷ��һֱ�ǰ����򱣳����״̬��
    else if(LightHouseOff2OnFlag == 1)
    {
      LightHouseOff2OnFlag = 1;
    }
    //������״̬ȷ�ϵ������򷵻س�ʼ״̬��
    else
    {
      LightHouseOff2OnFlag = 0;
    }
  }
  else   //0��ʾ��
  {
    if(LightHouseOff2OnFlag == 1)
    {
      LightHouseOff2OnFlag = 2;
    }
    else if(LightHouseOff2OnFlag == 2)
    {
      LightHouseOff2OnFlag = 0;
      return 1;
    }
    else
    {
      LightHouseOff2OnFlag = 0;
    }
  }
  
  return 0;
}



//======================================================================
//��������LightHouseWaitStart
//��  �ܣ����������ȴ�����
//��  ����
//��  �أ�
//Ӱ  �죺1�ȴ� 0����
//˵  ����1. ��⵽�������������أ��򷢳���
//        2. ע��������صļ����Ҫ�༸���㣬��ֹС���š�
//             
//======================================================================
uint8 LightHouseWaitStart(void)
{
  //�������ֵ��1.
  LightHouseWaitStartGapCount++;
  //ʵ�ֶ�θ���һ��ֵ���ﵽ�˲�Ч�����������˲�����СһЩ����Լһ��ʱ�䡣
  if(LightHouseWaitStartGapCount > LightHouseWaitStartGapCountLimit)
  {
    //�����źŸ���
    LightHouseStateUpdate();
    //��⵽������������
    if(LightHouseOn2Off() == 1)
    {
      return 0;
    }
    else
    {
      return 1;
    }
  }
  else
  {
  }
  
  return 1;
}



//======================================================================
//��������LightHouseWaitStop
//��  �ܣ����������ȴ�����
//��  ����
//��  �أ�
//Ӱ  �죺1�ȴ� 0����
//˵  ����
//         
//             
//======================================================================
uint8 LightHouseWaitStop(void)
{
  //������ͣ����־����Զ��ͣ����
  if(LightHouseNoStopFlag == 1)
  {
    return 1;
  }
  else
  {
  } 
  
  
  //ȷ��ͣ���󣬾�һֱ����ס��
  if(LightHouseWaitStopLockFlag == 1)
  {
    return 0;
  }
  else
  {
  }
  
  //ͣ��Ҫ��ʱ�жϣ�����һ������ͣ����
  if(LightHouseWaitStopDelayFlag == 0)
  {
    LightHouseWaitStopDelayCount++;
    //��ʱһ��ʱ�䣬�������þ�һЩ��
    if(LightHouseWaitStopDelayCount > LightHouseWaitStopDelayCountLimit * 63)
    {
      LightHouseWaitStopDelayFlag = 1;
    }
    else
    {
    }
  }
  else
  {
    //�������ֵ��1.
    LightHouseWaitStopGapCount++;
    //ʵ�ֶ�θ���һ��ֵ���ﵽ�˲�Ч����ͣ�����˲����Զ�һЩ����Ϊ�ӹսǹ����п��ܻ����С�
    if(LightHouseWaitStopGapCount > LightHouseWaitStopGapCountLimit)
    {
      //�����źŸ���
      LightHouseStateUpdate();
      //1. �ȼ�⵽���������䣬�ټ�⵽����������
      if(LightHouseWaitStopFlag == 0)
      {
        //�ȼ�⵽����������
        if(LightHouseOff2On() == 1)
        {
          //��־λ�仯
          LightHouseWaitStopFlag = 1;
          //�������������㡣
          LightHouseWaitStopOnCount = 0;
        }
        else
        {
        }    
      }
      //2. �����뱣�ֹ��� 
      else if(LightHouseWaitStopFlag == 1)
      {
        //���������������1
        if(LightHouseStateR0 == 0)
        {
          LightHouseWaitStopOnCount++;
          //��������������ֵ�����־λ�仯��ͬʱ���㡣
          if(LightHouseWaitStopOnCount >= LightHouseWaitStopOnCountLimit)
          {
            //��־ǰ��
            LightHouseWaitStopFlag = 2;
            LightHouseWaitStopOnCount = 0;
          }
          else
          {
          }
        }
        //һ����;�б䰵����ص����ǰ��
        else
        {
          //��־����
          LightHouseWaitStopFlag = 0;
        }
      }
      //3. �ټ�������������䡣
      else if(LightHouseWaitStopFlag == 2)
      {
        if(LightHouseOn2Off() == 1)
        {
          LightHouseWaitStopFlag = 3;
          return 0;
        }
        else
        {
        }
      }
      else if(LightHouseWaitStopFlag == 3)
      {
        //���μ����ɹ��������ټ���ˡ�
        LightHouseWaitStopLockFlag = 1;
        return 0;    
      }
      else
      {
      }
    }
    else
    {
    }
  }
  
  return 1;
}

//======================================================================
//��������LightHouseInit
//��  �ܣ�������ʼ��
//��  ����
//��  �أ�
//Ӱ  �죺
//˵  ����
//      
//             
//======================================================================
uint8 LightHouseInit(void)
{
  //LIGHTR0  ��������ģ��1 ����ΪGPIO����
  gpio_init(PORTE, 10, 0, 1);
  //LIGHTR1 ��������ģ��2  ����ΪGPIO����
  gpio_init(PORTE, 11, 0, 1);
  
  //�������ֵ��ʼ����
  LightHouseWaitStartGapCount = 0;
  LightHouseWaitStopGapCount = 0;
  //ͣ����ʱ�жϼ���ֵ��ʼ����
  LightHouseWaitStopDelayCount = 0;
  //ͣ����ʱ�жϱ�־λ��ʼ����
  LightHouseWaitStopDelayFlag = 0;
  //ͣ��ȷ�������־λ
  LightHouseWaitStopLockFlag = 0;
  
  return 1;
}



//======================================================================
//��������LightHouseStateUpdate
//��  �ܣ���������ģ���״̬����
//��  ����
//��  �أ�
//Ӱ  �죺
//˵  ����
//      
//             
//======================================================================
uint8 LightHouseStateUpdate(void)
{
  //��������ģ��0��״̬���� E10
  if(GPIO_PDIR_REG(PTE_BASE_PTR) & (1 << 10))
  {
    LightHouseStateR0 = 0;
  }
  else
  {
    LightHouseStateR0 = 1;
  }
  
//  //��������ģ��1��״̬���� E11
//  if(GPIO_PDIR_REG(PTE_BASE_PTR) & (1 << 11))
//  {
//    LightHouseStateR1 = 0;
//  }
//  else
//  {
//    LightHouseStateR1 = 1;
//  }
  
  
  return 1;
}

