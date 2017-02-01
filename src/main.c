#include "sandbox.h"

#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>


const size_t max_memory = ((size_t) 50) << 20;


int main(int argc, char **argv) {
  (void) argc;
  (void) argv;

  // Set up resource limits.
  struct sandbox_settings sandbox_settings;
  sandbox_settings.max_memory = max_memory;
  sandbox_settings.max_cpu_time = 1;
  if (sandbox_init(&sandbox_settings)) return 1;

  // Simulate misbehaving code.
  for (;;);
  /*
  for (int i; malloc(1 << 20); ++i) {
    printf("%i\n", i);
  }
  */

  return 0;
}