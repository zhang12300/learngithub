/******************************************************************************/
/*******************************************************************************
  �ļ���������ͷ�Ĵ��������ļ�CameraSet.c
  ��  �ܣ�����ͷ���Կ���
  ��  �ڣ�2014.10.09
  ��  �ߣ�HJZ
  ��  ע��
*******************************************************************************/
/******************************************************************************/
//ͷ�ļ�
#include "CameraSet.h"


//ȫ�ֱ�������
volatile ImgStatusDef ImgStatus = ImgGetFinish;   //��ǰͼ��״̬��־��־λ
//uint8 ImgRaw[CameraHight][CameraWidth];           //ԭʼ���ݴ�������
uint8 ImgStore1[CameraHight][CameraWidth];                    //ͼ�����ݴ�������1
uint8 ImgStore2[CameraHight][CameraWidth];                    //ͼ�����ݴ�������2

//uint8 ImgSend[CameraWidth * CameraHight];      //Ҫ���͵���λ�������飬����ӥ������ͷ��һ�ֽ�8�����أ������Ҫ��ѹΪ 1�ֽ�1�����أ����㴦��

//OV7725�Ĵ���ר�ó�ʼֵ��ȫ�ֱ���
CameraRegs OV7725Regs[] =
{
    //�Ĵ�����ַ���Ĵ���ֵ
    {OV7725_COM4         , 0xC1},//01
    {OV7725_CLKRC        , 0x00},//02
    {OV7725_COM2         , 0x03},//03
    {OV7725_COM3         , 0xD0},//04
    {OV7725_COM7         , 0x40},//05
    {OV7725_HSTART       , 0x3F},//06
    {OV7725_HSIZE        , 0x50},//07
    {OV7725_VSTRT        , 0x03},//08
    {OV7725_VSIZE        , 0x78},//09
    {OV7725_HREF         , 0x00},//10
    {OV7725_SCAL0        , 0x0A},//11
    {OV7725_AWB_Ctrl0    , 0xE0},//12
    {OV7725_DSPAuto      , 0xff},//13
    {OV7725_DSP_Ctrl2    , 0x0C},//14
    {OV7725_DSP_Ctrl3    , 0x00},//15
    {OV7725_DSP_Ctrl4    , 0x00},//16

#if (CameraWidth == 80)             //17
    {OV7725_HOutSize     , 0x14},   //��10λ����Ϊ��8λ����2λ��OV7725_EXHCH�У�Ϊ00��80����0x50,����2λ����0x14
#elif (CameraWidth == 160)
    {OV7725_HOutSize     , 0x28},
#elif (CameraWidth == 240)
    {OV7725_HOutSize     , 0x3c},
#elif (CameraWidth == 320)
    {OV7725_HOutSize     , 0x50},
#else

#endif

#if (CameraHight == 60 )             //18
    {OV7725_VOutSize     , 0x1E},   //��9λ����Ϊ��8λ����1λ��OV7725_EXHCH�У�Ϊ0�� 60����0x3C,����1λ����0x1E
#elif (CameraHight == 120 )
    {OV7725_VOutSize     , 0x3c},
#elif (CameraHight == 180 )
    {OV7725_VOutSize     , 0x5a},
#elif (CameraHight == 240 )
    {OV7725_VOutSize     , 0x78},
#else

#endif

    {OV7725_EXHCH        , 0x00},//19
    {OV7725_GAM1         , 0x0c},//20
    {OV7725_GAM2         , 0x16},//21
    {OV7725_GAM3         , 0x2a},//22
    {OV7725_GAM4         , 0x4e},//23
    {OV7725_GAM5         , 0x61},//24
    {OV7725_GAM6         , 0x6f},//25
    {OV7725_GAM7         , 0x7b},//26
    {OV7725_GAM8         , 0x86},//27
    {OV7725_GAM9         , 0x8e},//28
    {OV7725_GAM10        , 0x97},//29
    {OV7725_GAM11        , 0xa4},//30
    {OV7725_GAM12        , 0xaf},//31
    {OV7725_GAM13        , 0xc5},//32
    {OV7725_GAM14        , 0xd7},//33
    {OV7725_GAM15        , 0xe8},//34
    {OV7725_SLOP         , 0x20},//35
    {OV7725_LC_RADI      , 0x00},//36
    {OV7725_LC_COEF      , 0x13},//37
    {OV7725_LC_XC        , 0x08},//38
    {OV7725_LC_COEFB     , 0x14},//39
    {OV7725_LC_COEFR     , 0x17},//40
    {OV7725_LC_CTR       , 0x05},//41
    {OV7725_BDBase       , 0x99},//42
    {OV7725_BDMStep      , 0x03},//43
    {OV7725_SDE          , 0x04},//44
    {OV7725_BRIGHT       , 0x00},//45
    {OV7725_CNST         , 0xFF},//46
    {OV7725_SIGN         , 0x06},//47
    {OV7725_UVADJ0       , 0x11},//48
    {OV7725_UVADJ1       , 0x02},//49

};

