
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <stdbool.h>
	#include <ctype.h>
	#include "symtic.c"
	extern FILE *yyout;
	int yylex();
	extern int lineno;
	void yyerror(char *s);


%}

%union {
	int int_val;
	float float_val;
	bool bool_val;
	struct list_t* symtab_item;
}

%start S
%token mc_miniAlgo mc_langage mc_var mc_begin mc_end 
%token <symtab_item> var_name double_point semicolon comma 
%token CONST type_int type_float type_bool func mc_return 
%token While If equal_con lessEqual_con greatEqual_con diff_con

%token <int_val> ICONST
%token <float_val> FCONST
%token <bool_val> BCONST


%%

S:	mc_langage mc_miniAlgo mc_var {declare=1;} List_Declarations {declare=0;} mc_begin List_Instructions mc_end		{printf("\nbola kachir\n\n"); YYACCEPT;}	
	;

List_Declarations: Declaration						{;}
				 | List_Declarations Declaration	{;}
				 ;

Declaration: Idf double_point Type semicolon						{;}
		   | const_Idf double_point CONST Type semicolon 			{;}
		   | function 																		{;}
		   | 
		   ;

function: Type func {incr_scope();} var_name mc_var List_Declarations mc_begin List_Instructions Return {hide_scope();} mc_end 		{printf("\nthere is a function\n");}
		;

Return: mc_return var_name semicolon 	{;}

Idf: Idf comma var_name 		{;}
   | var_name					{;}
   ;

const_Idf: const_Idf var_name '=' Value		{;}
		 | var_name '=' Value 				{;}

Value: FCONST 	{;}
	 | ICONST 	{;}
	 | BCONST 	{;}
	 | var_name {;}
	 ;

Type: type_int 		 		{;} 
	| type_float			{;}
	| type_bool				{;}
	;

List_Instructions: Instruction 						{;}
				 | List_Instructions Instruction 	{;}
				 |  
				 ;

Instruction: Affectation 		{;}
		   | Boucle 			{printf("\nthere is a Boucle\n");}
		   | If_statment 		{printf("\nthere is a If_statment\n");}
		   ;

Affectation: var_name '=' exp semicolon 	{;}


exp: exp '+' e1 	{;}
   | exp '-' e1 	{;}
   | e1 			{;}
   ;

e1: e1 '*' e2 		{;}
  | e1 '/' e2 		{;}
  | e2 				{;}
  ;

e2: '(' exp ')' 	{;}
  | Value 			{;}
  ;



Boucle: While Condition_Statment mc_begin List_Instructions mc_end 	{;}
	  ;

If_statment: If Condition_Statment mc_begin List_Instructions mc_end  {;}

Condition_Statment: '(' Condition ')' 	{;}
				  ;

Condition: Value equal_con Value 		{;}
		 | Value '<' Value 	 			{;}
		 | Value '>' Value  	 		{;}
		 | Value lessEqual_con Value 	{;}
		 | Value greatEqual_con Value 	{;}
		 | Value diff_con Value 		{;}
		 ;



%%

int main(void) {

	init_hash_table();		

	int flag;
	flag = yyparse();
	
	// symbol table dump
	yyout = fopen("symtab_dump.out", "w");
	symtab_dump(yyout);
	fclose(yyout);

	return flag;
}

void yyerror(char *s) {fprintf(stderr, "%s\n", s);}

