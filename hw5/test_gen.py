#!/bin/python3

import random

n = 1000000

inputs = 35

output_fn = "input2-2.txt"

with open(output_fn, "w") as f:
    for i in range(n):
        for j in range(inputs):
            v = random.randint(0, 1)
            f.write(f"{v}")

        f.write("\n")

