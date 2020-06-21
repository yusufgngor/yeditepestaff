%{
	#include "y.tab.h"
	#include <stdio.h>
	#include <iostream>
	#include <string.h>
	#include <map>
	using namespace std;
	extern FILE *yyin;
	extern int yylex();
	extern int linenum;
	void yyerror(string s);
	
	map<string,string> vars;
	FILE *out;
	string text;
	
	
%}

%union
{

	struct denem{
	char* varname;
	int type;
	};
char *str;
denem dene;

}
%token <str> VARIABLE STRING INTEGER FLOAT
%token EQ PLUSOP
%type <dene> type assign assigns
%type <str> command 

%%
program:
	commands
	{
		string inttext,floattext,stringtext;
		for (std::map<string,string>::iterator it=vars.begin(); it!=vars.end(); ++it){
				if(it->second == "int")
					inttext +=it->first +",";
				else if(it->second == "float")
					floattext +=it->first + ",";
				else
					stringtext+= it->first + ",";
		}
		if (!inttext.empty()) {
		inttext.pop_back();
		inttext = "int " + inttext +";\n";
		cout << inttext;
		fprintf(out,"%s",inttext.c_str());




	     }
		 if (!floattext.empty()) {
			floattext.pop_back();
			floattext = "float "+ floattext +";\n";
			cout << floattext;
			fprintf(out,"%s",floattext.c_str());


	     }
		 if (!stringtext.empty()) {
			stringtext.pop_back();
			stringtext = "string " +stringtext +";\n";
			cout << stringtext;
			fprintf(out,"%s",stringtext.c_str());
	     }


		cout << endl;
		fprintf(out,"%c",'\n');

		cout << text;
		fprintf(out,"%s",text.c_str());

	}
	;

commands:
	command
	{
		
	}
	| 
	commands command
	{
		
	}
	;

command:
	VARIABLE EQ assigns
		{
			text += string($1) + " = " + string($3.varname) + ";\n";
			if($3.type==0){
				vars[string($1)]="int";
				//cout<<"int found"<<endl;
			}
			else if($3.type==1){
				vars[string($1)]="float";
				//cout<<"float found"<<endl;
			}
			else
			{
				vars[string($1)]="string";
				//cout<<"string found"<<endl;
			}
		}
	;

assigns:
	assign
	{
		$$=$1;
	}
	|
	assigns PLUSOP assign{
		string combined = string($$.varname)+" + "+string($3.varname);
		$$.varname = strdup(combined.c_str());

		if($1.type==$3.type)
			$$.type=$1.type;

		else if($1.type==1 && $3.type==0  )
			$$.type=1;

		else if($1.type==0 && $3.type==1  )
			$$.type=1;

		else{
			cout << "type mtabismatch in line "<< linenum <<endl;
			fprintf(out,"type mismatch in line %d",linenum);
			return 1;
		}
	}
	;

assign:
	type
	{
		 $$=$1;
	}
	|
	VARIABLE
	{
		//if it is a variable check the variable exist in map if it is return of variable's type;
		auto search = vars.find(string($1));  
    	if (search != vars.end())
	 	{  
			if(search->second=="int")
			{
				$$.type = 0;
				string temp = string($1);
				$$.varname = strdup(temp.c_str());
			
			}
		else if(search->second=="float")
			
			{
				$$.type = 1;
				string temp = string($1);
				$$.varname = strdup(temp.c_str());
			}
		else if(search->second=="string")
			
			{
				$$.type = 2;
				string temp = string($1);
				$$.varname = strdup(temp.c_str());
			}
		} 
		else 
		{  
        cout <<"Untyped variable is used in line " << linenum<<endl;
		fprintf(out,"Untyped variable is used in line %d",linenum); 
		return 1; 
		}  

	}
	;

	

type:
	INTEGER {
		//if any type can be found store that  it's type and itself
		$$.type = 0;
		string temp = string($1);
		$$.varname = strdup(temp.c_str());
	}
	|
	FLOAT {		
		$$.type = 1;
		string temp = string($1);
		$$.varname = strdup(temp.c_str());
	}
	|
	STRING {
		$$.type = 2;
		string temp = string($1);
		$$.varname = strdup(temp.c_str());
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
	out=fopen(argv[2],"w");
    yyparse();
    fclose(yyin);
	fclose(out);
    return 0;
}
