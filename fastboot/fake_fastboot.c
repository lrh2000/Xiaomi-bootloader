#include <stdio.h>
#include <string.h>

// Modify the following two lines to meet with your own phone.
#define MI_TOKEN "000000000000000000000000000000000000000000000000"
#define MI_PRODUCT "ginkgo"

void dump_file(FILE *log, const char *filename)
{
  FILE *fp = fopen(filename, "r");
  int c;

  if (!fp) {
    fprintf(log, "ERROR: Failed to open the file %s.\n", filename);
    return;
  }

  fprintf(log, "File '%s' Content: \n'''", filename);
  while ((c = fgetc(fp)) != EOF)
    fputc(c, log);
  fprintf(log, "'''\n");
}

int fake_fastboot(FILE *log, char **arg, int len)
{
  if (len <= 0) {
    fprintf(log, "ERROR: Command is too short.\n");
    return -2;
  }

  if (strcmp(arg[0], "getvar") == 0) {
    if (len <= 1) {
      fprintf(log, "ERROR: Command is too short.\n");
      return -2;
    }

    if (strcmp(arg[1], "token") == 0) {
      puts("token: " MI_TOKEN);
      puts("finished. total time: 0.001s");
      return 0;
    } else if (strcmp(arg[1], "product") == 0) {
      puts("product: " MI_PRODUCT);
      puts("finished. total time: 0.001s");
      return 0;
    } else {
      printf("getvar:%s FAILED (remote: GetVar Variable not found)\n", arg[1]);
      puts("finished. total time: 0.001s");
      return 1;
    }

  } else if (strcmp(arg[0], "oem") == 0) {
    if (len <= 1) {
      fprintf(log, "ERROR: Command is too short.\n");
      return -2;
    }

    puts("...");
    if (strcmp(arg[1], "device-info") == 0) {
      puts("(bootloader) Verity mode: true");
      puts("(bootloader) Device unlocked: false");
      puts("(bootloader) Device critical unlocked: false");
      puts("(bootloader) Charger screen enabled: true");
      puts("OKAY [ -0.000s]");
      puts("finished. total time: -0.000s");
      return 0;
    } else if (strcmp(arg[1], "unlock") == 0) {
      if (len <= 2) {
        fprintf(log, "ERROR: Command is too short.\n");
        return -2;
      }
      dump_file(log, arg[2]);
      puts("OKAY [ 0.100s]");
      puts("finished. total time: 0.100s");
      return 0;
    } else {
      puts("FAILED (remote: unknown command)");
      puts("finished. total time: 0.001s");
      return 1;
    }

  } else if (strcmp(arg[0], "devices") == 0) {
    puts("1234abcd\tfastboot");
    return 0;
  } else {
    fprintf(log, "ERROR: Unrecognized command.\n");
    return -2;
  }
}

int main(int argc, char **argv)
{
  FILE *log = fopen("fastboot_log", "a");
  char *real_arg[3];
  int len = 0;
  int err;

  if (!log) {
    fprintf(stderr, "Cannot open the log file.\n");
    return -1;
  }

  fprintf(log, "Command: ");
  for (int i = 0;i < argc;++i)
    fprintf(log, "%s%c", argv[i], " \n"[i == argc - 1]);

  for (int i = 1;i < argc && len < 3;++i)
  {
    if (strcmp(argv[i], "-s") == 0) {
      ++i;
      continue;
    }
    real_arg[len++] = argv[i];
  }

  err = fake_fastboot(log, real_arg, len);
  fprintf(log, "Processed the command! (Return value: %d)\n\n", err);

  fclose(log);
  return err;
}
