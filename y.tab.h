/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
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
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENTIFIER = 258,              /* IDENTIFIER  */
    STRING = 259,                  /* STRING  */
    NUMBER = 260,                  /* NUMBER  */
    FINDALL = 261,                 /* FINDALL  */
    FINDBY = 262,                  /* FINDBY  */
    FINDALLBY = 263,               /* FINDALLBY  */
    FINDFIRSTBY = 264,             /* FINDFIRSTBY  */
    FINDLASTBY = 265,              /* FINDLASTBY  */
    FINDDISTINCTBY = 266,          /* FINDDISTINCTBY  */
    FINDTOPBY = 267,               /* FINDTOPBY  */
    AND = 268,                     /* AND  */
    OR = 269,                      /* OR  */
    LPAREN = 270,                  /* LPAREN  */
    RPAREN = 271,                  /* RPAREN  */
    COMMA = 272,                   /* COMMA  */
    EQUALS = 273,                  /* EQUALS  */
    NOTEQUAL = 274,                /* NOTEQUAL  */
    GREATER = 275,                 /* GREATER  */
    LESS = 276,                    /* LESS  */
    GREATEREQ = 277,               /* GREATEREQ  */
    LESSEQ = 278,                  /* LESSEQ  */
    BETWEEN = 279,                 /* BETWEEN  */
    LIKE = 280,                    /* LIKE  */
    NOTLIKE = 281,                 /* NOTLIKE  */
    ISNULL = 282,                  /* ISNULL  */
    ISNOTNULL = 283,               /* ISNOTNULL  */
    TRUEVAL = 284,                 /* TRUEVAL  */
    FALSEVAL = 285,                /* FALSEVAL  */
    STARTINGWITH = 286,            /* STARTINGWITH  */
    ENDINGWITH = 287,              /* ENDINGWITH  */
    CONTAINING = 288,              /* CONTAINING  */
    NOT = 289,                     /* NOT  */
    IGNORECASE = 290               /* IGNORECASE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define IDENTIFIER 258
#define STRING 259
#define NUMBER 260
#define FINDALL 261
#define FINDBY 262
#define FINDALLBY 263
#define FINDFIRSTBY 264
#define FINDLASTBY 265
#define FINDDISTINCTBY 266
#define FINDTOPBY 267
#define AND 268
#define OR 269
#define LPAREN 270
#define RPAREN 271
#define COMMA 272
#define EQUALS 273
#define NOTEQUAL 274
#define GREATER 275
#define LESS 276
#define GREATEREQ 277
#define LESSEQ 278
#define BETWEEN 279
#define LIKE 280
#define NOTLIKE 281
#define ISNULL 282
#define ISNOTNULL 283
#define TRUEVAL 284
#define FALSEVAL 285
#define STARTINGWITH 286
#define ENDINGWITH 287
#define CONTAINING 288
#define NOT 289
#define IGNORECASE 290

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 10 "parser.y"

    char* str;
    int num;

#line 142 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
