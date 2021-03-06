_sqrt_tab db 0,16,22,27,32,35,39,42,45,48,50,53,55,57,59,61
db 64,65,67,69,71,73,75,76,78,80,81,83,84,86,87,89
db 90,91,93,94,96,97,98,99,101,102,103,104,106,107,108,109
db 110,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126
db 128,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142
db 143,144,144,145,146,147,148,149,150,150,151,152,153,154,155,155
db 156,157,158,159,160,160,161,162,163,163,164,165,166,167,167,168
db 169,170,170,171,172,173,173,174,175,176,176,177,178,178,179,180
db 181,181,182,183,183,184,185,185,186,187,187,188,189,189,190,191
db 192,192,193,193,194,195,195,196,197,197,198,199,199,200,201,201
db 202,203,203,204,204,205,206,206,207,208,208,209,209,210,211,211
db 212,212,213,214,214,215,215,216,217,217,218,218,219,219,220,221
db 221,222,222,223,224,224,225,225,226,226,227,227,228,229,229,230
db 230,231,231,232,232,233,234,234,235,235,236,236,237,237,238,238
db 239,240,240,241,241,242,242,243,243,244,244,245,245,246,246,247
db 247,248,248,249,249,250,250,251,251,252,252,253,253,254,254,255

isqrt:
         cmp    eax,10000h
         jb     c_15_0
         cmp    eax,1000000h
         jb     c_23_16

; bit 31..24
         cmp    eax,10000000h
         jb     c_27_24
         cmp    eax,40000000h
         jb     c_29_28
         shr    eax,24
         mov    al, [_sqrt_tab+eax]
         shl    eax,8
         ret
c_29_28: shr    eax,22
         mov    al, [_sqrt_tab+eax]
         shl    eax,7
         ret
c_27_24: cmp    eax,4000000h
         jb     c_25_24
         shr    eax,20
         mov    al, [_sqrt_tab+eax]
         shl    eax,6
         ret
c_25_24: shr    eax,18
         mov    al, [_sqrt_tab+eax]
         shl    eax,5
         ret

; bit 23..16
c_23_16: cmp    eax,100000h
         jb     c_19_16
         cmp    eax,400000h
         jb     c_21_20
         shr    eax,16
         mov    al, [_sqrt_tab+eax]
         shl    eax,4
         ret
c_21_20: shr    eax,14
         mov    al, [_sqrt_tab+eax]
         shl    eax,3
         ret
c_19_16: cmp    eax,40000h
         jb     c_17_16
         shr    eax,12
         mov    al, [_sqrt_tab+eax]
         shl    eax,2
         ret
c_17_16: shr    eax,10
         mov    al, [_sqrt_tab+eax]
         shl    eax,1
         ret

c_15_0:  cmp    eax,100h
         jb     c_7_0

; bit 15..8
         cmp    eax,1000h
         jb     c_11_8
         cmp    eax,4000h
         jb     c_13_12
         shr    eax,8
         mov    al, [_sqrt_tab+eax]
         ret
c_13_12: shr    eax,6
         mov    al, [_sqrt_tab+eax]
         shr    eax,1
         ret
c_11_8:  cmp    eax,400h
         jb     c_9_8
         shr    eax,4
         mov    al, [_sqrt_tab+eax]
         shr    eax,2
         ret
c_9_8:   shr    eax,2
         mov    al, [_sqrt_tab+eax]
         shr    eax,3
         ret
;bit 7..0
c_7_0:   cmp    eax,10h
         jb     c_3_0
         cmp    eax,40h
         jb     c_5_4
         mov    al, [_sqrt_tab+eax]
         shr    eax,4
         ret
c_5_4:   shl    eax,2
         mov    al, [_sqrt_tab+eax]
         shr    eax,5
         ret
c_3_0:   cmp    eax,4h
         jb     c_1_0
         shl    eax,4
         mov    al, [_sqrt_tab+eax]
         shr    eax,6
         ret
c_1_0:   shl    eax,6
         mov    al, [_sqrt_tab+eax]
         shr    eax,7
         ret





































