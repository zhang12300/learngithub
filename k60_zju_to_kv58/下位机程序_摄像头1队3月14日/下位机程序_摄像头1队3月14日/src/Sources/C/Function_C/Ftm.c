/******************************************************************************/
/*******************************************************************************
  �ļ�����FTMģ��C�ļ�Ftm.c
  ��  �ܣ�����������PWM����������������벶׽��
  ��  �ڣ�2014.11.04
  ��  �ߣ�HJZ
  ��  ע��
*******************************************************************************/
/******************************************************************************/
#include "Ftm.h"

uint16 speedOfCar = 150;


//------------------------------------------------------------------------------
//��������MotorInit_SYJ
//��  �ܣ��������PWM��ʼ��
//��  ������
//��  �أ���
//˵  ����1. ���˾�ѧ���ĵ����ʼ�����������ֵ1000.
//------------------------------------------------------------------------------
void MotorInit_SYJ(void)
{      	
      //SIM_SOPT4|=SIM_SOPT4_FTM1FLT0_MASK;        
      /* Turn on all port clocks */
      //SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK ;                    //////////////��ͬ��ע�͵�����SYJ�ģ����ÿ������
        
      PORTD_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH4
      PORTD_PCR5 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH5
      PORTD_PCR6 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH6
      PORTD_PCR7 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH7
      
      
      /* Enable the function on PTA8 */
//      PORTC_PCR1 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK; // FTM is alt4 function for this pin         
//      PORTC_PCR2 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;
//      
//      PORTC_PCR3 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;
//      PORTC_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;       //////////////��ͬ��ע�͵���SYJ�ģ�I/O�ڲ�һ����
      
      SIM_SCGC6|=SIM_SCGC6_FTM0_MASK;         //ʹ��FTM0ʱ��      
            
      FTM0_C4SC |= FTM_CnSC_ELSB_MASK;
      FTM0_C4SC &= ~FTM_CnSC_ELSA_MASK;
      FTM0_C4SC |= FTM_CnSC_MSB_MASK;
    
      FTM0_C5SC |= FTM_CnSC_ELSB_MASK;
      FTM0_C5SC &= ~FTM_CnSC_ELSA_MASK;
      FTM0_C5SC |= FTM_CnSC_MSB_MASK;
    
      FTM0_C6SC |= FTM_CnSC_ELSB_MASK;
      FTM0_C6SC &= ~FTM_CnSC_ELSA_MASK;
      FTM0_C6SC |= FTM_CnSC_MSB_MASK;
    
      FTM0_C7SC |= FTM_CnSC_ELSB_MASK;
      FTM0_C7SC &= ~FTM_CnSC_ELSA_MASK;
      FTM0_C7SC |= FTM_CnSC_MSB_MASK;
      
      //change MSnB = 1  
//      FTM0_C0SC |= FTM_CnSC_ELSB_MASK;
//      FTM0_C0SC &= ~FTM_CnSC_ELSA_MASK;
//      FTM0_C0SC |= FTM_CnSC_MSB_MASK;     
//      
//      FTM0_C1SC |= FTM_CnSC_ELSB_MASK;
//      FTM0_C1SC &= ~FTM_CnSC_ELSA_MASK;
//      FTM0_C1SC |= FTM_CnSC_MSB_MASK; 
//      
//      FTM0_C2SC |= FTM_CnSC_ELSB_MASK;
//      FTM0_C2SC &= ~FTM_CnSC_ELSA_MASK;
//      FTM0_C2SC |= FTM_CnSC_MSB_MASK; 
//      
//      FTM0_C3SC |= FTM_CnSC_ELSB_MASK;
//      FTM0_C3SC &= ~FTM_CnSC_ELSA_MASK;
//      FTM0_C3SC |= FTM_CnSC_MSB_MASK;           //////////////��ͬ��ע�͵�����SYJ�ģ�����FTM0_C0~FTMC3��������FTM0_C4~C7
      
      //FTM1_SC = FTM_SC_PS(0) | FTM_SC_CLKS(1);
      //FTM1_SC=0X0F;     
      //FTM0_SC = 0x2d; //not enable the interrupt mask   FTM_SC_PS(5) | FTM_SC_CLKS(1);
      
      FTM0_SC = FTM_SC_PS(4) | FTM_SC_CLKS(1);                      
      //////////////��ͬ��δע�͵���SYJ�ģ�JYB����FTM0_SC = 0x08; 
      //Ҳ����˵������ѡ�õ�CLKS����"System clock"����JYB��PS=000, Ҳ����"1��Ƶ"��SYJ��PS=100��Ҳ����"16��Ƶ"��
      
      //FTM1_SC=0X1F;       //BIT5  0 FTM counter operates in up counting mode.
                            //1 FTM counter operates in up-down counting mode.      
      //BIT43 FTM1_SC|=FTM1_SC_CLKS_MASK;
                            //00 No clock selected (This in effect disables the FTM counter.)
                            //01 System clock
                            //10 Fixed frequency clock
                            //11 External clock
      //BIT210 FTM1_SC|=FTM1_SC_PS_MASK; 
                            //100M          MOD=2000;     MOD=4000;   MOD=1000; 
                            //000 Divide by 1---12KHZ     6K          24k
                            //001 Divide by 2--- 6KHZ
                            //010 Divide by 4--- 3K
                            //011 Divide by 8--- 1.5K
                            //100 Divide by 16---750
                            //101 Divide by 32---375
                            //110 Divide by 64---187.5HZ
                            //111 Divide by 128--93.75hz             
      
      FTM0_MODE |= FTM_MODE_WPDIS_MASK;      
       //BIT1   Initialize the Channels Output
      //FTMEN is bit 0, need to set to zero so DECAPEN can be set to 0
      FTM0_MODE &=0XF0;           ////////////////��ͬ��JYB����FTM0_MODE &= ~1;
       //BIT0   FTM Enable
       //0 Only the TPM-compatible registers (first set of registers) can be used without any restriction. Do not use the FTM-specific registers.
       //1 All registers including the FTM-specific registers (second set of registers) are available for use with no restrictions.
      
      FTM0_OUTMASK=0X0F;  //FTM0_OUTMASK&=0XF0;    ////////////��ͬ��ע�͵�����SYJ�ģ���Ϊ������C4~C7��SYJ��C0~C3  
                           //0 Channel output is not masked. It continues to operate normally.
                           //1 Channel output is masked. It is forced to its inactive state.
      
      FTM0_COMBINE=0;      //Function for Linked Channels (FTMx_COMBINE)
      FTM0_OUTINIT=0;
      FTM0_EXTTRIG=0;      //FTM External Trigger (FTMx_EXTTRIG)
      FTM0_POL=0;          //Channels Polarity (FTMx_POL)
                           //0 The channel polarity is active high.
                           //1 The channel polarity is active low.     
      //Set Edge Aligned PWM
      FTM0_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;//ʹ��A��B�����ģʽ
      //QUADEN is Bit 1, Set Quadrature Decoder Mode (QUADEN) Enable to 0,   (disabled)
      //FTM0_SC = 0x16; //Center Aligned PWM Select = 0, sets FTM Counter to operate in up counting mode,
      //it is field 5 of FTMx_SC (status control) - also setting the pre-scale bits here
      
      FTM0_INVCTRL=0;     //��ת����
      FTM0_SWOCTRL=0;     //����������F TM Software Output Control (FTMx_SWOCTRL)
      FTM0_PWMLOAD=0;     //FTM PWM Load
                          //BIT9: 0 Loading updated values is disabled.
                          //1 Loading updated values is enabled.
      FTM0_CNTIN=0;        //Counter Initial Value      
      FTM0_MOD=1000;       //Modulo value,The EPWM period is determined by (MOD - CNTIN + 0x0001) 
                           //��������ʱ�ӳ�ʼ�����������Եõ�4��Ƶ��Ƶ�ʣ�ϵͳ60MƵ��ʱ��PWMƵ����15M,�Դ�����
                           //PMWƵ��=XϵͳƵ��/4/(2^FTM1_SC_PS)/FTM1_MOD
      
                          /////////////////��ͬ��ûע�͵���SYJ�ģ�JYB����FTM0_MOD=7500-1;
      
      FTM0_C4V = 100;
      //FTM0_C4V = 0;         //���� the pulse width(duty cycle) is determined by (CnV - CNTIN).
      FTM0_C5V = 100;
      FTM0_C6V = 100;
      FTM0_C7V = 100;
      //FTM0_C7V = 0;            
//      FTM0_C0V=0;        //���� the pulse width(duty cycle) is determined by (CnV - CNTIN).
//      FTM0_C1V=0;
//      
//      FTM0_C2V=0;
//      FTM0_C3V=0;           /////////////////////��ͬ��ע�͵�����SYJ����Ϊ����C4~C7��������C0~C3
      
      FTM0_CNT=0;          //ֻ�е�16λ����
}



