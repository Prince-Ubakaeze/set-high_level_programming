#!/usr/bin/python3
"""Lazy matrix multiplication module.

This module supplies one function, ``lazy_matrix_mul``, which
multiplies two matrices using NumPy. All argument validation is left
to NumPy, so the exceptions raised come from NumPy itself.
"""
import numpy as np


def lazy_matrix_mul(m_a, m_b):
    """Return the matrix product of ``m_a`` and ``m_b`` using NumPy."""
    return np.matmul(m_a, m_b)