all: lex yacc
	g++ lex.yy.c y.tab.c -ll -o out

yacc: lab3.y
	yacc -d lab3.y

lex: lab3.l
	lex lab3.l
clean: 
	rm lex.yy.c y.tab.c  y.tab.h  out
