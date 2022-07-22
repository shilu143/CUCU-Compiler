%{
#include<stdio.h>
#include<stdlib.h>
extern FILE *yyout, *yyin;
FILE *out;
%}

%union{
    int number;
    char *string;
}

%token <string> STRING
%token RETURN WHILE IF ELSE
%token ASSIGN
%token EQ NE LT GT LTE GTE
%token NOT AND OR
%token PLUS MINUS MULT DIVIDE
%token OCB CCB OB CB OSB CSB SEMI COMMA

%token <string> TYPE IDENTIFIER
%token <number> NUM

%%

PROGRAM : VAR_DEC 
        | FUNC_DEC 
        | FUNC_DEF
        | VAR_DEFINITION ;
        /* | PROGRAM */

VAR_DEC : TYPE IDENTIFIER SEMI PROGRAM {fprintf(out,"VARIABLE_NAME:%s  VARIABLE_TYPE:%s\n", $2, $1);} 
          | TYPE IDENTIFIER SEMI {fprintf(out,"VARIABLE_NAME:%s  VARIABLE_TYPE:%s\n", $2, $1);}

FUNC_DEC : TYPE IDENTIFIER OB FUNC_ARGS CB SEMI PROGRAM{fprintf(out,"VARIABLE_NAME:%s  VARIABLE_TYPE:%s\n", $2, $1);}
            |TYPE IDENTIFIER OB FUNC_ARGS CB SEMI{fprintf(out,"VARIABLE_NAME:%s  VARIABLE_TYPE:%s\n", $2, $1);}

VAR_DEFINITION : TYPE IDENTIFIER ASSIGN EXPR SEMI PROGRAM{fprintf(out,"VARIABLE_NAME:%s  VARIABLE_TYPE:%s\n", $2, $1);}
                | TYPE IDENTIFIER ASSIGN EXPR SEMI{fprintf(out,"VARIABLE_NAME:%s  VARIABLE_TYPE:%s\n", $2, $1);}

FUNC_DEF : TYPE IDENTIFIER OB FUNC_ARGS CB FUNC_BODY PROGRAM{
        fprintf(out,"FUNCTION_DEFINED:%s  RETURN_TYPE:%s\n", $2, $1);
    }
    | TYPE IDENTIFIER OB FUNC_ARGS CB FUNC_BODY {
        fprintf(out,"FUNCTION_DEFINED:%s  RETURN_TYPE:%s\n", $2, $1);
    }

FUNC_ARGS : TYPE IDENTIFIER COMMA FUNC_ARGS {fprintf(out,"FUNCTION_ARGUMENT:%s\n", $2);}
            | TYPE IDENTIFIER {fprintf(out,"FUNCTION_ARGUMENT:%s\n", $2);}
            |
             

FUNC_BODY : OCB STATEMENTS CCB 

STATEMENTS : STATEMENTS STATEMENT | STATEMENT ;

STATEMENT :     TYPE IDENTIFIER SEMI  {fprintf(out,"VARIABLE_NAME:%s  VARIABLE_TYPE:%s\n", $2, $1);}
                | TYPE IDENTIFIER ASSIGN EXPR SEMI {fprintf(out,"VARIABLE_NAME:%s  VARIABLE_TYPE:%s\n",$2,$1);}
                | IDENTIFIER ASSIGN EXPR SEMI {fprintf(out,"VARIABLE_NAME:%s\n",$1);}
                | RETURN EXPR SEMI {fprintf(out,"RETURN \n");}
                | IDENTIFIER SEMI {fprintf(out, "VARIABLE_NAME:%s\n",$1);}
                | IF OB EXPR CB STATEMENT {fprintf(out, "IF_STATEMENT\n");}
                | IF OB EXPR CB STATEMENT ELSE STATEMENT {fprintf(out, "IF_ELSE_STATEMENT\n");}
                | IF OB EXPR CB OCB STATEMENTS CCB {fprintf(out, "IF_STATEMENT\n");}
                | IF OB EXPR CB OCB STATEMENTS CCB ELSE OCB STATEMENTS CCB {fprintf(out, "IF_ELSE_STATEMENT\n");}
                | WHILE OB EXPR CB STATEMENT {fprintf(out, "WHILE_CONSTRUCT\n");}
                | WHILE OB EXPR CB OCB STATEMENTS CCB {fprintf(out, "WHILE_CONSTRUCT\n");}
                | IDENTIFIER OB EX_L CB SEMI {fprintf(out,"FUNCTION_CALLED:%s ",$1);}
                | EXPR SEMI

EX_L : EXPR COMMA EX_L | EXPR |

EXPR : BITWISE_EXPR 
        | BITWISE_EXPR ASSIGN EXPR

BITWISE_EXPR : EQ_EXPR
                   | BITWISE_EXPR AND EQ_EXPR {fprintf(out, "AND_OP ");}
                   | BITWISE_EXPR OR EQ_EXPR {fprintf(out, "OR_OP ");}
EQ_EXPR : REL_EXPR
              | EQ_EXPR EQ REL_EXPR {fprintf(out, "EQUALS ");}
              | EQ_EXPR NE REL_EXPR {fprintf(out, "NOT_EQUALS ");}

REL_EXPR : SHIFT_EXPR
               | REL_EXPR GT SHIFT_EXPR 
               | REL_EXPR LT SHIFT_EXPR 

SHIFT_EXPR : ADD_EXPR

ADD_EXPR : PRIM_EXPR
               | ADD_EXPR PLUS PRIM_EXPR {fprintf(out,"ADDITION ");}
               | ADD_EXPR MINUS PRIM_EXPR {fprintf(out,"SUBTRACTION ");}
               | ADD_EXPR DIVIDE PRIM_EXPR {fprintf(out,"DIVIDE ");}
               | ADD_EXPR MULT PRIM_EXPR {fprintf(out,"MULTIPLY ");}

PRIM_EXPR : NUM {fprintf(out,"CONST-%d ",$1);} | IDENTIFIER {fprintf(out,"IDENTIFIER-%s ",$1);} | STRING {fprintf(out,"CONST-%s ",$1);} | OB EXPR CB  

%%

int main(int argc, char *argv[]) {
    yyin = fopen(argv[1],"r");
    yyout = fopen("Lexer.txt", "w");
    out = fopen("Parser.txt","w");
    yyparse();
}

int yyerror(char *msg) {
    fprintf(out, "\n\nTHERE IS AN ERROR IN YOUR CODE\n");
    exit(0);
}

int yywrap()
{
    return 1;
}