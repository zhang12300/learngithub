/******************************************************************************/
/*******************************************************************************
  �ļ����������ļ�Debug.c
  ��  �ܣ�OLED��ʾ��FLASH������д��
  ��  �ڣ�2015.03.13
  ��  �ߣ�HJZ
  ��  ע��
*******************************************************************************/
/******************************************************************************/

#include "Debug.h"





//���뿪�ء�
//���뿪��ȷ�ϼ���,��ʼ��Ϊ0.
uint8 DebugSwitchConfirmCount[SwitchNum] = 
{
  0, 0, 0, 0  
};

//���뿪�ر�־��1ĳ������0��һ������1��16ms�����ڼ��ɱ�ȷ�ϡ�
uint8 DebugSwitchFlag[SwitchNum] = 
{
  0, 0, 0, 0
};


//������
//����ȷ�ϼ���,��ʼ��Ϊ0��
uint8 DebugButtonConfirmCount[ButtonNum] = 
{
  0, 0, 0, 0, 0, 0  
};
//������־��1��ʾ����DebugButtonConfirmNum��16ms�����ڱ����£�0��ʾû�С�
uint8 DebugButtonFlag[ButtonNum] = 
{
  0, 0, 0, 0, 0, 0
};

/*
//��Ҫ�޸ĵ�14��ֵ��
uint16 DebugServoPIDPMat00 = 167;
uint16 DebugServoPIDPMat01 = 195;
uint16 DebugServoPIDPMat02 = 214;
uint16 DebugServoPIDPMat03 = 225;
uint16 DebugServoPIDPMat04 = 231;
uint16 DebugServoPIDPMat05 = 234;
uint16 DebugServoPIDPMat06 = 255;
uint16 DebugServoPIDPMat07 = 235;
uint16 DebugServoPIDPMat08 = 230;
uint16 DebugServoPIDPMat09 = 217;
//3���ؼ�ֵ�����½�
uint8 DebugWMin10 = 160;
uint8 DebugWMax11 = 190;
uint8 DebugBMin12 = 85;
uint8 DebugBMax13 = 140;
uint8 DebugWBMin = 70;
uint8 DebugWBMax = 100;
*/

//��Ҫ�޸ĵ�60��ֵ��ÿҳ15��������Ҫ����ֵ����ʼ��ʱ���FLASH�ж�ȡ������
uint16 DebugModifyNum[60];

uint8 DebugOLEDUpdateCount = 0;       //OLED��ˢ��Ƶ�ʿ��ƣ�DebugOLEDUpdateCountNum��16msˢ��һ�Ρ�

uint8 DebugScreenChosen = DebugScreenChosenDisplay;  //����ѡ���־������ʾ/���Ρ�
uint8 DebugDisplayPage = 0;                          //��ʾ���棬ҳ�롣0~DebugDisplayPageNum-1
uint8 DebugModifyPage = 0;                           //���ν��棬ҳ�롣0,1,2.3
uint8 DebugModifyCursor = 0;                         //���ν��棬��ꡣ0~14.
uint8 DebugModifyCursorPre = 0;                      //���ν��棬��һ�εĹ��ֵ��0~14.
uint8 DebugModifyFlag = 0;                           //���ν��棬�޸ı�־��0��ʾ��ǰΪ������ģʽ��1��ʾ��ǰΪ�Ӽ�ֵģʽ��

//��ʱ��
uint16 TimeRealRun = 100;                         //��ʱ��ʱ��ʱ�����ޡ���0.1sΪ��λ��
uint8 TimeRealRunFlag = 0;                  //��ʱ�ܱ�־��0δ���꣬1�����ꡣ

//Debug�õ����ŵĳ�ʼ����
uint8 DebugPortInit(void)
{
  //4�����뿪��IO�ڳ�ʼ��
  gpio_init(PORTE,6,0,1);                               
  gpio_init(PORTE,7,0,1);
  gpio_init(PORTE,8,0,1);
  gpio_init(PORTE,9,0,1);
  
  //6�������ĳ�ʼ��
  gpio_init(PORTE,0,0,1);  //PTE0,����0,��ʼֵ��1��up�ϡ�
  gpio_init(PORTE,1,0,1);  //PTE1,����1,��ʼֵ��1��down�¡�
  gpio_init(PORTE,2,0,1);  //PTE2,����2,��ʼֵ��1��okȷ�ϡ�
  gpio_init(PORTE,3,0,1);  //PTE3,����3,��ʼֵ��1��escȡ����
  gpio_init(PORTE,4,0,1);  //PTE4,����4,��ʼֵ��1
  gpio_init(PORTE,5,0,1);  //PTE5,����5,��ʼֵ��1
  
  return 1;
}


//Debugר����ʱ������
void DebugDelay(int ms)
{
   int ii,jj;
   if (ms<1) ms=1;
   for(ii=0;ii<ms;ii++)     
     for(jj=0;jj<5341;jj++);     
}


//Debug���뿪��ɨ�躯����
uint8 DebugSwitchScan(void)
{
  //���뿪��0. 
  if(!(GPIOE_PDIR&0x0001))
  {
    if(!(GPIOE_PDIR&0x0001))
    {    
      DebugSwitchFlag[0] = 1;
    }
    else
    {
      DebugSwitchFlag[0] = 0;
    }
  }
  else
  {
    DebugSwitchFlag[0] = 0;
  }
  
  //���뿪��1. 
  if(!(GPIOE_PDIR&0x0002))
  {
    if(!(GPIOE_PDIR&0x0002))
    {
      DebugSwitchFlag[1] = 1;
    }
    else
    {
      DebugSwitchFlag[1] = 0;
    }
  }
  else
  {
    DebugSwitchFlag[1] = 0;
  }
  
  //���뿪��2.
  if(!(GPIOE_PDIR&0x0004))
  {
    if(!(GPIOE_PDIR&0x0004))
    {
      DebugSwitchFlag[2] = 1;
    }
    else
    {
      DebugSwitchFlag[2] = 0;
    }  
  }
  else
  {
    DebugSwitchFlag[2] = 0;
  }  
  
  //���뿪��3. 
  if(!(GPIOE_PDIR&0x0008))
  {
    if(!(GPIOE_PDIR&0x0008))
    {
      DebugSwitchFlag[3] = 1;
    }
    else
    {
      DebugSwitchFlag[3] = 0;
    }
  }
  else
  {
    DebugSwitchFlag[3] = 0;
  }    
    
  //���뿪�ز����ڼ��ɲ��ɹ���ɨ��һ����±�־λ���ɡ�
  return 1;
}

//Debug����ɨ�躯����
uint8 DebugButtonScan(void)
{    
  
  //����0.PTE0.
  if(!(GPIOE_PDIR&0x01))
  {
    //ȷ�ϴ�����1.
    DebugButtonConfirmCount[0]++;
    //�������16ms������ȷ�ϣ���ȷ�ϡ�
    if(DebugButtonConfirmCount[0] > DebugButtonConfirmNum)
    {
      //ȷ�ϱ�־��λ��
      DebugButtonFlag[0] = 1;    
      //ȷ�ϴ�����0��
      DebugButtonConfirmCount[0] = 0;      
      //һ��ֻ����һ����������ȷ���ˣ����ü�����İ�����ֱ�ӷ�����ȷ��
      return 1;
    }
    //��û������������Ϊû�а��¡�����������İ�����
    else
    {
      DebugButtonFlag[0] = 0;
    }
  }
  else
  {
    //ȷ�ϴ�����0��
    DebugButtonConfirmCount[0] = 0;
    //ȷ�ϱ�־��0.
    DebugButtonFlag[0] = 0;
    //����������İ�����
  }
  
  //����1.PTE1.
  if(!(GPIOE_PDIR&0x02))
  {
    //ȷ�ϴ�����1.
    DebugButtonConfirmCount[1]++;
    //�������16ms������ȷ�ϣ���ȷ�ϡ�
    if(DebugButtonConfirmCount[1] > DebugButtonConfirmNum)
    {
      //ȷ�ϱ�־��λ��
      DebugButtonFlag[1] = 1;     
      //ȷ�ϴ�����0��
      DebugButtonConfirmCount[1] = 0;     
      //һ��ֻ����һ����������ȷ���ˣ����ü�����İ�����ֱ�ӷ�����ȷ��
      return 1;
    }
    //��û������������Ϊû�а��¡�����������İ�����
    else
    {
      DebugButtonFlag[1] = 0;
    }
  }
  else
  {
    //ȷ�ϴ�����0��
    DebugButtonConfirmCount[1] = 0;
    //ȷ�ϱ�־��0.
    DebugButtonFlag[1] = 0;
    //����������İ�����
  }
  
  //����2.PTE2.
  if(!(GPIOE_PDIR&0x04))
  {
    //ȷ�ϴ�����1.
    DebugButtonConfirmCount[2]++;
    //�������16ms������ȷ�ϣ���ȷ�ϡ�
    if(DebugButtonConfirmCount[2] > DebugButtonConfirmNum)
    {
      //ȷ�ϱ�־��λ��
      DebugButtonFlag[2] = 1;     
      //ȷ�ϴ�����0��
      DebugButtonConfirmCount[2] = 0;           
      //һ��ֻ����һ����������ȷ���ˣ����ü�����İ�����ֱ�ӷ�����ȷ��
      return 1;
    }
    //��û������������Ϊû�а��¡�����������İ�����
    else
    {
      DebugButtonFlag[2] = 0;
    }
  }
  else
  {
    //ȷ�ϴ�����0��
    DebugButtonConfirmCount[2] = 0;
    //ȷ�ϱ�־��0.
    DebugButtonFlag[2] = 0;
    //����������İ�����
  }  
  
  //����3.PTE3.
  if(!(GPIOE_PDIR&0x08))
  {
    //ȷ�ϴ�����1.
    DebugButtonConfirmCount[3]++;
    //�������16ms������ȷ�ϣ���ȷ�ϡ�
    if(DebugButtonConfirmCount[3] > DebugButtonConfirmNum)
    {
      //ȷ�ϱ�־��λ��
      DebugButtonFlag[3] = 1;     
      //ȷ�ϴ�����0��
      DebugButtonConfirmCount[3] = 0;           
      //һ��ֻ����һ����������ȷ���ˣ����ü�����İ�����ֱ�ӷ�����ȷ��
      return 1;
    }
    //��û������������Ϊû�а��¡�����������İ�����
    else
    {
      DebugButtonFlag[3] = 0;
    }
  }
  else
  {
    //ȷ�ϴ�����0��
    DebugButtonConfirmCount[3] = 0;
    //ȷ�ϱ�־��0.
    DebugButtonFlag[3] = 0;
    //����������İ�����
  }
  
  
  //����4.PTE4.
  if(!(GPIOE_PDIR&0x10))
  {
    //ȷ�ϴ�����1.
    DebugButtonConfirmCount[4]++;
    //�������16ms������ȷ�ϣ���ȷ�ϡ�
    if(DebugButtonConfirmCount[4] > DebugButtonConfirmNum)
    {
      //ȷ�ϱ�־��λ��
      DebugButtonFlag[4] = 1;  
      //ȷ�ϴ�����0��
      DebugButtonConfirmCount[4] = 0;           
      //һ��ֻ����һ����������ȷ���ˣ����ü�����İ�����ֱ�ӷ�����ȷ��
      return 1;
    }
    //��û������������Ϊû�а��¡�����������İ�����
    else
    {
      DebugButtonFlag[4] = 0;
    }
  }
  else
  {
    //ȷ�ϴ�����0��
    DebugButtonConfirmCount[4] = 0;
    //ȷ�ϱ�־��0.
    DebugButtonFlag[4] = 0;
    //����������İ�����
  }
  
  
  //����5.PTE5.
  if(!(GPIOE_PDIR&0x20))
  {
    //ȷ�ϴ�����1.
    DebugButtonConfirmCount[5]++;
    //�������16ms������ȷ�ϣ���ȷ�ϡ�
    if(DebugButtonConfirmCount[5] > DebugButtonConfirmNum)
    {
      //ȷ�ϱ�־��λ��
      DebugButtonFlag[5] = 1;     
      //ȷ�ϴ�����0��
      DebugButtonConfirmCount[5] = 0;           
      //һ��ֻ����һ����������ȷ���ˣ����ü�����İ�����ֱ�ӷ�����ȷ��
      return 1;
    }
    //��û������������Ϊû�а��¡�����������İ�����
    else
    {
      DebugButtonFlag[5] = 0;
    }
  }
  else
  {
    //ȷ�ϴ�����0��
    DebugButtonConfirmCount[5] = 0;
    //ȷ�ϱ�־��0.
    DebugButtonFlag[5] = 0;
    //����������İ�����
  }
    
  
  return 0;
}

