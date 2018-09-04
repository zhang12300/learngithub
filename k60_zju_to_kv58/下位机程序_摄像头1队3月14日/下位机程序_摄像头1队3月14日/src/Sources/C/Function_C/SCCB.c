/******************************************************************************/
/*******************************************************************************
  �ļ�����SCCBͨ�ŵײ���ļ�SCCB.c
  ��  �ܣ�SCCBͨ��
  ��  �ڣ�2014.10.10
  ��  �ߣ�LYX
  ��  ע��
*******************************************************************************/
/******************************************************************************/

#include "SCCB.h"


//��SDA�����ϵ�ֵ
uint8 SDARead(void)
{     //�˴��ж��죬ԭ������uint8��ǿ��ת��uint32, ���������8λʱ�� ����ȥ�Ĳ��ǡ��桱��1��������һ�����롣 
      uint32 Temp;
      Temp = (GPIO_PDIR_REG(SDAPT_BASE_PTR) & (1 << SDAPIN) );
      if(Temp)
        return 1;
      else 
        return 0;
    //�����Ĵ���
    //return (uint8)(GPIO_PDIR_REG(SDAPT_BASE_PTR) & (1 << SDAPIN));
    //return Temp;  
}


//SCL����GPIO��������Ϊ����
void SCLIn(void)
{
    GPIO_PDDR_REG(SCLPT_BASE_PTR) &= ~(1 << SCLPIN);
}


//SCL����GPIO��������Ϊ���
void SCLOut(void)
{
    GPIO_PDDR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
}


//SCL��������͵�ƽ
void SCLClear(void)
{
    GPIO_PDOR_REG(SCLPT_BASE_PTR) &= ~(1 << SCLPIN);
}


//SCL��������ߵ�ƽ
void SCLSet(void)
{
    GPIO_PDOR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
}


//SDA����GPIO��������Ϊ����
void SDAIn(void)
{
    GPIO_PDDR_REG(SDAPT_BASE_PTR) &= ~(1 << SDAPIN);
}


//SDA����GPIO��������Ϊ���
void SDAOut(void)
{
    GPIO_PDDR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
}


//SDA��������͵�ƽ
void SDAClear(void)
{
    GPIO_PDOR_REG(SDAPT_BASE_PTR) &= ~(1 << SDAPIN);
}


//SDA��������ߵ�ƽ
void SDASet(void)
{
    GPIO_PDOR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
}


//SCCB��ʱ����������������ǿ���SCCB�ź�Ƶ�ʵĹؼ������ǲ�֪������ԭ��
void SCCBDelay(volatile uint16 time)
{
    while(time)
    {
        time--;  
    }
}

//SCCB���ų�ʼ������
void SCCBPortInit(void)
{
    //�������ž�����ΪGPIO�������ʼֵΪ1��©����·����������
    PORT_PCR_REG(SCLPORT_BASE_PTR, SCLPIN) |= (
                                    PORT_PCR_MUX(0x01) 
                                  | PORT_PCR_PE_MASK 
                                  | PORT_PCR_ODE_MASK
                                  );
    PORT_PCR_REG(SDAPORT_BASE_PTR, SDAPIN) |= (
                                    PORT_PCR_MUX(0x01) 
                                  | PORT_PCR_PE_MASK 
                                  | PORT_PCR_ODE_MASK
                                  );
    //SCLĬ��ΪGPIO���
    GPIO_PDDR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
    //SCLĬ�����Ϊ�ߵ�ƽ
    GPIO_PDOR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
    //SDAĬ��ΪGPIO���
    GPIO_PDDR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
    //SDAĬ�����Ϊ�ߵ�ƽ
    GPIO_PDOR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
}




//=======================Ұ���SCCB��======================================


