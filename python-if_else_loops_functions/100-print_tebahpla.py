#!/usr/bin/python3
for code in range(122, 96, -1):
    print("{:c}".format(code if code % 2 == 0 else code - 32), end="")
