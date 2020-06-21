all: lex yacc
	g++ lex.yy.c y.tab.c -ll -o lab2out

yacc: lab2.y
	yacc -d lab2.y

lex: lab2.l
	lex lab2.l
clean: 
	rm lex.yy.c y.tab.c  y.tab.h  lab2out
