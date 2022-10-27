// clear registers
xor r1,r1
xor r2,r2
xor r3,r3
xor r4,r4
// load number from mem_addr 0
ld r1,0

loop:
add r1,#0
bra noadd,E
add r2,#1
noadd:
shf r1,#-1
bra done,Z
bra loop,A

done:
str 1,r2
hlt
