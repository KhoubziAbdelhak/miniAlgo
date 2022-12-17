

#define SIZE 71
#define MAXTOKENLEN 12

#define UNDEF 0
#define INT_TYPE 1
#define FLOAT_TYPE 2
#define BOOL_TYPE 3



/* a linked list of references (lineno's) for each variable */
typedef struct RefList{ 
    int lineno;
    struct RefList *next;
}RefList;


// struct that represent a list node
typedef struct list_t {
	char st_name[MAXTOKENLEN];
	int st_size;
	int scope;
	RefList *lines;

	int inf_type;

	int st_ival;
	float st_fval;
	bool st_bval;
	
	int st_type;
	struct list_t *next;
} list_t;

 /* static structures */

static list_t **hash_table;

// Symbol Table Functions
void init_hash_table(); // initialize hash table
unsigned int hash(char *key); // hash function 
void insert(char *name, int len, int type, int lineno); // insert entry
list_t *lookup(char *name); // search for entry


