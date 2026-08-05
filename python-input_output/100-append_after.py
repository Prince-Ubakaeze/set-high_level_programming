#!/usr/bin/python3
"""Defines a function that inserts text after matching lines in a file."""
 
 
def append_after(filename="", search_string="", new_string=""):
    """Insert new_string after each line containing search_string."""
    with open(filename, "r", encoding="utf-8") as f:
        lines = f.readlines()
 
    content = ""
    for line in lines:
        content += line
        if search_string in line:
            content += new_string
 
    with open(filename, "w", encoding="utf-8") as f:
        f.write(content)