//------------------------------------------------------------------------------
//��������MotorInit_JYB
//��  �ܣ��������PWM��ʼ��
//��  ������
//��  �أ���
//˵  ����1. ���ձ�ѧ���ĵ����ʼ�����������ֵ7500.
//------------------------------------------------------------------------------
void MotorInit_JYB(void)
{
  //SIM_SOPT4|=SIM_SOPT4_FTM1FLT0_MASK;
  /* Turn on all port clocks */
  //SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;

  /* Enable the function on PTA8 */
  // FTM is alt4 function for this pin
  PORTD_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH4
  PORTD_PCR5 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH5
  PORTD_PCR6 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH6
  PORTD_PCR7 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK;  ///FTM0_CH7

  SIM_SCGC6|=SIM_SCGC6_FTM0_MASK;   //ʹ��FTM0ʱ��

  //change MSnB = 1
  FTM0_C4SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C4SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C4SC |= FTM_CnSC_MSB_MASK;

  FTM0_C5SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C5SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C5SC |= FTM_CnSC_MSB_MASK;

  FTM0_C6SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C6SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C6SC |= FTM_CnSC_MSB_MASK;

  FTM0_C7SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C7SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C7SC |= FTM_CnSC_MSB_MASK;

  //FTM1_SC = FTM_SC_PS(0) | FTM_SC_CLKS(1);
  //FTM1_SC = 0X0F;
  FTM0_SC = 0x08;//???not enable the interrupt mask
  //ϵͳʱ��sys_clk����Ϊ32��Ƶ��Ƶ��Ϊ2343.7Hz
  //FTM1_SC = 0X1F;     //BIT5
                        //0 FTM counter operates in up counting mode.
                        //1 FTM counter operates in up-down counting mode.
                        //BIT43 FTM1_SC|=FTM1_SC_CLKS_MASK;
                        //00 No clock selected (This in effect disables the FTM counter.)
                        //01 System clock
                        //10 Fixed frequency clock
                        //11 External clock
                        //BIT210 FTM1_SC|=FTM1_SC_PS_MASK;
                        //100M          MOD=2000;     MOD=4000;   MOD=1000;
                        //000 Divide by 1---12KHZ     6K          24k
                        //001 Divide by 2--- 6KHZ
                        //010 Divide by 4--- 3K
                        //011 Divide by 8--- 1.5K
                        //100 Divide by 16---750
                        //101 Divide by 32---375
                        //110 Divide by 64---187.5HZ
                        //111 Divide by 128--93.75hz

  FTM0_MODE |= FTM_MODE_WPDIS_MASK;
  //BIT1   Initialize the Channels Output
  //FTMEN is bit 0, need to set to zero so DECAPEN can be set to 0
  FTM0_MODE &= ~1;
  //BIT0   FTM Enable
  //0 Only the TPM-compatible registers (first set of registers) can be used without any restriction. Do not use the FTM-specific registers.
  //1 All registers including the FTM-specific registers (second set of registers) are available for use with no restrictions.

  FTM0_OUTMASK=0X0F;   //0 Channel output is not masked. It continues to operate normally.
                       //1 Channel output is masked. It is forced to its inactive state.

  FTM0_COMBINE=0;      //Function for Linked Channels (FTMx_COMBINE)
  FTM0_OUTINIT=0;
  FTM0_EXTTRIG=0;      //FTM External Trigger (FTMx_EXTTRIG)
  FTM0_POL=0;          //Channels Polarity (FTMx_POL)
                       //0 The channel polarity is active high.
                       //1 The channel polarity is active low.
  //Set Edge Aligned PWM
  FTM0_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;
  //QUADEN is Bit 1, Set Quadrature Decoder Mode (QUADEN) Enable to 0,   (disabled)
  //FTM0_SC = 0x16; //Center Aligned PWM Select = 0, sets FTM Counter to operate in up counting mode,
  //it is field 5 of FTMx_SC (status control) - also setting the pre-scale bits here

  FTM0_INVCTRL=0;     //��ת����
  FTM0_SWOCTRL=0;     //����������F TM Software Output Control (FTMx_SWOCTRL)
  FTM0_PWMLOAD=0;     //FTM PWM Load
                      //BIT9:
                      //0 Loading updated values is disabled.
                      //1 Loading updated values is enabled.
  FTM0_CNTIN=0;       //Counter Initial Value
  FTM0_MOD=7500-1;      //Modulo value,The EPWM period is determined by (MOD - CNTIN + 0x0001)
                      //��������ʱ�ӳ�ʼ�����������Եõ�4��Ƶ��Ƶ�ʣ�ϵͳ60MƵ��ʱ��PWMƵ����15M,�Դ�����
                      //PMWƵ��=XϵͳƵ��/4/(2^FTM1_SC_PS)/FTM1_MOD
  FTM0_C4V=0;         //���� the pulse width(duty cycle) is determined by (CnV - CNTIN).
  FTM0_C5V=0;
  FTM0_C6V=0; 
  FTM0_C7V=0;             ///�˴�CnVд0��Ϊ��ʹռ�ձ�Ϊ0����ʱ�����PWM����   --HJZ
  FTM0_CNT=0;         //ֻ�е�16λ����    
                    
}





