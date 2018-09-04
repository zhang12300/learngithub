#include	"myprintp.h"

PRINT_T PortToOut;

#ifdef	TRUE
#define	TRUE	1
#endif

#ifdef	FALSE
#define	FALSE	0
#endif

#define	CR_as_CRLF	TRUE        //true������ʹ��"\n"��ʾ�س�������(CR/LF)
                                //false,Ҫʹ��"\n\r"��ʾ�س�������
static	int	do_padding;         //����Ҫ�������ַ�ʱ���øñ��
static	int	left_flag;          //��������������ʱ���øñ��
static	int	len;                //���水��ʽ������ַ����ĳ���
/******************************************************************************
���㲻ָ����ȵ�ʱ�򣬳����Զ��������ݿ�Ĵ�С��
���ƿ�ȡ�����������������Ҫ�����ʱ�򣬿���ʹ
��ָ����ȵİ취������һ�㶼��ָ����ȵ�
******************************************************************************/
static	int	num1;               //�����ʽ���Ʒ��е�ǰ�����֣�
                                //��������ֶο��
static	int	num2;               //�����ʽ���Ʒ��е������֣�
                                //������ַ���ʱ��Ϊ
                                //����ַ�����

static	char	pad_character;  //��������ַ�

/******************************************************************************/
void Print_Init(PRINT_T *pPrint)
{
	PortToOut.m_printf =  pPrint->m_printf;
}
/******************************************************************************/
/******************************************************************************
���º����������ַ�:
���������ʱʹ�������ʱ���������ұ��������ַ���
���������ʱʹ���Ҷ���ʱ������������������ַ���
******************************************************************************/
static	void	padding( const int l_flag)
{
	int	i;

    if(do_padding && l_flag && (len < num1))
    {
		for(i = len; i < num1; i ++)
        {
			PortToOut.m_printf(pad_character);
        }
    }
}

/******************************************************************************
���������do_padding,�������λ�ñ��l_flag,
���ո�ʽ��ָ���ĸ�ʽ������˿�����ַ���������ַ�
******************************************************************************/
static	void	outs(char *lp)
{
	len = strlen(lp);
	padding(!left_flag);

	while (*lp && num2 --)
	{
		PortToOut.m_printf(*lp ++);
	}
	
	len = strlen(lp);
	padding(left_flag);
}


/******************************************************************************
���������do_padding,�������λ�ñ��l_flag,
���ո�ʽ��ָ���ĸ�ʽ�����ơ����޷��š��ֶο�ȡ�
���Ҷ���ȣ�������˿�����ַ���������ַ�
******************************************************************************/
static void reoutnum(unsigned	long num, 
					 unsigned	int negative, 
					 const	long	base)

{
	char	*cp;
    char	outbuf[32];
	const	char	digits[] = "0123456789ABCDEF";

	/*************************************************************
	����Ҫ��������ְ��ս���ת����ASCII�룬
	�Ե��򱣴���outbuf������
	*************************************************************/
	cp = outbuf;
	do
		{
			*cp ++ = digits[(int)(num % base)];
		}while((num /= base) != 0);

	if(negative)
	{
		*cp ++ = '-';			//����Ǹ�����������β��Ӹ���
	}

	*cp -- = 0;					//Ϊ��ʹ��strlen����������β�����\0

	
	/************************************************************************
	����������ֵĶ��뷽ʽ�����ʵ��ط��������ַ�
	���ұ�����outbuf�е��ַ�
	*************************************************************************/
	len = strlen(outbuf);
	padding(!left_flag);

	while(cp >= outbuf)
	{
		PortToOut.m_printf(*cp --);
	}

	padding(left_flag);  
}


/******************************************************************************
��Ҫ�ȴ������λ��Ȼ�����reoutnum����
******************************************************************************/
static	void	outnum(long num,
					   const long base, 
					   unsigned char sign)
{
	unsigned	int	negative;

	if((num < 0L) && sign)
	{
		negative = 1;
		num = - num;
	}
	else negative = 0;

	reoutnum(num, negative, base);
}


/******************************************************************************
�Ӹ�ʽ�ַ�����ȡ�����֣���Щ����������ʾ�ֶο�ȵȣ�
�����ҽ�������ASCII���������Ϊʮ�������֡�
******************************************************************************/
static	int	getnum(char** linep)
{
	int	n;
	char*	cp;
	
	n = 0;
	cp = *linep;
	while(isdigit(*cp))
	{
		n = n * 10 + ((*cp ++) - '0');
	}

	*linep = cp;
	return(n);
}


