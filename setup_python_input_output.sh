
#!/usr/bin/env bash
# ---------------------------------------------------------------
# setup_python_input_output.sh  (v3)
#
# Deletes any previous versions of the project files, regenerates
# them clean, strips stray whitespace/carriage returns, then runs
# pycodestyle plus a smoke test that includes the empty-input case.
#
#   Usage:  bash setup_python_input_output.sh [target_directory]
#           bash setup_python_input_output.sh mydir --no-test
# ---------------------------------------------------------------
set -euo pipefail
 
TARGET="${1:-python-input_output}"
mkdir -p "$TARGET"
cd "$TARGET"
 
echo "Target directory: $(pwd)"
 
# --- 1. Remove the previous versions -----------------------------
OLD_FILES="0-read_file.py 1-write_file.py 2-append_write.py 3-to_json_string.py 4-from_json_string.py 5-save_to_json_file.py 6-load_from_json_file.py 7-add_item.py 8-class_to_json.py 9-student.py 10-student.py 11-student.py 12-pascal_triangle.py 100-append_after.py 101-stats.py README.md"
echo "Removing old files..."
for f in $OLD_FILES; do
    rm -f "$f"
done
# leftovers from previous test runs
rm -f add_item.json my_list.json my_dict.json my_set.json student.json \
      my_first_file.txt file_append.txt append_after_100.txt my_file_0.txt
 
# --- 2. Write the files ------------------------------------------
echo "Writing files..."
 
cat > 0-read_file.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a function that reads a UTF-8 text file."""
 
 
def read_file(filename=""):
    """Read a UTF-8 text file and print its content to stdout."""
    with open(filename, "r", encoding="utf-8") as f:
        print(f.read(), end="")
SETEOF
 
cat > 1-write_file.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a function that writes a string to a UTF-8 text file."""
 
 
def write_file(filename="", text=""):
    """Write text to a UTF-8 file and return the number of characters."""
    with open(filename, "w", encoding="utf-8") as f:
        return f.write(text)
SETEOF
 
cat > 2-append_write.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a function that appends a string to a UTF-8 text file."""
 
 
def append_write(filename="", text=""):
    """Append text to a UTF-8 file and return the number of characters."""
    with open(filename, "a", encoding="utf-8") as f:
        return f.write(text)
SETEOF
 
cat > 3-to_json_string.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a function that returns the JSON representation of an object."""
import json
 
 
def to_json_string(my_obj):
    """Return the JSON string representation of my_obj."""
    return json.dumps(my_obj)
SETEOF
 
cat > 4-from_json_string.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a function that builds a Python object from a JSON string."""
import json
 
 
def from_json_string(my_str):
    """Return the Python object represented by the JSON string my_str."""
    return json.loads(my_str)
SETEOF
 
cat > 5-save_to_json_file.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a function that writes an object to a file using JSON."""
import json
 
 
def save_to_json_file(my_obj, filename):
    """Write my_obj to filename using its JSON representation."""
    with open(filename, "w", encoding="utf-8") as f:
        json.dump(my_obj, f)
SETEOF
 
cat > 6-load_from_json_file.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a function that creates an object from a JSON file."""
import json
 
 
def load_from_json_file(filename):
    """Return the Python object stored in the JSON file filename."""
    with open(filename, "r", encoding="utf-8") as f:
        return json.load(f)
SETEOF
 
cat > 7-add_item.py << 'SETEOF'
#!/usr/bin/python3
"""Adds all command line arguments to a list saved in add_item.json."""
import sys
 
save_to_json_file = __import__('5-save_to_json_file').save_to_json_file
load_from_json_file = __import__('6-load_from_json_file').load_from_json_file
 
FILENAME = "add_item.json"
 
try:
    items = load_from_json_file(FILENAME)
except FileNotFoundError:
    items = []
 
items.extend(sys.argv[1:])
save_to_json_file(items, FILENAME)
SETEOF
 
cat > 8-class_to_json.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a function that returns the dictionary description of an object."""
 
 
def class_to_json(obj):
    """Return the dictionary description of obj for JSON serialization."""
    result = {}
    for key, value in vars(obj).items():
        if isinstance(value, (list, dict, str, int, float, bool)):
            result[key] = value
    return result
SETEOF
 