//OV7620�Ĵ���ר�ó�ʼֵ��ȫ�ֱ���
CameraRegs OV7620Regs[] =
{
      //�Ĵ�����ַ���Ĵ���ֵ
    {OV7725_COM4         , 0xC1},//01
    {OV7725_CLKRC        , 0x00},//02
};





//����

//CameraDelay����
//5�� * 30000 * 1 = 150000 �����㣬Ҳ����1ms����һ��׼��
void CameraDelay(uint32 time)
{
  volatile uint32 timecount = time * 30000;
  while(timecount--)
  {
    asm("nop");  
    asm("nop");  
    asm("nop");  
    asm("nop");  
  }
}


//����ͷ����˿�����
void CameraPortInit(void)
{
    uint8 i;                                  
    uint8 IMAGE_PIN_IN[8] = {0,1,2,3,4,5,6,7};    
    PORT_MemMapPtr p = PORT_IMAGE_DATA_BASE_PTR;
    
    //ͼ����������ڳ�ʼ���� PTB0~PTB7������Ϊ����ͷ�������룬�������� 
    //SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK;
    for(i = 0;i < 8;i++)
    {
        //��Ӧ�Ķ˿����ų�ʼ��,�������룬
        //gpio_init(PORT_IMAGE_DATA,IMAGE_PIN_IN[i],0,0);
        //���ö˿�ΪGPIOģʽ��Ĭ����������
        PORT_PCR_REG(p,IMAGE_PIN_IN[i]) |= PORT_PCR_MUX(0x01) | PORT_PCR_PE_MASK;
        //����Ϊ��������
        PORT_PCR_REG(p,IMAGE_PIN_IN[i]) &= ~PORT_PCR_PS_MASK;
        
    }
    
    
    //���ж��������ų�ʼ��, �½��ش����жϣ��ݶ�ΪPTD1
    //�����������裬���˲�
    PORT_PCR_REG(PORT_FIELD_BASE_PTR, PIN_FIELD) |= (
                                                    PORT_PCR_MUX(0x01)    //GPIO
                                               //   | PORT_PCR_PE_MASK    //��������
                                                  | PORT_PCR_IRQC(0xA)   //�½��ش����ж�
                                               //   | PORT_PCR_PFE_MASK   //�˲�
                                                    );    
    //���ж��������ų�ʼ��, �����ش����жϣ��ݶ�ΪPTC8
    //�����������裬���˲�
    PORT_PCR_REG(PORT_LINE_BASE_PTR, PIN_LINE) |= (
                                                    PORT_PCR_MUX(0x01)    //GPIO
                                               //   | PORT_PCR_PE_MASK    //��������
                                                  | PORT_PCR_IRQC(0x9)    //�����ش����ж�
                                               //   | PORT_PCR_PFE_MASK   //�˲�
                                                    );   
    
    //PCLK�������ų�ʼ���������ش���DMA�� �ݶ�ΪPTB9
    //�����������裬���˲�
    PORT_PCR_REG(PORT_PCLK_BASE_PTR, PIN_PCLK) |= (
                                                    PORT_PCR_MUX(0x01) //GPIO
                                                //  | PORT_PCR_PE_MASK   //��������
                                                  | PORT_PCR_IRQC(0x1) //�����ش���DMA
                                                   );         
}


