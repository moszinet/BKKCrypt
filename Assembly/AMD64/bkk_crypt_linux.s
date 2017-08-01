# Copyleft (C) Ákos Kovács - 2017
# Under MIT and BKK POLICEWARE Licenses

# Fast implementation of the hardend BKK cipher

# Compilation on x86-64/amd64 architectures:
# Assemble with: 'gcc bkk_crypt_linux.s -c'
# Link with: 'gcc bkk_crypt_linux.o main.o -o bkk_test'

.global bkk_crypt
.type bkk_crypt, @function

# Calling convention: stdcall
# Equivalent C signature: 'void *bkk_crypt(const void *crypto);'
# %rdi: The crypto parameter
# %rax: Returned pointer
.section .text
bkk_crypt:
    pushq %rbp      # Follow conventions and make
    movq %rsp, %rbp # a new stack frame

    xorq %rax, %rax # Zero-out rax for more security
    movq %rdi, %rax # The encryption magic itself

    popq %rbp       # Destroy stack frame
    ret
