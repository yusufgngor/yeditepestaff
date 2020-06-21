all: lex yacc 
	g++ lex.yy.c y.tab.c -ll -o example9

yacc: example9.y
	yacc -d example9.y

lex: example9.l
	lex example9.l
clean: 
	rm lex.yy.c y.tab.c  y.tab.h  example9
