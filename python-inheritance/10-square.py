#!/usr/bin/python3
"""Defines a Square inherited from Rectangle."""

Rectangle = __import__("9-rectangle").Rectangle


class Square(Rectangle):
    """Represents a square."""

    def __init__(self, size):
        self.integer_validator("size", size)
        self.__size = size
        super().__init__(size, size)

    def area(self):
        """Return the square area."""
        return self.__size ** 2
