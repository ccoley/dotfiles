;
;   File:       sumtwo.asm
;   
;       Program accepts two single digit integers from the user, then if the sum is
;       less than 10 it displays the sum to the user.
;
;   Course:     CS2450
;   Author:     Chris Coley
;   Username:   coleycj
;
;   Register Usage:
;
;       R1: Num1 - First Input Number Variable
;       R2: Num2 - Second Input Number Variable
;       R3: Sum  - Sum Variable
;       R4: Temp - Temporary variable

; Labels        OpCodes Operands        Comments
                .ORIG   x3000

;       *** Display the greeting message
                LEA     R0, BAR
                PUTS
                LEA     R0, INTRO
                PUTS
                LEA     R0, BAR
                PUTS

;       *** Begin loop
LOOP            AND     R1, R1, 0       ; initialize Num1 to 0
                AND     R2, R2, 0       ; initialize Num2 to 0

;       *** Get a number from the user
                LEA     R0, FIRST       ; prompt user for a number
                PUTS
                GETC
                OUT                     ; mirror the input
                ADD     R1, R1, R0      ; Num1 <-- input

;       *** Validate the input
                LD      R4, OFFSET1    
                ADD     R4, R4, R1
                BRz     DONE            ; If Num1 is 0
                BRn     INPUT_ERROR     ; If Num1 is <0
                LD      R4, OFFSET2     
                ADD     R4, R4, R1
                BRp     INPUT_ERROR     ; If Num1 is >9

;       *** Get a second number from the user
                LEA     R0, SECOND      ; prompt user for a number
                PUTS
                GETC
                OUT                     ; mirror the input
                ADD     R2, R2, R0      ; Num2 <-- input

;       *** Validate the input
                LD      R4, OFFSET1
                ADD     R4, R4, R2
                BRz     DONE            ; If Num2 is 0
                BRn     INPUT_ERROR     ; If Num2 is <0
                LD      R4, OFFSET2
                ADD     R4, R4, R2
                BRp     INPUT_ERROR     ; If Num2 is >9

;       *** Calculate the sum
                LD      R4, OFFSET1
                ADD     R3, R4, R1
                ADD     R3, R3, R2

;       *** Validate the sum
                LD      R4, OFFSET2
                ADD     R4, R4, R3
                BRp     SUM_ERROR       ; If Sum is >9

;       *** Display the sum
                LEA     R0, NEW_LINE
                PUTS
                PUTS
                ADD     R0, R1, 0
                OUT                     ; Num1
                LEA     R0, PLUS
                PUTS                    ; " + "
                ADD     R0, R2, 0
                OUT                     ; Num2
                LEA     R0, EQUALS
                PUTS                    ; " = "
                ADD     R0, R3, 0
                OUT                     ; Sum
                BRnzp   LOOP
;       *** End Loop

;       *** Display the exit message
DONE            LEA     R0, NEW_LINE
                PUTS
                LEA     R0, OUTRO
                PUTS
                HALT

;       *** Display input ERROR message
INPUT_ERROR     LEA     R0, IN_ERR_MSG
                PUTS
                BRnzp   LOOP

;       *** Display sum ERROR message
SUM_ERROR       LEA     R0, SUM_ERR_MSG
                PUTS
                BRnzp   LOOP

;       ************
;       *** DATA ***
;       ************
OFFSET1         .FILL    xFFD0          ; -30
OFFSET2         .FILL    xFFC7          ; -39
BAR             .STRINGZ "\n===========================\n"
INTRO           .STRINGZ "=== Welcome to \"sumtwo\" ==="
OUTRO           .STRINGZ "\n==> Thanks for using \"sumtwo\" <==\n"
FIRST           .STRINGZ "\nEnter first number  (0 to exit): "
SECOND          .STRINGZ "\nEnter second number (0 to exit): "
PLUS            .STRINGZ " + "
EQUALS          .STRINGZ " = "
NEW_LINE        .STRINGZ "\n"
IN_ERR_MSG      .STRINGZ "\nERROR: You Can Only Enter Numbers\n"
SUM_ERR_MSG     .STRINGZ "\nERROR: The Sum Can Not Be Over 9\n"

                .END
