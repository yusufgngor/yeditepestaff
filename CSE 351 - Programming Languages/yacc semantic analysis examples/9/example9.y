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


    FILE *out;
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
		cout<<"<"<<$1<<">\n"<<$3<<"\n"<<"</"<<$1<<">";
		fprintf(out,"<%s>\n%s\n</%s>",$1,$3,$1); // writo to the file
	};

list:
 	OPB sub_list CLB
	{
		$$=$2;
	}

sub_list:
	sub_list CMM NUM
	{

		string combined =  string($1) + "\n<i>"  + string($3) +"</i>";
		$$ = strdup(combined.c_str());

	}
    |
    NUM
	{
		string combined="<i>"+string($1)+"</i>";
		$$ = strdup(combined.c_str());
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
	if(argc != 3)
	{
		printf("this program needs input file and output file name as input, you forget one of them\n");
		return 0;
	}
    yyin=fopen(argv[1],"r");
    out=fopen(argv[2],"w");

    yyparse();
    fclose(yyin);
    fclose(out);
    return 0;
}
