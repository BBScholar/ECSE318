

inp = """

"""

pc_base = 0x010
pc = pc_base

labels = {}


ops = ["NOP", "LD", "STR", "BRA", "XOR", "ADD", "ROT", "SHF", "HLT", "CMP"]
ccs = ["A", "P", "E", "C", "N", "Z", "NC", "PO"]

inp = inp .split("\n")

for line in inp:
    line = line.strip()
    if len(line) < 2 or line.startswith("//"):
        continue 
    
    if line[0] == ":":
        labels[line[1:]] = pc 
    else:
        pc += 1

pc = pc_base

for i in range(pc_base):
    print(32 * "0")

for line in inp:
    line = line.strip()

    if len(line) == 2:
        continue 

    if line.startswith("//") or line.startswith(":"):
        continue;

    parts = line.split()
    args = ""
    if len(parts) > 1:
        args = parts[1].split(",")

    opcode = format(ops.index(parts[0].upper()), "#06b")[2:]
    cc = "0000"
    src_t = "0"
    dst_t = "0"
    src_addr = "0000000000000000"
    dest_addr = "0000000000000000"

    if parts[0].upper() in {"NOP", "HLT"}:
        print(f"{opcode}_{cc}_{src_addr}_{dest_addr}")
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
        dest_addr = format(int(args[0][1:]) - 1, "#014b")[2:]
        # dst_addr = format(eval(args[0][1:], globals(), lables), '#014b')[2:]
    else:
        dst_t = "1"
        dest_addr = format(args[0],)
        # dst_addr = format(eval(args[0], globals(), lables), '#014b')[2:]

    if parts[0].upper() != "BRA":
        cc = src_t + dst_t + "00"

    print(f"{opcode}_{cc}_{src_addr}_{dest_addr}  // {line}")

