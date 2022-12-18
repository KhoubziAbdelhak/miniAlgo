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

#ifndef YY_YY_MINIALGO_TAB_H_INCLUDED
# define YY_YY_MINIALGO_TAB_H_INCLUDED
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
    mc_miniAlgo = 258,             /* mc_miniAlgo  */
    mc_langage = 259,              /* mc_langage  */
    mc_var = 260,                  /* mc_var  */
    mc_begin = 261,                /* mc_begin  */
    mc_end = 262,                  /* mc_end  */
    var_name = 263,                /* var_name  */
    double_point = 264,            /* double_point  */
    semicolon = 265,               /* semicolon  */
    comma = 266,                   /* comma  */
    CONST = 267,                   /* CONST  */
    type_int = 268,                /* type_int  */
    type_float = 269,              /* type_float  */
    type_bool = 270,               /* type_bool  */
    func = 271,                    /* func  */
    mc_return = 272,               /* mc_return  */
    While = 273,                   /* While  */
    If = 274,                      /* If  */
    equal_con = 275,               /* equal_con  */
    lessEqual_con = 276,           /* lessEqual_con  */
    greatEqual_con = 277,          /* greatEqual_con  */
    diff_con = 278,                /* diff_con  */
    ICONST = 279,                  /* ICONST  */
    FCONST = 280,                  /* FCONST  */
    BCONST = 281                   /* BCONST  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 22 "miniAlgo.y"

	int int_val;
	float float_val;
	bool bool_val;
	struct list_t* symtab_item;

#line 97 "miniAlgo.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_MINIALGO_TAB_H_INCLUDED  */
