#!/usr/bin/python3
"""Reads stdin line by line and computes log metrics."""
import sys


def print_stats(size, codes):
    """Print the total file size and the counts per status code."""
    print("File size: {:d}".format(size))
    for code in sorted(codes):
        print("{}: {:d}".format(code, codes[code]))


if __name__ == "__main__":
    total_size = 0
    status_codes = {}
    line_count = 0
    valid_codes = ["200", "301", "400", "401", "403", "404", "405", "500"]

    try:
        for line in sys.stdin:
            parts = line.split()
            if len(parts) > 2:
                try:
                    total_size += int(parts[-1])
                except ValueError:
                    pass
                code = parts[-2]
                if code in valid_codes:
                    status_codes[code] = status_codes.get(code, 0) + 1

            line_count += 1
            if line_count % 10 == 0:
                print_stats(total_size, status_codes)

        print_stats(total_size, status_codes)

    except KeyboardInterrupt:
        print_stats(total_size, status_codes)
        raise
