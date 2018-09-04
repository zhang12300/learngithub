//==============================================================================
//文件名称：DMA.c
//功能概要：K60 DMA底层驱动程序文件
//版权所有：HJZ
//端口使用：
//==============================================================================
#include "DMA.h"



volatile uint8 DMAFlag = 0;

/*

// 这是给OV7725准备的DMA初始化函数
uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint32 DMA_Count, uint32 S_Addr, uint32 D_Addr)
{
    //输入变量初步检查
	if (DMA_CHn > 15) return 0;                
	if (DMA_Source > 52) return 0; 

	//DMA通道配置
	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //打开DMA多路复用时钟
	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //打开DMA模块时钟
	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
		                                   | DMAMUX_CHCFG_ENBL_MASK			        // 使能DMA通道 
                                                   //| DMAMUX_CHCFG_TRIG_MASK				// 打开周期性触发模式，注意只有0~3通道支持
                                                   | DMAMUX_CHCFG_SOURCE(DMA_Source)      // 指定DMA触发源 
		                                   );
    
	DMA_CR = 0;												  // 默认配置，需要在DMA被激活之前配置此寄存器
	//DMA_DCHPRIn										      // 默认优先级配置，这里不另更改
	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // 主循环计数器，1个major loop, 即一次传输量=major_loop*minor_loop，最大为2^15=32767 
	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // 主循环计数器复位值，BITER应该等于CITER 
	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // 每次minor loop传送1个字节

	//源地址操作
	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMA源地址
	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // 每次读源地址后，增加的字节数
	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA所有主循环完成后，源地址的增量

	//目的地址操作
	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMA目标地址 
	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // 每次写目的地址后，增加的字节数
	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = 0x00;		      // DMA所有主循环完成后，目的地址的增量
	
	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
		                              | DMA_ATTR_SSIZE(0)	  // 源数据宽度，   8位传送 
		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
		                              | DMA_ATTR_DSIZE(0)	  // 目的数据宽度， 8位传送 
		                              );

	//CSR寄存器操作
	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;						  // 先清零CSR，之后再设置 
        DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_BWC(3);    //每读1次，eDMA引擎停止8个周期
	DMA_INT |= (1<<DMA_CHn);	                        // 1次主循环传输完成后的中断标志位，清零 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1次主循环传输完成后的中断使能位，使能 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1次DMA传输完成后，自动清REQ位，停止工作 

	//DMA启停位
	DMA_ERQ &= ~(1 << DMA_CHn);						      // 关闭相应通道的DMA请求，在配置阶段先关闭，再调用myDMA_Start函数开启DMA 
                                                              
	return 1;

}// end of DMAInit()


*/




//------------------------------------------------------------------------------
//函数名：DMAInit
//功  能：DMA初始化
//参  数：
//        DMA_CHn--指定的DMA通道号，范围0~15；
//        DMA_Source--DMA触发源，在DMA.h文件里有枚举定义
//        S_Addr--DMA传送源地址
//        D_Addr--DMA传送目的地址
//返  回：无
//说  明：对应OV7620，不是7725。7725用不到行中断。
//        1. 1次PCLK的硬件触发会导致1次DMA主循环，1次DMA主循环传输只有1个8位数据的传送，传送完成后目的地址会加1，直至目的数组被填满。
//        2. CAMERA_LINE次主循环后，视为"DMA传输完成"，会引发DMA传输完成中断，进入DMA传输完成中断服务函数。
//        3. DMA传输完成中断服务函数中，先清DMA传输完成中断标志位，再把行数加1。
//        4. 初始化时只打开场中断和DMA传输完成中断的IRQ，场中断中，先清自身标志位，然后初始化行数，然后打开行中断，并重复一次DMA的初始化。
//        5. 行中断中，先清自身标志位，如果没超过，就打开ERQ,如果超过了，就关行中断的IRQ。
//
//        

//------------------------------------------------------------------------------


