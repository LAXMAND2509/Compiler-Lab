%{
    #include <stdlib.h>
    #include <stdio.h>
    extern FILE* yyin;
    int yylex(void);
    int yyerror();
    #include "y.tab.h"
    extern int line;
    int error = 0;
    int termCount = 1,controlCount = 1;

%}
%token TERM ASSIGN_OP ARITH_OP REL_OP ID BOOL_OP EOS IF ELSE WHILE SWITCH CASE DEFAULT BREAK DO MINUS_OP ROUND_LEFT ROUND_RIGHT
%union
{
	int intval;
	float floatval;
	char *str;
}
%type<str> TERM REL_OP ARITH_OP ASSIGN_OP BOOL_OP MINUS_OP
%%
line: /*empty*/
	| TERM ASSIGN_OP TERM ARITH_OP TERM EOS { printf("t%d := %s %s %s\n%s := t%d\n\n", termCount, $3, $4, $5, $1, termCount); termCount++; } line
	| TERM ASSIGN_OP TERM MINUS_OP TERM EOS { printf("t%d := %s %s %s\n%s := t%d\n\n", termCount, $3, $4, $5, $1, termCount); termCount++; } line
	| TERM ASSIGN_OP TERM REL_OP TERM EOS { printf("t%d := %s %s %s\n%s := t%d\n\n", termCount, $3, $4, $5, $1, termCount); termCount++; } line
    | TERM ASSIGN_OP MINUS_OP TERM EOS{ printf("t%d := %s %s\n%s := t%d\n\n", termCount, $3, $4, $1, termCount); termCount++; } line
    | TERM ASSIGN_OP TERM EOS {printf("t%d := %s\n%s := t%d\n\n", termCount, $3, $1, termCount); termCount++; } line
    | while_block

while_block: WHILE ROUND_LEFT TERM REL_OP TERM ROUND_RIGHT '{' { printf("LABEL_%d:\n if not %s %s %s then goto FALSE_%d\n\nTRUE_%d:\n",controlCount,$3,$4,$5,controlCount,controlCount); printf("{\n");} line {printf("goto LABEL_%d \n}\n",controlCount);} '}' {printf("FALSE_%d: ",controlCount); controlCount++;} line
    | WHILE ROUND_LEFT TERM ARITH_OP TERM ROUND_RIGHT '{' { printf("LABEL_%d:\n if not %s %s %s then goto FALSE_%d\n\nTRUE_%d:\n",controlCount,$3,$4,$5,controlCount,controlCount); printf("{\n");} line {printf("goto LABEL_%d \n}\n",controlCount);} '}' {printf("FALSE_%d: ",controlCount); controlCount++;} line
    | WHILE ROUND_LEFT TERM BOOL_OP TERM ROUND_RIGHT '{' { printf("LABEL_%d:\n if not %s %s %s then goto FALSE_%d\n\nTRUE_%d:\n",controlCount,$3,$4,$5,controlCount,controlCount); printf("{\n");} line {printf("goto LABEL_%d \n}\n",controlCount);} '}' {printf("FALSE_%d: ",controlCount); controlCount++;} line
 
%%
int yyerror(char* s)
{
  fprintf(stderr, "%s\n", s);
  return 0;
}
int yywrap(){
	return 1;
}

int main(int argc, char **argv){
	/*yydebug = 1;*/
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
	
printf("\n");
	return 0;
}