/******************************************************************************
1������̳���12�������ѧ���ĳ���ͼ�񲿷ּ��˲��������ǲ����Ĳ�������д���ģ���һ��
�ʺ����еĳ�����������������⣬���Ի��ú����ѧ���ĳ���Ȼ�������ڱ������ᵽ�Ĳ���
˼·�Ѳ������ϡ�

2��ǰ�ڲ����õ�OLED���������������ǣ����ԹرյĹ����Ҷ��á�����ʼ�׶ο����ȹرգ�����ע
��

3���������˳��Ϊ����������---����ͷ��ͼ---������---�������---OLED����---������--
-������

4��ע�⣬������ر�OLED���ι��ܵĻ����������Ǵ�Flash�ж�ȡ�ģ����뱣֤Flash���Ѿ�����
���˲���������ǰ�ڹر�OLED���ι��ܣ���Щ�����Ҷ�������Ĭ��ֵ���ر�OLED���ι��ܺ����Ĭ
�ϲ������С�

5��ͼ����򣬽�������λ�������ͼ����������ܳ������������˴�ƪ��ר�Ų�����ͼ����
��˼·�����ں����ѧ��ͼ��Ļ��������ӵļ����������������θ�Ҫ����ѧ���ı��棬��Ը��Щ
���ݻ����ͼ���ͬѧ�ڿ�ʼ�׶����ͼ���������������

6��ͣ���ߡ�ʮ�ֵĶ����ж�����תͣ�����ܳ�����ͣ���ȹ��ܹر��ˣ�ͣ���ߵĺ�����ImagePro.c
�е�StopLineCheck()��ʮ�ֶ����ж��ĺ�����ImagePro.c�е�ShiZhiCheck()����ͨ��ImagePro.c
�е�PathJudgeNew()���á���תͣ�����ܳ�����������ͨ������DuZhuanFlag��RunOutFlag�ҵ�
��صĴ��롣֮���Թر���Щ���ܣ���Ϊ�˱��������ǻ�����Ϥͼ������ʱ�򣬵����г���ͻȻ
ͣ���������

7�����PWM�Ŀ��ƣ�1��2�ڱ������������Ƶ���������ʹ���ˣ�3��4�ڲ��ǿ��Ƶ��ת�ٵģ�ʹ
�õ�ʱ���ر�ע��

8����Ա֮��ֹ���ȷ����Ȼ���������ܳ��ˣ���Ҫ�����Ժ�û�п���ʱ���׼�������Ʋ��ֶ����
���۾��飬ͼ�񲿷ֽ����λ����ⲻҪ�ӱܣ�Ӳ��������������İ��Ӿ��������Լ��İ��ӣ�
ףԸ����ȡ�úóɼ���

******************************************************************************/
/******************************************************************************/
/*********************************
��dev.env.��IAR EWARM 6.30.1.3142
��Target  ��MK60-DN512-VLQ10
��Crystal ��50.000  MHz
��busclock��75.000  MHz
��pllclock��150.000 MHz
*********************************/

// Ӳ�������У�������������������OLED, ����ͷ

/************************************************************/
#define MAIN_PROGRAM           //���������
//#define PINREAD_DEBUG        //�����������
//#define CLOCK_DEBUG          //ʱ�����Ų���
//#define CAMERA_DEBUG_7725  //OV7725����ͷ����
//#define CAMERA_DEBUG_7620    //OV7620����ͷ����
//#define C_DEBUG            //C�����﷨����
//#define DAQ_DEBUG          //DAQ����
//#define DMA_DEBUG          //DMA����
//#define BLUETOOTH_DEBUG    //��������
//#define SD_DEBUG            //SD������
//#define MOTOR_DEBUG           //�������
//#define SERVO_DEBUG           //�������
//#define QUAD_DEBUG            //����������
//#define DIFF_DEBUG             //���ٲ���
//#define VIRTURL_DEBUG         //����ʾ��������
//#define DEBUG_DEBUG             //ԭ�������������
//#define OLED_DEBUG               //OLEDר�Ų���
//#define FLASH_DEBUG               //FLASH����
//#define GYRO_DEBUG                //�����ǲ���
//#define LIGHTHOUSE_DEBUG                //��������

/************************************************************/
//#define ERROR_PIC

//=================================������================================
//���ŷ��䣺
//PORT     FUNCTION
//  A0     TCLK
//  A1     TDI
//  A2     TDO
//  A3     TMS
//  A8     ������FTM1_QD_PHA
//  A9     ������FTM1_QD_PHB
//  A10    ������FTM2_QD_PHA
//  A11    ������FTM2_QD_PHB
//  A12    ���FTM1_CH0
//  A25    SCCB_SDA
//  A26    SCCB_SCL
//  B0~B7  ����ͷ����
//  B9     PCLK
//  B16    UART0_RX
//  B17    UART0_TX
//  C8     HREF
//  C16    OLED_D0
//  C17    OLED_D1
//  C18    OLED_RST
//  C19    OLED_DC
//  D1     VSYNC
//  D4     ���FTM0_CH4����
//  D5     ���FTM0_CH5��
//  D6     ���FTM0_CH6����
//  D7     ���FTM0_CH7�ҷ�
//  E0~E5  ��ť�����İ��ϵ�����С��ť��
//  E6~E9  ���뿪ͷ
//  E26    ����ָʾ��

#ifdef MAIN_PROGRAM

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Debug.h"
#include "Flash.h"
#include "LQ12864.h"
#include "adc.h"
#include "Fuzzy.h"
#include "BatteryCheck.h"

