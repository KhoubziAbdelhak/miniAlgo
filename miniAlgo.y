
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <ctype.h>
	int yylex();
	void yyerror(char *s);
%}

%start S
%token mc_miniAlgo mc_langage mc_var mc_begin mc_end 
%token var_name double_point semicolon comma equal 
%token CONST type_int type_float type_bool number

%%

S:	mc_langage mc_miniAlgo mc_var List_Declarations mc_begin mc_end	{printf("bola kachir\n"); YYACCEPT;}	
	;

List_Declarations: Declaration						{;}
				 | List_Declarations Declaration	{;}
				 ;

Declaration: Idf double_point Type semicolon				{;}
		   | const_Idf double_point CONST Type semicolon 	{;}
		   ;

Idf: Idf comma Idf 				{;}
   | var_name					{;}
   ;

const_Idf: const_Idf comma const_Idf 	{;}
		 | var_name equal number 		{;}

Type: type_int 		 		{;} 
	| type_float			{;}
	| type_bool				{;}
	;

%%

int main(void) {
	return yyparse();
}

void yyerror(char *s) {fprintf(stderr, "%s\n", s);}

