NIMFILES = ./clib.nim
NIMBASE = ~/lib/Nim/lib/nimbase.h
RELEASE_TYPE = debug
COMMON_BUILD_FLAGS = --gc:regions --header --nimcache:csrc --compileOnly 

.PHONY: clean release debug test all

all: dist/main.js lib/hellolib.node

dist/main.js: jssrc/main.ts
	tsc

dist/test.js: jssrc/test.ts
	tsc

lib/hellolib.node: csrc/nimbase.h $(RELEASE_TYPE)
	node-gyp rebuild

release: $(NIMFILES)
	nim cpp -d:release $(COMMON_BUILD_FLAGS) ./clib.nim

debug: $(NIMFILES)
	nim cpp $(COMMON_BUILD_FLAGS) ./clib.nim # most of the flags you had here don't work with gc:regions.

csrc/nimbase.h: $(NIMBASE)
	mkdir -p csrc
	cp $^ $@

test: dist/test.js
	node dist/test.js

clean:
	-rm -r csrc
	-rm -r build
	-rm -r lib
	-rm -r dist
