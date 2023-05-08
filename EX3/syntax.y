%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<fcntl.h>
    #include<unistd.h>
    int yylex(void);
    extern FILE* yyin;
    #include "y.tab.h"
    int error = 0;
    ertern int line;
%}

%token 