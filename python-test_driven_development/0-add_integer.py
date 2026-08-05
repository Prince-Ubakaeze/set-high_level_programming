#!/usr/bin/python3
"""Integer addition module.

This module supplies one function, ``add_integer``, which adds two
numbers together after casting them to integers.
"""


def add_integer(a, b=98):
    """Return the integer addition of ``a`` and ``b``.

    Floats are casted to integers before the addition is performed.
    """
    if not isinstance(a, (int, float)):
        raise TypeError("a must be an integer")
    if not isinstance(b, (int, float)):
        raise TypeError("b must be an integer")
    return int(a) + int(b)
