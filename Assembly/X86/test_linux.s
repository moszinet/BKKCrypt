# Copyleft (Cd Ákos Kovács - 2017
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
    # Call %eax = bkk_crypt(str0)
    pushl $str0
    call bkk_crypt
    # Clear stack
    popl %ebx

    # The result (in %eax) is the first parameter
    pushl %eax
    # str0 is the second paramter
    push $str0
    # strcmp(%eax, str0)
    call strcmp 
    # Clear both, being lazy with the stack now
    popl %ebx
    popl %ebx
    # Save for later
    push %eax 

    # Same as above, just with str1
    pushl $str1
    call bkk_crypt
    popl %ebx

    pushl %eax
    pushl $str1
    call strcmp
    popl %ebx
    popl %ebx

    # Restore the first one from the stack to %ebx
    popl %ebx
    # Or the test results together
    # %eax = %ebx | %eax
    orl %ebx, %eax
   
    # Complete test result on return
    push %eax
    call exit
    ret
