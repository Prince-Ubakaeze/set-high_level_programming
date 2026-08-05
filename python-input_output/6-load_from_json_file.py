#!/usr/bin/python3
"""Defines a function that creates an object from a JSON file."""
import json
 
 
def load_from_json_file(filename):
    """Return the Python object stored in the JSON file filename."""
    with open(filename, "r", encoding="utf-8") as f:
        return json.load(f)
