# Python: Inheritance

## Description

This directory contains Python exercises focused on inheritance, class
relationships, type inspection, method overriding, abstract-style base
classes, validation, built-in type subclassing, and dynamic attributes.

The project belongs to the `set-high_level_programming` repository.

## Learning Objectives

By completing these tasks, I learned how to:

- Inspect an object with `dir()`
- Create subclasses of built-in types such as `list` and `int`
- Distinguish exact class identity from broader inheritance relationships
- Use `type()` and `isinstance()` correctly
- Detect strict subclass relationships
- Define and extend base classes
- Override inherited methods
- Call parent initialisers with `super()`
- Validate constructor arguments in a base class
- Use private instance attributes in subclasses
- Create meaningful string representations with `__str__`
- Override comparison operators
- Add attributes dynamically when an object permits it
- Write doctests for classes and validation behaviour

## Requirements

- Ubuntu Linux
- Python 3
- Python files begin with:

```python
#!/usr/bin/python3
```

- No external modules are used.
- Test files use Python's built-in `doctest` module.

## Files

| File | Description |
|---|---|
| `0-lookup.py` | Returns an object's available attributes and methods |
| `1-my_list.py` | Defines a list subclass that prints a sorted copy |
| `tests/1-my_list.txt` | Doctests for `MyList` |
| `2-is_same_class.py` | Checks exact class identity |
| `3-is_kind_of_class.py` | Checks class or subclass membership |
| `4-inherits_from.py` | Checks strict inheritance |
| `5-base_geometry.py` | Defines an empty `BaseGeometry` class |
| `6-base_geometry.py` | Adds an unimplemented `area()` method |
| `7-base_geometry.py` | Adds positive-integer validation |
| `tests/7-base_geometry.txt` | Doctests for geometry validation |
| `8-rectangle.py` | Defines a validated Rectangle subclass |
| `9-rectangle.py` | Adds area and string representation |
| `10-square.py` | Defines a Square inherited from Rectangle |
| `11-square.py` | Adds a Square-specific string representation |
| `100-my_int.py` | Defines an integer with inverted equality operators |
| `101-add_attribute.py` | Adds a new attribute when the object supports it |

## Core Concepts

### Exact Class Versus Inheritance

Use:

```python
type(obj) is a_class
```

when the object must be exactly an instance of that class.

Use:

```python
isinstance(obj, a_class)
```

when instances of subclasses should also be accepted.

A strict inheritance check combines both:

```python
isinstance(obj, a_class) and type(obj) is not a_class
```

### Base Class Validation

`BaseGeometry.integer_validator()` centralises positive-integer validation.
Rectangle and Square reuse this inherited method rather than duplicating the
same rules.

The validator uses:

```python
type(value) is not int
```

instead of `not isinstance(value, int)` so that Boolean values are rejected.
In Python, `bool` is a subclass of `int`, a charming historical detail that
occasionally wanders into validation logic uninvited.

### Method Overriding

A subclass can replace an inherited method with its own implementation.
`Square.__str__()` overrides the Rectangle description while retaining the
inherited Rectangle behaviour and validation.

### Built-in Type Inheritance

`MyList` extends `list` with `print_sorted()` while preserving all normal list
operations.

`MyInt` extends `int` and reverses the results of `==` and `!=`.

## Usage

Make Python files executable:

```bash
chmod +x ./*.py
```

Run supplied test programs:

```bash
./0-main.py
./9-main.py
./11-main.py
```

Run the doctests:

```bash
python3 -m doctest -v tests/1-my_list.txt
python3 -m doctest -v tests/7-base_geometry.txt
```

Validate Python syntax:

```bash
python3 -m py_compile ./*.py
```
