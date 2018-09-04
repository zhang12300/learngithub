//-------------------------------------------------------------------------*
// �ļ���: isr.c                                                           *
// ˵  ��: �жϴ�������                                                    *
//---------------���ݴ�ѧ��˼����Ƕ��ʽϵͳʵ����2011��--------------------*

#include "includes.h"
#include "common.h"
#include "DMA.h"
#include "ImageGet.h"
#include "Pit.h"
#include "RunControl.h"
#include "Debug.h"

uint32 ErrorCountNow9 = 0;

uint8 QuadChangeFlag = 0;       //���ұ������л���־λ 
uint32 QuadLeftCount = 0;       //�����������ֵ��Խ���ʾ�ٶ�Խ�졣
uint32 QuadRightCount = 0;      //�ұ���������ֵ��Խ���ʾ�ٶ�Խ�졣
uint8 PIT0Count = 0;            //PIT0����ֵ

uint16 DiffCountL = 0;        //���ڲ��ٲ���ʱ���������������ܼ�����
uint16 DiffCountR = 0;        //���ڲ��ٲ���ʱ���������������ܼ�����

uint8 PIT2_Isr_Change = 0;    //PIT2�Ĺ��ܸ���ѡ��0��ʾ���ڷ���ʱ��5�������1��ʾ���ڶ�ʱͣ����
uint8 LightHouseWaitStartTooLongFlag = 0;   //�����Ⱦñ�־λ��λ
volatile uint8 QuadDoneFlag = 0;         //�������ٶ�ֵ�ɼ���ɱ�־��0δ��ɣ�1��ɡ�

//�������
uint8 ch0;
uint8 ch1;
uint8 ch2;
uint8 ch3;
uint8 ch4;
uint8 ch5;
uint8 ch6;
uint8 cnt = 0;

//-------------------------------------------------------------------------*
//������: uart3_isr                                                        *
//��  ��: ����3���ݽ����ж�����                                            *
//˵  ��: ��                                                               *
//-------------------------------------------------------------------------*
void uart0_isr(void)
{
    uint8 ch;
    DisableInterrupts;		//�����ж�
    
    if(cnt == 0){uart_re1 (UART0,&ch0);cnt++;}
    if(cnt == 1){uart_re1 (UART0,&ch1);cnt++;}
    if(cnt == 2){uart_re1 (UART0,&ch2);cnt++;}
    if(cnt == 3){uart_re1 (UART0,&ch3);cnt++;}
    if(cnt == 4){uart_re1 (UART0,&ch4);cnt++;}
    if(cnt == 5){uart_re1 (UART0,&ch5);cnt++;}
    if(cnt == 6)
    {
        uart_re1 (UART0,&ch6);cnt=0;
        if(ch0==0xFF && ch1==0x55 && ch2==0xAA && ch3==0x77 && ch4==0x01 && ch5==0x06 && ch6==0x7C)
        {
            uart_sendN(UART0, (uint8 *)"\nCar Start!", 11);
            StopRealFlag = 0;
            light_control(PORTE, 26, Light_ON);
        }
        if(ch0==0xFF && ch1==0x55 && ch2==0xAA && ch3==0x77 && ch4==0x01 && ch5==0x07 && ch6==0x7D)
        {
            uart_sendN(UART0, (uint8 *)"\nCar Stop!", 10);
            StopRealFlag = 1;
            light_control(PORTE, 26, Light_OFF);
        }
    }
    
	EnableInterrupts;		//�����ж�
}

//------------------------------------------------------------------------------
//��������PIT0_Isr
//��  �ܣ������ж϶�ʱ��PIT0�жϷ�����
//��  ������
//��  �أ���
//˵  ����
    //�ݶ�5ms��һ���жϣ������βɼ���������������ֵ��
    //ͼ��ɼ���ɺ�ͼ����ǰ����������жϣ���ͼ�����С�
    //��2�ν���ʱ�ص�����жϡ�
