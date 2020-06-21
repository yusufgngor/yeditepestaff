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

	/*
		we need to store the name of variable and  value of it.
		So we can use two array for that. One for keeping names, one for the values.
		But it would be a little bit complicated.
		Instead we use map library of c++.
		This is not about lex and yacc it is about data structure
	*/
	map<string,int> values;
%}

%union
{
int number;
char *str;
}

%token  MINUSOP PLUSOP OPENPAR CLOSEPAR DIVIDEOP MULTOP ASSIGNOP
%token<number> INTEGER
%token<str> VARIABLE
%type<number> expression
%left PLUSOP MINUSOP
%left MULTOP DIVIDEOP
%%

program:
    statement
	|
	statement program
    ;

statement:
    expression                      { cout<<$1<<endl;}
    |
	VARIABLE ASSIGNOP expression
	{
				values[string($1)] = $3;
				cout<<$1<<" = "<<values[string($1)]<<endl;
	}
    ;

expression:
    INTEGER	{$$=$1;}
    |
	VARIABLE                      { $$ = values[string($1)];}
    |
	expression PLUSOP expression     { $$ = $1 + $3; }
    |
	expression MINUSOP expression     { $$ = $1 - $3; }
    |
	expression MULTOP expression     { $$ = $1 * $3; }
    |
	expression DIVIDEOP expression     { $$ = $1 / $3; }
    |
	OPENPAR expression CLOSEPAR            { $$ = $2; }
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
