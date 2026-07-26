#!/usr/bin/python3
"""Solves the N-Queens problem."""

import sys


def solve_nqueens(size):
    """Print every valid arrangement of size queens."""
    columns = set()
    rising_diagonals = set()
    falling_diagonals = set()
    solution = []

    def place_queen(row):
        if row == size:
            print([position[:] for position in solution])
            return

        for column in range(size):
            rising = row + column
            falling = row - column

            if (
                column in columns
                or rising in rising_diagonals
                or falling in falling_diagonals
            ):
                continue

            columns.add(column)
            rising_diagonals.add(rising)
            falling_diagonals.add(falling)
            solution.append([row, column])

            place_queen(row + 1)

            solution.pop()
            falling_diagonals.remove(falling)
            rising_diagonals.remove(rising)
            columns.remove(column)

    place_queen(0)


def main():
    """Validate command-line input and solve the puzzle."""
    if len(sys.argv) != 2:
        print("Usage: nqueens N")
        sys.exit(1)

    try:
        size = int(sys.argv[1])
    except ValueError:
        print("N must be a number")
        sys.exit(1)

    if size < 4:
        print("N must be at least 4")
        sys.exit(1)

    solve_nqueens(size)


if __name__ == "__main__":
    main()
