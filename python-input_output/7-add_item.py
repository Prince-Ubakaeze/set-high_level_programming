#!/usr/bin/python3
"""Adds all command line arguments to a list saved in add_item.json."""
import sys

save_to_json_file = __import__('5-save_to_json_file').save_to_json_file
load_from_json_file = __import__('6-load_from_json_file').load_from_json_file

FILENAME = "add_item.json"

try:
    items = load_from_json_file(FILENAME)
except FileNotFoundError:
    items = []

items.extend(sys.argv[1:])
save_to_json_file(items, FILENAME)
