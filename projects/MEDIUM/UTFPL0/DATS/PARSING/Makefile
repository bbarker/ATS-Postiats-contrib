#
# A Simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

CCOMP=gcc -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 

######

CFLAGS :=
CFLAGS += -I $(PATSHOMEQ)
CFLAGS += -I $(PATSHOMEQ)/ccomp/runtime
CFLAGS += -I $(PATSHOMEQ)/contrib/atscntrb
CFLAGS +=  $(shell pkg-config --cflags json-c)

######

PATSCC2= $(PATSCC) -atsccomp "$(CCOMP)"

######

all:: parsing.o

######

cleanall:: ; $(RMF) parsing.o

######

SOURCES_SATS +=

SOURCES_DATS += \
  parsing.dats \
  parsing_d2cst.dats \
  parsing_d2var.dats \
  parsing_d2sym.dats \
  parsing_p2at.dats \
  parsing_d2exp.dats \
  parsing_d2ecl.dats \
  parsing_export.dats \

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######

OBJECTS :=
OBJECTS += $(MYTARGET_SATS_O)
OBJECTS += $(MYTARGET_DATS_O)

######

parsing.o: \
  $(OBJECTS) dynloadall_dats.o ; ld -r -o $@ $^

######

%_sats.o: %.sats ; $(PATSCC) $(CFLAGS) -c $<
%_dats.o: %.dats ; $(PATSCC2) $(CFLAGS) -c $<

######

cleanats:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