//------------------------------------------------------------------------------
void PIT0_Isr(void)
{       
    if((PIT_TFLG(0)&PIT_TFLG_TIF_MASK)!=0)
    {
      PIT_TFLG(0) |= PIT_TFLG_TIF_MASK;  //���жϱ�־
    }
    
    //gpio_reverse(PORTE, 26);
    
    //����ֵ��1��
    //PIT0Count++;
    //�������ٶ�ֵ�ɼ���ɱ�־��0δ��ɣ�1��ɡ�
    //QuadDoneFlag = 0;    
    QuadLeftCount = FTM2_CNT;    //��¼��������ֵ��
    FTM2_CNT = 0; 
    
    //��ֹPIT���ܹؼ���һ����ʹ����һ�δ�ͷ��ʼ������
    PIT_TCTRL(PIT0) &= ~(PIT_TCTRL_TEN_MASK);       //��ֹpitģ������
    //�ص��жϡ�
    disable_pit_interrupt(PIT0);
    //�������ٶ�ֵ�ɼ���ɱ�־��0δ��ɣ�1��ɡ�
    QuadDoneFlag = 1; 
}
/*
void PIT0_Isr(void)
{       
    if((PIT_TFLG(0)&PIT_TFLG_TIF_MASK)!=0)
    {
      PIT_TFLG(0) |= PIT_TFLG_TIF_MASK;  //���жϱ�־
    }
    
    //gpio_reverse(PORTE, 26);
    
    //����ֵ��1��
    PIT0Count++;
    //�������ٶ�ֵ�ɼ���ɱ�־��0δ��ɣ�1��ɡ�
    QuadDoneFlag = 0;         

    if(QuadChangeFlag == 0)
    {
      QuadChangeFlag = 1;          //�л����ұ������ı�־��
      QuadLeftCount = FTM2_CNT;    //��¼��������ֵ��
      
      DiffCountL += QuadLeftCount;
      
      FTM2_CNT = 0;                //���������㡣
      //��·A�� A10, B�� A11���򿪡�
      PORTA_PCR10 = PORT_PCR_MUX(6); // ��������A10ΪFTM2_PHA����  
      PORTA_PCR11 = PORT_PCR_MUX(6); // ��������A11ΪFTM2_PHB����   
      //��·A�� B18, B�� B19����Ϊ��Ч���á�
      PORTB_PCR18 = PORT_PCR_MUX(5); // ��������B18Ϊ��Ч���á�
      PORTB_PCR19 = PORT_PCR_MUX(5); // ��������B19Ϊ��Ч���á�   
    }
    else
    {
      QuadChangeFlag = 0;          //�л�����������ı�־��
      QuadRightCount = FTM2_CNT;   //��¼��������ֵ��
      
      DiffCountR += QuadRightCount;
      
      FTM2_CNT = 0;                //���������㡣
      //��·A�� B18, B�� B19���򿪡�
      PORTB_PCR18 = PORT_PCR_MUX(6); // ��������B18ΪFTM2_PHA����  
      PORTB_PCR19 = PORT_PCR_MUX(6); // ��������B19ΪFTM2_PHB����   
      //��·A�� A10, B�� A11����Ϊ��Ч���á�
      PORTA_PCR10 = PORT_PCR_MUX(5); // ��������A10Ϊ��Ч���á�
      PORTA_PCR11 = PORT_PCR_MUX(5); // ��������A11Ϊ��Ч���á� 
      
      //��ֹPIT���ܹؼ���һ����ʹ����һ�δ�ͷ��ʼ������
      PIT_TCTRL(PIT0) &= ~(PIT_TCTRL_TEN_MASK);       //��ֹpitģ������
      //�ص��жϡ�
      disable_pit_interrupt(PIT0);
      //�������ٶ�ֵ�ɼ���ɱ�־��0δ��ɣ�1��ɡ�
      QuadDoneFlag = 1; 
      
      
      
    }
    
     
}
*/
void PIT1_Isr(void)
{       
    if((PIT_TFLG(1)&PIT_TFLG_TIF_MASK)!=0)
    {
      PIT_TFLG(1) |= PIT_TFLG_TIF_MASK;  //���жϱ�־
    }
    //FTM0_C7V = 0;
    TimeOutFlag = 1;
}
//------------------------------------------------------------------------------
//��������PIT2_Isr
//��  �ܣ������ж϶�ʱ��PIT2�жϷ�����
//��  ������
//��  �أ���
//˵  ����1. ������ʱ�ܳ�����
//
//------------------------------------------------------------------------------
void PIT2_Isr(void)
{
  if((PIT_TFLG(2)&PIT_TFLG_TIF_MASK)!=0)
  {
    PIT_TFLG(2) |= PIT_TFLG_TIF_MASK;  //���жϱ�־
  }
  
  //��һ�ֹ����ǵ���������5���ʱ��
  if(PIT2_Isr_Change == 0)
  {
    //���õڶ��ֹ��ܡ�
    PIT2_Isr_Change = 1;
    
    //�����Ⱦñ�־λ��λ
    LightHouseWaitStartTooLongFlag = 1;    
    //����һ�κ�Ͳ����ٽ����ˡ������Ҫ��ʱͣ������Ҫ���¸�����ֵ����enableһ�Ρ�
    disable_pit_interrupt(PIT2);
  }
  //�ڶ��ֹ����Ƕ�ʱͣ����ʱ��
  else
  {
    //��ʱ�ܱ�־��1����ʾ��ʱ����ɣ�Ӧ������ͣ����
    TimeRealRunFlag = 1;
    //����һ�κ�Ͳ����ٽ����ˡ�һ����ֻ����һ�Ρ�
    disable_pit_interrupt(PIT2);
  }
  

  
}

