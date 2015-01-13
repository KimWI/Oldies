main : aleste2.rom

aleste2.rom : aleste2.asm boot.bin index.inc data.bin
	./sjasmplus aleste2.asm -lst=aleste2.lst

boot.bin index.inc data.bin : build.py
	python build.py

debugrom : aleste2.rom
	./openmsx -machine Panasonic_FS-A1GT aleste2.rom -script aleste2rom.tcl

debugdsk : 
	./openmsx -machine Panasonic_FS-A1GT -diska aleste21.dsk \
        -script aleste2.tcl