//FLASHֵ�Ķ�ȡ����
//tempsectorindex������ţ�tempsectorsize������С��num�ڼ�������
uint32 FlashReadNow(uint32 tempsectorindex, uint32 tempsectorsize, uint32 num)
{
  uint32 temp;
  
  
  temp = (*(byte *)((uint32)(tempsectorindex * tempsectorsize + num * 4))) 
       + (*(byte *)((uint32)(tempsectorindex * tempsectorsize + num * 4 + 1))) * 256 
       + (*(byte *)((uint32)(tempsectorindex * tempsectorsize + num * 4 + 2))) * 65536 
       + (*(byte *)((uint32)(tempsectorindex * tempsectorsize + num * 4 + 3))) * 16777216;
  
  return temp;
}


//FLASHֵ��д�뺯��
//tempsectorindex������ţ�num�ڼ������ݣ�tempelementsizeԪ�صĴ�С��һ����4����pointeruint8����ָ�루������uint8 *�͵ģ���
uint8 FlashWriteNow(uint32 tempsectorindex, uint32 num, uint32 tempelementsize, uint8 *pointeruint8)
{
  
  FlashWrite(tempsectorindex, num * 4, tempelementsize, pointeruint8);
  
  return 1;
}

//FLASHģ��ֵ��ʼ����ȡ
uint8 FlashInitRead(void)
{
  uint32 temp;
  uint8 i, j, k;
  
  for(i = 0; i < 60; i++)
  {
    temp = FlashReadNow(FlashSectorIndex, FlashSectorSize, i);
    DebugModifyNum[i] = temp;   //����Ҫǿ������ת�������Զ�ת���ġ�
  }
  
  
  //����ʵ��ֵ����ֱ�Ӹ���ʵ�ʱ�����ͨ���м��������Ϊ�˷����޸ġ�
  //LightHouseWaitStartMaxTime = DebugModifyNum[0];    //�������ʱ��
  //SpeedStrategyChosen = DebugModifyNum[1];          //�ٶȵ�λ
  //MotorTakeOffQuadCountLimit = DebugModifyNum[2];   //��ɿ���
  //AngleZoneConfirmMatLimit = DebugModifyNum[3];  //ֱ�Ǻڿ飬��־�洢������ֱ�Ǻڿ�ĸ������ڸ�ֵʱ��������Ϊֱ�Ǻڿ顣
  //AngleConfirmMatLimit = DebugModifyNum[4];      //ֱ�����־�洢������ֱ�ǵĸ������ڸ�ֵʱ��������Ϊֱ�ǡ�
  //BrickConfirmMatLimit = DebugModifyNum[5];      //�ϰ���־�洢�������ϰ��ĸ������ڸ�ֵʱ��������Ϊ�ϰ���
  //BrickConfirmFinalColCom = DebugModifyNum[6];   //�ϰ����ʱ��������������15Ϊ�㣬����Ҽӡ���
  //LightHouseWaitStopDelayCountLimit = DebugModifyNum[7]; //ͣ����ʱ�ж���ֵ������ô���16ms�ſ�ʼͣ���ж�
  //LightHouseWaitStopGapCountLimit = DebugModifyNum[8];  //ͣ�����������ֵ��ÿ����ô���16ms�͸���һ�ε����ɼ�ֵ

  

  //������,��4x8=32����д����DebugModifyNum[46]
  k = 15;
  for(i = 0; i <= 7; i++)
  {
    for(j = 0; j <= 3; j++)
    {
      //ControlRow_Weight[j][i] = DebugModifyNum[k];
      k++;
    }
  }
  
  //��ʱ��ʱ������
  //TimeRealRun = DebugModifyNum[47];
  //���P
  //SpeedPIDPVal = DebugModifyNum[48];
  //���D
  //SpeedPIDDVal = DebugModifyNum[49];
  //�µ��ĸ����ٶ�
  //SpeedTargetValGryoResult = DebugModifyNum[50];
  //ֱ����ĸ����ٶ�
  //SpeedTargetValAngle = DebugModifyNum[51];
  //��ֱ���ĸ����ٶ�
  //SpeedTargetValStraight = DebugModifyNum[52];
  //�µ���ֹ���������жϵ���������ֵ
  //GyroResultForbidBackCountNum = DebugModifyNum[53];
  //����ֱ��������ֵ
  //PathRealStraightCountLimit = DebugModifyNum[54];
//  //����ͣ��������ʱ��
//  LightHouseWaitStopOnCountLimit = DebugModifyNum[55];
  //ͣ��������ֵ��
  //StopFlagMaxCountNum = DebugModifyNum[55];
  //��ͣ����־
  //LightHouseNoStopFlag = DebugModifyNum[56];
  //ֱ������ͷ����ֵ��
  //AngleHeadLineNum = DebugModifyNum[57];
  //�����ȴ�ͣ���ٶ�
  //SpeedTargetValWaitStop = DebugModifyNum[58];
  //�����ٶ�
  //SpeedTargetValGryoUp = DebugModifyNum[59];
  
  
 /*   
  DebugModifyNum[0] = 10;
  DebugModifyNum[1] = 33;
  DebugModifyNum[2] = 37;
  DebugModifyNum[3] = 40;
  DebugModifyNum[4] = 40;
  DebugModifyNum[5] = 40;
  DebugModifyNum[6] = 34;
  DebugModifyNum[7] = 29;
  DebugModifyNum[8] = 0;
  DebugModifyNum[9] = 120;
  DebugModifyNum[10] = 230;
  DebugModifyNum[11] = 150;
  DebugModifyNum[12] = 150;
  DebugModifyNum[13] = 150;
  DebugModifyNum[14] = 150;
  DebugModifyNum[15] = 150;
  DebugModifyNum[16] = 150;
  */
  
  speedOfCar = DebugModifyNum[0];               //У����ʱ����������Ǿ����ٶȵģ�������ûɶ����
  Steer_kp[1] = DebugModifyNum[1];              //�����p����
  Steer_kp[2] = DebugModifyNum[2];
  Steer_kp[3] = DebugModifyNum[3];
  Steer_kp[4] = DebugModifyNum[4];
  Steer_kp[5] = DebugModifyNum[5];
  Steer_kp[6] = DebugModifyNum[6];
  Steer_kp[7] = DebugModifyNum[7];
  Steer_kp[0] = DebugModifyNum[8];
  SpeedPIDPVal = DebugModifyNum[9];             //�����PI����
  SpeedPIDDVal = DebugModifyNum[10];
  SpeedTargetMat[0][5] = DebugModifyNum[11];    //�����ٶ�
  SpeedTargetMat[0][4] = DebugModifyNum[12];
  SpeedTargetMat[0][6] = DebugModifyNum[12];
  SpeedTargetMat[0][3] = DebugModifyNum[13];
  SpeedTargetMat[0][7] = DebugModifyNum[13];
  SpeedTargetMat[0][2] = DebugModifyNum[14];
  SpeedTargetMat[0][8] = DebugModifyNum[14];
  SpeedTargetMat[0][1] = DebugModifyNum[15];
  SpeedTargetMat[0][9] = DebugModifyNum[15];
  SpeedTargetMat[0][0] = DebugModifyNum[16];
  SpeedTargetMat[0][10] = DebugModifyNum[16];
  BrickConfirmMatLimit = DebugModifyNum[17];      //�ϰ���־�洢�������ϰ��ĸ������ڸ�ֵʱ��������Ϊ�ϰ���
  BrickConfirmFinalColCom = DebugModifyNum[18];   //�ϰ����ʱ��������������15Ϊ�㣬����Ҽӡ���
  LimitLeftWBMin = DebugModifyNum[19];          //ͼ��ڰ��ߵ���ֵ
  LimitRightWBMin = DebugModifyNum[19];
  LimitLeftWBMax = DebugModifyNum[20];
  LimitRightWBMax = DebugModifyNum[20];
  LimitLeftWMin = DebugModifyNum[21];
  LimitRightWMin = DebugModifyNum[21];
  LimitLeftWMax = DebugModifyNum[22];
  LimitRightWMax = DebugModifyNum[22]; 
  LimitLeftBMin = DebugModifyNum[23];
  LimitRightBMin = DebugModifyNum[23];
  LimitLeftBMax = DebugModifyNum[24];
  LimitRightBMax = DebugModifyNum[24];
  SpeedTargetValStraight = DebugModifyNum[25];      //��ֱ���ٶ�
  SpeedBrick = DebugModifyNum[26];                  //�ϰ��ٶ�
  SpeedTargetValGryoUp = DebugModifyNum[27];        //�����ٶ�
  SpeedTargetValGryoResult = DebugModifyNum[28];    //�����ٶ�
  SpeedXiaoZhiDao = DebugModifyNum[29];             //Сֱ���ٶ�
  limitStopLineBlackXiu = DebugModifyNum[52];       //��ͣ�����ж��йصĺ�ɫ��ֵ���趨
  ServoPIDDMat[0] = DebugModifyNum[53];             //���d����
  ServoPIDD2Mat[0] = DebugModifyNum[53];
  ServoPIDDMat[1] = DebugModifyNum[54];
  ServoPIDD2Mat[1] = DebugModifyNum[54];
  ServoPIDDMat[2] = DebugModifyNum[55];
  ServoPIDD2Mat[2] = DebugModifyNum[55];
  ServoPIDDMat[3] = DebugModifyNum[56];
  ServoPIDD2Mat[3] = DebugModifyNum[56];
  ServoPIDDMat[4] = DebugModifyNum[57];
  ServoPIDD2Mat[4] = DebugModifyNum[57];
  ServoPIDDMat[5] = DebugModifyNum[58];
  ServoPIDD2Mat[5] = DebugModifyNum[58];
  ServoPIDDMat[6] = DebugModifyNum[59];
  ServoPIDD2Mat[6] = DebugModifyNum[59];
  

  return 1;
}


//Debug��ʼ��
uint8 DebugInit(void)
{
  //OLED��ʼ�����������ʾ��Hello AE86��
  LCD_Init();
  //FLASH��ʼ��
  FlashInit();
  //FLASHģ��ֵ��ʼ����ȡ��
  //FlashInitRead();
  //Debug�õ����ŵĳ�ʼ����
  DebugPortInit();
  
  return 1;
}



