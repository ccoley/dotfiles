/*
 * File:        stats.c
 *
 *      Program uses a function to read up to 1024 decimal integers from a text file.
 *      Once it has these numbers it calculates the min, max, and mean of the values,
 *      and displays them to the user.
 *
 * Course:      CS2450
 * Author:      Chris Coley
 * Username:    coleycj
 */

// Preprocessor Directives
#include <stdio.h>
#include <stdlib.h>
#include "Header_for_C2.h"

int main()
{
    int min;
    int max;
    int mean;
    int counter = 0;
    int values[MAX_SIZE];

    GetNums( values, &counter );            // Get values

    // If the values array has more than one element, calculate the min and max.
    // Else, you know they are the only number in the array so set them manually.
    if( counter > 1 )
    {
        CalcMin( values, &counter, &min );
        CalcMax( values, &counter, &max );
    }
    else
    {
        min = values[0];
        max = values[0];
    }

    CalcMean( values, &counter, &mean );    // Calculate the mean
    DisplayStats( &min, &max, &mean );      // Display the min, max, and mean
}

/** 
 * Function GetNums scans a file, puts the numbers from the file into an array, and
 * then stores the number of elements in the array in the 'counter' variable
 */
void GetNums( int v[], int *n )
{
    // Open the file
    FILE *fp;
    fp = fopen( FNAME, "r" );

    // Scan the file and populate the array
    if( fp != NULL )
    {
        int i = 0;
        while(( fscanf( fp, "%d", &v[i] ) != EOF ) && i < MAX_SIZE )
            i++;
        
        *n = i;                             // store the number of elements 
        fclose( fp );                       // close the file
    }
    else
        printf( "ERROR: File Not Found\n" );
}

/**
 * Function CalcMin finds the minimum value in an array and stores it in the 'min'
 * variable
 */
void CalcMin( int v[], int *n, int *min )
{
    int num;
    int i;

    // Prime the 'min' variable with the lowest of the first two elements
    *min = ( v[0] < v[1] ) ? v[0] : v[1];

    // Iterate through the rest of the array, updating 'min' if necessary
    for( i = 2; i < *n; i++ )
    {
        num = v[i];
        if( num < *min )
            *min = num;
    }
}

/**
 * Function CalcMax finds the maximum value in an array and stores it in the 'max'
 * variable
 */
void CalcMax( int v[], int *n, int *max )
{
    int num;
    int i;
    
    // Prime the 'max' variable with the highest of the first two elements
    *max = ( v[0] > v[1] ) ? v[0] : v[1];

    // Iterate through the rest of the array, updating 'max' if necessary
    for( i = 2; i < *n; i++ )
    {
        num = v[i];
        if( num > *max )
            *max = num;
    }
}

/**
 * Function CalcMean calculates the average, or mean, of an array and stores it in
 * the 'mean' variable
 */
void CalcMean( int v[], int *n, int *mean )
{
    int sum = 0;
    int i;
    
    for( i = 0; i < *n; i++ )
    {
        sum += v[i];                        // sum all the elements in the array
    }

    *mean = ( sum / *n );                   // calculate and store the average
}

/**
 * Function DisplayStats displays the minimum, maximum, and average values
 */
void DisplayStats( int *min, int *max, int *mean )
{
    printf( "The smallest number is %d\n", *min );
    printf( "The largest number is %d\n", *max );
    printf( "The average is %d\n", *mean );
}
