TARGET = XSPFKit

SYSROOT = /User/sysroot
CC = gcc
LD = $(CC)
CFLAGS  = -isysroot $(SYSROOT) \
	  -Wall \
	  -std=gnu99 \
	  -I. \
	  -c
LDFLAGS = -isysroot $(SYSROOT) \
	  -w \
	  -dynamiclib \
	  -install_name /System/Library/Frameworks/$(TARGET).framework/$(TARGET) \
	  -lobjc \
	  -framework Foundation
	  
OBJECTS = XSPFManager.o XSPFPlaylist.o XSPFTrack.o NSMutableString+XSPFKit.o

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $(TARGET) $(OBJECTS)
	cp $(TARGET) /System/Library/Frameworks/$(TARGET).framework

clean:
	rm -rf $(OBJECTS) $(TARGET)

%.o: %.m
	$(CC) $(CFLAGS) -o $@ $^

