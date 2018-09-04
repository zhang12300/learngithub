///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.30.3.8024/W32 for ARM       14/Mar/2018  19:12:14
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\C\Function_C\VirtualScope.c
//    Command line =  
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\C\Function_C\VirtualScope.c
//        -D IAR -D TWR_K60N512 -lCN
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\FLASH\List\ -lB
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\FLASH\List\ -o
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\FLASH\Obj\ --no_cse
//        --no_unroll --no_inline --no_code_motion --no_tbaa --no_clustering
//        --no_scheduling --debug --endian=little --cpu=Cortex-M4 -e --fpu=None
//        --dlib_config "C:\Program Files (x86)\IAR Systems\Embedded Workbench
//        7.0\arm\INC\c\DLib_Config_Normal.h" -I
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\H\ -I
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\H\Component_H\
//        -I E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\H\Frame_H\
//        -I
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\H\Function_H\
//        -I E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\H\SD_H\ -Ol
//        --use_c++_inline
//    List file    =  
//        E:\���ܳ�\����\��λ������_����ͷ1��3��9��\FLASH\List\VirtualScope.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN BrickSpeDealBackCount
        EXTERN BrickSpeDealCenFlag
        EXTERN BrickSpeDealFlag
        EXTERN DeviFuse
        EXTERN DeviPre
        EXTERN GyroResultFlag
        EXTERN LightHouseWaitStopDelayFlag
        EXTERN PathRealStraightFlag
        EXTERN PathType
        EXTERN ServoPIDInputVal
        EXTERN ShiZhiFlag
        EXTERN SlopeC
        EXTERN SpeedLeftVal
        EXTERN SpeedNowLeft
        EXTERN SpeedTargetLeftVal
        EXTERN StopFlag
        EXTERN StopRealFlag
        EXTERN __aeabi_f2iz
        EXTERN __aeabi_i2f
        EXTERN __aeabi_memclr4
        EXTERN __aeabi_ui2f
        EXTERN uart_send1

        PUBLIC CRC_CHECK
        PUBLIC ErrorCountNow6
        PUBLIC FreeCarsDataNum
        PUBLIC Virtual2DataPush
        PUBLIC Virtual2Send
        PUBLIC Virtual2SendData
        PUBLIC VirtualOutData
        PUBLIC VirtualOutPut_Data
        PUBLIC VirtualScopeSend
        PUBLIC tic1
        PUBLIC tic2
        PUBLIC tic3
        PUBLIC tic4
        PUBLIC tic5
        PUBLIC tic6
        PUBLIC tic7
        PUBLIC toc1
        PUBLIC toc2
        PUBLIC toc3
        PUBLIC toc4
        PUBLIC toc5
        PUBLIC toc6
        PUBLIC toc7
        PUBLIC uSendBuf

// E:\���ܳ�\����\��λ������_����ͷ1��3��9��\src\Sources\C\Function_C\VirtualScope.c
//    1 /******************************************************************************/
//    2 /*******************************************************************************
//    3   �ļ���������ʾ����C�ļ�VirtualScope.c
//    4   ��  �ܣ�������ʾ������������
//    5   ��  �ڣ�2014.11.18
//    6   ��  �ߣ�
//    7   ��  ע��
//    8 *******************************************************************************/
//    9 /******************************************************************************/
//   10 
//   11 #include "VirtualScope.h"
//   12 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   13 int16 ErrorCountNow6 = 0;
ErrorCountNow6:
        DS8 2
//   14 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   15 uint32 tic1;  //��ʱ����ʼ������¼��ʱ����ֵ��
tic1:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   16 uint32 toc1;  //��ʱ����ֹ������¼��ʱ����ֵ��
toc1:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   17 uint32 tic2;  //��ʱ����ʼ������¼��ʱ����ֵ��
tic2:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   18 uint32 toc2;  //��ʱ����ֹ������¼��ʱ����ֵ��
toc2:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   19 uint32 tic3;  //��ʱ����ʼ������¼��ʱ����ֵ��
tic3:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   20 uint32 toc3;  //��ʱ����ֹ������¼��ʱ����ֵ��
toc3:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   21 uint32 tic4;  //��ʱ����ʼ������¼��ʱ����ֵ��
tic4:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   22 uint32 toc4;  //��ʱ����ֹ������¼��ʱ����ֵ��
toc4:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   23 uint32 tic5;  //��ʱ����ʼ������¼��ʱ����ֵ��
tic5:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   24 uint32 toc5;  //��ʱ����ֹ������¼��ʱ����ֵ��
toc5:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   25 uint32 tic6;  //��ʱ����ʼ������¼��ʱ����ֵ��
tic6:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   26 uint32 toc6;  //��ʱ����ֹ������¼��ʱ����ֵ��
toc6:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   27 uint32 tic7;  //��ʱ����ʼ������¼��ʱ����ֵ��
tic7:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   28 uint32 toc7;  //��ʱ����ֹ������¼��ʱ����ֵ��
toc7:
        DS8 4
