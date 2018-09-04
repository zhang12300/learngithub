#ifndef	__MYPRINTP_H__
#define	__MYPRINTP_H__

#ifdef	__cpluscplus
extern "C"{
#endif

#include    <MK60N512VMD100.h> 
#include    <ctype.h>
#include    <string.h>
#include    <stdarg.h>


typedef void (*myprintf)(char) ;

typedef struct PRINT_T
{
	myprintf m_printf;			
}PRINT_T;
extern void Print_Init(PRINT_T *pPrint);
extern void printp(char* ctrl, ...);

#ifdef	__cpluscplus
}
#endif

#endif