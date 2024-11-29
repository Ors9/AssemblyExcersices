# Name: Or Saban
# Title: Maman 11 question 5
# ID: 208248716
# Date: 8.12.24
# File name: Maman11Question5.asm
# Description: 
# This program performs various operations on an array of integers,
# including printing signed and unsigned values, calculating sums,
# and computing differences. The user is prompted to select a base
# (between 2 and 10), and the array operations are performed in
# the specified base.
#
# Main Operations:
# A. Print array values as signed integers in the chosen base.
# B. Print array values as unsigned integers in the chosen base.
# C. Compute the sum of signed integers in the array.
# D. Compute the sum of unsigned integers in the array.
# E. Print the difference between pairs of signed integers.
# F. Print the sum of unsigned differences.

####################----------- Data Segment--------------- ##################
.data
# Messages for user prompts and outputs
user_message: .asciiz "In what base to print  2-10?"   # Prompt user to select base
msgB: .asciiz "print_array_sign"                      # Label for signed array print
msgC: .asciiz "print_array_unsign"                   # Label for unsigned array print
msgC2: .asciiz "sum_sign"                            # Label for signed sum calculation
msgD: .asciiz "sum_unsign"                           # Label for unsigned sum calculation
msgE: .asciiz "print_dif_sign"                       # Label for signed differences
msgG: .asciiz "print_dif_unsign"                     # Label for unsigned differences

# Data structures
array: .word 0, 20, -200, 50, -600, 16, -17, 122, 12, -5   # Array of integers for processing

####################------ Code Segment -------------##################
.text
main:
# Purpose: Main function to handle user input and call sub-functions for array operations.
# Input: None (reads integer input from the user).
# Output: Executes all array operations and prints results.
# Logic:
# 1. Prompt user for a valid base (between 2 and 10).
# 2. Call sub-functions to:
#    a. Print array as signed values.
#    b. Print array as unsigned values.
#    c. Compute and print sums (signed and unsigned).
#    d. Compute and print differences (signed and unsigned).


#####----------Maman 11 Q5 A----------------#######################
incorrect_integer:
   # --------- Print input message --------- #
    la $a0, user_message          # Load address of input message into $a0
    li $v0, 4                     # Syscall to print string
    syscall                       # Execute syscall to print message

    # --------- Read an integer from the user --------- #
    li $v0, 5                     # Syscall code for reading integer
    syscall                       # Execute syscall to read integer
    move $t0, $v0                 # Store the input integer temporarily in $t0

    # --------- Check if integer is in the range [2, 10] --------- #
    blt $t0, 2, incorrect_integer # If integer < 2, branch to incorrect_integer
    bgt $t0, 10, incorrect_integer # If integer > 10, branch to incorrect_integer

    # --------- Save valid integer to $a1 and push to stack --------- #
    move $a1, $t0                 # Move valid integer to $a1 for further use
    addi $sp, $sp, -4             # Adjust stack pointer to allocate space
    sw $a1, 0($sp)                # Store $a1 on the stack
   

###############################Call Question B #####################################
    # --------- Print Original Message ---------
    la $a0, msgB      # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- CALL Q B ---------
    la $a2, array 	          #array address
   
    jal print_array_sign


###############################Call Question C #####################################
  
    # --------- Print Original Message ---------
    la $a0, msgC      # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- CALL Q C ---------
    la $a2, array 	          #array address
    jal print_array_unsign
    


###############################Call Question D #####################################
  
    # --------- Print Original Message ---------
    la $a0, msgC2      # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- CALL Q D ---------
    la $a2, array 	          #array address
    jal sum_sign
    
 
    
############################### Call Question E #####################################
  
    # --------- Print Original Message ---------
    la $a0, msgD           # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- CALL Q E ---------
    la $a2, array 	          #array address
    jal sum_unsign
     

###############################Call Question F #####################################
  
    # --------- Print Original Message ---------
    la $a0, msgE           # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- CALL Q F ---------
    la $a2, array 	          #array address
    jal print_dif_sign
    