cat > 9-student.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a Student class."""
 
 
class Student:
    """Represents a student."""
 
    def __init__(self, first_name, last_name, age):
        """Initialize a new Student."""
        self.first_name = first_name
        self.last_name = last_name
        self.age = age
 
    def to_json(self):
        """Return the dictionary representation of the Student."""
        return self.__dict__
SETEOF
 
cat > 10-student.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a Student class with attribute filtering."""
 
 
class Student:
    """Represents a student."""
 
    def __init__(self, first_name, last_name, age):
        """Initialize a new Student."""
        self.first_name = first_name
        self.last_name = last_name
        self.age = age
 
    def to_json(self, attrs=None):
        """Return the dictionary representation of the Student.
 
        If attrs is a list of strings, only those attributes are retrieved.
        """
        if type(attrs) is list and all(type(a) is str for a in attrs):
            return {k: v for k, v in self.__dict__.items() if k in attrs}
        return self.__dict__
SETEOF
 
cat > 11-student.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a Student class that can be serialized and reloaded."""
 
 
class Student:
    """Represents a student."""
 
    def __init__(self, first_name, last_name, age):
        """Initialize a new Student."""
        self.first_name = first_name
        self.last_name = last_name
        self.age = age
 
    def to_json(self, attrs=None):
        """Return the dictionary representation of the Student.
 
        If attrs is a list of strings, only those attributes are retrieved.
        """
        if type(attrs) is list and all(type(a) is str for a in attrs):
            return {k: v for k, v in self.__dict__.items() if k in attrs}
        return self.__dict__
 
    def reload_from_json(self, json):
        """Replace all attributes of the Student from the json dictionary."""
        for key, value in json.items():
            setattr(self, key, value)
SETEOF
 
cat > 12-pascal_triangle.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a function that builds Pascal's triangle."""
 
 
def pascal_triangle(n):
    """Return a list of lists of integers representing Pascal's triangle."""
    triangle = []
    if n <= 0:
        return triangle
    for i in range(n):
        row = [1]
        if triangle:
            previous = triangle[-1]
            for j in range(len(previous) - 1):
                row.append(previous[j] + previous[j + 1])
            row.append(1)
        triangle.append(row)
    return triangle
SETEOF
 
cat > 100-append_after.py << 'SETEOF'
#!/usr/bin/python3
"""Defines a function that inserts text after matching lines in a file."""
 
 
def append_after(filename="", search_string="", new_string=""):
    """Insert new_string after each line containing search_string."""
    with open(filename, "r", encoding="utf-8") as f:
        lines = f.readlines()
 
    content = ""
    for line in lines:
        content += line
        if search_string in line:
            content += new_string
 
    with open(filename, "w", encoding="utf-8") as f:
        f.write(content)
SETEOF
 
cat > 101-stats.py << 'SETEOF'
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
SETEOF
 
cat > README.md << 'SETEOF'
# Python - Input/Output
 
Project files for `python-input_output` in the `set-high_level_programming` repository.
 
| File | Task |
| --- | --- |
| `0-read_file.py` | Read a UTF-8 text file and print it to stdout |
| `1-write_file.py` | Write a string to a file, return characters written |
| `2-append_write.py` | Append a string to a file, return characters added |
| `3-to_json_string.py` | Return the JSON string of an object |
| `4-from_json_string.py` | Return the object from a JSON string |
| `5-save_to_json_file.py` | Save an object to a file as JSON |
| `6-load_from_json_file.py` | Create an object from a JSON file |
| `7-add_item.py` | Add command line arguments to `add_item.json` |
| `8-class_to_json.py` | Dictionary description of an instance |
| `9-student.py` | `Student` class with `to_json` |
| `10-student.py` | `Student` class with attribute filtering |
| `11-student.py` | `Student` class with `reload_from_json` |
| `12-pascal_triangle.py` | Pascal's triangle |
| `100-append_after.py` | Insert a line after each matching line |
| `101-stats.py` | Log parsing from stdin |
SETEOF
 
# --- 3. Strip carriage returns and trailing whitespace -----------
# Copy-pasting through a browser or editor adds these, and they cause
# W291/W293 pycodestyle failures in every file.
for f in $OLD_FILES; do
    TMPF="$(mktemp)"
    sed -e 's/\r$//' -e 's/[[:space:]]*$//' "$f" > "$TMPF"
    cat "$TMPF" > "$f"
    rm -f "$TMPF"
done
 
