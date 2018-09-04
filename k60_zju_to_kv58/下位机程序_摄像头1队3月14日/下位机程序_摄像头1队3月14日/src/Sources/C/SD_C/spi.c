#include "spi.h"


//=================�ڲ���������=============================================

//=========================================================================
//�������ƣ�hw_spi_get_base_address                                                        
//���ܸ�Ҫ����ȡSPI�Ĵ����Ļ�ַ                                                
//����˵����spiNo:SPI��      
//�������أ�SPI�Ļ�ֵַ                                                                  
//=========================================================================
SPI_MemMapPtr hw_spi_get_base_address(uint8 spiNo);

//=================�ӿں���ʵ��=============================================

//=========================================================================
//�������ƣ�hw_spi_init
//����������spiNo��SPIͨ���š�
//          Master:�Ƿ���������
//�������أ���
//���ܸ�Ҫ��SPI��ʼ����
//=========================================================================
void hw_spi_init(uint8 spiNo,uint8 master)
{
    SPI_MemMapPtr BaseAdd = hw_spi_get_base_address(spiNo);
    
    //ʹ��SPIģ��ʱ�ӣ�����SPI���Ź���
    if(spiNo == 0)
    {
        SIM_SCGC6 |= SIM_SCGC6_DSPI0_MASK;
        PORTA_PCR14 = 0 | PORT_PCR_MUX(0x2) | PORT_PCR_DSE_MASK;//PCS0
        PORTA_PCR15 = 0 | PORT_PCR_MUX(0x2) | PORT_PCR_DSE_MASK;//SCK
        PORTA_PCR16 = 0 | PORT_PCR_MUX(0x2) | PORT_PCR_DSE_MASK;//SOUT
        PORTA_PCR17 = 0 | PORT_PCR_MUX(0x2);//SIN
    }
    else if(spiNo == 1)
    {
        SIM_SCGC6 |= SIM_SCGC6_SPI1_MASK;
        PORTE_PCR1 = 0 | PORT_PCR_MUX(0x2) | PORT_PCR_DSE_MASK;//SOUT
        PORTE_PCR2 = 0 | PORT_PCR_MUX(0x2) | PORT_PCR_DSE_MASK;//SCK
        PORTE_PCR3 = 0 | PORT_PCR_MUX(0x2);//SIN
        PORTE_PCR4 = 0 | PORT_PCR_MUX(0x2) | PORT_PCR_DSE_MASK;//PCS0
    }
    else 
    {
        SIM_SCGC3 |= SIM_SCGC3_SPI2_MASK;
    }
    
    SPI_MCR_REG(BaseAdd) = 0 
                 | SPI_MCR_CLR_TXF_MASK     //Clear the Tx FIFO counter.
                 | SPI_MCR_CLR_RXF_MASK     //Clear the Rx FIFO counter.
                 | SPI_MCR_PCSIS_MASK
                 | SPI_MCR_HALT_MASK;

    //�������ӻ�ģʽ���ù���ģʽ
    if(master == MASTER)
    {
        SPI_MCR_REG(BaseAdd) |= SPI_MCR_MSTR_MASK;//�ڿ�ʼҪ��ֹͣ����
        SPI_CTAR_REG(BaseAdd,0) = 0
                       | SPI_CTAR_DBR_MASK
                       | SPI_CTAR_FMSZ(0x08)
                       | SPI_CTAR_PDT_MASK//��ʱ����Ϊ7  ���Ը�С�� ����ÿ�δ������֮��������һ��
                       | SPI_CTAR_BR(0)//2��Ƶ
                       | SPI_CTAR_CPOL_MASK 
                       | SPI_CTAR_CPHA_MASK;
    }
    else
    {
        SPI_CTAR_SLAVE_REG(BaseAdd,0) = 0 
                            | SPI_CTAR_SLAVE_FMSZ(0x08)
                            | SPI_CTAR_SLAVE_CPOL_MASK 
                            | SPI_CTAR_SLAVE_CPHA_MASK; 
    }
 
    SPI_SR_REG(BaseAdd) = (SPI_SR_EOQF_MASK
                         | SPI_SR_TFUF_MASK
                         | SPI_SR_TFFF_MASK
                         | SPI_SR_RFOF_MASK
                         | SPI_SR_RFDF_MASK);
    
    SPI_MCR_REG(BaseAdd) &= ~SPI_MCR_HALT_MASK;
}


