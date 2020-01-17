.global verify
.global multiply
.global subtract
.global extracted_key

.data

extracted_key:
  .quad 0x5d57403f00000040
  .quad 0x39165ba135fb5041
  .quad 0x20e96f4a5b217172
  .quad 0x55e1a5ba05fcf186
  .quad 0xe051ba9e51ee9d3e
  .quad 0x75e614bcc71e77e1
  .quad 0x71652d68d37bc9d9
  .quad 0x393ee7739f8b04e2
  .quad 0x855c2df1608ed5e6
  .quad 0xc271c1ea811b105d
  .quad 0x3c6a081d1807e7fc
  .quad 0xc07317a190d20585
  .quad 0xa876bb41d3dc3d29
  .quad 0xb5f62195dbbe4e5b
  .quad 0x460ba7cf3cd83cb7
  .quad 0x7d57d06f51a34921
  .quad 0xb0669915fa3317dd
  .quad 0x029a3a73755682d0
  .quad 0x151bd2ed7b438945
  .quad 0xf2856318edc49bdf
  .quad 0xdcbcf49f866ddf6b
  .quad 0x998d3235181d9a1e
  .quad 0x5bd5da7e50aabfdb
  .quad 0xcc97ef2d4476c365
  .quad 0x76f964a575f4438c
  .quad 0x238d8e9fc32588c6
  .quad 0x530679bfcfe00661
  .quad 0x0868dae6788f30b5
  .quad 0x8804fdf3938be1fa
  .quad 0x731ed3e5d4c2d779
  .quad 0xbc13f0288d9a7c16
  .quad 0x4f0d13c40ec5c8ab
  .quad 0xb7fbcde320b827e3
  .quad 0xd0c7d6d2a398baab
  .quad 0x9acb6543caeebfa4
  .quad 0xf577f1e509e7e9a7
  .quad 0x7921d6154131f364
  .quad 0xbe9e8cc29d1712b4
  .quad 0xdc9eb8272d8cc54c
  .quad 0x033c4d08dc0dfc7e
  .quad 0xfbe3f298bd6e45c2
  .quad 0xdc7e57a0e06c0490
  .quad 0xbad9c25c0848d21b
  .quad 0x04f04b2a0d941cf6
  .quad 0x854ecb29807c58ab
  .quad 0xd7919c8fd714f2ba
  .quad 0x55aae85606957e7e
  .quad 0xa53b22c3f2fd57ba
  .quad 0x3c6ab0b8599564d6
  .quad 0x4927e8617562feeb
  .quad 0x44842445b3b9a1df
  .quad 0x5917b807baa06ee4
  .quad 0x17ec410f63bb8467
  .quad 0x408600a06f4b8956
  .quad 0x3a3b13f4fd26c73e
  .quad 0x5e9db9dbdcd39eb5
  .quad 0x334cf7efaeb45e3a
  .quad 0xe0de7c5c48932c8f
  .quad 0x0f2477833cb41279
  .quad 0x3c7e07211e6af139
  .quad 0x5378d72028d9697c
  .quad 0xf7c21e60570d55eb
  .quad 0x61cb74a4d518da21
  .quad 0xb26807fa231f0935
  .quad 0x49a70dfe41f1b3e2
  .long 0x00010001

sig:
  .quad 0xc672a3de7b34dcda
  .quad 0x0ef3c9ea00e2c4b4
  .quad 0x816f4c4f45c00467
  .quad 0x2b7e0974d24f401b
  .quad 0x75a456dfffe85bf8
  .quad 0xa325e8cd319fd592
  .quad 0x0a15e0303a071e60
  .quad 0xfe16935bce63d542
  .quad 0x1a41067e3ac63805
  .quad 0x41d786cf4b9604d3
  .quad 0xc9e39cdde57363b7
  .quad 0x554d95a0b4c15f49
  .quad 0xb79f830c64936380
  .quad 0xd47141982f1303fe
  .quad 0x2435505cdbf0fb29
  .quad 0xb54e95d86c35b0b6
  .quad 0x052e35c2f204e36a
  .quad 0x2b7c88da0f495810
  .quad 0xea54cd1066e9edcd
  .quad 0xbcb00cfbc42ea4c7
  .quad 0x0ab8fcd1fff36bf5
  .quad 0xfaa9f1c3b4b15ed0
  .quad 0x4fe9dc8e313bed71
  .quad 0xd92d5335afbb4169
  .quad 0x65230b08e58719c2
  .quad 0xcb4bc042dbe88ca9
  .quad 0xd332aca483889604
  .quad 0x6dd8a8b02a990254
  .quad 0xb14484ec7f03cdde
  .quad 0x69d22dfeb8e1af1d
  .quad 0x368e75d32e577219
  .quad 0xe5d0f426feda8602

.text

