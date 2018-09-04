///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.5.7591/W32 for ARM       06/Feb/2018  21:44:22
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\LightHouse.c
//    Command line =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\LightHouse.c
//        -D IAR -D TWR_K60N512 -lCN
//        D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\List\ -lB
//        D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\List\ -o
//        D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\Obj\ --no_cse --no_unroll
//        --no_inline --no_code_motion --no_tbaa --no_clustering
//        --no_scheduling --debug --endian=little --cpu=Cortex-M4 -e --fpu=None
//        --dlib_config "C:\Program Files (x86)\IAR Systems\Embedded Workbench
//        7.0\arm\INC\c\DLib_Config_Normal.h" -I
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\H\ -I
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\H\Component_H\ -I
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\H\Frame_H\ -I
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\H\Function_H\ -I
//        D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\H\SD_H\ -Ol
//        --use_c++_inline
//    List file    =  
//        D:\���ܳ�\����\��λ������_����ͷ1��\FLASH\List\LightHouse.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN gpio_init

        PUBLIC LightHouseInit
        PUBLIC LightHouseNoStopFlag
        PUBLIC LightHouseOff2On
        PUBLIC LightHouseOff2OnFlag
        PUBLIC LightHouseOn2Off
        PUBLIC LightHouseOn2OffFlag
        PUBLIC LightHouseStateR0
        PUBLIC LightHouseStateR1
        PUBLIC LightHouseStateUpdate
        PUBLIC LightHouseWaitStart
        PUBLIC LightHouseWaitStartGapCount
        PUBLIC LightHouseWaitStartMaxTime
        PUBLIC LightHouseWaitStop
        PUBLIC LightHouseWaitStopDelayCount
        PUBLIC LightHouseWaitStopDelayCountLimit
        PUBLIC LightHouseWaitStopDelayFlag
        PUBLIC LightHouseWaitStopFlag
        PUBLIC LightHouseWaitStopGapCount
        PUBLIC LightHouseWaitStopGapCountLimit
        PUBLIC LightHouseWaitStopLockFlag
        PUBLIC LightHouseWaitStopOnCount
        PUBLIC LightHouseWaitStopOnCountLimit

// D:\���ܳ�\����\��λ������_����ͷ1��\src\Sources\C\Function_C\LightHouse.c
//    1 /******************************************************************************/
//    2 /*******************************************************************************
//    3   �ļ��������������ļ�LightHouse.c
//    4   ��  �ܣ���������
//    5   ��  �ڣ�2015.05.11
//    6   ��  �ߣ�HJZ
//    7   ��  ע��
//    8 *******************************************************************************/
//    9 /******************************************************************************/
//   10 
//   11 #include "LightHouse.h"

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   12 uint8 LightHouseStateR0 = 0;    //��������ģ��0��״̬
LightHouseStateR0:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   13 uint8 LightHouseStateR1 = 0;    //��������ģ��1��״̬
LightHouseStateR1:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   14 uint8 LightHouseOn2OffFlag = 0;  //�����������ı�־����0��x�仯����ʼ��Ϊ0.
LightHouseOn2OffFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   15 uint8 LightHouseOff2OnFlag = 0;  //�����������ı�־����0��x�仯����ʼ��Ϊ0.
LightHouseOff2OnFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   16 uint8 LightHouseWaitStopFlag = 0;
LightHouseWaitStopFlag:
        DS8 1
//   17 
//   18   

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   19 uint8 LightHouseWaitStartGapCount;  //�����������ֵ
LightHouseWaitStartGapCount:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   20 uint8 LightHouseWaitStopGapCount;   //ͣ���������ֵ
LightHouseWaitStopGapCount:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   21 uint16 LightHouseWaitStopDelayCount;  //ͣ����ʱ�жϼ���ֵ
LightHouseWaitStopDelayCount:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   22 uint8 LightHouseWaitStopDelayFlag;  //ͣ����ʱ�жϱ�־λ
LightHouseWaitStopDelayFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   23 uint8 LightHouseWaitStopLockFlag;   //ͣ��ȷ�������־λ
LightHouseWaitStopLockFlag:
        DS8 1
