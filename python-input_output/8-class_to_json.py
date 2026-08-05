#!/usr/bin/python3
"""Defines a function that returns the dictionary description of an object."""
 
 
def class_to_json(obj):
    """Return the dictionary description of obj for JSON serialization."""
    result = {}
    for key, value in vars(obj).items():
        if isinstance(value, (list, dict, str, int, float, bool)):
            result[key] = value
    return result

