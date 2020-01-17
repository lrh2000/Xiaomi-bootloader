#pragma once
#include <stdint.h>

void substract(const uint32_t *key, uint32_t *dst);

void multiply(const uint32_t *key, uint32_t *dst,
        const uint32_t *src1, const uint32_t *src2);

int verify(void *data, uint32_t data_len,
      uint8_t *token, uint32_t token_len, const uint32_t *key);

extern const uint32_t extracted_key[0x83];
