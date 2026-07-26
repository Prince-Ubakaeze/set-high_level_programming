# Python: Classes and Objects

## Description

This directory contains Python exercises focused on object-oriented
programming, class design, encapsulation, properties, validation, special
methods, comparison operators, and linked-list implementation.

The project is part of the `set-high_level_programming` repository.

## Learning Objectives

By completing these tasks, I learned how to:

- Define Python classes and create instances
- Use the `__init__` constructor
- Create private instance attributes
- Validate attribute types and values
- Use `@property` getters and setters
- Raise `TypeError` and `ValueError` exceptions
- Define public instance methods
- Control printed object representations with `__str__`
- Use class instances with comparison operators
- Implement linked-list nodes and sorted insertion
- Translate Python bytecode into readable source code
- Apply encapsulation to protect object state

## Requirements

- Ubuntu Linux
- Python 3
- Python files begin with:

```python
#!/usr/bin/python3
```

- No external Python modules are required.
- The `math` standard-library module is used only in `103-magic_class.py`.

## Files

| File | Description |
|---|---|
| `0-square.py` | Defines an empty `Square` class |
| `1-square.py` | Adds a private square size attribute |
| `2-square.py` | Validates the square size during construction |
| `3-square.py` | Adds an area calculation method |
| `4-square.py` | Adds a size property with getter and setter |
| `5-square.py` | Prints a square using `#` characters |
| `6-square.py` | Adds validated square positioning |
| `100-singly_linked_list.py` | Defines nodes and a sorted singly linked list |
| `101-square.py` | Defines a printable square using `__str__` |
| `102-square.py` | Compares square instances by area |
| `103-magic_class.py` | Recreates a circle class from Python bytecode |

## Key Concepts

### Private Attributes

A double underscore triggers name mangling:

```python
self.__size
```

Internally, Python stores this using a name such as:

```python
_Square__size
```

This discourages direct external modification and allows validation through a
property setter.

### Properties

Properties allow an attribute to be accessed naturally while still validating
new values:

```python
@property
def size(self):
    return self.__size

@size.setter
def size(self, value):
    self.__size = value
```

### Special Methods

`__str__` controls the result of:

```python
print(object)
```

Comparison methods such as `__lt__`, `__eq__`, and `__ge__` define how class
instances behave with operators including `<`, `==`, and `>=`.

### Sorted Linked List

The singly linked-list task inserts each new node into the correct increasing
position rather than sorting the whole list afterwards.

## Usage

Make the files executable:

```bash
chmod +x *.py
```

Run a supplied test file:

```bash
./0-main.py
./6-main.py
./100-main.py
```

Run Python syntax checks:

```bash
python3 -m py_compile ./*.py
```

## Examples

Create and use a square:

```python
Square = __import__("4-square").Square

square = Square(5)
print(square.area())
square.size = 3
print(square.area())
```

Create a sorted linked list:

```python
SinglyLinkedList = \
    __import__("100-singly_linked_list").SinglyLinkedList

linked_list = SinglyLinkedList()
linked_list.sorted_insert(5)
linked_list.sorted_insert(1)
linked_list.sorted_insert(3)
print(linked_list)
```

## Author

Prince Chibuike Ubakaeze
