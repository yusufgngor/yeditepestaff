%{
#include "y.tab.h"
int linenum=1;
%}
digit	[0-9]
letter	[A-Za-z]


%%
[0-9]+\.[0-9]+ {yylval.str = strdup(yytext);	return FLOAT;}
[0-9]+ 	{yylval.str=strdup(yytext);	return INTEGER;}

= return EQ;
[ \t]
\n linenum++;
\+ return PLUSOP;
\"{letter}({letter}|{digit})*\" {yylval.str = strdup(yytext); return STRING;}
{letter}({letter}|{digit})* {yylval.str = strdup(yytext); return VARIABLE;}
%%