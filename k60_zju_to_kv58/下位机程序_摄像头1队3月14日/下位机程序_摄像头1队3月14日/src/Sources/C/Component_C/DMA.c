//==============================================================================
//�ļ����ƣ�DMA.c
//���ܸ�Ҫ��K60 DMA�ײ����������ļ�
//��Ȩ���У�HJZ
//�˿�ʹ�ã�
//==============================================================================
#include "DMA.h"



volatile uint8 DMAFlag = 0;

/*

// ���Ǹ�OV7725׼����DMA��ʼ������
uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint32 DMA_Count, uint32 S_Addr, uint32 D_Addr)
{
    //��������������
	if (DMA_CHn > 15) return 0;                
	if (DMA_Source > 52) return 0; 

	//DMAͨ������
	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //��DMA��·����ʱ��
	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //��DMAģ��ʱ��
	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
		                                   | DMAMUX_CHCFG_ENBL_MASK			        // ʹ��DMAͨ�� 
                                                   //| DMAMUX_CHCFG_TRIG_MASK				// �������Դ���ģʽ��ע��ֻ��0~3ͨ��֧��
                                                   | DMAMUX_CHCFG_SOURCE(DMA_Source)      // ָ��DMA����Դ 
		                                   );
    
	DMA_CR = 0;												  // Ĭ�����ã���Ҫ��DMA������֮ǰ���ô˼Ĵ���
	//DMA_DCHPRIn										      // Ĭ�����ȼ����ã����ﲻ�����
	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // ��ѭ����������1��major loop, ��һ�δ�����=major_loop*minor_loop�����Ϊ2^15=32767 
	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // ��ѭ����������λֵ��BITERӦ�õ���CITER 
	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // ÿ��minor loop����1���ֽ�

	//Դ��ַ����
	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMAԴ��ַ
	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // ÿ�ζ�Դ��ַ�����ӵ��ֽ���
	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA������ѭ����ɺ�Դ��ַ������

	//Ŀ�ĵ�ַ����
	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMAĿ���ַ 
	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // ÿ��дĿ�ĵ�ַ�����ӵ��ֽ���
	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = 0x00;		      // DMA������ѭ����ɺ�Ŀ�ĵ�ַ������
	
	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
		                              | DMA_ATTR_SSIZE(0)	  // Դ���ݿ�ȣ�   8λ���� 
		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
		                              | DMA_ATTR_DSIZE(0)	  // Ŀ�����ݿ�ȣ� 8λ���� 
		                              );

	//CSR�Ĵ�������
	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;						  // ������CSR��֮�������� 
        DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_BWC(3);    //ÿ��1�Σ�eDMA����ֹͣ8������
	DMA_INT |= (1<<DMA_CHn);	                        // 1����ѭ��������ɺ���жϱ�־λ������ 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1����ѭ��������ɺ���ж�ʹ��λ��ʹ�� 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1��DMA������ɺ��Զ���REQλ��ֹͣ���� 

	//DMA��ͣλ
	DMA_ERQ &= ~(1 << DMA_CHn);						      // �ر���Ӧͨ����DMA���������ý׶��ȹرգ��ٵ���myDMA_Start��������DMA 
                                                              
	return 1;

}// end of DMAInit()


*/




//------------------------------------------------------------------------------
//��������DMAInit
//��  �ܣ�DMA��ʼ��
//��  ����
//        DMA_CHn--ָ����DMAͨ���ţ���Χ0~15��
//        DMA_Source--DMA����Դ����DMA.h�ļ�����ö�ٶ���
//        S_Addr--DMA����Դ��ַ
//        D_Addr--DMA����Ŀ�ĵ�ַ
//��  �أ���
//˵  ������ӦOV7620������7725��7725�ò������жϡ�
//        1. 1��PCLK��Ӳ�������ᵼ��1��DMA��ѭ����1��DMA��ѭ������ֻ��1��8λ���ݵĴ��ͣ�������ɺ�Ŀ�ĵ�ַ���1��ֱ��Ŀ�����鱻������
//        2. CAMERA_LINE����ѭ������Ϊ"DMA�������"��������DMA��������жϣ�����DMA��������жϷ�������
//        3. DMA��������жϷ������У�����DMA��������жϱ�־λ���ٰ�������1��
//        4. ��ʼ��ʱֻ�򿪳��жϺ�DMA��������жϵ�IRQ�����ж��У����������־λ��Ȼ���ʼ��������Ȼ������жϣ����ظ�һ��DMA�ĳ�ʼ����
//        5. ���ж��У����������־λ�����û�������ʹ�ERQ,��������ˣ��͹����жϵ�IRQ��
//
//        

