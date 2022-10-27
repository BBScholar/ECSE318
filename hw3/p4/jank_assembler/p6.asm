xor r1,r1
xor r2,r2
xor r3,r3
xor r4,r4
xor r5,r5

// load a
ld r1,0
// load b
ld r2,1

ld r3,#4 
ld r5,#1
cmp r5,r5

loop: add r2,#0
bra noadd,E
add r4,r1
noadd:
shf r4,#1
shf r2,#-1
add r3, r5
bra done,Z
bra loop,A
done:
str 2,r4
hlt
