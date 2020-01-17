#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "verify.h"

int main(int argc, char **argv)
{
  FILE *fp;
  char *filename;
  uint8_t sig[0x100];
  uint32_t size;
  uint8_t token[48];
  int err;

  if (argc != 2) {
    fprintf(stderr, "Usage: %s [signature file]\n", argv[0]);
    return 1;
  }

  fp = fopen(argv[1], "rb");
  if (!fp) {
    fprintf(stderr, "Cannot open the signature file.\n");
    return 1;
  }

  size = fread(sig, 1, sizeof(sig), fp);
  fclose(fp);
  if (size != sizeof(sig)) {
    fprintf(stderr, "Cannot load the signature data.\n");
    return 1;
  }

  err = verify(sig, sizeof(sig), token, sizeof(token), extracted_key);

  if (err) {
    fprintf(stderr, "Invaild signature data.\n");
  } else {
    printf("Vaild signature data!\n");
    printf("Corresponding token is: ");
    for (int i = 0;i < (int)sizeof(token);++i)
      putchar(token[i]);
    putchar('\n');
  }

  filename = malloc(strlen(argv[1]) + 10);
  if (!filename) {
    fprintf(stderr, "Cannot allocate memory.\n");
    return 1;
  }

  sprintf(filename, "%s_decrypt", argv[1]);
  fp = fopen(filename, "wb");
  free(filename);
  if (!fp) {
    fprintf(stderr, "Cannot open the decrypt file.\n");
    return 1;
  }

  size = fwrite(sig, 1, sizeof(sig), fp);
  fclose(fp);
  if (size != sizeof(sig)) {
    fprintf(stderr, "Cannot store the decrypted signature.\n");
    return 1;
  }

  printf("The decrypted signature is saved into the file %s_decrypt\n", argv[1]);

  return 0;
}
