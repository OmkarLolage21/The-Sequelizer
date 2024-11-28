%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
extern int yylex();
%}

%union {
    char* str;
    int num;
}

    %token<str> IDENTIFIER 
    %token<str> STRING 
    %token<num> NUMBER % token FINDALL FINDBY FINDALLBY FINDFIRSTBY FINDLASTBY FINDDISTINCTBY FINDTOPBY AND OR 
    %token LPAREN RPAREN COMMA EQUALS NOTEQUAL GREATER LESS GREATEREQ LESSEQ 
    %token BETWEEN LIKE NOTLIKE ISNULL ISNOTNULL TRUEVAL FALSEVAL STARTINGWITH 
    %token ENDINGWITH CONTAINING NOT IGNORECASE AFTER BEFORE IN NOTIN ORDERBY FINDBYLASTNAMEANDFIRSTNAME FINDBYLASTNAMEORFIRSTNAME 
    %token FINDDISTINCTBYLASTNAMEANDFIRSTNAME FINDBYSTARTDATEBETWEEN FINDBYSTARTDATEAFTER FINDBYSTARTDATEBEFORE FINDBYFIRSTNAMELIKE 
    %token FINDBYFIRSTNAMENOTLIKE FINDBYFIRSTNAMESTARTINGWITH FINDBYFIRSTNAMEENDINGWITH FINDBYFIRSTNAMECONTAINING FINDBYAGEORDERBYLASTNAMEDESC 
    %token FINDBYLASTNAMENOT FINDBYAGENOTIN FINDBYACTIVETRUE FINDBYACTIVEFALSE FINDBYFIRSTNAMEIGNORECASE FINDBYAGEISNULL FINDBYAGEISNOTNULL

%type<str> query condition comparison

%left AND
%left OR

%%

query:
  | FINDBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s;\n", $4); }
  | FINDALLBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s;\n", $4); }
  | FINDFIRSTBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s ORDER BY %s ASC LIMIT 1;\n", $4, $2); }
  | FINDLASTBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s ORDER BY %s DESC LIMIT 1;\n", $4, $2); }
  | FINDTOPBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s ORDER BY %s DESC LIMIT 1;\n", $4, $2); }
  | FINDDISTINCTBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT DISTINCT * FROM table WHERE %s;\n", $4); }
  | FINDBYLASTNAMEANDFIRSTNAME IDENTIFIER LPAREN condition RPAREN IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s AND %s;\n", $4, $8); }
  | FINDBYLASTNAMEORFIRSTNAME IDENTIFIER LPAREN condition RPAREN IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s OR %s;\n", $4, $8); }
  | FINDDISTINCTBYLASTNAMEANDFIRSTNAME IDENTIFIER LPAREN condition RPAREN IDENTIFIER LPAREN condition RPAREN { printf("SELECT DISTINCT * FROM table WHERE %s AND %s;\n", $4, $8); }
  | FINDBYSTARTDATEBETWEEN IDENTIFIER LPAREN condition RPAREN IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE table.startDate between %s AND %s;\n", $4, $8); }
  | FINDBYSTARTDATEAFTER STRING { printf("SELECT * FROM table WHERE table.startDate > %s;\n", $2); }
  | FINDBYSTARTDATEBEFORE STRING { printf("SELECT * FROM table WHERE table.startDate < %s;\n", $2); }
  | FINDBYFIRSTNAMELIKE STRING { printf("SELECT * FROM table WHERE table.firstName LIKE %s;\n", $2); }
  | FINDBYFIRSTNAMENOTLIKE STRING { printf("SELECT * FROM table WHERE table.firstName NOT LIKE %s;\n", $2); }
  | FINDBYFIRSTNAMESTARTINGWITH STRING { printf("SELECT * FROM table WHERE table.firstName LIKE %s;\n", $2); }
  | FINDBYFIRSTNAMEENDINGWITH STRING { printf("SELECT * FROM table WHERE table.firstName LIKE %s;\n", $2); }
  | FINDBYFIRSTNAMECONTAINING STRING { printf("SELECT * FROM table WHERE table.firstName LIKE %s;\n", $2); }
  | FINDBYAGEORDERBYLASTNAMEDESC NUMBER { printf("SELECT * FROM table WHERE table.age = %d ORDER BY table.lastName DESC;\n", $2); }
  | FINDBYLASTNAMENOT STRING { printf("SELECT * FROM table WHERE table.lastname != %s;\n", $2); }
  | FINDBYAGEIN STRING { printf("SELECT * FROM table WHERE table.age IN (%s);\n", $2); }
  | FINDBYAGENOTIN STRING { printf("SELECT * FROM table WHERE table.age NOT IN (%s);\n", $2); }
  | FINDBYACTIVETRUE { printf("SELECT * FROM table WHERE table.active = true;\n"); }
  | FINDBYACTIVEFALSE { printf("SELECT * FROM table WHERE table.active = false;\n"); }
  | FINDBYFIRSTNAMEIGNORECASE STRING { printf("SELECT * FROM table WHERE UPPER(table.firstName) = UPPER(%s);\n"); }
  | FINDBYAGEISNULL { printf("SELECT * FROM table WHERE table.age IS NULL;\n"); }
  | FINDBYAGEISNOTNULL { printf("SELECT * FROM table WHERE table.age IS NOT NULL;\n"); } 
  ;

