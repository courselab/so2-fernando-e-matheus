
#include <unistd.h>
#include <stdio.h>

int printf(const char *fmt, ...) 
{
  write (1, "World\n", 7);
  return 0;
}