//------------------------------------------------------------------------------


//���Ǹ�OV7620׼����DMA��ʼ����������ʱ�Ȳ�Ҫ��
//DMAͨ��0��B0~B7Ϊ����Դ��ַ��ImgSotre����ΪĿ�ĵ�ַ��
//ÿ��Ӳ����������1�ֽڣ�ͬʱĿ���ַ��1���ֽڡ�
//�ɼ���1�����غ����DMA�жϣ���ʱԴ��ַ���䣬Ŀ�ĵ�ַ��1��������ռ�ֽ�����
uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint16 DMA_Count, uint32 S_Addr, uint32 D_Addr)
{
    //��������������
	if (DMA_CHn > 15) return 0;                
	if (DMA_Source > 52) return 0; 

	//DMAͨ������
	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //��DMA��·����ʱ��
	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //��DMAģ��ʱ��
	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
	                                           | DMAMUX_CHCFG_ENBL_MASK		// ʹ��DMAͨ�� 
                                                 //| DMAMUX_CHCFG_TRIG_MASK		// �������Դ���ģʽ��ע��ֻ��0~3ͨ��֧��
                                                   | DMAMUX_CHCFG_SOURCE(DMA_Source) // ָ��DMA����Դ 
                                                    );
    
	DMA_CR = 0;												  // Ĭ�����ã���Ҫ��DMA������֮ǰ���ô˼Ĵ���
	//DMA_DCHPRIn										      // Ĭ�����ȼ����ã����ﲻ�����
	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // ��ѭ����������1��major loop, ��һ�δ�����=major_loop*minor_loop�����Ϊ2^15=32767 
	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // ��ѭ����������λֵ��BITERӦ�õ���CITER 
	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // ÿ��minor loop����1���ֽ�

	//Դ��ַ����
	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMAԴ��ַ
	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // ÿ�ζ�Դ��ַ�����ӵ��ֽ���
	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA������ѭ����ɺ�Դ��ַ������

	//Ŀ�ĵ�ַ����
	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMAĿ���ַ 
	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // ÿ��дĿ�ĵ�ַ�����ӵ��ֽ���
	//DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = CameraWidth;		      // DMA������ѭ����ɺ�Ŀ�ĵ�ַ������
	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = 0;      /////////////////////////�������ֲ�֪���ĸ��ǶԵ�
        
	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
		                              | DMA_ATTR_SSIZE(0)	  // Դ���ݿ�ȣ�   8λ���� 
		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
		                              | DMA_ATTR_DSIZE(0)	  // Ŀ�����ݿ�ȣ� 8λ���� 
		                              );

	//CSR�Ĵ�������
	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;				// ������CSR��֮�������� 
	DMA_INT |= (1<<DMA_CHn);					// 1����ѭ��������ɺ���жϱ�־λ������ 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1����ѭ��������ɺ���ж�ʹ��λ��ʹ�� 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1��DMA������ɺ��Զ���REQλ��ֹͣ���� 

	//DMA��ͣλ
	DMA_ERQ &= ~(1 << DMA_CHn);		// �ر���Ӧͨ����DMA���������ý׶��ȹر�
                                                              // ������ѭ��(����1����ѭ��)��ɺ�ERQ�ᱻ�Զ����㣬��Ҫ���ж����ٴ��ֶ�������
	return 1;

}// end of DMAInit()


