lex syntax.l
yacc -d syntax.y 
gcc y.tab.c lex.yy.c
./a.out sample.txt