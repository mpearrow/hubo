default: all



CFLAGS := -I./include -g --std=gnu99
CXXFLAGS := -I./include -g

CC := gcc
CXX := g++

# SOCKETCAN #
CAN_LIBS :=
CAN_OBJS := src/hubo-socketcan.o
CAN_DEFS :=

# esd CAN #
# CAN_LIBS := -lntcan
# CAN_OBJS := src/hubo-esdcan.o
# CAN_DEFS := -DHUBO_CONFIG_ESD

BINARIES := hubo-main hubo-console hubo-loop
all : $(BINARIES)

LIBS := -lach -lrt $(CAN_LIBS)

hubo_main_objs := src/hubo-main.o $(CAN_OBJS)

hubo-main: $(hubo_main_objs)
	$(CC) -o $@  $(hubo_main_objs) $(LIBS)

hubo-console: src/hubo-console.o
	$(CXX)  -o $@ $< -lach -lreadline

hubo-loop: src/hubo-loop.o
	gcc -o $@ $< -lach -lrt

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<


clean:
	rm -f $(BINARIES) src/*.o

