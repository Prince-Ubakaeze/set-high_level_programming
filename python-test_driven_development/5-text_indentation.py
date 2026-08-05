#!/usr/bin/python3
"""Text indentation module.

This module supplies one function, ``text_indentation``, which prints
a text with two new lines after each ``.``, ``?`` and ``:``.
"""


def text_indentation(text):
    """Print ``text`` with two new lines after each of . ? and : ."""
    if not isinstance(text, str):
        raise TypeError("text must be a string")

    buffer = ""
    for char in text:
        buffer += char
        if char in ".?:":
            print(buffer.strip())
            print()
            buffer = ""
    if buffer.strip() != "":
        print(buffer.strip(), end="")
