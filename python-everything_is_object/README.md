# Python: Everything Is Object

## Description

This project explores Python's object model, including object identity,
equality, mutability, immutability, aliasing, assignment, argument passing,
copies, tuples, CPython optimisations, and memory-efficient classes.

The directory belongs to the `set-high_level_programming` repository.

## Learning Objectives

By completing these tasks, I learned how to:

- Determine an object's type using `type()`
- Retrieve an object's identity using `id()`
- Distinguish between equality with `==` and identity with `is`
- Understand names as references to Python objects
- Recognise mutable and immutable object behaviour
- Explain the difference between mutation and reassignment
- Understand how Python passes object references to functions
- Create a shallow copy of a list
- Recognise valid tuple syntax
- Understand list behaviour with `+` and `+=`
- Preserve state between function calls
- Restrict instance attributes using `__slots__`
- Understand selected CPython integer and string optimisations

## Requirements

- Ubuntu Linux
- Python 3
- Python scripts begin with:

```python
#!/usr/bin/python3
```

- Answer files contain only the requested answer and a terminating newline.
- No external modules are used.

## Files

| File | Description |
|---|---|
| `0-answer.txt` | Function used to retrieve an object's type |
| `1-answer.txt` | Function used to retrieve an object's identity |
| `2-answer.txt` - `5-answer.txt` | Object identity questions involving integers |
| `6-answer.txt` - `13-answer.txt` | Equality and identity comparisons |
| `14-answer.txt` - `18-answer.txt` | Mutation, reassignment, and function arguments |
| `19-copy_list.py` | Returns a shallow copy of a list |
| `20-answer.txt` - `23-answer.txt` | Tuple syntax questions |
| `24-answer.txt` - `26-answer.txt` | Identity questions involving integers and tuples |
| `27-answer.txt` - `28-answer.txt` | List identity after `+` and `+=` |
| `100-magic_string.py` | Returns `BestSchool` repeatedly across calls |
| `101-locked_class.py` | Restricts new attributes to `first_name` |
| `103-line1.txt` - `106-line5.txt` | CPython object-allocation questions |

## Core Concepts

### Equality and Identity

Equality compares values:

```python
first == second
```

Identity checks whether two names point to the same object:

```python
first is second
```

Two separate lists may be equal without being the same object.

### Mutation and Reassignment

Mutation changes an existing object:

```python
numbers.append(4)
```

Every name pointing to that list observes the change.

Reassignment makes a name point to another object:

```python
numbers = numbers + [4]
```

Other names remain attached to the original list.

### Mutable and Immutable Objects

Common mutable objects include:

- Lists
- Dictionaries
- Sets

Common immutable objects include:

- Integers
- Floats
- Strings
- Tuples

An operation on an immutable object creates or selects another object rather
than changing the original value in place.

### Function Arguments

Python passes references to objects. A function can mutate a mutable object
received as an argument, but assigning a new object to the local parameter does
not reassign the caller's variable.

### Shallow List Copy

The expression:

```python
new_list = old_list[:]
```

creates a new outer list containing references to the same elements.

### Tuple Syntax

The comma creates a tuple, not the parentheses:

```python
single_item = (1,)
```

Without the comma, `(1)` is simply the integer `1`.

### Restricted Attributes

`LockedClass` uses:

```python
__slots__ = ("first_name",)
```

This prevents instances from receiving arbitrary new attributes while allowing
`first_name`.

## Usage

Make the Python files executable:

```bash
chmod +x 19-copy_list.py 100-magic_string.py 101-locked_class.py
```

Run a supplied test file:

```bash
./19-main.py
./100-main.py
./101-main.py
```

Validate Python syntax:

```bash
python3 -m py_compile \
19-copy_list.py \
100-magic_string.py \
101-locked_class.py
```

Check the required line limits:

```bash
wc -l 19-copy_list.py 100-magic_string.py
```

Expected limits:

- `19-copy_list.py`: maximum 3 lines
- `100-magic_string.py`: maximum 4 lines

## Author

Prince Chibuike Ubakaeze