/******************************************************************************
���ո�ʽ�ַ����ƶ���Ҫ����˿��������,
����֧�����еı�׼C���ݸ�ʽ����ֻ֧��Ƕ��ʽϵͳ
�����õ��ĸ�ʽ,ʡ���˸������ݸ�ʽ��
�����Ѿ�֧�ֵĸ�ʽ����ĸ�ʽ���Ժ����׵ı����ӽ�ȥ��
******************************************************************************/
void	printp(char* ctrl, ...)
{
	int	long_flag;
	int	dot_flag;

	char	ch;			
	va_list	argp;		//����Ϊ�ɱ������������Ҫ���в�����ȡ��
						//argp����ֻ����ɱ����
	va_start(argp, ctrl);
						//��ʼ��argp,ʹ��ָ���һ���ɱ����
	/*******************************************************************
	ctrl�������ڶ�ջ�У���Ϊ������ʽ�ַ�����ָ�룬
	����ctrl��Ϊָ�������ʽ�ַ�����
	������Ǹ�ʽ���Ʊ��%���ͽ��������if�ṹ��
	���ַ������Ȼ����������ѭ����
	��ʼ�´�ѭ�����������һ���ַ���
	�����%������if���и�ʽ�ж����������
	********************************************************************/
	for( ; *ctrl; ctrl ++)
	{
		if (*ctrl != '%')
		{
		    PortToOut.m_printf(*ctrl);
#if CR_as_CRLF == TRUE
			if(*ctrl == '\n') PortToOut.m_printf('\r');
#endif
			continue;
		}
		/************************************************************
		��������ʽ���Ʊ��%ʱ������ִ������
		�Ĵ��룬�ȳ�ʼ�����еı����
		************************************************************/
		dot_flag = 
		long_flag =
      	left_flag  =
      	do_padding = 0;
      	pad_character = ' ';
		num2 = 32767;

	try_next:
		ch = *( ++ctrl);	//ȡ�ø�ʽ���Ʊ��%�������֡��㡢
		                    //'-'����l������ַ�

		if(isdigit(ch))		//�ж��Ƿ�Ϊ����
		{
			if(dot_flag)	//�ж��������ڵ�Ǯ�����ڵ��
			                //�����ڵ�ǰ�������ִ���
							//num1��������num2
			{
				num2 = getnum(&ctrl);
			}
			else
			{
				if(ch == '0')
				{
					pad_character = '0';
				}

				num1 = getnum(&ctrl);
				do_padding = 1;
			}

			ctrl --;
			goto try_next;
		}

		switch(tolower(ch))	//�жϸ�ʽ�����ַ�������ָ����ʽ���
		                    //���ݻ��߽�һ���ж������ʽ
		{
			case	'%':	PortToOut.m_printf('%');
			continue;
			case	'-':	left_flag = 1;
			break;
			case	'.':	dot_flag = 1;
			break;
			case	'l':	long_flag = 1;
			break;
			case	'd':	
				if ( long_flag == 1)
				{
					if( ch == 'D')		//�����Ρ��޷���
					{
						outnum(va_arg(argp, unsigned long), 10L, 0);
						continue;
					}
					else				//�����Ρ��з���
					{
						outnum(va_arg(argp, long), 10L, 1);
						continue;
					}
				}
				else
				{
					if( ch == 'D')		//���Ρ��޷���
					{
						outnum(va_arg(argp, unsigned int), 10L, 0);
						continue;
					}
					else				//���Ρ��з���
					{
						outnum(va_arg(argp, int), 10L, 1);
						continue;
					}
				}
			case	'X':	
				if ( long_flag == 1)
				{
					if ( ch == 'X')		//��16���ơ��޷���
					{
						outnum(va_arg(argp, unsigned long), 16L, 0);
						continue;
					}
					else				//��16���ơ��з���
					{
						outnum(va_arg(argp, long), 16L, 1);
						continue;
					}
				} 
				else
				{
					if ( ch == 'X')		//��16���ơ��޷���
					{
						outnum(va_arg(argp, unsigned int), 16L, 0);
						continue;
					} 
					else				//��16���ơ��з���
					{
						outnum(va_arg(argp,	int), 16L, 1);
						continue;
					}
				}

			case	's':				//����ַ���
				outs(va_arg(argp, char*));
				continue;

			case	'c':				//����ַ�
				PortToOut.m_printf(va_arg(argp , int));
				continue;
		
			default:
				continue;
		}
		goto	try_next;				//������ַ����Ƹ�ʽʱ��
		                                //��ִ�е�������

	}				//forѭ������

	va_end( argp);						//�����ɱ������ȡ
}
