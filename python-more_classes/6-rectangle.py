#!/usr/bin/python3
"""Defines a Rectangle that tracks active instances."""


class Rectangle:
    """Represents a rectangle."""

    number_of_instances = 0

    def __init__(self, width=0, height=0):
        self.__counted = False
        self.width = width
        self.height = height
        Rectangle.number_of_instances += 1
        self.__counted = True

    @property
    def width(self):
        """Return the rectangle width."""
        return self.__width

    @width.setter
    def width(self, value):
        """Set and validate the rectangle width."""
        if not isinstance(value, int):
            raise TypeError("width must be an integer")
        if value < 0:
            raise ValueError("width must be >= 0")
        self.__width = value

    @property
    def height(self):
        """Return the rectangle height."""
        return self.__height

    @height.setter
    def height(self, value):
        """Set and validate the rectangle height."""
        if not isinstance(value, int):
            raise TypeError("height must be an integer")
        if value < 0:
            raise ValueError("height must be >= 0")
        self.__height = value

    def area(self):
        """Return the rectangle area."""
        return self.__width * self.__height

    def perimeter(self):
        """Return the rectangle perimeter."""
        if self.__width == 0 or self.__height == 0:
            return 0
        return 2 * (self.__width + self.__height)

    def __str__(self):
        """Return the rectangle drawn with # characters."""
        if self.__width == 0 or self.__height == 0:
            return ""
        row = "#" * self.__width
        return "\n".join(row for _ in range(self.__height))

    def __repr__(self):
        """Return a representation that recreates the rectangle."""
        return "Rectangle({}, {})".format(self.__width, self.__height)

    def __del__(self):
        """Decrement the instance counter and report deletion."""
        if getattr(self, "_Rectangle__counted", False):
            Rectangle.number_of_instances -= 1
            self.__counted = False
            print("Bye rectangle...")
