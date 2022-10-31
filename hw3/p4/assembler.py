
src4 = """
ld r0,0
cmp r0,r0
add r0,#1
str 1,r0
"""

src5 = """
ld r0,0
ld r1,#0 
ld r2,#32
ld r3,#1
cmp r3,r3
add r3,#1
:loop
add r0,#0
bra noadd,E 
add r1,#1
:noadd
shf r0,#1
add r2,r3
bra end,Z
bra loop,A
:end
str 1,r1
hlt
"""

src6 = """
// load registers
ld r0,0 
ld r1,1
ld r2,#0 
ld r3,#4 
//iteration variable
ld r4,#1
cmp r4,r4
add r4,#1

:loop 
add r0,#0
bra noadd,E
add r2,r1
:noadd
shf r0,#1
shf r2,#1
add r3,r4
bra end,Z
bra loop,A
:end
str 2,r2
hlt
"""

src = src6

ops = ["NOP", "LD", "STR", "BRA", "XOR", "ADD", "ROT", "SHF", "HLT", "CMP"]

ccs = ["A", "P", "E", "C", "N", "Z", "NC", "PO"]

src = src.split("\n")

lables = {}

PC_BASE = 0x010

pc = PC_BASE # Code segment base address

# Resolve forward labels
for line in src:
    line = line.strip()

    if len(line) < 2 or line.startswith("//"):
        continue

    if line[0] == ':':
        lables[line[1:]] = pc
    else:
        pc += 1

pc = PC_BASE

for i in range(PC_BASE):
    print(32 * "0")

for line in src:
    line = line.strip()

    if len(line) < 2:
        continue

    if line.startswith("//") or line.startswith(":"):
        # print(f"                       // {line}")
        continue

    subline = line
    if "//" in line:
        subline = line[:line.index("//")]
    parts = subline.split()
    args = ""
    if len(parts) > 1:
        args = parts[1].split(",")

    opcode = format(ops.index(parts[0].upper()), '#06b')[2:]
    cc = "0000"
    src_t = "0"
    dst_t = "0"
    src_addr = "000000000000"
    dst_addr = "000000000000"

    if parts[0].upper() in {"NOP", "HLT"}:
        print(f"{opcode}{cc}{src_addr}{dst_addr}")
        continue

    if parts[0].upper() == "BRA":
        if args[1] in ccs:
            cc = format(ccs.index(args[1].strip()), '#06b')[2:]
        else:
            print(f"Error, '{args[1]}' is not a valid condition code.")
            exit()
    else:
        if args[1].startswith("#"):
            src_t = "1"
            src_addr = format(eval(args[1][1:], globals(), lables), '#014b')[2:] # Not secure
        elif args[1].upper().startswith("R"):
            src_addr = format(eval(args[1][1:], globals(), lables), '#014b')[2:]
        else:
            src_addr = format(eval(args[1], globals(), lables), '#014b')[2:]
    if args[0].upper().startswith("R"):
        dst_addr = format(eval(args[0][1:], globals(), lables), '#014b')[2:]
    else:
        dst_t = "1"
        dst_addr = format(eval(args[0], globals(), lables), '#014b')[2:]

    if parts[0].upper() != "BRA":
        cc = src_t + dst_t + "00"

    # print(f"{opcode}_{cc}_{src_addr}_{dst_addr}  // {line}")
    print(f"{opcode}{cc}{src_addr}{dst_addr} // {line}")

# print("\n// **** Symbol Table: ****")
# for sym in lables:
    # print(f"// * {f'{sym} '.ljust(15, '.')} {format(lables[sym], '#05x')}")

print()
