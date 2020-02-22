CC = $(COMPILER)
CFLAGS = -c
OBJS_MAIN = main.o
DEPEND = multiplicacion

.PHONY: multiplicacion

all: $(DEPEND)

multiplicacion:
	$(CC) $(CFLAGS) MultiplicacionMatrices.c -o $(OBJS_MAIN)
	$(CC) $(OBJS_MAIN) -o main.out
	rm *.o
