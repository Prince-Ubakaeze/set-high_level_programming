#!/usr/bin/python3
"""Defines an exact class comparison function."""


def is_same_class(obj, a_class):
    """Return True when obj is exactly an instance of a_class."""
    return type(obj) is a_class
