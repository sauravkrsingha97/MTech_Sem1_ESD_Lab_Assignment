	AREA BITS_ID, CODE, READONLY
    ENTRY
START
    LDR R2, =01562      ; Last 5 ID digits 
    MOV R0, #0          ; This will hold the count of 0's
    MOV R1, #0          ; This will hold the count of 1's
    MOV R3, #32         ; Counter to check all 32 bits of the register

COUNT_LOOP
    MOVS R2, R2, LSR #1 ; Shift R2 right by 1, bit moves to Carry Flag
    BCS BRANCH          ; If Carry is 1, branch to BRANCH
    ADD R0, R0, #1      ; If not 1, increment 0's counter (R0)
    B CHECK_DONE

BRANCH
    ADD R1, R1, #1      ; Increment 1's counter (R1)

CHECK_DONE
    SUBS R3, R3, #1     ; Decrement our 32-bit loop counter
    BNE COUNT_LOOP      ; If not zero, repeat for next bit

STOP B STOP             ; End the program
    END