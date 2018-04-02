**************************************
*
* Name: Matthew Carroll
* ID: 14262619
* Date: March 20, 2018
* Lab4
*
* Program description:
* Take in an array giving us the values we want to calculate in the fibonacci sequence and output to a second array
* 
* Pseudocode of Main Program:
*   usigned int N;
*   unsigned int R;
*   N = NARR
*   R = RESARR
*   while(N != $00){
*       R = calculate(*N);
*       R++;
*       N++;
*   }
* 
*---------------------------------------
*
* Pseudocode of Subroutine:
*
*   //This is literally my lab 3, copied and N changed into value. Why do something twice?
*   
*   calculate(VALUE){
*       unsigned int VA;
*       VA = VALUE;
*       unsigned int RESULT; (4-byte variable)
*       unsigned int COUNT; (1 byte variable)
*       unsigned int PREV; (4-byte variable)
*       unsigned int NEXT; (4-byte variable)
*       RESULT=1;
*       PREV=1;
*       COUNT = VA;
*       while(COUNT>2){
*           PREV = RESULT + PREV;
*           NEXT = PREV;
*           PREV = RESULT;
*           RESULT = NEXT;
*           COUNT--;
*       }
*       return RESULT
*   }
*
**************************************



* start of data section
	    ORG     $B000
NARR	FCB	    1, 2, 5, 10, 20, 128, 254, 255, $00
SENTIN	EQU	    $00

	    ORG     $B010
RESARR	RMB	    32	
                
                
                
* define any variables that your MAIN program might need here
* REMEMBER: Your subroutine must not access any of the main
* program variables including NARR and RESARR.

R       RMB     2
N       RMB     2


	    ORG     $C000
	    LDS	    #$01FF		initialize stack pointer
* start of your main program
        LDX     #RESARR
        CLR     R
        STX     R           R = RESARR          
        LDX     #NARR       
        CLR     N           
        STX     N           N = NARR
WLE     LDAA    0,X         
        CMPA    #$00        
        BEQ     DONE        while(N != $00)
        JSR     CAL         R = CAL(*N)
        LDX     R           
        PULA                
        STAA    0,X         Pulling 1st value off stack and putting it in RESARR value
        INX
        PULA    
        STAA    0,X         Pulling 2nd and adding to RESARR
        INX
        PULA    
        STAA    0,X         Pulling 3rd and adding to RESARR
        INX
        PULA
        STAA    0,X         Pulling 4th and adding to RESARR
        INX
        STX     R           R++
        LDX     N
        INX
        STX     N           N++
        BRA     WLE
DONE    BRA     DONE                
                
                
* define any variables that your SUBROUTINE might need here
COUNT   RMB     1
PREV    RMB     4
NEXT    RMB     4
RESULT  RMB     4
VA      RMB     1
RTMP    RMB     2
                
                   
	    ORG     $D000
* start of your subroutine
CAL     CLR     VA
        STAA    VA          putting parameter in memory to use in subroutine
        
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
        
        LDAA    VA
        STAA    COUNT       COUNT = VA
WHILE   LDAA    COUNT
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
        
ENDWL   PULX                takes return value off stack
        STX     RTMP        temporarily puts the return pointer in memory
        
        LDX     #RESULT     used to put variables in stack
        
        TSY     
        LDAA    3,X
        PSHA    3,Y         stores first byte on stack
        LDAA    2,X         
        PSHA    2,Y         stores second byte on stack
        LDAA    1,X
        PSHA    1,Y         stores third byte on stack
        LDAA    0,X 
        PSHA    0,Y         stores fourth byte on stack
        
        LDX     RTMP        put the return pointer back in X
        PSHX                put the return pointer on the top of the stack
        
        RTS