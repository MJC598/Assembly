**************************************
*
* Name: Matthew Carroll
* ID: 14262619
* Date: March 4, 2018
* Lab3
*
* Program description:
*   Solve for the Nth number in the Fibonacci Sequence and save into a 4-byte number
*
* Pseudocode:
*
*  unsigned int N = 40; (1 byte variable)
*  unsigned int RESULT; (4-byte variable)
*
*  unsigned int COUNT; (1 byte variable)
*  unsigned int PREV; (4-byte variable)
*  unsigned int NEXT; (4-byte variable)
*
*
*  RESULT=1;
*  PREV=1;
*  COUNT = N;
*  while(COUNT>2){
*   PREV = RESULT + PREV;
*   NEXT = PREV;
*   PREV = RESULT;
*   RESULT = NEXT;
*   COUNT--;
*  }
*
**************************************

* start of data section


            ORG 	$B000
N           FCB    	40 

	        ORG 	$B010
RESULT      RMB     4
*uses whatever register is open
            
* define any other variables that you might need here
COUNT       RMB     1
PREV        RMB     4
*X-Register is used primarily as pointer thru PREV
NEXT        RMB     4
*Y-Register is used primarily as pointer thru NEXT
            
* start of your program
            
	        ORG  	$C000
            
            LDY     #RESULT     *Clearing RESULT variable
            CLR     0,Y         *
            CLR     1,Y         *
            CLR     2,Y         *
            CLR     3,Y         *
            
            LDAA    #1 
            CLC
            ADCA    3,Y         RESULT = 1
            STAA    3,Y
            
            LDX     #PREV
            LDY     #NEXT
            CLR     COUNT
            
            CLR     0,X         *Clearing PREV variable
            CLR     1,X         *
            CLR     2,X         *         
            CLR     3,X         *
            
            CLR     0,Y         *Clearing NEXT variable
            CLR     1,Y         *
            CLR     2,Y         *
            CLR     3,Y         *
            
            LDAA    #1
            CLC
            ADCA    3,X         PREV = 1
            STAA    3,X
            
            LDAA    N
            STAA    COUNT       COUNT = N
WHILE       LDAA    COUNT
            CMPA    #2          while(count>2)
            BLS     ENDWL    
            
            LDY     #RESULT     PREV = RESULT + PREV
            LDAA    3,Y         
            ADDA    3,X         *Adds the LSBs, doesn't need the CF
            STAA    3,X
            LDAA    2,Y
            ADCA    2,X         *Since its the second byte it needs the CF
            STAA    2,X
            LDAA    1,Y         
            ADCA    1,X         *3rd byte needs CF
            STAA    1,X
            LDAA    0,Y
            ADCA    0,X         *MSB needs CF
            STAA    0,X
            
            LDY     #NEXT       NEXT = PREV;
            LDAA    0,X
            STAA    0,Y
            LDAA    1,X
            STAA    1,Y
            LDAA    2,X
            STAA    2,Y
            LDAA    3,X
            STAA    3,Y
            
            LDY     #RESULT     PREV = RESULT
            LDAA    0,Y
            STAA    0,X
            LDAA    1,Y
            STAA    1,X
            LDAA    2,Y
            STAA    2,X
            LDAA    3,Y
            STAA    3,X
            
            LDY     #NEXT       RESULT = NEXT
            LDX     #RESULT
            LDAA    0,Y
            STAA    0,X
            LDAA    1,Y
            STAA    1,X
            LDAA    2,Y
            STAA    2,X
            LDAA    3,Y
            STAA    3,X
            
            LDX     #PREV       *This is done so it can actually add the two together when it loops
            
            DEC     COUNT       COUNT--
            BRA     WHILE       REQUIRED BRANCH BACK TO BEGINNING OF WHILE LOOP
ENDWL       BRA     ENDWL       END OF PROGRAM            
            