//   24 

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   25 uint16 LightHouseWaitStartMaxTime = 50;         //��0.1sΪ��λ��50����5�롣��ô����󣬲�����û�м�⵽������ֱ�ӷ�����
LightHouseWaitStartMaxTime:
        DATA
        DC16 50

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   26 uint16 LightHouseWaitStopDelayCountLimit = 70;  //ͣ����ʱ�ж���ֵ������ô���16ms�ſ�ʼͣ���ж�
LightHouseWaitStopDelayCountLimit:
        DATA
        DC16 70

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   27 uint16 LightHouseWaitStopGapCountLimit = 10;   //ͣ�����������ֵ��ÿ����ô���16ms�͸���һ�ε����ɼ�ֵ��һ�㲻Ҫ����
LightHouseWaitStopGapCountLimit:
        DATA
        DC16 10
//   28 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   29 uint16 LightHouseWaitStopOnCount = 0;         //ͣ��ʱ�ģ�����������
LightHouseWaitStopOnCount:
        DS8 2

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//   30 uint16 LightHouseWaitStopOnCountLimit = 2;    //ͣ��ʱ����������������ֵ����ͣ����������йأ������ȱ������0.016*LightHouseWaitStopGapCountLimit*LightHouseWaitStopOnCountLimit�롣����Ҫ̫��
LightHouseWaitStopOnCountLimit:
        DATA
        DC16 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   31 uint16 LightHouseNoStopFlag = 0;              //������ͣ����־��1��������ģʽ�������ݵ���ͣ����ֱ�ӳ��ȥ��0�ر�����ģʽ�����ݵ���ͣ����
LightHouseNoStopFlag:
        DS8 2
//   32 
//   33 
//   34 //�������������ļ�⣬��⵽�����򷵻�1�����򷵻�0.

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   35 uint8 LightHouseOn2Off(void)
//   36 {
//   37   if(LightHouseStateR0 == 0) //0��ʾ��
LightHouseOn2Off:
        LDR.N    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseOn2Off_0
//   38   {
//   39     //��ʼ״̬��0��ȷ�϶��������
//   40     if(LightHouseOn2OffFlag == 0)
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseOn2Off_1
//   41     {
//   42       LightHouseOn2OffFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOn2Off_2
//   43     }
//   44     //ȷ��һֱ�������򱣳����״̬��
//   45     else if(LightHouseOn2OffFlag == 1)
??LightHouseOn2Off_1:
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseOn2Off_3
//   46     {
//   47       LightHouseOn2OffFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOn2Off_2
//   48     }
//   49     //������״̬ȷ�ϵ������򷵻س�ʼ״̬��
//   50     else
//   51     {
//   52       LightHouseOn2OffFlag = 0;
??LightHouseOn2Off_3:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOn2Off_2
//   53     }
//   54   }
//   55   else   //1��ʾ��
//   56   {
//   57     if(LightHouseOn2OffFlag == 1)
??LightHouseOn2Off_0:
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseOn2Off_4
//   58     {
//   59       LightHouseOn2OffFlag = 2;
        MOVS     R0,#+2
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOn2Off_2
//   60     }
//   61     else if(LightHouseOn2OffFlag == 2)
??LightHouseOn2Off_4:
        LDR.N    R0,??DataTable5_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??LightHouseOn2Off_5
//   62     {
//   63       LightHouseOn2OffFlag = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
//   64       return 1;
        MOVS     R0,#+1
        B.N      ??LightHouseOn2Off_6
