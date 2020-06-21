%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
int linenum;
%}
%%
[a-zA-Z][a-zA-Z0-9]* {yylval.str = strdup(yytext);return VAR;}
[0-9]+ {yylval.str = strdup(yytext);return NUM;}
\=  return ASSIGNOP;
\[  return OPB;
\]  return CLB;
\,  return CMM;
\n	linenum++;
[ \t]+
%%
