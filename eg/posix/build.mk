CPP_FLAGS = $(CPPFLAGS)
C_FLAGS   = -Wall -Wno-parentheses -Wno-unused-result -Wno-unused-but-set-variable $(CFLAGS)
LD_FLAGS  = $(LDFLAGS)

bin = getpid fork fork-01 fork-02 exec exec-01 wait loop open redir shell-loop shell-redir shell-pipe shell-job pipe pipeline kill sigaction sigaction-handler ctermid pgid tcpgrp


$(bin) : % : %.c
	gcc $(CPP_FLAGS) $(C_FLAGS) $(LD_FLAGS) $< -o $@

exec-01 : loop

kill : CPPFLAGS += -D_GNU_SOURCE

sigaction : CPPFLAGS += -D_GNU_SOURCE

sigaction-handler: CPPFLAGS += -D_GNU_SOURCE

.PHONY: clean

clean :
	rm -f *.o $(bin)
	rm -f *~
