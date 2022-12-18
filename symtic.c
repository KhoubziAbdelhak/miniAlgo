
#include <stdio.h>
#include <stdlib.h>
#include <string.h> 
#include "symtic.h"


/* flag variable for declaring */
int declare = 0; // 1: declaring variable, 0: not

/* current scope */
int cur_scope = 0;


void init_hash_table() {
	hash_table = malloc(SIZE * sizeof(list_t*));
	for(int i=0; i<SIZE; i++) hash_table[i] = NULL;
}

unsigned int hash(char *key) {
	unsigned int hashval = 0;
	for(; *key!='\0'; key++) hashval += *key;
	return hashval % SIZE;
}


void insert(char *name, int len, int type, int lineno) {
	unsigned int hashval = hash(name);
	list_t *l = hash_table[hashval];
	while((l != NULL) && (strcmp(name, l->st_name) != 0)) l = l->next;


	/* variable not yet in table */
	if (l == NULL){
		/* check if we are really declaring */
		if(declare == 1){
			/* set up entry */
			l = (list_t*) malloc(sizeof(list_t));
			strncpy(l->st_name, name, len);
			l->st_type = type;
			l->scope = cur_scope;
			l->lines = (RefList*) malloc(sizeof(RefList));
			l->lines->lineno = lineno;
			l->lines->next = NULL;
			
			/* add to hashtable */
			l->next = hash_table[hashval];
			hash_table[hashval] = l; 
			printf("Inserted %s for the first time with linenumber %d!\n", name, lineno);
		}
		else{
			fprintf(stderr, "Variable %s not declared at line %d!\n", name, lineno);
		}
	}
	/* found in table */
	else{
		
		// just add line number
		if(declare == 0){
			/* find last reference */
			RefList *t = l->lines;
			while (t->next != NULL) t = t->next;
			
			/* add linenumber to reference list */
			t->next = (RefList*) malloc(sizeof(RefList));
			t->next->lineno = lineno;
			t->next->next = NULL;
			printf("Found %s again at line %d!\n", name, lineno);
		}
		/* double declaration */
		else{
			if(l->scope == cur_scope) {
				fprintf(stderr, "A multiple declaration of variable %s at line %d\n", name, lineno);
				/*exit(1);*/
			}
			else {
				/* set up entry */
				l = (list_t*) malloc(sizeof(list_t));
				strncpy(l->st_name, name, len);  
				l->st_type = type;
				l->scope = cur_scope;
				l->lines = (RefList*) malloc(sizeof(RefList));
				l->lines->lineno = lineno;
				l->lines->next = NULL;
				
				/* add to hashtable */
				l->next = hash_table[hashval];
				hash_table[hashval] = l; 
				printf("Inserted %s for a new scope with linenumber %d!\n", name, lineno);
			}			
		}		
	}



}


list_t *lookup(char *name) {
	unsigned int hashval = hash(name);
	list_t *l = hash_table[hashval];
	while((l != NULL) && (strcmp(name, l->st_name) != 0)) l = l->next;
	return l;
}



void hide_scope(){ /* hide the current scope */
	printf("enter the hide_scope func\n");
	list_t *l;
	printf("Hiding scope \'%d\':\n", cur_scope);
	/* for all the lists */
	for (int i=0; i < SIZE; i++){
		if(hash_table[i] != NULL){
			l = hash_table[i];
			/* Find the first item that is from another scope */
			while(l != NULL && l->scope == cur_scope){
				printf("Hiding %s..\n", l->st_name);
				l = l->next;
			}
			/* Set the list equal to that item */
			hash_table[i] = l;
		}
	}
	cur_scope--;
}

void incr_scope(){ /* go to next scope */
	printf("enter the incr_scope func\n");
	cur_scope++;
}




void symtab_dump(FILE * of){  /* dump file */
  int i;
  fprintf(of,"------------ ------ ------------------- ----------- ------------\n");
  fprintf(of,"Name         Type 		Value 	   Scope  Line Numbers\n");
  fprintf(of,"------------ ------ ------------------- ----------- ------------\n");
  for (i=0; i < SIZE; ++i){ 
	if (hash_table[i] != NULL){ 
		list_t *l = hash_table[i];
		while (l != NULL){ 
			RefList *t = l->lines;
			fprintf(of,"%-12s ",l->st_name);
			if (l->st_type == INT_TYPE)           {    fprintf(of,"%-7s","int");   fprintf(of, "%4d 		", l->st_ival);}
			if (l->st_type == FLOAT_TYPE)          {      fprintf(of,"%-7s","float"); fprintf(of, "%4f 		", l->st_fval); }
			if (l->st_type == BOOL_TYPE)            {    fprintf(of,"%-7s","bool"); fprintf(of, "%4d 		", l->st_bval); }
			if(l->st_type == UNDEF) fprintf(of,"%-7s","undef"); // if UNDEF or 0
			fprintf(of,"   %d ",l->scope);
			while (t != NULL){
				fprintf(of," 	%4d ",t->lineno);
				t = t->next;
			}
			fprintf(of,"\n");
			l = l->next;
		}
    }
  }
}