//=========================================================================
//�������ƣ�hw_spi_send
//����������spiNo��SPIͨ���š�
//          data[]����Ҫ���͵����ݡ�
//          len�����ݳ��ȡ�
//�������أ���
//���ܸ�Ҫ��SPI�������ݡ�
//=========================================================================
//uint32 hw_spi_send(uint8 spiNo,uint8 data[],uint32 len)
uint32 SPI_ReadWriteByte(uint8 spiNo,unsigned char buffer)
{
    //uint32 i = 0;
    uint32 RX_Data;
    SPI_MemMapPtr BaseAdd = hw_spi_get_base_address(spiNo);
    
    SPI_SR_REG(BaseAdd) = (SPI_SR_EOQF_MASK
         | SPI_SR_TFUF_MASK
         | SPI_SR_TFFF_MASK
         | SPI_SR_RFOF_MASK
         | SPI_SR_RFDF_MASK)
      ;
    SPI_MCR_REG(BaseAdd) |= SPI_MCR_CLR_TXF_MASK | SPI_MCR_CLR_RXF_MASK  ;
#if 0              
    for(i = 0;i < len;i++)
    {
        if(i == (len - 1))
        {
                SPI_PUSHR_REG(BaseAdd) = 0 
                               | SPI_PUSHR_CTAS(0)
                               | SPI_PUSHR_EOQ_MASK
                               | SPI_PUSHR_PCS(1)
                               | SPI_PUSHR_TXDATA(data[i]);
        }
        else
        {
                SPI_PUSHR_REG(BaseAdd) = 0 | SPI_PUSHR_CONT_MASK 
                               | SPI_PUSHR_CTAS(0)
                               | SPI_PUSHR_PCS(1)
                               | SPI_PUSHR_TXDATA(data[i]);
        }
    }
#endif
    
#if 1
    SPI_SR_REG(BaseAdd) |= SPI_SR_TCF_MASK;                         //���������ɱ�־
    
    SPI_PUSHR_REG(BaseAdd) = (SPI_PUSHR_CTAS(0)                     //ѡ��CTAR0�Ĵ������崫������
                          | SPI_PUSHR_EOQ_MASK                      //��֡SPI���������һ֡����
                          | SPI_PUSHR_TXDATA(buffer));              //д������
    
    SPI_MCR_REG(BaseAdd) &= ~SPI_MCR_HALT_MASK;                     //����SPI���ݴ���
    
    while((SPI_SR_REG(BaseAdd) & SPI_SR_TCF_MASK) == 0);            //�ȴ��������

#endif
  
    SPI_SR_REG(BaseAdd) |= SPI_SR_TCF_MASK;                         //���������ɱ�־
    
    while((SPI_SR_REG(BaseAdd) & SPI_SR_RFDF_MASK) == 0);           //�ȴ����ջ���������Ч���ݣ����ȴ�RX FIFO��Ϊ��Ϊֹ
    
    RX_Data = (uint8)SPI_POPR_REG(BaseAdd);                         //��ȡRX FIFO�ڲ�����
    
    SPI_SR_REG(BaseAdd) |= SPI_SR_RFDF_MASK;                        //���RX FIFO��Ϊ�ձ�־
    
    SPI_MCR_REG(BaseAdd) |= SPI_MCR_HALT_MASK;                      //ֹͣSPI���ݴ���
    
    return (RX_Data);

}

//=========================================================================
//�������ƣ�hw_spi_re
//����������spiNo��SPIͨ���š�
//          data[]����Ҫ���յ����ݡ�
//�������أ�0���ɹ� 1��ʧ��
//���ܸ�Ҫ��SPI�������ݡ�
//=========================================================================
uint8 hw_spi_re(uint8 spiNo,uint8 data[])
{
      SPI_MemMapPtr BaseAdd = hw_spi_get_base_address(spiNo);

      if(SPI_SR_REG(BaseAdd) & SPI_SR_RFDF_MASK)
      {
    	      data[0] = (uint8)SPI_POPR_REG(BaseAdd);                
              SPI_SR_REG(BaseAdd) |= SPI_SR_RFDF_MASK;
              return 1;
      }
        SPI_SR_REG(BaseAdd) = (SPI_SR_EOQF_MASK
                              | SPI_SR_TFUF_MASK
                              | SPI_SR_TFFF_MASK
                              | SPI_SR_RFOF_MASK
                              | SPI_SR_RFDF_MASK);

      SPI_MCR_REG(BaseAdd) |= SPI_MCR_CLR_TXF_MASK      //Clear the Tx FIFO counter.
                | SPI_MCR_CLR_RXF_MASK;                 //Clear the Rx FIFO counter.
      return 0;
}

/*
//=========================================================================
//�������ƣ�hw_spi_enable_re_int
//����˵����spiNo: SPI��
//�������أ� ��
//���ܸ�Ҫ����SPI�����ж�
//=========================================================================
void hw_spi_enable_re_int(uint8 spiNo)
{
    SPI_MemMapPtr BaseAdd = hw_spi_get_base_address(spiNo);
    BSET(SPI_RSER_RFDF_RE_SHIFT, SPI_RSER_REG(BaseAdd));//����SPI�����ж�
    enable_irq(spiNo + SPI0IRQ);			 //���������ŵ�IRQ�ж�
}

//=========================================================================
//�������ƣ�hw_spi_disable_re_int
//����˵����spiNo: SPI��
//�������أ� ��
//���ܸ�Ҫ����SPI�����ж�
//=========================================================================
void hw_spi_disable_re_int(uint8 spiNo)
{
    SPI_MemMapPtr BaseAdd = hw_spi_get_base_address(spiNo);
    BCLR(SPI_RSER_RFDF_RE_SHIFT, SPI_RSER_REG(BaseAdd));//�ر�SPI�����ж�
    disable_irq(spiNo + SPI0IRQ);			 //���������ŵ�IRQ�ж�
}
*/




