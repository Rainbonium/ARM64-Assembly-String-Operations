// Purpose    : Perform multiple string functions on 3 user defined strings

    .data
        // For the header
        szAuthor:  .asciz "Authors : ************, **************"
        szDate:    .asciz "Date    : **/**/****"
        szProgram: .asciz "Program : ******"
        // End header
        szStr1: .skip  20       // Stores the first user input string
        szStr2: .skip  20       // Stores the second user input string
        szStr3: .skip  20       // Stores the third user input string 
        sz0:    .asciz "Input a string: "
        sz1a:   .asciz "1. s1.length() =  "
        sz1b:   .asciz "   s2.length() =  "
        sz1c:   .asciz "   s3.length() =  "
        sz2:    .asciz "2. String_equals(s1,s3) = "
        sz3:    .asciz "3. String_equals(s1,s1) = "
        sz4:    .asciz "4. String_equalsIgnoreCase(s1,s3) = "
        sz5:    .asciz "5. String_equalsIgnoreCase(s1,s2) = "
        sz6a:   .asciz "6. s4 = String_copy(s1)\n   s1 = "
        sz6b:   .asciz "   s4 = "
        sz7:    .asciz "7. String_substring_1(s3,4,14) = "
        sz8:    .asciz "8. String_substring_2(s3,7) = "
        sz9:    .asciz "9. String_charAt(s2,4) = "
        sz10:   .asciz "10. String_startsWith_1(s1,11,'hat.') = "
        sz11:   .asciz "11. String_startsWith_2(s1,'Cat') = "
        sz12:   .asciz "12. String_endsWith(s1,'in the hat.') = "
        sz13:   .asciz "13. String_indexOf_1(s2,'g') = "
        sz14:   .asciz "14. String_indexOf_2(s2,'g',9) = "
        sz15:   .asciz "15. String_indexOf_3(s2,'eggs') = "
        sz16:   .asciz "16. String_lastIndexOf_1(s2,'g') = "
        sz17:   .asciz "17. String_lastIndexOf_2(s2,'g',6) = "
        sz18:   .asciz "18. String_lastIndexOf_3(s2,'egg') = "
        sz19:   .asciz "19. String_replace(s1,'a','o') = "
        sz20:   .asciz "20. String_toLowerCase(s1) = "
        sz21:   .asciz "21. String_toUpperCase(s1) = "
        sz22:   .asciz "22. String_concat(s1, ' ')\n"
        sz23:   .asciz "    String_concat(s1, s2) = "
        szITH:  .asciz "in the hat."
        ptrStr: .quad  0        // Pointer used for pointing to malloc'd returns
        ptrTmp: .quad  0        // For freeing when multiple malloc'd strings are in play
        szHat:  .asciz "hat."
        szEggs: .asciz "eggs"
        szCat:  .asciz "Cat"
        szEgg:  .asciz "egg"
        szSpace:.asciz " "      // For str_concat
        szTmp:  .skip  5        // For converting int64 to ascii
        chNl:   .byte  10       // Newline byte. '\n'
        chDq:   .byte  34       // Double quotes. '\"'
        chSq:   .byte  39       // Single quotes. '\''
        chTmp:  .byte  0        // Used to print char.
        buffer: .quad  0        // Variables are being overwritten and I don't know why so I hope this helps

    .global main              // Provides program main address to the linker

    .text
