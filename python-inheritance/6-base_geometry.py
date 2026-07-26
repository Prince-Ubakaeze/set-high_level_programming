#!/usr/bin/python3
"""Defines a geometry base class with an abstract area method."""


class BaseGeometry:
    """Represents a geometry base class."""

    def area(self):
        """Raise an exception because subclasses must implement area."""
        raise Exception("area() is not implemented")
