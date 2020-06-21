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

%token <str> TOKHEAT TOKTEMPERATURE TOKTARGET STATE NUMBER

%%
commands:
	| commands command
	;

command:
	heat_switch
	|
	target_set
	;

heat_switch:
	TOKHEAT STATE
	{
		//if(strcmp($2,"on") == 0) //this is alternative to convert it to string 
		if(string($2) == "on")
			cout<<"Heat turned on\n";

		else
			cout<<"Heat turned off\n";
	}
	;

target_set:
	TOKTARGET TOKTEMPERATURE NUMBER
	{
		cout<<$1<<"  is "<<$3<<endl;
		cout<<$2<<" is set to "<<$3<<endl;

	}
	;

%%
void yyerror(string s){
	cout<<"error "<< s<<endl;

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
