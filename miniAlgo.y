
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <ctype.h>
	int yylex();
	void yyerror(char *s);
%}

%start S
%token mc_miniAlgo mc_langage mc_var mc_begin mc_end 
%token var_name double_point semicolon comma 
%token CONST type_int type_float type_bool func number
%token While If equal_con lessEqual_con greatEqual_con diff_con

%%

S:	mc_langage mc_miniAlgo mc_var List_Declarations mc_begin List_Instructions mc_end	{printf("\nbola kachir\n\n"); YYACCEPT;}	
	;

List_Declarations: Declaration						{;}
				 | List_Declarations Declaration	{;}
				 ;

Declaration: Idf double_point Type semicolon				{;}
		   | const_Idf double_point CONST Type semicolon 	{;}
		   | function 										{;}
		   | 
		   ;

function: Type func var_name mc_var List_Declarations mc_begin List_Instructions mc_end 	{printf("\nthere is a function\n");}

Idf: Idf comma Idf 				{;}
   | var_name					{;}
   ;

const_Idf: const_Idf comma const_Idf 	{;}
		 | var_name '=' number 		{;}

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
  | var_name 		{;}
  | number 			{;}
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


Value: var_name  	{;}
	 | number 		{;}
	 ;

%%

int main(void) {
	return yyparse();
}

void yyerror(char *s) {fprintf(stderr, "%s\n", s);}

