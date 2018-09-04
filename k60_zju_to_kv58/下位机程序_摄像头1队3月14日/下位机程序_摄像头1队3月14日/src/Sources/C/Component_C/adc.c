//============================================================================
//�ļ����ƣ�adc.c  
//���ܸ�Ҫ��adc����Դ�ļ�
//��Ȩ���У�HJF
//�汾���£�2011-11-13  V1.0   ��ʼ�汾
//          2011-11-21   V1.1   �淶�Ű���
//============================================================================

#include "adc.h"

//AD���������
int16 ADResult0 = 0;
int16 ADResult1 = 0;
int16 ADResult2 = 0;
int16 ADResult3 = 0;
int16 ADResult4 = 0;
int16 ADResult5 = 0;

uint16 ADResultCom;    //��Ư����

uint32 GryoFlatCount = 0; //�����ǣ�ƽ·������
uint8 GryoFlatFlag = 1;   //�����ǣ�ƽ·��־��1ƽ·��0�¡�
int16 GyroResult[GyroResultNum];  //�����ǣ��Ƕȴ������顣
uint8 GyroResultFlag = 0;   //�����ǣ��µ��жϡ�0ƽ·��1���£�2���¡�

//��ֹ���������ж�
uint8 GyroResultForbidFlag = 0;           //�µ���ֹ���������жϱ�־��1��ʾ��ֹ�κ����������жϣ�0��ʾ����ֹ��
uint8 GyroResultForbidBackCount = 0;      //�µ���ֹ���������жϵ�����
uint8 GyroResultForbidBackCountNum = 50;  //�µ���ֹ���������жϵ���������ֵ
 
//============================================================================
//�������ƣ�adc_init
//�������أ�0 �ɹ� ��1 ʧ��
//����˵����MoudelNumber��ģ���
//���ܸ�Ҫ��AD��ʼ��
//============================================================================
uint8 hw_adc_init(int MoudelNumber)
{
    if(MoudelNumber == 0)//ģ��0
    {
    	//��ADC0ģ��ʱ��
        SIM_SCGC6 |= (SIM_SCGC6_ADC0_MASK );
    }
    else if(MoudelNumber == 1)//ģ��1
    {      
    	//��ADC1ģ��ʱ��
        SIM_SCGC3 |= (SIM_SCGC3_ADC1_MASK );
    }
    else
    {
        return 0;
    }
    
    return 1;
}



//============================================================================
//�������ƣ�ad_once
//�������أ�16λ�޷��ŵ�ADֵ 
//����˵����MoudelNumber��ģ���
//               Channel��ͨ����
//              accuracy������
//���ܸ�Ҫ���ɼ�һ��һ·ģ������ADֵ    
//============================================================================
uint16 hw_ad_once(int MoudelNumber,int Channel,uint8 accuracy)//�ɼ�ĳ·ģ������ADֵ
{
		uint16 result = 0;
		uint8 ADCCfg1Mode = 0;
		ADC_MemMapPtr ADCMoudel;//����ADCģ���ַָ��
				
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
		
		
		if(MoudelNumber==0)//ѡ��ADCģ��0
		{
		   ADCMoudel = ADC0_BASE_PTR;
		}
		else               //ѡ��ADCģ��1
		{
		   ADCMoudel = ADC1_BASE_PTR;
		}
		
		//����������Դģʽ������ʱ�ӣ�����ʱ��4��Ƶ��������ʱ��ʹ�ܣ����þ���
		ADC_CFG1_REG(ADCMoudel) = ADLPC_NORMAL
								 | ADC_CFG1_ADIV(ADIV_4)
								 | ADLSMP_LONG
								 | ADC_CFG1_MODE(ADCCfg1Mode)
								 | ADC_CFG1_ADICLK(ADICLK_BUS);
		   
		//���ý�ֹ�첽ʱ��ʹ�������ADxxatͨ��ѡ�񣬸������ã�������ʱ��   
		ADC_CFG2_REG(ADCMoudel)  =    MUXSEL_ADCA
								 | ADACKEN_DISABLED
								 | ADHSC_HISPEED
								 | ADC_CFG2_ADLSTS(ADLSTS_20) ;
								
		//����ͨ����
		ADC_SC1_REG(ADCMoudel,A) = AIEN_ON | DIFF_SINGLE | ADC_SC1_ADCH(Channel);
	    //�ȴ�ת�����
    	while (( ADC_SC1_REG(ADCMoudel,A) & ADC_SC1_COCO_MASK ) != ADC_SC1_COCO_MASK)
		{

		}
	    //��ȡת�����
		result = ADC_R_REG(ADCMoudel,A);       
		//��ADCת����ɱ�־
		ADC_SC1_REG(ADCMoudel,A) &= ~ADC_SC1_COCO_MASK;

    return result;
}

