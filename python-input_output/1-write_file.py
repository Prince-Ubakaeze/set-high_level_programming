#!/usr/bin/python3
"""Defines a function that writes a string to a UTF-8 text file."""
 
 
def write_file(filename="", text=""):
    """Write text to a UTF-8 file and return the number of characters."""
    with open(filename, "w", encoding="utf-8") as f:
        return f.write(text)
    
