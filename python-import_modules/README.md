# Python: Import and Modules

## Description

This directory contains Python exercises covering imports, modules,
command-line arguments, arithmetic functions, compiled modules, standard
library utilities, and Python bytecode translation.

The project is part of the `set-high_level_programming` repository.

## Learning Objectives

By completing these tasks, I learned how to:

- Import functions and variables from Python modules
- Protect executable code with `if __name__ == "__main__"`
- Use command-line arguments through `sys.argv`
- Count, access, and process command-line arguments
- Perform arithmetic using imported functions
- Work with Python's arbitrary-precision integers
- Inspect names defined by a module using `dir()`
- Sort and filter module attributes
- Handle calculator input and invalid operators
- Exit a Python program with a specific status code
- Produce output without using `print()`
- Translate Python bytecode into equivalent source code
- Use constants from Python's standard library

## Requirements

- Ubuntu Linux
- Python 3
- Python scripts must begin with:

```python
#!/usr/bin/python3
```

- All executable scripts should have execute permission:

```bash
chmod +x *.py
```

- Task `4-hidden_discovery.py` requires `hidden_4.pyc` compiled for
  Python 3.8.x.

## Files

| File | Description |
|---|---|
| `0-add.py` | Imports `add()` and prints the result of `1 + 2` |
| `1-calculation.py` | Imports calculator functions and performs four operations |
| `2-args.py` | Prints the count and values of command-line arguments |
| `3-infinite_add.py` | Adds all integer command-line arguments |
| `4-hidden_discovery.py` | Prints public names defined by `hidden_4.pyc` |
| `5-variable_load.py` | Imports and prints the variable `a` |
| `100-my_calculator.py` | Implements a command-line calculator |
| `101-easy_print.py` | Prints `#pythoniscool` without using `print()` |
| `102-magic_calculation.py` | Recreates the behaviour of supplied Python bytecode |
| `103-fast_alphabet.py` | Prints the uppercase alphabet using the `string` module |
| `add_0.py` | Provides the addition function used by Task 0 |
| `calculator_1.py` | Provides arithmetic functions used by Tasks 1 and 6 |
| `variable_load_5.py` | Provides the variable imported by Task 5 |
| `magic_calculation_102.py` | Provides `add()` and `sub()` for Task 8 |

## Usage

Run a script directly:

```bash
./0-add.py
```

Pass arguments to a script:

```bash
./2-args.py Hello Welcome To Python
```

Add multiple integers:

```bash
./3-infinite_add.py 79 10 -40
```

Use the calculator:

```bash
./100-my_calculator.py 3 + 5
./100-my_calculator.py 12 '*' 4
```

The multiplication operator should be quoted or escaped so that the shell does
not expand it as a wildcard.

## Hidden Module Task

Download the compiled module with:

```bash
curl -Lso hidden_4.pyc \
  "https://github.com/alx-tools/0x02.py/raw/master/hidden_4.pyc"
```

Run it with Python 3.8.x:

```bash
./4-hidden_discovery.py
```

## Syntax Validation

Check Python syntax with:

```bash
python3 -m py_compile *.py
```
