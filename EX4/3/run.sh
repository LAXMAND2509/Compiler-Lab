lex ICG.l
yacc -d ICG.y 
gcc y.tab.c lex.yy.c
./a.out sample.txt