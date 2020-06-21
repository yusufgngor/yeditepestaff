%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

int linenum;
%}
%%
[0-9]+	{yylval.number = atoi(yytext);return INTEGER;}
\-	return MINUSOP;
\+	return PLUSOP;
\(	return OPENPAR;
\)	return CLOSEPAR;
\/	return DIVIDEOP;
\*	return MULTOP;
=	return ASSIGNOP;
\n	linenum++;
[a-z]([a-z]|[0-9])*	{yylval.str =strdup(yytext); return VARIABLE;}

[ \t]+
%%

/*use the line below to show what will happen if strdup is not used
[a-z]([a-z]|[0-9])*	{yylval.str =yytext; return VARIABLE;}

*/
