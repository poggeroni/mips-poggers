AS	 = as
ASFLAGS  =

LINKER   = ld
LFLAGS   =

SRCDIR   = src
OBJDIR   = obj

SOURCES := $(wildcard $(SRCDIR)/*.asm)
OBJECTS := $(SOURCES:$(SRCDIR)/%.asm=$(OBJDIR)/%.o)


poggers: $(OBJECTS)
	$(LINKER) $(OBJECTS) $(LFLAGS) -o $@

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.asm $(OBJDIR)
	$(AS) $(ASFLAGS) $< -o $@

$(OBJDIR):
	mkdir -p $(OBJDIR)

.PHONY: clean
clean:
	rm $(OBJECTS)

.PHONY: remove
remove: clean
	rm $(TARGET)
