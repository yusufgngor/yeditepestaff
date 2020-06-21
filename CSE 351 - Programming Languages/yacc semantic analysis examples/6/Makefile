all: lex yacc
	g++ lex.yy.c y.tab.c -ll -o example6

yacc: example6.y
	yacc -d example6.y

lex: example6.l
	lex example6.l
clean: 
	rm lex.yy.c y.tab.c  y.tab.h  example6