//------------------------------------------------------------------------------
//��������QuadInit3
//��  �ܣ�3��������������ʼ��
//��  ������
//��  �أ���
//˵  ����1. 3����������������ģʽ��QUADMODE=1, A�����Լ�����B������ָʾ�����������ջ��߽Ӹߵ�ƽ��
//------------------------------------------------------------------------------
void QuadInit3(void)
{
  //Ĭ���ȴ���·���ر���·��
  //��·A�� B18, B�� B19���򿪡�
  PORTB_PCR18 = PORT_PCR_MUX(6); // ��������B18ΪFTM2_PHA����  
  PORTB_PCR19 = PORT_PCR_MUX(6); // ��������B19ΪFTM2_PHB����   
  //��·A�� A10, B�� A11����Ϊ��Ч���á�
  PORTA_PCR10 = PORT_PCR_MUX(5); // ��������A10Ϊ��Ч���á�
  PORTA_PCR11 = PORT_PCR_MUX(5); // ��������A11Ϊ��Ч���á� 
          
  SIM_SCGC3 |= SIM_SCGC3_FTM2_MASK;         //ʹ��FTM2ʱ��  
  FTM2_MODE |= FTM_MODE_WPDIS_MASK;         //д������ֹ  
  FTM2_QDCTRL |= FTM_QDCTRL_QUADMODE_MASK;  //AB��ͬʱȷ������ͼ���ֵ����QUADMODE = 1
  FTM2_CNTIN = 0;                           //FTM0��������ʼֵΪ0  
  FTM2_MOD = 65535;                         //����ֵ  
  FTM2_QDCTRL |= FTM_QDCTRL_QUADEN_MASK;    //����FTM2��������ģʽ����QUADEN = 1  
  FTM2_MODE |= FTM_MODE_FTMEN_MASK;         //FTM2EN = 1    
  FTM2_CNT = 0;                             //���������㡣
}

