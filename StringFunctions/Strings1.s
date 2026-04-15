// --------------------------------------------
// str_print - Prints bool values. Prints false for invalid cases.
// Pre:
// X0: Bool value 0 or 1.
// LR: Contains the return address
// Post:
// X0: Bool string.
// --------------------------------------------
// str_length1 - Returns length of string.
// Pre:
// X0: Points to the first byte of a CString
// LR: Contains the return address
// Post:
// X0: The length of the string.
// --------------------------------------------
// str_equals - Checks if strings are equal.
// Pre:
// X0: Points to the first byte of a CString.
// X1: Points to the first byte of another CString.
// LR: Contains the return address
// Post:
// X0: Bool value.
// --------------------------------------------
// str_equalsIgnore - Checks if strings are equal while ignoring case.
// Pre:
// X0: Points to the first byte of a CString.
// X1: Points to the first byte of another CString.
// LR: Contains the return address
// Post:
// X0: Bool value.
// --------------------------------------------
// str_copy - Copies a string.
// Pre:
// X0: Points to the first byte of a CString.
// LR: Contains the return address
// Post:
// X0: Dynamic address of copied string.
// --------------------------------------------
// str_substring_1 - Returns a substring of a string.
// Pre:
// X0: Points to the first byte of a CString.
// X1: Contains the leftmost boundary for the substring.
// X2: Contains the rightmost boundary for the substring.
// LR: Contains the return address
// Post:
// X0: Dynamic address of substring.
// --------------------------------------------
// str_substring_2 - Returns a substring of a string.
// Pre:
// X0: Points to the first byte of a CString.
// X1: Contains the leftmost boundary for the substring.
// LR: Contains the return address
// Post:
// X0: Dynamic address of substring.
// --------------------------------------------
// str_char - Returns a character at a specified position.
// Pre:
// X0: Points to the first byte of a CString.
// X1: The position of a character.
// LR: Contains the return address
// Post:
// X0: A character.
// --------------------------------------------
// str_startsWith_1 - Prints if a string starts with another string at an index.
// Pre:
// X0: Points to the first byte of a CString.
// X1: The index value
// X2: Points to the first byte of a comparison CString.
// LR: Contains the return address.
// Post:
// X0: Bool value.
// --------------------------------------------
// str_startsWith_2 - Prints if a string starts with another string.
// Pre:
// X0: Points to the first byte of a CString.
// X1: Points to the first byte of a comparison CString.
// LR: Contains the return address.
// Post:
// X0: Bool value.
// --------------------------------------------
// str_endsWith - Prints if a string ends with another string.
// Pre:
// X0: Points to the first byte of a CString.
// X1: Points to the first byte of a comparison CString.
// LR: Contains the return address.
// Post:
// X0: Bool value.
// --------------------------------------------

    .data
    szTrue:         .asciz "TRUE"
    szFalse:        .asciz "FALSE"
    
    .global str_printBool
    .global str_length1
    .global str_equals
    .global str_equalsIgnoreCase
    .global str_copy
    .global str_substring_1
    .global str_substring_2
    .global str_charAt
    .global str_startsWith_1
    .global str_startsWith_2
    .global str_endsWith
    
    .text