/*  ���Ǹ�DMA����ר�õ�DMA��ʼ����������ʱ���ö�
uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint32 S_Addr, uint32 D_Addr)
{
    //��������������
	if (DMA_CHn > 15) return 0;                
	if (DMA_Source > 52) return 0; 

	//DMAͨ������
	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //��DMA��·����ʱ��
	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //��DMAģ��ʱ��
	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
												  | DMAMUX_CHCFG_ENBL_MASK			        // ʹ��DMAͨ�� 
												  //| DMAMUX_CHCFG_TRIG_MASK				// �������Դ���ģʽ��ע��ֻ��0~3ͨ��֧��
												  | DMAMUX_CHCFG_SOURCE(DMA_Source)      // ָ��DMA����Դ 
												  );
    
	DMA_CR = 0;												  // Ĭ�����ã���Ҫ��DMA������֮ǰ���ô˼Ĵ���
	//DMA_DCHPRIn										      // Ĭ�����ȼ����ã����ﲻ�����
	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(10); // ��ѭ����������1��major loop, ��һ�δ�����=major_loop*minor_loop�����Ϊ2^15=32767 
	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(10); // ��ѭ����������λֵ��BITERӦ�õ���CITER 
	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // ÿ��minor loop����1���ֽ�

	//Դ��ַ����
	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMAԴ��ַ
	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // ÿ�ζ�Դ��ַ�����ӵ��ֽ���
	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA������ѭ����ɺ�Դ��ַ������

	//Ŀ�ĵ�ַ����
	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMAĿ���ַ 
	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // ÿ��дĿ�ĵ�ַ�����ӵ��ֽ���
	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = -10;		      // DMA������ѭ����ɺ�Ŀ�ĵ�ַ������
	
	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
		                              | DMA_ATTR_SSIZE(0)	  // Դ���ݿ�ȣ�   8λ���� 
		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
		                              | DMA_ATTR_DSIZE(0)	  // Ŀ�����ݿ�ȣ� 8λ���� 
		                              );

	//CSR�Ĵ�������
	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;						  // ������CSR��֮�������� 
	DMA_INT |= (1<<DMA_CHn);						// 1����ѭ��������ɺ���жϱ�־λ������ 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1����ѭ��������ɺ���ж�ʹ��λ��ʹ�� 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1��DMA������ɺ��Զ���REQλ��ֹͣ���� 

	//DMA��ͣλ
	DMA_ERQ &= ~(1 << DMA_CHn);						      // �ر���Ӧͨ����DMA���������ý׶��ȹرգ��ٵ���myDMA_Start��������DMA 
                                                              // ������ѭ��(����1����ѭ��)��ɺ�ERQ�ᱻ�Զ����㣬��Ҫ���ж����ٴ��ֶ�������
	return 1;

}// end of DMAInit()

*/

//���漸������Ӧ�÷���isr.c �У�ֻ���ݴ��ڴ�
/*
void DMA_CHO_ISR(void)
{
		DMA_INT|=DMA_INT_INT0_MASK;//���ͨ��0�ж�
			//putstr("DMA complete��");
				row_F[imagerow]=1;//�ɼ���ɱ�־
					imagerow++;	
}









void portb_isr(void)//���жϣ�B10���������ж�
{
	PORTB_PCR10|=PORT_PCR_ISF_MASK;//����жϱ�־λ
	row++; //�м���
	if(row==data_table[imagerow])//�����ǰ������Ӧ�òɼ� 
		{
		DMA_ERQ|=DMA_ERQ_ERQ0_MASK;//ʹ��ͨ��0Ӳ��DMA����  
		}
	  else if(row>=ENDROW) //һ����ɣ��ر����ж�
	  	{
		  disable_irq (88);
		  	 displaypara(row,6,60);

	  	}
}
*/


void enable_DMA_irq(uint8 DMAno)
{
  switch(DMAno)
  {
    case 0:
    enable_irq(0);			      //��DMAͨ��0��IRQ�ж�
    break;
    case 1:
    enable_irq(1);			      //��DMAͨ��1��IRQ�ж�
    break;
    case 2:
    enable_irq(2);			     //��DMAͨ��2��IRQ�ж�
    break;
    case 3:
    enable_irq(3);			      //��DMAͨ��3��IRQ�ж�
    break;
    case 4:
    enable_irq(4);			      //��DMAͨ��4��IRQ�ж�
    break;
    case 5:
    enable_irq(5);			      //��DMAͨ��5��IRQ�ж�
    break;
    case 6:
    enable_irq(6);			     //��DMAͨ��6��IRQ�ж�
    break;
    case 7:
    enable_irq(7);			      //��DMAͨ��7��IRQ�ж�
    break;
    case 8:
    enable_irq(8);			      //��DMAͨ��8��IRQ�ж�
    break;
    case 9:
    enable_irq(9);			      //��DMAͨ��9��IRQ�ж�
    break;
    case 10:
    enable_irq(10);			     //��DMAͨ��10��IRQ�ж�
    break;
    case 11:
    enable_irq(11);			      //��DMAͨ��11��IRQ�ж�
    break;
    case 12:
    enable_irq(12);			      //��DMAͨ��12��IRQ�ж�
    break;
    case 13:
    enable_irq(13);			      //��DMAͨ��13��IRQ�ж�
    break;
    case 14:
    enable_irq(14);			     //��DMAͨ��14��IRQ�ж�
    break;
    case 15:
    enable_irq(15);			      //��DMAͨ��15��IRQ�ж�
    break;
    
    default:
    break;
  }    
}











































