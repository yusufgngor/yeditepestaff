all: lex yacc
	g++ lex.yy.c y.tab.c -ll -o example7

yacc: example7.y
	yacc -d example7.y

lex: example7.l
	lex example7.l
clean: 
	rm lex.yy.c y.tab.c  y.tab.h  example7


