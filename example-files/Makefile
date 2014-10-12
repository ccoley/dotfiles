# makefile
# Authors: Chris Coley and Tim Miller

CC = gcc
C_FILES = decodeStage.c dump.c executeStage.c fetchStage.c loader.c main.c memory.c memoryStage.c registers.c tools.c writebackStage.c
O_FILES = ${C_FILES:.c=.o}
OUT = yess

yess: decodeStage.o dump.o executeStage.o fetchStage.o loader.o main.o memory.o memoryStage.o registers.o tools.o writebackStage.o
	$(CC) -o $(OUT) $(O_FILES)

decodeStage.o: decodeStage.c decodeStage.h tools.h registers.h
dump.o: dump.c dump.h types.h fetchStage.h decodeStage.h executeStage.h memoryStage.h writebackStage.h registers.h memory.h
executeStage.o: executeStage.c executeStage.h types.h registers.h
fetchStage.o: fetchStage.c fetchStage.h decodeStage.h tools.h types.h
loader.o: loader.c loader.h types.h tools.h memory.h dump.h
main.o: main.c main.h types.h tools.h memory.h dump.h loader.h registers.h fetchStage.h decodeStage.h executeStage.h memoryStage.h writebackStage.h
memory.o: memory.c memory.h types.h tools.h
memoryStage.o: memoryStage.c memoryStage.h tools.h
registers.o: registers.c registers.h
tools.o: tools.c tools.h types.h
writebackStage.o: writebackStage.c writebackStage.h types.h dump.h

clean:
	rm -rf $(O_FILES) debug

debug: $(O_FILES)
	$(CC) -g $(C_FILES) -o debug
