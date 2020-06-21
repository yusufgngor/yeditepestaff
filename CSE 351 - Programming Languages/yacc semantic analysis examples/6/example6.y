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

%union
{
int number;
}

%token <number> INTEGER  // this terminal has a type
%token INTRSW EQUALSYM IDENTIFIER PLUSOP MINUSOP
%type  <number> operand number op // the non-terminals have a type now


%%
decl:
	INTRSW IDENTIFIER EQUALSYM operand {cout<<"result is "<<$4<<endl;}
	;

operand:
	number
	{
		$$=$1; //in this part we send the information to the parent node with $$
	}
	|
	operand op number
	{
		if($2 == 1){
			$$=$1+$3; //in this part we send the information to the parent node with $$
		}else{
			$$=$1-$3; //in this part we send the information to the parent node with $$
		}
		//alternative solution
		//$$=$1 + ($2 * $3); //in this part we send the information to the parent node with $$

	}
	;

op:
	PLUSOP {$$=1;}
	|
	MINUSOP {$$=-1;}
	;

number:
	INTEGER {$$=$1;}
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
