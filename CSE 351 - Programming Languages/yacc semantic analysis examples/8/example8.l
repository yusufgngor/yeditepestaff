%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
int linenum;
%}
%%
[a-zA-Z][a-zA-Z]+ {yylval.str = strdup(yytext);return VAR;}
\+	return PLUSOP;
\=  return ASSIGNOP;
\; return SEMICOLON;
[a-zA-Z0-9] {yylval.str = strdup(yytext);return CHAR;}
\n	linenum++;
[ \t]+
%%
