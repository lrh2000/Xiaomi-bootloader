#include <string.h>
#include "verify.h"

const uint32_t extracted_key[0x83] = {
    0x00000040, 0x5d57403f, 0x35fb5041, 0x39165ba1,
    0x5b217172, 0x20e96f4a, 0x05fcf186, 0x55e1a5ba,
    0x51ee9d3e, 0xe051ba9e, 0xc71e77e1, 0x75e614bc,
    0xd37bc9d9, 0x71652d68, 0x9f8b04e2, 0x393ee773,
    0x608ed5e6, 0x855c2df1, 0x811b105d, 0xc271c1ea,
    0x1807e7fc, 0x3c6a081d, 0x90d20585, 0xc07317a1,
    0xd3dc3d29, 0xa876bb41, 0xdbbe4e5b, 0xb5f62195,
    0x3cd83cb7, 0x460ba7cf, 0x51a34921, 0x7d57d06f,
    0xfa3317dd, 0xb0669915, 0x755682d0, 0x029a3a73,
    0x7b438945, 0x151bd2ed, 0xedc49bdf, 0xf2856318,
    0x866ddf6b, 0xdcbcf49f, 0x181d9a1e, 0x998d3235,
    0x50aabfdb, 0x5bd5da7e, 0x4476c365, 0xcc97ef2d,
    0x75f4438c, 0x76f964a5, 0xc32588c6, 0x238d8e9f,
    0xcfe00661, 0x530679bf, 0x788f30b5, 0x0868dae6,
    0x938be1fa, 0x8804fdf3, 0xd4c2d779, 0x731ed3e5,
    0x8d9a7c16, 0xbc13f028, 0x0ec5c8ab, 0x4f0d13c4,
    0x20b827e3, 0xb7fbcde3, 0xa398baab, 0xd0c7d6d2,
    0xcaeebfa4, 0x9acb6543, 0x09e7e9a7, 0xf577f1e5,
    0x4131f364, 0x7921d615, 0x9d1712b4, 0xbe9e8cc2,
    0x2d8cc54c, 0xdc9eb827, 0xdc0dfc7e, 0x033c4d08,
    0xbd6e45c2, 0xfbe3f298, 0xe06c0490, 0xdc7e57a0,
    0x0848d21b, 0xbad9c25c, 0x0d941cf6, 0x04f04b2a,
    0x807c58ab, 0x854ecb29, 0xd714f2ba, 0xd7919c8f,
    0x06957e7e, 0x55aae856, 0xf2fd57ba, 0xa53b22c3,
    0x599564d6, 0x3c6ab0b8, 0x7562feeb, 0x4927e861,
    0xb3b9a1df, 0x44842445, 0xbaa06ee4, 0x5917b807,
    0x63bb8467, 0x17ec410f, 0x6f4b8956, 0x408600a0,
    0xfd26c73e, 0x3a3b13f4, 0xdcd39eb5, 0x5e9db9db,
    0xaeb45e3a, 0x334cf7ef, 0x48932c8f, 0xe0de7c5c,
    0x3cb41279, 0x0f247783, 0x1e6af139, 0x3c7e0721,
    0x28d9697c, 0x5378d720, 0x570d55eb, 0xf7c21e60,
    0xd518da21, 0x61cb74a4, 0x231f0935, 0xb26807fa,
    0x41f1b3e2, 0x49a70dfe, 0x00010001,
  };

static inline uint32_t reverse_bytes(uint32_t k)
{
  return ((k & 0xff) << 0x18) | ((k & 0xff00) << 0x8) |
          ((k & 0xff0000) >> 0x8) | ((k & 0xff000000) >> 0x18);
}

void substract(const uint32_t *key, uint32_t *dst)
{
  uint32_t len = *key;
  uint64_t x10 = 0;

  for (uint32_t j = 0;j < len;++j)
  {
    // w12 = dst[j]
    // w13 = key[j + 2]
    uint64_t x15;

    x15 = (uint64_t)dst[j] - (uint64_t)key[j + 2] + x10;
    x10 = (int64_t)x15 >> 32;
    dst[j] = (uint32_t)x15;
  }
}

void multiply(const uint32_t *key, uint32_t *dst,
        const uint32_t *src1, const uint32_t *src2)
{
  uint32_t len = *key; // X8

  memset(dst, 0, sizeof(uint32_t) * len);

  for (uint32_t i = 0;i < len;++i) // X23
  {
    // w10 = src1[i];
    // w13 = src2[0];
    // w15 = dst[0];
    // w12 = key[1];
    // w17 = key[2];
    uint32_t w12;
    uint64_t x14, x13, x4;

    x14 = (uint64_t)src2[0] * (uint64_t)src1[i] + (uint64_t)dst[0];
    w12 = key[1] * (uint32_t)x14;
    x13 = (uint64_t)w12 * (uint64_t)key[2] + (uint64_t)((uint32_t)x14);

    for (uint32_t j = 0;j + 1 < len;++j) // X11
    {
      // x8 = &key[j]
      // x17 = &dst[j]
      // w11 = src2[j + 1];
      // w0 = key[j + 3];
      // w1 = dst[j + 1];
      uint64_t x2, x16;

      x2 = (uint64_t)src2[j + 1] * (uint64_t)src1[i] + (x14 >> 32);
      x16 = (uint64_t)w12 * (uint64_t)key[j + 3] + (x13 >> 32);
      x14 = x2 + (uint64_t)dst[j + 1];
      x13 = (uint32_t)x14 + x16;

      dst[j] = (uint32_t)x13;
    }
    x4 = (x14 >> 32) + (x13 >> 32);
    dst[len - 1] = (uint32_t)x4;

    if (x4 & (1ull << 32))
      substract(key, dst);
  }
}

int verify(void *data, uint32_t data_len,
      uint8_t *token, uint32_t token_len, const uint32_t *key)
{
  uint32_t num1[0x40], num2[0x40], num3[0x40], num4[0x40];
  uint32_t len = *key; // 0x40
  uint8_t *num = (uint8_t *)num1;

  if (!data)
    return -1;
  if (data_len != 0x100)
    return -1;
  if (!token)
    return -1;
  if (token_len > 0xf5)
    return -1;
  if (!key)
    return -1;

  memcpy(num1, data, data_len);
  for (uint32_t i = 0;i < len;++i)
    num2[i] = reverse_bytes(num1[len - i - 1]);

  if (key[0x82] != 0x10001)
    return -1; // Not implemented.

  multiply(key, num3, num2, &key[0x42]);
  for (uint32_t i = 0;i < 16;i += 2)
  {
    multiply(key, num4, num3, num3);
    multiply(key, num3, num4, num4);
  }
  multiply(key, num4, num3, num2);

  for (uint32_t i = len - 1;~i;--i)
  {
    if (num4[i] < key[i + 2])
      break;
    if (num4[i] > key[i + 2]) {
      substract(key, num4);
      break;
    }
  }

  for (uint32_t i = len - 1;~i;--i)
    num1[len - i - 1] = reverse_bytes(num4[i]);
  memcpy(data, num, data_len);

  if (num[0] != 0)
    return -2;
  if (num[1] != 1)
    return -2;

  for (uint32_t i = 2;i < 0xff - token_len;++i)
    if (num[i] != 0xff)
      return -2;
  if (num[0xff - token_len] != 0)
    return -2;

  for (uint32_t i = 0;i < token_len;++i)
    token[i] = num[0x100 - token_len + i];

  return 0;
}