condition:
    IDENTIFIER comparison NUMBER { 
        char buf[256];
        snprintf(buf, sizeof(buf), "%s %s %d", $1, $2, $3);
        $$ = strdup(buf);
    }
    | IDENTIFIER comparison STRING { 
        $3[strlen($3) - 1] = '\0';  
        char* value = $3 + 1;
        char buf[256];
        snprintf(buf, sizeof(buf), "%s %s '%s'", $1, $2, value);
        $$ = strdup(buf);
    }
    | IDENTIFIER BETWEEN STRING AND STRING {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s BETWEEN '%s' AND '%s'", $1, $3, $5);
        $$ = strdup(buf);
    }
    | IDENTIFIER LIKE STRING {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s LIKE '%s'", $1, $3);
        $$ = strdup(buf);
    }
    | IDENTIFIER NOTLIKE STRING {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s NOT LIKE '%s'", $1, $3);
        $$ = strdup(buf);
    }
    | IDENTIFIER ISNULL {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s IS NULL", $1);
        $$ = strdup(buf);
    }
    | IDENTIFIER ISNOTNULL {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s IS NOT NULL", $1);
        $$ = strdup(buf);
    }
    | IDENTIFIER STARTINGWITH STRING {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s LIKE '%s%%'", $1, $3);
        $$ = strdup(buf);
    }
    | IDENTIFIER ENDINGWITH STRING {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s LIKE '%%%s'", $1, $3);
        $$ = strdup(buf);
    }
    | IDENTIFIER CONTAINING STRING {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s LIKE '%%%s%%'", $1, $3);
        $$ = strdup(buf);
    }
    | IDENTIFIER EQUALS TRUEVAL {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s = TRUE", $1);
        $$ = strdup(buf);
    }
    | IDENTIFIER EQUALS FALSEVAL {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s = FALSE", $1);
        $$ = strdup(buf);
    }
    | condition AND condition {
        char buf[512];
        snprintf(buf, sizeof(buf), "%s AND %s", $1, $3);
        $$ = strdup(buf);
    }
    | condition OR condition {
        char buf[512];
        snprintf(buf, sizeof(buf), "%s OR %s", $1, $3);
        $$ = strdup(buf);
    }
    | IDENTIFIER IN LPAREN condition RPAREN {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s IN (%s)", $1, $4);
        $$ = strdup(buf);
    }
    | IDENTIFIER NOTIN LPAREN condition RPAREN {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s NOT IN (%s)", $1, $4);
        $$ = strdup(buf);
    }
    | IDENTIFIER AFTER STRING {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s > '%s'", $1, $3);
        $$ = strdup(buf);
    }
    | IDENTIFIER BEFORE STRING {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s < '%s'", $1, $3);
        $$ = strdup(buf);
    }
    | IDENTIFIER IGNORECASE EQUALS STRING {
        char buf[256];
        snprintf(buf, sizeof(buf), "UPPER(%s) = UPPER('%s')", $1, $4);
        $$ = strdup(buf);
    }
;

comparison:
    EQUALS { $$ = strdup("="); }
    | NOTEQUAL { $$ = strdup("!="); }
    | GREATER { $$ = strdup(">"); }
    | LESS { $$ = strdup("<"); }
    | GREATEREQ { $$ = strdup(">="); }
    | LESSEQ { $$ = strdup("<="); }
    ;

%%
void yyerror(const char *s)
{
    fprintf(stderr, "Error: %s\n", s);
}

int main(void)
{
    yyparse();
    return 0;
}