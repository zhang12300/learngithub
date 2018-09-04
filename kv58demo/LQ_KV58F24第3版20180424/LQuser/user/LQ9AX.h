/*LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
��ƽ    ̨������KV58F24���ܳ�VDĸ��
����    д��CHIUSIR
��E-mail  ��chiusir@163.com
������汾��V1.0
�������¡�2017��12��18��
�������Ϣ�ο����е�ַ��
����    վ��http://www.lqist.cn
���Ա����̡�http://shop36265907.taobao.com
------------------------------------------------
��dev.env.��IAR7.80.4
��Target  ��MKV58F1M0VLQ24
��Crystal �� 50.000Mhz
��busclock��137.500MHz
��pllclock��275.000MHz
QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ*/
#ifndef __LQ9AX_H__
#define __LQ9AX_H__
// FXOS8700 registers and constants
#define FXOS8700_I2C_ADDR		0x1E
#define FXOS8700_OUT_X_MSB       	0x01
#define FXOS8700_WHO_AM_I      		0x0D
#define FXOS8700_XYZ_DATA_CFG       	0x0E
#define FXOS8700_CTRL_REG1        	0x2A
#define FXOS8700_CTRL_REG2        	0x2B
#define FXOS8700_M_CTRL_REG1         	0x5B
#define FXOS8700_M_CTRL_REG2        	0x5C
#define FXOS8700_WHO_AM_I_VALUE     	0xC7

// FXAS21002 registers and constants
#define FXAS21002_I2C_ADDR		0x20
#define FXAS21002_X_MSB                 0X01
#define FXAS21002_X_LSB                 0X02
#define FXAS21002_Y_MSB                 0X03
#define FXAS21002_Y_LSB                 0X04
#define FXAS21002_Z_MSB                 0X05
#define FXAS21002_Z_LSB                 0X06
#define FXAS21002_DATA_REG            	0x01 
#define FXAS21002_WHO_AM_I        	0x0C 
#define FXAS21002_CTRL_REG0           	0x0D
#define FXAS21002_CTRL_REG1           	0x13
#define FXAS21002_WHO_AM_I_VALUE	0xD4

typedef union
{
  u16 MYWORD;
  struct
  {
    u8 BYTEL;//��8λ
    u8 BYTEH;//��8λ����CODEWARRIOR���ģʽ��ͬ
  } MYBYTE;
}LQ9AXt;

extern u8 LQ9AX_DAT[19];
extern void Test_9AX(void);
extern LQ9AXt ACC_X,ACC_Y,ACC_Z,GYRO_X,GYRO_Y,GYRO_Z,MAG_X,MAG_Y,MAG_Z;
/*********************** UART���ܺ��� **************************/
//��ʼ��
extern void Init_LQ_9AX(void);
extern void Update9AX(void);
extern void Cvt_14bit_Str(s8 str[],LQ9AXt V2);
/********************************************************************/

#endif 