//��ֵ���޸ģ�temp=0��ʾ��1����λ��temp=1��ʾ��1����λ
uint8 DebugModifyValue(uint8 temp)
{
  
  //temp=0��ʾ��1����λ
  if(temp == 0)
  {
    //��ǰ�ǵ�0ҳ��
    if(DebugModifyPage == 0)
    {
      //���ݹ��λ������ֵ��
      if(DebugModifyCursor == 0)
      {
        DebugModifyNum[0] --;
        speedOfCar = DebugModifyNum[0];
      }
      else if(DebugModifyCursor == 1)
      {
        DebugModifyNum[1] --;
        Steer_kp[1] = DebugModifyNum[1];
      }
      else if(DebugModifyCursor == 2)
      {
        DebugModifyNum[2] --;
        Steer_kp[2] = DebugModifyNum[2];
      }
      else if(DebugModifyCursor == 3)
      {
        DebugModifyNum[3]--;
        Steer_kp[3] = DebugModifyNum[3];
      }
      else if(DebugModifyCursor == 4)
      {
        DebugModifyNum[4]--;
        Steer_kp[4] = DebugModifyNum[4];
      }
      else if(DebugModifyCursor == 5)
      {
        DebugModifyNum[5]--;
        Steer_kp[5] = DebugModifyNum[5];
      }
      else if(DebugModifyCursor == 6)
      {
        DebugModifyNum[6]--;
        Steer_kp[6] = DebugModifyNum[6];
      }
      else if(DebugModifyCursor == 7)
      {
        DebugModifyNum[7]--;
        Steer_kp[7] = DebugModifyNum[7];
      }
      else if(DebugModifyCursor == 8)
      {
        DebugModifyNum[8]--;
        Steer_kp[0] = DebugModifyNum[8];
        //LightHouseWaitStopGapCountLimit = DebugModifyNum[8];
      }
      else if(DebugModifyCursor == 9)
      {
        DebugModifyNum[9]--;
        SpeedPIDPVal = DebugModifyNum[9];

        //LimitLeftWBMin = DebugModifyNum[9];
        //LimitRightWBMin = DebugModifyNum[9];
      }
      else if(DebugModifyCursor == 10)
      {
        DebugModifyNum[10]--;
        SpeedPIDDVal = DebugModifyNum[10];

        //LimitLeftWBMax = DebugModifyNum[10];
        //LimitRightWBMax = DebugModifyNum[10];
      }
      else if(DebugModifyCursor == 11)
      {
        DebugModifyNum[11]--;
        SpeedTargetMat[0][5] = DebugModifyNum[11];
        //LimitLeftWMin = DebugModifyNum[11];
        //LimitRightWMin = DebugModifyNum[11];
      }
      else if(DebugModifyCursor == 12)
      {
        DebugModifyNum[12]--;
        SpeedTargetMat[0][4] = DebugModifyNum[12];
        SpeedTargetMat[0][6] = DebugModifyNum[12];
        //LimitLeftWMax = DebugModifyNum[12];
        //LimitRightWMax = DebugModifyNum[12];
      }
      else if(DebugModifyCursor == 13)
      {
        DebugModifyNum[13]--;
        SpeedTargetMat[0][3] = DebugModifyNum[13];
        SpeedTargetMat[0][7] = DebugModifyNum[13];
        //LimitLeftBMin = DebugModifyNum[13];
        //LimitRightBMin = DebugModifyNum[13];
      }
      else if(DebugModifyCursor == 14)
      {
        DebugModifyNum[14]--;
        SpeedTargetMat[0][2] = DebugModifyNum[14];
        SpeedTargetMat[0][8] = DebugModifyNum[14];
        //LimitLeftBMax = DebugModifyNum[14];
        //LimitRightBMax = DebugModifyNum[14];
      }
      else
      {
      }
    }
    //��ǰ�ǵ�1ҳ��
    else if(DebugModifyPage == 1)
    {
      //���ݹ��λ������ֵ��
      if(DebugModifyCursor == 0)
      {
        DebugModifyNum[15]--;
        SpeedTargetMat[0][1] = DebugModifyNum[15];
        SpeedTargetMat[0][9] = DebugModifyNum[15];
        //ControlRow_Weight[0][0] = DebugModifyNum[15];
      }
      else if(DebugModifyCursor == 1)
      {
        DebugModifyNum[16]--;
        SpeedTargetMat[0][0] = DebugModifyNum[16];
        SpeedTargetMat[0][10] = DebugModifyNum[16];
        //ControlRow_Weight[1][0]  = DebugModifyNum[16];
      }
      else if(DebugModifyCursor == 2)
      { 
        DebugModifyNum[17]--;
        BrickConfirmMatLimit = DebugModifyNum[17];      //�ϰ���־�洢�������ϰ��ĸ������ڸ�ֵʱ��������Ϊ�ϰ���
        //ControlRow_Weight[2][0]  = DebugModifyNum[17];
      }
      else if(DebugModifyCursor == 3)
      {
        DebugModifyNum[18]--;
        BrickConfirmFinalColCom = DebugModifyNum[18];   //�ϰ����ʱ��������������15Ϊ�㣬����Ҽӡ���
        //ControlRow_Weight[3][0]  = DebugModifyNum[18];
      }
      else if(DebugModifyCursor == 4)
      {
        DebugModifyNum[19]--;
        LimitLeftWBMin = DebugModifyNum[19];
        LimitRightWBMin = DebugModifyNum[19];
        //ControlRow_Weight[0][1]  = DebugModifyNum[19];
      }
      else if(DebugModifyCursor == 5)
      {
        DebugModifyNum[20]--;
        LimitLeftWBMax = DebugModifyNum[20];
        LimitRightWBMax = DebugModifyNum[20];
        //ControlRow_Weight[1][1] = DebugModifyNum[20];
      }
      else if(DebugModifyCursor == 6)
      {
        DebugModifyNum[21]--;
        LimitLeftWMin = DebugModifyNum[21];
        LimitRightWMin = DebugModifyNum[21];
        //ControlRow_Weight[2][1] = DebugModifyNum[21];
      }
      else if(DebugModifyCursor == 7)
      {
        DebugModifyNum[22]--;
        LimitLeftWMax = DebugModifyNum[22];
        LimitRightWMax = DebugModifyNum[22]; 
        //ControlRow_Weight[3][1] = DebugModifyNum[22];
      }
      else if(DebugModifyCursor == 8)
      {
        DebugModifyNum[23]--;
        LimitLeftBMin = DebugModifyNum[23];
        LimitRightBMin = DebugModifyNum[23];
        //ControlRow_Weight[0][2] = DebugModifyNum[23];
      }
      else if(DebugModifyCursor == 9)
      {
        DebugModifyNum[24]--;
        LimitLeftBMax = DebugModifyNum[24];
        LimitRightBMax = DebugModifyNum[24];
        //ControlRow_Weight[1][2] = DebugModifyNum[24];
      }
      else if(DebugModifyCursor == 10)
      {
        DebugModifyNum[25]--;
        SpeedTargetValStraight = DebugModifyNum[25];
        //ControlRow_Weight[2][2] = DebugModifyNum[25];
      }
      else if(DebugModifyCursor == 11)
      {
        DebugModifyNum[26]--;
        SpeedBrick = DebugModifyNum[26];
        //ControlRow_Weight[3][2] = DebugModifyNum[26];
      }
      else if(DebugModifyCursor == 12)
      {
        DebugModifyNum[27]--;
        SpeedTargetValGryoUp = DebugModifyNum[27];
        //ControlRow_Weight[0][3] = DebugModifyNum[27];
      }
      else if(DebugModifyCursor == 13)
      {
        DebugModifyNum[28]--;
        SpeedTargetValGryoResult = DebugModifyNum[28];
        //ControlRow_Weight[1][3] = DebugModifyNum[28];
      }
      else if(DebugModifyCursor == 14)
      {
        DebugModifyNum[29]--;
        SpeedXiaoZhiDao = DebugModifyNum[29];
        //ControlRow_Weight[2][3] = DebugModifyNum[29];
      }
      else
      {
      }
    }
    //��ǰ�ǵ�2ҳ��
    else if(DebugModifyPage == 2)
    {
      //���ݹ��λ������ֵ��
      if(DebugModifyCursor == 0)
      {
        DebugModifyNum[30]--;
        //ControlRow_Weight[3][3] = DebugModifyNum[30];
      }
      else if(DebugModifyCursor == 1)
      {
        DebugModifyNum[31]--;
        //ControlRow_Weight[0][4]  = DebugModifyNum[31];
      }
      else if(DebugModifyCursor == 2)
      {
        DebugModifyNum[32]--;
        //ControlRow_Weight[1][4]  = DebugModifyNum[32];
      }
      else if(DebugModifyCursor == 3)
      {
        DebugModifyNum[33]--;
        //ControlRow_Weight[2][4]  = DebugModifyNum[33];
      }
      else if(DebugModifyCursor == 4)
      {
        DebugModifyNum[34]--;
        //ControlRow_Weight[3][4]  = DebugModifyNum[34];
      }
      else if(DebugModifyCursor == 5)
      {
        DebugModifyNum[35]--;
        //ControlRow_Weight[0][5] = DebugModifyNum[35];
      }
      else if(DebugModifyCursor == 6)
      {
        DebugModifyNum[36]--;
        //ControlRow_Weight[1][5] = DebugModifyNum[36];
      }
      else if(DebugModifyCursor == 7)
      {
        DebugModifyNum[37]--;
        //ControlRow_Weight[2][5] = DebugModifyNum[37];
      }
      else if(DebugModifyCursor == 8)
      {
        DebugModifyNum[38]--;
        //ControlRow_Weight[3][5] = DebugModifyNum[38];
      }
      else if(DebugModifyCursor == 9)
      {
        DebugModifyNum[39]--;
        //ControlRow_Weight[0][6] = DebugModifyNum[39];
      }
      else if(DebugModifyCursor == 10)
      {
        DebugModifyNum[40]--;
        //ControlRow_Weight[1][6] = DebugModifyNum[40];
      }
      else if(DebugModifyCursor == 11)
      {
        DebugModifyNum[41]--;
        //ControlRow_Weight[2][6] = DebugModifyNum[41];
      }
      else if(DebugModifyCursor == 12)
      {
        DebugModifyNum[42]--;
        //ControlRow_Weight[3][6] = DebugModifyNum[42];
      }
      else if(DebugModifyCursor == 13)
      {
        DebugModifyNum[43]--;
        //ControlRow_Weight[0][7] = DebugModifyNum[43];
      }
      else if(DebugModifyCursor == 14)
      {
        DebugModifyNum[44]--;
        //ControlRow_Weight[1][7] = DebugModifyNum[44];
      }
      else
      {
      }
    }
    //��ǰ�ǵ�3ҳ��
    else if(DebugModifyPage == 3)
    {
      //���ݹ��λ������ֵ��
      if(DebugModifyCursor == 0)
      {
        DebugModifyNum[45]--;
        //ControlRow_Weight[2][7] = DebugModifyNum[45];
      }
      else if(DebugModifyCursor == 1)
      {
        DebugModifyNum[46]--;
        //ControlRow_Weight[3][7]  = DebugModifyNum[46];
      }
      else if(DebugModifyCursor == 2)
      {
        DebugModifyNum[47] -= 10;;
        //TimeRealRun -= 10;
      }
      else if(DebugModifyCursor == 3)
      {
        DebugModifyNum[48] -= 1;
        //SpeedPIDPVal -= 1;
      }
      else if(DebugModifyCursor == 4)
      {
        DebugModifyNum[49] -= 1;
        //SpeedPIDDVal -= 1;
      }
      else if(DebugModifyCursor == 5)
      {
        DebugModifyNum[50]--;
        //SpeedTargetValGryoResult--;
      }
      else if(DebugModifyCursor == 6)
      {
        DebugModifyNum[51]--;
        //SpeedTargetValAngle--;
      }
      else if(DebugModifyCursor == 7)
      {
        DebugModifyNum[52]--;
        limitStopLineBlackXiu = DebugModifyNum[52];
        //SpeedTargetValStraight = DebugModifyNum[52];
      }
      else if(DebugModifyCursor == 8)
      {
        DebugModifyNum[53]--;
        ServoPIDDMat[0] = DebugModifyNum[53];
        ServoPIDD2Mat[0] = DebugModifyNum[53];
        //GyroResultForbidBackCountNum = DebugModifyNum[53];
      }
      else if(DebugModifyCursor == 9)
      {
        DebugModifyNum[54]--;
        ServoPIDDMat[1] = DebugModifyNum[54];
        ServoPIDD2Mat[1] = DebugModifyNum[54];
        //PathRealStraightCountLimit = DebugModifyNum[54];
      }
      else if(DebugModifyCursor == 10)
      {
        DebugModifyNum[55]--;
        ServoPIDDMat[2] = DebugModifyNum[55];
        ServoPIDD2Mat[2] = DebugModifyNum[55];
        //StopFlagMaxCountNum = DebugModifyNum[55];
      }
      else if(DebugModifyCursor == 11)
      {
        DebugModifyNum[56]--;
        ServoPIDDMat[3] = DebugModifyNum[56];
        ServoPIDD2Mat[3] = DebugModifyNum[56];
        //LightHouseNoStopFlag = DebugModifyNum[56];
      }
      else if(DebugModifyCursor == 12)
      {
        DebugModifyNum[57]--;
        ServoPIDDMat[4] = DebugModifyNum[57];
        ServoPIDD2Mat[4] = DebugModifyNum[57];
        //AngleHeadLineNum = DebugModifyNum[57];
      }
      else if(DebugModifyCursor == 13)
      {
        DebugModifyNum[58]--;
        ServoPIDDMat[5] = DebugModifyNum[58];
        ServoPIDD2Mat[5] = DebugModifyNum[58];
        //SpeedTargetValWaitStop = DebugModifyNum[58];
      }
      else if(DebugModifyCursor == 14)
      {
        DebugModifyNum[59]--;
        ServoPIDDMat[6] = DebugModifyNum[59];
        ServoPIDD2Mat[6] = DebugModifyNum[59];
        //SpeedTargetValGryoUp = DebugModifyNum[59];
      }
      else
      {
      }      
      
    }
    else
    {
    }
  }
  //temp=1��ʾ��1����λ
  else
  {
    //��ǰ�ǵ�0ҳ��
    if(DebugModifyPage == 0)
    {
      //���ݹ��λ������ֵ��
      if(DebugModifyCursor == 0)
      {
        DebugModifyNum[0] ++;
        speedOfCar = DebugModifyNum[0];
      }
      else if(DebugModifyCursor == 1)
      {
        DebugModifyNum[1]++;
        Steer_kp[1] = DebugModifyNum[1];
      }
      else if(DebugModifyCursor == 2)
      {
        DebugModifyNum[2] ++;
        Steer_kp[2] = DebugModifyNum[2];
      }
      else if(DebugModifyCursor == 3)
      {
        DebugModifyNum[3]++;
        Steer_kp[3] = DebugModifyNum[3];
      }
      else if(DebugModifyCursor == 4)
      {
        DebugModifyNum[4]++;
        Steer_kp[4] = DebugModifyNum[4];
      }
      else if(DebugModifyCursor == 5)
      {
        DebugModifyNum[5]++;
        Steer_kp[5] = DebugModifyNum[5];
      }
      else if(DebugModifyCursor == 6)
      {
        DebugModifyNum[6]++;
        Steer_kp[6] = DebugModifyNum[6];
      }
      else if(DebugModifyCursor == 7)
      {
        DebugModifyNum[7]++;
        Steer_kp[7] = DebugModifyNum[7];
      }
      else if(DebugModifyCursor == 8)
      {
        DebugModifyNum[8]++;
        Steer_kp[0] = DebugModifyNum[8];
        //LightHouseWaitStopGapCountLimit = DebugModifyNum[8];
      }
      else if(DebugModifyCursor == 9)
      {
        DebugModifyNum[9]++;
        SpeedPIDPVal = DebugModifyNum[9];
        //LimitLeftWBMin = DebugModifyNum[9];
        //LimitRightWBMin = DebugModifyNum[9];
      }
      else if(DebugModifyCursor == 10)
      {
        DebugModifyNum[10]++;
        SpeedPIDDVal = DebugModifyNum[10];
        //LimitLeftWBMax = DebugModifyNum[10];
        //LimitRightWBMax = DebugModifyNum[10];
      }
      else if(DebugModifyCursor == 11)
      {
        DebugModifyNum[11]++;
        SpeedTargetMat[0][5] = DebugModifyNum[11];
        //LimitLeftWMin = DebugModifyNum[11];
        //LimitRightWMin = DebugModifyNum[11];
      }
      else if(DebugModifyCursor == 12)
      {
        DebugModifyNum[12]++;
        SpeedTargetMat[0][4] = DebugModifyNum[12];
        SpeedTargetMat[0][6] = DebugModifyNum[12];
        //LimitLeftWMax = DebugModifyNum[12];
        //LimitRightWMax = DebugModifyNum[12];
      }
      else if(DebugModifyCursor == 13)
      {
        DebugModifyNum[13]++;
        SpeedTargetMat[0][3] = DebugModifyNum[13];
        SpeedTargetMat[0][7] = DebugModifyNum[13];
        //LimitLeftBMin = DebugModifyNum[13];
        //LimitRightBMin = DebugModifyNum[13];
      }
      else if(DebugModifyCursor == 14)
      {
        DebugModifyNum[14]++;
        SpeedTargetMat[0][2] = DebugModifyNum[14];
        SpeedTargetMat[0][8] = DebugModifyNum[14];
        //LimitLeftBMax = DebugModifyNum[14];
        //LimitRightBMax = DebugModifyNum[14];
      }
      else
      {
      }
    }
    //��ǰ�ǵ�1ҳ��
    else if(DebugModifyPage == 1)
    {
      //���ݹ��λ������ֵ��
      if(DebugModifyCursor == 0)
      {
        DebugModifyNum[15]++;
        SpeedTargetMat[0][1] = DebugModifyNum[15];
        SpeedTargetMat[0][9] = DebugModifyNum[15];
        //ControlRow_Weight[0][0] = DebugModifyNum[15];
      }
      else if(DebugModifyCursor == 1)
      {
        DebugModifyNum[16]++;
        SpeedTargetMat[0][0] = DebugModifyNum[16];
        SpeedTargetMat[0][10] = DebugModifyNum[16];
        //ControlRow_Weight[1][0]  = DebugModifyNum[16];
      }
      else if(DebugModifyCursor == 2)
      {
        DebugModifyNum[17]++;
        BrickConfirmMatLimit = DebugModifyNum[17];      //�ϰ���־�洢�������ϰ��ĸ������ڸ�ֵʱ��������Ϊ�ϰ���
        //ControlRow_Weight[2][0]  = DebugModifyNum[17];
      }
      else if(DebugModifyCursor == 3)
      {
        DebugModifyNum[18]++;
        BrickConfirmFinalColCom = DebugModifyNum[18];   //�ϰ����ʱ��������������15Ϊ�㣬����Ҽӡ���
        //ControlRow_Weight[3][0]  = DebugModifyNum[18];
      }
      else if(DebugModifyCursor == 4)
      {
        DebugModifyNum[19]++;
        LimitLeftWBMin = DebugModifyNum[19];
        LimitRightWBMin = DebugModifyNum[19];
        //ControlRow_Weight[0][1]  = DebugModifyNum[19];
      }
      else if(DebugModifyCursor == 5)
      {
        DebugModifyNum[20]++;
        LimitLeftWBMax = DebugModifyNum[20];
        LimitRightWBMax = DebugModifyNum[20];        
        //ControlRow_Weight[1][1] = DebugModifyNum[20];
      }
      else if(DebugModifyCursor == 6)
      {
        DebugModifyNum[21]++;
        LimitLeftWMin = DebugModifyNum[21];
        LimitRightWMin = DebugModifyNum[21];
        //ControlRow_Weight[2][1] = DebugModifyNum[21];
      }
      else if(DebugModifyCursor == 7)
      {
        DebugModifyNum[22]++;
        LimitLeftWMax = DebugModifyNum[22];
        LimitRightWMax = DebugModifyNum[22]; 
        //ControlRow_Weight[3][1] = DebugModifyNum[22];
      }
      else if(DebugModifyCursor == 8)
      {
        DebugModifyNum[23]++;
        LimitLeftBMin = DebugModifyNum[23];
        LimitRightBMin = DebugModifyNum[23];
        //ControlRow_Weight[0][2] = DebugModifyNum[23];
      }
      else if(DebugModifyCursor == 9)
      {
        DebugModifyNum[24]++;
        LimitLeftBMax = DebugModifyNum[24];
        LimitRightBMax = DebugModifyNum[24];
        //ControlRow_Weight[1][2] = DebugModifyNum[24];
      }
      else if(DebugModifyCursor == 10)
      {
        DebugModifyNum[25]++;
        SpeedTargetValStraight = DebugModifyNum[25];
        //ControlRow_Weight[2][2] = DebugModifyNum[25];
      }
      else if(DebugModifyCursor == 11)
      {
        DebugModifyNum[26]++;
        SpeedBrick = DebugModifyNum[26];
        //ControlRow_Weight[3][2] = DebugModifyNum[26];
      }
      else if(DebugModifyCursor == 12)
      {
        DebugModifyNum[27]++;
        SpeedTargetValGryoUp = DebugModifyNum[27];
        //ControlRow_Weight[0][3] = DebugModifyNum[27];
      }
      else if(DebugModifyCursor == 13)
      {
        DebugModifyNum[28]++;
        SpeedTargetValGryoResult = DebugModifyNum[28];
        //ControlRow_Weight[1][3] = DebugModifyNum[28];
      }
      else if(DebugModifyCursor == 14)
      {
        DebugModifyNum[29]++;
        SpeedXiaoZhiDao = DebugModifyNum[29];
        //ControlRow_Weight[2][3] = DebugModifyNum[29];
      }
      else
      {
      }
    }
    //��ǰ�ǵ�2ҳ��
    else if(DebugModifyPage == 2)
    {
      //���ݹ��λ������ֵ��
      if(DebugModifyCursor == 0)
      {
        DebugModifyNum[30]++;
        //ControlRow_Weight[3][3] = DebugModifyNum[30];
      }
      else if(DebugModifyCursor == 1)
      {
        DebugModifyNum[31]++;
        //ControlRow_Weight[0][4]  = DebugModifyNum[31];
      }
      else if(DebugModifyCursor == 2)
      {
        DebugModifyNum[32]++;
        //ControlRow_Weight[1][4]  = DebugModifyNum[32];
      }
      else if(DebugModifyCursor == 3)
      {
        DebugModifyNum[33]++;
        //ControlRow_Weight[2][4]  = DebugModifyNum[33];
      }
      else if(DebugModifyCursor == 4)
      {
        DebugModifyNum[34]++;
        //ControlRow_Weight[3][4]  = DebugModifyNum[34];
      }
      else if(DebugModifyCursor == 5)
      {
        DebugModifyNum[35]++;
        //ControlRow_Weight[0][5] = DebugModifyNum[35];
      }
      else if(DebugModifyCursor == 6)
      {
        DebugModifyNum[36]++;
        //ControlRow_Weight[1][5] = DebugModifyNum[36];
      }
      else if(DebugModifyCursor == 7)
      {
        DebugModifyNum[37]++;
        //ControlRow_Weight[2][5] = DebugModifyNum[37];
      }
      else if(DebugModifyCursor == 8)
      {
        DebugModifyNum[38]++;
        //ControlRow_Weight[3][5] = DebugModifyNum[38];
      }
      else if(DebugModifyCursor == 9)
      {
        DebugModifyNum[39]++;
        //ControlRow_Weight[0][6] = DebugModifyNum[39];
      }
      else if(DebugModifyCursor == 10)
      {
        DebugModifyNum[40]++;
        //ControlRow_Weight[1][6] = DebugModifyNum[40];
      }
      else if(DebugModifyCursor == 11)
      {
        DebugModifyNum[41]++;
        //ControlRow_Weight[2][6] = DebugModifyNum[41];
      }
      else if(DebugModifyCursor == 12)
      {
        DebugModifyNum[42]++;
        //ControlRow_Weight[3][6] = DebugModifyNum[42];
      }
      else if(DebugModifyCursor == 13)
      {
        DebugModifyNum[43]++;
        //ControlRow_Weight[0][7] = DebugModifyNum[43];
      }
      else if(DebugModifyCursor == 14)
      {
        DebugModifyNum[44]++;
        //ControlRow_Weight[1][7] = DebugModifyNum[44];
      }
      else
      {
      }
    }
    //��ǰ�ǵ�3ҳ��
    else if(DebugModifyPage == 3)
    {
      //���ݹ��λ������ֵ��
      if(DebugModifyCursor == 0)
      {
        DebugModifyNum[45]++;
        //ControlRow_Weight[2][7] = DebugModifyNum[45];
      }
      else if(DebugModifyCursor == 1)
      {
        DebugModifyNum[46]++;
        //ControlRow_Weight[3][7]  = DebugModifyNum[46];
      }
      else if(DebugModifyCursor == 2)
      {
        DebugModifyNum[47] += 10;
        //TimeRealRun += 10;
      }
      else if(DebugModifyCursor == 3)
      {
        DebugModifyNum[48] += 1;
        //SpeedPIDPVal += 1;
      }
      else if(DebugModifyCursor == 4)
      {
        DebugModifyNum[49] += 1;
        //SpeedPIDDVal += 1;
      }
      else if(DebugModifyCursor == 5)
      {
        DebugModifyNum[50]++;
        //SpeedTargetValGryoResult++;
      }
      else if(DebugModifyCursor == 6)
      {
        DebugModifyNum[51]++;
        //SpeedTargetValAngle++;
      }
      else if(DebugModifyCursor == 7)
      {
        DebugModifyNum[52]++;
        limitStopLineBlackXiu = DebugModifyNum[52];
        //SpeedTargetValStraight = DebugModifyNum[52];
      }
      else if(DebugModifyCursor == 8)
      {
        DebugModifyNum[53]++;
        ServoPIDDMat[0] = DebugModifyNum[53];
        ServoPIDD2Mat[0] = DebugModifyNum[53];
        //GyroResultForbidBackCountNum = DebugModifyNum[53];
      }
      else if(DebugModifyCursor == 9)
      {
        DebugModifyNum[54]++;
        ServoPIDDMat[1] = DebugModifyNum[54];
        ServoPIDD2Mat[1] = DebugModifyNum[54];
        //PathRealStraightCountLimit = DebugModifyNum[54];
      }
      else if(DebugModifyCursor == 10)
      {
        DebugModifyNum[55]++;
        ServoPIDDMat[2] = DebugModifyNum[55];
        ServoPIDD2Mat[2] = DebugModifyNum[55];
        //StopFlagMaxCountNum = DebugModifyNum[55];
      }
      else if(DebugModifyCursor == 11)
      {
        DebugModifyNum[56]++;
        ServoPIDDMat[3] = DebugModifyNum[56];
        ServoPIDD2Mat[3] = DebugModifyNum[56];
        //LightHouseNoStopFlag = DebugModifyNum[56];
      }
      else if(DebugModifyCursor == 12)
      {
        DebugModifyNum[57]++;
        ServoPIDDMat[4] = DebugModifyNum[57];
        ServoPIDD2Mat[4] = DebugModifyNum[57];
        //AngleHeadLineNum = DebugModifyNum[57];
      }
      else if(DebugModifyCursor == 13)
      {
        DebugModifyNum[58]++;
        ServoPIDDMat[5] = DebugModifyNum[58];
        ServoPIDD2Mat[5] = DebugModifyNum[58];
        //SpeedTargetValWaitStop = DebugModifyNum[58];
      }
      else if(DebugModifyCursor == 14)
      {
        DebugModifyNum[59]++;
        ServoPIDDMat[6] = DebugModifyNum[59];
        ServoPIDD2Mat[6] = DebugModifyNum[59];
        //SpeedTargetValGryoUp = DebugModifyNum[59];
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


//������Ϣ����
uint8 DebugButtonDeal(void)
{
  //��ǰΪ��ʾ���档
  if(DebugScreenChosen == DebugScreenChosenDisplay)
  {
    //1. �����ж�3�Ű����Ƿ��£�3�Ű�����ʾ�л���ʾ/����
    if(DebugButtonFlag[3] == 1)
    {
      //�л������ν��档
      DebugScreenChosen = DebugScreenChosenModify;
      //����׼����ʾ�����ݡ�
      LCD_CLS();
      
      return 1;
    }
    else
    {
    }
    
    //2. ���ж�2�Ű����Ƿ��£�2�Ű�������ʾ��������ʱû�ж���////////////////
    if(DebugButtonFlag[2] == 1)
    {
      
      
      return 1;
    }
    else
    {
    }
    
    //3. ���ж�1�Ű����Ƿ��£�1�Ű�������ʾ�����±�ʾ��һҳ��
    if(DebugButtonFlag[1] == 1)
    {
      //��ʾ�����µ�ҳ����1�������ͻص�0.ȡֵ��ΧΪ0~DebugDisplayPageNum - 1
      if(DebugDisplayPage >= DebugDisplayPageNum - 1)
      {
        DebugDisplayPage = 0;
      }
      else
      {
        DebugDisplayPage++;
      }
      //����׼����ʾ�����ݡ�
      LCD_CLS();
      
      return 1;
    }
    else
    {      
    }    
    
    //4. ���ж�0�Ű����Ƿ��£�2�Ű�������ʾ�����±�ʾ��һҳ��
    if(DebugButtonFlag[0] == 1)
    {
      //��ʾ�����µ�ҳ����1�����׾ͻص���.ȡֵ��ΧΪ0~DebugDisplayPageNum - 1   
      if(DebugDisplayPage == 0)
      {
        DebugDisplayPage = DebugDisplayPageNum - 1;
      }
      else
      {
        DebugDisplayPage--;
      }
      //����׼����ʾ�����ݡ�
      LCD_CLS();
      
      return 1;
    }
    else
    {
    }
    
  }
  //��ǰΪ���ν��档
  else
  {
    //1. ���ж�3�Ű����Ƿ��£�3�Ű�����ʾ�л���ʾ/���Ρ�
    if(DebugButtonFlag[3] == 1)
    {
      //�л�����ʾ���档
      DebugScreenChosen = DebugScreenChosenDisplay;
      //����׼����ʾ�����ݡ�
      LCD_CLS();
      
      return 1;      
    }
    else
    {     
    }

    //2. ���ж�2�Ű����Ƿ��£�2�Ű����ڵ��ν����±�ʾ ȷ��/���档
    if(DebugButtonFlag[2] == 1)
    {
      //֮ǰ�޸ı�־Ϊ0���ٰ���2�ż���ʾ����Ҫ�����޸ġ�����Ļ��Ҫ���ָ��ı�־��
      if(DebugModifyFlag == 0)
      {
        DebugModifyFlag = 1;
      }
      //֮ǰ�޸ı�־Ϊ1���ٰ���2�ż���ʾ�Ѿ��޸���ɣ���Ҫ���沢�˳���������ģʽ�����ı�־��ʧ��
      else
      {
        DebugModifyFlag = 0;
        ///////////////////////////////������ô���棿������
      }
      
      return 1;
    }
    else
    {
    }
    
    //3. ���ж�1�Ű����Ƿ��£�1�Ű����ڵ��ν����±�ʾ �������/ֵ��һ����λ��
    if(DebugButtonFlag[1] == 1)
    {
      //֮ǰ�޸ı�־Ϊ0����ʾ��������ģʽ������1�ż���ʾ���ƹ�ꡣ
      if(DebugModifyFlag == 0)
      {
        //����ȡֵ��ΧΪ0~14
        if(DebugModifyCursor >= 14)
        {
          //��¼��һ�εĹ��λ��
          DebugModifyCursorPre = 14;
          DebugModifyCursor = 0;         
          //DebugModifyPage��0,1,2,3��4��ȡֵ����ҳ������4ҳ֮�䷭��
          if(DebugModifyPage == 0)
          {
            DebugModifyPage = 1;
          }
          else if(DebugModifyPage == 1)
          {
            DebugModifyPage = 2;
          }
          else if(DebugModifyPage == 2)
          {
            DebugModifyPage = 3;
          }
          else if(DebugModifyPage == 3)
          {
            DebugModifyPage = 0;
          }          
          else
          {
          }
          //����׼����ʾ�����ݡ�
          LCD_CLS();
        }
        else
        {
          //��¼��һ�εĹ��λ��
          DebugModifyCursorPre = DebugModifyCursor;
          DebugModifyCursor++;
          
        }
        
      }
      //֮ǰ�޸ı�־Ϊ1����ʾ�ǼӼ�ֵģʽ������1�ż���ʾ�������ֵҪ��һ����λ��
      else
      {
        //0��ʾ��1����λ��
        DebugModifyValue(0);
      }
      
      return 1;
    }
    else
    {     
    }

    //4. ���ж�0�Ű����Ƿ��£�0�Ű����ڵ��ν����±�ʾ �������/ֵ��һ����λ��
    if(DebugButtonFlag[0] == 1)
    {
      //֮ǰ�޸ı�־Ϊ0����ʾ��������ģʽ������0�ż���ʾ���ƹ�ꡣ
      if(DebugModifyFlag == 0)
      {
        //����ȡֵ��ΧΪ0~14
        if(DebugModifyCursor == 0)
        {
          //��¼��һ�εĹ��λ�á�
          DebugModifyCursorPre = 0;
          DebugModifyCursor = 14;
          //DebugModifyPage��0, 1, 2, 3��4��ȡֵ����ҳ������4ҳ֮�䷭��
          if(DebugModifyPage == 0)
          {
            DebugModifyPage = 3;
          }
          else if(DebugModifyPage == 1)
          {
            DebugModifyPage = 0;
          }
          else if(DebugModifyPage == 2)
          {
            DebugModifyPage = 1;
          }
          else if(DebugModifyPage == 3)
          {
            DebugModifyPage = 2;
          }          
          else
          {
          }
          //����׼����ʾ�����ݡ�
          LCD_CLS();   
        }
        else
        {
          //��¼��һ�εĹ��λ�á�
          DebugModifyCursorPre = DebugModifyCursor;
          DebugModifyCursor--;
        }
     
      }
      //֮ǰ�޸ı�־Ϊ1����ʾ�ǼӼ�ֵģʽ������0�ż���ʾ�������ֵҪ��һ����λ��
      else
      {
        //1��ʾ��1����λ��
        DebugModifyValue(1);
      }
      
      return 1;
    }
    else
    {      
    }
    
  }
  
  return 1;
}

//���λ�ñ�ע
//numΪ���λ��0~14
uint8 DebugModifyCursorMark(void)
{    
  
  if(DebugModifyCursor == 0)
  {
    LCD_P6x8Str(0, 1, "#");
    if(DebugModifyCursorPre == 1)
    {
      LCD_P6x8Str(0, 2, " ");
    }
    else if(DebugModifyCursorPre == 14)
    {
      LCD_P6x8Str(64, 7, " ");
    }
    else
    {     
    }
  }
  else if(DebugModifyCursor == 1)
  {
    LCD_P6x8Str(0, 2, "#");
    if(DebugModifyCursorPre == 2)
    {
      LCD_P6x8Str(0, 3, " ");
    }
    else if(DebugModifyCursorPre == 0)
    {
      LCD_P6x8Str(0, 1, " ");
    }
    else
    {     
    }
  }
  else if(DebugModifyCursor == 2)
  {
    LCD_P6x8Str(0, 3, "#");
    if(DebugModifyCursorPre == 3)
    {
      LCD_P6x8Str(0, 4, " ");
    }
    else if(DebugModifyCursorPre == 1)
    {
      LCD_P6x8Str(0, 2, " ");
    }
    else
    {     
    }
  }  
  else if(DebugModifyCursor == 3)
  {
    LCD_P6x8Str(0, 4, "#");
    if(DebugModifyCursorPre == 4)
    {
      LCD_P6x8Str(0, 5, " ");
    }
    else if(DebugModifyCursorPre == 2)
    {
      LCD_P6x8Str(0, 3, " ");
    }
    else
    {     
    }
  }  
  else if(DebugModifyCursor == 4)
  {
    LCD_P6x8Str(0, 5, "#");
    if(DebugModifyCursorPre == 5)
    {
      LCD_P6x8Str(0, 6, " ");
    }
    else if(DebugModifyCursorPre == 3)
    {
      LCD_P6x8Str(0, 4, " ");
    }
    else
    {     
    }
  } 
  else if(DebugModifyCursor == 5)
  {
    LCD_P6x8Str(0, 6, "#");
    if(DebugModifyCursorPre == 6)
    {
      LCD_P6x8Str(0, 7, " ");
    }
    else if(DebugModifyCursorPre == 4)
    {
      LCD_P6x8Str(0, 5, " ");
    }
    else
    {     
    }
  }  
  else if(DebugModifyCursor == 6)
  {
    LCD_P6x8Str(0, 7, "#");
    if(DebugModifyCursorPre == 7)
    {
      LCD_P6x8Str(64, 0, " ");
    }
    else if(DebugModifyCursorPre == 5)
    {
      LCD_P6x8Str(0, 6, " ");
    }
    else
    {     
    }
  }
  else if(DebugModifyCursor == 7)
  {
    LCD_P6x8Str(64, 0, "#");
    if(DebugModifyCursorPre == 8)
    {
      LCD_P6x8Str(64, 1, " ");
    }
    else if(DebugModifyCursorPre == 6)
    {
      LCD_P6x8Str(0, 7, " ");
    }
    else
    {     
    }
  }
  else if(DebugModifyCursor == 8)
  {
    LCD_P6x8Str(64, 1, "#");
    if(DebugModifyCursorPre == 9)
    {
      LCD_P6x8Str(64, 2, " ");
    }
    else if(DebugModifyCursorPre == 7)
    {
      LCD_P6x8Str(64, 0, " ");
    }
    else
    {     
    }
  }
  else if(DebugModifyCursor == 9)
  {
    LCD_P6x8Str(64, 2, "#");
    if(DebugModifyCursorPre == 10)
    {
      LCD_P6x8Str(64, 3, " ");
    }
    else if(DebugModifyCursorPre == 8)
    {
      LCD_P6x8Str(64, 1, " ");
    }
    else
    {     
    }
  }
  else if(DebugModifyCursor == 10)
  {
    LCD_P6x8Str(64, 3, "#");
    if(DebugModifyCursorPre == 11)
    {
      LCD_P6x8Str(64, 4, " ");
    }
    else if(DebugModifyCursorPre == 9)
    {
      LCD_P6x8Str(64, 2, " ");
    }
    else
    {     
    }
  }
  else if(DebugModifyCursor == 11)
  {
    LCD_P6x8Str(64, 4, "#");
    if(DebugModifyCursorPre == 12)
    {
      LCD_P6x8Str(64, 5, " ");
    }
    else if(DebugModifyCursorPre == 10)
    {
      LCD_P6x8Str(64, 3, " ");
    }
    else
    {     
    }
  }
  else if(DebugModifyCursor == 12)
  {
    LCD_P6x8Str(64, 5, "#");
    if(DebugModifyCursorPre == 13)
    {
      LCD_P6x8Str(64, 6, " ");
    }
    else if(DebugModifyCursorPre == 11)
    {
      LCD_P6x8Str(64, 4, " ");
    }
    else
    {     
    }
  }
  else if(DebugModifyCursor == 13)
  {
    LCD_P6x8Str(64, 6, "#");
    if(DebugModifyCursorPre == 14)
    {
      LCD_P6x8Str(64, 7, " ");
    }
    else if(DebugModifyCursorPre == 12)
    {
      LCD_P6x8Str(64, 5, " ");
    }
    else
    {     
    }
  }
  else if(DebugModifyCursor == 14)
  {
    LCD_P6x8Str(64, 7, "#");
    if(DebugModifyCursorPre == 0)
    {
      LCD_P6x8Str(0, 1, " ");
    }
    else if(DebugModifyCursorPre == 13)
    {
      LCD_P6x8Str(64, 6, " ");
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


//OLED����ʾ��Ϣˢ�¡�
uint8 DebugOLEDUpdate(void)
{
  uint32 temp;
  uint8 i;
    
  //��ǰΪ��ʾ���档
  if(DebugScreenChosen == DebugScreenChosenDisplay)
  {
    //��0ҳ��������ʾ���ڶ��Pֵ����Ҫ��һЩ������
    //���+Ӣ����+������+��ֵ��û�й��͸��ı�־��
    //0. DF = DeviFuse                   ��ƫ�            3λ������������
    //1. DD = DeviNow - DeviPre;         ƫ��仯�ʡ�        3λ������������
    //2. DL = DeviNowLevel               ƫ��ȼ���          1λ������������
    //3. DR = DeviRowChosen              ƫ��ѡȡ�С�        2λ������������
    //4. SP = ServoPIDPMat[DeviNowLevel] ���Pֵ��           3λ������������
    //5. SD = ServoPIDDMat[DeviNowLevel] ���Dֵ��           3λ������������
    //6. SV = ServoPIDInputVal-ServoPIDCen       ���ʵ��ֵ��        3λ������������
    if(DebugDisplayPage == 0)
    {
      //��ʾ�����0ҳ�õģ���1����ʾ���ţ��м�3����ʾֵ�����1����ʾ�ַ���ĩβ��
      uint8 DF00[5] = {0, 0, 0, 0, 0};   //ƫ��DevuFuse
      uint8 DD01[5] = {0, 0, 0, 0, 0};   //ƫ��仯��DevuFuse-DeviPre
      uint8 DL02[5] = {0, 0, 0, 0, 0};   //ƫ��ȼ�DeviNowLevel
      uint8 DR03[5] = {0, 0, 0, 0, 0};   //ƫ��ѡȡ��DeviRowChosen
      uint8 SP04[5] = {0, 0, 0, 0, 0};   //���PֵServoPIDPMat[DeviNowLevel]
      uint8 SD05[5] = {0, 0, 0, 0, 0};   //���DֵServoPIDDMat[DeviNowLevel]
      uint8 SV06[5] = {0, 0, 0, 0, 0};   //���ʵ��ֵFTM1_C0V-ServoPIDCen
      uint8 QL07[5] = {0, 0, 0, 0, 0};   //�����������ֵQuadLeftCount
      uint8 QR08[5] = {0, 0, 0, 0, 0};   //�ұ���������ֵQuadRightCount
      uint8 LS09[5] = {0, 0, 0, 0, 0};   //����ɨ�����BlackLeftLastEdgeStartCol
      uint8 RS10[5] = {0, 0, 0, 0, 0};   //����ɨ�����BlackRighttLastEdgeStartCol
      uint8 CS11[5] = {0, 0, 0, 0, 0};   //ɨ����㶨λ��BlackCenEdgeStartCol
      uint8 LH12[5] = {0, 0, 0, 0, 0};   //����ͷBlackLeftHeadLine
      uint8 RH13[5] = {0, 0, 0, 0, 0};   //����ͷBlackRightHeadLine

      //��0����ʾֵ��
      if(DeviFuse < 0)
      {
        DF00[0] = 45;      //45����-
        temp = 0 - DeviFuse;
      }
      else
      {
        DF00[0] = 32;   //32����ո�
        temp = DeviFuse;
      }
      DF00[1] = temp / 100 + 48;           //48����0
      DF00[2] = (temp % 100) / 10 + 48;
      DF00[3] = (temp % 10) / 1 + 48;
      //��1����ʾֵ��
      if(DeviFuse - DeviPre < 0)
      {
        DD01[0] = 45;
        temp = DeviPre - DeviFuse;
      }
      else
      {
        DD01[0] = 32;
        temp = DeviFuse - DeviPre;        
      }
      DD01[1] = temp / 100 + 48;
      DD01[2] = (temp % 100) / 10 + 48;
      DD01[3] = (temp % 10) / 1 + 48;      
      //��2����ʾֵ��
      temp = BatteryCheckVal;
      DL02[0] = 32;
      DL02[1] = temp / 100 + 48;
      DL02[2] = (temp % 100) / 10 + 48;            
      DL02[3] = (temp % 10) / 1 + 48;
      //��3����ʾֵ��
      temp = Steer_kp[2];
      DR03[0] = 32;
      DR03[1] = temp / 100 + 48;
      DR03[2] = (temp % 100) / 10 + 48;
      DR03[3] = (temp % 10) / 1 + 48;
      //��4����ʾֵ��
      temp = Steer_kp[3];
      SP04[0] = 32;
      SP04[1] = temp / 100 + 48;
      SP04[2] = (temp % 100) / 10 + 48;
      SP04[3] = (temp % 10) / 1 + 48;        
      //��5����ʾֵ��
      temp = Steer_kp[4];
      SD05[0] = 32;
      SD05[1] = temp / 100 + 48;
      SD05[2] = (temp % 100) / 10 + 48;
      SD05[3] = (temp % 10) / 1 + 48;        
      //��6����ʾֵ��
      temp = Steer_kp[5];
      SV06[0] = 32;
      SV06[1] = temp / 100 + 48;
      SV06[2] = (temp % 100) / 10 + 48;
      SV06[3] = (temp % 10) / 1 + 48;         
      //��7����ʾֵ��
      temp = Steer_kp[6];
      QL07[0] = 32;  //�ո�
      QL07[1] = temp / 100 + 48;
      QL07[2] = (temp % 100) / 10 + 48;
      QL07[3] = (temp % 10) / 1 + 48;
      //��8����ʾֵ��
      temp = Steer_kp[7];
      QR08[0] = 32;  //�ո�
      QR08[1] = temp / 100 + 48;
      QR08[2] = (temp % 100) / 10 + 48;
      QR08[3] = (temp % 10) / 1 + 48;   
      //��9��ʾֵ��
      temp = BlackLeftEdgeStartCol;
      LS09[0] = 32;  //�ո�
      LS09[1] = temp / 100 + 48;
      LS09[2] = (temp % 100) / 10 + 48;
      LS09[3] = (temp % 10) / 1 + 48;  
      //��10����ʾֵ��
      temp = BlackRightEdgeStartCol;
      RS10[0] = 32;  //�ո�
      RS10[1] = temp / 100 + 48;
      RS10[2] = (temp % 100) / 10 + 48;
      RS10[3] = (temp % 10) / 1 + 48;  
      //��11����ʾֵ��
      temp = BlackCenEdgeStartCol;
      CS11[0] = 32;  //�ո�
      CS11[1] = temp / 100 + 48;
      CS11[2] = (temp % 100) / 10 + 48;
      CS11[3] = (temp % 10) / 1 + 48;  
      //��10����ʾֵ��
      temp = BlackLeftHeadLine;
      LH12[0] = 32;  //�ո�
      LH12[1] = temp / 100 + 48;
      LH12[2] = (temp % 100) / 10 + 48;
      LH12[3] = (temp % 10) / 1 + 48;  
      //��11����ʾֵ��
      temp = BlackRightHeadLine;
      RH13[0] = 32;  //�ո�
      RH13[1] = temp / 100 + 48;
      RH13[2] = (temp % 100) / 10 + 48;
      RH13[3] = (temp % 10) / 1 + 48;        
      //�У��У��ַ�����
      LCD_P6x8Str(55, 0, "D_0"); 
 
      LCD_P6x8Str(0, 1, "DF");
      LCD_P6x8Str(0, 2, "DD");
      LCD_P6x8Str(0, 3, "P1");
      LCD_P6x8Str(0, 4, "P2");
      LCD_P6x8Str(0, 5, "P3");
      LCD_P6x8Str(0, 6, "P4");
      LCD_P6x8Str(0, 7, "P5");
      
      LCD_P6x8Str(18, 1, DF00);
      LCD_P6x8Str(18, 2, DD01);
      LCD_P6x8Str(18, 3, DL02);
      LCD_P6x8Str(18, 4, DR03);
      LCD_P6x8Str(18, 5, SP04);
      LCD_P6x8Str(18, 6, SD05);
      LCD_P6x8Str(18, 7, SV06);
      
      LCD_P6x8Str(64, 1, "P6");
      LCD_P6x8Str(64, 2, "P7");
      LCD_P6x8Str(64, 3, "LS");
      LCD_P6x8Str(64, 4, "RS");
      LCD_P6x8Str(64, 5, "CS");
      LCD_P6x8Str(64, 6, "LH");
      LCD_P6x8Str(64, 7, "RH"); 
      
      LCD_P6x8Str(64+18, 1, QL07);
      LCD_P6x8Str(64+18, 2, QR08);
      LCD_P6x8Str(64+18, 3, LS09);
      LCD_P6x8Str(64+18, 4, RS10);
      LCD_P6x8Str(64+18, 5, CS11);
      LCD_P6x8Str(64+18, 6, LH12);
      LCD_P6x8Str(64+18, 7, RH13);

    }
    //��1ҳ��������ʾ�̶�6�е���������ߵĺڵ�׵������ֵ��
    else if(DebugDisplayPage == 1)
    {
      //��ʾ�����1ҳ�õġ�
      uint8 D_1_LB[18][4] = {0, 0, 0, 0};
      uint8 D_1_LW[18][4] = {0, 0, 0, 0};
      
      //�����ַ�����β�͡�
      for(i = 0; i < 18; i++)
      {
        D_1_LB[i][3] = 0;
        D_1_LW[i][3] = 0;
      }      
      
      //�������18��ֵ���ұ�18��ֵ�����ұ߹����м�Գơ���
      //12 06 00
      //13 07 01
      //14 08 02
      //15 09 03
      //16 10 04
      //17 11 05
      for(i = 0; i <= 5; i++)
      {
        //��ǰ�е��������ȡʧ�ܡ�
        if(BlackLeftLoc[9 + i * 10][0] ==  MaxValUint8)
        {
          D_1_LB[i][0] = 32;
          D_1_LB[i][1] = 32;
          D_1_LB[i][2] = 32;   

          D_1_LB[i + 6][0] = 32;
          D_1_LB[i + 6][1] = 32;
          D_1_LB[i + 6][2] = 32;         

          D_1_LB[i + 12][0] = 32;
          D_1_LB[i + 12][1] = 32;
          D_1_LB[i + 12][2] = 32;

          D_1_LW[i][0] = 32;
          D_1_LW[i][1] = 32;
          D_1_LW[i][2] = 32;

          D_1_LW[i + 6][0] = 32;
          D_1_LW[i + 6][1] = 32;
          D_1_LW[i + 6][2] = 32;

          D_1_LW[i + 12][0] = 32;
          D_1_LW[i + 12][1] = 32;
          D_1_LW[i + 12][2] = 32;
        }
        //��ǰ�е��������ȡ�ɹ���
        else
        {
          //0-5��ʾ��3�С�
          temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0] + 1 + BlackLeftEdgeNum] - ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0]];
          D_1_LB[i][0] = temp / 100 + 48;
          D_1_LB[i][1] = (temp % 100) / 10 + 48;
          D_1_LB[i][2] = (temp % 10) / 1 + 48;   
          
          //6-11��ʾ��2�С�
          temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0]];
          D_1_LB[i + 6][0] = temp / 100 + 48;
          D_1_LB[i + 6][1] = (temp % 100) / 10 + 48;
          D_1_LB[i + 6][2] = (temp % 10) / 1 + 48;         
          
          //12-17��ʾ��1�С�
          temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0] - 1];
          D_1_LB[i + 12][0] = temp / 100 + 48;
          D_1_LB[i + 12][1] = (temp % 100) / 10 + 48;
          D_1_LB[i + 12][2] = (temp % 10) / 1 + 48;
  
          //0-5��ʾ��4�С�
          temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0] + 1 + BlackLeftEdgeNum];
          D_1_LW[i][0] = temp / 100 + 48;
          D_1_LW[i][1] = (temp % 100) / 10 + 48;
          D_1_LW[i][2] = (temp % 10) / 1 + 48;
          
          //6-11��ʾ��5�С�
          temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0] + 2 + BlackLeftEdgeNum];
          D_1_LW[i + 6][0] = temp / 100 + 48;
          D_1_LW[i + 6][1] = (temp % 100) / 10 + 48;
          D_1_LW[i + 6][2] = (temp % 10) / 1 + 48;
          
          //12-17��ʾ��6�С�
          temp = ImgNew[9 + i * 10][BlackLeftLoc[9 + i * 10][0] + 3 + BlackLeftEdgeNum];
          D_1_LW[i + 12][0] = temp / 100 + 48;
          D_1_LW[i + 12][1] = (temp % 100) / 10 + 48;
          D_1_LW[i + 12][2] = (temp % 10) / 1 + 48;
        }
      }     
      
      //36��ֵ����ʾ��
      LCD_P6x8Str(55, 0, "D_1");
      LCD_P6x8Str(14, 1, "LB");
      LCD_P6x8Str(48, 1, "C");
      LCD_P6x8Str(86, 1, "LW");
      
      for(i = 0; i <= 5; i++)
      {
        LCD_P6x8Str(42, i+2, D_1_LB[i]);
        LCD_P6x8Str(21, i+2, D_1_LB[i+6]);
        LCD_P6x8Str(0, i+2, D_1_LB[i+12]);
        LCD_P6x8Str(64, i+2, D_1_LW[i]);
        LCD_P6x8Str(85, i+2, D_1_LW[i+6]);
        LCD_P6x8Str(106, i+2, D_1_LW[i+12]);        
      }
    }
    //��2ҳ.������ʾ�̶�6�е��Һ������ߵĺڵ�׵������ֵ��
    else if(DebugDisplayPage == 2)
    {
      //��ʾ�����2ҳ�õġ�
      uint8 D_2_RB[18][4] = {0, 0, 0, 0};  
      uint8 D_2_RW[18][4] = {0, 0, 0, 0};  
      
      //�����ַ�����β�͡�
      for(i = 0; i < 18; i++)
      {
        D_2_RB[i][3] = 0;
        D_2_RW[i][3] = 0;
      }
      
      //�������18��ֵ���ұ�18��ֵ�����ұ߹����м�Գơ���
      //12 06 00
      //13 07 01
      //14 08 02
      //15 09 03
      //16 10 04
      //17 11 05
      for(i = 0; i <= 5; i++)
      {
        //��ǰ�е��Һ�����ȡʧ�ܡ�
        if(BlackRightLoc[9 + i * 10][0] ==  MaxValUint8)
        {
          D_2_RB[i][0] = 32;
          D_2_RB[i][1] = 32;
          D_2_RB[i][2] = 32;

          D_2_RB[i + 6][0] = 32;
          D_2_RB[i + 6][1] = 32;
          D_2_RB[i + 6][2] = 32;

          D_2_RB[i + 12][0] = 32;
          D_2_RB[i + 12][1] = 32;
          D_2_RB[i + 12][2] = 32;

          D_2_RW[i][0] = 32;
          D_2_RW[i][1] = 32;
          D_2_RW[i][2] = 32;

          D_2_RW[i + 6][0] = 32;
          D_2_RW[i + 6][1] = 32;
          D_2_RW[i + 6][2] = 32;

          D_2_RW[i + 12][0] = 32;
          D_2_RW[i + 12][1] = 32;
          D_2_RW[i + 12][2] = 32;
        }
        //��ǰ�е��Һ�����ȡ�ɹ���
        else
        {
          //0-5��ʾ��4�С�
          temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0] - 1 - BlackLeftEdgeNum] - ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0]];
          D_2_RB[i][0] = temp / 100 + 48;
          D_2_RB[i][1] = (temp % 100) / 10 + 48;
          D_2_RB[i][2] = (temp % 10) / 1 + 48;
          
          //6-11��ʾ��5�С�
          temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0]];
          D_2_RB[i + 6][0] = temp / 100 + 48;
          D_2_RB[i + 6][1] = (temp % 100) / 10 + 48;
          D_2_RB[i + 6][2] = (temp % 10) / 1 + 48;
          
          //12-17��ʾ��6�С�
          temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0] + 1];
          D_2_RB[i + 12][0] = temp / 100 + 48;
          D_2_RB[i + 12][1] = (temp % 100) / 10 + 48;
          D_2_RB[i + 12][2] = (temp % 10) / 1 + 48;
  
          //0-5��ʾ��3�С�
          temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0] - 1 - BlackLeftEdgeNum];
          D_2_RW[i][0] = temp / 100 + 48;
          D_2_RW[i][1] = (temp % 100) / 10 + 48;
          D_2_RW[i][2] = (temp % 10) / 1 + 48;
          
          //6-11��ʾ��2�С�
          temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0] - 2 - BlackLeftEdgeNum];
          D_2_RW[i + 6][0] = temp / 100 + 48;
          D_2_RW[i + 6][1] = (temp % 100) / 10 + 48;
          D_2_RW[i + 6][2] = (temp % 10) / 1 + 48;
          
          //12-17��ʾ��1�С�
          temp = ImgNew[9 + i * 10][BlackRightLoc[9 + i * 10][0] - 3 - BlackLeftEdgeNum];
          D_2_RW[i + 12][0] = temp / 100 + 48;
          D_2_RW[i + 12][1] = (temp % 100) / 10 + 48;
          D_2_RW[i + 12][2] = (temp % 10) / 1 + 48;          
        }
      }     
      
      //36��ֵ����ʾ��
      LCD_P6x8Str(55, 0, "D_2");
      LCD_P6x8Str(16, 1, "RW");
      LCD_P6x8Str(70, 1, "C");
      LCD_P6x8Str(98, 1, "RB");
      
      for(i = 0; i <= 5; i++)
      {
        LCD_P6x8Str(42, i+2, D_2_RW[i]);
        LCD_P6x8Str(21, i+2, D_2_RW[i+6]);
        LCD_P6x8Str(0, i+2, D_2_RW[i+12]);
        LCD_P6x8Str(64, i+2, D_2_RB[i]);
        LCD_P6x8Str(85, i+2, D_2_RB[i+6]);
        LCD_P6x8Str(106, i+2, D_2_RB[i+12]);        
      }
    }
    //��3ҳ.������ʾ�ذ������ֵ����ȷ����ص���ֵ��
    else if(DebugDisplayPage == 3)
    {
      //��ʾ�����3ҳ�õġ�
      uint8 D_3_L[18][4] = {0, 0, 0, 0};
      uint8 D_3_R[18][4] = {0, 0, 0, 0};
      
      //�����ַ�����β�͡�
      for(i = 0; i < 18; i++)
      {
        D_3_L[i][3] = 0;
        D_3_R[i][3] = 0;
      }
      
      
      //����36��ֵ��
      for(i = 0; i <= 5; i++)
      {
        //0-5��ʾ��3�С�
        temp = ImgNew[9 + i * 10][CameraRealWidth/2];
        D_3_L[i][0] = temp / 100 + 48;
        D_3_L[i][1] = (temp % 100) / 10 + 48;
        D_3_L[i][2] = (temp % 10) / 1 + 48;
        
        //6-11��ʾ��2�С�
        temp = ImgNew[9 + i * 10][CameraRealWidth/2 - 1];
        D_3_L[i + 6][0] = temp / 100 + 48;
        D_3_L[i + 6][1] = (temp % 100) / 10 + 48;
        D_3_L[i + 6][2] = (temp % 10) / 1 + 48;
        
        //12-17��ʾ��1�С�
        temp = ImgNew[9 + i * 10][CameraRealWidth/2 - 2];
        D_3_L[i + 12][0] = temp / 100 + 48;
        D_3_L[i + 12][1] = (temp % 100) / 10 + 48;
        D_3_L[i + 12][2] = (temp % 10) / 1 + 48;

        //0-5��ʾ��4�С�
        temp = ImgNew[9 + i * 10][CameraRealWidth/2 + 1];
        D_3_R[i][0] = temp / 100 + 48;
        D_3_R[i][1] = (temp % 100) / 10 + 48;
        D_3_R[i][2] = (temp % 10) / 1 + 48;
        
        //6-11��ʾ��5�С�
        temp = ImgNew[9 + i * 10][CameraRealWidth/2 + 2];
        D_3_R[i + 6][0] = temp / 100 + 48;
        D_3_R[i + 6][1] = (temp % 100) / 10 + 48;
        D_3_R[i + 6][2] = (temp % 10) / 1 + 48;
        
        //12-17��ʾ��6�С�
        temp = ImgNew[9 + i * 10][CameraRealWidth/2 + 3];
        D_3_R[i + 12][0] = temp / 100 + 48;
        D_3_R[i + 12][1] = (temp % 100) / 10 + 48;
        D_3_R[i + 12][2] = (temp % 10) / 1 + 48;      
      }
      
      
      //36��ֵ����ʾ��
      LCD_P6x8Str(55, 0, "D_3");
      LCD_P6x8Str(0,   1, "123");
      LCD_P6x8Str(21,  1, "124");
      LCD_P6x8Str(42,  1, "125");
      LCD_P6x8Str(64,  1, "126");
      LCD_P6x8Str(85,  1, "127");
      LCD_P6x8Str(106, 1, "128");   
      
      for(i = 0; i <= 5; i++)
      {
        LCD_P6x8Str(42, i+2, D_3_L[i]);
        LCD_P6x8Str(21, i+2, D_3_L[i+6]);
        LCD_P6x8Str(0, i+2, D_3_L[i+12]);
        LCD_P6x8Str(64, i+2, D_3_R[i]);
        LCD_P6x8Str(85, i+2, D_3_R[i+6]);
        LCD_P6x8Str(106, i+2, D_3_R[i+12]);        
      }      
    }
    //��ͼ
    else if(DebugDisplayPage == 4)
    {
      uint8 bmp[127*8];  //127��0~126��8ҳ0~7��
      uint32 j;
      uint8 page;
      //ҳ ��0�� ��126��
      //0:   0 ~ 126
      //1: 127 ~ 253
      //2: 254 ~ 380
      //3: 381 ~ 507
      //4: 508 ~ 634
      //5: 635 ~ 761
      //6: 762 ~ 888
      //7: 889 ~ 1015
      //��������
      for(j = 0; j < 127 * 8; j++)
      {
        bmp[j] = 0;
      }
      //ʵ��ͼ�����60x125������д1���е�С�Ѷȡ�
      for(i = 0; i < 60; i++)
      {
        //ҳ�롣
        page = i / 8;
        //����ߣ�����д1.
        if(BlackLeftLoc[i][0] != MaxValUint8)
        {
          bmp[127 * page + BlackLeftLoc[i][0] / 2] |= 1 << (i - page * 8);
        }
        else
        {
        }
        //�Һ��ߣ�����д1.
        if(BlackRightLoc[i][0] != MaxValUint8)
        {
          bmp[127 * page + BlackRightLoc[i][0] / 2] |= 1 << (i - page * 8);
        }
        else
        {
        }                
      }
      //�б�ʶ
      bmp[253]  |= 1 << 1;  //��9��
      bmp[380]  |= 1 << 3;  //��19��
      bmp[507]  |= 1 << 5;  //��29��
      bmp[634]  |= 1 << 7;  //��39��
      bmp[888]  |= 1 << 1;  //��49��
      bmp[1015] |= 1 << 3;  //��59��
      //����ͷ
      if(BlackLeftHeadLine != MaxValUint8)
      {
        page = BlackLeftHeadLine / 8;
        bmp[127 * page] |= 1 << (BlackLeftHeadLine - page * 8);
      }
      else
      {
      }
      //����ͷ
      if(BlackRightHeadLine != MaxValUint8)
      {
        page = BlackRightHeadLine / 8;
        bmp[127 * page + 125] |= 1 << (BlackRightHeadLine - page * 8);
      }
      else
      {
      }      
      //�б�ʶ
      bmp[889]  |= 1 << 6;
      bmp[889]  |= 1 << 7;  //��0��
      bmp[951]  |= 1 << 6;
      bmp[951]  |= 1 << 7;  //��62��
      bmp[1014]  |= 1 << 6;
      bmp[1014]  |= 1 << 7;  //��125��  
      //��ɨ�����
      bmp[889 + BlackLeftEdgeStartCol / 2] |= 1 << 4;
      bmp[889 + BlackLeftEdgeStartCol / 2] |= 1 << 5;
      //��ɨ�����
      bmp[889 + BlackRightEdgeStartCol / 2] |= 1 << 4;
      bmp[889 + BlackRightEdgeStartCol / 2] |= 1 << 5;      
      //PutPixel��������ֻ����DrawBMP�������Ҹ���Ч��
      Draw_BMP(0, 0, 127, 7, bmp);      
    }
    //�����ҳ��
    else 
    {
    }
  }
  //��ǰΪ���ν��档
  else
  {
    //���ν����õġ�ǰ3����ʾֵ�����1����ʾ�ַ���ĩβ��
    uint8 tempVal[60][4]; 

    //�����ַ�����β�͡�
    for(i = 0; i < 60; i++)
    {
      tempVal[i][3] = 0;
    }
    
    //���ν����ҳ�룬0,1,2,3
    if(DebugModifyPage == 0)
    {
      //��0ҳ�ı��⡣
      LCD_P6x8Str(0, 0, "M_0");
      //�޸ı�־��
      if(DebugModifyFlag == 1)
      {
        LCD_P6x8Str(24, 0, "@");
      }
      else
      {
        LCD_P6x8Str(24, 0, " ");
      }
      
      //���ı�ע��
      DebugModifyCursorMark();
      
      //15�������ļ��㡣
      for(i = 0; i <= 14; i++)
      {
        temp = DebugModifyNum[i];
        tempVal[i][0] = temp / 100 + 48;
        tempVal[i][1] = (temp % 100) / 10 + 48;
        tempVal[i][2] = (temp % 10) / 1 + 48;        
      }
      //15���������ֵ���ʾ��
      LCD_P6x8Str(12, 1, "SPD");
      LCD_P6x8Str(12, 2, "Kp1");
      LCD_P6x8Str(12, 3, "Kp2");
      LCD_P6x8Str(12, 4, "Kp3");
      LCD_P6x8Str(12, 5, "Kp4");
      LCD_P6x8Str(12, 6, "Kp5");
      LCD_P6x8Str(12, 7, "Kp6");
      LCD_P6x8Str(76, 0, "Kp7");
      LCD_P6x8Str(76, 1, "Kp0");
      LCD_P6x8Str(76, 2, "MtI");
      LCD_P6x8Str(76, 3, "MtP");
      LCD_P6x8Str(76, 4, "Mt5");
      LCD_P6x8Str(76, 5, "Mt4");
      LCD_P6x8Str(76, 6, "Mt3");
      LCD_P6x8Str(76, 7, "Mt2");
      //15������ֵ����ʾ��
      LCD_P6x8Str(36, 1, tempVal[0]);
      LCD_P6x8Str(36, 2, tempVal[1]);
      LCD_P6x8Str(36, 3, tempVal[2]);
      LCD_P6x8Str(36, 4, tempVal[3]);
      LCD_P6x8Str(36, 5, tempVal[4]);
      LCD_P6x8Str(36, 6, tempVal[5]);
      LCD_P6x8Str(36, 7, tempVal[6]);
      LCD_P6x8Str(100, 0, tempVal[7]);
      LCD_P6x8Str(100, 1, tempVal[8]);
      LCD_P6x8Str(100, 2, tempVal[9]);
      LCD_P6x8Str(100, 3, tempVal[10]);
      LCD_P6x8Str(100, 4, tempVal[11]);
      LCD_P6x8Str(100, 5, tempVal[12]);
      LCD_P6x8Str(100, 6, tempVal[13]);
      LCD_P6x8Str(100, 7, tempVal[14]);
      
    }
    //���ν����ҳ�룬0,1,2,3
    else if(DebugModifyPage == 1)
    {
      //��1ҳ�ı��⡣
      LCD_P6x8Str(0, 0, "M_1");
      //�޸ı�־��
      if(DebugModifyFlag == 1)
      {
        LCD_P6x8Str(24, 0, "@");
      }
      else
      {
        LCD_P6x8Str(24, 0, " ");
      }
      
      //���ı�ע��
      DebugModifyCursorMark();
      
      //15�������ļ��㡣
      for(i = 15; i <= 29; i++)
      {
        temp = DebugModifyNum[i];
        tempVal[i][0] = temp / 100 + 48;
        tempVal[i][1] = (temp % 100) / 10 + 48;
        tempVal[i][2] = (temp % 10) / 1 + 48;        
      }
      //15���������ֵ���ʾ��
      LCD_P6x8Str(12, 1, "Mt1");
      LCD_P6x8Str(12, 2, "Mt0");
      LCD_P6x8Str(12, 3, "Bci");
      LCD_P6x8Str(12, 4, "Bxu");
      LCD_P6x8Str(12, 5, "WBi");
      LCD_P6x8Str(12, 6, "WBa");
      LCD_P6x8Str(12, 7, "Win");
      LCD_P6x8Str(76, 0, "Wax");
      LCD_P6x8Str(76, 1, "Bin");
      LCD_P6x8Str(76, 2, "Bax");
      LCD_P6x8Str(76, 3, "Zhi");
      LCD_P6x8Str(76, 4, "Zha");
      LCD_P6x8Str(76, 5, "sPo");
      LCD_P6x8Str(76, 6, "xPo");
      LCD_P6x8Str(76, 7, "xZi");
      //15������ֵ����ʾ��
      LCD_P6x8Str(36, 1, tempVal[0+15]);
      LCD_P6x8Str(36, 2, tempVal[1+15]);
      LCD_P6x8Str(36, 3, tempVal[2+15]);
      LCD_P6x8Str(36, 4, tempVal[3+15]);
      LCD_P6x8Str(36, 5, tempVal[4+15]);
      LCD_P6x8Str(36, 6, tempVal[5+15]);
      LCD_P6x8Str(36, 7, tempVal[6+15]);
      LCD_P6x8Str(100, 0, tempVal[7+15]);
      LCD_P6x8Str(100, 1, tempVal[8+15]);
      LCD_P6x8Str(100, 2, tempVal[9+15]);
      LCD_P6x8Str(100, 3, tempVal[10+15]);
      LCD_P6x8Str(100, 4, tempVal[11+15]);
      LCD_P6x8Str(100, 5, tempVal[12+15]);
      LCD_P6x8Str(100, 6, tempVal[13+15]);
      LCD_P6x8Str(100, 7, tempVal[14+15]);  
    }
    //��ǰ�ǵ�2ҳ��
    else if(DebugModifyPage == 2)
    {
      //��2ҳ�ı��⡣
      LCD_P6x8Str(0, 0, "M_2");
      //�޸ı�־��
      if(DebugModifyFlag == 1)
      {
        LCD_P6x8Str(24, 0, "@");
      }
      else
      {
        LCD_P6x8Str(24, 0, " ");
      }
      
      //���ı�ע��
      DebugModifyCursorMark();
      
      //15�������ļ��㡣
      for(i = 30; i <= 44; i++)
      {
        temp = DebugModifyNum[i];
        tempVal[i][0] = temp / 100 + 48;
        tempVal[i][1] = (temp % 100) / 10 + 48;
        tempVal[i][2] = (temp % 10) / 1 + 48;        
      }
      //15���������ֵ���ʾ��
      LCD_P6x8Str(12, 1, "C33");
      LCD_P6x8Str(12, 2, "C04");
      LCD_P6x8Str(12, 3, "C14");
      LCD_P6x8Str(12, 4, "C24");
      LCD_P6x8Str(12, 5, "C34");
      LCD_P6x8Str(12, 6, "C05");
      LCD_P6x8Str(12, 7, "C15");
      LCD_P6x8Str(76, 0, "C25");
      LCD_P6x8Str(76, 1, "C35");
      LCD_P6x8Str(76, 2, "C06");
      LCD_P6x8Str(76, 3, "C16");
      LCD_P6x8Str(76, 4, "C26");
      LCD_P6x8Str(76, 5, "C36");
      LCD_P6x8Str(76, 6, "C07");
      LCD_P6x8Str(76, 7, "C17");
      //15������ֵ����ʾ��
      LCD_P6x8Str(36, 1, tempVal[0+30]);
      LCD_P6x8Str(36, 2, tempVal[1+30]);
      LCD_P6x8Str(36, 3, tempVal[2+30]);
      LCD_P6x8Str(36, 4, tempVal[3+30]);
      LCD_P6x8Str(36, 5, tempVal[4+30]);
      LCD_P6x8Str(36, 6, tempVal[5+30]);
      LCD_P6x8Str(36, 7, tempVal[6+30]);
      LCD_P6x8Str(100, 0, tempVal[7+30]);
      LCD_P6x8Str(100, 1, tempVal[8+30]);
      LCD_P6x8Str(100, 2, tempVal[9+30]);
      LCD_P6x8Str(100, 3, tempVal[10+30]);
      LCD_P6x8Str(100, 4, tempVal[11+30]);
      LCD_P6x8Str(100, 5, tempVal[12+30]);
      LCD_P6x8Str(100, 6, tempVal[13+30]);
      LCD_P6x8Str(100, 7, tempVal[14+30]);
    }
    //��ǰ�ǵ�3ҳ��
    else if(DebugModifyPage == 3)
    {
      //��2ҳ�ı��⡣
      LCD_P6x8Str(0, 0, "M_2");
      //�޸ı�־��
      if(DebugModifyFlag == 1)
      {
        LCD_P6x8Str(24, 0, "@");
      }
      else
      {
        LCD_P6x8Str(24, 0, " ");
      }
      
      //���ı�ע��
      DebugModifyCursorMark();
      
      //15�������ļ��㡣
      for(i = 45; i <= 59; i++)
      {
        temp = DebugModifyNum[i];
        tempVal[i][0] = temp / 100 + 48;
        tempVal[i][1] = (temp % 100) / 10 + 48;
        tempVal[i][2] = (temp % 10) / 1 + 48;        
      }
      //15���������ֵ���ʾ��
      LCD_P6x8Str(12, 1, "C27");
      LCD_P6x8Str(12, 2, "C37");
      LCD_P6x8Str(12, 3, "Tim");
      LCD_P6x8Str(12, 4, "MoP");
      LCD_P6x8Str(12, 5, "MoD");
      LCD_P6x8Str(12, 6, "STG");
      LCD_P6x8Str(12, 7, "STA");
      LCD_P6x8Str(76, 0, "STL");
      LCD_P6x8Str(76, 1, "Kd1");
      LCD_P6x8Str(76, 2, "Kd2");
      LCD_P6x8Str(76, 3, "Kd3");
      LCD_P6x8Str(76, 4, "Kd4");
      LCD_P6x8Str(76, 5, "Kd5");
      LCD_P6x8Str(76, 6, "Kd6");
      LCD_P6x8Str(76, 7, "Kd7");
      //15������ֵ����ʾ��
      LCD_P6x8Str(36, 1, tempVal[0+45]);
      LCD_P6x8Str(36, 2, tempVal[1+45]);
      LCD_P6x8Str(36, 3, tempVal[2+45]);
      LCD_P6x8Str(36, 4, tempVal[3+45]);
      LCD_P6x8Str(36, 5, tempVal[4+45]);
      LCD_P6x8Str(36, 6, tempVal[5+45]);
      LCD_P6x8Str(36, 7, tempVal[6+45]);
      LCD_P6x8Str(100, 0, tempVal[7+45]);
      LCD_P6x8Str(100, 1, tempVal[8+45]);
      LCD_P6x8Str(100, 2, tempVal[9+45]);
      LCD_P6x8Str(100, 3, tempVal[10+45]);
      LCD_P6x8Str(100, 4, tempVal[11+45]);
      LCD_P6x8Str(100, 5, tempVal[12+45]);
      LCD_P6x8Str(100, 6, tempVal[13+45]);
      LCD_P6x8Str(100, 7, tempVal[14+45]);
    }
    else
    {
    }
  }
  return 1;
}



