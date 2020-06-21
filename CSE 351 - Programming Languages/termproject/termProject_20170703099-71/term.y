%{
	#include "y.tab.h"
	#include <iostream>
    #include <vector>
    #include <algorithm>
    #include <string.h>
    #include <map>  
	using namespace std;
	extern FILE *yyin;
	extern int yylex();
    extern int lineno;
    extern int tabcount;
	void yyerror(string s);
    string givetypestr(unsigned short);
    unsigned short ifcounter=0;
    bool ifopened=false,isloopstart=false;
    map<unsigned short,vector<string>> allvars;
    map<string,unsigned short> varcur;
    
    bool compareFunction (string& a, string& b) {return a<b;} 
%}

%union
{  
    struct datam{
	char* varname;
	unsigned short type;
	};
	datam data;
    int tab;
	bool opened;
    char* str;

}

%token NLINE  EQ  IF CLMN ELIF  ELSE
%token <tab> TAB
%token <str> VARIABLE STRING INTEGER FLOAT OP COND
%type <str>  commands assign ifelse condution
%type <data> expr type command
%left OP NLINE
%start program
%%
program:commands  {
    string text = string($1);


    cout << "void main()\n{";
    for(int i=0;i<3;i++)
    {
        if(allvars[i].size()==0)
            continue;
        string type;
        if(i==0)
            type="int";
        else if(i==1)
            type="float";
        else if(i==2)
            type="string";
        cout << "\n\t"<<type<<" ";

        sort(allvars[i].begin(),allvars[i].end(),compareFunction);

        for(int j=0;j<allvars[i].size();j++)
            if(j!=allvars[i].size()-1)
            cout << (allvars[i])[j]<<"_"<<givetypestr(i)<<",";
            else
            cout << (allvars[i])[j]<<"_"<<givetypestr(i);
        cout << ";";

    }
    cout <<endl;
    cout << "\n";
    bool f=true;
    for (int i=0;text[i]!='\0';i++){
        
        if (text[i]=='\n')
            {
                cout<<"\n";
                f=true;
            }
        else
            {
                if (f)
                    cout<<"\t";
                cout<<text[i];
                f=false;
            }
    }
    cout << "}"<<endl;
    
}

commands:TAB command
{   
    string temp;
    for(int i=0;i<$1;i++)
        temp+="\t";
    temp=temp+ string($2.varname);
    $2.varname = strdup(temp.c_str());

    //cout << ifopened << " - " <<"if count: "<< ifcounter << " tab:" << $1 <<endl;
	if(ifopened){
		if(ifcounter == $1)
		{
        ifopened = false;
		//cout << "girdi at "<< lineno ;
		}
		else{
	        cout << "tab inconsistency in line "<< lineno << endl;
			return 0;
		}


	}

    
	else if ($1 > ifcounter )
    {
        cout << "tab inconsistency in line "<< lineno << endl;
        return 0;
    }
    else if ($1 < ifcounter)
    {
        string tempclose;
        int diff = ifcounter - $1;

        for(int j=0;j<diff;j++)
        {
            for(int i =0 ;i<ifcounter-1-j;i++)
            tempclose+="\t";
            tempclose=tempclose+ "}\n";
        }

        tempclose+=string($2.varname);
        $2.varname = strdup(tempclose.c_str());
        ifcounter = $1;
    }
	if($2.type)
    {
        ifcounter++;
        ifopened =true;
        string temp1="\n";
        for(int i=0;i<$1;i++)
        temp1+="\t";

        temp1 = string($2.varname) +temp1+ "{";
        $2.varname = strdup(temp1.c_str());
    }

    //cout <<"tab:"<< $1 << " - " << ifcounter<<endl;
   
    temp = string($2.varname);
    $$ = strdup(temp.c_str());
    
}
    |
    command
    {
    if(ifcounter>0)
    {
        string tempclose;
        for(int i =0 ;i<ifcounter-1;i++)
            tempclose+="\t";
        tempclose=tempclose+ "}\n"+string($1.varname);
        $1.varname = strdup(tempclose.c_str());
	ifcounter =0;
    }
	//cout << ifopened << endl;
    if(ifopened){
        cout << "error in line "<<lineno<<": at least one line should be inside if/elif/else block "<<endl;
        return 0;
    }
    if($1.type)
       {
        ifcounter++;
        ifopened = true;
        string temp2= string($1.varname) + "\n{";
        $1.varname = strdup(temp2.c_str());
       }
    else{
	   ifopened=false;
	   	}
    
    string temp = string($1.varname);
    $$ = strdup(temp.c_str());
    }
    |
    commands NLINE commands
    {
        if(string($3)!="\n"){
            string combined = string($$)+"\n"+string($3);
		    $$ = strdup(combined.c_str());
        }
    }
