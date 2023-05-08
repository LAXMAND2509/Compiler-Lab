%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
    int yylex(void);
    int yyerror(char* s);
    extern int yylval;
    int debug=0;
    int line=1;
%}
%%
[ \t]+ ;
\n {line++;}
[0-9]+ {return NUM;}
("int"|"float"|"char"|"double"|"void") {return DTYPE;}
"if" {return IF;}
"while" {return WHILE;}
"#include ".*">" {return PREPRO;}
"else" {return ELSE;}
[_a-zA-Z][a-zA-Z0-9_]* {return ID;}
";" {return EOS;}
(">"|"<"|"<="|">="|"!="|"==") {return COMPARISON_OP;}
("+"|"-"|"*"|"/"|"%") {return AR_OP;}
("+="|"-="|"*="|"/="|"=") {return ASSIGN_OP;}
("++"|"--") {return UN_OP;}
">>" {return RSHIFT;}
"<<" {return LSHIFT;}
"!" {return NOT;}
"{" {return *yytext;}
"}" {return *yytext;}
"||" {return OR;}
"&&" {return AND;}
("//"|"/*"|"*/"|"."|","|"("|")"|"'") {return *yytext;}
. {
fprintf(stderr,"Unknown token found: %s\n", yytext);
}
%%