//��ʱ����
void DLY_ms(word ms)
{                         
  word a;
  while(ms)
  {
    a=13350;
    while(a--);
    ms--;
  }
  return;
}
//������
  void main(void)
{
    uint8 flag;  //�������OLED�޸Ĳ����Ļ�������flag�ᱻ��λ
    uint32 tic1;
    uint32 tic2,tic3,tic4,tic5,tic6,tic7,tic8,tic9,tic10,tic11; //����һ��tic�ǵ���ʱ������ʱ��
    gpio_init(PORTD, 4, 1, 0);                                  //���ĸ��ǵ�����������
    gpio_init(PORTD, 5, 1, 0);
    gpio_init(PORTD, 6, 1, 0);
    gpio_init(PORTD, 7, 1, 0);
    
    DebugInit();            //OLED,FLASH,button,switch��ʼ�����������ʾ��Hello AE86��������ʼ�׶ο����ȹرգ�
    
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    //enableuartreint(UART0, 45);
    
    DisableInterrupts;                                    //�ر������ж�
    
    
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    light_control(PORTE, 26, Light_OFF);
    light_init(PORTD, 15, Light_ON);                      //��Ƭ������ָʾ��
    light_control(PORTD, 15, Light_OFF);
    
    pit_init(PIT0, 75000 * 5);                              //75000��Ϊ1ms��������5ms���ڱ�����
    //enable_pit_interrupt(PIT0);                         //��PIT0�ж�
    
    VariablesInit();      //���ֱ����ĳ�ʼ����ֵ
    ServoInit();          // ��ʼ�����
    
    QuadInit3();           //��ʼ������������ʼ�׶ο����ȹرգ�
    
    //ADC��ʼ�����ڵ�ص�ѹ��������ʼ�׶ο����ȹرգ�
    hw_adc_init(0);
    //��ص�ѹ������ʼ������ʼ�׶ο����ȹرգ�
    BatteryCheckInit();
    //�����ǳ�ʼ����������ʼ��Ư��ȡ������ʼ�׶ο����ȹرգ�
    GyroInit();
    
    
    while(!CameraInit())         //��ʼ������ͷ
    {
      uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
    }
    
    //DMAͨ��0�� DMA����ԴΪPORTB�� DMAԴ��ַΪB0~B7, DMAĿ�ĵ�ַΪImgStore1����
    while(!DMAInit(DMACH00, DMASOURCE_PORTB, CameraWidth, GPIOB_DIR_ADDR, (uint32)(ImgStore1[0])))
    {
      uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
    }
    
    
    //��������ȼ����õ���ȷ���д���֤============================
    //set_irq_priority(FIELD_IRQ, 2);
    //set_irq_priority(LINE_IRQ, 1);
    //set_irq_priority(DMA0_IRQ, 0);
    
    PORTD_ISFR = PORT_ISFR_ISF_MASK;       //�峡����PORT�ı�־λ
    PORTC_ISFR = PORT_ISFR_ISF_MASK;       //��������PORT�ı�־λ
    PORTB_ISFR = PORT_ISFR_ISF_MASK;       //��PCLK����PORT�ı�־λ
    disable_irq(LINE_IRQ);                 //�����ж�IRQ
    disable_irq(DMA0_IRQ);                 //��DMA��������ж�IRQ
    enable_irq(FIELD_IRQ);                //�����ж�IRQ
    
    ImgStatus = ImgGetStart;        //ͼ��ɼ���־λ��Ϊ��ʼ
    
    //��ʼ��ɨ�貦�뿪�ء�
    DebugSwitchScan();
    
    EnableInterrupts;                                     //�������ж� 
    flag = 0;                           //����OLED�޸Ĳ����󣬲���flag����λ

    //���뿪�ش򿪴�ͼ���ģʽ
    while(DebugSwitchFlag[3] == 1)
    {
      LCD_P8x16Str(12,3,"Send Image");
      while(ImgStatus != ImgGetFinish); //���ͼ��ɼ�δ��������һֱ�ȴ���
      disable_irq(LINE_IRQ);                 //�����ж�IRQ
      disable_irq(DMA0_IRQ);                 //��DMA��������ж�IRQ
      disable_irq(FIELD_IRQ);                //�س��ж�IRQ
      ImageSend();
      
      PORTD_ISFR = PORT_ISFR_ISF_MASK;       //�峡����PORT�ı�־λ
      PORTC_ISFR = PORT_ISFR_ISF_MASK;       //��������PORT�ı�־λ
      PORTB_ISFR = PORT_ISFR_ISF_MASK;       //��PCLK����PORT�ı�־λ
      disable_irq(LINE_IRQ);                 //�����ж�IRQ
      disable_irq(DMA0_IRQ);                 //��DMA��������ж�IRQ
      enable_irq(FIELD_IRQ);                //�����ж�IRQ
      ImgStatus = ImgGetStart;              //ͼ��ɼ���־λ��Ϊ��ʼ
    }
    //�����뿪��1����1��λ�ã���һֱ��OLED���Σ���������whileѭ���������ܳ���
    while(DebugSwitchFlag[1] == 1)
    {
      flag = 1;
      //16.64ms���յ㡣16.64ms��OV7620�ɼ�һ��ͼƬ��ʱ��
      //tic1 = temptic2;
      //temptic2 = PIT_CVAL(1);
      
      while(ImgStatus != ImgGetFinish); //���ͼ��ɼ�δ��������һֱ�ȴ���
      
      //16.64ms����㡣            
      ImgStatus = ImgGetStart;        //ͼ��ɼ���־λ��Ϊ��ʼ        
  
      //ʹ��OLEDʱ������ʹ�ñ������ɼ���ʱ�䲻����
      
      //tic2 = PIT_CVAL(1);
      //��ͼ����ɹ�����ƫ���ȡ�ɹ���������ж���͵���Ŀ��ƣ����򱣳�ԭ״��
      //���Ѿ�����ֱ�������⴦��Ҳ���Խ��ж���͵���Ŀ��ơ�
      if(ImagePro() == 1 || AngleSpeDealFlag == 1)          //ͼ����  
      {
       
      }
      else
      {
        
      }

      
      ServoPID();         //�������

      //tic3 = PIT_CVAL(1);
      //Debug���ԣ���1.���뿪��ɨ�裬2������ɨ�裬3��������Ϣ����4��OLED��ˢ�¡�����ʼ�׶ο����ȹرգ�
      DebugDebug();                 
      //toc3 = PIT_CVAL(1);
      
      //��ص�ѹ����
      BatteryCheckUpdate();
      
      //toc1 = PIT_CVAL(1);
    }
    
    
    //������A0ģʽ���뵽A1ģʽ����ִ�����в���������������
    if(flag == 1)
    {
      //��A0ģʽ����A1ģʽ��
      //A1ģʽ��־��
      //�ص�OLED��
      LCD_CLS();     
      //�����ĺ�����µ�ֵд��FLASH��
      FlashFinalWrite();
      LCD_P8x16Str(12,3,"Debug Succeed");
    }
    else
    {
      LCD_P8x16Str(12,3,"Start");
    }
    
    
 

    GyroInit();                 //��ʼ�������ǣ���ʼ�׶ο����ȹرգ�
    
    
    MotorInit_SYJ();          //��ʼ�������ע����1��2�ں��������������������ʹ�ܵģ�3��4�ڲ��ǿ��Ƶ���ٶȵ�PWM

    while(1)
    {
      //16.64ms���յ㡣
//      tic1 = PIT_CVAL(1)/75000;
      while(ImgStatus != ImgGetFinish) ; //���ͼ��ɼ�δ��������һֱ�ȴ���
//      tic2 = PIT_CVAL(1)/75000;
      
      //16.64ms����㡣            
      ImgStatus = ImgGetStart;        //ͼ��ɼ���־λ��Ϊ��ʼ        
      
      FTM2_CNT = 0;                            //���������㡣׼������10ms�ı������ٶ�ֵ�ɼ���
      QuadDoneFlag = 0;                        //��ǰ���ñ�־λ��0���Է�ImagePro()��ʱ����5ms�������
      
      
      PIT_TCTRL(PIT0) |= PIT_TCTRL_TEN_MASK;       //ʹ��pitģ������,��ʱPIT��������ʼ���������ڱ���������ʼ�׶ο����ȹرգ�
      enable_pit_interrupt(PIT0);                         //��PIT0�жϣ����ڱ���������ʼ�׶ο����ȹرգ�
      
//      tic3 = PIT_CVAL(1)/75000; 
      //��ͼ����ɹ�����ƫ���ȡ�ɹ���������ж���͵���Ŀ��ƣ����򱣳�ԭ״��
      //���Ѿ�����ֱ�������⴦��Ҳ���Խ��ж���͵���Ŀ��ơ�
      if(ImagePro() == 1 || AngleSpeDealFlag == 1)          //ͼ����  
      {
        GPIO_PDOR_REG(PORTC) |= (1<<0);
//        tic4 = PIT_CVAL(1)/75000; 
        while(QuadDoneFlag == 0) ;  //���������ٶȲɼ�δ��ɣ���һֱ�ȴ���    
        
//        tic5 = PIT_CVAL(1)/75000; 
      }
      else
      {
//        tic6 = PIT_CVAL(1)/75000; 
        GPIO_PDOR_REG(PORTC) &= ~(1<<0);
        //����ͼ����ʧ�ܣ�Ҳ�����10ms�Ժ���ȥ������ĵ�����ơ�
        while(QuadDoneFlag == 0) ;  //���������ٶȲɼ�δ��ɣ���һֱ�ȴ���
//        tic7 = PIT_CVAL(1)/75000; 
      }
      
      //toc4 = PIT_CVAL(1);
      
      
      //ʵʱ�ٶȻ�ȡ����ʼ�׶ο����ȹرգ�
      SpeedRealTimeGet();
        
//       tic8 = PIT_CVAL(1)/75000; 
       ServoPID();         //������� 
       //tic7 = PIT_CVAL(1);
//       tic9 = PIT_CVAL(1)/75000; 
       MotorPID();         //�������
//       tic10 = PIT_CVAL(1)/75000; 
       //toc7 = PIT_CVAL(1);
       
      //�����Ǵ���AD�ɼ�����־λ��������ʼ�׶ο����ȹرգ�
      GryoDeal();
      
      //��ص�ѹ����
      //BatteryCheckUpdate();
      
      //tic5 = temptic1;
      //temptic1 = PIT_CVAL(1);
      
      //����ʾ�������õ���FreeCars��
      Virtual2SendData();
//      tic11 = PIT_CVAL(1)/75000; 
      //toc5 = PIT_CVAL(1);
      
      //toc1 = PIT_CVAL(1);
      
    }  // end of while(1)



}      // end of main()
#endif // end of MAIN_PROGRAM



