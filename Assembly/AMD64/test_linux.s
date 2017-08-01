# Copyleft (C) Ákos Kovács - 2017
# Under MIT and BKK POLICEWARE Licenses

# Use the Makefile to build it
# Shell return values:
# 0 - all tests passed
# non-zero otherwise

.global bkk_crypt
.global strcmp
.global exit

.global main
.type bkk_crypt, @function
.type main, @function

.section .rodata
str0:
    .string "We bust haxxors"
str1:
    .string "Safe plaintext\n"

.section .text
main:
    # Call %rax = bkk_crypt(str0)
    movq $str0, %rdi
    callq bkk_crypt

    # The result (in %rax) is the first parameter
    movq %rax, %rdi
    # str1 is the second paramter
    movq $str0, %rsi
    # strcmp(%rax, str0)
    callq strcmp 
    # Save for later
    pushq %rax 

    # Same as above, just with str1
    movq $str1, %rdi
    callq bkk_crypt

    movq %rax, %rdi
    movq $str1, %rsi
    callq strcmp

    # Restore the first one from the stack to %rbx
    popq %rbx
    # Or the test results together
    # %rax = %rbx | %rax
    orq %rbx, %rax
   
    # Complete test result on return
    mov %rax, %rdi
    call exit
    ret
