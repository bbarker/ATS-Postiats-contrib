######

PATSCC=patscc

######

INCLUDE_ATS :=
INCLUDE_ATS += -I${PATSHOME}
INCLUDE_ATS += -I${PATSHOMERELOC}/contrib

######

CFLAGS_ATS :=
CFLAGS_ATS += -D_ATS_CCOMP_HEADER_NONE_
CFLAGS_ATS += -D_ATS_CCOMP_PRELUDE_NONE_
CFLAGS_ATS += -D_ATS_CCOMP_PRELUDE_USER_=\"./../pats_ccomp.h\"
CFLAGS_ATS += -D_ATS_CCOMP_EXCEPTION_NONE_

######

CC=arm-linux-gnueabi-gcc
LD=arm-linux-gnueabi-ld

CFLAGS=-Wall -Wextra -march=armv6 -msoft-float -fPIC -mapcs-frame -marm
LDFLAGS=-N -Ttext=0x10000

######

all:: kernel_dats.elf

######

kernel_dats.c: kernel.dats ; $(PATSCC) -ccats - $@ $<
kernel_dats.s: kernel_dats.c ; \
  $(CC) $(INCLUDE_ATS) $(CFLAGS) $(CFLAGS_ATS) -O2 -S -o $@ $<
kernel_dats.o: kernel_dats.s ; \
  $(CC) $(INCLUDE_ATS) $(CFLAGS) $(CFLAGS_ATS) -O2 -c -o $@ $<

######

kernel.elf: bootstrap.o kernel.o
kernel_dats.elf: bootstrap.o kernel_dats.o

######
#
# for quitting: ^Ax
#
testing: kernel_dats.elf ; \
qemu-system-arm -M versatilepb -cpu arm1176 -nographic -kernel kernel_dats.elf
#
######

RMF=rm -f

######

.PHONY: clean

clean:: ; $(RMF) *~
clean:: ; $(RMF) *.o

######

clean:: ; $(RMF) *_dats.c
clean:: ; $(RMF) *_dats.s

######

cleanall:: clean
cleanall:: ; $(RMF) *.elf

######

.SUFFIXES: .s .o .elf

.s.o: ; $(CC) $(CFLAGS) -o $@ -c $^

.o.elf: ; $(LD) $(LDFLAGS) -o $@ $^

###### end of [Makefile] ######
