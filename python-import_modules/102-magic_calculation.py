#!/usr/bin/python3
"""Reproduce the supplied Python bytecode."""

from magic_calculation_102 import add, sub


def magic_calculation(a, b):
    """Return the value produced by the supplied bytecode."""
    if a < b:
        c = add(a, b)
        for i in range(4, 6):
            c = add(c, i)
        return c

    return sub(a, b)
