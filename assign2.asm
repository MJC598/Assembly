**************************************
*
* Name: Matthew Carroll
* ID: 14262619
* Date: February 19, 2018
* Lab2
*
* Program description:
*   Calculate the Nth number of the Fibonacci Sequence
*
* Pseudocode:
*
*	#define N = whatever I want to find
*   unsigned int result;
*   unsigned int first;
*   unsigned int second;
*   unsigned int counter;
*
*	unsigned int main(void)
*		result = 1;
*   	first = 0;
*       second = 0;
*       counter = 0;
*		while counter < N DO
*           counter++;
*			first = result;
*			result = first + second;
*			second = first;
*           if counter == 1 DO
*               second--;
*		return result;
*		
*
**************************************

* start of data section

        ORG     $B000
N       FCB     10

* define any other variables that you might need here
        ORG     $B010
RESULT  RMB     2
FIRST   RMB     2
SECOND  RMB     2
COUNTER RMB     1

* start of your program
        ORG     $C000
        CLR     RESULT      result = 0
        CLR     RESULT+1
        LDD     RESULT      result = 1
        ADDD    #1
        STD     RESULT
        CLR     FIRST       first = 0
        CLR     FIRST+1
        CLR     SECOND      second = 0
        CLR     SECOND+1
        CLR     COUNTER     counter = 0
WHILE   LDAA    COUNTER     while(counter < N)
        CMPA    N
        BHS     ENDWLE
        ADDA    #1          counter++
        STAA    COUNTER
        CLR     FIRST       first = result
        CLR     FIRST+1
        LDD     FIRST
        ADDD    RESULT      result = first + second
        STD     FIRST
        LDD     FIRST
        ADDD    SECOND
        STD     RESULT
        CLR     SECOND      second = first
        CLR     SECOND+1
        LDD     SECOND
        ADDD    FIRST
        STD     SECOND
IF      LDAA    COUNTER     if(counter == 1)
        CMPA    #1
        BNE     ELSE
        LDD     SECOND      second--
        SUBD    #1
        STD     SECOND      
ELSE    BRA     WHILE
ENDWLE  BRA     ENDWLE      return result
