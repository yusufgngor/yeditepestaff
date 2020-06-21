all: lex yacc
	g++ lex.yy.c y.tab.c -ll -o example10

yacc: example10.y
	yacc -d example10.y

lex: example10.l
	lex example10.l
clean:
	rm lex.yy.c y.tab.c  y.tab.h  example10
