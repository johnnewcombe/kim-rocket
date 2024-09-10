
ORG = 0x0200

all:	rocket.ptp

rocket.ptp: rocket.bin Makefile
	
	srec_cat ./output/rocket.bin -binary -offset $(ORG) -o ./output/rocket.ptp -MOS_Technologies

rocket.bin: rocket.o
	
	ld65 -t none -vm -m ./output/rocket.map -o ./output/rocket.bin ./output/rocket.o

rocket.o: rocket.s
	
	ca65 -v -l ./output/rocket.lst -o ./output/rocket.o --feature labels_without_colons rocket.s

clean:
	
	$(RM) ./output/*.o ./output/*.lst ./output/*.map ./output/*.bin ./output/*.ptp

distclean: clean