/*
//OV7725����ͷ�Ĵ�����ʼ�� �ɹ�����1 ʧ�ܷ���0
uint8 CameraRegInit(void)
{
    uint8 i;
    uint8 SensorID = 1;
    uint8 Send_Tmp[1] = {"1"};
    
    //SCCB�ź���������
    SCCBPortInit();
    
    //��λ����ͷ���мĴ���
    if(SCCBWriteByte(OV7725_COM7, 0x80) == 0)
    {
        uart_sendN(UART0, (uint8 *)"\nCamera Registers Reset Failed!", 31);
        return 0;
    }
    
    //��ʱ
    CameraDelay(50);
    
    
    
    //��ȡ����ͷоƬ��ID��
    if(SCCBReadByte(&SensorID, 1, OV7725_VER) == 0)
    {
        uart_sendN(UART0, (uint8 *)"\nCamera Registers ReadID Failed!", 32);
        return 0;
    }
    
    Send_Tmp[0] = SensorID;
    
    //��ȡ����ͷоƬID�ųɹ�
    uart_sendN(UART0, (uint8 *)"\nCamera Registers ReadID Succeed: ", 34);
    uart_send1(UART0, '\n');
    uart_sendN(UART0, Send_Tmp, sizeof(Send_Tmp));
    
    
    
    //���ø����Ĵ���
    if(SensorID == OV7725_ID) 
    {
        for( i = 0 ; i < 49 ; i++ )
        {
            if( 0 == SCCBWriteByte(OV7725Regs[i].addr, OV7725Regs[i].val) )
            {
                uart_sendN(UART0, (uint8 *)"\nCamera Writing a Reg Failed!", 29);
                return 0;
            }
        }
    }
    else
    {
        uart_sendN(UART0, (uint8 *)"\nSensor ID Unmatch!", 19);
        return 0;
    }
    
    //����Camera���Ĵ������ɹ�
    uart_sendN(UART0, (uint8 *)"\nCamera Registers Initial Finally Succeed!", 42);
    return 1;
}

*/



//OV7620����ͷ�Ĵ�����ʼ�� �ɹ�����1 ʧ�ܷ���0
uint8 CameraRegInit(void)
{
    //uint8 i;
    //uint8 SensorID = 1;
    //uint8 Send_Tmp[1] = {"1"};
    
    //SCCB�ź���������
    SCCBPortInit();

    //��λ����ͷ���мĴ���
    if(SCCBWriteByte(OV7620_COMCTRLA, 0x80) == 0)
    {
        uart_sendN(UART0, (uint8 *)"\nCamera Registers Reset Failed!", 31);
        return 0;
    }
    
    //��ʱ
    CameraDelay(50);    
    
    //PCLK�ķ�Ƶ��HSYNC��Ч��CHSYNC��Ч��VSYNC��Ч���ء�
    //PCLK:166ns   HREF:254.6us   VSYN:133.6ms
    /*
    if( 0 == SCCBWriteByte(OV7620_CLKCTRL,0x00))
    {
        uart_sendN(UART0, (uint8 *)"\nCamera Writing OV7620_CLKCTRL Failed!", 38);
        return 0;
    }
    */
    /*
    if( 0 == SCCBWriteByte(OV7620_HS,0x3F))
    {
        uart_sendN(UART0, (uint8 *)"\nCamera Writing OV7620_COMCTRLC Failed!", 39);
        return 0;
    }
    
    if( 0 == SCCBWriteByte(OV7620_HE,0xBF))
    {
        uart_sendN(UART0, (uint8 *)"\nCamera Writing OV7620_COMCTRLC Failed!", 39);
        return 0;
    }    
    */
    //AWB������ֵѡ��Ϊ �ͣ� QVGA���ѡ��320*240��VSYNC����ż���������HREF�����ԣ�RGB٤��У��������
    //PCLK:332ns   HREF:509.6us   VSYN:133.6ms
    if( 0 == SCCBWriteByte(OV7620_COMCTRLC,0x24))
    {
        uart_sendN(UART0, (uint8 *)"\nCamera Writing OV7620_COMCTRLC Failed!", 39);
        return 0;
    }
    
    /*
    //�����ɼ�ģʽ(320*240)
    //PCLK:666ns   HREF:509.6us   VSYN:133.6ms
    if( 0 == SCCBWriteByte(OV7620_COMCTRLH,0x00))
    {
        uart_sendN(UART0, (uint8 *)"\nCamera Writing OV7620_COMCTRLH Failed!", 39);
        return 0;
    }
    */

    
    //����Camera���Ĵ������ɹ�
    uart_sendN(UART0, (uint8 *)"\nCamera Registers Initial Finally Succeed12!", 42);
    return 1;
}





//����ͷ��ʼ������ �ɹ�����1 ʧ�ܷ���0
uint8 CameraInit(void)
{
  
    if(!CameraRegInit()) return 0; //����ͷ�Ĵ�����ʼ����ʧ�ܣ�ֱ�ӷ���0
    CameraPortInit();              //����ͷ����˿�����
    return 1;
}