//这是给OV7620准备的DMA初始化函数，暂时先不要动
//DMA通道0，B0~B7为数据源地址，ImgSotre数组为目的地址。
//每次硬件触发传送1字节，同时目标地址加1个字节。
//采集完1行像素后进入DMA中断，此时源地址不变，目的地址加1行像素所占字节数。
uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint16 DMA_Count, uint32 S_Addr, uint32 D_Addr)
{
    //输入变量初步检查
	if (DMA_CHn > 15) return 0;                
	if (DMA_Source > 52) return 0; 

	//DMA通道配置
	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //打开DMA多路复用时钟
	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //打开DMA模块时钟
	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
	                                           | DMAMUX_CHCFG_ENBL_MASK		// 使能DMA通道 
                                                 //| DMAMUX_CHCFG_TRIG_MASK		// 打开周期性触发模式，注意只有0~3通道支持
                                                   | DMAMUX_CHCFG_SOURCE(DMA_Source) // 指定DMA触发源 
                                                    );
    
	DMA_CR = 0;												  // 默认配置，需要在DMA被激活之前配置此寄存器
	//DMA_DCHPRIn										      // 默认优先级配置，这里不另更改
	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // 主循环计数器，1个major loop, 即一次传输量=major_loop*minor_loop，最大为2^15=32767 
	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(DMA_Count); // 主循环计数器复位值，BITER应该等于CITER 
	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // 每次minor loop传送1个字节

	//源地址操作
	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMA源地址
	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // 每次读源地址后，增加的字节数
	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA所有主循环完成后，源地址的增量

	//目的地址操作
	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMA目标地址 
	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // 每次写目的地址后，增加的字节数
	//DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = CameraWidth;		      // DMA所有主循环完成后，目的地址的增量
	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = 0;      /////////////////////////两个数字不知道哪个是对的
        
	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
		                              | DMA_ATTR_SSIZE(0)	  // 源数据宽度，   8位传送 
		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
		                              | DMA_ATTR_DSIZE(0)	  // 目的数据宽度， 8位传送 
		                              );

	//CSR寄存器操作
	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;				// 先清零CSR，之后再设置 
	DMA_INT |= (1<<DMA_CHn);					// 1次主循环传输完成后的中断标志位，清零 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1次主循环传输完成后的中断使能位，使能 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1次DMA传输完成后，自动清REQ位，停止工作 

	//DMA启停位
	DMA_ERQ &= ~(1 << DMA_CHn);		// 关闭相应通道的DMA请求，在配置阶段先关闭
                                                              // 所有主循环(不是1次主循环)完成后，ERQ会被自动清零，需要行中断中再次手动开启。
	return 1;

}// end of DMAInit()


/*  这是给DMA测试专用的DMA初始化函数，暂时不用动
uint8 DMAInit(uint8 DMA_CHn, uint8 DMA_Source, uint32 S_Addr, uint32 D_Addr)
{
    //输入变量初步检查
	if (DMA_CHn > 15) return 0;                
	if (DMA_Source > 52) return 0; 

	//DMA通道配置
	SIM_SCGC6 |= SIM_SCGC6_DMAMUX_MASK;    //打开DMA多路复用时钟
	SIM_SCGC7 |= SIM_SCGC7_DMA_MASK;       //打开DMA模块时钟
	DMAMUX_CHCFG_REG(DMAMUX_BASE_PTR, DMA_CHn) = (0
												  | DMAMUX_CHCFG_ENBL_MASK			        // 使能DMA通道 
												  //| DMAMUX_CHCFG_TRIG_MASK				// 打开周期性触发模式，注意只有0~3通道支持
												  | DMAMUX_CHCFG_SOURCE(DMA_Source)      // 指定DMA触发源 
												  );
    
	DMA_CR = 0;												  // 默认配置，需要在DMA被激活之前配置此寄存器
	//DMA_DCHPRIn										      // 默认优先级配置，这里不另更改
	DMA_BASE_PTR->TCD[DMA_CHn].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(10); // 主循环计数器，1个major loop, 即一次传输量=major_loop*minor_loop，最大为2^15=32767 
	DMA_BASE_PTR->TCD[DMA_CHn].BITER_ELINKNO = DMA_CITER_ELINKNO_CITER(10); // 主循环计数器复位值，BITER应该等于CITER 
	DMA_BASE_PTR->TCD[DMA_CHn].NBYTES_MLNO = 1;				  // 每次minor loop传送1个字节

	//源地址操作
	DMA_BASE_PTR->TCD[DMA_CHn].SADDR = S_Addr;				  // DMA源地址
	DMA_BASE_PTR->TCD[DMA_CHn].SOFF  = 0x0000;				  // 每次读源地址后，增加的字节数
	DMA_BASE_PTR->TCD[DMA_CHn].SLAST = 0x00;			      // DMA所有主循环完成后，源地址的增量

	//目的地址操作
	DMA_BASE_PTR->TCD[DMA_CHn].DADDR = D_Addr;				  // DMA目标地址 
	DMA_BASE_PTR->TCD[DMA_CHn].DOFF  = 0x0001;				  // 每次写目的地址后，增加的字节数
	DMA_BASE_PTR->TCD[DMA_CHn].DLAST_SGA = -10;		      // DMA所有主循环完成后，目的地址的增量
	
	DMA_BASE_PTR->TCD[DMA_CHn].ATTR  =(0 
		                              |DMA_ATTR_SMOD(0)		  // Source modulo feature disabled 
		                              | DMA_ATTR_SSIZE(0)	  // 源数据宽度，   8位传送 
		                              | DMA_ATTR_DMOD(0) 	  // Destination modulo feature disabled 
		                              | DMA_ATTR_DSIZE(0)	  // 目的数据宽度， 8位传送 
		                              );

	//CSR寄存器操作
	DMA_BASE_PTR->TCD[DMA_CHn].CSR = 0;						  // 先清零CSR，之后再设置 
	DMA_INT |= (1<<DMA_CHn);						// 1次主循环传输完成后的中断标志位，清零 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_INTMAJOR_MASK; // 1次主循环传输完成后的中断使能位，使能 
	DMA_BASE_PTR->TCD[DMA_CHn].CSR |= DMA_CSR_DREQ_MASK;      // 1次DMA传输完成后，自动清REQ位，停止工作 

	//DMA启停位
	DMA_ERQ &= ~(1 << DMA_CHn);						      // 关闭相应通道的DMA请求，在配置阶段先关闭，再调用myDMA_Start函数开启DMA 
                                                              // 所有主循环(不是1次主循环)完成后，ERQ会被自动清零，需要行中断中再次手动开启。
	return 1;

}// end of DMAInit()

*/