//SCCB��ʼ�źź���
uint8 SCCBStart(void)
{      
    uint8 temp1;
    SDASet();    //SDA_H();
    SCLSet();    //SCL_H();
    SCCB_DELAY();

    
    SDAIn();     //SDA_DDR_IN();
    temp1 = SDARead();
    if(!temp1) // SDA_IN()
    {
        SDAOut();  //SDA_DDR_OUT();
        return 0;   // SDA��Ϊ�͵�ƽ������æ,�˳� 
    }
    SDAOut();     //SDA_DDR_OUT();
    
    
    
    
    SDAClear();  //SDA_L();

    SCCB_DELAY();
    SCLClear();  //SCL_L();

    if(SDARead())      //SDA_IN()
    {
        SDAOut();    //SDA_DDR_OUT();
        return 0;   // SDA��Ϊ�ߵ�ƽ�����߳���,�˳� 
    }
    
  
    //SDA_DDR_OUT();
    //SDA_L();
    //SCCB_delay();
    return 1;
}
          
          
//SCCBֹͣ�źź���
void SCCBStop(void)
{
    SCLClear();  //SCL_L();
    //SCCB_DELAY();
    SDAClear(); //SDA_L();
    SCCB_DELAY();
    SCLSet();   //SCL_H();
    SCCB_DELAY();
    SDASet();  //SDA_H();
    SCCB_DELAY();
}
          
    
//SCCBӦ���źź���
void SCCBAck(void)
{
    SCLClear();     //SCL_L();
    SCCB_DELAY();
    SDAClear();     //SDA_L();
    SCCB_DELAY();
    SCLSet();       //SCL_H();
    SCCB_DELAY();
    SCLClear();     //SCL_L();
    SCCB_DELAY();
}

          
//SCCB��Ӧ���źź���
void SCCBNoAck(void)
{
    SCLClear();     //SCL_L();
    SCCB_DELAY();
    SDASet();       //SDA_H();
    SCCB_DELAY();
    SCLSet();       //SCL_H();
    SCCB_DELAY();
    SCLClear();     //SCL_L();
    SCCB_DELAY();
  
}
          
          
//SCCB�ȴ�Ӧ����
//0��ʾ��Ӧ��1��ʾ��Ӧ��
uint8 SCCBWaitAck(void)
{
    SCLClear();        //SCL_L();
    //SDA_H();  //===========================���������£�Ұ���û��д��DEMOK��д��������û�б�Ҫ
    SDAIn();          //SDA_DDR_IN();

    SCCB_DELAY();
    SCLSet();          //SCL_H();

    SCCB_DELAY();

    if(SDARead())      //SDA_IN()     //Ӧ��Ϊ�ߵ�ƽ���쳣��ͨ��ʧ��
    {
        SDAOut();      //SDA_DDR_OUT();
        SCLClear();    //SCL_L();
        return 0;
    }
    SDAOut();          //SDA_DDR_OUT();

    SCLClear();        //SCL_L();
    return 1;  
}


//SCCB�������ݺ��� 
//SendByte Ϊ��Ҫ���͵�����
void SCCBSendByte(uint8 SendByte)
{
    uint8 i = 8;
    while(i--)
    {

        if(SendByte & 0x80)     //SDA �������
        {
            SDASet();           //SDA_H();
        }
        else
        {
            SDAClear();         //SDA_L();
        }
        SendByte <<= 1;
        SCCB_DELAY();
        SCLSet();               //SCL_H();                //SCL ���ߣ��ɼ��ź�
        SCCB_DELAY();
        SCLClear();             //SCL_L();                //SCL ʱ��������
        //SCCB_DELAY();
    }
    //SCL_L();    
}
          
//дһ�ֽ�����1�εĺ���
// ����  ��- WriteAddress: ��д���ַ    - SendByte: ��д������  - DeviceAddress: ��������
// ���  ������Ϊ:=1�ɹ�д��,=0ʧ��
uint8 SCCBWriteByteOne(uint8 WriteAddress, uint8 SendByte)
{
    if(!SCCBStart())
    {
        return 0;
    }
    SCCBSendByte(ADDR_OV7725);                    // ������ַ
    if( !SCCBWaitAck() )
    {
        SCCBStop();
        return 0;
    }
    SCCBSendByte(WriteAddress);   // ���õ���ʼ��ַ 
    SCCBWaitAck();
    SCCBSendByte(SendByte);
    SCCBWaitAck();
    SCCBStop();
    return 1;  
}

//дһ�ֽ����ݶ�Σ���extern�ĺ���
// ����  ��- WriteAddress: ��д���ַ    - SendByte: ��д������  - DeviceAddress: ��������
// ���  ������Ϊ:=1�ɹ�д��,=0ʧ��
//���ǵ���sccb�Ĺܽ�ģ�⣬�Ƚ�����ʧ�ܣ���˶��Լ���               
uint8 SCCBWriteByte(uint8 WriteAddress , uint8 SendByte)            
{
    uint8 i = 0;
    while( 0 == SCCBWriteByteOne ( WriteAddress, SendByte ) )
    {
        i++;
        if(i == 20)
        {
            return 0 ;
        }
    }
    return 1;    
}