//==========================����ʱ�Ӳ���===========================
/*
����ʱ�Ӳ��Գɹ���2014.10.09
��myDAQ��PORTA10������Ƶ�ʾ��У�PIT���1msһ���жϣ����Ƶ��Ϊ500Hz
*/
#ifdef CLOCK_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"

void main(void)
{
    DisableInterrupts;                                    //�ر������ж�
    
    gpio_init(PORTA,10,1,0);                              //ʱ��������ų�ʼ��
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT0,75000);                                   //��ʼ��PIT1����Ϊ1ms*20*4   ���Լ�ؿ�������
    enable_pit_interrupt(PIT0);                         //��PIT1�ж�
    
    EnableInterrupts;                                     //�������ж�

    
    
    
    while(1)
    { 
      
      
    }  // end of while(1) 
}      // end of main()
#endif // end of CLOCK_DEBUG










//=======================================�������ڲ���===========================

//�������ڲ��Գɹ���2014.10.10
//ע��TX,RX��Ӧ�Ķ˿ڼ��ɣ�������ϵ�˿ӡ���׿���λ��


#ifdef  BLUETOOTH_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"

volatile uint8 BUFF[11] = {0};


void main(void)
{/*
    uint8 ch;
    
    uint8 first[] = {"\nDMA������ BUFF[10]={"};
    uint8 last[] = {"10}"};
    uint8 DMA_error[] = {"DMA��ʼ��ʧ��"};
    uint8 helloworld[] = {"Hello World!"};
   */ 
    //float a1 = 60000;
    //float a2 = 60000.3;
    //float a3 = 
    uint32 runcount;
    DisableInterrupts;                                    //�ر������ж�
    
    gpio_init(PORTA,6,1,0);                              //ʱ��������ų�ʼ��
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART4, periph_clk_khz, 115200);             //���ڳ�ʼ��
    //pit_init(PIT0,75000);                                   //��ʼ��PIT1����Ϊ1ms*20*4   ���Լ�ؿ�������
    //enable_pit_interrupt(PIT0);                         //��PIT1�ж�
    uart_sendN(UART4,(uint8*)"\nHello World!",13);
    EnableInterrupts;


    while(1)
    {
      //if(uart_re1(UART0, &ch))//�˴�Ӧ��uart_re1�����еļ���������ȥ��
      //{
        runcount++;
        if(runcount>=1000000)
        {
            light_change(PORTE, 26);//ָʾ�Ƶ�������״̬�л�
            uart_sendN(UART4,(uint8*)"\nHello World!",13);
            uart_sendN(UART4,(uint8*)"\n001",13);
            uart_sendN(UART4,(uint8*)"\n002",13);
            uart_sendN(UART4,(uint8*)"\n003",13);
            runcount=0;
        }
       //}// end of if���ճɹ�
    }  // end of while(1) 
}      // end of main()
#endif // end of BLUETOOTH_DEBUG























//============================DMA����=============================
/*
DMA���Գɹ���2014.10.10
�������ӣ�PTA8���ڲ�������������PTA7�ϵ�DMA��������3V3���ӵ�B0��B7�������ţ�
          ���Ӻô����������ô��ڵ������ַ������ַ���MCU�ϣ��Ϳ��Է���BUFF�����������һ�����ر仯��
�ؼ����ã��ر�DREQʱ��DMA0���жϷ������в���Ҫ�ٴ�ERQ��
          ��DREQʱ��DMA0���жϷ���������Ҫ�ֶ���ERQ.
          DLAST���-10����������ѭ���鿴��
          BITER��CITER�Լ�BUFF���ȶ����10��
          PTA7��ΪDMA����Դ��GPIO���룬��������(Ĭ������Ϊ0)���½��ش���DMA��
          PTB0~PTB7������Ϊ����ͷ�������룬�������衣
          PTA8���GPIO�����
*/
#ifdef DMA_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"

uint8 BUFF[11] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b};




void main(void)
{
    uint8 ch, chh;
    uint32 i;
    uint8 first[] = {"\nDMA������ BUFF[10]={"};
    uint8 last[] = {"10}"};
    uint8 DMA_error[] = {"DMA��ʼ��ʧ��"};
    
    DisableInterrupts;                                    //�ر������ж�
    
    gpio_init(PORTA,6,1,0);                              //ʱ��������ų�ʼ��
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 9600);             //���ڳ�ʼ��
    //pit_init(PIT0,75000);                                   //��ʼ��PIT1����Ϊ1ms*20*4   ���Լ�ؿ�������
    //enable_pit_interrupt(PIT0);                         //��PIT1�ж�
    
    
    
    //DMA�������� �� ������������ ����
    DMAPORTInit();
    
    if(!DMAInit(DMACH00, DMASOURCE_PORTA, GPIOB_DIR_ADDR, (uint32)BUFF))
    {
      while(1)
      {
      uart_sendN(UART0, DMA_error, sizeof(DMA_error));     
      }
    }
    
    enable_DMA_irq(DMACH00);              //����DMAͨ��0��IRQ�ж�
    
    EnableInterrupts;                                     //�������ж�
    
    DMA_ERQ |= (1 << 0);                            //��DMAӲ������ʹ��


    while(1)
    {
      if(uart_re1(UART0, &ch))            //�˴�Ӧ��uart_re1�����еļ���������ȥ��
      {
      gpio_reverse(PORTA, 8);
      for(i=0;i<150000;i++)
      {
        asm("nop");  
      }
      gpio_reverse(PORTA, 8);
      
      uart_sendN(UART0, (uint8 *)"Hello World!", 12);
      for(i = 0; i <= 10; i++)
      {
        chh = BUFF[i];
        uart_send1(UART0, chh);
      }
  
      

      
      
      
      }// end of if���ճɹ�
    }  // end of while(1) 
}      // end of main()
#endif // end of DMA_DEBUG





//=======================���������ȡ����==============================
//GPIO����������Գɹ���2014.10.12
//1. �ò�����PA15Ϊ�������ţ�PA17��PC0Ϊ������ţ����ӵ�������ϵ������ƣ���
//   ��PA15��⵽�͵�ƽʱ��PA17��PC0����PA15��⵽�ߵ�ƽ���෴��
//2. ʵ�ʲ���ʱ���֣������ʹ�����������裨©����·��Ӱ�죩����GPIO����ģʽʱ��Ĭ�ϼ�⵽���ǵ͵�ƽ��
//   �Ҹ����������ⲿ�ø߻��õ�ʱ��������״̬��һֱ���ֵ���һ���ⲿ�ı䡣
//3. ʵ�ʲ���ʱ���֣����ʹ�����������裨©����·��Ӱ�죩����GPIO����ģʽʱ��Ĭ�ϼ�⵽���ǵ͵�ƽ��
//   ��������������ⲿ�øߺ�ѶŰ����õ���������״̬���Զ���Ϊ�͵�ƽ������һ������⣬��ȷ��������������á�
//   Ҳ����˵�����ⲿ����ʱ��GPIO��������������Ѹ�����״̬�õ͡�
//3. PORTPCR�Ĵ�������GPIO�Ĵ���ǰ���ó�MUX(1)�������ó�GPIOģʽ����ʱĬ��ΪGPIO���룩��
//4. GPIO�ķ������ֵ������ֵ�Ͱ������������д�����׶���
//                                                         --HJZ
#ifdef PINREAD_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"