###############################Call Question G #####################################
  
    # --------- Print Original Message ---------
    la $a0, msgG           # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- CALL Q G ---------
    la $a2, array 	          #array address
    jal print_sum_unsign
    
    
#######################################################################

   
# --------- Exit Program --------- #
finish:
    li $v0, 10         # Exit syscall
    syscall
	
#---------Print_base function--------------
print_base:
# Purpose: Print a number in a specific base (signed or unsigned),if the number negative print the 
# absoulut value and add - at start
# Inputs:
#   $a1 - The base to use for conversion (2-10).
#   $a2 - The number to convert and print.
#   $a3 - Sign flag (1 for signed, 0 for unsigned).
# Outputs: The number is printed in the specified base.
# Logic:
# 1. Check if the number is negative (signed case only).
# 2. Convert the number to the specified base and store the digits on a stack.
# 3. Print digits in reverse order by popping the stack.

    #----saving in stack-----------
    addiu $sp ,$sp ,-16        #Adjust stack pointer
    sw $ra , 12($sp)          #Save return address
    sw $a3 , 8($sp)           #Save $a3 The number in the stack
    sw $a2 ,4($sp)           #Save $a2 The number in the stack
    sw $a1 ,0($sp)	     #save $a1 The base in the stack
    
    #------loading arguments----------
    lw $a3 , 8($sp)          #loading $a3 sign or unsign
    lw $a2 ,4($sp)          #loading  $a2 the number    
    lw $a1 ,0($sp)          #loading  $a1 the base     
    li $t1 ,0x0             #initilize stack pointer
    li $t4 , 0              #initialize counter to 0
    blt $a2 , 0 ,negative_case #check if the number is negative
    beq $a2 , 0 , loop         #edge case 0
    bne $a1 , 2 , loop_base_not_2
    j loop
    

    
negative_case:
    beq $a3 , 0 , negative_unsign     #if we in unsign case
    #----negative with sign---
    xori $a2, $a2, 0xFFFFFFFF  # Invert all bits in $a2  
    addi $a2 , $a2 , 1 #Add in lsb 1
    li $v0, 11         # Syscall code for printing a character
    li $a0, 45         # ASCII code for '-'
    syscall            # Print '-'
    bne $a1 , 2 , loop_base_not_2
    j loop

negative_unsign:
    addi $a2, $a2, 0xFFFFFFFF  # Invert all bits in $a2  
    addi $a2 , $a2 , 1 #Add in lsb 1    

loop_base_not_2:
     beq $a2 , 0x0 , print_the_stack 

    
loop:
     beq $t4 , 31 , print_the_stack # Exit after 32 iterations
    divu $a2 , $a1      #assume the base != 0 
    mfhi $t2               # high a2 mod a1
    mflo $a2               #low a2/a1
    
    #-------Save in the stack-------------
    addiu $sp, $sp, -4          #Make room for number
    sw $t2, 0($sp)             #Save in the stack
    addi $t1,$t1,0x1      #counter of the stack ++
    addi $t4 , $t4 , 0x1  #counter ++
    bne $a1 , 2 , loop_base_not_2
    j loop  
	
print_the_stack:
    beq $t1 , 0x0 , done_print #check if the counter arrive to 0	
    
    # Load the value from the stack
    lw $a0, 0($sp)       # Load the top value of the stack into $a0 for printing
    
    # Print the value
    li $v0, 1           # Syscall code for printing an integer
    syscall
    
    # Move the stack pointer up to "pop" the value from the stack
    addi $sp, $sp, 4           # Increment $sp by 4 to pop the top item from the stack
    addi $t1 , $t1 ,-1   #Decrease the stack pointer
    
    
    j print_the_stack
    
done_print:	  	  
    #----Restore Registers and Return------
    lw $ra, 12($sp)            # Restore return address
    lw $a3, 8($sp)            # Restore $a3 (sign)
    lw $a1, 0($sp)            # Restore $a1 (base)
    lw $a2, 4($sp)            # Restore $a2 (number)
    addiu $sp, $sp, 16        # Adjust stack pointer back
    jr $ra                     # Return to caller
	
	
