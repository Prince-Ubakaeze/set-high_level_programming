#!/usr/bin/python3
"""Defines an object attribute and method lookup function."""


def lookup(obj):
    """Return the list of available attributes and methods of obj."""
    return dir(obj)
