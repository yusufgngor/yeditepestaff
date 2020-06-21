%{
	#include <stdio.h>
	#include <iostream>
	#include <string>
	#include "y.tab.h"
	using namespace std;

	extern FILE *yyin;
	extern int yylex();
	extern int linenum;
	void yyerror(string s);

	string finalOutput="";

%}

%union
{
	char *str;
}
%token PLUSOP ASSIGNOP OPB CMM CLB
%token <str> VAR  NUM
%type <str> list sub_list

%%

st:
	VAR ASSIGNOP list
	{

	};

list:
 	OPB sub_list CLB
	{

	}

sub_list:
	sub_list CMM NUM
	{


		finalOutput+="\n<i>"  + string($3) +"</i>";

	}
    |
    NUM
	{
		finalOutput+="<i>"+string($1)+"</i>";


	};

%%

void yyerror(string s){
	cout<<"error at line: "<<linenum<<endl;
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

	cout<<finalOutput<<endl;
    return 0;
}
