//==============================================================================
//�ļ����ƣ�Flash.c
//���ܸ�Ҫ��K60 Flash����/д��ײ���������Դ�ļ�
//==============================================================================
#include "Flash.h" 

//=======================�ڲ����ú�������=======================================
//==============================================================================
//�������ƣ�hw_flash_sign_off
//�������أ���
//����˵������
//���ܸ�Ҫ������Flash�洢�����������FlashԤ��ȡ����
//==============================================================================
static void hw_flash_sign_off(void);

//==============================================================================
//�������ƣ�hw_flash_cmd_launch
//�������أ�0-�ɹ� 1-ʧ��
//����˵������
//���ܸ�Ҫ������Flash����
//==============================================================================
static uint32 hw_flash_cmd_launch(void);

//==============================================================================

//=================�ⲿ�ӿں���=================================================
//==============================================================================
//�������ƣ�FlashInit
//�������أ���
//����˵������
//���ܸ�Ҫ����ʼ��Flashģ��
//==============================================================================
void FlashInit(void)
{
  //���FMC������
  hw_flash_sign_off();
    
  //��ֹ���Ź�
  WDOG_UNLOCK = 0xC520;//Writing the unlock sequence values to this register to make the watchdog write-once registers writable 
                       //again. The required unlock squence is 0xc520 followed by 0xd928 within 20 bus clock cycles. A valid 
                       //unlock sequence opens a window equal in length to the WCT within which you can update the registers.
                       // writing a value other than the above mentioned sequence or if the ssequence is longer than 20 bus cycles,
                       //reset the system or if IRQRSTEN is set,it interrupts and then resets the system. The unlock sequence is effective 
                       // only if ALLOWUPDATE is set.
  WDOG_UNLOCK = 0xD928;
  WDOG_STCTRLH = 0;
    
  //�ȴ��������
  while(!(FTFL_FSTAT & CCIF));
    
  //������ʳ����־λ
  FTFL_FSTAT = ACCERR | FPVIOL;
}

//==============================================================================
//�������ƣ�FlashEraseSector
//�������أ�����ִ��ִ��״̬��0=��������0=�쳣��
//����˵����sectorNo�������ţ�K60N512ʵ��ʹ��0~255��
//���ܸ�Ҫ������ָ��flash����
//==============================================================================
uint8 FlashEraseSector(uint16 sectorNo)
{
  union
  {
    uint32  word;
    uint8   byte[4];
  }dest;
    
  dest.word = (uint32)(sectorNo*(1<<11));

  //���ò�������
  FTFL_FCCOB0 = ERSSCR;   //lyx: ERSSCR: 0x09 ����Flash����
    
  //����Ŀ���ַ
  FTFL_FCCOB1 = dest.byte[2];
  FTFL_FCCOB2 = dest.byte[1];
  FTFL_FCCOB3 = dest.byte[0];
    
  //ִ����������
  if(1 == hw_flash_cmd_launch())    //��ִ��������ִ���
    return 1;     //�����������
   
  //������sector0ʱ��������豸
  if(dest.word <= 0x800)
  {
    //д��4�ֽ�
    FTFL_FCCOB0 = PGM4; 
    //����Ŀ���ַ
    FTFL_FCCOB1 = 0x00;
    FTFL_FCCOB2 = 0x04;
    FTFL_FCCOB3 = 0x0C;
    //����
    FTFL_FCCOB4 = 0xFF;
    FTFL_FCCOB5 = 0xFF;
    FTFL_FCCOB6 = 0xFF;
    FTFL_FCCOB7 = 0xFE;
    //ִ����������
    if(1 == hw_flash_cmd_launch())  //��ִ��������ִ���
      return 2;   //�����������
    }  
    
    return 0;  //�ɹ�����
}

//==============================================================================
//�������ƣ�FlashWrite
//�������أ�����ִ��״̬��0=��������0=�쳣��
//����˵����sectNo��Ŀ�������� ��K60N512ʵ��ʹ��0~255��
//          offset:д�������ڲ�ƫ�Ƶ�ַ��0~2043��
//          cnt��д���ֽ���Ŀ��0~2043��
//          buf��Դ���ݻ������׵�ַ
//���ܸ�Ҫ��flashд�����
//==============================================================================
uint8 FlashWrite(uint16 sectNo,uint16 offset,uint16 cnt,uint8 buf[])
{
  uint32 size;
  uint32 destaddr;
    
  union
  {
    uint32   word;
    uint8_t  byte[4];
  }dest;
    
  if(offset%4 != 0)
    return 1;   //�����趨����ƫ����δ���루4�ֽڶ��룩
    
  //����д������
  FTFL_FCCOB0 = PGM4;
  destaddr = (uint32)(sectNo*(1<<11) + offset);//�����ַ
  dest.word = destaddr;
  for(size=0; size<cnt; size+=4, dest.word+=4, buf+=4)
  {
    //����Ŀ���ַ
    FTFL_FCCOB1 = dest.byte[2];
    FTFL_FCCOB2 = dest.byte[1];
    FTFL_FCCOB3 = dest.byte[0];
 
    //��������
    FTFL_FCCOB4 = buf[3];
    FTFL_FCCOB5 = buf[2];
    FTFL_FCCOB6 = buf[1];
    FTFL_FCCOB7 = buf[0];
        
    if(1 == hw_flash_cmd_launch()) 
      return 2;  //д���������
  }
  return 0;  //�ɹ�ִ��
}

//========================�ڲ�����ʵ��==========================================
//==============================================================================
//�������ƣ�hw_flash_sign_off
//�������أ���
//����˵������
//���ܸ�Ҫ������Flash�洢�����������FlashԤ��ȡ����
//==============================================================================
void hw_flash_sign_off(void)
{  
  //�������
  FMC_PFB0CR |= FMC_PFB0CR_S_INV_MASK;//p724 S_INV:invalidate Prefetch Speculation Buffer
                                              //S_INV bit determines if the FMC's prefetch speculation buffer is to be invalidated(cleared).
                                              //When S_INV bit is written ,the prefetch speculation buffer is immediately cleared. Whenever
                                              // flash memory is modified, the prefetch speculation buffer should be cleared. S_INV bit 
                                              // always reads as zero.
  
}

//==============================================================================
//�������ƣ�hw_flash_cmd_launch
//�������أ�0-�ɹ� 1-ʧ��
//����˵������
//���ܸ�Ҫ������Flash����
//==============================================================================
static uint32 hw_flash_cmd_launch(void)
{
  //������ʴ����־λ�ͷǷ����ʱ�־λ
  FTFL_FSTAT = ACCERR | FPVIOL;           //lyx: ACCERR:flash���ʴ����־λ
                                          //lyx: FPVIOL:flash�Ƿ����ʱ�����־λ
  //��������
  FTFL_FSTAT = CCIF;                      //lyx: CCIF:ָ������жϱ�־λ

  //�ȴ��������
  while(!(FTFL_FSTAT & CCIF));

  //�������־
  if(FTFL_FSTAT & (ACCERR | FPVIOL | MGSTAT0))
    return 1 ; //ִ���������
  
  return 0; //ִ������ɹ�
}
//==============================================================================

