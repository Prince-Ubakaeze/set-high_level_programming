#!/usr/bin/python3
"""Lazy matrix multiplication module.

This module supplies one function, ``lazy_matrix_mul``, which
multiplies two matrices using NumPy.
"""
import numpy as np


def lazy_matrix_mul(m_a, m_b):
    """Return the matrix product of ``m_a`` and ``m_b`` using NumPy."""
    for name, matrix in (("m_a", m_a), ("m_b", m_b)):
        if not isinstance(matrix, list):
            raise TypeError("{} must be a list".format(name))
        if not all(isinstance(row, list) for row in matrix):
            raise TypeError("{} must be a list of lists".format(name))
        if matrix == [] or matrix == [[]]:
            raise ValueError("{} can't be empty".format(name))
        msg = "{} should contain only integers or floats".format(name)
        for row in matrix:
            for element in row:
                if not isinstance(element, (int, float)):
                    raise TypeError(msg)
        size_msg = "each row of {} must be of the same size".format(name)
        if any(len(row) != len(matrix[0]) for row in matrix):
            raise TypeError(size_msg)

    if len(m_a[0]) != len(m_b):
        raise ValueError("m_a and m_b can't be multiplied")

    return np.matmul(m_a, m_b)
