lex syntax.l
yacc -d syntax.y
gcc lex.yy.c y.tab.c -ll
./a.out sample1.txt