//DMA0���������������PCLK������B9
//��Щ���������������Ƿ���LineIsr��ԭ����LineIsr�����Ҫ���Ͽ�ʼ�����ݣ�������
void DMA0_Isr(void)
{
  
    uint8 DMACHno = 0;
  
    ErrorCountNow9++;
    
    
    DMA_INT |= (1 << DMACHno);    //��DMA0ͨ����������жϱ�־λ
    LineCount++;              //�ɼ��м���ֵ��1
    
    if(LineCount >= CameraHight)   //����ɼ����
    {
        ImgStatus = ImgGetFinish;    //ͼ��ɼ�������־λ
           
        if(ImgPresent == ImgNO1)  
        //�����ǰ�ɼ����ǵ�1��ͼ����ô��1��ͼ��Ͳɼ����ˣ�׼���ɼ���2��ͼ��
        {
            ImgPresent = ImgNO2;  
        }
        else if(ImgPresent == ImgNO2)
        //�����ǰ�ɼ����ǵ�2��ͼ����ô��2��ͼ��Ͳɼ����ˣ�׼���ɼ���1��ͼ��
        {
            ImgPresent = ImgNO1;
        }
        else
        {
            //uart_sendN(UART0, (uint8 *)"\nError In DMA0_Isr()!", 21);  //���󾯸� 
        }
                
        //disable_irq(FIELD_IRQ);   //���ж�IRQ���ã��ȴ���һ��ImgGet()�����ٿ���
        disable_irq(LINE_IRQ);    //���ж�IRQ����
        enable_irq(DMA0_IRQ);    //DMA0��IRQ����   
         
    }   
    
  /*
    uint8 DMACHno = 0;
    DMA_INT |= (1 << DMACHno);    //��DMA0ͨ����������жϱ�־λ
    LineCount++;              //�ɼ��м���ֵ��1
    
    if(LineCount >= CameraHight)   //����ɼ����
    {
        ImgStatus = ImgGetFinish;    //ͼ��ɼ�������־λ
        disable_irq(FIELD_IRQ);   //���ж�IRQ���ã��ȴ���һ��ImgGet()�����ٿ���
        disable_irq(LINE_IRQ);    //���ж�IRQ����
        disable_irq(DMA0_IRQ);    //DMA0��IRQ����          
    }
    */
}
 

//PORTA�жϷ�����
//�����IRQ����򿪣�����������������
void PORTA_Isr(void)  
{
    PORTA_ISFR = ~0;
    uart_sendN(UART0, (uint8 *)"\nError In PORTA_Isr()!", 22); //���󾯸�
}


//PORTB�жϷ���������PCLK������DMA��B9
//�����IRQ����򿪣�����������������
void PORTB_Isr(void)  
{
    PORTB_ISFR = ~0;
    uart_sendN(UART0, (uint8 *)"\nError In PORTB_Isr()!", 22);  //���󾯸�
}


//PORTC�жϷ������������жϣ�C8
void PORTC_Isr(void)  
{
    uint32 FlagTmp = PORTC_ISFR;  
    PORTC_ISFR =  ~0;             //���PORTC�������жϱ�־λ
    
    if(FlagTmp & (1 << PIN_LINE))   //���ȷ�������жϵ�
    {
        LineIsr();                    //�����жϴ�����
    }
}



//PORTD�жϷ������������жϣ�D1
void PORTD_Isr(void)  
{
    uint32 FlagTmp = PORTD_ISFR;  
    PORTD_ISFR =  ~0;             //���PORTD�������жϱ�־λ
    
    if(FlagTmp & (1 << PIN_FIELD))   //���ȷ���ǳ��жϵ�
    {
        FieldIsr();                    //�����жϴ�����
    }

}



//PORTE�жϷ�����
//�����IRQ����򿪣�����������������
void PORTE_Isr(void)  
{
    PORTE_ISFR = ~0;
    uart_sendN(UART0, (uint8 *)"\nError In PORTE_Isr()!", 22);   //���󾯸�
}



  

/*
void porta_isr(void)//���жϣ�A24���½����ж�
{
  
	PORTA_PCR24 |= PORT_PCR_ISF_MASK;//����жϱ�־
	DMA0_Init();
	enable_irq(0);//ʹ��DMAͨ��0����ж�
	row=0;//��ʼ����
	imagerow=0;//��ʼ���ɼ���
	enable_irq (88);//ʹ��B���ж� ��B10���ж�

}
*/