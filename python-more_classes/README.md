# Python: More Classes and Objects

## Description

This directory contains Python exercises focused on progressively building a
`Rectangle` class and applying advanced object-oriented programming concepts.
It also includes a backtracking solution to the N-Queens problem.

The project is part of the `set-high_level_programming` repository.

## Learning Objectives

By completing these tasks, I learned how to:

- Define and instantiate Python classes
- Create private instance attributes
- Validate values using property getters and setters
- Calculate object area and perimeter
- Customise string output with `__str__`
- Create reproducible representations with `__repr__`
- Recreate objects using `eval(repr(object))`
- Detect object deletion with `__del__`
- Track active objects using class attributes
- Change object output using a configurable class attribute
- Define static methods and class methods
- Compare object instances using computed values
- Use recursion and backtracking to solve N-Queens
- Validate command-line arguments and exit statuses

## Requirements

- Ubuntu Linux
- Python 3
- Python files begin with:

```python
#!/usr/bin/python3
```

- Rectangle tasks do not import any modules.
- `101-nqueens.py` imports only the `sys` module.

## Files

| File | Description |
|---|---|
| `0-rectangle.py` | Defines an empty `Rectangle` class |
| `1-rectangle.py` | Adds validated width and height properties |
| `2-rectangle.py` | Adds area and perimeter methods |
| `3-rectangle.py` | Adds a `#`-based string representation |
| `4-rectangle.py` | Adds an `eval()`-compatible `__repr__` |
| `5-rectangle.py` | Reports when a rectangle is deleted |
| `6-rectangle.py` | Tracks the number of active instances |
| `7-rectangle.py` | Adds a configurable `print_symbol` |
| `8-rectangle.py` | Compares rectangles by area |
| `9-rectangle.py` | Adds a class method for creating squares |
| `101-nqueens.py` | Solves the N-Queens problem using backtracking |

## Key Concepts

### Properties and Validation

The rectangle dimensions are stored privately and accessed through properties:

```python
@property
def width(self):
    return self.__width
```

The corresponding setter rejects invalid types and negative values.

### String Representation

`__str__` returns the visual rectangle used by `print()` and `str()`.

`__repr__` returns:

```python
Rectangle(width, height)
```

This allows a new equivalent object to be created using `eval()` when the
`Rectangle` class is available.

### Class and Static Methods

`bigger_or_equal` is a static method because it compares two supplied
rectangles without relying on one particular instance.

`square` is a class method because it creates and returns a new instance of the
class with equal width and height.

### N-Queens Backtracking

The N-Queens solver places one queen per row. Before placing a queen, it checks
whether its column or either diagonal is already occupied. If a placement
eventually fails, the algorithm removes that queen and tries another column.

## Usage

Make all task files executable:

```bash
chmod +x *.py
```

Run a supplied rectangle test:

```bash
./0-main.py
./9-main.py
```

Run the N-Queens solver:

```bash
./101-nqueens.py 4
```

Expected number of solutions for `N = 4`:

```text
2
```

Validate all Python files:

```bash
python3 -m py_compile ./*.py
```

## Error Handling for N-Queens

Wrong number of arguments:

```text
Usage: nqueens N
```

Non-integer argument:

```text
N must be a number
```

Value below four:

```text
N must be at least 4
```

Each invalid invocation exits with status code `1`.

## Complexity Note

The N-Queens search is exponential in the worst case. Sets provide efficient
average-case checks for occupied columns and diagonals, reducing unnecessary
board scans during backtracking.
