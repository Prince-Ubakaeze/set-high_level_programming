#!/usr/bin/python3
"""Add all integer command-line arguments."""

from sys import argv


if __name__ == "__main__":
    total = 0

    for value in argv[1:]:
        total += int(value)

    print(total)
