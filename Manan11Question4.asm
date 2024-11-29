# Name: Or Saban
# Title: Maman 11 Question 4
# ID: 208248716
# Date: 8.12.24
# File name: Maman11Question4.asm
# Description: 
# This program processes a given string to format text by ensuring that
# the first letter of each sentence is lowercase while converting all
# uppercase letters within the string to lowercase. The program recognizes
# sentences based on periods ('.') and skips over spaces. The resulting
# modified string is printed after processing.
#
# Main Features:
# 1. Processes input string and modifies it in place.
# 2. Ensures the first letter of each sentence is converted to lowercase.
# 3. Converts all uppercase letters ('A'-'Z') to lowercase across the string.
# 4. Skips non-alphabetical characters and spaces during processing.
# 5. Prints the original and modified string for comparison.

#################### Data Segment ##################
.data
str: .asciiz "hyunDAi aNd Kia. tHebEST sMartwatChEs. learning a NEW langUa."

#################### Code Segment ##################
.text
main:
	# Purpose: Display the original string before any modifications
    # --------- Print input message --------- #
    la $a0, str          # Load address of input message
    li $v0, 4            # Syscall to print string
    syscall

    # Print newline after the input string
    # Purpose: Separate the original string from the modified string in output
    li $v0, 11           # Syscall to print a single character
    li $a0, 10           # ASCII code for newline
    syscall

    # --------- Initialize --------- #
    li $t0, 0            # Initialize index for str
    li $t1, 1            # Flag for first character after period (1 = on, 0 = off)

# --------- Main Loop --------- #
swap:
	# Purpose: Process each character of the string
    lbu $a0, str($t0)        # Load byte from str at index $t0
    beq $a0, $zero, print_string  # If null terminator, go to print_string
    beq $a0, 0x20, skip_index     # If space, skip to next character
    beq $a0, 0x2E, dot_case       # If period, set flag for new sentence
    beq $t1, 1, first_char        # If first char of a sentence, convert to lowercase

    # Convert uppercase to lowercase if within 'A'-'Z' range
    blt $a0, 'A', skip_index      # Skip if below 'A'
    bgt $a0, 'Z', skip_index      # Skip if above 'Z'

first_char:
 # Purpose: Convert the first character of a sentence to lowercase
    li $t1, 0                     # Turn off first character flag
    xori $a0, $a0, 0x20           # Convert uppercase to lowercase
    sb $a0, str($t0)              # Store modified character back in str
    j skip_index                  # Go to next character

dot_case:
 # Purpose: Mark the end of a sentence and prepare for the next sentence
    li $t1, 1                     # Set flag for new sentence
    addi $t0, $t0, 1              # Move to next character
    j swap                        # Continue loop

skip_index:
    # Purpose: Move to the next character without making changes
    addi $t0, $t0, 1              # Move to next character
    j swap                        # Continue loop

# --------- Print the converted string --------- #
print_string:
# Purpose: Display the modified string after processing
    la $a0, str                   # Load the address of the modified string
    li $v0, 4                     # Syscall to print string
    syscall

# --------- Exit Program --------- #
finish:
    li $v0, 10                    # Exit syscall
    syscall