//=================�ڲ�����ʵ��=============================================
//=========================================================================
//�������ƣ�hw_spi_get_base_address
//����������spiNo��SPIͨ����
//�������أ���
//���ܸ�Ҫ����SPIͨ����ת���ɶ�Ӧ��ָ�롣
//=========================================================================
SPI_MemMapPtr hw_spi_get_base_address(uint8 spiNo)
{
    switch(spiNo)
    {
    case 0:
      return SPI0_BASE_PTR;
    case 1:
      return SPI1_BASE_PTR;
    case 2:
      return SPI2_BASE_PTR;
    default:
      return 0;
    }
}
//void lqspiinit(void)
void SPI_Configuration(void)
{
  ///�Ȱ�ʱ�����Ŵ�
        SIM_SCGC6 |= SIM_SCGC6_DSPI0_MASK;
     //   PORTA_PCR14 = 0 | PORT_PCR_MUX(0x2) | PORT_PCR_DSE_MASK;//PCS0
        gpio_init(PTA_BASE_PTR,13,1,0);
        PORTA_PCR15 = 0 | PORT_PCR_MUX(0x2) | PORT_PCR_DSE_MASK;//SCK
        PORTA_PCR16 = 0 | PORT_PCR_MUX(0x2) | PORT_PCR_DSE_MASK;//SOUT
        PORTA_PCR17 = 0 | PORT_PCR_MUX(0x2);                    //SIN
        SPI0_MCR|=SPI_MCR_MSTR_MASK;                            //����ģʽ
	    SPI0_MCR|=SPI_MCR_PCSIS(1);                             //PCS0�͵�ƽ��Ч
        SPI0_MCR&=~SPI_MCR_MDIS_MASK;                           //ʹ��DSPIʱ��
	    SPI0_MCR&=~SPI_MCR_HALT_MASK;                           //����SPIģ��
        SPI0_CTAR0|=SPI_CTAR_DBR_MASK;                          //���������� SCK Duty Cycle
	    SPI0_CTAR0=SPI_CTAR_FMSZ(7);                            //֡��СΪ8bit
	    SPI0_CTAR0|=SPI_CTAR_PBR(0);//Ԥ��Ƶ30M//
                                    //00 Baud Rate Prescaler value is 2
                                    //01 Baud Rate Prescaler value is 3.
                                    //10 Baud Rate Prescaler value is 5.
                                    //11 Baud Rate Prescaler value is 7.
	    SPI0_CTAR0|=SPI_CTAR_BR(0x0100); //���շ�Ƶ180/4=45MHz
                                    //0000 2
                                    //0001 4
                                    //0010 6
                                    //0011 8
                                    //0100 16
                                    //0101 32
                                    //0110 64
                                    //0111 128
                                    //SCK baud rate = (fSYS/PBR) x [(1+DBR)/BR]    
  
}

void SPI_SetSpeed(unsigned char SpeedSet)
{
    if(SpeedSet == SPI_SPEED_LOW)
    {
        SPI0_CTAR0|=SPI_CTAR_DBR_MASK;                          //���������� SCK Duty Cycle
	    SPI0_CTAR0=SPI_CTAR_FMSZ(7);                            //֡��СΪ8bit
	    SPI0_CTAR0|=SPI_CTAR_PBR(0);//Ԥ��Ƶ30M//
                                    //00 Baud Rate Prescaler value is 2
                                    //01 Baud Rate Prescaler value is 3.
                                    //10 Baud Rate Prescaler value is 5.
                                    //11 Baud Rate Prescaler value is 7.
	    SPI0_CTAR0|=SPI_CTAR_BR(0x0100); //���շ�Ƶ180/4=45MHz
                                    //0000 2
                                    //0001 4
                                    //0010 6
                                    //0011 8
                                    //0100 16
                                    //0101 32
                                    //0110 64
                                    //0111 128
                                    //SCK baud rate = (fSYS/PBR) x [(1+DBR)/BR]     
    }
    else
    {
        SPI0_CTAR0|=SPI_CTAR_DBR_MASK;                          //���������� SCK Duty Cycle
	    SPI0_CTAR0=SPI_CTAR_FMSZ(7);                            //֡��СΪ8bit
	    SPI0_CTAR0|=SPI_CTAR_PBR(0);//Ԥ��Ƶ30M//
                                    //00 Baud Rate Prescaler value is 2
                                    //01 Baud Rate Prescaler value is 3.
                                    //10 Baud Rate Prescaler value is 5.
                                    //11 Baud Rate Prescaler value is 7.
      SPI0_CTAR0|=SPI_CTAR_BR(0);
    }
}


#if 0
void lqwrite(unsigned char cmd)
{ 
    SPI0_PUSHR=cmd;
	while((SPI0_SR&SPI_SR_TCF_MASK)==0);//�ȴ��������
	SPI0_SR|=SPI_SR_TCF_MASK;//�����־	

}
#endif