//============================================================================
//�������ƣ�ad_mid
//�������أ�16λ�޷��ŵ�ADֵ 
//����˵����MoudelNumber��ģ���
//               Channel��ͨ����
//              accuracy������
//���ܸ�Ҫ����ֵ�˲���Ľ��(��Χ:0-4095) 
//============================================================================
uint16 hw_ad_mid(int MoudelNumber,int Channel,uint8 accuracy) 
{
	uint16 i,j,k,tmp;
	//1.ȡ3��A/Dת�����
	i = hw_ad_once(MoudelNumber,Channel,accuracy);
	j = hw_ad_once(MoudelNumber,Channel,accuracy);
	k = hw_ad_once(MoudelNumber,Channel,accuracy);
	//2.ȡ��ֵ
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
//�������ƣ�ad_ave
//�������أ�16λ�޷��ŵ�ADֵ 
//����˵����MoudelNumber��ģ���
//               Channel��ͨ����
//              accuracy������
//                     N:��ֵ�˲�����(��Χ:0~255)
//���ܸ�Ҫ����ֵ�˲���Ľ��(��Χ:0-4095) 
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
//��������GyroInit
//��  �ܣ������ǳ�ʼ��
//��  ����
//��  �أ�
//Ӱ  �죺
//˵  ����
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
  
  //����100�Ρ�
  for(i = 0; i <= 99; i++)
  {
    adresult[i] = hw_ad_mid(0, 10, 16);
  }
  
  //��С����ð��������
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
  //ȡ�м����ɸ�����ƽ��ֵ
  for(i = 26; i <= 75; i++)
  {
    temp = (temp + adresult[i]) / 2;
  }
  
  ADResultCom = temp;
  
  return 1;
}


//����������AD�ɼ�����־λ����
uint8 GryoDeal(void)
{
  //int16 temp;
  uint8 i;

  //3��ƽ��AD�ɼ��������ķ���ֵ�������ٶȡ�
  //��������̫�����Գ���1000.ȡǧλ��//ԭ�������ǳ�1000�ģ�������Ϊ��100
  ADResult0 = (hw_ad_mid(0, 10, 16) - ADResultCom) / 1000;
  
  //�˲���������´����ͺ󣬲��������ͺ�û�й�ϵ���ؼ��������±���Ҫ���١������¼Ӽ����ǿ�ѡ�ģ�
  ADResult1 = (ADResult1 * 90 + ADResult0 * 10) / 100;
  //Ϊ�˷�ֹ�ܳ���������Ư�������1��ԣ�ȣ���ʵ��1000��ԣ�ȣ�����-1~+1�ı仯�����˵���
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
  
  
  //���ٶ�����Ϊ0�Ĵ����ĸ��¡����ھ��������º󣬽ǶȲ��ܻ��㣬
  //���Ե����ٶ�����Ϊ0����ƽ·���Ĵ����ﵽһ����������Ҫ�ֶ��ѽǶȹ��㡣
  if(ADResult1 == 0)
  {
    //���ٶ�Ϊ0������1��
    GryoFlatCount++;
  }
  else
  {
    //���ٶ�Ϊ0�������㡣
    GryoFlatCount = 0;
  }
  
  if(GryoFlatCount > GryoFlatFlagNum)
  {
    //�������ɴΣ��ж�Ϊƽ·���Ƕȹ��㡣
    //�ñ�־λ��
    GryoFlatFlag = 1;
    //�Ƕȹ���
    ADResult2 = 0;
    //�������㣬��ֹ��Ϊ�Ƕȹ���������������С�
    for(i = 0; i <= GyroResultNum - 1; i++)
    {
      GyroResult[i] = 0;
    }
  }
  else
  {
    GryoFlatFlag = 0;
  }
  
  
  //���֡����ٶȱ�ɽǶȡ�
  ADResult2 += ADResult1;
  
  for(i = 0; i <= GyroResultNum - 2; i++)
  {
    GyroResult[i] = GyroResult[i+1];
  }
  GyroResult[GyroResultNum-1] = ADResult2;
  
  //��Ϊ��ֵ�ġ��㶸���½��أ����±�־��
  if(
    (GyroResult[GyroResultNum-1] < 0)
  &&(GyroResult[0] < 0)
  &&(GyroResult[0] - GyroResult[GyroResultNum-1] > GyroResultLimit)    //������߼���
    )
  {
    GyroResultFlag = 1;
  }
  //��Ϊ��ֵ�ġ����������أ����±�־�����º����׳������±�־��
  else if(
    (GyroResult[GyroResultNum-1] > 0)
  &&(GyroResult[0] > 0)
  &&(GyroResult[GyroResultNum-1] - GyroResult[0] > GyroResultLimit)   //������߼���
    )
  {
    GyroResultFlag = 2;
  }
  //�������أ�ƽ·��
  else
  {
    GyroResultFlag = 0;
  }
  
  //������������0����ÿ�μ�һ�������������֮ǰ��
  if(GyroResultForbidBackCount != 0)
  {
    GyroResultForbidBackCount--;
  }
  else
  {
  }
  //�µ���ֹ���������жϱ�־
  //����ʱ������־��1���м�ᾭ����־��0��Ȼ���ﵽ��־��2.��2ʱ�򵹼�������ʱ�������־��
  if(GyroResultFlag == 1)
  {
    //��־λ��λ��
    GyroResultForbidFlag = 1;
    //����������
    GyroResultForbidBackCount = GyroResultForbidBackCountNum;
  }
  //���±�־�ˣ����ߵ����������ˣ��ͽ����־��
  else if(GyroResultFlag == 2 || GyroResultForbidBackCount == 0)
  {
    //�����־
    GyroResultForbidFlag = 0;
  }
  //ƽ·���̣�������ᡣ
  else
  {
  }
  
  return 1;
}


