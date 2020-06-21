all: lex yacc
	g++ lex.yy.c y.tab.c -ll -o example8

yacc: example8.y
	yacc -d example8.y

lex: example8.l
	lex example8.l
clean: 
	rm lex.yy.c y.tab.c  y.tab.h  example8
