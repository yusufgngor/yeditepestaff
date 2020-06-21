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
char *str;
}
%token PLUSOP ASSIGNOP SEMICOLON
%token <str> CHAR VAR
%type <str> s
%%

p:
    st SEMICOLON p | st

st:
    VAR ASSIGNOP s
	{
		cout<<$3<<endl;
	}

s:
    CHAR PLUSOP s
	{
		string combined = string($1)+string($3);
		$$ = strdup(combined.c_str());
		// we cannot pass string type to $$, it needs char *
		// c_str() convert string to const char *
		// since we need char *, not const char *, we used strdup to obtain char *.
	}
	|
	CHAR
	{
		$$=$1;
	}
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
