/* CMSC 430 Compiler Theory and Design
   Project 1 Skeleton
   UMGC CITE
   Summer 2023 */

/* This file contains flex input file */

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws			[ \t\r]+
comment		"//".*\n
line		[\n]
id     		[a-zA-Z](([a-zA-Z0-9])|(_[a-zA-Z0-9])|(__[a-zA-Z0-9]))*
digit		[0-9]
dec			{digit}+
hex   		 \#[a-fA-F0-9]+  // Added — used in test6.txt


char1   	'[^\'\\]'		// Added — used in test6.txt
char2  	    '\\[btnrf]'		// Added — used in test6.txt

punc		[\(\),:;]
realit      [0-9]*\.[0-9]+([eE][+-]?[0-9]+)?	// Added — used in test6.txt

%%

{ws}		{ ECHO; }

{comment}	{ ECHO; nextLine(); }
{line}		{ ECHO; nextLine(); }
"+"			{ ECHO; return(ADDOP); }
"*"			{ ECHO; return(MULOP); }
"/"			{ ECHO; return(MULOP); }	
"&"			{ ECHO; return(ANDOP); }
"-"         { ECHO; return(ADDOP); }  

"=>"		{ ECHO; return(ARROW); }
begin		{ ECHO; return(BEGIN_); }
case		{ ECHO; return(CASE); }
character	{ ECHO; return(CHARACTER); }
end			{ ECHO; return(END); }
endswitch	{ ECHO; return(ENDSWITCH); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is			{ ECHO; return(IS); }
list		{ ECHO; return(LIST); }
of			{ ECHO; return(OF); }
others		{ ECHO; return(OTHERS); }
returns		{ ECHO; return(RETURNS); }
switch		{ ECHO; return(SWITCH); }
when		{ ECHO; return(WHEN); }


"real"      { ECHO; return(REAL); }
"if"        { ECHO; return(IF); }
"then"      { ECHO; return(THEN); }
"else" 		{ ECHO; return(ELSE); }
"elsif"     { ECHO; return(ELSIF); }
"endif"     { ECHO; return(ENDIF); }
"fold"      { ECHO; return(FOLD); }
"left"      { ECHO; return(LEFT); }
"right"     { ECHO; return(RIGHT); }
"endfold"   { ECHO; return(ENDFOLD); }

"%"      { ECHO; return (MULOP); }    
"^"      { ECHO; return (ADDOP); }    
"="      { ECHO; return (ASSIGNOP); } 

"~"      { ECHO; return(NEGOP); }      // Added - used in test5.txt

"|"      { ECHO; return(OROP); }		// Added - used in test5.txt
"!"      { ECHO; return(NOTOP); }		// Added - used in test5.txt

"<"      { ECHO; return(RELOP); }
">"      { ECHO; return(RELOP); }
"<="     { ECHO; return(RELOP); }
">="     { ECHO; return(RELOP); }
"<>"     { ECHO; return(RELOP); }


{id}		{ ECHO; return(IDENTIFIER); }
{dec}		{ ECHO; return(INT_LITERAL); }
{hex}         { ECHO; return(HEXINT); }
{char1}		{ ECHO; return(CHAR_LITERAL); }
{char2}		{ ECHO; return(CHAR_LITERAL); }

{punc}		{ ECHO; return(yytext[0]); }
{realit}      { ECHO; return(REALIT); }
.		{ ECHO; appendError(LEXICAL, yytext); }

%%


int main() {
	firstLine();
	
	FILE *file = fopen("lexemes.txt", "w");

	int token = yylex();
	while (token) {
		fprintf(file, "%d %s\n", token, yytext);
		token = yylex();
	}
	lastLine();
	fclose(file);
	return 0;
}