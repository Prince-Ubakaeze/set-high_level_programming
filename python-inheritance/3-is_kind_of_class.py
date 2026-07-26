#!/usr/bin/python3
"""Defines a class and subclass membership function."""


def is_kind_of_class(obj, a_class):
    """Return True when obj is an instance of a_class or its subclass."""
    return isinstance(obj, a_class)