//����SCCB�������ݵĺ���
//���ز��������յ�������
uint8 SCCBReceiveByte(void)
{
    uint8 i = 8;
    uint8 ReceiveByte = 0;

    //SDA_H();
    //SCCB_DELAY();
    SDAIn();              //SDA_DDR_IN();

    while(i--)
    {
        ReceiveByte <<= 1;
        SCLClear();          //SCL_L();
        SCCB_DELAY();
        SCLSet();            //SCL_H();
        SCCB_DELAY();

        if(SDARead())         //SDA_IN()
        {
            ReceiveByte |= 0x01;
        }
    }
    SDAOut();                 //SDA_DDR_OUT();
    SCLClear();               //SCL_L();
    return ReceiveByte;  
}
          
// ��������SCCB_ReadByte
// ����  ����ȡһ������1��
// ����  ��- pBuffer: ��Ŷ�������  - length: ����������    - ReadAddress: ��������ַ        - DeviceAddress: ��������
// ���  ������Ϊ:=1�ɹ�����,=0ʧ��         
uint8 SCCBReadByteOne(uint8 *pBuffer, uint16 length, uint8 ReadAddress)
{
    if(!SCCBStart())
    {
        return 0;
    }
    SCCBSendByte( ADDR_OV7725 );         // ������ַ 
    if( !SCCBWaitAck() )
    {
        SCCBStop();
        return 0;
    }
    SCCBSendByte( ReadAddress );           // ���õ���ʼ��ַ 
    SCCBWaitAck();
    SCCBStop();

    if(!SCCBStart())
    {
        return 0;
    }
    SCCBSendByte( ADDR_OV7725 + 1 );               // ������ַ 

    if(!SCCBWaitAck())
    {
        SCCBStop();
        return 0;
    }
    while(length)
    {
        *pBuffer = SCCBReceiveByte();    
        if(length == 1)
        {
            SCCBNoAck();
        }
        else
        {
            SCCBAck();
        }
        pBuffer++;
        length--;
    }
    SCCBStop();
    return 1;   
}


// ��������SCCB_ReadByte
// ����  ����ȡһ�����ݶ�Σ� ����extern�ĺ���
// ����  ��- pBuffer: ��Ŷ�������  - length: ����������    - ReadAddress: ��������ַ        - DeviceAddress: ��������
// ���  ������Ϊ:=1�ɹ�����,=0ʧ��  

uint8 SCCBReadByte(uint8 *pBuffer, uint16 length, uint8 ReadAddress)
{
    uint8 i = 0;
    while( 0 == SCCBReadByteOne(pBuffer, length, ReadAddress) )
    {
        i++;
        if(i == 30)
        {
            return 0 ;
        }
    }
    return 1;    
}
          





