%{
	#include <stdio.h>
	#include <iostream>
	#include <string>
	using namespace std;
	#include "y.tab.h"
	extern FILE *yyin;
	extern int yylex();
	void yyerror(string s);
%}



%token DEFTOK VAR SPACE OPENBR CLOSEBR COMMA CLMN TAB RTRN LINE

%%
program:
	function
	|program function
	;
	
function:
	DEFTOK SPACE VAR OPENBR vars CLOSEBR CLMN LINE TAB code
	;

vars:
	VAR
	|vars COMMA VAR
	;
	
code:
	RTRN SPACE vars
	;

%%
void yyerror(string s){
	cout<<"error: "<<s<<endl;
}
int yywrap(){
	return 1;
}
int main(int argc, char *argv[])
{
    /* Call the lexer, then quit. */
    yyin=fopen(argv[1],"r");
    yyparse();
    fclose(yyin);
    return 0;
}