str_printBool:
    STR X29, [SP, #-16]!            // Push to stack pointer.
	STR X30, [SP, #-16]!            // Push to stack pointer.

    CMP X0, #1		                // Compare X0 with 1.
    BEQ str_printBool_true          // Branch to true if equal.
    
    LDR X0, =szFalse                // Load the address of szFalse into X0.
    BL putstring                    // Branch and link to putstring.
    LDR X0, =szFalse                // Load the address of szTrue into X0.
    B str_printBool_exit            // Branch to exit.

str_printBool_true:
    LDR X0, =szTrue                 // Load the address of szTrue into X0.
    BL putstring                    // Branch and link to putstring.
    LDR X0, =szTrue                 // Load the address of szFalse into X0.

str_printBool_exit:
    LDR X30, [SP], #16              // Pop from stack pointer.
	LDR X29, [SP], #16              // Pop from stack pointer.
    RET                             // Return.

// --------------------------------------------

str_length1:
    STR  X29, [SP, #-16]! // Push to stack.
    STR  X30, [SP, #-16]! // Push link register.

    MOV  X7, X0           // Points to the first digit of CString
    MOV  X2, #0           // Counter

str_length1_topLoop:
    LDRB W1, [X7], #1     // indirect addressing X1 = *X0
    CMP  W1, #0           // if (W1 == NULL CHARACTER)
    BEQ  str_length1_botLoop         // Jump to end of loop
    ADD  X2, X2, #1      // increment the counter
    B    str_length1_topLoop         // Loop

str_length1_botLoop:
    mov  X0, X2          // X0 = Length of string 

    LDR X30, [SP], #16   // Pop LR.
    LDR X29, [SP], #16   // Pop
    ret                  // Return to caller

// --------------------------------------------

str_equals:
    STR X29, [SP, #-16]!            // Push to stack pointer.
	STR X30, [SP, #-16]!            // Push to stack pointer.
    
    MOV X6, X0                      // Move X0 contents into X6.
    MOV X7, X1                      // Move X1 contents into X7.
    
str_equals_loop:
    LDRB W0, [X6], #1               // Load W0 with X6 with shift.
    LDRB W1, [X7], #1               // Load W1 with X7 with shift.
    
    CMP W0, W1                      // Compare W0 with W1.
    BNE str_equals_ne               // Branch to ne if W0 ~= W1.
    
    CMP W0, #0                      // Compare W0 to 0.
    BEQ str_equals_eq               // Branch to eq if W0 == 0.
    
    B str_equals_loop               // Branch to loop.

str_equals_ne:
    MOV X0, #0                      // Move 0 into X0.
    B str_equals_exit               // Branch to exit.

str_equals_eq:
    MOV X0, #1                      // Move 1 into X0.

str_equals_exit:
    LDR X30, [SP], #16              // Pop from stack pointer.
	LDR X29, [SP], #16              // Pop from stack pointer.
    RET                             // Return.

// --------------------------------------------

str_equalsIgnoreCase:
    STR X29, [SP, #-16]!            // Push to stack pointer.
    STR X30, [SP, #-16]!            // Push to stack pointer.
    
    MOV X6, X0                      // Move X0 contents into X6.
    MOV X7, X1                      // Move X1 contents into X7.
    
str_equalsIgnoreCase_topLoop:
    LDRB W0, [X6], #1               // Load W0 with X6 with shift.
    LDRB W1, [X7], #1               // Load W1 with X7 with shift.
    
    CMP W0, #97                     // Compare W0 with 97.
    BLT str_equalsIgnoreCase_midLoop// Branch to midLoop if W0 < 97.
    
    CMP W0, #122                    // Compare W0 with 122.
    BGT str_equalsIgnoreCase_midLoop// Branch to midLoop if W0 < 122.
    
    SUB  W0, W0, #32                // Store W0 - 32 in W0.

str_equalsIgnoreCase_midLoop:   
    CMP W1, #97                     // Compare W1 with 97.
    BLT str_equalsIgnoreCase_botLoop// Branch to botLoop if W0 < 97.
    
    CMP W1, #122                    // Compare W1 with 122.
    BGT str_equalsIgnoreCase_botLoop// Branch to botLoop if W0 < 122.
    
    SUB  W1, W1, #32                // Store W1 - 32 in W1.

str_equalsIgnoreCase_botLoop:
    CMP W0, W1                      // Compare W0 with W1.
    BNE str_equalsIgnoreCase_ne     // to ne if W0 ~= W1.
    
    CMP W0, #0                      // Compare W0 to 0.
    BEQ str_equalsIgnoreCase_eq     // Branch to eq if W0 == 0.
    
    B str_equalsIgnoreCase_topLoop  // Branch to loop.
    
str_equalsIgnoreCase_ne:
    MOV X0, #0                      // Move 0 into X0.
    B str_equalsIgnoreCase_exit     // Branch to exit.

str_equalsIgnoreCase_eq:
    MOV X0, #1                      // Move 1 into X0.

str_equalsIgnoreCase_exit:
    LDR X30, [SP], #16              // Pop from stack pointer.
	LDR X29, [SP], #16              // Pop from stack pointer.
    RET                             // Return.
    
// --------------------------------------------

str_copy:
    STR X29, [SP, #-16]!            // Push to stack pointer.
	STR X30, [SP, #-16]!            // Push to stack pointer.
    
    STR X0, [SP, #-16]!             // Push X0 to stack pointer.
    
    BL str_length1                  // Branch and link to str_length1.
    ADD X0, X0, #1                  // Store X0 + 1 into X0.
    
    BL malloc                       // Branch and link to malloc.
    MOV X1, X0                      // Move X0 into X1.
    
    LDR X6, [SP], #16               // Pop from stack pointer int X6.
    
str_copy_loop:
    LDRB W7, [X6], #1               // Load W7 with X6 with shift.
    STRB W7, [X1], #1               // Store W7 into what's in X0.
    
    CMP W7, #0                      // Compare W1 to 0.
    BEQ str_copy_exit               // Branch to exit if W0 == 0.
    
    B str_copy_loop               // Branch to loop.

str_copy_exit:
    LDR X30, [SP], #16              // Pop from stack pointer.
	LDR X29, [SP], #16              // Pop from stack pointer.
    RET                             // Return.

// --------------------------------------------

str_substring_1:
    STR X29, [SP, #-16]!            // Push to stack pointer.
	STR X30, [SP, #-16]!            // Push to stack pointer.
    
    STR X0, [SP, #-16]!             // Push X0 to stack pointer.
    STR X1, [SP, #-16]!             // Push X1 to stack pointer.
    STR X2, [SP, #-16]!             // Push X2 to stack pointer.
    
    BL str_length1                  // Branch and link to str_length1.
    ADD X0, X0, #1                  // Store X0 + 1 into X0.
    
    BL malloc                       // Branch and link to malloc.
    MOV X1, X0                      // Move X0 into X1.
    
    MOV X5, #0                      // Move 0 into X5.
    LDR X4, [SP], #16               // Pop from stack pointer int X4.
    LDR X3, [SP], #16               // Pop from stack pointer int X3.
    LDR X2, [SP], #16               // Pop from stack pointer int X2.
    
str_substring_1_toploop:
    LDRB W6, [X2], #1               // Load W6 with X2 with shift.
    
    CMP X3, X5                      // Compare X3 and X5.
    ADD X5, X5, #1                  // Store X5 + 1 into X5.
    BGT str_substring_1_botloop     // Branch to botloop if X5 > X3.
    
    STRB W6, [X1], #1               // Store W6 into what's in X1.

str_substring_1_botloop:
    CMP X5, X4                      // Compare X5 and X2.
    BEQ str_substring_1_exit        // Branch to exit if X5 == X2.
    
    CMP W5, #0                      // Compare W5 to 0.
    BEQ str_substring_1_exit        // Branch to exit if W5 == 0.
    
    B str_substring_1_toploop       // Branch to loop.

str_substring_1_exit:
    LDR X30, [SP], #16              // Pop from stack pointer.
	LDR X29, [SP], #16              // Pop from stack pointer.
    RET                             // Return.

// --------------------------------------------

str_substring_2:
    STR X29, [SP, #-16]!            // Push to stack pointer.
	STR X30, [SP, #-16]!            // Push to stack pointer.
    
    STR X0, [SP, #-16]!             // Push X0 to stack pointer.
    STR X1, [SP, #-16]!             // Push X1 to stack pointer.
    
    BL str_length1                  // Branch and link to str_length1.
    ADD X0, X0, #1                  // Store X0 + 1 into X0.
    
    BL malloc                       // Branch and link to malloc.
    MOV X1, X0                      // Move X0 into X1.
    
    MOV X5, #0                      // Move 0 into X5.
    LDR X3, [SP], #16               // Pop from stack pointer int X3.
    LDR X2, [SP], #16               // Pop from stack pointer int X2.
    
str_substring_2_toploop:
    LDRB W6, [X2], #1               // Load W6 with X2 with shift.
    
    CMP X5, X3                      // Compare X5 and X3.
    ADD X5, X5, #1                  // Store X5 + 1 into X5.
    BLT str_substring_2_botloop     // Branch to botloop if X5 > X3.
    
    STRB W6, [X1], #1               // Store W6 into what's in X1.

str_substring_2_botloop:
    CMP W6, #0                      // Compare W5 to 0.
    BEQ str_substring_2_exit        // Branch to exit if W5 == 0.
    
    B str_substring_2_toploop       // Branch to loop.

str_substring_2_exit:
    LDR X30, [SP], #16              // Pop from stack pointer.
	LDR X29, [SP], #16              // Pop from stack pointer.
    RET                             // Return.

// --------------------------------------------

str_charAt:
    STR X29, [SP, #-16]!            // Push to stack pointer.
	STR X30, [SP, #-16]!            // Push to stack pointer.
    
    MOV X6, X0                      // Move X0 contents into X6.
    MOV X2, #0                      // Move 0 into X1.
    
str_charAt_loop:
    LDRB W0, [X6], #1               // Load W0 with X6 with shift.
    
    CMP X2, X1                      // Compare X2 and X1.
    ADD X2, X2, #1                  // Store X2 + 1 into X2.
    BEQ str_charAt_exit             // Branch to exit if X1 == X2.
    
    B str_charAt_loop               // Branch to loop.

str_charAt_exit:
    LDR X30, [SP], #16              // Pop from stack pointer.
	LDR X29, [SP], #16              // Pop from stack pointer.
    RET                             // Return.

// --------------------------------------------

str_startsWith_1:
    STR X29, [SP, #-16]!            // Push to stack pointer.
	STR X30, [SP, #-16]!            // Push to stack pointer.
    
    MOV X5, #0                      // Move 0 into X5.
    MOV X6, X0                      // Move X0 contents into X6.

str_startsWith_1_skip:
    LDRB W0, [X6], #1               // Load W0 with X6 with shift.
    ADD X5, X5, #1                  // Store X5 + 1 in X5.
    
    CMP X5, X1                      // Compare X5 with X1.
    BNE str_startsWith_1_skip       // Branch to loop if X5 == X1.

    MOV X0, X6                      // Move X6 to X0.
    STR X6, [SP, #-16]!             // Push X2 to stack pointer.
    STR X2, [SP, #-16]!             // Push X1 to stack pointer.

    BL str_length1                  // Branch and link to str_length1.
    MOV X4, X0                      // Move X0 into X4.
    
    LDR X6, [SP], #16               // Pop from stack pointer into X0.
    LDR X7, [SP], #16               // Pop from stack pointer into X1.

str_startsWith_1_loop:
    LDRB W0, [X6], #1               // Load W0 with X6 with shift.
    LDRB W1, [X7], #1               // Load W1 with X7 with shift.
    
    CMP W0, W1                      // Compare W0 with W1.
    BNE str_startsWith_1_ne         // Branch to ne if W0 ~= W1.
    
    CMP X4, X5                      // Compare W0 with W1.
    BEQ str_startsWith_1_eq         // Branch to eq if X4 == X5.
    
    CMP W0, #0                      // Compare W0 to 0.
    BEQ str_startsWith_1_eq         // Branch to eq if W0 == 0.
    
    ADD X4, X4, #1                  // Store X4 + 1 in X4.
    
    B str_startsWith_1_loop         // Branch to loop.

str_startsWith_1_ne:
    MOV X0, #0                      // Move 0 into X0.
    B str_startsWith_1_exit         // Branch to exit.

str_startsWith_1_eq:
    MOV X0, #1                      // Move 1 into X0.

str_startsWith_1_exit:
    LDR X30, [SP], #16              // Pop from stack pointer.
	LDR X29, [SP], #16              // Pop from stack pointer.
    RET                             // Return.

// --------------------------------------------

str_startsWith_2:
    STR X29, [SP, #-16]!            // Push to stack pointer.
	STR X30, [SP, #-16]!            // Push to stack pointer.
    
    MOV X5, #0                      // Move 0 into X5.
    STR X0, [SP, #-16]!             // Push X0 to stack pointer.
    STR X1, [SP, #-16]!             // Push X1 to stack pointer.
    
    MOV X0, X1                      // Move X1 contents into X0.
    BL str_length1                  // Branch and link to str_length1.
    MOV X4, X0                      // Move X0 into X4.
    
    LDR X7, [SP], #16               // Pop from stack pointer into X7.
    LDR X6, [SP], #16               // Pop from stack pointer into X6.

str_startsWith_2_loop:
    LDRB W0, [X6], #1               // Load W0 with X6 with shift.
    LDRB W1, [X7], #1               // Load W1 with X7 with shift.
    
    CMP W0, W1                      // Compare W0 with W1.
    BNE str_startsWith_2_ne         // Branch to ne if W0 ~= W1.
    
    ADD X5, X5, #1                  // Store X5 + 1 in X5.
    
    CMP X4, X5                      // Compare W0 with W1.
    BEQ str_startsWith_2_eq         // Branch to eq if X4 == X5.
    
    B str_startsWith_2_loop         // Branch to loop.

str_startsWith_2_ne:
    MOV X0, #0                      // Move 0 into X0.
    B str_startsWith_2_exit         // Branch to exit.

str_startsWith_2_eq:
    MOV X0, #1                      // Move 1 into X0.

str_startsWith_2_exit:
    LDR X30, [SP], #16              // Pop from stack pointer.
	LDR X29, [SP], #16              // Pop from stack pointer.
    RET                             // Return.

// --------------------------------------------

str_endsWith:
    STR X29, [SP, #-16]!            // Push to stack pointer.
	STR X30, [SP, #-16]!            // Push to stack pointer.
    
    MOV X5, #0                      // Move 0 into X5.
    STR X0, [SP, #-16]!             // Push X0 to stack pointer.
    STR X1, [SP, #-16]!             // Push X1 to stack pointer.
    
    BL str_length1                  // Branch and link to str_length1.
    MOV X3, X0                      // Move X0 into X3.
    
    LDR X0, [SP], #16               // Pop from stack pointer into X7.
    STR X0, [SP, #-16]!             // Push X1 to stack pointer.
    BL str_length1                  // Branch and link to str_length1.
    MOV X4, X0                      // Move X0 into X4.
    
    SUB X1, X3, X4                  // Store X3 - X4 into X1.
    
    LDR X2, [SP], #16               // Pop from stack pointer into X7.
    LDR X6, [SP], #16               // Pop from stack pointer into X2.

str_endsWith_skip:
    LDRB W0, [X6], #1               // Load W0 with X6 with shift.
    ADD X5, X5, #1                  // Store X5 + 1 in X5.
    
    CMP X5, X1                      // Compare X5 with X1.
    BNE str_endsWith_skip           // Branch to loop if X5 == X1.

    MOV X0, X6                      // Move X6 to X0.
    STR X6, [SP, #-16]!             // Push X2 to stack pointer.
    STR X2, [SP, #-16]!             // Push X1 to stack pointer.

    BL str_length1                  // Branch and link to str_length1.
    MOV X4, X0                      // Move X0 into X4.
    
    LDR X6, [SP], #16               // Pop from stack pointer into X0.
    LDR X7, [SP], #16               // Pop from stack pointer into X1.

str_endsWith_loop:
    LDRB W0, [X6], #1               // Load W0 with X6 with shift.
    LDRB W1, [X7], #1               // Load W1 with X7 with shift.
    
    CMP W0, W1                      // Compare W0 with W1.
    BNE str_endsWith_ne         // Branch to ne if W0 ~= W1.
    
    CMP X4, X5                      // Compare W0 with W1.
    BEQ str_endsWith_eq         // Branch to eq if X4 == X5.
    
    CMP W0, #0                      // Compare W0 to 0.
    BEQ str_endsWith_eq         // Branch to eq if W0 == 0.
    
    ADD X4, X4, #1                  // Store X4 + 1 in X4.
    
    B str_endsWith_loop         // Branch to loop.

str_endsWith_ne:
    MOV X0, #0                      // Move 0 into X0.
    B str_endsWith_exit         // Branch to exit.

str_endsWith_eq:
    MOV X0, #1                      // Move 1 into X0.

str_endsWith_exit:
    LDR X30, [SP], #16              // Pop from stack pointer.
	LDR X29, [SP], #16              // Pop from stack pointer.
    RET                             // Return.

    .end
