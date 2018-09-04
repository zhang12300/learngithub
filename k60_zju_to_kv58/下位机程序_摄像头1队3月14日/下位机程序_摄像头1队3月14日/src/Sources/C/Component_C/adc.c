//============================================================================
//文件名称：adc.c  
//功能概要：adc构件源文件
//版权所有：HJF
//版本更新：2011-11-13  V1.0   初始版本
//          2011-11-21   V1.1   规范排版风格
//============================================================================

#include "adc.h"

//AD采样结果。
int16 ADResult0 = 0;
int16 ADResult1 = 0;
int16 ADResult2 = 0;
int16 ADResult3 = 0;
int16 ADResult4 = 0;
int16 ADResult5 = 0;

uint16 ADResultCom;    //温漂修正

uint32 GryoFlatCount = 0; //陀螺仪，平路计数。
uint8 GryoFlatFlag = 1;   //陀螺仪，平路标志。1平路，0坡。
int16 GyroResult[GyroResultNum];  //陀螺仪，角度储存数组。
uint8 GyroResultFlag = 0;   //陀螺仪，坡道判断。0平路，1上坡，2下坡。

//禁止赛道类型判断
uint8 GyroResultForbidFlag = 0;           //坡道禁止赛道类型判断标志，1表示禁止任何赛道类型判断，0表示不禁止。
uint8 GyroResultForbidBackCount = 0;      //坡道禁止赛道类型判断倒计数
uint8 GyroResultForbidBackCountNum = 50;  //坡道禁止赛道类型判断倒计数载入值
 
//============================================================================
//函数名称：adc_init
//函数返回：0 成功 ，1 失败
//参数说明：MoudelNumber：模块号
//功能概要：AD初始化
//============================================================================
uint8 hw_adc_init(int MoudelNumber)
{
    if(MoudelNumber == 0)//模块0
    {
    	//打开ADC0模块时钟
        SIM_SCGC6 |= (SIM_SCGC6_ADC0_MASK );
    }
    else if(MoudelNumber == 1)//模块1
    {      
    	//打开ADC1模块时钟
        SIM_SCGC3 |= (SIM_SCGC3_ADC1_MASK );
    }
    else
    {
        return 0;
    }
    
    return 1;
}



//============================================================================
//函数名称：ad_once
//函数返回：16位无符号的AD值 
//参数说明：MoudelNumber：模块号
//               Channel：通道号
//              accuracy：精度
//功能概要：采集一次一路模拟量的AD值    
//============================================================================
uint16 hw_ad_once(int MoudelNumber,int Channel,uint8 accuracy)//采集某路模拟量的AD值
{
		uint16 result = 0;
		uint8 ADCCfg1Mode = 0;
		ADC_MemMapPtr ADCMoudel;//保存ADC模块地址指针
				
		switch(accuracy)
		{
			 case 8:
			   ADCCfg1Mode = 0x00;
			   break;
			 case 12:
			   ADCCfg1Mode = 0x01;
			   break;
			 case 10:
			   ADCCfg1Mode = 0x02;
			   break;
			 case 16:
			   ADCCfg1Mode = 0x03;
			   break;
			 default:
			   ADCCfg1Mode = 0x00;
		}
		
		
		if(MoudelNumber==0)//选择ADC模块0
		{
		   ADCMoudel = ADC0_BASE_PTR;
		}
		else               //选择ADC模块1
		{
		   ADCMoudel = ADC1_BASE_PTR;
		}
		
		//配置正常电源模式，总线时钟，总线时钟4分频，长采样时间使能，设置精度
		ADC_CFG1_REG(ADCMoudel) = ADLPC_NORMAL
								 | ADC_CFG1_ADIV(ADIV_4)
								 | ADLSMP_LONG
								 | ADC_CFG1_MODE(ADCCfg1Mode)
								 | ADC_CFG1_ADICLK(ADICLK_BUS);
		   
		//配置禁止异步时钟使能输出，ADxxat通道选择，高速配置，长采样时间   
		ADC_CFG2_REG(ADCMoudel)  =    MUXSEL_ADCA
								 | ADACKEN_DISABLED
								 | ADHSC_HISPEED
								 | ADC_CFG2_ADLSTS(ADLSTS_20) ;
								
		//设置通道号
		ADC_SC1_REG(ADCMoudel,A) = AIEN_ON | DIFF_SINGLE | ADC_SC1_ADCH(Channel);
	    //等待转换完成
    	while (( ADC_SC1_REG(ADCMoudel,A) & ADC_SC1_COCO_MASK ) != ADC_SC1_COCO_MASK)
		{

		}
	    //读取转化结果
		result = ADC_R_REG(ADCMoudel,A);       
		//清ADC转换完成标志
		ADC_SC1_REG(ADCMoudel,A) &= ~ADC_SC1_COCO_MASK;

    return result;
}

