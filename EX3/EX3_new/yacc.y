%{
    #include <stdlib.h>
    #include <stdio.h>
    extern FILE* yyin;
    int yylex(void);
    int yyerror();
    #include "y.tab.h"
    extern int line;
    int error = 0;
%}
%start long_statment
%token ID DATA_TYPE  
%token CHAR STRING NUMBER
%token LOGICAL_OP UNARY_OP BITWISE_OP RELATIONAL_OP ARITHMETIC_OP ARITH_ASSIGN_OP
%token RETURN IF ELSE FOR PRINT ASSIGN_OP PPD WHILE
%%
long_statment: 
    PPD long_statment
	| DATA_TYPE ID '(' ')' '{' long_statment '}'
    | statments long_statment
    | statments
    | '\n'
    ;
statments:
    declaration ';' statments
    | assignment ';' statments
    | RETURN NUMBER ';'
    | PRINT '(' printexpression ')'';'statments
    | loop_block_while statments
    | loop_block_for statments
    | cond_stmt statments
    |
    ;
cond_stmt: IF '(' expression ')' '{' statments '}'
    | IF '(' expression ')' '{' statments '}' ELSE '{' statments '}'
loop_block_while:
    WHILE '(' expression ')' '{' statments '}'
    ;
loop_block_for:
    FOR '('for_expression')' '{' statments '}'
    ;
for_expression:
    declaration ';' ID RELATIONAL_OP NUMBER  ';' for_increment
    ;
for_increment:
     UNARY_OP ID
	| ID UNARY_OP
    | ID ARITH_ASSIGN_OP expression
    ;
declaration:
    DATA_TYPE variables
    ;
variables:
    variables ',' assignment
    | assignment
    | ID
    ;
assignment:
    assignment ASSIGN_OP expression
    | ID
    ;
printexpression:
    STRING
    | STRING ',' printexpression
    | ID ',' printexpression
    | ID
    ;
expression:
	'(' expression ')'
	| expression LOGICAL_OP expression
	| expression ARITHMETIC_OP expression
	| expression ARITH_ASSIGN_OP expression
	| expression RELATIONAL_OP expression
	| expression BITWISE_OP expression
	| UNARY_OP expression
	| expression UNARY_OP
	| ID '[' expression ']'
	| NUMBER
	| ID
	| CHAR
	| STRING
    |
	| /* empty */
%%
int yyerror(){
    printf( "---\nSyntax is NOT valid!\nError around line %d\n", line);
    error = 1;
    return 0;
}

int yywrap() {
	return 1;
}

int main(int argc, char **argv) {
    yyin = fopen(argv[1], "rt");
    if(!yyin)
    {   
    printf("File not found!\n");
    return 0;
    }
    yyparse();
    if(error!=1){
        printf("The input program has a valid syntax!\n");
    }
    return 0;
}