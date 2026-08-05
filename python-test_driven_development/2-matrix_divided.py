#!/usr/bin/python3
"""Matrix division module.

This module supplies one function, ``matrix_divided``, which divides
every element of a matrix by a number.
"""


def matrix_divided(matrix, div):
    """Return a new matrix with all elements of ``matrix`` divided by ``div``.

    Every result is rounded to 2 decimal places.
    """
    err = "matrix must be a matrix (list of lists) of integers/floats"

    if not isinstance(matrix, list) or matrix == []:
        raise TypeError(err)
    for row in matrix:
        if not isinstance(row, list) or row == []:
            raise TypeError(err)
        for element in row:
            if not isinstance(element, (int, float)):
                raise TypeError(err)
    if any(len(row) != len(matrix[0]) for row in matrix):
        raise TypeError("Each row of the matrix must have the same size")
    if not isinstance(div, (int, float)):
        raise TypeError("div must be a number")
    if div == 0:
        raise ZeroDivisionError("division by zero")

    return [[round(element / div, 2) for element in row] for row in matrix]
