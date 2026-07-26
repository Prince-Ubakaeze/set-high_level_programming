#!/usr/bin/python3
"""Defines a function that adds an attribute when possible."""


def add_attribute(obj, attr, value):
    """Add an attribute to obj or raise TypeError when impossible."""
    if not hasattr(obj, "__dict__"):
        raise TypeError("can't add new attribute")
    setattr(obj, attr, value)