//   29 
//   30 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   31 uint8 uSendBuf[UartDataNum*2]={0};
uSendBuf:
        DS8 36

        SECTION `.data`:DATA:REORDER:NOROOT(0)
//   32 uint8 FreeCarsDataNum=UartDataNum*2;
FreeCarsDataNum:
        DATA
        DC8 34
//   33 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   34 float VirtualOutData[4] = { 0 };
VirtualOutData:
        DS8 16
//   35 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   36 unsigned short CRC_CHECK(unsigned char *Buf, unsigned char CRC_CNT)
//   37 {
CRC_CHECK:
        PUSH     {R4,R5}
//   38     unsigned short CRC_Temp;
//   39     unsigned char i,j;
//   40     CRC_Temp = 0xffff;
        MOVW     R2,#+65535
//   41 
//   42     for (i=0;i<CRC_CNT; i++){      
        MOVS     R3,#+0
        B.N      ??CRC_CHECK_0
??CRC_CHECK_1:
        ADDS     R3,R3,#+1
??CRC_CHECK_0:
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R3,R1
        BCS.N    ??CRC_CHECK_2
//   43         CRC_Temp ^= Buf[i];
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        LDRB     R4,[R3, R0]
        EORS     R2,R4,R2
//   44         for (j=0;j<8;j++) {
        MOVS     R4,#+0
        B.N      ??CRC_CHECK_3
//   45             if (CRC_Temp & 0x01)
//   46                 CRC_Temp = (CRC_Temp >>1 ) ^ 0xa001;
//   47             else
//   48                 CRC_Temp = CRC_Temp >> 1;
??CRC_CHECK_4:
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LSRS     R2,R2,#+1
??CRC_CHECK_5:
        ADDS     R4,R4,#+1
??CRC_CHECK_3:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+8
        BGE.N    ??CRC_CHECK_1
        LSLS     R5,R2,#+31
        BPL.N    ??CRC_CHECK_4
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LSRS     R2,R2,#+1
        EOR      R2,R2,#0xA000
        EORS     R2,R2,#0x1
        B.N      ??CRC_CHECK_5
//   49         }
//   50     }
//   51     return(CRC_Temp);
??CRC_CHECK_2:
        MOVS     R0,R2
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        POP      {R4,R5}
        BX       LR               ;; return
//   52 }
//   53 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   54 void VirtualOutPut_Data(void)
//   55 {
VirtualOutPut_Data:
        PUSH     {R4,LR}
        SUB      SP,SP,#+48
//   56   int temp[4] = {0};
        ADD      R0,SP,#+28
        MOVS     R1,#+16
        BL       __aeabi_memclr4
//   57   unsigned int temp1[4] = {0};
        ADD      R0,SP,#+12
        MOVS     R1,#+16
        BL       __aeabi_memclr4
//   58   unsigned char databuf[10] = {0};
        ADD      R0,SP,#+0
        MOVS     R1,#+0
        MOVS     R2,#+0
        MOVS     R3,#+0
        STM      R0!,{R1-R3}
        SUBS     R0,R0,#+12
//   59   unsigned char i;
//   60   unsigned short CRC16 = 0;
        MOVS     R0,#+0
//   61   for(i=0;i<4;i++)
        MOVS     R4,#+0
        B.N      ??VirtualOutPut_Data_0
