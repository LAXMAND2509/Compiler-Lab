%{
    #include <stdlib.h>
    #include <stdio.h>
    int yylex(void);
    extern FILE* yyin;
    #include "y.tab.h"
%}

%token ID NUM COMP ARITH WHILE IF ELSE INT

%%
L : L S | S 

S : WHILE '(' E ')' S | IF '(' E ')' S ELSE S | IF '(' E ')' S | '{' L '}' | AS ';' | DL ';' 
 
E : E R E | E A E | ID | NUM

R : COMP

A : ARITH

AS : AS '=' E | ID

DL : T V

T : INT

V : V ',' AS | AS 

%%
int yyerror(char* str){
    fprintf(stderr, "%s\n", str);
    return 0;
}
int yywrap(){
    return 1;
}

int main(int argc, char **argv){
    if(argc != 2){
        fprintf(stderr, "Enter file name as argument!\n");
        return 1;
    }
    yyin = fopen(argv[1], "rt");
    if (!yyin){
        fprintf(stderr, "File not found!\n");
        return 2;
    }
    yyparse();
    return 0;
}
