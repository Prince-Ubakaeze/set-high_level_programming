#!/usr/bin/python3
"""Defines a function that builds Pascal's triangle."""
 
 
def pascal_triangle(n):
    """Return a list of lists of integers representing Pascal's triangle."""
    triangle = []
    if n <= 0:
        return triangle
    for i in range(n):
        row = [1]
        if triangle:
            previous = triangle[-1]
            for j in range(len(previous) - 1):
                row.append(previous[j] + previous[j + 1])
            row.append(1)
        triangle.append(row)
    return triangle