//   62    {
//   63     
//   64     temp[i]  = (int)VirtualOutData[i];
??VirtualOutPut_Data_1:
        LDR.W    R0,??DataTable4
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        BL       __aeabi_f2iz
        ADD      R1,SP,#+28
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R0,[R1, R4, LSL #+2]
//   65     temp1[i] = (unsigned int)temp[i];
        ADD      R0,SP,#+28
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        ADD      R1,SP,#+12
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R0,[R1, R4, LSL #+2]
//   66     
//   67    }
        ADDS     R4,R4,#+1
??VirtualOutPut_Data_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+4
        BLT.N    ??VirtualOutPut_Data_1
//   68    
//   69   for(i=0;i<4;i++) 
        MOVS     R4,#+0
        B.N      ??VirtualOutPut_Data_2
//   70   {
//   71     databuf[i*2]   = (unsigned char)(temp1[i]%256);
??VirtualOutPut_Data_3:
        ADD      R0,SP,#+12
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        MOV      R1,#+256
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        ADD      R0,SP,#+0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STRB     R2,[R0, R4, LSL #+1]
//   72     databuf[i*2+1] = (unsigned char)(temp1[i]/256);
        ADD      R0,SP,#+12
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR      R0,[R0, R4, LSL #+2]
        LSRS     R0,R0,#+8
        ADD      R1,SP,#+0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R1,R1,R4, LSL #+1
        STRB     R0,[R1, #+1]
//   73   }
        ADDS     R4,R4,#+1
??VirtualOutPut_Data_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+4
        BLT.N    ??VirtualOutPut_Data_3
//   74   
//   75   CRC16 = CRC_CHECK(databuf,8);
        MOVS     R1,#+8
        ADD      R0,SP,#+0
        BL       CRC_CHECK
//   76   databuf[8] = CRC16%256;
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOV      R1,#+256
        SDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        STRB     R2,[SP, #+8]
//   77   databuf[9] = CRC16/256;
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOV      R1,#+256
        SDIV     R0,R0,R1
        STRB     R0,[SP, #+9]
//   78   
//   79   for(i=0;i<10;i++)
        MOVS     R4,#+0
        B.N      ??VirtualOutPut_Data_4
//   80   uart_send1(UART0,databuf[i]);
??VirtualOutPut_Data_5:
        ADD      R0,SP,#+0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R1,[R4, R0]
        LDR.N    R0,??DataTable4_1  ;; 0x4006a000
        BL       uart_send1
        ADDS     R4,R4,#+1
??VirtualOutPut_Data_4:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+10
        BLT.N    ??VirtualOutPut_Data_5
//   81 }
        ADD      SP,SP,#+48
        POP      {R4,PC}          ;; return
//   82 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   83 void VirtualScopeSend(void)
//   84 {
VirtualScopeSend:
        PUSH     {R3-R5,LR}
//   85   float temp1;  
//   86   float temp2; 
//   87   float temp3;
//   88 
//   89   if(tic1 > toc1)
        LDR.N    R0,??DataTable4_2
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_3
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??VirtualScopeSend_0
//   90   {
//   91     temp1 = (tic1 - toc1) / 75 ;
        LDR.N    R0,??DataTable4_3
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_2
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOVS     R1,#+75
        UDIV     R0,R0,R1
        BL       __aeabi_ui2f
        MOVS     R4,R0
        B.N      ??VirtualScopeSend_1
//   92   }
//   93   else
//   94   {
//   95     temp1 = 100;
??VirtualScopeSend_0:
        LDR.N    R4,??DataTable4_4  ;; 0x42c80000
//   96   }
//   97   
//   98   if(tic2 > toc2)
??VirtualScopeSend_1:
        LDR.N    R0,??DataTable4_5
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_6
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??VirtualScopeSend_2
//   99   {
//  100     temp2 = (tic2 - toc2) / 75;
        LDR.N    R0,??DataTable4_6
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_5
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOVS     R1,#+75
        UDIV     R0,R0,R1
        BL       __aeabi_ui2f
        MOVS     R5,R0
        B.N      ??VirtualScopeSend_3
//  101   }
//  102   else
//  103   {
//  104     temp2 = 100;
??VirtualScopeSend_2:
        LDR.N    R5,??DataTable4_4  ;; 0x42c80000
//  105   }
//  106   
//  107   if(tic3 > toc3)
??VirtualScopeSend_3:
        LDR.N    R0,??DataTable4_7
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_8
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??VirtualScopeSend_4
//  108   {
//  109     temp3 = (tic3 - toc3) / 75;
        LDR.N    R0,??DataTable4_8
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_7
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOVS     R1,#+75
        UDIV     R0,R0,R1
        BL       __aeabi_ui2f
        B.N      ??VirtualScopeSend_5
//  110   }
//  111   else
//  112   {
//  113     temp3 = 100;
??VirtualScopeSend_4:
        LDR.N    R0,??DataTable4_4  ;; 0x42c80000
//  114   }
//  115   
//  116   //ServoPercent = 
//  117   
//  118 /*
//  119   VirtualOutData[0] = PathType;                  //�������� 0δ֪ 1ֱ�� 2���� 3���� 4���� 5���� 6���� 7����
//  120   VirtualOutData[1] = CURVEL;                    //����ߵ����ʣ���Ϊ���ڵĵ�����仯�������п��ܱ仯�ܴ�
//  121   VirtualOutData[2] = CURVEC;                    //�����ߵ����ʣ���Ϊ���ڵĵ�����仯�������п��ܱ仯�ܴ�
//  122   VirtualOutData[3] = CURVER;                    //�Һ��ߵ����ʣ���Ϊ���ڵĵ�����仯�������п��ܱ仯�ܴ�
//  123     */
//  124 /*
//  125   VirtualOutData[0] = DeviRowChosen;                   //ƫ����ȡʱ��ѡ�е��кš�
//  126   VirtualOutData[1] = CenterLineLoc[DeviRowChosen];    //ƫ����ȡʱ��ѡ�е��кŶ�Ӧ�������ߵ�ֵ��
//  127   VirtualOutData[2] = BlackLeftLoc[DeviRowChosen][0];  //ƫ����ȡʱ��ѡ�е��кŶ�Ӧ������ߵ�ֵ��
//  128   VirtualOutData[3] = BlackRightLoc[DeviRowChosen][0]; //ƫ����ȡʱ��ѡ�е��кŶ�Ӧ���Һ��ߵ�ֵ��
//  129   */
//  130     /*
//  131   VirtualOutData[0] = temp1;                      //�ɼ�ͼ��������ʱ�䣬��λΪms
//  132   VirtualOutData[1] = temp2;                      //����ͼ��ͷ���������������ʱ�䣬��λΪms
//  133   VirtualOutData[2] = DeviNow;                    //��ǰƫ�
//  134   VirtualOutData[3] = ServoPercent;               //�����ǵİٷ�ֵ��ȡֵ��-100��+100�����Ҳ��Գƣ������Ҹ���
//  135 */
//  136   /*
//  137   VirtualOutData[0] = PathType;                 
//  138   VirtualOutData[1] = SpeedFlag;                    
//  139   VirtualOutData[2] = DeviNow;                    
//  140   VirtualOutData[3] = ServoPercent;                   
//  141   */
//  142   
//  143   VirtualOutData[0] = temp1;        
??VirtualScopeSend_5:
        LDR.N    R1,??DataTable4
        STR      R4,[R1, #+0]
//  144   VirtualOutData[1] = temp2;
        LDR.N    R1,??DataTable4
        STR      R5,[R1, #+4]
//  145   VirtualOutData[2] = temp3;
        LDR.N    R1,??DataTable4
        STR      R0,[R1, #+8]
//  146   VirtualOutData[3] = SlopeC;
        LDR.N    R0,??DataTable4_9
        LDR      R0,[R0, #+0]
        BL       __aeabi_i2f
        LDR.N    R1,??DataTable4
        STR      R0,[R1, #+12]
//  147   
//  148   VirtualOutPut_Data();
        BL       VirtualOutPut_Data
//  149 }
        POP      {R0,R4,R5,PC}    ;; return
//  150 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  151 void Virtual2DataPush(uint8 chanel,uint16 data)
//  152 {
//  153     uSendBuf[chanel*2]=data/256;
Virtual2DataPush:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOV      R2,#+256
        SDIV     R2,R1,R2
        LDR.N    R3,??DataTable4_10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STRB     R2,[R3, R0, LSL #+1]
//  154     uSendBuf[chanel*2+1]=data%256;
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOV      R2,#+256
        SDIV     R3,R1,R2
        MLS      R3,R3,R2,R1
        LDR.N    R1,??DataTable4_10
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R0,R1,R0, LSL #+1
        STRB     R3,[R0, #+1]
//  155 }
        BX       LR               ;; return
//  156 
//  157 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  158 void Virtual2Send(void)
//  159 {
Virtual2Send:
        PUSH     {R3-R5,LR}
//  160   uint8 i,sum=0; 
        MOVS     R5,#+0
//  161   //ʹ����ѯ�ķ�ʽ�������ݣ�������δ���ͣ�����ͣ�ڴ˴�ֱ���������
//  162   uart_send1(UART0,251);
        MOVS     R1,#+251
        LDR.N    R0,??DataTable4_1  ;; 0x4006a000
        BL       uart_send1
//  163   uart_send1(UART0,109);
        MOVS     R1,#+109
        LDR.N    R0,??DataTable4_1  ;; 0x4006a000
        BL       uart_send1
//  164   uart_send1(UART0,37);
        MOVS     R1,#+37
        LDR.N    R0,??DataTable4_1  ;; 0x4006a000
        BL       uart_send1
//  165   sum+=(251);      //ȫ�����ݼ���У��
        SUBS     R5,R5,#+5
//  166   sum+=(109);
        ADDS     R5,R5,#+109
//  167   sum+=(37);
        ADDS     R5,R5,#+37
//  168   for(i=0;i<FreeCarsDataNum;i++)
        MOVS     R4,#+0
        B.N      ??Virtual2Send_0
//  169   {
//  170     uart_send1(UART0,uSendBuf[i]);
??Virtual2Send_1:
        LDR.N    R0,??DataTable4_10
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R1,[R4, R0]
        LDR.N    R0,??DataTable4_1  ;; 0x4006a000
        BL       uart_send1
//  171     sum+=uSendBuf[i];         //ȫ�����ݼ���У��
        LDR.N    R0,??DataTable4_10
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDRB     R0,[R4, R0]
        ADDS     R5,R0,R5
//  172   }
        ADDS     R4,R4,#+1
??Virtual2Send_0:
        LDR.N    R0,??DataTable4_11
        LDRB     R0,[R0, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,R0
        BCC.N    ??Virtual2Send_1
//  173   uart_send1(UART0,sum);
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR.N    R0,??DataTable4_1  ;; 0x4006a000
        BL       uart_send1
//  174 }
        POP      {R0,R4,R5,PC}    ;; return
//  175 
//  176 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  177 void Virtual2SendData(void)
//  178 {
Virtual2SendData:
        PUSH     {R7,LR}
//  179   uint16 temp1, temp2, temp3, temp4, temp5, temp6, temp7;
//  180     
//  181   ErrorCountNow6++;
        LDR.N    R0,??DataTable4_12
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable4_12
        STRH     R0,[R1, #+0]
//  182   
//  183   
//  184   if(tic1 > toc1)
        LDR.N    R0,??DataTable4_2
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_3
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??Virtual2SendData_0
//  185   {
//  186     temp1 = (tic1 - toc1) / 75000;
        LDR.N    R0,??DataTable4_3
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_2
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable4_13  ;; 0x124f8
        UDIV     R0,R0,R1
        B.N      ??Virtual2SendData_1
//  187   }
//  188   else
//  189   {
//  190     temp1 = 50;
??Virtual2SendData_0:
        MOVS     R0,#+50
//  191   }  
//  192   
//  193   
//  194   if(tic2 > toc2)
??Virtual2SendData_1:
        LDR.N    R0,??DataTable4_5
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_6
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??Virtual2SendData_2
//  195   {
//  196     temp2 = (tic2 - toc2) / 75000;
        LDR.N    R0,??DataTable4_6
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_5
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable4_13  ;; 0x124f8
        UDIV     R0,R0,R1
        B.N      ??Virtual2SendData_3
//  197   }
//  198   else
//  199   {
//  200     temp2 = 50;
??Virtual2SendData_2:
        MOVS     R0,#+50
//  201   }
//  202   
//  203   if(tic3 > toc3)
??Virtual2SendData_3:
        LDR.N    R0,??DataTable4_7
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_8
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??Virtual2SendData_4
//  204   {
//  205     temp3 = (tic3 - toc3) / 75000;
        LDR.N    R0,??DataTable4_8
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_7
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable4_13  ;; 0x124f8
        UDIV     R0,R0,R1
        B.N      ??Virtual2SendData_5
//  206   }
//  207   else
//  208   {
//  209     temp3 = 50;
??Virtual2SendData_4:
        MOVS     R0,#+50
//  210   }  
//  211 
//  212   if(tic4 > toc4)
??Virtual2SendData_5:
        LDR.N    R0,??DataTable4_14
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_15
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??Virtual2SendData_6
//  213   {
//  214     temp4 = (tic4 - toc4) / 75000;
        LDR.N    R0,??DataTable4_15
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_14
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable4_13  ;; 0x124f8
        UDIV     R0,R0,R1
        B.N      ??Virtual2SendData_7
//  215   }
//  216   else
//  217   {
//  218     temp4 = 50;
??Virtual2SendData_6:
        MOVS     R0,#+50
//  219   }
//  220   
//  221   if(tic5 > toc5)
??Virtual2SendData_7:
        LDR.N    R0,??DataTable4_16
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_17
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??Virtual2SendData_8
//  222   {
//  223     temp5 = (tic5 - toc5) / 75000;
        LDR.N    R0,??DataTable4_17
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_16
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable4_13  ;; 0x124f8
        UDIV     R0,R0,R1
        B.N      ??Virtual2SendData_9
//  224   }
//  225   else
//  226   {
//  227     temp5 = 50;
??Virtual2SendData_8:
        MOVS     R0,#+50
//  228   }
//  229   
//  230   if(tic6 > toc6)
??Virtual2SendData_9:
        LDR.N    R0,??DataTable4_18
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_19
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??Virtual2SendData_10
//  231   {
//  232     temp6 = (tic6 - toc6) / 75;
        LDR.N    R0,??DataTable4_19
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_18
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOVS     R1,#+75
        UDIV     R0,R0,R1
        B.N      ??Virtual2SendData_11
//  233   }
//  234   else
//  235   {
//  236     temp6 = 50;
??Virtual2SendData_10:
        MOVS     R0,#+50
//  237   }
//  238   
//  239   if(tic7 > toc7)
??Virtual2SendData_11:
        LDR.N    R0,??DataTable4_20
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_21
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS.N    ??Virtual2SendData_12
//  240   {
//  241     temp7 = (tic7 - toc7) / 75;
        LDR.N    R0,??DataTable4_21
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_20
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        MOVS     R1,#+75
        UDIV     R0,R0,R1
        B.N      ??Virtual2SendData_13
//  242   }
//  243   else
//  244   {
//  245     temp7 = 50;
??Virtual2SendData_12:
        MOVS     R0,#+50
//  246   }
//  247     
//  248   
//  249   Virtual2DataPush( 0, ServoPIDInputVal-1000);
??Virtual2SendData_13:
        LDR.N    R0,??DataTable4_22
        LDR      R0,[R0, #+0]
        SUBS     R1,R0,#+1000
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+0
        BL       Virtual2DataPush
//  250   Virtual2DataPush( 1, SpeedLeftVal);
        LDR.N    R0,??DataTable4_23
        LDR      R1,[R0, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+1
        BL       Virtual2DataPush
//  251   Virtual2DataPush( 2, SpeedTargetLeftVal);
        LDR.N    R0,??DataTable4_24
        LDRH     R1,[R0, #+0]
        MOVS     R0,#+2
        BL       Virtual2DataPush
//  252   Virtual2DataPush( 3, SpeedNowLeft);
        LDR.N    R0,??DataTable4_25
        LDRH     R1,[R0, #+0]
        MOVS     R0,#+3
        BL       Virtual2DataPush
//  253   Virtual2DataPush( 4, DeviFuse);
        LDR.N    R0,??DataTable4_26
        LDR      R1,[R0, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+4
        BL       Virtual2DataPush
//  254   Virtual2DataPush( 5, DeviFuse-DeviPre);
        LDR.N    R0,??DataTable4_26
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable4_27
        LDR      R1,[R1, #+0]
        SUBS     R1,R0,R1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+5
        BL       Virtual2DataPush
//  255   Virtual2DataPush( 6, ShiZhiFlag*200);
        LDR.N    R0,??DataTable4_28
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+200
        SMULBB   R1,R0,R1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+6
        BL       Virtual2DataPush
//  256   
//  257   Virtual2DataPush( 7, PathType*300);
        LDR.N    R0,??DataTable4_29
        LDRB     R0,[R0, #+0]
        MOV      R1,#+300
        SMULBB   R1,R0,R1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+7
        BL       Virtual2DataPush
//  258   Virtual2DataPush( 8, LightHouseWaitStopDelayFlag);
        LDR.N    R0,??DataTable4_30
        LDRB     R1,[R0, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+8
        BL       Virtual2DataPush
//  259 
//  260   Virtual2DataPush( 9, GyroResultFlag);
        LDR.N    R0,??DataTable4_31
        LDRB     R1,[R0, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+9
        BL       Virtual2DataPush
//  261   Virtual2DataPush(10, BrickSpeDealCenFlag * 100);  
        LDR.N    R0,??DataTable4_32
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+100
        SMULBB   R1,R0,R1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+10
        BL       Virtual2DataPush
//  262   Virtual2DataPush(11, StopFlag);
        LDR.N    R0,??DataTable4_33
        LDRB     R1,[R0, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+11
        BL       Virtual2DataPush
//  263   Virtual2DataPush(12, StopRealFlag);
        LDR.N    R0,??DataTable4_34
        LDRB     R1,[R0, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+12
        BL       Virtual2DataPush
//  264   Virtual2DataPush(13, BrickSpeDealFlag * 100);
        LDR.N    R0,??DataTable4_35
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+100
        SMULBB   R1,R0,R1
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+13
        BL       Virtual2DataPush
//  265   Virtual2DataPush(14, BrickSpeDealBackCount);  
        LDR.N    R0,??DataTable4_36
        LDRB     R1,[R0, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+14
        BL       Virtual2DataPush
//  266   Virtual2DataPush(15, PathRealStraightFlag);
        LDR.N    R0,??DataTable4_37
        LDRB     R1,[R0, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+15
        BL       Virtual2DataPush
//  267   Virtual2DataPush(16, PathType);
        LDR.N    R0,??DataTable4_29
        LDRB     R1,[R0, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,#+16
        BL       Virtual2DataPush
//  268  
//  269   
//  270   
//  271 //    Virtual2DataPush( 0, DeviFuse);
//  272 //    Virtual2DataPush( 1, ImgProSucceedFlag * 100);
//  273 //    Virtual2DataPush( 2, ServoPIDInputVal - ServoPIDCen);
//  274 //    Virtual2DataPush( 3, BlackLeftHeadLine);
//  275 //    Virtual2DataPush( 4, BlackRightHeadLine);
//  276 //    Virtual2DataPush( 5, StopFlag);
//  277 //    Virtual2DataPush( 6, SpeedPIDDVal);  
//  278 //    Virtual2DataPush( 7, speed_kp);
//  279 //    Virtual2DataPush( 8, speed_kd);
//  280 //    
//  281 //    Virtual2DataPush( 9, SpeedNowLeft);
//  282 //    Virtual2DataPush(10, SpeedTargetLeftVal);  
//  283 //    Virtual2DataPush(11, SpeedLeftVal);
//  284 //    Virtual2DataPush(12, SpeedNowRight);
//  285 //    Virtual2DataPush(13, SpeedTargetRightVal);
//  286 //    Virtual2DataPush(14, SpeedRightVal);  
//  287 //    Virtual2DataPush(15, SpeedRightValP);
//  288 //    Virtual2DataPush(16, SpeedRightValD);
//  289   
//  290    /*
//  291   Virtual2DataPush( 0, DeviFuse);
//  292   Virtual2DataPush( 1, ImgProSucceedFlag * 100);
//  293   Virtual2DataPush( 2, LimitLeftHeadWB);
//  294   Virtual2DataPush( 3, LimitLeftHeadB);
//  295   Virtual2DataPush( 4, LimitLeftHeadW);
//  296   Virtual2DataPush( 5, flag000);
//  297   Virtual2DataPush( 6, countcount);
//  298   
//  299   Virtual2DataPush( 7, CURVEL);
//  300   Virtual2DataPush( 8, CURVER);
//  301   
//  302   Virtual2DataPush( 9, BlackRightHeadLine-BlackLeftHeadLine);
//  303   Virtual2DataPush(10, PathType);  
//  304   Virtual2DataPush(11, AngleConfirmCount);
//  305   Virtual2DataPush(12, AngleConfirmCountMax);
//  306   Virtual2DataPush(13, AngleConfirmLockFlag);
//  307   Virtual2DataPush(14, AngleSpeDealBackCount);  
//  308   Virtual2DataPush(15, AngleSpeDealDir);
//  309   Virtual2DataPush(16, BlackRightContinueFlag);
//  310    
//  311   
//  312  
//  313  
//  314  
//  315    Virtual2DataPush( 5, BlackLeftHeadLine);
//  316   Virtual2DataPush( 6, BlackRightHeadLine);
//  317   
//  318   Virtual2DataPush( 7, PathType);
//  319   Virtual2DataPush( 8, flag000);
//  320 
//  321   Virtual2DataPush( 9, flag111);  
//  322   Virtual2DataPush(10, temp3);  
//  323   Virtual2DataPush(11, AngleConfirmCount);
//  324   Virtual2DataPush(12, AngleConfirmCountMax);
//  325   Virtual2DataPush(13, AngleConfirmFlag);
//  326   Virtual2DataPush(14, AngleSpeDealDir);  
//  327   Virtual2DataPush(15, AngleSpeDealBackCount);
//  328   Virtual2DataPush(16, AngleSpeDealFlag);
//  329 
//  330   Virtual2DataPush( 0, DeviFuse);
//  331   Virtual2DataPush( 1, ImgProSucceedFlag * 100);
//  332   Virtual2DataPush( 2, ServoPIDInputVal-ServoPIDCen);
//  333   Virtual2DataPush( 3, QuadRightCount);
//  334   Virtual2DataPush( 4, SpeedTargetVal);
//  335   Virtual2DataPush( 5, SpeedNowLeft);
//  336   Virtual2DataPush( 6, SpeedTargetLeftVal);
//  337   
//  338   Virtual2DataPush( 7, SpeedLeftVal / 50);
//  339   Virtual2DataPush( 8, SpeedNowRight);
//  340   Virtual2DataPush( 9, BlackRightLoc[39][0]);
//  341   Virtual2DataPush(10, BlackRightLoc[29][0]);  
//  342   Virtual2DataPush(11, BlackRightLoc[19][0]);
//  343   Virtual2DataPush(12, BlackRightLoc[14][0]);
//  344   Virtual2DataPush(13, temptempSpeedLeftVal / 50);
//  345   Virtual2DataPush(14, ADResult0);
//  346   Virtual2DataPush(15, ADResult1);
//  347   Virtual2DataPush(16, ADResult2);
//  348   */
//  349   
//  350   /*
//  351   Virtual2DataPush( 9, AngleConfirmFlag);           //ֱ��������ȷ�ϱ�־��1ȷ�ϣ�0����
//  352   Virtual2DataPush(10, AngleConfirmLockFlag);       //ֱ�����жϳɹ������־λ,ȷ����ֱ�������λ������ȷ��ֱ�������⴦��ʼ��λ�á�
//  353   Virtual2DataPush(11, AngleSpeDealDir);            //ֱ���䷽���־��0��ֱ���䣬1��ֱ���䣬2����
//  354   Virtual2DataPush(12, AngleSpeDealBackCount);      //ֱ��������ȷ�Ϻ�������������ĵ���������
//  355   Virtual2DataPush(13, AngelSpeDealExitJudgeFlag);  //��ֱ�����жϱ�־��1�ѳ���0δ��
//  356   Virtual2DataPush(14, AngleSpeDealFlag);           //1˵���÷�ͼ�������ֱ��������⴦��,0˵��δ���С�
//  357   Virtual2DataPush(15, AngleConfirmCount);
//  358   Virtual2DataPush(16, AngleConfirmCountMax);  
//  359   
//  360   //Virtual2DataPush(15, BlackLeftEndLine);
//  361   //Virtual2DataPush(16, BlackRightEndLine);
//  362   Virtual2DataPush(15, SpeedLeftVal);
//  363   Virtual2DataPush(16, SpeedRightVal);
//  364   Virtual2DataPush( 0, DeviFuse);
//  365 
//  366   Virtual2DataPush( 1, ImgBlackSucceedFlag * 100);
//  367   Virtual2DataPush( 2, ErrorCountNow7);//���ж�
//  368   
//  369   Virtual2DataPush( 3, ErrorCountNow8);     //���ж�
//  370   Virtual2DataPush( 4, ErrorCountNow9);     //DMA�ж�   
//  371   Virtual2DataPush( 5, ErrorCountNow0);   //SERVO
//  372   Virtual2DataPush( 6, ErrorCountNow1);   //MOTOR
//  373   Virtual2DataPush( 7, ErrorCountNow5);   //IMAGEPRO
//  374   Virtual2DataPush( 8, temp1);   //VIR
//  375   Virtual2DataPush( 9, temp2);
//  376   Virtual2DataPush(10, temp3);
//  377   Virtual2DataPush(11, temp4);
//  378   Virtual2DataPush(12, temp5);
//  379   Virtual2DataPush(13, temp6);  
//  380   Virtual2DataPush(14, temp7);
//  381   Virtual2DataPush(15, QuadLeftCount);
//  382   Virtual2DataPush(16, QuadRightCount);   
//  383 */
//  384   
//  385  
//  386   
//  387   Virtual2Send();
        BL       Virtual2Send
//  388 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     VirtualOutData

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x4006a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     toc1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     tic1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     0x42c80000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     toc2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     tic2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_7:
        DC32     toc3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_8:
        DC32     tic3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_9:
        DC32     SlopeC

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_10:
        DC32     uSendBuf

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_11:
        DC32     FreeCarsDataNum

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_12:
        DC32     ErrorCountNow6

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_13:
        DC32     0x124f8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_14:
        DC32     toc4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_15:
        DC32     tic4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_16:
        DC32     toc5

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_17:
        DC32     tic5

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_18:
        DC32     toc6

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_19:
        DC32     tic6

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_20:
        DC32     toc7

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_21:
        DC32     tic7

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_22:
        DC32     ServoPIDInputVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_23:
        DC32     SpeedLeftVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_24:
        DC32     SpeedTargetLeftVal

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_25:
        DC32     SpeedNowLeft

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_26:
        DC32     DeviFuse

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_27:
        DC32     DeviPre

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_28:
        DC32     ShiZhiFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_29:
        DC32     PathType

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_30:
        DC32     LightHouseWaitStopDelayFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_31:
        DC32     GyroResultFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_32:
        DC32     BrickSpeDealCenFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_33:
        DC32     StopFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_34:
        DC32     StopRealFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_35:
        DC32     BrickSpeDealFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_36:
        DC32     BrickSpeDealBackCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_37:
        DC32     PathRealStraightFlag

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC32 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC32 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        END
// 
//   110 bytes in section .bss
//     1 byte  in section .data
//    44 bytes in section .rodata
// 1 180 bytes in section .text
// 
// 1 180 bytes of CODE  memory
//    44 bytes of CONST memory
//   111 bytes of DATA  memory
//
//Errors: none
//Warnings: 7
