%{
    #include <stdio.h>
    #include <stdlib.h> 
    #include <fcntl.h>
    #include <unistd.h>
    int yylex(void);
    extern FILE* yyin;
    #include "y.tab.h"
    int error = 0;
    extern int line;
%}
%token FOR MAIN RETURN IF ELSE WHILE DO ID NUM DTYPE EOS PREPRO COMPARISON_OP UN_OP ASSIGN_OP RSHIFT LSHIFT NOT OR AND AR_OP
%%
long_stmt: statement long_stmt
    | statement
    | PREPRO "int main(){" long_stmt "}"
    ;
statement: loop_block
    | cond_stmt
    | declaration_stmt EOS
    | assignment_stmt EOS
    | '{' statement '}'
    ;
loop_block: WHILE '(' expr ')' statement;
declaration_stmt: DTYPE var;
var: var ',' assignment_stmt
    | assignment_stmt
    | ID
    ;
cond_stmt: IF '(' expr ')' statement ELSE statement
    | IF '(' expr ')' statement
    ;
assignment_stmt: assignment_stmt ASSIGN_OP expr
    | ID
    ;
expr: expr COMPARISON_OP expr
    | expr AR_OP expr
    | ID UN_OP
    | UN_OP ID
    | NOT expr
    | expr AND expr
    | expr OR expr
    | expr RSHIFT expr
    | expr LSHIFT expr
    | '(' expr ')'
    | ID
    | NUM
    | NUM '.' NUM
    ;
%%
int yyerror(){
    fprintf(stderr, "Syntax is NOT valid!Error at line %d\n", line);
    error = 1;
    return 0;
}
int yywrap(){
    return 1;
}
int main(int argc, char **argv){
    yyin = fopen(argv[1], "rt");
    if(!yyin)
    {   
    printf("File not found!\n");
    return 0;
    }
    yyparse();
    if(!error){
        printf("The input program has a valid syntax!\n");
    }
    return 0;
}