//============================================================================
//函数名称：ad_mid
//函数返回：16位无符号的AD值 
//参数说明：MoudelNumber：模块号
//               Channel：通道号
//              accuracy：精度
//功能概要：中值滤波后的结果(范围:0-4095) 
//============================================================================
uint16 hw_ad_mid(int MoudelNumber,int Channel,uint8 accuracy) 
{
	uint16 i,j,k,tmp;
	//1.取3次A/D转换结果
	i = hw_ad_once(MoudelNumber,Channel,accuracy);
	j = hw_ad_once(MoudelNumber,Channel,accuracy);
	k = hw_ad_once(MoudelNumber,Channel,accuracy);
	//2.取中值
	if (i > j)
	{
		tmp = i; i = j; j = tmp;
	}
	if (k > j) 
	  tmp = j;
	else if(k > i) 
	  tmp = k;
    else 
      tmp = i;
	return tmp;
}

//============================================================================
//函数名称：ad_ave
//函数返回：16位无符号的AD值 
//参数说明：MoudelNumber：模块号
//               Channel：通道号
//              accuracy：精度
//                     N:均值滤波次数(范围:0~255)
//功能概要：均值滤波后的结果(范围:0-4095) 
//============================================================================
uint16 hw_ad_ave(int MoudelNumber,int Channel,uint8 accuracy,uint8 N) 
{
	uint32 tmp = 0;
	uint8  i;
    for(i = 0; i < N; i++)
		tmp += hw_ad_mid(MoudelNumber,Channel,accuracy);
	tmp = tmp / N; 
    return (uint16)tmp;
}


//======================================================================
//函数名：GyroInit
//功  能：陀螺仪初始化
//参  数：
//返  回：
//影  响：
//说  明：
//      
//             
//======================================================================
uint8 GyroInit(void)
{
  uint32 temp;
  uint16 adresult[100];
  uint8 i, j;
  
  //G1  ADC0_SE10   <->   PTA7
  PORT_PCR_REG(PORTA_BASE_PTR,  7) |= (0|PORT_PCR_MUX(0));
  //G2  ADC0_SE17   <->   PTE24
  //PORT_PCR_REG(PORTE_BASE_PTR, 24) |= (0|PORT_PCR_MUX(0));
  //G3  ADC0_SE18   <->   PTE25
  //PORT_PCR_REG(PORTE_BASE_PTR, 25) |= (0|PORT_PCR_MUX(0));
  
  //采样100次。
  for(i = 0; i <= 99; i++)
  {
    adresult[i] = hw_ad_mid(0, 10, 16);
  }
  
  //从小到大冒泡排排序
  for(i = 0; i <= 98; i++)
  {
    for(j = i + 1; j <= 99; j++)
    {
      if(adresult[i] < adresult[j])
      {
        temp = adresult[j];
        adresult[j] = adresult[i];
        adresult[i] = temp;
      }
      else
      {
      }
    }
  }
  
  temp = adresult[25];
  //取中间若干个点求平均值
  for(i = 26; i <= 75; i++)
  {
    temp = (temp + adresult[i]) / 2;
  }
  
  ADResultCom = temp;
  
  return 1;
}