#--------Print_array_sign Q5 B--------------
print_array_sign:
# Purpose: Print all elements of the array as signed integers in a given base.
# Inputs:
#   $a1 - The base to use for conversion.
#   $a2 - The starting address of the array.
# Outputs: Array elements are printed as signed integers in the specified base.
# Logic:
# 1. Loop through all elements of the array (10 elements).
# 2. Call `print_base` for each element with the signed flag set.
# 3. Print a space between elements.
# 4. Print a newline after the array.	
    #----Saving Registers on the Stack-----------
    addiu $sp, $sp, -12      # Adjust stack pointer for 4 words
    sw $ra, 8($sp)           # Save return address
    sw $a2, 4($sp)            # Save $a2 (original array address) on the stack
    sw $a1, 0($sp)            # Save $a1 (base) on the stack
    
    #------Loading Arguments----------
    lw $t2 , 4($sp)            #Load $t2 with the array address
    lw $a1, 0($sp)            # Load $a1 with the base for printing
    li $t4, 10                # Set loop count to 10 (number of elements)
    li $t3, 0                 # Initialize index register (counter) to 0
    li $a3 , 1                #flag for sign


inside_loop:
    beq $t3, $t4, end_loop    # If counter equals 10, exit loop
    lw $a2, 0($t2)            # Load the current element of the array into $a2

    
    # Save $t2 on the stack temporarily before calling print_base
    addiu $sp, $sp, -8        # Adjust stack pointer to make room for $t2
    sw $t2, 0($sp)            # Save $t2 on the stack
    sw $t4 ,4($sp)            #Save $t4 on the stack

    jal print_base            # Call print_base to print the array element with given base
    
    la $a0 ,0x20 #ascii of space
    li $v0 , 11 #code for print char
    syscall

    # Restore $t2 from the stack after print_base
    lw $t2, 0($sp)            # Restore $t2 from the stack
    lw $t4 , 4($sp)             #Resotore $t4 from the stack
    addiu $sp, $sp, 8         # Adjust stack pointer back	
    	
    addi $t3, $t3, 1          # Increment the index (counter)
    addi $t2, $t2, 4          # Move to the next array element (4 bytes forward for word)
    j inside_loop             # Jump back to the start of the loop

end_loop:
    la $a0 ,10 #ascii for newline
    li $v0,11   #print char
    syscall	
    #----Restore Registers from the Stack-----
    lw $a1, 0($sp)            # Restore $a1 (base)
    lw $a2, 4($sp)            # Restore $a2 (array address)
    lw $ra, 8($sp)           # Restore return address
    addiu $sp, $sp, 12        # Adjust stack pointer back

    jr $ra                   # Return to the caller
    
#--------Print_array_usign Q5 C--------------    
print_array_unsign:
# Purpose: Print all elements of the array as unsigned integers in a given base.
# Inputs:
#   $a1 - The base to use for conversion.
#   $a2 - The starting address of the array.
# Outputs: Array elements are printed as unsigned integers in the specified base.
# Logic:
# 1. Loop through all elements of the array (10 elements).
# 2. Call `print_base` for each element with the unsigned flag set.
# 3. Print a space between elements.
# 4. Print a newline after the array.
     #----Saving Registers on the Stack-----------
    addiu $sp, $sp, -12      # Adjust stack pointer for 4 words
    sw $ra ,8($sp)
    sw $a2, 4($sp)            # Save $a2 (original array address) on the stack
    sw $a1, 0($sp)            # Save $a1 (base) on the stack
    
    #------Loading Arguments----------
    li $a3 , 0            #unsign flag
    lw $t2 , 4($sp)            #Load $t2 with the array address
    lw $a1, 0($sp)            # Load $a1 with the base for printing
    li $t4, 10                # Set loop count to 10 (number of elements)
    li $t3, 0                 # Initialize index register (counter) to 0


