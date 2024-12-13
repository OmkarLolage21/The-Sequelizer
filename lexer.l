%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

"findAll"                   { return FINDALL; }
"findBy"                    { return FINDBY; }
"findAllBy"                 { return FINDALLBY; }
"findFirstBy"               { return FINDFIRSTBY; }
"findLastBy"                { return FINDLASTBY; }
"findDistinctBy"            { return FINDDISTINCTBY; }
"findTopBy"                 { return FINDTOPBY; }
"findByLastnameAndFirstname" { return FINDBYLASTNAMEANDFIRSTNAME; }
"findByLastnameOrFirstname" { return FINDBYLASTNAMEORFIRSTNAME; }
"findDistinctByLastnameAndFirstname" { return FINDDISTINCTBYLASTNAMEANDFIRSTNAME; }
"findByStartDateBetween" { return FINDBYSTARTDATEBETWEEN; }
"findByStartDateAfter" { return FINDBYSTARTDATEAFTER; }
"findByStartDateBefore" {  return FINDBYSTARTDATEBEFORE; }
"findByAge(Is)Null" { return FINDBYAGEISNULL; }
"findByAge(Is)NotNull" { return FINDBYAGEISNOTNULL; }
"findByFirstnameLike" { return FINDBYFIRSTNAMELIKE; }
"findByFirstnameNotLike" { return FINDBYFIRSTNAMENOTLIKE; }
"findByFirstnameStartingWith" { return FINDBYFIRSTNAMESTARTINGWITH; }
"findByFirstnameEndingWith" { return FINDBYFIRSTNAMEENDINGWITH; }
"findByFirstnameContaining" { return FINDBYFIRSTNAMECONTAINING; }
"findByAgeOrderByLastnameDesc" { return FINDBYAGEORDERBYLASTNAMEDESC; }
"findByLastnameNot" { return FINDBYLASTNAMENOT; }
"findByAgeIn" { return FINDBYAGEIN; }
"findByAgeNotIn" { return FINDBYAGENOTIN; }
"findByActiveTrue()" { return FINDBYACTIVETRUE; }
"findByActiveFalse()" { return FINDBYACTIVEFALSE; }
"findByFirstnameIgnoreCase" { return FINDBYFIRSTNAMEIGNORECASE; }

"and"                       { return AND; }
"or"                        { return OR; }
"between"                   { return BETWEEN; }
"like"                      { return LIKE; }
"not like"                  { return NOTLIKE; }
"true"                      { return TRUEVAL; }
"false"                     { return FALSEVAL; }
"is null"                   { return ISNULL; }
"is not null"               { return ISNOTNULL; }
"starting with"             { return STARTINGWITH; }
"ending with"               { return ENDINGWITH; }
"containing"                { return CONTAINING; }
"not"                       { return NOT; }
"ignore case"               { return IGNORECASE; }

">"                         { return GREATER; }
"<"                         { return LESS; }
">="                        { return GREATEREQ; }
"<="                        { return LESSEQ; }
"="                         { return EQUALS; }
"!="                        { return NOTEQUAL; }
"("                         { return LPAREN; }
")"                         { return RPAREN; }
","                         { return COMMA; }

"after"                     { return AFTER; }
"before"                    { return BEFORE; }
"in"                        { return IN; }
"not in"                    { return NOTIN; }
"order by"                  { return ORDERBY; }
"true"                      { return TRUEVAL; }
"false"                     { return FALSEVAL; }
"ignore case"               { return IGNORECASE; }

\"[^\"]*\"                  { yylval.str = strdup(yytext); return STRING; }

[a-zA-Z_][a-zA-Z0-9_]*      { yylval.str = strdup(yytext); return IDENTIFIER; }

[0-9]+                      { yylval.num = atoi(yytext); return NUMBER; }

\n                          { /* Ignore newline */ }
[ \t]                       { /* Ignore whitespace */ }

.                           { /* Ignore everything else */ }
%%

int yywrap() {
    return 1;
}