//下面几个函数应该放在isr.c 中，只是暂存于此
/*
void DMA_CHO_ISR(void)
{
		DMA_INT|=DMA_INT_INT0_MASK;//清除通道0中断
			//putstr("DMA complete！");
				row_F[imagerow]=1;//采集完成标志
					imagerow++;	
}









void portb_isr(void)//行中断，B10，上升沿中断
{
	PORTB_PCR10|=PORT_PCR_ISF_MASK;//清除中断标志位
	row++; //行计数
	if(row==data_table[imagerow])//如果当前行数据应该采集 
		{
		DMA_ERQ|=DMA_ERQ_ERQ0_MASK;//使能通道0硬件DMA请求  
		}
	  else if(row>=ENDROW) //一场完成，关闭行中断
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
    enable_irq(0);			      //开DMA通道0的IRQ中断
    break;
    case 1:
    enable_irq(1);			      //开DMA通道1的IRQ中断
    break;
    case 2:
    enable_irq(2);			     //开DMA通道2的IRQ中断
    break;
    case 3:
    enable_irq(3);			      //开DMA通道3的IRQ中断
    break;
    case 4:
    enable_irq(4);			      //开DMA通道4的IRQ中断
    break;
    case 5:
    enable_irq(5);			      //开DMA通道5的IRQ中断
    break;
    case 6:
    enable_irq(6);			     //开DMA通道6的IRQ中断
    break;
    case 7:
    enable_irq(7);			      //开DMA通道7的IRQ中断
    break;
    case 8:
    enable_irq(8);			      //开DMA通道8的IRQ中断
    break;
    case 9:
    enable_irq(9);			      //开DMA通道9的IRQ中断
    break;
    case 10:
    enable_irq(10);			     //开DMA通道10的IRQ中断
    break;
    case 11:
    enable_irq(11);			      //开DMA通道11的IRQ中断
    break;
    case 12:
    enable_irq(12);			      //开DMA通道12的IRQ中断
    break;
    case 13:
    enable_irq(13);			      //开DMA通道13的IRQ中断
    break;
    case 14:
    enable_irq(14);			     //开DMA通道14的IRQ中断
    break;
    case 15:
    enable_irq(15);			      //开DMA通道15的IRQ中断
    break;
    
    default:
    break;
  }    
}











































