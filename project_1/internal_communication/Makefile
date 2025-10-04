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
	./$(LISTENER_EXEC)

# Binary string is an example of what should sent when executing the sender
send:
	./$(SENDER_EXEC) 1000101010010011101010

clean:
	rm $(LISTENER_EXEC) $(SENDER_EXEC)
