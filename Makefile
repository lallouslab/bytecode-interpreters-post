CC = gcc
CFLAGS = -std=gnu11 -O3 -g

INTERPRETERS = basic-switch immediate-arg stack-machine register-machine

all: $(INTERPRETERS) pigletvm piglet-matcher

test: test-interpreters pigletvm-test piglet-matcher-test

test-interpreters: $(INTERPRETERS)
	$(foreach interpr,$(INTERPRETERS),./$(interpr);)

%: interpreter-%.c
	$(CC) $(CFLAGS) $< -o $@

pigletvm: pigletvm.c pigletvm-rcache.c pigletvm-exec.c
	$(CC) $(CFLAGS) $^ -o $@

pigletvm-test: pigletvm.c pigletvm-rcache.c pigletvm-test.c
	$(CC) -g $(CFLAGS) $^ -o $@
	./pigletvm-test

piglet-matcher: piglet-matcher.c piglet-matcher-exec.c
	$(CC) $(CFLAGS) $^ -o $@

piglet-matcher-test: piglet-matcher.c piglet-matcher-test.c
	$(CC) -g $(CFLAGS) $^ -o $@
	./piglet-matcher-test

clean:
	rm -vf $(INTERPRETERS) pigletvm pigletvm-test piglet-matcher piglet-matcher-test

.PHONY: all clean pigletvm-test piglet-matcher-test test-interpreters
