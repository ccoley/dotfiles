/*
 * File:        stats.h
 *
 *          Header file for the "stats.c" program
 *
 * Course:      CS2450
 * Author:      Chris Coley
 * Username:    coleycj
 */

// Preprocessor Directives
#define MAX_SIZE    1024
#define FNAME       "/u/css/classes/2450/khj/stats/data.txt"

// Function Prototypes
void GetNums(int[], int*);
void CalcMin(int[], int*, int*);
void CalcMax(int[], int*, int*);
void CalcMean(int[], int*, int*);
void DisplayStats(int*, int*, int*);
