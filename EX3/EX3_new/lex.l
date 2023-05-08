%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
    int yylex(void);
    void yyerror(char* s);
    extern int yylval;
    int line=0;
    int num_of_lines(char *str){
        int count = 0,i=0;
        while(str[i]!='\0'){
            if(str[i]=='\n'){
                count++;
            }
            i++;
        }
        return count;
    }
%}

digit [0-9]
letter [A-Za-z]
number [0-9]+
float_number "0"|[0-9]+"."[0-9]+
id [a-zA-Z_][a-zA-Z0-9_]*
space [ \t]
special "."|","|"("|")"|"["|"]"|"{"|"}"|";"
data_type "int"|"float"|"double"|"char"|"void"
keyword "if"|"else"|"for"|"while"|"return"|"switch"|"case"|"break"|"continue"|{data_type}
arithmetic "+"|"-"|"*"|"/"|"%"
relational ">"|"<"|">="|"<="|"!="|"=="
unary "++"|"--"
arith_assign "+="|"-="|"*="|"/="|"%="
logical "&&"|"||"|"!"
bitwise "&"|"|"|"^"|"<<"|">>"
single_comment "//".*
newline \n
multi_comment "/*"[^*/]*"*/"
char_const \'.\'
string_const \"[^"\n]*\"
%%
^"#include".*">" {printf("%s \t\t-PPD\n",yytext);return PPD;}

"return" {printf("%s \t\t-Return keyword\n",yytext);return RETURN;}
"if" {printf("%s \t\t-If keyword\n",yytext);return IF;}
"else" {printf("%s \t\t-else keyword\n",yytext);return ELSE;}
"for" {printf("%s \t\t-for keyword\n",yytext);return FOR;}
"printf" {printf("%s \t\t-printf function\n",yytext);return PRINT;}
"while" {printf("%s \t\t-while loop\n",yytext);return WHILE;}
{newline} {line++;}
{space}+ {}
[=] {printf("%s\t\t-Assign OP\n",yytext); return ASSIGN_OP;}
{single_comment} {printf("%s\t\t-Single line comment\n",yytext);}
{multi_comment} {printf("%s\t\t-Multi line comment\n",yytext); line+=num_of_lines(yytext);}
{data_type} {printf("%s\t\t-Data type\n",yytext);return DATA_TYPE;}
{keyword} {printf("%s\t\t-Keyword\n",yytext);return *yytext;}
{id} {printf("%s - Identifier\n",yytext); return ID; }
{float_number}|{number} {printf("%s - Floating point Constant\n",yytext); return NUMBER; }
{arithmetic}[=] {printf("%s - Arithmetic Assignment Operator\n",yytext); return ARITH_ASSIGN_OP;}
{logical} {printf("%s - Logical Operator\n",yytext); return LOGICAL_OP; }
{bitwise} {printf("%s - Bitwise Operator\n",yytext); return BITWISE_OP; }
{unary} {printf("%s - Unary Operator\n",yytext); return UNARY_OP; }
{relational} {printf("%s - Relational Operator\n",yytext); return RELATIONAL_OP; }
{arithmetic} {printf("%s - Arithmetic Operator\n",yytext); return ARITHMETIC_OP; }
{char_const} {printf("%s - Character Constant\n",yytext); return CHAR; }
{string_const} {printf("%s - String Constant\n",yytext); return STRING; }
{special} {printf("%s - Special Character\n",yytext); return *yytext; }
. {
  char msg[25];
  sprintf(msg,"Unknown token found: <%s>\n", yytext);
  yyerror(msg);
}
%%