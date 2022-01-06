# This Make script is used to generate the ROM and check its integrity.
#
# Tested in the following environment:
# - FreeBSD 13.0
# - asmx-8085 1.8.2
#

all: vt100.asmx.bin
all: check.asmx

vt100.asmx.srec: vt100.asm
	asmx-8085 -w -e -s9 -l $@.lst -c $< > $@

vt100.asmx.bin: vt100.asmx.srec
	objcopy -I srec -O binary $< $@

check.asmx: vt100.asmx.bin
	sha1 -q $< | cmp - vt100.sha1


# Tested with vasm snapshot from 2022-01-06.
VASM = vasmz80_oldstyle

vt100.vasm.bin: vt100.asm
	$(VASM) -intel-syntax -quiet -Fbin -o $@ -L $@.lst $<

check.vasm: vt100.vasm.bin
	sha1 -q $< | cmp - vt100.sha1


.PHONY: clean
clean:
	rm -f vt100.asmx.*
	rm -f vt100.vasm.*

