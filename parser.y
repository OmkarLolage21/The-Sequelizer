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

%token <str> IDENTIFIER
%token <str> STRING
%token <num> NUMBER
%token FINDALL FINDBY FINDALLBY FINDFIRSTBY FINDLASTBY FINDDISTINCTBY FINDTOPBY AND OR
%token LPAREN RPAREN COMMA EQUALS NOTEQUAL GREATER LESS GREATEREQ LESSEQ
%token BETWEEN LIKE NOTLIKE ISNULL ISNOTNULL TRUEVAL FALSEVAL STARTINGWITH
%token ENDINGWITH CONTAINING NOT IGNORECASE

%type <str> query condition comparison

%left AND
%left OR

%%

query:
    FINDALL LPAREN RPAREN { printf("SELECT * FROM table;\n"); }
    | FINDBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s;\n", $4); }
    | FINDALLBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s;\n", $4); }
    | FINDFIRSTBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s ORDER BY %s ASC LIMIT 1;\n", $4, $2); }
    | FINDLASTBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s ORDER BY %s DESC LIMIT 1;\n", $4, $2); }
    | FINDTOPBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT * FROM table WHERE %s ORDER BY %s DESC LIMIT 1;\n", $4, $2); }
    | FINDDISTINCTBY IDENTIFIER LPAREN condition RPAREN { printf("SELECT DISTINCT * FROM table WHERE %s;\n", $4); }
;

condition:
    IDENTIFIER comparison NUMBER {
        char buf[256];
        snprintf(buf, sizeof(buf), "%s %s %d", $1, $2, $3);
        $$ = strdup(buf);
    }
    | IDENTIFIER comparison STRING {
        // Remove quotes around the string
        $3[strlen($3) - 1] = '\0';  // remove trailing "
        char* value = $3 + 1;  // skip leading "
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

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}

