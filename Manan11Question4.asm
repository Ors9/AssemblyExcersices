#################### Data Segment ##################
.data
str: .asciiz "hyunDAi aNd Kia. tHebEST sMartwatChEs. learning a NEW langUa."

#################### Code Segment ##################
.text
main:
    # --------- Print input message --------- #
    la $a0, str          # Load address of input message
    li $v0, 4            # Syscall to print string
    syscall

    # Print newline after the input string
    li $v0, 11           # Syscall to print a single character
    li $a0, 10           # ASCII code for newline
    syscall

    # --------- Initialize --------- #
    li $t0, 0            # Initialize index for str
    li $t1, 1            # Flag for first character after period (1 = on, 0 = off)

# --------- Main Loop --------- #
swap:
    lbu $a0, str($t0)        # Load byte from str at index $t0
    beq $a0, $zero, print_string  # If null terminator, go to print_string
    beq $a0, 0x20, skip_index     # If space, skip to next character
    beq $a0, 0x2E, dot_case       # If period, set flag for new sentence
    beq $t1, 1, first_char        # If first char of a sentence, convert to lowercase

    # Convert uppercase to lowercase if within 'A'-'Z' range
    blt $a0, 'A', skip_index      # Skip if below 'A'
    bgt $a0, 'Z', skip_index      # Skip if above 'Z'

first_char:
    li $t1, 0                     # Turn off first character flag
    xori $a0, $a0, 0x20           # Convert uppercase to lowercase
    sb $a0, str($t0)              # Store modified character back in str
    j skip_index                  # Go to next character

dot_case:
    li $t1, 1                     # Set flag for new sentence
    addi $t0, $t0, 1              # Move to next character
    j swap                        # Continue loop

skip_index:
    addi $t0, $t0, 1              # Move to next character
    j swap                        # Continue loop

# --------- Print the converted string --------- #
print_string:
    la $a0, str                   # Load the address of the modified string
    li $v0, 4                     # Syscall to print string
    syscall

# --------- Exit Program --------- #
finish:
    li $v0, 10                    # Exit syscall
    syscall
