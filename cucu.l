%{
#include <stdio.h>
#include "cucu.tab.h"
%}


%%

int|char[ ][*] {yylval.string=strdup(yytext);  fprintf(yyout, "TYPE : %s\n", yytext); return TYPE;}
return {fprintf(yyout, "RETURN : %s\n", yytext); return RETURN;}
while {fprintf(yyout, "WHILE : %s\n", yytext); return WHILE;}
if {fprintf(yyout, "IF : %s\n", yytext); return IF;}
else {fprintf(yyout, "ELSE : %s\n", yytext); return ELSE;}
[0-9]+ {yylval.number=atoi(yytext);  fprintf(yyout,"NUM : %s\n", yytext); return NUM;}
[a-zA-Z_][a-zA-Z0-9_]* {yylval.string = strdup(yytext);  fprintf(yyout,"IDENTIFIER : %s\n", yytext); return IDENTIFIER;}
= {fprintf(yyout, "ASSIGN : %s\n", yytext); return ASSIGN;}
== {fprintf(yyout, "RELATIONAL OP : %s\n", yytext); return EQ;}
!= {fprintf(yyout, "RELATIONAL OP : %s\n", yytext); return NE;}
\< {fprintf(yyout, "LESS THAN : %s\n", yytext); return LT;}
\> {fprintf(yyout, "GREATER THAN : %s\n", yytext); return GT;}
\<= {fprintf(yyout, "LESS THAN EQUAL : %s\n", yytext); return LTE;}
\>= {fprintf(yyout, "GREATER THAN EQUAL : %s\n", yytext); return GTE;}
[,] {fprintf(yyout, "COMMA : %s\n", yytext); return COMMA;}
[!] {fprintf(yyout, "NOT OP : %s\n", yytext); return NOT;}
\& {fprintf(yyout, "AND OP : %s\n", yytext); return AND;}
\| {fprintf(yyout, "OR OP : %s\n", yytext); return OR;}
\+ {fprintf(yyout, "PLUS : %s\n", yytext);  return PLUS;}
\- {fprintf(yyout, "MINUS : %s\n", yytext); return MINUS;}
\* {fprintf(yyout, "MULTIPLY : %s\n", yytext); return MULT;}
\/ {fprintf(yyout, "DIVIDE : %s\n", yytext); return DIVIDE;}
\{ {fprintf(yyout, "OBRACE : %s\n", yytext); return OCB;}
\} {fprintf(yyout, "EBRACE : %s\n", yytext); return CCB;}
\( {fprintf(yyout, "OBRACE : %s\n", yytext); return OB;}
\) {fprintf(yyout, "EBRACE : %s\n", yytext); return CB;}
\[ {fprintf(yyout, "OBRACE : %s\n", yytext); return OSB;}
\] {fprintf(yyout, "EBRACE : %s\n", yytext); return CSB;}
[;] {fprintf(yyout, "SEMI : %s\n", yytext); return SEMI;}
["].*["] {yylval.string=strdup(yytext); fprintf(yyout, "STRING : %s\n", yytext); return STRING;}
[ \t\n]   {;}
\/\/.* {;}
\/\*(.*\n)*.*\*\/  {;}
%%
