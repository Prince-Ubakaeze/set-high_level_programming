#!/usr/bin/python3
"""Defines a rebellious integer subclass."""


class MyInt(int):
    """Represents an integer with inverted equality operators."""

    def __eq__(self, other):
        """Return the opposite of normal equality."""
        return int.__ne__(self, other)

    def __ne__(self, other):
        """Return the opposite of normal inequality."""
        return int.__eq__(self, other)
