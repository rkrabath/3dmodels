
TARGETS = $(shell ls *.scad | cut -d. -f1 | sed -e 's/$$/.gcode/')

all : $(TARGETS)

%.stl : %.scad
	openscad $*.scad -o $@

%.gcode : %.stl
	prusa/bin/prusa-slicer --export-gcode $*.stl

prusa/bin/prusa-slicer:
	wget https://github.com/prusa3d/PrusaSlicer/releases/download/version_2.4.1/PrusaSlicer-2.4.1+linux-x64-GTK3-202203101056.tar.bz2
	tar -xjf PrusaSlicer-2.4.1+linux-x64-GTK3-202203101056.tar.bz2
	mv PrusaSlicer-2.4.1+linux-x64-GTK3-202203101056 prusa
	rm PrusaSlicer-2.4.1+linux-x64-GTK3-202203101056.tar.bz2