//Debug���Ժ�����
uint8 DebugDebug(void)
{
  
  //1. ���뿪��ɨ�裬������DebugSwitchFlag[]��־���и��¡�
  DebugSwitchScan();
  
  //2. ����ɨ�衣������DebugButtonFlag[]��־���и��¡�����ȷ�Ϻ�İ���ֵ��
  if(DebugButtonScan() == 1)
  {
    //��ĳ���������¡�
    //3. ������Ϣ����
    DebugButtonDeal();
  }
  else
  {
    //û�м������£����Բ����е�3��������
  }
  
  DebugOLEDUpdateCount++;
  if(DebugOLEDUpdateCount > DebugOLEDUpdateCountNum)
  {
    DebugOLEDUpdateCount = 0;
    //4. OLED����ʾ��Ϣˢ�¡�ˢ��ʱ����Ҫ���жϣ�����ϲ���Ӱ������
    //DisableInterrupts;
    DebugOLEDUpdate();
    //EnableInterrupts;  
  }
  else
  {    
  }
  
  return 1;
}


//������ֵд��FLASH��
uint8 FlashFinalWrite(void)
{
  uint8 *pointeruint8;         //uint8�����ݵ�ָ�롣
  uint8 i;
  
  //�Ȳ�������������
  FlashEraseSector(FlashSectorIndex);
  
  for(i = 0; i < 60; i++)
  {
    pointeruint8 = (uint8 *)&DebugModifyNum[i];
    FlashWriteNow(FlashSectorIndex, i, FlashElementSize, pointeruint8);      
  }
  
  return 1;
}
