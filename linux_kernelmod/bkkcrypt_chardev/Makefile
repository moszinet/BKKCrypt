obj-m += bkkcrypt-dev.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

tests:
	$(CC) -o unit_tests unit_tests.c