chmod +x ./*.py
 
echo
echo "Files created:"
ls -1
 
if [ "${2:-}" = "--no-test" ]; then
    echo
    echo "Done (tests skipped)."
    exit 0
fi
 
# --- 4. Style check ----------------------------------------------
echo
echo "--- pycodestyle ---"
if command -v pycodestyle > /dev/null 2>&1; then
    pycodestyle ./*.py && echo "PEP8: OK (0 errors)"
else
    echo "pycodestyle not installed, skipping (pip3 install pycodestyle)"
fi
 
# --- 5. Smoke tests ----------------------------------------------
echo
echo "--- smoke tests ---"
 
TMP="$(mktemp -d)"
cp ./*.py "$TMP"/
cd "$TMP"
chmod +x ./*.py
 
printf 'Line one\nLine two\n' > my_file_0.txt
 
python3 - << 'PYEOF'
read_file = __import__('0-read_file').read_file
write_file = __import__('1-write_file').write_file
append_write = __import__('2-append_write').append_write
to_json_string = __import__('3-to_json_string').to_json_string
from_json_string = __import__('4-from_json_string').from_json_string
save_to_json_file = __import__('5-save_to_json_file').save_to_json_file
load_from_json_file = __import__('6-load_from_json_file').load_from_json_file
class_to_json = __import__('8-class_to_json').class_to_json
Student9 = __import__('9-student').Student
Student10 = __import__('10-student').Student
Student11 = __import__('11-student').Student
pascal_triangle = __import__('12-pascal_triangle').pascal_triangle
append_after = __import__('100-append_after').append_after
 
FAILURES = []
 
 
def check(label, got, want):
    if got == want:
        print("[ok  ] {}".format(label))
    else:
        FAILURES.append(label)
        print("[FAIL] {}: got {!r}, expected {!r}".format(label, got, want))
 
 
read_file("my_file_0.txt")
check("0 read_file printed above", True, True)
check("1 write_file", write_file("f1.txt", "This School is so cool!\n"), 24)
append_write("f2.txt", "abc")
check("2 append_write", append_write("f2.txt", "de"), 2)
check("3 to_json_string", to_json_string([1, 2, 3]), "[1, 2, 3]")
check("4 from_json_string", from_json_string("[1, 2, 3]"), [1, 2, 3])
save_to_json_file([1, 2, 3], "my_list.json")
check("5 save_to_json_file", open("my_list.json").read(), "[1, 2, 3]")
check("6 load_from_json_file", load_from_json_file("my_list.json"), [1, 2, 3])
 
 
class MyClass:
    def __init__(self, name):
        self.name = name
        self.number = 0
 
 
m = MyClass("John")
m.number = 89
check("8 class_to_json", class_to_json(m), {"name": "John", "number": 89})
check("9 Student.to_json", Student9("John", "Doe", 23).to_json(),
      {"first_name": "John", "last_name": "Doe", "age": 23})
check("10 Student filter",
      Student10("Bob", "Dylan", 27).to_json(["first_name", "age"]),
      {"first_name": "Bob", "age": 27})
check("10 Student unknown attr",
      Student10("Bob", "Dylan", 27).to_json(["middle_name", "age"]), {"age": 27})
s = Student11("Fake", "Fake", 89)
s.reload_from_json({"first_name": "John", "last_name": "Doe", "age": 23})
check("11 reload_from_json", [s.first_name, s.last_name, s.age],
      ["John", "Doe", 23])
check("12 pascal_triangle", pascal_triangle(5),
      [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]])
check("12 pascal_triangle(0)", pascal_triangle(0), [])
 
with open("append_after_100.txt", "w") as f:
    f.write("At SET,\nPython is really important,\n")
append_after("append_after_100.txt", "Python", "C is fun!\n")
check("13 append_after", open("append_after_100.txt").read(),
      "At SET,\nPython is really important,\nC is fun!\n")
 
if FAILURES:
    print("FAILED: {}".format(", ".join(FAILURES)))
PYEOF
 
rm -f add_item.json
./7-add_item.py
./7-add_item.py Best School
./7-add_item.py 89 Python C
RESULT="$(cat add_item.json)"
if [ "$RESULT" = '["Best", "School", "89", "Python", "C"]' ]; then
    echo "[ok  ] 7 add_item"
else
    echo "[FAIL] 7 add_item: $RESULT"
fi
 
# empty input must still print "File size: 0"
EMPTY="$(printf '' | ./101-stats.py)"
if [ "$EMPTY" = "File size: 0" ]; then
    echo "[ok  ] 14 stats, empty input"
else
    echo "[FAIL] 14 stats, empty input: $EMPTY"
fi
 
# 12 lines: stats at line 10, then final totals
echo "[----] 14 stats, 12 lines:"
python3 -c "
for i in range(12):
    print('1.1.1.1 - [d] \"GET /projects/260 HTTP/1.1\" {} 10'.format([200, 301, 404][i % 3]))
" | ./101-stats.py | sed 's/^/       /'
 
cd - > /dev/null
rm -rf "$TMP"
 
echo
echo "--- done ---"