//编码器处理。AD采集，标志位处理。
uint8 GryoDeal(void)
{
  //int16 temp;
  uint8 i;

  //3次平均AD采集编码器的返回值，即角速度。
  //由于跳变太大，所以除以1000.取千位。//原来这里是除1000的，后来改为除100
  ADResult0 = (hw_ad_mid(0, 10, 16) - ADResultCom) / 1000;
  
  //滤波。会给判坡带来滞后，不过上坡滞后没有关系，关键是在下坡必须要减速。（上坡加减速是可选的）
  ADResult1 = (ADResult1 * 90 + ADResult0 * 10) / 100;
  //为了防止跑车过程中温漂上扬，给出1的裕度（其实是1000的裕度）。即-1~+1的变化都被滤掉。
  /*
  if(ADResult1 < 0)
  {
    temp = 0 - ADResult1;
  }
  else
  {
    temp = ADResult1;
  }
  
  if(temp <= 1)
  {
    ADResult1 = 0;
  }
  else
  {    
  }
  */
  
  
  //角速度连续为0的次数的更新。由于经过上下坡后，角度不能回零，
  //所以当角速度连续为0（即平路）的次数达到一定次数后，需要手动把角度归零。
  if(ADResult1 == 0)
  {
    //角速度为0次数加1。
    GryoFlatCount++;
  }
  else
  {
    //角速度为0次数清零。
    GryoFlatCount = 0;
  }
  
  if(GryoFlatCount > GryoFlatFlagNum)
  {
    //大于若干次，判定为平路。角度归零。
    //置标志位。
    GryoFlatFlag = 1;
    //角度归零
    ADResult2 = 0;
    //数组清零，防止因为角度归零引起的跳变误判。
    for(i = 0; i <= GyroResultNum - 1; i++)
    {
      GyroResult[i] = 0;
    }
  }
  else
  {
    GryoFlatFlag = 0;
  }
  
  
  //积分。角速度变成角度。
  ADResult2 += ADResult1;
  
  for(i = 0; i <= GyroResultNum - 2; i++)
  {
    GyroResult[i] = GyroResult[i+1];
  }
  GyroResult[GyroResultNum-1] = ADResult2;
  
  //均为负值的、你陡的下降沿，上坡标志。
  if(
    (GyroResult[GyroResultNum-1] < 0)
  &&(GyroResult[0] < 0)
  &&(GyroResult[0] - GyroResult[GyroResultNum-1] > GyroResultLimit)    //巧妙的逻辑！
    )
  {
    GyroResultFlag = 1;
  }
  //均为正值的、陡的上升沿，下坡标志。下坡后容易出现上坡标志。
  else if(
    (GyroResult[GyroResultNum-1] > 0)
  &&(GyroResult[0] > 0)
  &&(GyroResult[GyroResultNum-1] - GyroResult[0] > GyroResultLimit)   //巧妙的逻辑！
    )
  {
    GyroResultFlag = 2;
  }
  //无跳变沿，平路。
  else
  {
    GyroResultFlag = 0;
  }
  
  //若倒计数不是0，则每次减一，必须放在载入之前。
  if(GyroResultForbidBackCount != 0)
  {
    GyroResultForbidBackCount--;
  }
  else
  {
  }
  //坡道禁止赛道类型判断标志
  //上坡时，将标志置1，中间会经历标志置0，然后会达到标志置2.置2时或倒计数结束时，解除标志。
  if(GyroResultFlag == 1)
  {
    //标志位置位。
    GyroResultForbidFlag = 1;
    //倒计数载入
    GyroResultForbidBackCount = GyroResultForbidBackCountNum;
  }
  //下坡标志了，或者倒计数结束了，就解除标志。
  else if(GyroResultFlag == 2 || GyroResultForbidBackCount == 0)
  {
    //解除标志
    GyroResultForbidFlag = 0;
  }
  //平路过程，不用理会。
  else
  {
  }
  
  return 1;
}


