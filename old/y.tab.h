/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PPD = 258,
    NUM = 259,
    VOID = 260,
    ID = 261,
    EOS = 262,
    DTYPE = 263,
    LSHIFT = 264,
    RSHIFT = 265,
    NOT = 266,
    AND = 267,
    OR = 268,
    ARITH_OP = 269,
    INDE_OP = 270,
    ASSIGN_OP = 271,
    COMPARISON_OP = 272,
    IF = 273,
    ELSE = 274,
    WHILE = 275,
    FOR = 276,
    RETURN = 277,
    COMMENT = 278,
    PRINTF = 279
  };
#endif
/* Tokens.  */
#define PPD 258
#define NUM 259
#define VOID 260
#define ID 261
#define EOS 262
#define DTYPE 263
#define LSHIFT 264
#define RSHIFT 265
#define NOT 266
#define AND 267
#define OR 268
#define ARITH_OP 269
#define INDE_OP 270
#define ASSIGN_OP 271
#define COMPARISON_OP 272
#define IF 273
#define ELSE 274
#define WHILE 275
#define FOR 276
#define RETURN 277
#define COMMENT 278
#define PRINTF 279

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