void main(void)
{	
	//��������GPIO�ڵ�ת��ʱ��
	SIM_SCGC5 = SIM_SCGC5_PORTA_MASK | SIM_SCGC5_PORTB_MASK | SIM_SCGC5_PORTC_MASK | SIM_SCGC5_PORTD_MASK | SIM_SCGC5_PORTE_MASK;
	
        //��������PA15�ĳ�ʼ����GPIO���룬©����·����������
        PORT_PCR_REG(PORTA_BASE_PTR, 15) |= ( 0
                                  |  PORT_PCR_MUX(0x01) 
                                  | PORT_PCR_PE_MASK 
                                  | PORT_PCR_ODE_MASK
                                  );
        GPIO_PDDR_REG(PTA_BASE_PTR) |= (1 << 15);
        GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
        GPIO_PDDR_REG(PTA_BASE_PTR) &= ~(1 << 15);

        //��������PA17��PC0�ĳ�ʼ����GPIO���
	PORTA_PCR17 |= (0 | PORT_PCR_MUX(1));         
        PORTC_PCR0 |= (0 | PORT_PCR_MUX(1));
        
        GPIO_PDDR_REG(PTC_BASE_PTR) |= (1 << 0);
        GPIO_PDOR_REG(PTC_BASE_PTR) &= ~(1 << 0);
	
	GPIO_PDDR_REG(PTA_BASE_PTR) |= (1 << 17);
	GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 17);   
        
	for(;;)  
	{	//��⵽�ߵ�ƽ��PA17����PC0��   	
		if( GPIO_PDIR_REG(PTA_BASE_PTR) & (1 << 15) )
		{
		    GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 17);
                    GPIO_PDOR_REG(PTC_BASE_PTR) |= (1 << 0);	
		}
                //��⵽�͵�ƽ��PA17��PC0��   
		else
                {		
                    GPIO_PDOR_REG(PTC_BASE_PTR) &= ~(1 << 0);
                    GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 17);		
		}	 
	}
	
}

#endif // end of PINREAD_DEBUG








//=========================DAQ�ı��ز�׽����============================
#ifdef DAQ_DEBUG

#include "MK60N512VMD100.h"
#include "gpio.h"

void Delay(volatile uint16 time)
{
    while(time)
    {
        time--;  
    }
}


void main(void)
{
  
  SIM_SCGC5 |= (SIM_SCGC5_PORTA_MASK | SIM_SCGC5_PORTB_MASK | SIM_SCGC5_PORTC_MASK | SIM_SCGC5_PORTD_MASK | SIM_SCGC5_PORTE_MASK);
  
  gpio_init(PORTA, 14, 1, 1);
  gpio_init(PORTA, 15, 1, 1);
  //PORTA_PCR15 |= (0 | PORT_PCR_MUX(1));
  
  
  //PORTA_PCR14 |= PORT_PCR_DSE_MASK;
 //PORTA_PCR15 |= PORT_PCR_DSE_MASK;
  
  

  GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 14); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 15); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 14);   
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
  Delay(1000);
  
    GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 14); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 15); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 14);   
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
  Delay(1000);

  
    GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 14); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) |= (1 << 15); 
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 14);   
  Delay(1000);
  
  GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 15);
  Delay(1000);


  
  while(1) ; 

}

#endif // end of DAQ_DEBUG



//=======================��������������==================================
#ifdef BT_SET

#include "sysinit.h"
#include "common.h"
#include "gpio.h"
#include "uart.h"
#include "light.h"

void main(void)
{
    //uint8 cmd[] = {"AT+BAUD8\r"};
    uint8 cmd[] = {"\nHello World!"};
    uint32 runcount = 0;
    DisableInterrupts;                                    //�ر������ж�
    
    gpio_init(PORTA,10,1,0);                              //ʱ��������ų�ʼ��
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 9600);             //���ڳ�ʼ��

    EnableInterrupts;
    while(1)
    {

        runcount++;
        if(runcount>=1000000)
        {
            light_change(PORTE, 26);//ָʾ�Ƶ�������״̬�л�
            uart_sendN(UART0, cmd, sizeof(cmd));
            runcount=0;
        }
      
    }



} // end of main

#endif // end of BT_SET







//========================OV7725����ͷ����================================
#ifdef CAMERA_DEBUG_7725

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"

void main(void)
{
    DisableInterrupts;                                    //�ر������ж�
    
    gpio_init(PORTA,10,1,0);                              //ʱ��������ų�ʼ��
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT0,75000);                                   //��ʼ��PIT1����Ϊ1ms*20*4   ���Լ�ؿ�������
    //enable_pit_interrupt(PIT0);                         //��PIT1�ж�

    while(!CameraInit())         //��ʼ������ͷ
    {
      uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
    }
    
    while(!DMAInit(DMACH00, DMASOURCE_PORTA, CameraDMACount, GPIOB_DIR_ADDR, (uint32)ImgStore))
    {
      uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
    }
    
    //��ֹӲ������ERQ
    DMA_ERQ &= ~(1 << 0);
    //��PTA�ж�
    disable_irq(PORTA_IRQ);
    //��DMAINT��־λ
    DMA_INT |= (1 << 0);
    //��DMA��IRQ
    enable_irq(DMA0_IRQ);

    EnableInterrupts;                                     //�������ж�
    while(1)
    {
      ImageGet();        //ͼ���ȡ
      ImagePro();        //ͼ����
      //SendImg();  
      
    }  // end of while(1)
}      // end of main()



#endif  //end of CAMERA_DEBUG_7725









//==========================OV7620����ͷ����==================================
//���ŷ��䣺
//PORT     FUNCTION
//  A0     TCLK
//  A1     TDI
//  A2     TDO
//  A3     TMS
//  A8     ������FTM1_QD_PHA
//  A9     ������FTM1_QD_PHB
//  A10    ������FTM2_QD_PHA
//  A11    ������FTM2_QD_PHB
//  A12    ���FTM1_CH0
//  A25    SCCB_SDA
//  A26    SCCB_SCL
//  B0~B7  ����ͷ����
//  B9     PCLK
//  B16    UART0_RX
//  B17    UART0_TX
//  C8     HREF
//  C16    OLED_D0
//  C17    OLED_D1
//  C18    OLED_RST
//  C19    OLED_DC
//  D1     VSYNC
//  D4     ���FTM0_CH4����
//  D5     ���FTM0_CH5��
//  D6     ���FTM0_CH6����
//  D7     ���FTM0_CH7�ҷ�
//  E0~E5  ��ť�����İ��ϵ�����С��ť��
//  E6~E9  ���뿪ͷ
//  E26    ����ָʾ��

#ifdef CAMERA_DEBUG_7620

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"

void main(void)
{
    DisableInterrupts;                                    //�ر������ж�
    
    gpio_init(PORTA,10,1,0);                              //ʱ��������ų�ʼ��
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT0,75000);                                   //��ʼ��PIT1����Ϊ1ms*20*4   ���Լ�ؿ�������
    //enable_pit_interrupt(PIT0);                         //��PIT1�ж�

    while(!CameraInit())         //��ʼ������ͷ
    {
      uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
    }
    
    //DMAͨ��0�� DMA����ԴΪPORTB�� DMAԴ��ַΪB0~B7, DMAĿ�ĵ�ַΪImgStore1����
    while(!DMAInit(DMACH00, DMASOURCE_PORTB, CameraWidth, GPIOB_DIR_ADDR, (uint32)(ImgStore1[0])))
    {
      uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
    }
    
    //��������ȼ����õ���ȷ���д���֤============================
    //set_irq_priority(FIELD_IRQ, 2);
    //set_irq_priority(LINE_IRQ, 1);
    //set_irq_priority(DMA0_IRQ, 0);
    
    PORTD_ISFR = PORT_ISFR_ISF_MASK;       //�峡����PORT�ı�־λ
    PORTC_ISFR = PORT_ISFR_ISF_MASK;       //��������PORT�ı�־λ
    PORTB_ISFR = PORT_ISFR_ISF_MASK;       //��PCLK����PORT�ı�־λ
    disable_irq(LINE_IRQ);                 //�����ж�IRQ
    disable_irq(DMA0_IRQ);                 //��DMA��������ж�IRQ
    enable_irq(FIELD_IRQ);                //�����ж�IRQ
    
    EnableInterrupts;                                     //�������ж�
    ImgStatus = ImgGetStart;        //ͼ��ɼ���־λ��Ϊ��ʼ


    while(1)
    {
      while(ImgStatus != ImgGetFinish) ; //���ͼ��ɼ�δ��������һֱ�ȴ���
      ImgStatus = ImgGetStart;        //ͼ��ɼ���־λ��Ϊ��ʼ
      
      
      ImageProSend();        //ͼ����
      //SendImg();  
      
    }  // end of while(1)
}      // end of main()



