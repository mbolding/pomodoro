# Makefile for Pomodoro Timer

CC=gcc
CFLAGS=-Wall -O2
TARGET=pomodoro
SRC=pomodoro.c

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC)

clean:
	rm -f $(TARGET)