//��ѧ���ı�������ʼ�����������������߱������ġ�
/*

//------------------------------------------------------------------------------
//��������QuadInit
//��  �ܣ�������������ʼ��
//��  ������
//��  �أ���
//˵  ����
//------------------------------------------------------------------------------
void QuadInit(void)
{
  //�����˿�ʱ��
  //SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;
  //ѡ��ܽŸ��ù���
  PORTB_PCR0 = PORT_PCR_MUX(6);
  PORTB_PCR1 = PORT_PCR_MUX(6);
  PORTB_PCR18 = PORT_PCR_MUX(6);
  PORTB_PCR19 = PORT_PCR_MUX(6);
  //ʹ��FTM1��FTM2ʱ��
  SIM_SCGC6|=SIM_SCGC6_FTM1_MASK;
  SIM_SCGC3|=SIM_SCGC3_FTM2_MASK;

  FTM1_MOD = 20000;                 //�ɸ�����Ҫ����
  FTM2_MOD = 20000;

  FTM1_CNTIN = 0;
  FTM2_CNTIN = 0;

  FTM1_MODE |= FTM_MODE_WPDIS_MASK; //��ֹд����
  FTM2_MODE |= FTM_MODE_WPDIS_MASK; //��ֹд����
  FTM1_MODE |= FTM_MODE_FTMEN_MASK; //FTMEN=1,�ر�TPM����ģʽ������FTM���й���
  FTM2_MODE |= FTM_MODE_FTMEN_MASK; //FTMEN=1,�ر�TPM����ģʽ������FTM���й���

  FTM1_QDCTRL &= ~FTM_QDCTRL_QUADMODE_MASK;  //ѡ������ģʽΪA����B�����ģʽ
  FTM1_QDCTRL |= FTM_QDCTRL_QUADEN_MASK;     //ʹ����������ģʽ
  FTM2_QDCTRL &= ~FTM_QDCTRL_QUADMODE_MASK;  //ѡ������ģʽΪA����B�����ģʽ
  FTM2_QDCTRL |= FTM_QDCTRL_QUADEN_MASK;     //ʹ����������ģʽ

  FTM1_SC |= FTM_SC_CLKS(3);         //ѡ���ⲿʱ��
  //FTM1_CONF |=FTM_CONF_BDMMODE(3); //�ɸ�����Ҫѡ��
  FTM2_SC |= FTM_SC_CLKS(3);
  //FTM2_CONF |=FTM_CONF_BDMMODE(3);
}

*/