command: assign
{
    $$.type = false;
    $$.varname = $1;
}
    |
    ifelse
    {
       $$.type = true;
       $$.varname = $1;
    }
	|
	 {$$.type = false;
        $$.varname = strdup("");
     }
    ;
ifelse: 
    IF condution CLMN
	{
		isloopstart = true;
        string temp = "if" + string($2);
        $$ = strdup(temp.c_str());

	}
    |
    ELIF condution CLMN
    {
        if(ifcounter ==0 ){
            cout << "else without if in line "<< lineno << endl; 
            return 0 ;
        }
		else if(!isloopstart)
		{
			cout << "elif after else in line " << lineno<<endl;
			return 0;
		}
        string temp = "else if" + string($2);
        $$ = strdup(temp.c_str());
    }
    |
    ELSE CLMN
	{
		isloopstart = false;
		if(ifcounter ==0){
            cout << "else without if in line "<< lineno << endl; 
            return 0 ;
        }
        string temp = "else";
        $$ = strdup(temp.c_str());
	}
    ;
assign: VARIABLE EQ expr
    {
        string temp = string($1);
        // vectorun içinde  o vaar yoksa ekle
        std::vector<string>::iterator it;
        short i = $3.type;
        if (!(std::find(allvars[i].begin(), allvars[i].end(),temp)!=allvars[i].end()))
            allvars[i].push_back(temp);
        
        //real vectorunde de ekle
        varcur[temp] = $3.type;

        string c= string($1)+"_"+givetypestr(varcur[$1]) +" = " + $3.varname+";";
        $$ = strdup(c.c_str());
        

    }
;


expr:VARIABLE
    {
        unsigned short ty = varcur[string($1)];
        $$.type = ty;
        string temp = string($1)+"_"+givetypestr(ty);
        $$.varname = strdup(temp.c_str());
    }
    |
    type
    {
        $$.type=$1.type;
        string temp =string($1.varname);        
        $$.varname = strdup(temp.c_str());
    }
    |
    expr OP expr
    {
        
        string combined = string($$.varname)+" "+$2+" " +string($3.varname);
		$$.varname = strdup(combined.c_str());
        //cout <<  $1.varname << " - " << $3.varname << endl;
        
		if($1.type==$3.type)
			$$.type=$1.type;
		else if( $1.type==1 && $3.type==0 )
			$$.type=1;
        else if( $1.type==0 && $3.type==1 )
			$$.type=1;
		else{
			cout << "type mismatch in line "<< lineno <<endl;
			return 0;
		}
        //cout << "ilk: " << $1 << "iki" << $3 <<endl;

    }
    ;

type:
    INTEGER
    {
        string temp = string($1);
		$$.varname = strdup(temp.c_str());
        $$.type = 0;
    }   
    |
    FLOAT
    {
        string temp = string($1);
		$$.varname = strdup(temp.c_str());
        $$.type = 1;
    }
    |
    STRING
    {   
        string temp = string($1);
		$$.varname = strdup(temp.c_str());
        $$.type = 2;
    }
    ;

condution: expr COND expr
    {
        //cout << "comp :" << $1 << " - " << $3 << endl;
        if( (($3.type == 2) && ($1.type != 2)) || ( ($1.type == 2) && ($3.type!=2)) )
            {
                cout << "comparison type mismatch in line "<<lineno<<endl;
                return 0;
            }
        string temp ="( " +string($1.varname) +  " " + string($2) + " "+ string($3.varname) +" )";
        $$ = strdup(temp.c_str());
    };

%%

string givetypestr(unsigned short a){

    if(a==0)
        return "int";
    if(a==1)
        return "flt";
    else
        return "str";


}


void yyerror(string s){
	cout<<"error "<< s<<endl;

}
int yywrap(){
	return 0;
}
int main(int argc, char *argv[])
{
    /* Call the lexer, then quit. */
    yyin=fopen(argv[1],"r");
    yyparse();
    fclose(yyin);
    return 0;
}





