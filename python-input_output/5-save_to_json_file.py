#!/usr/bin/python3
"""Defines a function that writes an object to a file using JSON."""
import json


def save_to_json_file(my_obj, filename):
    """Write my_obj to filename using its JSON representation."""
    with open(filename, "w", encoding="utf-8") as f:
        json.dump(my_obj, f)