//   65     }
//   66     else
//   67     {
//   68       LightHouseOn2OffFlag = 0;
??LightHouseOn2Off_5:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_1
        STRB     R0,[R1, #+0]
//   69     }
//   70   }
//   71   
//   72   return 0;
??LightHouseOn2Off_2:
        MOVS     R0,#+0
??LightHouseOn2Off_6:
        BX       LR               ;; return
//   73   
//   74 }
//   75 
//   76 //�����İ������ļ��,��⵽�����򷵻�1�����򷵻�0.

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   77 uint8 LightHouseOff2On(void)
//   78 {
//   79   if(LightHouseStateR0 == 1) //1��ʾ��
LightHouseOff2On:
        LDR.N    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseOff2On_0
//   80   {
//   81     //��ʼ״̬��0��ȷ�϶���ǰ���
//   82     if(LightHouseOff2OnFlag == 0)
        LDR.N    R0,??DataTable5_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseOff2On_1
//   83     {
//   84       LightHouseOff2OnFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOff2On_2
//   85     }
//   86     //ȷ��һֱ�ǰ����򱣳����״̬��
//   87     else if(LightHouseOff2OnFlag == 1)
??LightHouseOff2On_1:
        LDR.N    R0,??DataTable5_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseOff2On_3
//   88     {
//   89       LightHouseOff2OnFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOff2On_2
//   90     }
//   91     //������״̬ȷ�ϵ������򷵻س�ʼ״̬��
//   92     else
//   93     {
//   94       LightHouseOff2OnFlag = 0;
??LightHouseOff2On_3:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOff2On_2
//   95     }
//   96   }
//   97   else   //0��ʾ��
//   98   {
//   99     if(LightHouseOff2OnFlag == 1)
??LightHouseOff2On_0:
        LDR.N    R0,??DataTable5_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseOff2On_4
//  100     {
//  101       LightHouseOff2OnFlag = 2;
        MOVS     R0,#+2
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseOff2On_2
//  102     }
//  103     else if(LightHouseOff2OnFlag == 2)
??LightHouseOff2On_4:
        LDR.N    R0,??DataTable5_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??LightHouseOff2On_5
//  104     {
//  105       LightHouseOff2OnFlag = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
//  106       return 1;
        MOVS     R0,#+1
        B.N      ??LightHouseOff2On_6
//  107     }
//  108     else
//  109     {
//  110       LightHouseOff2OnFlag = 0;
??LightHouseOff2On_5:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_2
        STRB     R0,[R1, #+0]
//  111     }
//  112   }
//  113   
//  114   return 0;
??LightHouseOff2On_2:
        MOVS     R0,#+0
??LightHouseOff2On_6:
        BX       LR               ;; return
//  115 }
//  116 
//  117 
//  118 
//  119 //======================================================================
//  120 //��������LightHouseWaitStart
//  121 //��  �ܣ����������ȴ�����
//  122 //��  ����
//  123 //��  �أ�
//  124 //Ӱ  �죺1�ȴ� 0����
//  125 //˵  ����1. ��⵽�������������أ��򷢳���
//  126 //        2. ע��������صļ����Ҫ�༸���㣬��ֹС���š�
//  127 //             
//  128 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  129 uint8 LightHouseWaitStart(void)
//  130 {
LightHouseWaitStart:
        PUSH     {R7,LR}
//  131   //�������ֵ��1.
//  132   LightHouseWaitStartGapCount++;
        LDR.N    R0,??DataTable5_3
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable5_3
        STRB     R0,[R1, #+0]
//  133   //ʵ�ֶ�θ���һ��ֵ���ﵽ�˲�Ч�����������˲�����СһЩ����Լһ��ʱ�䡣
//  134   if(LightHouseWaitStartGapCount > LightHouseWaitStartGapCountLimit)
        LDR.N    R0,??DataTable5_3
        LDRB     R0,[R0, #+0]
        CMP      R0,#+4
        BLT.N    ??LightHouseWaitStart_0
//  135   {
//  136     //�����źŸ���
//  137     LightHouseStateUpdate();
        BL       LightHouseStateUpdate
//  138     //��⵽������������
//  139     if(LightHouseOn2Off() == 1)
        BL       LightHouseOn2Off
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStart_1
//  140     {
//  141       return 0;
        MOVS     R0,#+0
        B.N      ??LightHouseWaitStart_2
//  142     }
//  143     else
//  144     {
//  145       return 1;
??LightHouseWaitStart_1:
        MOVS     R0,#+1
        B.N      ??LightHouseWaitStart_2
//  146     }
//  147   }
//  148   else
//  149   {
//  150   }
//  151   
//  152   return 1;
??LightHouseWaitStart_0:
        MOVS     R0,#+1
??LightHouseWaitStart_2:
        POP      {R1,PC}          ;; return
//  153 }
//  154 
//  155 
//  156 
//  157 //======================================================================
//  158 //��������LightHouseWaitStop
//  159 //��  �ܣ����������ȴ�����
//  160 //��  ����
//  161 //��  �أ�
//  162 //Ӱ  �죺1�ȴ� 0����
//  163 //˵  ����
//  164 //         
//  165 //             
//  166 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  167 uint8 LightHouseWaitStop(void)
//  168 {
LightHouseWaitStop:
        PUSH     {R7,LR}
//  169   //������ͣ����־����Զ��ͣ����
//  170   if(LightHouseNoStopFlag == 1)
        LDR.N    R0,??DataTable5_4
        LDRH     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStop_0
//  171   {
//  172     return 1;
        MOVS     R0,#+1
        B.N      ??LightHouseWaitStop_1
//  173   }
//  174   else
//  175   {
//  176   } 
//  177   
//  178   
//  179   //ȷ��ͣ���󣬾�һֱ����ס��
//  180   if(LightHouseWaitStopLockFlag == 1)
??LightHouseWaitStop_0:
        LDR.N    R0,??DataTable5_5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStop_2
//  181   {
//  182     return 0;
        MOVS     R0,#+0
        B.N      ??LightHouseWaitStop_1
//  183   }
//  184   else
//  185   {
//  186   }
//  187   
//  188   //ͣ��Ҫ��ʱ�жϣ�����һ������ͣ����
//  189   if(LightHouseWaitStopDelayFlag == 0)
??LightHouseWaitStop_2:
        LDR.N    R0,??DataTable5_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseWaitStop_3
//  190   {
//  191     LightHouseWaitStopDelayCount++;
        LDR.N    R0,??DataTable5_7
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable5_7
        STRH     R0,[R1, #+0]
//  192     //��ʱһ��ʱ�䣬�������þ�һЩ��
//  193     if(LightHouseWaitStopDelayCount > LightHouseWaitStopDelayCountLimit * 63)
        LDR.N    R0,??DataTable5_8
        LDRH     R0,[R0, #+0]
        MOVS     R1,#+63
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable5_7
        LDRH     R1,[R1, #+0]
        CMP      R0,R1
        BGE.N    ??LightHouseWaitStop_4
//  194     {
//  195       LightHouseWaitStopDelayFlag = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_6
        STRB     R0,[R1, #+0]
//  196     }
//  197     else
//  198     {
//  199     }
//  200   }
//  201   else
//  202   {
//  203     //�������ֵ��1.
//  204     LightHouseWaitStopGapCount++;
//  205     //ʵ�ֶ�θ���һ��ֵ���ﵽ�˲�Ч����ͣ�����˲����Զ�һЩ����Ϊ�ӹսǹ����п��ܻ����С�
//  206     if(LightHouseWaitStopGapCount > LightHouseWaitStopGapCountLimit)
//  207     {
//  208       //�����źŸ���
//  209       LightHouseStateUpdate();
//  210       //1. �ȼ�⵽���������䣬�ټ�⵽����������
//  211       if(LightHouseWaitStopFlag == 0)
//  212       {
//  213         //�ȼ�⵽����������
//  214         if(LightHouseOff2On() == 1)
//  215         {
//  216           //��־λ�仯
//  217           LightHouseWaitStopFlag = 1;
//  218           //�������������㡣
//  219           LightHouseWaitStopOnCount = 0;
//  220         }
//  221         else
//  222         {
//  223         }    
//  224       }
//  225       //2. �����뱣�ֹ��� 
//  226       else if(LightHouseWaitStopFlag == 1)
//  227       {
//  228         //���������������1
//  229         if(LightHouseStateR0 == 0)
//  230         {
//  231           LightHouseWaitStopOnCount++;
//  232           //��������������ֵ�����־λ�仯��ͬʱ���㡣
//  233           if(LightHouseWaitStopOnCount >= LightHouseWaitStopOnCountLimit)
//  234           {
//  235             //��־ǰ��
//  236             LightHouseWaitStopFlag = 2;
//  237             LightHouseWaitStopOnCount = 0;
//  238           }
//  239           else
//  240           {
//  241           }
//  242         }
//  243         //һ����;�б䰵����ص����ǰ��
//  244         else
//  245         {
//  246           //��־����
//  247           LightHouseWaitStopFlag = 0;
//  248         }
//  249       }
//  250       //3. �ټ�������������䡣
//  251       else if(LightHouseWaitStopFlag == 2)
//  252       {
//  253         if(LightHouseOn2Off() == 1)
//  254         {
//  255           LightHouseWaitStopFlag = 3;
//  256           return 0;
//  257         }
//  258         else
//  259         {
//  260         }
//  261       }
//  262       else if(LightHouseWaitStopFlag == 3)
//  263       {
//  264         //���μ����ɹ��������ټ���ˡ�
//  265         LightHouseWaitStopLockFlag = 1;
//  266         return 0;    
//  267       }
//  268       else
//  269       {
//  270       }
//  271     }
//  272     else
//  273     {
//  274     }
//  275   }
//  276   
//  277   return 1;
??LightHouseWaitStop_4:
        MOVS     R0,#+1
??LightHouseWaitStop_1:
        POP      {R1,PC}          ;; return
??LightHouseWaitStop_3:
        LDR.N    R0,??DataTable5_9
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable5_9
        STRB     R0,[R1, #+0]
        LDR.N    R0,??DataTable5_10
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable5_9
        LDRB     R1,[R1, #+0]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R0,R1
        BCS.N    ??LightHouseWaitStop_4
        BL       LightHouseStateUpdate
        LDR.N    R0,??DataTable5_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseWaitStop_5
        BL       LightHouseOff2On
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStop_4
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_11
        STRB     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_12
        STRH     R0,[R1, #+0]
        B.N      ??LightHouseWaitStop_4
??LightHouseWaitStop_5:
        LDR.N    R0,??DataTable5_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStop_6
        LDR.N    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??LightHouseWaitStop_7
        LDR.N    R0,??DataTable5_12
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable5_12
        STRH     R0,[R1, #+0]
        LDR.N    R0,??DataTable5_12
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable5_13
        LDRH     R1,[R1, #+0]
        CMP      R0,R1
        BCC.N    ??LightHouseWaitStop_4
        MOVS     R0,#+2
        LDR.N    R1,??DataTable5_11
        STRB     R0,[R1, #+0]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_12
        STRH     R0,[R1, #+0]
        B.N      ??LightHouseWaitStop_4
??LightHouseWaitStop_7:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_11
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseWaitStop_4
??LightHouseWaitStop_6:
        LDR.N    R0,??DataTable5_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??LightHouseWaitStop_8
        BL       LightHouseOn2Off
        CMP      R0,#+1
        BNE.N    ??LightHouseWaitStop_4
        MOVS     R0,#+3
        LDR.N    R1,??DataTable5_11
        STRB     R0,[R1, #+0]
        MOVS     R0,#+0
        B.N      ??LightHouseWaitStop_1
??LightHouseWaitStop_8:
        LDR.N    R0,??DataTable5_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??LightHouseWaitStop_4
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5_5
        STRB     R0,[R1, #+0]
        MOVS     R0,#+0
        B.N      ??LightHouseWaitStop_1
//  278 }
//  279 
//  280 //======================================================================
//  281 //��������LightHouseInit
//  282 //��  �ܣ�������ʼ��
//  283 //��  ����
//  284 //��  �أ�
//  285 //Ӱ  �죺
//  286 //˵  ����
//  287 //      
//  288 //             
//  289 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  290 uint8 LightHouseInit(void)
//  291 {
LightHouseInit:
        PUSH     {R7,LR}
//  292   //LIGHTR0  ��������ģ��1 ����ΪGPIO����
//  293   gpio_init(PORTE, 10, 0, 1);
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+10
        LDR.N    R0,??DataTable5_14  ;; 0x400ff100
        BL       gpio_init
//  294   //LIGHTR1 ��������ģ��2  ����ΪGPIO����
//  295   gpio_init(PORTE, 11, 0, 1);
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+11
        LDR.N    R0,??DataTable5_14  ;; 0x400ff100
        BL       gpio_init
//  296   
//  297   //�������ֵ��ʼ����
//  298   LightHouseWaitStartGapCount = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_3
        STRB     R0,[R1, #+0]
//  299   LightHouseWaitStopGapCount = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_9
        STRB     R0,[R1, #+0]
//  300   //ͣ����ʱ�жϼ���ֵ��ʼ����
//  301   LightHouseWaitStopDelayCount = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_7
        STRH     R0,[R1, #+0]
//  302   //ͣ����ʱ�жϱ�־λ��ʼ����
//  303   LightHouseWaitStopDelayFlag = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_6
        STRB     R0,[R1, #+0]
//  304   //ͣ��ȷ�������־λ
//  305   LightHouseWaitStopLockFlag = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5_5
        STRB     R0,[R1, #+0]
//  306   
//  307   return 1;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//  308 }
//  309 
//  310 
//  311 
//  312 //======================================================================
//  313 //��������LightHouseStateUpdate
//  314 //��  �ܣ���������ģ���״̬����
//  315 //��  ����
//  316 //��  �أ�
//  317 //Ӱ  �죺
//  318 //˵  ����
//  319 //      
//  320 //             
//  321 //======================================================================

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  322 uint8 LightHouseStateUpdate(void)
//  323 {
//  324   //��������ģ��0��״̬���� E10
//  325   if(GPIO_PDIR_REG(PTE_BASE_PTR) & (1 << 10))
LightHouseStateUpdate:
        LDR.N    R0,??DataTable5_15  ;; 0x400ff110
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+21
        BPL.N    ??LightHouseStateUpdate_0
//  326   {
//  327     LightHouseStateR0 = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable5
        STRB     R0,[R1, #+0]
        B.N      ??LightHouseStateUpdate_1
//  328   }
//  329   else
//  330   {
//  331     LightHouseStateR0 = 1;
??LightHouseStateUpdate_0:
        MOVS     R0,#+1
        LDR.N    R1,??DataTable5
        STRB     R0,[R1, #+0]
//  332   }
//  333   
//  334 //  //��������ģ��1��״̬���� E11
//  335 //  if(GPIO_PDIR_REG(PTE_BASE_PTR) & (1 << 11))
//  336 //  {
//  337 //    LightHouseStateR1 = 0;
//  338 //  }
//  339 //  else
//  340 //  {
//  341 //    LightHouseStateR1 = 1;
//  342 //  }
//  343   
//  344   
//  345   return 1;
??LightHouseStateUpdate_1:
        MOVS     R0,#+1
        BX       LR               ;; return
//  346 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     LightHouseStateR0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     LightHouseOn2OffFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     LightHouseOff2OnFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     LightHouseWaitStartGapCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     LightHouseNoStopFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     LightHouseWaitStopLockFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     LightHouseWaitStopDelayFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     LightHouseWaitStopDelayCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_8:
        DC32     LightHouseWaitStopDelayCountLimit

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_9:
        DC32     LightHouseWaitStopGapCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_10:
        DC32     LightHouseWaitStopGapCountLimit

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_11:
        DC32     LightHouseWaitStopFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_12:
        DC32     LightHouseWaitStopOnCount

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_13:
        DC32     LightHouseWaitStopOnCountLimit

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_14:
        DC32     0x400ff100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_15:
        DC32     0x400ff110

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  347 
// 
//  15 bytes in section .bss
//   8 bytes in section .data
// 610 bytes in section .text
// 
// 610 bytes of CODE memory
//  23 bytes of DATA memory
//
//Errors: none
//Warnings: none