/*

//=======================Demok��SCCB��
//SCCBӦ���źź���
void SCCBAck(void)
{
    SCLClear();     //SCL_L();
    SCCB_DELAY();
    SDAClear();     //SDA_L();
    SCCB_DELAY();
    SCLSet();       //SCL_H();
    SCCB_DELAY();
    SCLClear();     //SCL_L();
    SCCB_DELAY();
}

          
//SCCB��Ӧ���źź���
void SCCBNoAck(void)
{
    SCLClear();     //SCL_L();
    SCCB_DELAY();
    SDASet();       //SDA_H();
    SCCB_DELAY();
    SCLSet();       //SCL_H();
    SCCB_DELAY();
    SCLClear();     //SCL_L();
    SCCB_DELAY();
  
}

void SCCBStart(void)
{
    SCLOut();                 //SCL_OUT;
    SDAOut();                 //SDA_OUT;
                             
    SDASet();                 //SDA_HIGH;
                              //  //sccb_wait();
    SCLSet();                 //SCL_HIGH;
    SCCB_DELAY();             //sccb_wait();
    SDAClear();               //SDA_LOW;
    SCCB_DELAY();             //sccb_wait();
    SCLClear();               //SCL_LOW;
}

void SCCBStop(void)
{
  SCLOut();                 //SCL_OUT;
  SDAOut();                 //SDA_OUT;
  
  SDAClear();               //SDA_LOW;
  SCCB_DELAY();             //sccb_wait();
  SCLSet();                 //SCL_HIGH;
  SCCB_DELAY();             //sccb_wait();
  SDASet();                 //SDA_HIGH;
  SCCB_DELAY();             //sccb_wait();
}



//  ����˵����sccb�ֽ�д��         
//  ����˵����data--��д���ֽ�����
//  �������أ�ack--Ӧ���ź�
//            ack=1δ�յ�Ӧ��    ack=0�յ�Ӧ��
uint8 SCCBSendByte(uint8 data)
{
    uint8 i;
    uint8 ack;
    
    SDAOut();                //SDA_OUT;
    for( i=0; i<8; i++)
    {
      if(data & 0x80)
        SDASet();            //SDA_HIGH;
      else 
        SDAClear();          //SDA_LOW;
      data <<= 1;
      
      SCCB_DELAY();          //sccb_wait();
      SCLSet();              //SCL_HIGH;
      SCCB_DELAY();          //sccb_wait();
      SCLClear();            //SCL_LOW;
      SCCB_DELAY();          //sccb_wait();
    }
    
    SDASet();                //SDA_HIGH;
    SDAIn();                 //SDA_IN;
    SCCB_DELAY();            //sccb_wait();
    SCLSet();                //SCL_HIGH;
    SCCB_DELAY();            //sccb_wait();
    ack = SDARead();         //ack = SDA_DATA;
    SCLClear();              //SCL_LOW;
    SCCB_DELAY();            //sccb_wait();
    return ack;  
}

//  ����˵������ָ���豸��ָ����ַ��д��ָ������        
//  ����˵����device--����ͷ�豸�ţ�����OV7620дΪ0X42   OV7640дΪ0X42  OV6620дΪ0XC0�����ѹ̶�ΪADDR_OV7725
//            address--Ҫд��ĵ�ַ
//            data--Ҫд�������
uint8 SCCBWriteByte(uint16 address, uint8 data)
{
  uint8 i;
  uint8 ack1, ack2, ack3;
  
  for( i=0; i<20; i++)         ///����20��
  {
    SCCBStart();                    //sccb_start();
    ack1 = SCCBSendByte(ADDR_OV7725);      //ack = sccb_sendByte(device);
    if( ack1 == 1 )
    {
     // sccb_stop();
      continue;
    }
    
    ack2 = SCCBSendByte((uint8)(address & 0x00FF));      //ack = sccb_sendByte(address);
    if( ack2 == 1 )
    {
     // sccb_stop();
      continue;
    }
    
    ack3 = SCCBSendByte(data);      //ack = sccb_sendByte(data);
    if( ack3 == 1 )
    {
     // sccb_stop();
      continue;
    }
    
    SCCBStop();                      //sccb_stop();
    return 1;
  }  
  
  return 0;
}


//����SCCB�������ݵĺ���
//���ز��������յ�������
uint8 SCCBReceiveByte(void)
{
    uint8 i = 8;
    uint8 ReceiveByte = 0;

    //SDA_H();
    //SCCB_DELAY();
    SDAIn();              //SDA_DDR_IN();

    while(i--)
    {
        ReceiveByte <<= 1;
        SCLClear();          //SCL_L();
        SCCB_DELAY();
        SCLSet();            //SCL_H();
        SCCB_DELAY();

        if(SDARead())         //SDA_IN()
        {
            ReceiveByte |= 0x01;
        }
    }
    SDAOut();                 //SDA_DDR_OUT();
    SCLClear();               //SCL_L();
    return ReceiveByte;  
}




// ��������SCCB_ReadByte
// ����  ����ȡһ������1��
// ����  ��- pBuffer: ��Ŷ�������  - length: ����������    - ReadAddress: ��������ַ        - DeviceAddress: ��������
// ���  ������Ϊ:=1�ɹ�����,=0ʧ��         
// ��ע  ���ú����᳢��30�Σ�ֻҪ��һ�γɹ����ͻ�ִ�е�����return 1, ȫ��ʧ�ܺ󣬻�ִ��return 0
uint8 SCCBReadByte(uint8 *pBuffer, uint16 length, uint8 ReadAddress)
{
    uint8 i; 
    uint8 ack1, ack2, ack3, ack4, ack5;
    
    for(i = 0; i < 30; i++)
    {
      SCCBStart();                         //��ʼ�ź�
      ack1 = SCCBSendByte( ADDR_OV7725 );         // ������ַ
      if( ack1 == 1 )
      {
      // sccb_stop();
        continue;
      }  
      ack2 = SCCBSendByte( ReadAddress );           // ���õ���ʼ��ַ 
      if( ack2 == 1 )
      {
      // sccb_stop();
      continue;
      }      
      SCCBStop();              

      //����һ��
      SCCBStart();      
      ack3 = SCCBSendByte( ADDR_OV7725 + 1 );               // ������ַ 
      if( ack3 == 1 )
      {
      // sccb_stop();
      continue;
      }      

      while(length)
      {
          *pBuffer = SCCBReceiveByte();    
          if(length == 1)
          {
              SCCBNoAck();
          }
          else
          {
              SCCBAck();
          }
          pBuffer++;
          length--;
      }
      SCCBStop();
      return 1;
    
    } // end of forѭ��
    return 0;
}


*/


