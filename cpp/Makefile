CFALGS=-O3 -Werror  
program: hello_wold.o
	g++ -o program hello_wold.o $(CFALGS)
hello_wold.o: hello_wold.c
	g++ -c -o hello_wold.o $< $(CFALGS) 

