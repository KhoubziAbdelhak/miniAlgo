
%{
#include <stdbool.h>
#include "miniAlgo.tab.h"
#include "symtic.h"
	int yylex();
	void yyerror(char *s);
	int lineno = 1;
%}



%x ML_COMMENT

digit 		[0-9]
Idf  [a-zA-Z]([a-zA-Z0-9]|_([a-zA-Z0-9]))*	

BCONST      "true"|"false"
ICONST		"0"|[0-9]{digit}*
FCONST		"0"|{digit}*"."{digit}+



%%

"//".*                  { printf("Eat up comment at line %d\n", lineno); } 

"/*"                    { printf("Eat up comment from line %d ", lineno); BEGIN(ML_COMMENT); }
<ML_COMMENT>"*/"        { printf("to line %d\n", lineno); BEGIN(INITIAL); }
<ML_COMMENT>[^*\n]+		
<ML_COMMENT>"*"			
<ML_COMMENT>"\n"        { lineno += 1; }


LANGAGE			return mc_langage;
VAR				return mc_var;
BEGIN			return mc_begin;
END				return mc_end;
miniAlgo		return mc_miniAlgo;

INT				return type_int;
FLOAT			return type_float;
BOOL			return type_bool;
CONST			return CONST;
Function 		return func;
Return 			return mc_return;

While 			return While;	
If 				return If;
"==" 			return equal_con;
"<=" 			return lessEqual_con;
">=" 			return greatEqual_con;
"<>" 			return diff_con;


{Idf} 				{
	if(yyleng > 12) {
		printf("lexical error Idf leng > 12");
	}
	else {
		insert(yytext, strlen(yytext), UNDEF, lineno);
		yylval.symtab_item = lookup(yytext);
		return var_name;
	}
}


{ICONST} 			{
	yylval.int_val = atoi(yytext);
	return ICONST;
}


{FCONST} 			{
	yylval.float_val = atoi(yytext);
	return FCONST;
}


{BCONST} 			{
	if(strcmp(yytext, "true") == 0) yylval.bool_val = true;
	if(strcmp(yytext, "false") == 0) yylval.bool_val = false;
	return BCONST;
}

:										return double_point;
;										return semicolon;
,										return comma;
[-+*/()=<>]								{return yytext[0];}

[ \t]			;
[\n]			lineno++;

.				{ printf("\n9awed ya Chkoupi in line %d\n\n", lineno); exit(EXIT_FAILURE);}

%%


int yywrap(void) {return 1;}


