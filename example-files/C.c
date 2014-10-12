/*******************************************************************************
 * RDParser.c  --  by Chris Coley
 *
 * Program 6 - Building a Recursive Descent Parser
 *
 * Write a program the recognizes properly formed integer expressions such as 
 * 3+4, (4-(-5))*7, 24/6+2, etc.
 *
 * Accepts language {0,1,2,3,4,5,6,7,8,9,-,+,*,/,(,)}
 *
 * =============================================================================
 *
 * Extra Credit: Update the parser to allow white space in the strings.
 *
 * Rules:
 *   -- The string can contain any number of "spaces" or "tabs".
 *   -- The string can not begin with white space.
 *   -- There can not be any white space between a number and it's sign. 
 *      For example "-6" and "-( 7 + 3 )" are accepted, but "- 6" and 
 *      "- ( 7 + 3 )" are not.
 ******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

// Function Prototypes
void match(char lookahead, char *curr);
int error();
void Expr(char *curr);
void F(char *curr);
void G(char *curr);
void Term(char *curr);
void H(char *curr);
void Factor(char *curr);
void AddOp(char *curr);
void MulOp(char *curr);
void Number(char *curr);
void I(char *curr);
void Digit(char *curr);
void WhiteSpace(char *curr);

char *curr;

int main() {
    char ch;
    puts("Enter a string for parsing: ");
    ch = getchar();
    curr = &ch;
    Expr(curr);
    if (*curr == '\n')
        puts("String is in the language");
    else
        error();
}

void match(char lookahead, char *curr) {
    if (*curr == lookahead)
        *curr = getchar();
    else
        error();
}

int error() {
    puts("SYNTAX ERROR");
    exit(1);
}

void Expr(char *curr) {
    // Expr -> F Term G
    if (isdigit(*curr) || *curr == '+' || *curr == '-' || *curr == '(') {
        F(curr);
        Term(curr);
        WhiteSpace(curr);
        G(curr);
    }
    else
        error();
}

void F(char *curr) {
    // F -> AddOp
    if (*curr == '+' || *curr == '-')
        AddOp(curr);
}

void G(char *curr) {
    // G -> AddOp Term G
    if (*curr == '+' || *curr == '-') {
        AddOp(curr);
        WhiteSpace(curr);
        Term(curr);
        WhiteSpace(curr);
        G(curr);
    }
}

void Term(char *curr) {
    // Term -> Factor H
    if (isdigit(*curr) || *curr == '('){
        Factor(curr);
        WhiteSpace(curr);
        H(curr);
    }
    else
        error();
}

void H(char *curr) {
    // H -> MulOp Factor H
    if (*curr == '*' || *curr == '/') {
        MulOp(curr);
        WhiteSpace(curr);
        Factor(curr);
        WhiteSpace(curr);
        H(curr);
    }
}

void Factor(char *curr) {
    // Factor -> Number
    if (isdigit(*curr))
        Number(curr);
    // Factor -> ( Expr )
    else if (*curr == '(') {
        match('(', curr);
        WhiteSpace(curr);
        Expr(curr);
        WhiteSpace(curr);
        match(')', curr);
    }
    else
        error();
}

void AddOp(char *curr) {
    // AddOp -> +
    if (*curr == '+')
        match('+', curr);
    // AddOp -> -
    else if (*curr == '-')
        match('-', curr);
    else
        error();
}

void MulOp(char *curr) {
    // MulOp -> *
    if (*curr == '*')
        match('*', curr);
    // MulOp -> /
    else if (*curr == '/')
        match('/', curr);
    else
        error();
}

void Number(char *curr) {
    // Number -> Digit I
    if (isdigit(*curr))
    {
        Digit(curr);
        I(curr);
    }
    else
        error();
}

void I(char *curr) {
    // I -> Digit I
    if (isdigit(*curr))
    {
        Digit(curr);
        I(curr);
    }
}

void Digit(char *curr) {
    // Digit -> 0|1|2|3|4|5|6|7|8|9
    match(*curr, curr);
}

void WhiteSpace(char *curr) {
    // WhiteSpace -> ' 'WhiteSpace
    if (*curr == ' ') {
        match(' ', curr);
        WhiteSpace(curr);
    }
    // WhiteSpace -> '\t'WhiteSpace
    else if (*curr == '\t') {
        match('\t', curr);
        WhiteSpace(curr);
    }
}