#endif // end of CAMERA_DEBUG_7620



//==========================C�����﷨����==================================
#ifdef C_DEBUG

#include "common.h"
#include "sysinit.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "math.h"

void main(void)
{
    uint8 i, j, k;
    uint8 x, y;
    uint8 temp1, temp2, temp3, temp4, temp5, temp6, temp7;
    int8 x1;
    int8 x2;
    int16 x3;
   
    
    i = 200;
    j = 100;
    k = 250;
    if((i + j) > k)
    {
      temp1 = 1;  
    }
    else
    {
      temp1 = 0;  
    }
    
    if((j - i) < 0)
    {
      temp2 = 1; 
    }
    else
    {
      temp2 = 0;  
    }
    
    x = i + j;
    if(x > k)
    {
      temp3 = 1;
    }
    else
    {
      temp3 = 0;
    }
    
    y = j - i;
    if(y < 0)
    {
      temp4 = 1;
    }
    else
    {
      temp4 = 0;  
    }
    
    
    
    x1 = (int8)(j - i);
    if(x1 < 0)
    {
      temp5 = 1;
    }
    else
    {
      temp5 = 0;  
    } 
    
    x2 = -1;
    if(x2 < 0)
      temp6 = 1;
    else
      temp6 = 0;
    
    x3 = -1;
    if(x3 < 0)
      temp7 = 1;
    else
      temp7 = 0;    
   
    
    while(1)
    {
    }
}

#endif // end of C_DEBUG
//==========================================================================






//==============================SD������====================================
#ifdef SD_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"

#include "diskio.h"
#include "ff.h"
#include "ffconf.h"
#include "integer.h"
#include "myprintp.h"
#include "sd_driver.h"
#include "spi.h"
#include "SD.h"
#include "sdhc.h"

#include "ctype.h"
#include "stdarg.h"
#include "ycheck.h"
#include "yvals.h"


#define BUFF_SIZE   100
void main()
{   
 FIL fdst;  //�ļ�
    FATFS fs;  //�ļ�ϵͳ

    uint32 size, sizetmp;
    int res;
    char *str = "��л��ѡ�� Ұ��Kinetis������ ��^_^ ";
    uint8 buff[BUFF_SIZE];

    for(size = 0; size < BUFF_SIZE; size++)buff[size] = 0;

    f_mount(0, &fs);		                                                       //SD��ϵͳ��ʼ��

    res = f_open(&fdst, "0:/FireDemo.txt", FA_OPEN_ALWAYS | FA_WRITE | FA_READ);  //���ļ������û�оʹ���������д��

    if( res == FR_DISK_ERR)
    {
        printf( "\nû����SD������\n" );
        return;
    }
    else if ( res == FR_OK )
    {
        printf( "\n�ļ��򿪳ɹ� \n" );
    }
    else
    {
        printf("\n����ֵ�쳣");
    }


    f_puts(str, &fdst);                     //���ļ���д���ַ���

    size = f_size(&fdst);                   //��ȡ�ļ��Ĵ�С

    printf( "\n�ļ���СΪ��%d \n" , size);  //���ڴ�ӡ�ļ��Ĵ�С

    if(size > BUFF_SIZE)size = BUFF_SIZE;   //��ֹ���

    f_lseek(&fdst, 0);                      //��ָ��ָ���ļ�����
    f_read (&fdst, buff, size, (UINT *)&sizetmp);   //��ȡ


    printf("�ļ�����Ϊ��%s", (char const *)buff);

    f_close(&fdst);                         //�ر��ļ�
     
  
    
}


/*
struct WSNSTATE  //??,???????
{
unsigned diskok:1; //???????????????BIT0    0:??????????   1:???????
unsigned fileok:1; //?????????BIT1                0:??????????? 1:??????
unsigned record:1; //
unsigned position:1; //
};

volatile struct WSNSTATE state; //????
FATFS fs;            // Work area (file system object) for logical drive
FRESULT res;         // FatFs function common result code
UINT br,bw;         // File Write count

FIL testdata;  //???????
FILINFO* sfil;

unsigned char filebuff[720]={0}; //????
volatile unsigned int filebuffoffset=0;
unsigned char read_buff[512];
unsigned char receivebuff[512];
unsigned char test_buff[64];

void init_disk_fatfs(void)   //??????????,???state.diskok==1;
{
	if(state.diskok==0)  //???????? 
	{
		if(disk_initialize(0))
		{
			state.diskok=0;
		}
		else
		{	
			res = f_mount(0,&fs);      // ?????????for logical drive 0
//			SCI0_putchar(res);
			state.diskok=1;
		}
	}
}

void uart0_send1 (int8 ch)
{
    //�ȴ����ͻ�������
    while(!(UART_S1_REG(UART0) & UART_S1_TDRE_MASK));
    //��������
    UART_D_REG(UART0) = (int8)ch;
}


void main(void)
{
    unsigned char r;
    unsigned int i,n;
    unsigned char kkk;
    signed char namebuf[7];
    unsigned char tmp0,tmp1;
    FRESULT rc; 
    
    PRINT_T Print;
    
    uart_init(UART0, periph_clk_khz, 115200);
    Print.m_printf = uart0_send1;	
    Print_Init(&Print);
    
    SPI_Configuration();
    printp("\nUartInit is ok!\n");
   
    
    init_disk_fatfs();
    if(state.diskok)printp("\ninit_disk is ok!\n");
 
    //EnableInterrupts;
    for(i=0;i<=256;i++)
    {
        filebuffoffset++;
        filebuff[i]='s';
    }
    
        rc =f_open(&testdata,"0:/data1.txt",FA_CREATE_ALWAYS|FA_WRITE);
     if(FR_OK == rc)printp("\nf_open is ok\n");
    
    rc = f_write(&testdata,filebuff,filebuffoffset,&bw);
    if(FR_OK == rc)printp("\nf_write is ok!\n");
    rc = f_close(&testdata);  
    if(FR_OK == rc)
    printp("\ncreat single file is ok\n");
    printp("%dbytes",f_size(&testdata));
  
  while(1)
  {
    
    
  }    // end of while(1)  
}      // end of main()
*/



#endif // end of SD_DEBUG
//==========================================================================





//==========================�������==================================
//���ŷ��䣺
//PORT     FUNCTION
//  A0     TCLK
//  A1     TDI
//  A2     TDO
//  A3     TMS
//  A8     ������FTM1_QD_PHA
//  A9     ������FTM1_QD_PHB
//  A10    ������FTM2_QD_PHA
//  A11    ������FTM2_QD_PHB
//  A12    ���FTM1_CH0
//  A25    SCCB_SDA
//  A26    SCCB_SCL
//  B0~B7  ����ͷ����
//  B9     PCLK
//  B16    UART0_RX
//  B17    UART0_TX
//  C8     HREF
//  C16    OLED_D0
//  C17    OLED_D1
//  C18    OLED_RST
//  C19    OLED_DC
//  D1     VSYNC
//  D4     ���FTM0_CH4����
//  D5     ���FTM0_CH5��
//  D6     ���FTM0_CH6����
//  D7     ���FTM0_CH7�ҷ�
//  E0~E5  ��ť�����İ��ϵ�����С��ť��
//  E6~E9  ���뿪ͷ
//  E26    ����ָʾ��

#ifdef MOTOR_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "VirtualScope.h"

void main(void)
{
    DisableInterrupts;                                    //�ر������ж�
    
    gpio_init(PORTA,10,1,0);                              //ʱ��������ų�ʼ��
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT0,75000);                                   //��ʼ��PIT1����Ϊ1ms*20*4   ���Լ�ؿ�������
    //enable_pit_interrupt(PIT0);                         //��PIT1�ж�
    
    EnableInterrupts;
    
    MotorInit_SYJ();
     FTM0_C4V = 0;         //���� the pulse width(duty cycle) is determined by (CnV - CNTIN).
     FTM0_C5V = 100;
      FTM0_C6V = 100;    
      FTM0_C7V = 0;
    while(1)
    {
      Virtual2SendData();
      //uart_sendN(UART0, (uint8 *)"\nHello Motor!", 13);
    }  // end of while(1) 
        
}      // end of main()
#endif // end of MOTOR_DEBUG




