$(shell mkdir -p bin)
$(shell mkdir -p build)

CC := gcc -W -Wall -Wextra -pedantic -Werror -std=c11

.PHONY: default
default: bin/exe

.PHONY: clean
clean:
	rm -rf bin/* build/*

.PHONY: run
run: bin/exe
	time -p ./$<; echo "Return status: $$?"

bin/exe: src/main.c build/resource_limit.o build/sandbox.o
	$(CC) $+ -o $@

build/resource_limit.o: src/resource_limit.c src/resource_limit.h
build/sandbox.o: src/sandbox.c src/sandbox.h src/resource_limit.h

build/%.o:
	$(CC) -c $< -o $@

build/include/luajit-2.0/% build/lib/%: third_party/luajit-2.0/Makefile
	cd third_party/luajit-2.0/ && $(MAKE) install PREFIX=$(realpath build)

third_party/luajit-2.0/Makefile:
	git submodule update third_party/luajit-2.0/
