all:lex yacc
	g++ lex.yy.c y.tab.c -ll -o project
lex:term.l
	lex term.l
yacc:term.y
	yacc -d term.y
clean:
	rm lex.yy.c y.tab.c y.tab.h project

