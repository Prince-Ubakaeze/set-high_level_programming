# Python: More Data Structures

## Description

This directory contains Python and C exercises covering advanced use of lists,
sets, dictionaries, `map`, lambda functions, Roman numeral conversion, weighted
averages, and selected CPython internals.

The project belongs to the `set-high_level_programming` repository.

## Learning Objectives

By completing these tasks, I learned how to:

- Create new matrices without modifying the original matrix
- Use list and dictionary comprehensions
- Replace values while preserving the original collection
- Remove duplicate integers using sets
- Find intersections and symmetric differences between sets
- Count, sort, add, update, and delete dictionary keys
- Build new dictionaries from existing dictionaries
- Find the key associated with the largest dictionary value
- Use `map()` and lambda expressions without explicit loops
- Convert Roman numerals to integers
- Calculate weighted averages
- Delete dictionary entries by matching their values
- Inspect Python lists and bytes objects through the CPython C API

## Requirements

### Python

- Ubuntu Linux
- Python 3
- Python files begin with:

```python
#!/usr/bin/python3
```

- No external Python modules are required.

### C and CPython

Task `103-python.c` was designed for:

- Ubuntu 14.04 LTS
- Python 3.4
- GCC with C99 support

The original compilation command is:

```bash
gcc -Wall -Werror -Wextra -pedantic -std=c99 -shared \
-Wl,-soname,libPython.so -o libPython.so -fPIC \
-I/usr/include/python3.4 103-python.c
```

Modern Linux systems may not include the old Python 3.4 development headers, so
the CPython task may need to be compiled in the course-provided environment.

## Files

| File | Description |
|---|---|
| `0-square_matrix_simple.py` | Returns a new matrix with every value squared |
| `1-search_replace.py` | Replaces matching list values in a new list |
| `2-uniq_add.py` | Adds each unique integer only once |
| `3-common_elements.py` | Returns common elements from two sets |
| `4-only_diff_elements.py` | Returns elements found in only one of two sets |
| `5-number_keys.py` | Returns the number of dictionary keys |
| `6-print_sorted_dictionary.py` | Prints a dictionary using sorted keys |
| `7-update_dictionary.py` | Adds or updates a dictionary key and value |
| `8-simple_delete.py` | Deletes a dictionary key when it exists |
| `9-multiply_by_2.py` | Returns a new dictionary with doubled values |
| `10-best_score.py` | Returns the key with the largest integer value |
| `11-multiply_list_map.py` | Multiplies list values using `map()` |
| `12-roman_to_int.py` | Converts a Roman numeral to an integer |
| `100-weight_average.py` | Calculates the weighted average of score tuples |
| `101-square_matrix_map.py` | Squares matrix values using nested `map()` calls |
| `102-complex_delete.py` | Deletes every dictionary key matching a value |
| `103-python.c` | Prints CPython list and bytes object information |

## Usage

Make the Python files executable:

```bash
chmod +x *.py
```

Run a script or supplied test file:

```bash
./0-main.py
./12-main.py
```

Run basic syntax validation:

```bash
python3 -m py_compile ./*.py
```

Compile the CPython extension in a Python 3.4 environment:

```bash
gcc -Wall -Werror -Wextra -pedantic -std=c99 -shared \
-Wl,-soname,libPython.so -o libPython.so -fPIC \
-I/usr/include/python3.4 103-python.c
```

## Key Concepts

### Set Operations

```python
set_1 & set_2
```

returns their common elements, while:

```python
set_1 ^ set_2
```

returns elements present in only one set.

### Dictionary Comprehension

```python
{key: value * 2 for key, value in a_dictionary.items()}
```

creates a new dictionary without modifying the original dictionary.

### Roman Numeral Conversion

The Roman numeral function scans symbols from right to left. A value smaller
than the most recent larger value is subtracted; otherwise, it is added.

### Complexity

Most collection-processing functions run in linear time relative to the number
of input elements. Set and dictionary operations generally provide efficient
average-case lookup behaviour.
