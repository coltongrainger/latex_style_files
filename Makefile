# Bundles the source files together into the final outputs, using CPP and its flags.
# This is inelegant, but ought to suffice for now
# TODO: I still need to check that the output files actually work. Everything seems OK

CPPFLAGS = -nostdinc -w -P -C

INPUTS = src/*.tex
OUTPUTS = ccg-notes.cls ccg-pset.cls ccg-topic.cls

all: $(OUTPUTS)

%.cls: src/%.cls $(INPUTS)
	cpp $(CPPFLAGS) src/$@ > $@
