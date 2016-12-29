
DEBUG_OPT=-g

.PHONY: all run clean

BIN=main_c main_cpp murmur_rs

all: $(BIN)

clean:
	rm $(BIN)

run: all
	time ./murmur_rs > log_rs.log
	time ./main_c > log_c.log
	time ./main_cpp > log_cpp.log

runnull: all
	time ./murmur_rs > /dev/null
	time ./main_c > /dev/null
	time ./main_cpp > /dev/null

main_c: main.c
	gcc $(DEBUG_OPT) -O3 -fno-inline $< -o $@

main_cpp: main.cpp
	g++ $(DEBUG_OPT) -O3 -fno-inline $< -o $@

murmur_rs: murmur_rs.rs
	rustc $(DEBUG_OPT) -O $< -o $@
