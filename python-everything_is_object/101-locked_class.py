#!/usr/bin/python3
"""Defines a class that restricts dynamic attributes."""


class LockedClass:
    """Allows only the first_name instance attribute."""

    __slots__ = ("first_name",)
