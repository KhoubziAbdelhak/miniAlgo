
miniAlgo: lex.yy.c miniAlgo.tab.c
	gcc miniAlgo.tab.c lex.yy.c -lfl -ly -o miniAlgo

lex.yy.c: miniAlgo.l miniAlgo.tab.c
	lex miniAlgo.l

miniAlgo.tab.c: miniAlgo.y
	bison -d miniAlgo.y

clean:
	rm miniAlgo.tab.c miniAlgo.tab.h lex.yy.c miniAlgo

