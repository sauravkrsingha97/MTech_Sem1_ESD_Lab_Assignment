        AREA RESET, DATA, READONLY
        EXPORT __Vectors

__Vectors
        DCD 0x20001000        ; Initial Stack Pointer
        DCD Reset_Handler
        DCD 0
        DCD 0
        DCD 0
        DCD 0
        DCD 0
        DCD 0
        DCD 0
        DCD 0
        DCD 0
        DCD SVC_Handler       ; SVC Handler

;--------------------------------------

        AREA CODE, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler

Reset_Handler

        ; Switch to unprivileged Thread mode
        MOV R0, #1
        MSR CONTROL, R0

        ; Parameters
        LDR R0, =1562
        LDR R1, =1562

        ; Call SVC (62)
        SVC #62

loop
        B loop

;--------------------------------------

        EXPORT SVC_Handler

SVC_Handler

        ; Get stacked PC
        TST LR, #4
        ITE EQ
        MRSEQ R0, MSP
        MRSNE R0, PSP

        LDR R1, [R0, #24]     ; PC
        LDRB R2, [R1, #-2]    ; SVC number

        ; Compare with 62
        MOV R3, #62
        CMP R2, R3

        ; Get parameters
        LDR R4, [R0, #0]      ; R0
        LDR R5, [R0, #4]      ; R1

        BEQ DO_ADD

DO_SUB
        SUB R6, R4, R5
        B EXIT

DO_ADD
        ADD R6, R4, R5

EXIT
        STR R6, [R0, #0]      ; return value in R0

        BX LR

        END