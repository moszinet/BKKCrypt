AS        := gcc
ASFLAGS   := -m32
LD        := gcc
LDFLAGS   := -m32
RM        := rm
AS_OBJS   := bkk_crypt_linux.o test_linux.o
AS_TARGET := as_test

all: test

test: $(AS_TARGET)
	@echo -n "Assembling and running asm tests... "
	@(./$(AS_TARGET) && echo "[SUCCESS]") || echo "[FAIL]"

$(AS_TARGET): $(AS_OBJS)
	$(LD) $(AS_OBJS) -o $@ $(LDFLAGS)

%.o: %.s
	$(AS) $(ASFLAGS) $^ -c

.PHONY: clean
clean:
	$(RM) $(AS_OBJS) $(AS_TARGET)
