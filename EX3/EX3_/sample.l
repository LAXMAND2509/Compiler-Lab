%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
    void yyerror(char*);
    extern int yylval;
%}
%%
[ \t]+ {}

[0-9]+ {
  yylval = atoi(yytext); 
  return NUM;
}

[+\-^*/] {return ARITH;}

"<" { return COMP; }
"<=" { return COMP; }
">" { return COMP; }
">=" { return COMP; }
"!="  { return COMP; }
"==" { return COMP; }
"("  { return *yytext; }
")" { return *yytext; }
"{" { return *yytext; }
"}" { return *yytext; }
"while" {return WHILE; }
"if" { return IF; }
"else" { return ELSE; }
"int" { return INT; }
";" { return *yytext; }
"=" { return *yytext; }
"," { return *yytext; }

[a-zA-Z][a-zA-Z0-9_]* {
  return ID;
}

\n {}

. {
    char err[25] = {0};
    sprintf(err, "Invalid Character \"%s\"\n", yytext);
    yyerror(err);
}
%%
