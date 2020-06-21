%{
	#include <stdio.h>
	#include <iostream>
	#include <string>
	#include <map>
	using namespace std;
	#include "y.tab.h"
	extern FILE *yyin;
	extern int yylex();
	void yyerror(string s);
%}



%token VAR DEFTOK RETURNTOK OPENPAR CLOSEPAR TABTOK CMM CLMN SPACE

%%

program:
	function { cout << "f called"<<endl;}
	|
	function program
	;
function:
	DEFTOK SPACE VAR OPENPAR parameters CLOSEPAR CLMN TABTOK RETURNTOK parameters
	;
parameters:
	VAR { cout << "var called"<<endl;}
	|
	parameters CMM VAR {  cout << "paramet var called"<<endl;}
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


	
codes:
	TAB RTRN vars
	;
	
	vars:
	VAR
	|vars COMMA VAR
	;
	
code:
	RTRN SPACE vars
	;