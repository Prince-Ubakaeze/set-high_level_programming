#!/usr/bin/python3
"""Defines a list subclass with sorted printing."""


class MyList(list):
    """Represents a list that can print a sorted copy."""

    def print_sorted(self):
        """Print the list in ascending order without changing it."""
        print(sorted(self))
