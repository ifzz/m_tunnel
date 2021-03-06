
CC=gcc
CFLAGS= -Wall -std=gnu99 -Wdeprecated-declarations

DEBUG= -g
RELEASE= -O2

LIBS= -lpthread -lc

SRCS := $(shell find src -name "*.c")
SRCS += $(shell find vendor/m_net/src -name "*.c")
SRCS += $(shell find vendor/m_foundation/src -name "*.c")

DIRS := $(shell find src -type d)
DIRS += $(shell find vendor/m_net/src -type d)
DIRS += $(shell find vendor/m_foundation/src -type d)

INCS := $(foreach n, $(DIRS), -I$(n))

all: debug

debug: $(SRCS)
	$(CC) $(DEBUG) $(CFLAGS) $(INCS) -o tun_local.out $^ $(LIBS) -DTEST_TUNNEL_LOCAL -DPLAT_THREAD
	$(CC) $(DEBUG) $(CFLAGS) $(INCS) -o tun_remote.out $^ $(LIBS) -DTEST_TUNNEL_REMOTE -DPLAT_THREAD

release: $(SRCS)
	$(CC) $(RELEASE) $(CFLAGS) $(INCS) -o tun_local.out $^ $(LIBS) -DTEST_TUNNEL_LOCAL -DPLAT_THREAD
	$(CC) $(RELEASE) $(CFLAGS) $(INCS) -o tun_remote.out $^ $(LIBS) -DTEST_TUNNEL_REMOTE -DPLAT_THREAD

clean:
	rm -rf *.out *.dSYM
