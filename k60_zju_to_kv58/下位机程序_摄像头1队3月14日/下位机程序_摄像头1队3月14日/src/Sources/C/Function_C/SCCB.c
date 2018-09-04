/******************************************************************************/
/*******************************************************************************
  文件名：SCCB通信底层库文件SCCB.c
  功  能：SCCB通信
  日  期：2014.10.10
  作  者：LYX
  备  注：
*******************************************************************************/
/******************************************************************************/

#include "SCCB.h"


//读SDA引脚上的值
uint8 SDARead(void)
{     //此处有洞天，原来是用uint8来强制转换uint32, 当结果大于8位时， 传过去的不是“真”（1），而是一个乱码。 
      uint32 Temp;
      Temp = (GPIO_PDIR_REG(SDAPT_BASE_PTR) & (1 << SDAPIN) );
      if(Temp)
        return 1;
      else 
        return 0;
    //致命的错误：
    //return (uint8)(GPIO_PDIR_REG(SDAPT_BASE_PTR) & (1 << SDAPIN));
    //return Temp;  
}


//SCL引脚GPIO方向设置为输入
void SCLIn(void)
{
    GPIO_PDDR_REG(SCLPT_BASE_PTR) &= ~(1 << SCLPIN);
}


//SCL引脚GPIO方向设置为输出
void SCLOut(void)
{
    GPIO_PDDR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
}


//SCL引脚输出低电平
void SCLClear(void)
{
    GPIO_PDOR_REG(SCLPT_BASE_PTR) &= ~(1 << SCLPIN);
}


//SCL引脚输出高电平
void SCLSet(void)
{
    GPIO_PDOR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
}


//SDA引脚GPIO方向设置为输入
void SDAIn(void)
{
    GPIO_PDDR_REG(SDAPT_BASE_PTR) &= ~(1 << SDAPIN);
}


//SDA引脚GPIO方向设置为输出
void SDAOut(void)
{
    GPIO_PDDR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
}


//SDA引脚输出低电平
void SDAClear(void)
{
    GPIO_PDOR_REG(SDAPT_BASE_PTR) &= ~(1 << SDAPIN);
}


//SDA引脚输出高电平
void SDASet(void)
{
    GPIO_PDOR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
}


//SCCB延时函数，怀疑这里就是控制SCCB信号频率的关键，但是不知道具体原因
void SCCBDelay(volatile uint16 time)
{
    while(time)
    {
        time--;  
    }
}

//SCCB引脚初始化函数
void SCCBPortInit(void)
{
    //两个引脚均设置为GPIO输出，初始值为1，漏极开路，上拉电阻
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
    //SCL默认为GPIO输出
    GPIO_PDDR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
    //SCL默认输出为高电平
    GPIO_PDOR_REG(SCLPT_BASE_PTR) |= (1 << SCLPIN);
    //SDA默认为GPIO输出
    GPIO_PDDR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
    //SDA默认输出为高电平
    GPIO_PDOR_REG(SDAPT_BASE_PTR) |= (1 << SDAPIN);
}




//=======================野火的SCCB库======================================


//SCCB起始信号函数
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
        return 0;   // SDA线为低电平则总线忙,退出 
    }
    SDAOut();     //SDA_DDR_OUT();
    
    
    
    
    SDAClear();  //SDA_L();

    SCCB_DELAY();
    SCLClear();  //SCL_L();

    if(SDARead())      //SDA_IN()
    {
        SDAOut();    //SDA_DDR_OUT();
        return 0;   // SDA线为高电平则总线出错,退出 
    }
    
  
    //SDA_DDR_OUT();
    //SDA_L();
    //SCCB_delay();
    return 1;
}
          
          
//SCCB停止信号函数
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
          
    
//SCCB应答信号函数
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

          
//SCCB无应答信号函数
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
          
          
//SCCB等待应答函数
//0表示无应答，1表示有应答
uint8 SCCBWaitAck(void)
{
    SCLClear();        //SCL_L();
    //SDA_H();  //===========================这里有文章，野火的没有写，DEMOK有写，到底有没有必要
    SDAIn();          //SDA_DDR_IN();

    SCCB_DELAY();
    SCLSet();          //SCL_H();

    SCCB_DELAY();

    if(SDARead())      //SDA_IN()     //应答为高电平，异常，通信失败
    {
        SDAOut();      //SDA_DDR_OUT();
        SCLClear();    //SCL_L();
        return 0;
    }
    SDAOut();          //SDA_DDR_OUT();

    SCLClear();        //SCL_L();
    return 1;  
}


