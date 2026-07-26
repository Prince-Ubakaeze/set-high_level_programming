#!/usr/bin/python3
"""Defines a complete Square inherited from Rectangle."""

Rectangle = __import__("9-rectangle").Rectangle


class Square(Rectangle):
    """Represents a square with a customised description."""

    def __init__(self, size):
        self.integer_validator("size", size)
        self.__size = size
        super().__init__(size, size)

    def area(self):
        """Return the square area."""
        return self.__size ** 2

    def __str__(self):
        """Return the square description."""
        return "[Square] {}/{}".format(
            self.__size, self.__size
        )