//==========================�������==================================
//���ŷ��䣺
//PORT     FUNCTION
//  A0     TCLK
//  A1     TDI
//  A2     TDO
//  A3     TMS
//  A8     ������FTM1_QD_PHA
//  A9     ������FTM1_QD_PHB
//  A10    ������FTM2_QD_PHA
//  A11    ������FTM2_QD_PHB
//  A12    ���FTM1_CH0
//  A25    SCCB_SDA
//  A26    SCCB_SCL
//  B0~B7  ����ͷ����
//  B9     PCLK
//  B16    UART0_RX
//  B17    UART0_TX
//  C8     HREF
//  C16    OLED_D0
//  C17    OLED_D1
//  C18    OLED_RST
//  C19    OLED_DC
//  D1     VSYNC
//  D4     ���FTM0_CH4����
//  D5     ���FTM0_CH5��
//  D6     ���FTM0_CH6����
//  D7     ���FTM0_CH7�ҷ�
//  E0~E5  ��ť�����İ��ϵ�����С��ť��
//  E6~E9  ���뿪ͷ
//  E26    ����ָʾ��

#ifdef SERVO_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"


void main(void)
{
    //int i, j;
    DisableInterrupts;                                    //�ر������ж�
    
    gpio_init(PORTA,10,1,0);                              //ʱ��������ų�ʼ��
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT0,75000);                                   //��ʼ��PIT1����Ϊ1ms*20*4   ���Լ�ؿ�������
    //enable_pit_interrupt(PIT0);                         //��PIT1�ж�
    
    EnableInterrupts;
    
    ServoInit();
    while(1)
    {
      
      FTM1_C0V = 1350;
      //FTM1_C0V = 1310;
      /*for(i = 0; i < 10000; i++)
        for(j = 0; j < 10000; j++)
        {}
      FTM1_C0V = 1810;
      for(i = 0; i < 10000; i++)
        for(j = 0; j < 10000; j++)
        {}
      FTM1_C0V = 2039;
      for(i = 0; i < 10000; i++)
        for(j = 0; j < 10000; j++)
        {}
      */
      uart_sendN(UART0, (uint8 *)"\nHello Servo!", 13);
    }  // end of while(1)   
}      // end of main()
#endif // end of SERVO_DEBUG
  
 
  
//==========================����ʾ��������===========================
#ifdef VIRTURL_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"  
#include "VirtualScope.h"


void main(void)
{
    uint8 t1 = 0;
    uint8 t2 = 125;
    DisableInterrupts;                                    //�ر������ж�
    
    gpio_init(PORTA,10,1,0);                              //ʱ��������ų�ʼ��
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT0,75000);                                   //��ʼ��PIT1����Ϊ1ms*20*4   ���Լ�ؿ�������
    //enable_pit_interrupt(PIT0);                         //��PIT1�ж�
    
    EnableInterrupts;
    
    
    while(1)
    {
      t1++;
      t2++;
      Virtual2DataPush(0, t1);
      Virtual2DataPush(1, t2);
      Virtual2DataPush(15, t1);
      Virtual2Send();
      //VirtualScopeSend();     
    }  // end of while(1) 
}      // end of main
#endif // end of VIRTURL_DEBUG




//================================����������=================================
#ifdef QUAD_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"  
#include "Ftm.h"
#include "VirtualScope.h"

void main(void)
{
    DisableInterrupts;                                    //�ر������ж�
    
    gpio_init(PORTA,17,1,0);                              //ʱ��������ų�ʼ��
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT0,75000*5);                                   //��ʼ��PIT0����,75000��1ms.
    enable_pit_interrupt(PIT0);                         //��PIT0�ж�
    
    EnableInterrupts;
    
    MotorInit();                //�����ʼ������
    QuadInit3();                //3�߱�������ʼ������
    while(1)
    {
      Virtual2SendData();
      //VirtualScopeSend();     
    }  // end of while(1) 
}      // end of main
#endif // end of QUAD_DEBUG



//================================���ٲ���=================================
#ifdef DIFF_DEBUG

#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"  
#include "Ftm.h"
#include "VirtualScope.h"

void main(void)
{
    uint32 temptic1;
  
    DisableInterrupts;                                    //�ر������ж�
    
    //gpio_init(PORTA,17,1,0);                              //ʱ��������ų�ʼ��
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT0,75000*5);                                   //��ʼ��PIT0����,75000��1ms.
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478��ʾ17ms������Զ���ڸ�ֵ����tictoc�����塣
    enable_pit_interrupt(PIT0);                         //��PIT0�ж�
    
    //MotorInit();                //�����ʼ������
    QuadInit3();                //3�߱�������ʼ������
    ServoInit();
    //MotorInit();
    
    EnableInterrupts;
    

    while(1)
    {
      tic1 = temptic1;
      temptic1 = PIT_CVAL(1);
      
      FTM2_CNT = 0;                            //���������㡣׼������10ms�ı������ٶ�ֵ�ɼ���
      QuadDoneFlag = 0;                        //��ǰ���ñ�־λ��0���Է�ImagePro()��ʱ����5ms�������
      
      PIT_TCTRL(PIT0) |= PIT_TCTRL_TEN_MASK;       //ʹ��pitģ������,��ʱPIT��������ʼ������
      enable_pit_interrupt(PIT0);                         //��PIT0�ж�
      
      while(QuadDoneFlag == 0) ;  //���������ٶȲɼ�δ��ɣ���һֱ�ȴ���
      
      
      gpio_init(PORTA,17,1,0);
      
      Virtual2SendData();
      
      toc1 = PIT_CVAL(1);
    }  // end of while(1) 
}      // end of main
#endif // end of DIFF_DEBUG


//================================DEBUG����================================
#ifdef DEBUG_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Flash.h"
#include "LQ12864.h"
#include "Debug.h"

