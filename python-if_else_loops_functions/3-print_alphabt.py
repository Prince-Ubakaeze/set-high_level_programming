#!/usr/bin/python3
for code in range(97, 123):
    if code != 101 and code != 113:
        print("{:c}".format(code), end="")