inside_loop1:
    beq $t3, $t4, end_loop1    # If counter equals 10, exit loop
    lw $a2, 0($t2)            # Load the current element of the array into $a2

    # Save $t2 on the stack temporarily before calling print_base
    addiu $sp, $sp, -8        # Adjust stack pointer to make room for $t2
    sw $t2, 0($sp)            # Save $t2 on the stack
    sw $t4 ,4($sp)            #Save $t4 on the stack
    
    jal print_base            # Call print_base to print the array element with given base
	 
    la $a0 ,0x20 #ascii of space
    li $v0 , 11 #code for print char
    syscall	 

    # Restore $t2 from the stack after print_base
    lw $t2, 0($sp)            # Restore $t2 from the stack
    lw $t4 , 4($sp)             #Resotore $t4 from the stack
    addiu $sp, $sp, 8         # Adjust stack pointer back	
    	
    addi $t3, $t3, 1          # Increment the index (counter)
    addi $t2, $t2, 4          # Move to the next array element (4 bytes forward for word)
    j inside_loop1             # Jump back to the start of the loop

end_loop1:
    la $a0 ,10 #ascii for newline
    li $v0,11   #print char
    syscall	
    #----Restore Registers from the Stack-----
    lw $a1, 0($sp)            # Restore $a1 (base)
    lw $a2, 4($sp)            # Restore $a2 (array address)
    lw $ra, 8($sp)           # Restore return address
    addiu $sp, $sp, 12        # Adjust stack pointer back

    jr $ra                   # Return to the caller
	
#--------Print_array_usign Q5 D-------------- 	
sum_sign:
# Purpose: Compute the sum of all elements in the array as signed integers.
# Inputs:
#   $a2 - The starting address of the array.
#   $a1 - The base for printing the result.
# Outputs: Prints the sum of the array elements as a signed integer in the specified base.
# Logic:
# 1. Initialize a sum register to 0.
# 2. Loop through all elements of the array and add them to the sum.
# 3. Call `print_base` to print the final sum.

     #----Saving Registers on the Stack-----------
    addiu $sp, $sp, -12     # Adjust stack pointer for 4 words
    sw $ra , 8($sp)          # Save return address
    sw $a2, 4($sp)            # Save $a2 (original array address) on the stack
    sw $a1, 0($sp)            # Save $a1 (base) on the stack
    
    #------Loading Arguments----------
    lw $t2 , 4($sp)            #Load $t2 with the array address
    lw $a1, 0($sp)            # Load $a1 with the base for printing
    li $t4, 10                # Set loop count to 10 (number of elements)
    li $t3, 0                 # Initialize index register (counter) to 0
    li $t0 , 0                #initialize sum of all the elements
    li $a3 , 1	              #intilize the sign flag

inside_loop2:
    beq $t3, $t4, end_loop2    # If counter equals 10, exit loop
    lw $a2, 0($t2)            # Load the current element of the array into $a2
    add $t0 ,$t0 , $a2        # a3 += a2;

    # Save $t2 on the stack temporarily before calling print_base
    addiu $sp, $sp, -8        # Adjust stack pointer to make room for $t2
    sw $t2, 0($sp)            # Save $t2 on the stack
    sw $t4 ,4($sp)            #Save $t4 on the stack

    # Restore $t2 from the stack after print_base
    lw $t2, 0($sp)            # Restore $t2 from the stack
    lw $t4 , 4($sp)             #Resotore $t4 from the stack
    addiu $sp, $sp, 8         # Adjust stack pointer back	
    	
    addi $t3, $t3, 1          # Increment the index (counter)
    addi $t2, $t2, 4          # Move to the next array element (4 bytes forward for word)
    j inside_loop2 
	
    
end_loop2:  
    move $a2 $t0 #Copy $t0 to $a2
    jal print_base	
	
    la $a0 ,10 #ascii for newline
    li $v0,11   #print char
    syscall 
    
    #----Restore Registers from the Stack-----
    lw $a1, 0($sp)            # Restore $a1 (base)
    lw $a2, 4($sp)            # Restore $a2 (array address)
    lw $ra, 8($sp)           # Restore return address
    addiu $sp, $sp, 12        # Adjust stack pointer back

    jr $ra                   # Return to the caller
    
    
