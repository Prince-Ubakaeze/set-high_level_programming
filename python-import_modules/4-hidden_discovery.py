#!/usr/bin/python3
"""Print public names defined by the hidden_4 compiled module."""

if __name__ == "__main__":
    import hidden_4

    for name in sorted(dir(hidden_4)):
        if not name.startswith("__"):
            print(name)
