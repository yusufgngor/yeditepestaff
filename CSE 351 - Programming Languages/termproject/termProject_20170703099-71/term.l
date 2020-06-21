digit	[0-9]
letter	[A-Za-z]
%{
#include "y.tab.h"
int tabcount = 0;
unsigned int lineno=1;
%}
%%
elif {  return ELIF ;}
if { return IF ;}
else { return ELSE;}
\n {lineno++; return NLINE;}
-?{digit}+\.{digit}+ { yylval.str = strdup(yytext);return FLOAT;}
-?{digit}+  { yylval.str = strdup(yytext);return INTEGER;}
\"({letter}|{digit})*\" { yylval.str = strdup(yytext); return STRING;}
{letter}({letter}|{digit})*  { yylval.str = strdup(yytext); return VARIABLE;}
[*/+-]  {yylval.str = strdup(yytext);return OP;}
(<|>|<=|>=|==|!=) {yylval.str = strdup(yytext);return COND;}
:  return CLMN;
=  return EQ;

(\t|[ ]{4})+ {
    tabcount =0;
    for(int i =0;i<=strlen(yytext);i++)
        if(yytext[i]=='\t')
            tabcount++;
        //printf("%d adet tab bulundu",tabcount);
    yylval.tab = tabcount;
    return TAB;
} 


[ ] //space



%%
