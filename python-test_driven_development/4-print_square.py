#!/usr/bin/python3
"""Square printing module.

This module supplies one function, ``print_square``, which prints a
square made of the ``#`` character.
"""


def print_square(size):
    """Print a square of ``size`` by ``size`` using the # character."""
    if not isinstance(size, int):
        raise TypeError("size must be an integer")
    if size < 0:
        raise ValueError("size must be >= 0")
    for _ in range(size):
        print("#" * size)