#--------Print_array_usign Q5 E-------------- 	
sum_unsign:
# Purpose: Compute the sum of all elements in the array as unsigned integers.
# Inputs:
#   $a2 - The starting address of the array.
#   $a1 - The base for printing the result.
# Outputs: Prints the sum of the array elements as an unsigned integer in the specified base.
# Logic:
# 1. Initialize a sum register to 0.
# 2. Loop through all elements of the array and add them (unsigned addition).
# 3. Call `print_base` to print the final sum.
    #----Saving Registers on the Stack-----------
    addiu $sp, $sp, -12      # Adjust stack pointer for 4 words
    sw $ra, 8($sp)          # Save return address
    sw $a2, 4($sp)           # Save $a2 (original array address) on the stack
    sw $a1, 0($sp)           # Save $a1 (base) on the stack
    
    #------Loading Arguments----------
    lw $t2, 4($sp)           # Load $t2 with the array address
    lw $a1, 0($sp)           # Load $a1 with the base for printing
    li $t4, 10               # Set loop count to 10 (number of elements)
    li $t3, 0                # Initialize index register (counter) to 0
    li $a3, 0                # Initialize unsigned flag
    li $t0, 0                # Initialize sum of all elements as unsigned


	
	
inside_loop3:
    beq $t3, $t4, end_loop3    # If counter equals 10, exit loop
    lw $a2, 0($t2)            # Load the current element of the array into $a2
    addu $t0 ,$t0 , $a2        # $t0 += $a2 as unsign

    # Save $t2 on the stack temporarily before calling print_base
    addiu $sp, $sp, -8        # Adjust stack pointer to make room for $t2
    sw $t2, 0($sp)            # Save $t2 on the stack
    sw $t4 ,4($sp)            #Save $t4 on the stack

    # Restore $t2 from the stack after print_base
    lw $t2, 0($sp)            # Restore $t2 from the stack
    lw $t4 , 4($sp)             #Resotore $t4 from the stack
    addiu $sp, $sp, 8         # Adjust stack pointer back	
    	
    addi $t3, $t3, 1          # Increment the index (counter)
    addi $t2, $t2, 4          # Move to the next array element (4 bytes forward for word)
    j inside_loop3 
	
    
end_loop3: 
    move $a2 , $t0 #Copy $t0 to $a2
    jal print_base	
	
    # Print newline after the result
    la $a0, 10               # ASCII for newline
    li $v0, 11               # Syscall to print character
    syscall
    
    #----Restore Registers from the Stack-----
    lw $a1, 0($sp)           # Restore $a1 (base)
    lw $a2, 4($sp)           # Restore $a2 (array address)
    lw $ra, 8($sp)          # Restore return address
    addiu $sp, $sp, 12       # Adjust stack pointer back

    jr $ra                   # Return to the caller    

	
#--------Print_array_usign Q5 F-------------- 		
print_dif_sign:
# Purpose: Compute and print the difference between consecutive signed array elements.
# Inputs:
#   $a2 - The starting address of the array.
#   $a1 - The base for printing the differences.
# Outputs: Prints the differences between consecutive elements as signed integers.
# Logic:
# 1. Loop through the array in pairs (e.g., `array[0] - array[1]`).
# 2. Call `print_base` for each computed difference.
# 3. Print a space between differences and a newline after the last one.

    # Save registers on the stack
    addiu $sp, $sp, -12       # Adjust stack pointer for 3 saved registers
    sw $ra, 8($sp)            # Save return address
    sw $a2, 4($sp)            # Save array pointer ($a2)
    sw $a1, 0($sp)            # Save base
    
     # Initialize registers
    lw $a1 ,0($sp)             #load base
    lw $t2, 4($sp)            # Load array address into $t2
    li $t1, 9                 # Number of pairs to process (10 elements in total)
    li $t3, 0                 # Initialize pair counter
    li $a3, 1                # Initialize signed flag
  
    
