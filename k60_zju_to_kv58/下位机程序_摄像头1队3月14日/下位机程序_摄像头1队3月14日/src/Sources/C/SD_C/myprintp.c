#include	"myprintp.h"

PRINT_T PortToOut;

#ifdef	TRUE
#define	TRUE	1
#endif

#ifdef	FALSE
#define	FALSE	0
#endif

#define	CR_as_CRLF	TRUE        //true，可以使用"\n"表示回车，换行(CR/LF)
                                //false,要使用"\n\r"表示回车，换行
static	int	do_padding;         //当需要输出填充字符时设置该标记
static	int	left_flag;          //当输出数据左对齐时设置该标记
static	int	len;                //保存按格式输出的字符串的长度
/******************************************************************************
当你不指定宽度的时候，程序自动根据数据库的大小来
控制宽度。当你输出许多数据需要对齐的时候，可以使
用指定宽度的办法，其余一般都不指定宽度的
******************************************************************************/
static	int	num1;               //保存格式控制符中点前的数字，
                                //用作输出字段宽度
static	int	num2;               //保存格式控制符中点后的数字，
                                //在输出字符串时作为
                                //输出字符个数

static	char	pad_character;  //保存填充字符

/******************************************************************************/
void Print_Init(PRINT_T *pPrint)
{
	PortToOut.m_printf =  pPrint->m_printf;
}
/******************************************************************************/
/******************************************************************************
以下函数输出填充字符:
当输出数字时使用左对齐时，在数字右边输出填充字符；
当输出数字时使用右对齐时，在数字左边输出填充字符。
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
根据填充标记do_padding,和填充标记位置标记l_flag,
按照格式符指定的格式向输出端口输出字符串和填充字符
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
根据填充标记do_padding,和填充标记位置标记l_flag,
按照格式符指定的格式（进制、有无符号、字段宽度、
左右对齐等）向输出端口输出字符串和填充字符
******************************************************************************/
static void reoutnum(unsigned	long num, 
					 unsigned	int negative, 
					 const	long	base)

{
	char	*cp;
    char	outbuf[32];
	const	char	digits[] = "0123456789ABCDEF";

	/*************************************************************
	将需要输出的数字按照进制转换成ASCII码，
	以倒序保存在outbuf数组中
	*************************************************************/
	cp = outbuf;
	do
		{
			*cp ++ = digits[(int)(num % base)];
		}while((num /= base) != 0);

	if(negative)
	{
		*cp ++ = '-';			//如果是负数，在数组尾添加负号
	}

	*cp -- = 0;					//为了使用strlen函数，数组尾部添加\0

	
	/************************************************************************
	根据输出数字的对齐方式，在适当地方输出填充字符
	，且保存在outbuf中的字符
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
主要先处理符号位，然后调用reoutnum函数
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
从格式字符串中取出数字（这些数字用来表示字段宽度等）
，而且将连续的ASCII码的数字作为十进制数字。
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
按照格式字符串制定的要求，向端口输出数据,
不是支持所有的标准C数据格式，它只支持嵌入式系统
经常用到的格式,省略了浮点数据格式，
按照已经支持的格式，别的格式可以很容易的被增加进去。
******************************************************************************/
void	printp(char* ctrl, ...)
{
	int	long_flag;
	int	dot_flag;

	char	ch;			
	va_list	argp;		//由于为可变参数函数，需要进行参数提取，
						//argp依次只想各可变参数
	va_start(argp, ctrl);
						//初始化argp,使它指向第一个可变参数
	/*******************************************************************
	ctrl将存在于堆栈中，作为遍历格式字符串的指针，
	利用ctrl作为指针遍历格式字符串，
	如果不是格式控制标记%，就进入下面的if结构，
	将字符输出，然后跳出本次循环，
	开始下次循环，即检查下一个字符；
	如果是%，跳过if进行格式判断与数据输出
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
		当遇到格式控制标记%时，程序将执行下面
		的代码，先初始化所有的标记量
		************************************************************/
		dot_flag = 
		long_flag =
      	left_flag  =
      	do_padding = 0;
      	pad_character = ' ';
		num2 = 32767;

	try_next:
		ch = *( ++ctrl);	//取得格式控制标记%或者数字、点、
		                    //'-'、‘l’后的字符

		if(isdigit(ch))		//判断是否为数字
		{
			if(dot_flag)	//判断数字是在点钱还是在点后，
			                //若是在点前，该数字存入
							//num1，点后存入num2
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

		switch(tolower(ch))	//判断格式控制字符，按照指定格式输出
		                    //数据或者进一步判断输出格式
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
					if( ch == 'D')		//长整形、无符号
					{
						outnum(va_arg(argp, unsigned long), 10L, 0);
						continue;
					}
					else				//长整形、有符号
					{
						outnum(va_arg(argp, long), 10L, 1);
						continue;
					}
				}
				else
				{
					if( ch == 'D')		//整形、无符号
					{
						outnum(va_arg(argp, unsigned int), 10L, 0);
						continue;
					}
					else				//整形、有符号
					{
						outnum(va_arg(argp, int), 10L, 1);
						continue;
					}
				}
			case	'X':	
				if ( long_flag == 1)
				{
					if ( ch == 'X')		//长16进制、无符号
					{
						outnum(va_arg(argp, unsigned long), 16L, 0);
						continue;
					}
					else				//长16进制、有符号
					{
						outnum(va_arg(argp, long), 16L, 1);
						continue;
					}
				} 
				else
				{
					if ( ch == 'X')		//短16进制、无符号
					{
						outnum(va_arg(argp, unsigned int), 16L, 0);
						continue;
					} 
					else				//短16进制、有符号
					{
						outnum(va_arg(argp,	int), 16L, 1);
						continue;
					}
				}

			case	's':				//输出字符串
				outs(va_arg(argp, char*));
				continue;

			case	'c':				//输出字符
				PortToOut.m_printf(va_arg(argp , int));
				continue;
		
			default:
				continue;
		}
		goto	try_next;				//当多个字符控制格式时，
		                                //能执行到这个语句

	}				//for循环结束

	va_end( argp);						//结束可变参数提取
}
