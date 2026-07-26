Python: If/Else, Loops and Functions
Description

This directory contains Python and C programming exercises focused on conditional statements, loops, functions, string manipulation, arithmetic operations, Python bytecode, and singly linked lists.

The project is part of the set-high_level_programming repository.

Learning Objectives

By completing these tasks, I learned how to:

Use if, elif, and else statements
Work with for and while loops
Use the range() function
Format output using str.format()
Work with ASCII character codes using ord() and chr()
Define and call Python functions
Return values from functions
Perform arithmetic and power operations
Work with positive and negative numbers
Extract the last digit of an integer
Translate Python bytecode into Python source code
Work with C structures and pointers
Insert a node into a sorted singly linked list
Requirements
Ubuntu Linux
Python 3
GCC compiler for the C task
Python files must begin with:
#!/usr/bin/python3
C files are compiled using:
gcc -Wall -Werror -Wextra -pedantic -std=gnu89
Files
File	Description
0-positive_or_negative.py	Prints whether a random number is positive, negative, or zero
1-last_digit.py	Prints the last digit of a random signed number
2-print_alphabet.py	Prints the lowercase ASCII alphabet
3-print_alphabt.py	Prints the lowercase alphabet except q and e
4-print_hexa.py	Prints numbers from 0 to 98 in decimal and hexadecimal
5-print_comb2.py	Prints numbers from 00 to 99
6-print_comb3.py	Prints all unique combinations of two different digits
7-islower.py	Checks whether a character is lowercase
8-uppercase.py	Prints a string in uppercase without using str.upper()
9-print_last_digit.py	Prints and returns the last digit of a number
10-add.py	Adds two integers and returns the result
11-pow.py	Computes a number raised to a given power
12-fizzbuzz.py	Prints the FizzBuzz sequence from 1 to 100
13-insert_number.c	Inserts a number into a sorted singly linked list
lists.h	Header file containing the linked-list structure and prototypes
100-print_tebahpla.py	Prints the alphabet in reverse with alternating letter cases
101-remove_char_at.py	Removes a character from a string at a specified position
102-magic_calculation.py	Recreates the behaviour of provided Python bytecode
Usage

Make a Python file executable:

chmod +x filename.py

Run a Python script:

./filename.py

Example:

./0-positive_or_negative.py

Test a Python function using its provided main file:

./7-main.py

Compile the linked-list task:

gcc -Wall -Werror -Wextra -pedantic -std=gnu89 \
13-main.c linked_lists.c 13-insert_number.c -o insert

Run the compiled program:

./insert