loop20471:
    beq $t3, $t1, end_loop20471  # If counter equals the number of pairs, exit loop
     lw $a2, 0($t2)            # Load the first element of the pair into $a3
     lw $a0 , 4($t2)             # Load the second element of the pair into $a0
    sub  $a2 ,$a2 , $a0       # $a2 = $a2 - $a0 as sign

    # Save $t2 on the stack temporarily before calling print_base
    addiu $sp, $sp, -8        # Adjust stack pointer to make room for $t2
    sw $t2, 0($sp)            # Save $t2 on the stack
    sw $t1 , 4($sp)           # Save $t1 on the stack
    jal print_base
    	
    #Print space
    la $a0 ,0x20 #ascii of space
    li $v0 , 11 #code for print char
    syscall	

    # Restore $t2 from the stack after print_base
    lw $t2, 0($sp)            # Restore $t2 from the stack
    lw $t1, 4($sp)            # Restore $t1 from the stack
    addiu $sp, $sp, 8         # Adjust stack pointer back	
    	
    addi $t3, $t3, 1          # Increment the index (counter)
    addi $t2, $t2, 4          # Move to the next pair 
    j loop20471
	
end_loop20471: 
    # Print newline after the result
    la $a0, 10               # ASCII for newline
    li $v0, 11               # Syscall to print character
    syscall
    
    
    #----Restore Registers from the Stack-----
    lw $a1, 0($sp)           # Restore $a1 (base)
    lw $a2, 4($sp)           # Restore $a2 (array address)
    lw $ra, 8($sp)          # Restore return address
    addiu $sp, $sp, 12       # Adjust stack pointer back

    jr $ra                   # Return to the caller    
    
#--------Print_array_usign Q5 F-------------- 		
print_sum_unsign:
# Purpose: Compute and print the sum of unsigned differences between consecutive array elements.
# Inputs:
#   $a2 - The starting address of the array.
#   $a1 - The base for printing the results.
# Outputs: Prints the sum of unsigned differences.
# Logic:
# 1. Loop through the array in pairs (e.g., `abs(array[0] - array[1])`).
# 2. Compute the absolute difference using unsigned arithmetic.
# 3. Call `print_base` to print the final result.:

    # Save registers on the stack
    addiu $sp, $sp, -12       # Adjust stack pointer for 3 saved registers
    sw $ra, 8($sp)            # Save return address
    sw $a2, 4($sp)            # Save array pointer ($a2)
    sw $a1, 0($sp)            # Save base
    
     # Initialize registers
    lw $a1 ,0($sp)             #load base
    lw $t2, 4($sp)            # Load array address into $t2
    li $t1, 9                 # Number of pairs to process (10 elements in total)
    li $t3, 0                 # Initialize pair counter
    li $a3, 0                # Initialize signed flag
  
    
loopF:
    beq $t3, $t1, end_loopF  # If counter equals the number of pairs, exit loop
     lw $a2, 0($t2)            # Load the first element of the pair into $a3
     lw $a0 , 4($t2)             # Load the second element of the pair into $a0
     addu  $a2 ,$a2 , $a0       # $a2 = $a2 - $a0 as sign

    # Save $t2 on the stack temporarily before calling print_base
    addiu $sp, $sp, -8        # Adjust stack pointer to make room for $t2
    sw $t2, 0($sp)            # Save $t2 on the stack
    sw $t1 , 4($sp)           # Save $t1 on the stack
    jal print_base
    	
    #Print space
    la $a0 ,0x20 #ascii of space
    li $v0 , 11 #code for print char
    syscall	

    # Restore $t2 from the stack after print_base
    lw $t2, 0($sp)            # Restore $t2 from the stack
    lw $t1, 4($sp)            # Restore $t1 from the stack
    addiu $sp, $sp, 8         # Adjust stack pointer back	
    	
    addi $t3, $t3, 1          # Increment the index (counter)
    addi $t2, $t2, 4          # Move to the next pair 
    j loopF
	
end_loopF: 
    # Print newline after the result
    la $a0, 10               # ASCII for newline
    li $v0, 11               # Syscall to print character
    syscall
    
    
    #----Restore Registers from the Stack-----
    lw $a1, 0($sp)           # Restore $a1 (base)
    lw $a2, 4($sp)           # Restore $a2 (array address)
    lw $ra, 8($sp)          # Restore return address
    addiu $sp, $sp, 12       # Adjust stack pointer back

    jr $ra                   # Return to the caller      

	
