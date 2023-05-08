lex lex.l
yacc -d yacc.y 
gcc y.tab.c lex.yy.c
./a.out sample.txt