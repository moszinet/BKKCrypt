# Copyleft (C) Ákos Kovács - 2017
# Under MIT and BKK POLICEWARE Licenses

# Fast implementation of the hardend BKK cipher

# Compilation on x86-64/amd64 architectures:
# Assemble with: 'gcc bkk_crypt_linux.s -m32 -c'
# Link with: 'gcc bkk_crypt_linux.o main.o -m32 -o bkk_test'
.code32

.global bkk_crypt
.type bkk_crypt, @function

# Calling convention: stdcall
# Equivalent C signature: 'void *bkk_crypt(const void *crypto);'
# 4(%ebp): The old %ebp
# 8(%ebp): First parameter
# %rax: Returned pointer
.section .text
bkk_crypt:
    pushl %ebp          # Follow conventions and make
    movl %esp, %ebp     # a new stack frame

    xorl %eax, %eax     # Zero-out rax for more security
    movl 8(%ebp), %eax # The encryption magic itself

    popl %ebp           # Destroy stack frame
    ret