void main(void)
{
    //uint8 flag;
    DisableInterrupts;                                    //�ر������ж�
    
    gpio_init(PORTA,17,1,1);                              //ʱ��������ų�ʼ��
    gpio_init(PORTC, 0,1,1);
    gpio_init(PORTD,15,1,1);
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478��ʾ17ms������Զ���ڸ�ֵ����tictoc�����塣
    pit_init(PIT0, 75000*5);                              //75000��Ϊ1ms
    //enable_pit_interrupt(PIT0);                         //��PIT0�ж�
    
    MotorInit();          //��ʼ�����
    ServoInit();          // ��ʼ�����
    QuadInit3();           //��ʼ��������
    //OLEDInit();           //��ʼ��OLED
    //CameraInit();         //��ʼ������ͷ
    
    while(!CameraInit())         //��ʼ������ͷ
    {
      uart_sendN(UART0, (uint8 *)"\nCamera Initial Failed!", 23);  
    }
    
    //DMAͨ��0�� DMA����ԴΪPORTB�� DMAԴ��ַΪB0~B7, DMAĿ�ĵ�ַΪImgStore1����
    while(!DMAInit(DMACH00, DMASOURCE_PORTB, CameraWidth, GPIOB_DIR_ADDR, (uint32)(ImgStore1[0])))
    {
      uart_sendN(UART0, (uint8 *)"\nDMA Initial Failed!", 20);     
    }
    
    //��������ȼ����õ���ȷ���д���֤============================
    //set_irq_priority(FIELD_IRQ, 2);
    //set_irq_priority(LINE_IRQ, 1);
    //set_irq_priority(DMA0_IRQ, 0);
    
    PORTD_ISFR = PORT_ISFR_ISF_MASK;       //�峡����PORT�ı�־λ
    PORTC_ISFR = PORT_ISFR_ISF_MASK;       //��������PORT�ı�־λ
    PORTB_ISFR = PORT_ISFR_ISF_MASK;       //��PCLK����PORT�ı�־λ
    disable_irq(LINE_IRQ);                 //�����ж�IRQ
    disable_irq(DMA0_IRQ);                 //��DMA��������ж�IRQ
    enable_irq(FIELD_IRQ);                //�����ж�IRQ
    
    ImgStatus = ImgGetStart;        //ͼ��ɼ���־λ��Ϊ��ʼ
    EnableInterrupts;                                     //�������ж�
    
    while(1)
    {
      //16.64ms���յ㡣
      tic1 = PIT_CVAL(1);
      while(ImgStatus != ImgGetFinish) ; //���ͼ��ɼ�δ��������һֱ�ȴ���
      
      //16.64ms����㡣            
      ImgStatus = ImgGetStart;        //ͼ��ɼ���־λ��Ϊ��ʼ        

      FTM2_CNT = 0;                            //���������㡣׼������10ms�ı������ٶ�ֵ�ɼ���
      QuadDoneFlag = 0;                        //��ǰ���ñ�־λ��0���Է�ImagePro()��ʱ����5ms�������
      
      PIT_TCTRL(PIT0) |= PIT_TCTRL_TEN_MASK;       //ʹ��pitģ������,��ʱPIT��������ʼ������
      enable_pit_interrupt(PIT0);                         //��PIT0�ж�
      
      tic2 = PIT_CVAL(1);
      //��ͼ����ɹ�����ƫ���ȡ�ɹ���������ж���͵���Ŀ��ƣ����򱣳�ԭ״��
      //���Ѿ�����ֱ�������⴦��Ҳ���Խ��ж���͵���Ŀ��ơ�
      if(ImagePro() == 1 || AngleSpeDealFlag == 1)          //ͼ����  
      {
        //QuadInit3();           //��ʼ��������
        toc2 = PIT_CVAL(1);
        while(QuadDoneFlag == 0) ;  //���������ٶȲɼ�δ��ɣ���һֱ�ȴ���
        
        
        tic3 = PIT_CVAL(1); 
        ServoPID();         //�������
        MotorPID();         //�������
        toc3 = PIT_CVAL(1);
      }
      
      toc1 = PIT_CVAL(1);
      //VirtualScopeSend();
      Virtual2SendData();
      
      
      
    }  // end of while(1)
}      // end of main()
#endif // end of DEBUG_DEBUG


//=================================OLED����================================
#ifdef OLED_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Debug.h"
#include "Flash.h"
#include "LQ12864.h"

void main(void)
{
    uint16 temp = 359;
    uint8 temp1[4] = {0, 0, 0, 0};
    uint32 tempcount = 0;
  
    DisableInterrupts;                                    //�ر������ж�
        
    gpio_init(PORTA,17,1,1);                              
    gpio_init(PORTC, 0,1,1);
    gpio_init(PORTD,15,1,1);
    gpio_init(PORTE,26,1,1);
    //light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478��ʾ17ms������Զ���ڸ�ֵ����tictoc�����塣
    pit_init(PIT0, 75000);                              //75000��Ϊ1ms
    enable_pit_interrupt(PIT0);
    
    //�����һ����������ʼ����Ϊ�˰�FTM2ģ���ʼ��һ�£���ΪPIT0_ISR����ȡFTM2_CNT�Ĵ�����ֵ��
    //�������ʼ����ȡֵ��ʱ������ȥ��һֱ�����Ƕ���
    QuadInit3();
    
    DebugInit();
    
    //��Ҫ��PIT0_ISR�����򻯡���Ȼ������������
    
    temp1[0] = temp / 100 + 48;
    temp1[1] = (temp % 100) / 10 + 48;
    temp1[2] = (temp % 10) / 1 + 48;
    LCD_P6x8Str(0, 0, "S0");
    LCD_P6x8Str(0, 1, "S1");
    LCD_P6x8Str(0, 2, "S2");
    LCD_P6x8Str(0, 3, "S3");
    
    LCD_P6x8Str(64, 0, "B0");
    LCD_P6x8Str(64, 1, "B1");
    LCD_P6x8Str(64, 2, "B2");
    LCD_P6x8Str(64, 3, "B3");
    LCD_P6x8Str(64, 4, "B4");
    LCD_P6x8Str(64, 5, "B5");    
    
    //gpio_ctrl(PORTC, 0,0);
    //gpio_ctrl(PORTD, 15,0);
    gpio_ctrl(PORTA, 17,0);
    EnableInterrupts;                                     //�������ж�  
    
    while(1)
    {
      gpio_ctrl(PORTD, 15,0);
      tempcount++;
      if(tempcount > 1000)
      {
        tempcount = 0;
        //DisableInterrupts;
        
        //////////ʵ�ְ���ĳ�������߲�һ��ĳ�����뿪�أ���ĳ��������
        //�жϺ����᲻���LCD������Ӱ�죿
        DebugSwitchScan();
        
         
        //���뿪��ֵ��ʾ��
        if(DebugSwitchFlag[0] == 1)
        {
          LCD_P6x8Str(18, 0, "1");
        }
        else
        {
          LCD_P6x8Str(18, 0, "0");
        }
        
        if(DebugSwitchFlag[1] == 1)
        {
          LCD_P6x8Str(18, 1, "1");
        }
        else
        {
          LCD_P6x8Str(18, 1, "0");
        }      
        
        if(DebugSwitchFlag[2] == 1)
        {
          LCD_P6x8Str(18, 2, "1");
        }
        else
        {
          LCD_P6x8Str(18, 2, "0");
        }
        
        if(DebugSwitchFlag[3] == 1)
        {
          LCD_P6x8Str(18, 3, "1");
        }
        else
        {
          LCD_P6x8Str(18, 3, "0");
        }
        
        
        if(DebugButtonScan() == 1)
        {
        //����ֵ��ʾ��
        if(DebugButtonFlag[0] == 1)
        {
            LCD_P6x8Str(82, 0, "1");
          }
          else
          {
            LCD_P6x8Str(82, 0, "0");
          }      
    
          if(DebugButtonFlag[1] == 1)
          {
            LCD_P6x8Str(82, 1, "1");
          }
          else
          {
            LCD_P6x8Str(82, 1, "0");
          }            
          
          if(DebugButtonFlag[2] == 1)
          {
            LCD_P6x8Str(82, 2, "1");
          }
          else
          {
            LCD_P6x8Str(82, 2, "0");
          }      
          
          if(DebugButtonFlag[3] == 1)
          {
            LCD_P6x8Str(82, 3, "1");
          }
          else
          {
            LCD_P6x8Str(82, 3, "0");
          }            
          
          if(DebugButtonFlag[4] == 1)
          {
            LCD_P6x8Str(82, 4, "1");
          }
          else
          {
            LCD_P6x8Str(82, 4, "0");
          }      
    
          if(DebugButtonFlag[5] == 1)
          {
            LCD_P6x8Str(82, 5, "1");
          }
          else
          {
            LCD_P6x8Str(82, 5, "0");
          }      
        }
        
        //EnableInterrupts;
      }
      
    }  // end of while(1)
}      // end of main()
#endif // end of OLED_DEBUG



//=================================FLASH����================================
#ifdef FLASH_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Debug.h"
#include "Flash.h"
#include "LQ12864.h"

