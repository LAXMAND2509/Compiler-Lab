%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
    int yylex(void);
    int yyerror(char* s);
    int debug=0;
    int line=0;
%}
%%
[ \t]+ ;
\n {line++;}
[0-9]+ {yylval.str = strdup(yytext); return NUM;}
("int"|"float"|"char"|"double") {return DTYPE; }
"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
[_a-zA-Z][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }
";" {return EOS;}
(">"|"<"|"<="|">="|"!="|"==") { return COMPARISON_OP; }
("+="|"-="|"*="|"/="|"%="|"=") { yylval.str = strdup(yytext); return ASSIGN_OP; }
("++"|"--") { return INDE_OP; }
("+"|"-") { yylval.str = strdup(yytext); return ARITH_OP; }
("*"|"/"|"%") { yylval.str = strdup(yytext); return ARITH_OP_2; }
">>" { return RSHIFT; }
"<<" {return LSHIFT; }
"!" { yylval.str = strdup(yytext); return NOT; }
"||" {yylval.str = strdup(yytext); return OR; }
"&&" {yylval.str = strdup(yytext); return AND; }
"{" { return *yytext; }
"}" { return *yytext; }
"\\" {return *yytext;}/*spl chars*/
"." {return *yytext;}
"," {return *yytext;}
"(" {return *yytext;}
")" {return *yytext;}
. {
    char msg[25];
    sprintf(msg,"Unknown token found: <%s>\n", yytext);
    yyerror(msg);
}
%%