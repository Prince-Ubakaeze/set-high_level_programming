#!/usr/bin/python3
"""Defines a geometry base class with integer validation."""


class BaseGeometry:
    """Represents a geometry base class."""

    def area(self):
        """Raise an exception because subclasses must implement area."""
        raise Exception("area() is not implemented")

    def integer_validator(self, name, value):
        """Validate that value is a positive integer."""
        if type(value) is not int:
            raise TypeError("{} must be an integer".format(name))
        if value <= 0:
            raise ValueError("{} must be greater than 0".format(name))