main:

    // Output the header
    // Author
    ldr  X0, =szAuthor      // Load the address for the author string into X0
    bl   putstring          // Output the author string
    ldr  X0, =chNl          // Load the address of the "\n" character into X0
    bl   putch              // Print the character

    // Date
    ldr  X0, =szDate        // Load the address for the date string into X0
    bl   putstring          // Output the date string
    ldr  X0, =chNl          // Load the address of the "\n" character into X0
    bl   putch              // Print the character

    // Program
    ldr  X0, =szProgram     // Load the address for the program string into X0
    bl   putstring          // Output the program string
    ldr  X0, =chNl          // Load the address of the "\n" character into X0
    bl   putch              // Print the character

    // Blank line
    ldr  X0, =chNl          // Load the address of the "\n" character into X0
    bl   putch              // Print the character

    // End outputting header

    // Get user input 
    ldr  X0, =sz0               // Load the prompt into X0
    bl   putstring              // Print the prompt
    ldr  X0, =szStr1            // Load the address for the string into X0
    mov  X1, #20                // Move the maximum allowed bytes into X1
    bl   getstring              // Get user input
    ldr  X0, =sz0               // Load the prompt into X0
    bl   putstring              // Print the prompt
    ldr  X0, =szStr2            // Load the address for the string into X0
    mov  X1, #20                // Move the maximum allowed bytes into X1
    bl   getstring              // Get user input
    ldr  X0, =sz0               // Load the prompt into X0
    bl   putstring              // Print the prompt
    ldr  X0, =szStr3            // Load the address for the string into X0
    mov  X1, #20                // Move the maximum allowed bytes into X1
    bl   getstring              // Get user input
    
    // Line break
    ldr  X0, =chNl              // Load the address of the null
    bl   putch                  // Print the char

    //1a
    ldr  X0, =sz1a              // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr1            // Load the address of the string into X0
    bl   str_length1            // Find the length of the string
    ldr  X1, =szTmp             // Load an address into X1 to store the converted int
    bl   int64asc               // Branch and link to int64asc
    ldr  X0, =szTmp             // Load the address of temporary string into X0
    bl   putstring              // Branch and link to putstring
    ldr  X0, =chNl              // Load the address of the null
    bl   putch                  // Print the char
    //1b 
    ldr  X0, =sz1b              // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr2            // Load the address of the string into X0
    bl   str_length1            // Find the length of the string
    ldr  X1, =szTmp             // Load an address into X1 to store the converted int
    bl   int64asc               // Branch and link to int64asc
    ldr  X0, =szTmp             // Load the address of temporary string into X0
    bl   putstring              // Branch and link to putstring
    ldr  X0, =chNl              // Load the address of the null
    bl   putch                  // Print the char
    //1c
    ldr  X0, =sz1c              // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr3            // Load the address of the string into X0
    bl   str_length1            // Find the length of the string
    ldr  X1, =szTmp             // Load an address into X1 to store the converted int
    bl   int64asc               // Branch and link to int64asc
    ldr  X0, =szTmp             // Load the address of temporary string into X0
    bl   putstring              // Branch and link to putstring
    ldr  X0, =chNl              // Load the address of the null
    bl   putch                  // Print the char
    ldr  X0, =chNl              // Load the address of the null
    bl   putch                  // Print the char
    
    //2
    ldr  X0, =sz2               // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr1            // Load the address of the string into X0
    ldr  X1, =szStr3            // Load the address of another string into X1 
    bl   str_equals             // Compare the two strings
    bl   str_printBool          // Print true or false
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //3
    ldr  X0, =sz3               // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr1            // Load the address of the string into X0
    ldr  X1, =szStr1            // Load the address of another string into X1 
    bl   str_equals             // Compare the two strings
    bl   str_printBool          // Print true or false
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //4
    ldr  X0, =sz4               // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr1            // Load the address of the string into X0
    ldr  X1, =szStr3            // Load the address of another string into X1 
    bl   str_equalsIgnoreCase   // Compare the two strings
    bl   str_printBool          // Print true or false
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    
    //5
    ldr  X0, =sz5               // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr1            // Load the address of the string into X0
    ldr  X1, =szStr2            // Load the address of another string into X1 
    bl   str_equalsIgnoreCase   // Compare the two strings
    bl   str_printBool          // Print true or false
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //6
    ldr  X0, =sz6a              // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr1            // Load the address of the string into X0
    bl   putstring              // Print the string
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =sz6b              // Load the address of the disp string into X0
    bl   putstring              // Print the string
    
    ldr  X0, =szStr1            // Load the address of the string
    bl   str_copy               // Copy the string
    
    ldr  X1, =ptrStr            // Load the address of a pointer into X0
    str  X0, [X1]               // Store the address of the new string into ptrStr
    bl   putstring              // Print the copied string
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =ptrStr            // Load the address of the pointer into X0
    ldr  X0, [X0]               // Get the address of the new string
    bl   free                   // Free the memory

    //7
    ldr  X0, =sz7               // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr3            // Load the address of the string into X0
    mov  X1, #4                 // Move the starting index into X1
    mov  X2, #14                // Move the last index into X2
    bl   str_substring_1        // Find the substring
    ldr  X1, =ptrStr            // Load the address of a pointer into X1
    str  X0, [X1]               // Store the address of the new memory into the pointer
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch
    ldr  X0, =ptrStr            // Load the address of the pointer into X0
    ldr  X0, [X0]               // Dereference the address of the substring
    bl   putstring              // Output the substring
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch  
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =ptrStr            // Load the address of the pointer into X0
    ldr  X0, [X0]               // Get the address of the new string
    bl   free                   // Free the memory

    //8
    ldr  X0, =sz8               // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr3            // Load the address of the string into X0
    mov  X1, #7                 // Move the starting index into X1
    bl   str_substring_2        // Find the substring
    ldr  X1, =ptrStr            // Load the address of a pointer into X1
    str  X0, [X1]               // Store the address of the new memory into the pointer
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch
    ldr  X0, =ptrStr            // Load the address of the pointer into X0
    ldr  X0, [X0]               // Dereference the address of the substring
    bl   putstring              // Output the substring
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch  
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =ptrStr            // Load the address of the pointer into X0
    ldr  X0, [X0]               // Get the address of the new string
    bl   free                   // Free the memory
    
    //9
    ldr  X0, =sz9               // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =chSq              // Load the double quote character into X0
    bl   putch                  // Branch to putch
    ldr  X0, =szStr2            // Load the address of the string into X0
    mov  X1, #4                 // Move the desired index into X1
    bl   str_charAt             // Find the character
    ldr  X1, =chTmp             // Load X1 with the address to chTmp
    str  X0, [X1]               // Store X0 into X1 value.
    ldr  X0, =chTmp             // Load X1 with the address to chTmp
    bl   putch                  // Output the character
    ldr  X0, =chSq              // Load the double quote character into X0
    bl   putch                  // Branch to putch  
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //10
    ldr  X0, =sz10              // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr1            // Load the address of the string into X0
    mov  X1, #11                // Move the starting index into X1
    ldr  X2, =szHat             // Load the substring being checked for into X2
    bl   str_startsWith_1       // Check if it starts with the substring at a specified index
    bl   str_printBool          // Output 
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //11
    ldr  X0, =sz11              // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr1            // Load the address of the string into X0
    ldr  X1, =szCat             // Load the substring being checked for into X2
    bl   str_startsWith_2       // Check if it starts with the substring at a specified index
    bl   str_printBool          // Output
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //12
    ldr  X0, =sz12              // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr1            // Load the address of the first string into X0
    ldr  X1, =szITH             // Load the substring being checked for into X1
    bl   str_endsWith           // Check if the string ends with the given substring
    bl   str_printBool          // Output
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    
    //13
    ldr  X0, =sz13              // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr2            // Load the address of string 2 into X0
    mov  X1, #'g                // Move 'g' into X1
    bl   str_indexOf_1          // Branch and link to str_indexOf_1
    ldr  X1, =szTmp             // Load the address of temporary string into X1
    bl   int64asc               // Convert integer to ascii
    ldr  X0, =szTmp             // Load the address of temporary string into X1
    bl   putstring              // Print the string
    ldr  X0, =chNl              // Load the address of newline into X0
    bl   putch                  // Print the char
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //14
    ldr  X0, =sz14              // Load the address of the disp string into X0
    bl   putstring              // Print the string
    ldr  X0, =szStr2            // Load the address of string 2 into X0
    mov  X1, #'g                // Move 'g' into X1
    mov  X2, #9                 // Move 9 into X2
    bl   str_indexOf_2          // Branch and link to str_indexOf_2
    ldr  X1, =szTmp             // Load the address of the temp string into X1
    bl   int64asc               // Convert int to ascii.
    ldr  X0, =szTmp             // Load the address of the temp string into X0
    bl   putstring              // Print string
    ldr  X0, =chNl              // Load the address of newline into X0
    bl   putch                  // Print the char
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //15
    ldr  X0, =sz15              // Load the address of the disp string into X0
    bl   putstring              // Print string
    ldr  X0, =szStr2            // Load the address of the second string into X0
    ldr  X1, =szEggs            // Load the address of the search string into X1
    bl   str_indexOf_3          // Branch and link to str_indexOf_3
    ldr  X1, =szTmp             // Load the address of the temp string into X1
    bl   int64asc               // Convert int to ascii
    ldr  X0, =szTmp             // Load the address of the temp string into X0
    bl   putstring              // Print string   
    ldr  X0, =chNl              // Load the address of newline into X0
    bl   putch                  // Print the char
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //16
    ldr  X0, =sz16              // Load the address of the disp string into X0
    bl   putstring              // Print string
    ldr  X0, =szStr2            // Load the address of second string into X0
    mov  X1, #'g                // Move 'g' into X1
    bl   str_lastIndexOf_1      // Branch and link to str_lastIndexOf_1
    ldr  X1, =szTmp             // Load the address of temp string into X1
    bl   int64asc               // Convert int to ascii
    ldr  X0, =szTmp             // Load the address of temp string into X0
    bl   putstring              // Print string
    ldr  X0, =chNl              // Load the address of the newline into X0
    bl   putch                  // Print the char
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line
    
    //17
    ldr  X0, =sz17              // Load the address of the disp string into X0
    bl   putstring              // Print string
    ldr  X0, =szStr2            // Load the address of second string into X0
    mov  X1, #'g                // Move 'g' into X1
    mov  X2, #9                 // Move 9 into X2
    bl   str_lastIndexOf_2      // Branch and link to str_lastIndexOf_2
    ldr  X1, =szTmp             // Load the address of temp string into X1
    bl   int64asc               // Convert int to ascii
    ldr  X0, =szTmp             // Load the address of temp string into X0
    bl   putstring              // Print string
    ldr  X0, =chNl              // Load the address of newline into X0
    bl   putch                  // Print the char
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //18
    ldr  X0, =sz18              // Load the address of the disp string into X0
    bl   putstring              // Print string
    ldr  X0, =szStr2            // Load the address of the second string into X0
    ldr  X1, =szEgg             // Load the address of the search string into X1
    bl   str_lastIndexOf_3      // Branch and link to str_lastIndexOf_3
    ldr  X1, =szTmp             // Load the address of the temp string into X1
    bl   int64asc               // Convert int to ascii
    ldr  X0, =szTmp             // Load the address of the temp string into X0
    bl   putstring              // Print string
    ldr  X0, =chNl              // Load the address of newline into X0
    bl   putch                  // Print the char
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //19
    ldr  X0, =sz19              // Load the address of the disp string into X0
    bl   putstring              // Print string
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch
    ldr  X0, =szStr1            // Load the address of the first string into X0
    mov  X1, #'a                // Move 'a' into X1
    mov  X2, #'o                // Move 'o' into X2
    bl   str_replace            // Branch and link to str_replace
    ldr  X1, =ptrStr            // Load the address of the pointer into X1
    str  X0, [X1]               // Store X0 into X1 value
    bl   putstring              // Print string
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch
    ldr  X0, =chNl              // Load the address of newline into X0
    bl   putch                  // Print the char
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //20
    ldr  X0, =sz20              // Load the address of the disp string into X0
    bl   putstring              // Print string
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch
    ldr  X0, =ptrStr            // Load the address of the pointer to the new string into X0
    ldr  X0, [X0]               // Dereference the pointer
    mov  X19, X0                // Save this first new string's address so that it can be freed 
    bl   str_toLower            // Branch and link to str_toLower
    ldr  X1, =ptrStr            // Load the address of the pointer to the new string into X1
    str  X0, [X1]               // Store the new string's address into the pointer
    bl   putstring              // Print string
    mov  X0, X19                // Move X19 into X0
    bl   free                   // Free dynamic memory
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch         
    ldr  X0, =chNl              // Load the address of newline into X0
    bl   putch                  // Print the char
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //21
    ldr  X0, =sz21              // Load the address of the disp string into X0
    bl   putstring              // Print string
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch
    ldr  X0, =ptrStr            // Load the address of the pointer to the new string into X0
    ldr  X0, [X0]               // Dereference the pointer
    mov  X19, X0                // Move X0 into X19
    bl   str_toUpper            // Branch and link to str_toUpper
    ldr  X1, =ptrStr            // Load the address of the pointer to the new string into X1
    str  X0, [X1]               // Store the new string's address into the pointer
    bl   putstring              // Print string
    mov  X0, X19                // Move X19 into X0
    bl   free                   // Free dynamic memory
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch
    ldr  X0, =chNl              // Load the address of newline into X0
    bl   putch                  // Print the char
    ldr  X0, =chNl              // Load the new line
    bl   putch                  // Output a new line

    //22
    ldr  X0, =sz22              // Load the address of the disp string 1 into X0
    bl   putstring              // Print string
    ldr  X0, =sz23              // Load the address of the disp string 2 into X0
    bl   putstring              // Print string
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch
    ldr  X0, =ptrStr            // Load the address of the pointer to the new string into X0
    ldr  X0, [X0]               // Dereference the pointer
    mov  X19, X0                // Save this first new string's address so that it can be freed 
    ldr  X1, =szSpace           // Load the address of the space string into X1
    bl   str_concat             // Branch and link to str_concat
    ldr  X1, =ptrStr            // Load the address of the string pointer into X1
    str  X0, [X1]               // Store X0 into X1 value
    mov  X0, X19                // Move X19 into X0
    bl   free                   // Free dynamic memory
    ldr  X0, =ptrStr            // Load the address of the string pointer into X0
    ldr  X0, [X0]               // Dereference the pointer
    mov  X19, X0                // Save this first new string's address so that it can be freed 
    ldr  X1, =szStr2            // Load the address of the second string into X1
    bl   str_concat             // Branch and link to str_concat
    ldr  X1, =ptrStr            // Load the address of the pointer into X1
    str  X0, [X1]               // Store X0 into X1 value
    bl   putstring              // Print string
    mov  X0, X19                // Move X19 into X0
    bl   free                   // Free dynamic memory
    ldr  X0, =ptrStr            // Load the address of the pointer into X0
    ldr  X0, [X0]               // Load X0 value into X0
    bl   free                   // Free dynamic memory
    ldr  X0, =chDq              // Load the double quote character into X0
    bl   putch                  // Branch to putch
    ldr  X0, =chNl              // Load the address of newline into X0
    bl   putch                  // Print the char
    ldr  X0, =chNl              // Load the address of newline into X0
    bl   putch                  // Print the char

    // Setup the parameters to exit the program
    // and then call Linux to do it.

exit:
    mov X0, #0              // use 0 return code
    mov X8, #93             // Service command code 93 terminates this program
    svc 0                   // Call linux to terminate the program
    .end