verify:
                STP             X28, X0, [SP,#-0x40]!
                STP             X22, X21, [SP,#0x10]
                STP             X20, X19, [SP,#0x20]
                STP             X29, X30, [SP,#0x30]
                ADD             X29, SP, #0x30
                SUB             SP, SP, #0x410
                MOV             X21, X4
                MOV             X8, X0
                MOV             X20, X3
                MOV             X19, X2
                MOV             W0, #2
                CBZ             X8, .loc_1DA8
                CMP             X1, #0x100
                B.NE            .loc_1DA8
                MOV             W0, #3
                CBZ             X19, .loc_1DA8
                CMP             X20, #0xF5
                B.HI            .loc_1DA8
                CBZ             X21, .loc_1C74
                MOV             X10, XZR
                ADD             X13, SP, #0x308
                B               .loc_1B98
.loc_1B8C:
                LDRB            W9, [X8],#1
                ADD             X10, X10, #1
                STRB            W9, [X13],#1
.loc_1B98:
                CMP             X10, #0x100
                B.NE            .loc_1B8C
                LDRSW           X8, [X21]
                MOV             X10, XZR
                ADD             X9, SP, #0x208
                LSL             W12, W8, #2
                SUB             W11, W12, #4
                ADD             X12, SP, #0x308
                B               .loc_1BF4
.loc_1BBC:
                ADD             W13, W11, #1
                LDRB            W15, [X12,W11,SXTW]
                ADD             W14, W11, #2
                ADD             W16, W11, #3
                LDRB            W13, [X12,W13,SXTW]
                ADD             X10, X10, #1
                LDRB            W14, [X12,W14,SXTW]
                LSL             W17, W15, #0x18
                LDRB            W16, [X12,W16,SXTW]
                SUB             W11, W11, #4
                BFI             W17, W13, #0x10, #8
                BFI             W17, W14, #8, #8
                ORR             W1, W17, W16
                STR             W1, [X9],#4
.loc_1BF4:
                CMP             X10, X8
                B.LT            .loc_1BBC
                LDR             W8, [X21,#0x208]
                CMP             W8, #3
                B.EQ            .loc_1C7C
                MOV             W11, #0x10001
                CMP             W8, W11
                B.NE            .loc_1CC0
                ADD             X3, X21, #0x108
                ADD             X1, SP, #0x108
                ADD             X2, SP, #0x208
                MOV             X0, X21
                BL              multiply
                MOV             W22, WZR
                B               .loc_1C5C
.loc_1C30:
                ADD             X1, SP, #8
                ADD             X2, SP, #0x108
                ADD             X3, SP, #0x108
                MOV             X0, X21
                BL              multiply
                ADD             X1, SP, #0x108
                ADD             X2, SP, #8
                ADD             X3, SP, #8
                MOV             X0, X21
                BL              multiply
                ADD             W22, W22, #2
.loc_1C5C:
                CMP             W22, #0xF
                B.LE            .loc_1C30
                ADD             X22, SP, #8
                ADD             X1, SP, #8
                ADD             X2, SP, #0x108
                B               .loc_1CB0
.loc_1C74:
                MOV             W0, #4
                B               .loc_1DA8
.loc_1C7C:
                ADD             X3, X21, #0x108
                ADD             X1, SP, #0x108
                ADD             X2, SP, #0x208
                MOV             X0, X21
                ADD             X22, SP, #0x108
                BL              multiply
                ADD             X1, SP, #8
                ADD             X2, SP, #0x108
                ADD             X3, SP, #0x108
                MOV             X0, X21
                BL              multiply
                ADD             X1, SP, #0x108
                ADD             X2, SP, #8
.loc_1CB0:
                ADD             X3, SP, #0x208
                MOV             X0, X21
                BL              multiply
                B               .loc_1CC4
.loc_1CC0:
                MOV             X22, XZR
.loc_1CC4:
                LDR             W9, [X21]
                SXTW            X11, W9
                SBFIZ           X12, X9, #2, #0x20
.loc_1CD0:
                CBZ             W11, .loc_1CFC
                ADD             X16, X22, X12
                ADD             X17, X21, X12
                LDUR            W8, [X16,#-4]
                LDR             W10, [X17,#4]
                CMP             W8, W10
                B.CC            .loc_1D0C
                SUB             X11, X11, #1
                SUB             X12, X12, #4
                CMP             W8, W10
                B.LS            .loc_1CD0
.loc_1CFC:
                MOV             X0, X21
                MOV             X1, X22
                BL              subtract
                LDR             W9, [X21]
.loc_1D0C:
                ADD             X8, SP, #0x308
                SXTW            X13, W9
                B               .loc_1D44
.loc_1D18:
                ADD             X0, X22, X13,LSL#2
                MOV             X13, X11
                LDUR            W12, [X0,#-4]
                LSR             W2, W12, #0x18
                STRB            W12, [X8,#3]
                LSR             W3, W12, #0x10
                LSR             W4, W12, #8
                STRB            W2, [X8]
                STRB            W3, [X8,#1]
                STRB            W4, [X8,#2]
                ADD             X8, X8, #4
.loc_1D44:
                SUBS            X11, X13, #1
                B.GE            .loc_1D18
                LDRB            W5, [SP,#0x308]
                CBNZ            W5, .loc_1DA4
                LDRB            W9, [SP,#0x309]
                CMP             W9, #1
                B.NE            .loc_1DA4
                MOV             W12, #0x100
                MOV             W13, #0xFF
                SUB             X9, X12, X20
                SUB             X10, X13, X20
                MOV             W14, #2
                ADD             X15, SP, #0x308
                MOV             W0, #5
.loc_1D7C:
                CMP             X14, X10
                B.CS            .loc_1D98
                LDRB            W17, [X15,X14]
                ADD             X14, X14, #1
                CMP             W17, #0xFF
                B.EQ            .loc_1D7C
                B               .loc_1DA8
.loc_1D98:
                ADD             X11, SP, #0x308
                LDRB            W6, [X11,X10]
                CBZ             W6, .loc_1DEC
.loc_1DA4:
                MOV             W0, #5
.loc_1DA8:
                ADD             SP, SP, #0x410
                LDP             X29, X30, [SP,#0x30]
                LDP             X20, X19, [SP,#0x20]
                LDP             X22, X21, [SP,#0x10]
                LDP             X28, X1, [SP],#0x40

                ADD             X2, SP, #-0x148
                MOV             X3, #0x20
1:
                LDR             X4, [X2],#8
                STR             X4, [X1],#8
                SUBS            X3, X3, #1
                B.NE            1b

                RET
.loc_1DD4:
                LDRB            W7, [X11,X9]
                STRB            W7, [X19]
                ADD             X9, X9, #1
                ADD             X19, X19, #1
.loc_1DEC:
                CMP             X9, #0xFF
                B.LS            .loc_1DD4
                CMP             X9, #0x100
                CSET            W0, NE
                B               .loc_1DA8
.loc_1E00:
                MOV             W0, #1
                B               .loc_1DA8

multiply:
                STR             X25, [SP,#-0x50]!
                STP             X24, X23, [SP,#0x10]
                STP             X22, X21, [SP,#0x20]
                STP             X20, X19, [SP,#0x30]
                STP             X29, X30, [SP,#0x40]
                ADD             X29, SP, #0x40
                MOV             X19, X3
                MOV             X20, X2
                MOV             X21, X1
                MOV             X22, X0
                MOV             X9, XZR
                B               .loc_1E44
.loc_1E3C:
                STR             WZR, [X21,X9,LSL#2]
                ADD             X9, X9, #1
.loc_1E44:
                LDRSW           X8, [X22]
                CMP             X9, X8
                B.LT            .loc_1E3C
                MOV             X23, XZR
                ADD             X24, X19, #4
                MOV             X25, #0x100000000
                B               .loc_1EF8
.loc_1E60:
                LDR             W10, [X20],#4
                LDR             W13, [X19]
                MOV             X11, XZR
                LDR             W15, [X21]
                MOV             X9, XZR
                LDP             W12, W17, [X22,#4]
                MADD            X14, X13, X10, X15
                MUL             W12, W12, W14
                MUL             X15, X12, X17
                ADD             X13, X15, W14,UXTW
                B               .loc_1EC4
.loc_1E8C:
                ADD             X8, X22, X11,LSL#2
                ADD             X17, X21, X11,LSL#2
                LDR             W11, [X24,X11,LSL#2]
                ADD             X9, X9, X25
                LDR             W0, [X8,#0xC]
                LDR             W1, [X17,#4]
                MADD            X2, X11, X10, X16
                MOV             X11, X15
                MUL             X3, X0, X12
                ADD             X14, X2, X1
                ADD             X16, X3, X13,LSR#32
                ADD             X13, X16, W14,UXTW
                STR             W13, [X17]
                LDR             W8, [X22]
.loc_1EC4:
                ADD             X15, X11, #1
                LSR             X16, X14, #0x20
                CMP             X15, W8,SXTW
                B.LT            .loc_1E8C
                ADD             X4, X16, X13,LSR#32
                ASR             X5, X9, #0x1E
                STR             W4, [X21,X5]
                TBZ             X4, #0x20, .loc_1EF0
                MOV             X0, X22
                MOV             X1, X21
                BL              subtract
.loc_1EF0:
                LDR             W8, [X22]
                ADD             X23, X23, #1
.loc_1EF8:
                CMP             X23, W8,SXTW
                B.LT            .loc_1E60
                LDP             X29, X30, [SP,#0x40]
                LDP             X20, X19, [SP,#0x30]
                LDP             X22, X21, [SP,#0x20]
                LDP             X24, X23, [SP,#0x10]
                LDR             X25, [SP],#0x50
                RET

subtract:
                MOV             X8, XZR
                MOV             X10, XZR
                ADD             X9, X0, #8
                B               .loc_1F44
.loc_1F28:
                LDR             W12, [X1]
                ADD             X8, X8, #1
                LDR             W13, [X9],#4
                SUB             X14, X12, X13
                ADD             X15, X14, X10
                ASR             X10, X15, #0x20
                STR             W15, [X1],#4
.loc_1F44:
                LDRSW           X11, [X0]
                CMP             X8, X11
                B.LT            .loc_1F28
                RET
