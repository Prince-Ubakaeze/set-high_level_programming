# Python: Data Structures

## Description

This directory contains Python and C exercises covering lists, tuples,
sequences, matrices, string manipulation, list mutation, linked lists, and
basic CPython internals.

The project is part of the `set-high_level_programming` repository.

## Learning Objectives

By completing these tasks, I learned how to:

- Create, access, update, copy, and delete list elements
- Validate list indexes safely without using `try` and `except`
- Iterate through lists in normal and reverse order
- Distinguish between modifying a list and returning a modified copy
- Work with nested lists as matrices
- Create and combine tuples
- Return multiple values from a function
- Find values in a list without relying on selected built-in functions
- Use list comprehensions to create new lists
- Work with strings without using `str.replace()`
- Swap variables using tuple unpacking
- Use pointers and linked-list traversal in C
- Detect whether a singly linked list is a palindrome efficiently
- Inspect Python list objects through the CPython C API

## Requirements

### Python

- Ubuntu Linux
- Python 3
- Python files begin with:

```python
#!/usr/bin/python3
```

### C

- GCC
- Betty-compatible formatting for C files
- The palindrome task can be compiled with:

```bash
gcc -Wall -Werror -Wextra -pedantic \
13-main.c linked_lists.c 13-is_palindrome.c -o palindrome
```

The CPython task was designed for Python 3.4 on Ubuntu 14.04 and uses:

```bash
gcc -Wall -Werror -Wextra -pedantic -std=c99 -shared \
-Wl,-soname,PyList -o libPyList.so -fPIC \
-I/usr/include/python3.4 100-print_python_list_info.c
```

## Files

| File | Description |
|---|---|
| `0-print_list_integer.py` | Prints every integer in a list |
| `1-element_at.py` | Retrieves a list element using a validated index |
| `2-replace_in_list.py` | Replaces an element in the original list |
| `3-print_reversed_list_integer.py` | Prints list integers in reverse order |
| `4-new_in_list.py` | Replaces an element in a copied list |
| `5-no_c.py` | Removes lowercase and uppercase `c` characters |
| `6-print_matrix_integer.py` | Prints a matrix of integers |
| `7-add_tuple.py` | Adds the first two values of two tuples |
| `8-multiple_returns.py` | Returns a string's length and first character |
| `9-max_integer.py` | Finds the largest integer without using `max()` |
| `10-divisible_by_2.py` | Identifies values divisible by two |
| `11-delete_at.py` | Deletes a list item at a specified index |
| `12-switch.py` | Swaps the values of two variables |
| `13-is_palindrome.c` | Checks whether a singly linked list is a palindrome |
| `lists.h` | Defines the linked-list structure and function prototypes |
| `100-print_python_list_info.c` | Prints basic CPython list information |

## Usage

Make Python files executable:

```bash
chmod +x *.py
```

Run a Python script:

```bash
./12-switch.py
```

Test a function using a supplied main file:

```bash
./0-main.py
```

Compile and run the palindrome task:

```bash
gcc -Wall -Werror -Wextra -pedantic \
13-main.c linked_lists.c 13-is_palindrome.c -o palindrome

./palindrome
```

## Complexity Note

The palindrome solution uses the fast-and-slow pointer technique, reverses the
second half of the list, compares both halves, and restores the original list.

- Time complexity: `O(n)`
- Extra space: `O(1)`