/*

//------------------------------------------------------------------------------
//��������Ftm0Init
//��  �ܣ��������PWM��ʼ��
//��  ������
//��  �أ���
//˵  ����
//------------------------------------------------------------------------------
void Ftm0Init(void)
{
  //��PORTDģ���ſ�ʱ��
  SIM_SCGC5 |= SIM_SCGC5_PORTD_MASK;

  //��PORTD4����ΪFTM0_ch4����PORTD5����ΪFTM0_ch5�������������������
  PORTD_PCR4 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK; //D4ΪFTM0_ch4�������
  PORTD_PCR5 = PORT_PCR_MUX(0x4)| PORT_PCR_DSE_MASK; //D5ΪFTM0_ch5�������

  //ʹ��FTM0ʱ��
  SIM_SCGC6 |= SIM_SCGC6_FTM0_MASK;

  //����FTM0_ch4Ϊ���ض���PWM��������
  FTM0_C4SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C4SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C4SC |= FTM_CnSC_MSB_MASK;

  //����FTM0_ch5Ϊ���ض���PWM��������
  FTM0_C5SC |= FTM_CnSC_ELSB_MASK;
  FTM0_C5SC &= ~FTM_CnSC_ELSA_MASK;
  FTM0_C5SC |= FTM_CnSC_MSB_MASK;

  //ʱ��Դѡ��sys_clk����FTM������Ԥ��Ƶ16��
  FTM0_SC = FTM_SC_PS(4) | FTM_SC_CLKS(1);

  FTM0_MODE &= ~FTM_MODE_FTMEN_MASK;         //��ֹFTMģ��
  //һ����ֹFTMEN����FTM�ض��Ĵ�������д�룬�����������Ч
  FTM0_OUTMASK = 0xCF;                       //ͨ��4��5��ֹ���룬������������

  FTM0_COMBINE = 0;                          //����������ͨ��,ȫ����ֹ
  FTM0_OUTINIT = 0;                          //�ⲿ�����ʼ��Ϊ0
  FTM0_EXTTRIG = 0;                          //�ⲿ�������ã�ȫ����ֹ
  FTM0_POL = 0;                              //����������ã�ȫ��Ϊ������

  FTM0_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;     //������������ʹ�ܣ�EPWM����CPWM������

  FTM0_INVCTRL = 0;       //FTM���ù��ܽ�ֹ
  FTM0_SWOCTRL = 0;       //���������ƽ�ֹ
  FTM0_PWMLOAD = 0;       //PWM���ؿ��ƽ�ֹ

  //��������PWM�������ڡ�ռ�ձȵȲ���
  //PWM���㷽����CnV/MOD��MOD��֪��ͨ������CnV����ռ�ձ�
  FTM0_CNTIN = 0;         //FTM������ʼֵ����Ϊ0
  FTM0_MOD = 1000;        //FTM������ģ��ֵΪ1000
                          //����LQ��ʱ�ӳ�ʼ���������õ�����Ƶ��PWM����sys_clkΪ100M����PWMΪ50M
                          //PWMƵ��f=sys_clk/2/(2^FTM0_SC_PS)/FTM0_MOD=150M/2/16/1000=4687.5Hz������0.213ms
  FTM0_C4V = 0;           //��������ΪCnV - CNTIN��ռ�ձ�Ϊ20%
  FTM0_C5V = 0;
  FTM0_CNT = 0;           //FTM�������Ĵ�������16λ�����ã�д���κ�ֵ��ʹ��ص�CNTIN
}
*/
//------------------------------------------------------------------------------
//��������ServoInit
//��  �ܣ��������PWM��ʼ��
//��  ������
//��  �أ���
//˵  ����
//------------------------------------------------------------------------------
void ServoInit(void)
{
  //��PORTAģ���ſ�ʱ��
  SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;

  //��PORTB0����ΪFTM1_ch0�������������������
  PORTA_PCR12 = PORT_PCR_MUX(0x3)| PORT_PCR_DSE_MASK;

  //ʹ��FTM1ģ���ſ�ʱ��
  SIM_SCGC6|=SIM_SCGC6_FTM1_MASK;

  //����FTM1_ch0Ϊ���ض���PWM��������
  FTM1_C0SC |= FTM_CnSC_ELSB_MASK;
  FTM1_C0SC &= ~FTM_CnSC_ELSA_MASK;
  FTM1_C0SC |= FTM_CnSC_MSB_MASK;

  //ʱ��Դѡ��sys_clk����FTM������Ԥ��Ƶ128��
  FTM1_SC = FTM_SC_PS(6) | FTM_SC_CLKS(1);

  FTM1_MODE &= ~FTM_MODE_FTMEN_MASK;         //��ֹFTMģ��
  FTM1_OUTMASK &= ~1;                        //ͨ��0��ֹ���룬������������

  FTM1_COMBINE = 0;                          //����������ͨ��,ȫ����ֹ
  FTM1_OUTINIT = 0;                          //�ⲿ�����ʼ��Ϊ0
  FTM1_EXTTRIG = 0;                          //�ⲿ�������ã�ȫ����ֹ
  FTM1_POL = 0;                              //����������ã�ȫ��Ϊ������

  FTM1_QDCTRL &=~FTM_QDCTRL_QUADEN_MASK;     //������������ʹ�ܣ�EPWM����CPWM������

  FTM1_INVCTRL = 0;     //FTM���ù��ܽ�ֹ
  FTM1_SWOCTRL = 0;     //���������ƽ�ֹ
  FTM1_PWMLOAD = 0;     //PWM���ؿ��ƽ�ֹ

  //��������PWM�������ڡ�ռ�ձȵȲ���
  //PWM���㷽����CnV/MOD��MOD��֪��ͨ������CnV����ռ�ձ�
  FTM1_CNTIN = 0;         //FTM������ʼֵ����Ϊ0
  FTM1_MOD = 23437 - 1;        //FTM������ģ��ֵΪ2000
                          //����LQ��ʱ�ӳ�ʼ���������õ�����Ƶ��PWM����sys_clkΪ100M����PWMΪ50M
                          //PWMƵ��f=sys_clk/2/(2^FTM1_SC_PS)/FTM1_MOD=150M/2/128/1953=300.02Hz������3.33ms
  FTM1_C0V = 1750;      //��������ΪCnV - CNTIN��ռ�ձ�Ϊ20%
  //4.3% 4.4%(L) 4.5% 5.0% 5.5% 6.0% 6.5% 7.0% 7.15%(C) 7.5% 8.0% 8.5% 9.0% 9.5% 9.9%(R) 10.0% 10.3% 10.5%
  //1008 1031    1055 1172 1289 1406 1523 1640 1676     1758 1875 1992 2109 2226 2320    2344  2414  4922
  
  //6.3% 1476
  //6.55% 1535
  //6.6% 1547
  //6.8% 1594
  //6.9% 1617
  //7.45% 1746
  //7.9% 1851
  //8.45% 1980
  //8.7% 2039
  //8.9% 2086
  //9.3% 2180
  // 1965   1765   1580
  FTM1_CNT = 0;           //FTM�������Ĵ�������16λ�����ã�д���κ�ֵ��ʹ��ص�CNTIN
}








