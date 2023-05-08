%{  
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include "y.tab.h"
    int debug=0;
    int line=0;
%}

ppd ^#.*(\n)
slc \/\/.*(\n)
mlc \/\*[^\/\*]*\*\/
spl_obj  "cin"|"cout"|"std"
space "\n"|"\t"|" "
keyword "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"namespace"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"using"|"vector"|"void"|"while"
id [_a-zA-Z]([a-zA-Z0-9])*
function {id}\((.)*\)
floatConst (\+|\-)?[1-9]([0-9])*\.([0-9]*)
intConst (\+|\-)?[0-9]([0-9])*
charConst \'.\'
strConst \".*\"
bitWise "^"|"&"|"|"|"<<"|">>"
arr {id}("["(.)*"]")
assign "="
incr "++"
decr "--"
arithAssign "+="|"-="|"*="|"/="|"%="
relat ">="|"<="|"<"|">"|"=="
arith "+"|"-"|"*"|"<"|">"|"%"
logic &&|\|\||!
splChars ";"|","|"."|"["|"]"|"("|")"|"{"|"}"|"["|"]"
bracket ("[".*)|("]".*)
%%
{ppd}   {printf("%s\t\t- PreProcessor Directive\n",yytext);}
{slc}   {printf("%s\t\t- Single Line Comment\n",yytext);}
{mlc}   {printf("%s\t\t- Multi Line Comment\n",yytext);}
{spl_obj}   {printf("%s\t\t- Special Object\n",yytext);}
{bracket}   {
                yyless(1);
                printf("%s \t\t-special character\n",yytext);
            }
{function} {
    int pos = 1;
    for(int i=0;i<strlen(yytext);i++){
        if(yytext[i] == '('){
            pos = i;
            break;
        }
    }
    yyless(pos);
    printf("%s \t\t- name-function\n",yytext);
}
{arr}   {printf("%s \t\t- Array notation\n",yytext); return ARR;}
{id}            {printf("%s \t\t- identifier\n", yytext); return ID;}
{floatConst}    {printf("%s \t\t- decimal constant\n", yytext); return FLOATCONST;}
{intConst}      {printf("%s \t\t- integer constant\n", yytext); return INTCONST;}
{charConst}     {printf("%s \t\t- Character Constant\n", yytext); return CHARCONST;}
{strConst}   {printf("%s \t\t- String Constant\n", yytext); return STRCONST;}
{bitWise}     {printf("%s \t\t- bitwise Operator\n", yytext); return BITWISE;}
{assign}      {printf("%s \t\t- Assignment Operator\n", yytext); return ASSIGN;}
{arithAssign} {printf("%s \t\t- Arithmetic Assignment Operator\n", yytext); return ARRITHASSIGN;}
{incr}  {printf("%s \t\t- increment Operator\n", yytext); return INCR;}
{decr}  {printf("%s \t\t- decrement Operator\n", yytext);  return DECR;}
{arith}       {printf("%s \t\t- Arithmetic Operator\n", yytext); return ARITH;}
{logic}       {printf("%s \t\t- Logical Operator\n", yytext); return LOGIC;}
{relat}         {printf("%s \t\t- Relational Operator\n", yytext);return RELAT;}
{splChars}    {printf("%s \t\t- special Character\n", yytext); return SPLCHAR;}
{space} {printf("%s \t\t- White Space\n", yytext);return SPACE;}
. {printf("%s \t\t-unknown token\n",yytext);}
%%

int main(int argc, char **argv){
    if(argc != 2){
        printf("PUT 2 ARGS\n");
        return 1;
    }
    yyin = fopen(argv[1],"rt");
    if(yyin == NULL){
        printf("file not found\n");
        return 1;
    }
    yylex();
}