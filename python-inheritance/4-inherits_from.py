#!/usr/bin/python3
"""Defines a strict inheritance checking function."""


def inherits_from(obj, a_class):
    """Return True when obj inherits from a_class but is not exactly it."""
    return isinstance(obj, a_class) and type(obj) is not a_class
