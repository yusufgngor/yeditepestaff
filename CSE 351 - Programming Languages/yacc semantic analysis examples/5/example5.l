%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}
%%
[0-9]+ 	yylval.str=strdup(yytext);	return NUMBER;
heat 	yylval.str=strdup(yytext);	return TOKHEAT;
on|off	yylval.str=strdup(yytext);	return STATE;
target	yylval.str=strdup(yytext);	return TOKTARGET;
temperature	yylval.str=strdup(yytext);	return TOKTEMPERATURE;
\n
[ \t]+
%%
