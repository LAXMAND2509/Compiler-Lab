%{
    #include <stdlib.h>
    #include <stdio.h>
    int yylex(void);
    extern FILE* yyin;
    #include "y.tab.h"
    int error = 0;
    /*extern int debug;*/
    extern int line;
    int temp=0, label=0;
%}
%token NUM DTYPE IF WHILE FOR ELSE ID EOS COMPARISON_OP ASSIGN_OP INDE_OP ARITH_OP ARITH_OP_2 RSHIFT LSHIFT NOT AND OR
%union{
    int intval;
    float floatval;
    char *str;
}
%type<str> statement cond_statement assgn_statement expr term factor NUM ASSIGN_OP ARITH_OP COMPARISON_OP program ARITH_OP_2 ID AND OR NOT
%%
program: statement {printf("%s",$1);} program | statement {printf("%s",$1);};
statement : assgn_statement EOS {sprintf($$,"%s\n",$1);}
| cond_statement {sprintf($$,"%s\n",$1);}
| '{' program '}' {sprintf($$,"{%s}\n",$2);};

assgn_statement: ID ASSIGN_OP expr {sprintf($$,"%s %s %s",$1,$2,$3);};
expr: expr ARITH_OP term {printf("t%d = %s %s %s\n",temp, $1,$2,$3); sprintf($$,"t%d",temp); temp++;}
    | expr COMPARISON_OP term {printf("t%d = %s %s %s\n",temp, $1,$2,$3); sprintf($$,"t%d",temp); temp++;}
    | expr AND term {printf("t%d = %s %s %s\n",temp, $1,$2,$3); sprintf($$,"t%d",temp); temp++;}
    | expr OR term {printf("t%d = %s %s %s\n",temp, $1,$2,$3); sprintf($$,"t%d",temp); temp++;}
    | term {sprintf($$,"%s",$1);};
term: term ARITH_OP_2 factor {printf("t%d = %s %s %s\n",temp, $1,$2,$3); sprintf($$,"t%d",temp); temp++;}
    | factor {sprintf($$,"%s",$1);};
factor: ID {$$=$1;}
    | NUM {$$=$1;};
cond_statement : IF '(' expr ')' statement ELSE statement {sprintf($$,"if %s goto l%d\ngoto l%d\nl%d: \n%s\nl%d: \n%s\n",$3,label,label+1,label,$5,label+1,$7);label+=2;}
    | IF '(' expr ')' statement {sprintf($$,"if %s goto l%d\ngoto l%d\nl%d: \n%s\nl%d: ",$3,label,label+1,label,$5,label+1);label+=2;}
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
if(!error){
    printf("Valid syntax!\n");
}
return 0;
}