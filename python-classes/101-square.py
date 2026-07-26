#!/usr/bin/python3
"""Defines a Square whose string form matches my_print()."""


class Square:
    """Represents a square."""

    def __init__(self, size=0, position=(0, 0)):
        self.size = size
        self.position = position

    @property
    def size(self):
        """Return the square size."""
        return self.__size

    @size.setter
    def size(self, value):
        """Set and validate the square size."""
        if not isinstance(value, int):
            raise TypeError("size must be an integer")
        if value < 0:
            raise ValueError("size must be >= 0")
        self.__size = value

    @property
    def position(self):
        """Return the square position."""
        return self.__position

    @position.setter
    def position(self, value):
        """Set and validate the square position."""
        if (
            not isinstance(value, tuple)
            or len(value) != 2
            or not all(isinstance(item, int) for item in value)
            or not all(item >= 0 for item in value)
        ):
            raise TypeError(
                "position must be a tuple of 2 positive integer"
            )
        self.__position = value

    def area(self):
        """Return the area of the square."""
        return self.__size ** 2

    def my_print(self):
        """Print the square."""
        print(self)

    def __str__(self):
        if self.__size == 0:
            return ""

        rows = []
        rows.extend("" for _ in range(self.__position[1]))
        rows.extend(
            " " * self.__position[0] + "#" * self.__size
            for _ in range(self.__size)
        )
        return "\n".join(rows)
