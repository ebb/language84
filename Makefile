### Special variables and targets

.DEFAULT_GOAL = all
.PHONY: all clean


### Configuration variables

PROGRAMS = 84

LDFLAGS = -static -nostdlib -Wl,--build-id=none

CFLAGS_COMMON = -I. -std=gnu11 -fno-stack-protector

CFLAGS_SUPPORT_OPTIM = -O2
CFLAGS_SUPPORT_WARN = -Wall
CFLAGS_SUPPORT = $(CFLAGS_COMMON) $(CFLAGS_SUPPORT_OPTIM) $(CFLAGS_SUPPORT_WARN)

CFLAGS_GENERATED_OPTIM = -O0
CFLAGS_GENERATED_WARN = -Wno-unused-variable -Wno-unused-function -Wno-unused-value
CFLAGS_GENERATED = $(CFLAGS_COMMON) $(CFLAGS_GENERATED_OPTIM) $(CFLAGS_GENERATED_WARN)

Q = @
E = @ echo


### Local customization hook

-include local.make


### Default goal

all: 84_stable $(PROGRAMS)


### Clean

clean:
	$(E) CLEAN
	$(Q) rm -f *.o *.c.d 84_stable $(PROGRAMS) $(PROGRAMS:%=%.c)


### Compile and link

$(PROGRAMS) 84_stable: %: %.c support.o
	$(E) "CC  $@"
	$(Q) $(CC) $(CFLAGS_GENERATED) $(LDFLAGS) -o $@ $^

support.o: support.c support.h
	$(E) "CC  $@"
	$(Q) $(CC) -c $(CFLAGS_SUPPORT) $<

$(PROGRAMS:%=%.c): 84_stable
	$(E) "84  $@"
	$(Q) ./84_stable $(@:%.c=%)


### Dependency files generated by the Language 84 compiler

-include *.c.d
