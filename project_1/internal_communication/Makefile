# Compiler
GCC = gcc

# File names
LISTENER_EXEC = listener
SENDER_EXEC = sender
LISTENER_SRC = $(LISTENER_EXEC).c
SENDER_SRC = $(SENDER_EXEC).c

# Variables
PORT = 4547

# Compilation
make:
	$(GCC) $(LISTENER_SRC) -o $(LISTENER_EXEC)
	$(GCC) $(SENDER_SRC) -o $(SENDER_EXEC)

listen:
	./$(LISTENER_EXEC) $(PORT)

send:
	./$(SENDER_EXEC) localhost $(PORT)

clean:
	rm $(LISTENER_EXEC) $(SENDER_EXEC)
