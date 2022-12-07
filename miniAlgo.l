
%{
	#include "miniAlgo.tab.h"
	int yylex();
	void yyerror(char *s);
	int line_number = 0;
%}


%%


LANGAGE			return mc_langage;
VAR				return mc_var;
BEGIN			return mc_begin;
END				return mc_end;
miniAlgo		return mc_miniAlgo;

[ \t]			;
[\n]			line_number++;
[a-zA-Z]+		return var_name;
INT				return type_int;
FLOAT			return type_float;
BOOL			return type_bool;
CONST			return CONST;
[1-9][0-9]*		return number;
:				return double_point;
;				return semicolon;
,				return comma;
=				return equal;



.				{ printf("9awed ya in line %d\n", line_number);}

%%


int yywrap(void) {return 1;}