//SCCB发送数据函数 
//SendByte 为需要发送的数据
void SCCBSendByte(uint8 SendByte)
{
    uint8 i = 8;
    while(i--)
    {

        if(SendByte & 0x80)     //SDA 输出数据
        {
            SDASet();           //SDA_H();
        }
        else
        {
            SDAClear();         //SDA_L();
        }
        SendByte <<= 1;
        SCCB_DELAY();
        SCLSet();               //SCL_H();                //SCL 拉高，采集信号
        SCCB_DELAY();
        SCLClear();             //SCL_L();                //SCL 时钟线拉低
        //SCCB_DELAY();
    }
    //SCL_L();    
}
          
//写一字节数据1次的函数
// 输入  ：- WriteAddress: 待写入地址    - SendByte: 待写入数据  - DeviceAddress: 器件类型
// 输出  ：返回为:=1成功写入,=0失败
uint8 SCCBWriteByteOne(uint8 WriteAddress, uint8 SendByte)
{
    if(!SCCBStart())
    {
        return 0;
    }
    SCCBSendByte(ADDR_OV7725);                    // 器件地址
    if( !SCCBWaitAck() )
    {
        SCCBStop();
        return 0;
    }
    SCCBSendByte(WriteAddress);   // 设置低起始地址 
    SCCBWaitAck();
    SCCBSendByte(SendByte);
    SCCBWaitAck();
    SCCBStop();
    return 1;  
}

//写一字节数据多次，被extern的函数
// 输入  ：- WriteAddress: 待写入地址    - SendByte: 待写入数据  - DeviceAddress: 器件类型
// 输出  ：返回为:=1成功写入,=0失败
//考虑到用sccb的管脚模拟，比较容易失败，因此多试几次               
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


//接收SCCB总线数据的函数
//返回参数：接收到的数据
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
          
// 函数名：SCCB_ReadByte
// 描述  ：读取一串数据1次
// 输入  ：- pBuffer: 存放读出数据  - length: 待读出长度    - ReadAddress: 待读出地址        - DeviceAddress: 器件类型
// 输出  ：返回为:=1成功读入,=0失败         
uint8 SCCBReadByteOne(uint8 *pBuffer, uint16 length, uint8 ReadAddress)
{
    if(!SCCBStart())
    {
        return 0;
    }
    SCCBSendByte( ADDR_OV7725 );         // 器件地址 
    if( !SCCBWaitAck() )
    {
        SCCBStop();
        return 0;
    }
    SCCBSendByte( ReadAddress );           // 设置低起始地址 
    SCCBWaitAck();
    SCCBStop();

    if(!SCCBStart())
    {
        return 0;
    }
    SCCBSendByte( ADDR_OV7725 + 1 );               // 器件地址 

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


// 函数名：SCCB_ReadByte
// 描述  ：读取一串数据多次， 真正extern的函数
// 输入  ：- pBuffer: 存放读出数据  - length: 待读出长度    - ReadAddress: 待读出地址        - DeviceAddress: 器件类型
// 输出  ：返回为:=1成功读入,=0失败  

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

//=======================Demok的SCCB库
//SCCB应答信号函数
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

          
//SCCB无应答信号函数
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



//  功能说明：sccb字节写入         
//  参数说明：data--待写入字节内容
//  函数返回：ack--应答信号
//            ack=1未收到应答    ack=0收到应答
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

//  功能说明：在指定设备的指定地址中写入指定数据        
//  参数说明：device--摄像头设备号（其中OV7620写为0X42   OV7640写为0X42  OV6620写为0XC0），已固定为ADDR_OV7725
//            address--要写入的地址
//            data--要写入的数据
uint8 SCCBWriteByte(uint16 address, uint8 data)
{
  uint8 i;
  uint8 ack1, ack2, ack3;
  
  for( i=0; i<20; i++)         ///尝试20次
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


//接收SCCB总线数据的函数
//返回参数：接收到的数据
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




// 函数名：SCCB_ReadByte
// 描述  ：读取一串数据1次
// 输入  ：- pBuffer: 存放读出数据  - length: 待读出长度    - ReadAddress: 待读出地址        - DeviceAddress: 器件类型
// 输出  ：返回为:=1成功读入,=0失败         
// 备注  ：该函数会尝试30次，只要有一次成功，就会执行到最后的return 1, 全部失败后，会执行return 0
uint8 SCCBReadByte(uint8 *pBuffer, uint16 length, uint8 ReadAddress)
{
    uint8 i; 
    uint8 ack1, ack2, ack3, ack4, ack5;
    
    for(i = 0; i < 30; i++)
    {
      SCCBStart();                         //开始信号
      ack1 = SCCBSendByte( ADDR_OV7725 );         // 器件地址
      if( ack1 == 1 )
      {
      // sccb_stop();
        continue;
      }  
      ack2 = SCCBSendByte( ReadAddress );           // 设置低起始地址 
      if( ack2 == 1 )
      {
      // sccb_stop();
      continue;
      }      
      SCCBStop();              

      //重启一次
      SCCBStart();      
      ack3 = SCCBSendByte( ADDR_OV7725 + 1 );               // 器件地址 
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
    
    } // end of for循环
    return 0;
}


*/


