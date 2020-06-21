all: lex yacc
	g++ lex.yy.c y.tab.c -ll -o example5

yacc: example5.y
	yacc -d example5.y

lex: example5.l
	lex example5.l
clean: 
	rm lex.yy.c y.tab.c  y.tab.h  example5