void main(void)
{
    uint8 *pointeruint8;         //uint8�����ݵ�ָ�롣
  
    uint8 i;
  /* uint32 temp[60] = {//0,10,20, 30, 40, 50, 60, 70, 80, 90,150
                       0,165,180,205,215,235,240,229,225,211,211,   //11�����Pֵ��
                       130,140,110,120,   //4��ͼ��ؼ���ֵ��
                       10, 20, 25, 20, //���е�0��-0
                       20, 25, 22, 15, //���е�1��-10
                       24, 30, 19, 11, //���е�2��-20
                       29, 38, 17, 8, //���е�3��-30
                       32, 38, 15, 7,  //���е�4��-40
                       35, 45, 13, 5, //���е�5��-50
                       37, 55, 12, 3, //���е�6��-60
                       40, 60, 12, 0,  //���е�7��-60+
                        480,             //��ʱ��ʱ�䣬0.1sΪ��λ��
                        35,         //���P
                        80         //���D
                      };*/
      uint32 temp[60] = {//0,10,20, 30, 40, 50, 60, 70, 80, 90,150
                       50,       //LightHouseWaitStartMaxTime�������ʱ��
                       6,        //SpeedStrategyChosen�ٶȲ���
                       300,      //MotorTakeOffQuadCountLimit����ٶ�
                       3,2,3,5, //AngleZoneConfirmMatLimit, AngleConfirmMatLimit, BrickConfirmMatLimit, BrickConfirmFinalColCom
                       20,10,    //LightHouseWaitStopDelayCountLimit, LightHouseWaitStopGapCountLimit
                       75,90,90,140,80,110,   //6��ͼ��ؼ���ֵ��WBi, WBa, Win, Wax, Bin, Bax
                       10, 20, 25, 25, //���е�0��-0
                       20, 25, 25, 20, //���е�1��-10
                       24, 30, 20, 15, //���е�2��-20
                       29, 38, 17, 8, //���е�3��-30
                       32, 38, 15, 7,  //���е�4��-40
                       35, 45, 13, 5, //���е�5��-50
                       37, 55, 12, 3, //���е�6��-60
                       40, 60, 12, 0,  //���е�7��-60+
                        480,             //��ʱ��ʱ�䣬0.1sΪ��λ��
                        20,         //���P
                        15,         //���D
                        30,         //�µ��ĸ����ٶ�
                        21,         //ֱ����ĸ����ٶ�
                        35,         //��ֱ���ĸ����ٶ�
                        20,         //�µ���ֹ���������жϵ���������ֵ
                        8,          //����ֱ��������ֵ
                        5,          //ͣ��������ֵ��1����λ��0.1s
                        0,          //������ͣ����־��1��������ģʽ��0��ʹ��
                        5,          //ֱ������ͷ����ֵ����������⣬�����
                        25,         //�����ȴ�ͣ���ٶ�
                        25          //�����ٶ�
                      };
       
         
    DisableInterrupts;                                    //�ر������ж�

    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478��ʾ17ms������Զ���ڸ�ֵ����tictoc�����塣
    pit_init(PIT0, 75000);                              //75000��Ϊ1ms
    //enable_pit_interrupt(PIT0);

    
    FlashInit();

    //EnableInterrupts;                                     //�������ж�  
    
    //�Ȳ�������������
    FlashEraseSector(FlashSectorIndex);
  
    
    for(i = 0; i < 60; i++)
    {
      pointeruint8 = (uint8 *)&temp[i];
      FlashWriteNow(FlashSectorIndex, i, FlashElementSize, pointeruint8);  
    }
    
    while(1)
    {

      gpio_init(PORTD,15,1,0); 
    }  // end of while(1)
}      // end of main()
#endif // end of FLASH_DEBUG


//=================================�����ǲ���================================
#ifdef GYRO_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Debug.h"
#include "Flash.h"
#include "LQ12864.h"
#include "adc.h"

void main(void)
{

    DisableInterrupts;                                    //�ر������ж�
    
    light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478��ʾ17ms������Զ���ڸ�ֵ����tictoc�����塣
    //pit_init(PIT0,75000*5);                                   //��ʼ��PIT0����,75000��1ms.
    //enable_pit_interrupt(PIT0);                         //��PIT0�ж�
    
    //ADC��ʼ��
    hw_adc_init(0);
    
    //�����ǳ�ʼ��
    GyroInit();
    
    
    //EnableInterrupts;  

    while(1)
    {
      
      tic2 = PIT_CVAL(1);
      //ADResult0 = (ADResult0 * 90 + (hw_ad_once(0, 10, 16) - ADResultCom) * 10) / 100;
      //ADResult1 = (ADResult1 * 90 + (hw_ad_once(0, 17, 16) - ADResultCom) * 10) / 100;
      //ADResult2 = (ADResult2 * 90 + (hw_ad_once(0, 18, 16) - ADResultCom) * 10) / 100;
      ADResult0 = hw_ad_once(0, 10, 16) - ADResultCom;
      toc2 = PIT_CVAL(1);
      
      tic3 = PIT_CVAL(1);
      //ADResult3 = (ADResult3 * 90 + (hw_ad_mid(0, 10, 16) - ADResultCom) * 10) / 100;
      //ADResult4 = (ADResult4 * 90 + (hw_ad_mid(0, 17, 16) - ADResultCom) * 10) / 100;
      //ADResult5 = (ADResult5 * 90 + (hw_ad_mid(0, 18, 16) - ADResultCom) * 10) / 100;
      ADResult3 = hw_ad_mid(0, 10, 16) - ADResultCom;
      toc3 = PIT_CVAL(1);    
      
      Virtual2SendData();
      
    }  // end of while(1)
}      // end of main()
#endif // end of GYRO_DEBUG

//=================================��������================================
#ifdef LIGHTHOUSE_DEBUG

#include "math.h"
#include "common.h"
#include "sysinit.h"
#include "gpio.h"
#include "light.h"
#include "uart.h"
#include "wdog.h"
#include "Pit.h"
#include "DMA.h"
#include "ImageGet.h"
#include "ImagePro.h"
#include "CameraSet.h"
#include "vectors.h"
#include "MK60N512VMD100.h"
#include "Ftm.h"
#include "RunControl.h"
#include "VirtualScope.h"
#include "Debug.h"
#include "Flash.h"
#include "LQ12864.h"
#include "adc.h"

void main(void)
{

    DisableInterrupts;                                    //�ر������ж�
    
    //light_init(PORTE, 26, Light_ON);                      //��Ƭ������ָʾ��
    uart_init(UART0, periph_clk_khz, 115200);             //���ڳ�ʼ��
    pit_init(PIT1, 0x7FFFFFFE);                                   //0x137478��ʾ17ms������Զ���ڸ�ֵ����tictoc�����塣
    //pit_init(PIT0,75000*5);                                   //��ʼ��PIT0����,75000��1ms.
    //enable_pit_interrupt(PIT0);                         //��PIT0�ж�
    
    //������ʼ��
    LightHouseInit();
    
    gpio_init(PORTE, 26, 1, 1);   //���һ��1��ʾϨ��
    gpio_init(PORTA, 17, 1, 1);
    
    
    //EnableInterrupts;  

    while(1)
    {
      
      LightHouseStateUpdate();
      
      if(LightHouseStateR0 == 1)
      {
        GPIO_PDOR_REG(PTA_BASE_PTR) &= ~(1 << 17);   //����͵�ƽ��ʾ����
      }
      else
      {
        GPIO_PDOR_REG(PTA_BASE_PTR) |=  (1 << 17);   //����ߵ�ƽ��ʾϨ��
      }
 
      if(LightHouseStateR1 == 1)
      {
        GPIO_PDOR_REG(PTE_BASE_PTR) &= ~(1 << 26);   //����͵�ƽ��ʾ����
      }
      else
      {
        GPIO_PDOR_REG(PTE_BASE_PTR) |=  (1 << 26);   //����ߵ�ƽ��ʾϨ��
      }
      
      Virtual2SendData();
      
    }  // end of while(1)
}      // end of main()
#endif // end of LIGHTHOUSE_DEBUG


//��׼C�ļ�ͷ

/******************************************************************************/
/*******************************************************************************
  �ļ�����ͼ��������ļ�ImagePro.c
  ��  �ܣ�ͼ����
  ��  �ڣ�2014.10.09
  ��  �ߣ�HJZ
  ��  ע��
*******************************************************************************/
/******************************************************************************/


//��׼H�ļ�ͷ

/******************************************************************************/
/*******************************************************************************
  �ļ�����ͼ�������ͷ�ļ�IamgePro.h
  ��  �ܣ�ͼ����
  ��  �ڣ�2014.10.09
  ��  �ߣ�HJZ
  ��  ע��
*******************************************************************************/
/******************************************************************************/
//1. ͷ�ļ�
//2. �궨��
//3. �������Ͷ���
//4. ��������
//5. ��������


//��׼����ͷ

//======================================================================
//��������
//��  �ܣ�
//��  ����
//��  �أ�
//Ӱ  �죺
//˵  ����
//      
//             
//======================================================================