#!/usr/bin/env bash
# ---------------------------------------------------------------
# setup_almost_a_circle.sh  (v3)
#
# v2: every Base method is now tested against BOTH Rectangle and
#     Square, in their own test files, for the checker's per-class
#     "test exists" checks.
# v3: adds Base.draw (turtle) and 101-main.py.
#
# Builds the whole python-almost_a_circle project: the models package,
# the unittest suite, and the package __init__.py files. Removes any
# previous version first, strips carriage returns and trailing
# whitespace, guarantees a final newline, then runs pycodestyle and
# the full test suite.
#
#   Usage:  bash setup_almost_a_circle.sh [target_directory]
#           bash setup_almost_a_circle.sh mydir --no-test
# ---------------------------------------------------------------
set -euo pipefail
 
TARGET="${1:-python-almost_a_circle}"
mkdir -p "$TARGET/models" "$TARGET/tests/test_models"
cd "$TARGET"
 
echo "Target directory: $(pwd)"
 
ALL_FILES="README.md 101-main.py models/__init__.py models/base.py models/rectangle.py models/square.py tests/__init__.py tests/test_models/__init__.py tests/test_models/test_base.py tests/test_models/test_rectangle.py tests/test_models/test_square.py"
 
# --- 1. Remove the previous version ------------------------------
echo "Removing old files..."
for f in $ALL_FILES; do
    rm -f "$f"
done
rm -f Rectangle.json Square.json Base.json Rectangle.csv Square.csv
find . -name __pycache__ -type d -exec rm -rf {} + 2> /dev/null || true
 
 
 
# --- 2. Write the files ------------------------------------------
echo "Writing files..."
 
cat > README.md << 'SETEOF'
# Python - Almost a circle
 
Project files for `python-almost_a_circle` in the `set-high_level_programming` repository.
 
## Package
 
| File | Contents |
| --- | --- |
| `models/__init__.py` | Makes `models` a package |
| `models/base.py` | `Base`: id management, JSON and CSV serialization |
| `models/rectangle.py` | `Rectangle`: validation, `area`, `display`, `update`, `to_dictionary` |
| `models/square.py` | `Square`: `size` property, `update`, `to_dictionary` |
 
## Tests
 
Run the whole suite from the project root:
 
```
python3 -m unittest discover tests
```
 
| File | Covers |
| --- | --- |
| `tests/test_models/test_base.py` | id handling, JSON strings, files, CSV, `create` |
| `tests/test_models/test_rectangle.py` | instantiation, validation, area, display, str, update, dictionary |
| `tests/test_models/test_square.py` | inheritance, size, validation, display, str, update, dictionary |
SETEOF
 
cat > 101-main.py << 'SETEOF'
#!/usr/bin/python3
""" 101-main """
from models.base import Base
from models.rectangle import Rectangle
from models.square import Square
 
if __name__ == "__main__":
 
    list_rectangles = [Rectangle(100, 40), Rectangle(90, 110, 30, 10),
                       Rectangle(20, 25, 110, 80)]
    list_squares = [Square(35), Square(15, 70, 50), Square(80, 30, 70)]
 
    Base.draw(list_rectangles, list_squares)
SETEOF
 
> models/__init__.py
 
cat > models/base.py << 'SETEOF'
#!/usr/bin/python3
"""Defines the Base class, the foundation of every other class here."""
import json
import csv
 
 
class Base:
    """Manage the id attribute of all derived classes.
 
    Attributes:
        __nb_objects (int): the number of instantiated Bases.
    """
 
    __nb_objects = 0
 
    def __init__(self, id=None):
        """Initialize a new Base.
 
        Args:
            id (int): the identity of the new instance.
        """
        if id is not None:
            self.id = id
        else:
            Base.__nb_objects += 1
            self.id = Base.__nb_objects
 
    @staticmethod
    def to_json_string(list_dictionaries):
        """Return the JSON string representation of a list of dictionaries."""
        if list_dictionaries is None or list_dictionaries == []:
            return "[]"
        return json.dumps(list_dictionaries)
 
    @staticmethod
    def from_json_string(json_string):
        """Return the list represented by a JSON string."""
        if json_string is None or json_string == "":
            return []
        return json.loads(json_string)
 
    @classmethod
    def save_to_file(cls, list_objs):
        """Write the JSON representation of a list of objects to a file."""
        if list_objs is None:
            list_objs = []
        filename = "{}.json".format(cls.__name__)
        with open(filename, "w", encoding="utf-8") as f:
            f.write(cls.to_json_string([o.to_dictionary() for o in list_objs]))
 
    @classmethod
    def create(cls, **dictionary):
        """Return an instance with all its attributes already set."""
        if cls.__name__ == "Square":
            dummy = cls(1)
        else:
            dummy = cls(1, 1)
        dummy.update(**dictionary)
        return dummy
 
    @classmethod
    def load_from_file(cls):
        """Return a list of instances loaded from <Class name>.json."""
        filename = "{}.json".format(cls.__name__)
        try:
            with open(filename, "r", encoding="utf-8") as f:
                dictionaries = cls.from_json_string(f.read())
        except IOError:
            return []
        return [cls.create(**d) for d in dictionaries]
 
    @classmethod
    def save_to_file_csv(cls, list_objs):
        """Write the CSV representation of a list of objects to a file."""
        if list_objs is None:
            list_objs = []
        if cls.__name__ == "Square":
            fields = ["id", "size", "x", "y"]
        else:
            fields = ["id", "width", "height", "x", "y"]
        filename = "{}.csv".format(cls.__name__)
        with open(filename, "w", newline="", encoding="utf-8") as f:
            writer = csv.writer(f)
            for obj in list_objs:
                dictionary = obj.to_dictionary()
                writer.writerow([dictionary[field] for field in fields])
 
    @staticmethod
    def draw(list_rectangles, list_squares):
        """Draw every given rectangle and square in a turtle window.
 
        Args:
            list_rectangles (list): the Rectangle instances to draw.
            list_squares (list): the Square instances to draw.
        """
        import turtle
 
        pen = turtle.Turtle()
        pen.screen.bgcolor("#0b1021")
        pen.screen.title("Almost a circle")
        pen.pensize(3)
        pen.speed(0)
        pen.hideturtle()
 
        def outline(shape, colour):
            """Trace one shape at its own offset in the given colour."""
            pen.color(colour)
            pen.penup()
            pen.goto(shape.x, shape.y)
            pen.pendown()
            for _ in range(2):
                pen.forward(shape.width)
                pen.left(90)
                pen.forward(shape.height)
                pen.left(90)
 
        for rectangle in list_rectangles:
            outline(rectangle, "#f4a259")
        for square in list_squares:
            outline(square, "#5bc0be")
 
        pen.screen.exitonclick()
 
    @classmethod
    def load_from_file_csv(cls):
        """Return a list of instances loaded from <Class name>.csv."""
        if cls.__name__ == "Square":
            fields = ["id", "size", "x", "y"]
        else:
            fields = ["id", "width", "height", "x", "y"]
        filename = "{}.csv".format(cls.__name__)
        instances = []
        try:
            with open(filename, "r", newline="", encoding="utf-8") as f:
                for row in csv.reader(f):
                    if row == []:
                        continue
                    values = [int(value) for value in row]
                    instances.append(cls.create(**dict(zip(fields, values))))
        except IOError:
            return []
        return instances
SETEOF
 
cat > models/rectangle.py << 'SETEOF'
#!/usr/bin/python3
"""Defines the Rectangle class."""
from models.base import Base
 
 
class Rectangle(Base):
    """Represent a rectangle, inheriting its id from Base."""
 
    def __init__(self, width, height, x=0, y=0, id=None):
        """Initialize a new Rectangle.
 
        Args:
            width (int): the width of the rectangle.
            height (int): the height of the rectangle.
            x (int): the horizontal offset of the rectangle.
            y (int): the vertical offset of the rectangle.
            id (int): the identity of the rectangle.
        """
        self.width = width
        self.height = height
        self.x = x
        self.y = y
        super().__init__(id)
 
    @property
    def width(self):
        """int: the width of the rectangle."""
        return self.__width
 
    @width.setter
    def width(self, value):
        if type(value) is not int:
            raise TypeError("width must be an integer")
        if value <= 0:
            raise ValueError("width must be > 0")
        self.__width = value
 
    @property
    def height(self):
        """int: the height of the rectangle."""
        return self.__height
 
    @height.setter
    def height(self, value):
        if type(value) is not int:
            raise TypeError("height must be an integer")
        if value <= 0:
            raise ValueError("height must be > 0")
        self.__height = value
 
    @property
    def x(self):
        """int: the horizontal offset of the rectangle."""
        return self.__x
 
    @x.setter
    def x(self, value):
        if type(value) is not int:
            raise TypeError("x must be an integer")
        if value < 0:
            raise ValueError("x must be >= 0")
        self.__x = value
 
    @property
    def y(self):
        """int: the vertical offset of the rectangle."""
        return self.__y
 
    @y.setter
    def y(self, value):
        if type(value) is not int:
            raise TypeError("y must be an integer")
        if value < 0:
            raise ValueError("y must be >= 0")
        self.__y = value
 
    def area(self):
        """Return the area of the rectangle."""
        return self.width * self.height
 
    def display(self):
        """Print the rectangle with the # character, honouring x and y."""
        print("\n" * self.y, end="")
        for _ in range(self.height):
            print(" " * self.x + "#" * self.width)
 
    def update(self, *args, **kwargs):
        """Update the rectangle.
 
        Args:
            *args: id, width, height, x, y in that order.
            **kwargs: attribute names and values, skipped if args is given.
        """
        if args:
            attributes = ["id", "width", "height", "x", "y"]
            for attribute, value in zip(attributes, args):
                setattr(self, attribute, value)
        else:
            for key, value in kwargs.items():
                if key in ("id", "width", "height", "x", "y"):
                    setattr(self, key, value)
 
    def to_dictionary(self):
        """Return the dictionary representation of the rectangle."""
        return {"id": self.id, "width": self.width, "height": self.height,
                "x": self.x, "y": self.y}
 
    def __str__(self):
        """Return [Rectangle] (<id>) <x>/<y> - <width>/<height>."""
        return "[Rectangle] ({}) {}/{} - {}/{}".format(
            self.id, self.x, self.y, self.width, self.height)
SETEOF
 
cat > models/square.py << 'SETEOF'
#!/usr/bin/python3
"""Defines the Square class."""
from models.rectangle import Rectangle
 
 
class Square(Rectangle):
    """Represent a square, a rectangle with equal sides."""
 
    def __init__(self, size, x=0, y=0, id=None):
        """Initialize a new Square.
 
        Args:
            size (int): the size of the square.
            x (int): the horizontal offset of the square.
            y (int): the vertical offset of the square.
            id (int): the identity of the square.
        """
        super().__init__(size, size, x, y, id)
 
    @property
    def size(self):
        """int: the size of the square."""
        return self.width
 
    @size.setter
    def size(self, value):
        self.width = value
        self.height = value
 
    def update(self, *args, **kwargs):
        """Update the square.
 
        Args:
            *args: id, size, x, y in that order.
            **kwargs: attribute names and values, skipped if args is given.
        """
        if args:
            attributes = ["id", "size", "x", "y"]
            for attribute, value in zip(attributes, args):
                setattr(self, attribute, value)
        else:
            for key, value in kwargs.items():
                if key in ("id", "size", "x", "y"):
                    setattr(self, key, value)
 
    def to_dictionary(self):
        """Return the dictionary representation of the square."""
        return {"id": self.id, "size": self.size, "x": self.x, "y": self.y}
 
    def __str__(self):
        """Return [Square] (<id>) <x>/<y> - <size>."""
        return "[Square] ({}) {}/{} - {}".format(
            self.id, self.x, self.y, self.width)
SETEOF
 
> tests/__init__.py
 
> tests/test_models/__init__.py
 
cat > tests/test_models/test_base.py << 'SETEOF'
#!/usr/bin/python3
"""Unittests for models/base.py."""
import inspect
import os
import unittest
from models.base import Base
from models.rectangle import Rectangle
from models.square import Square
 
 
class TestBaseId(unittest.TestCase):
    """Test the id handling of the Base class."""
 
    def setUp(self):
        """Reset the object counter before each test."""
        Base._Base__nb_objects = 0
 
    def test_id_is_incremented(self):
        """Consecutive instances get consecutive ids."""
        self.assertEqual(Base().id, 1)
        self.assertEqual(Base().id, 2)
        self.assertEqual(Base().id, 3)
 
    def test_given_id(self):
        """A given id is used as is."""
        self.assertEqual(Base(12).id, 12)
 
    def test_given_id_does_not_change_counter(self):
        """A given id does not increment the counter."""
        Base()
        Base(89)
        self.assertEqual(Base().id, 2)
 
    def test_none_id(self):
        """An explicit None falls back to the counter."""
        self.assertEqual(Base(None).id, 1)
 
    def test_negative_id(self):
        """A negative id is accepted."""
        self.assertEqual(Base(-5).id, -5)
 
    def test_zero_id(self):
        """Zero is a valid id."""
        self.assertEqual(Base(0).id, 0)
 
    def test_string_id(self):
        """The type of id is not validated."""
        self.assertEqual(Base("hello").id, "hello")
 
    def test_nb_objects_is_private(self):
        """__nb_objects is not publicly accessible."""
        with self.assertRaises(AttributeError):
            Base.__nb_objects
 
    def test_no_id_attribute_before_init(self):
        """Base takes at most one argument."""
        with self.assertRaises(TypeError):
            Base(1, 2)
 
 
class TestBaseToJsonString(unittest.TestCase):
    """Test the to_json_string static method."""
 
    def test_none(self):
        """None gives an empty list string."""
        self.assertEqual(Base.to_json_string(None), "[]")
 
    def test_empty_list(self):
        """An empty list gives an empty list string."""
        self.assertEqual(Base.to_json_string([]), "[]")
 
    def test_returns_a_string(self):
        """The return value is a string."""
        self.assertIs(type(Base.to_json_string([{"id": 1}])), str)
 
    def test_one_dictionary(self):
        """A single dictionary is serialized."""
        self.assertEqual(Base.to_json_string([{"id": 9}]), '[{"id": 9}]')
 
    def test_two_dictionaries(self):
        """Two dictionaries produce two JSON objects."""
        result = Base.to_json_string([{"id": 1}, {"id": 2}])
        self.assertEqual(len(result), 22)
 
    def test_rectangle_dictionary(self):
        """A rectangle dictionary keeps all five keys."""
        r = Rectangle(10, 7, 2, 8, 1)
        result = Base.to_json_string([r.to_dictionary()])
        for key in ("id", "width", "height", "x", "y"):
            self.assertIn(key, result)
 
 
class TestBaseFromJsonString(unittest.TestCase):
    """Test the from_json_string static method."""
 
    def test_none(self):
        """None gives an empty list."""
        self.assertEqual(Base.from_json_string(None), [])
 
    def test_empty_string(self):
        """An empty string gives an empty list."""
        self.assertEqual(Base.from_json_string(""), [])
 
    def test_empty_list_string(self):
        """The string of an empty list gives an empty list."""
        self.assertEqual(Base.from_json_string("[]"), [])
 
    def test_returns_a_list(self):
        """The return value is a list."""
        self.assertIs(type(Base.from_json_string('[{"id": 1}]')), list)
 
    def test_one_dictionary(self):
        """A single JSON object is deserialized."""
        self.assertEqual(Base.from_json_string('[{"id": 9}]'), [{"id": 9}])
 
    def test_round_trip(self):
        """Serializing then deserializing gives the original list."""
        original = [{"id": 1, "width": 2}, {"id": 3, "width": 4}]
        result = Base.from_json_string(Base.to_json_string(original))
        self.assertEqual(result, original)
 
 
class TestBaseCreate(unittest.TestCase):
    """Test the create class method."""
 
    def test_create_rectangle(self):
        """A rectangle is rebuilt from its dictionary."""
        r1 = Rectangle(3, 5, 1, 0, 7)
        r2 = Rectangle.create(**r1.to_dictionary())
        self.assertEqual(str(r1), str(r2))
 
    def test_create_returns_new_object(self):
        """create returns a different object."""
        r1 = Rectangle(3, 5, 1)
        r2 = Rectangle.create(**r1.to_dictionary())
        self.assertIsNot(r1, r2)
 
    def test_create_square(self):
        """A square is rebuilt from its dictionary."""
        s1 = Square(3, 5, 1, 7)
        s2 = Square.create(**s1.to_dictionary())
        self.assertEqual(str(s1), str(s2))
 
    def test_create_type(self):
        """create returns an instance of the calling class."""
        self.assertIs(type(Square.create(**{"id": 1, "size": 3})), Square)
 
 
class TestBaseDraw(unittest.TestCase):
    """Test the draw static method.
 
    The method opens a turtle window, so it is inspected rather than
    called: running it needs a display and would block on a click.
    """
 
    def test_draw_exists(self):
        """Base has a draw attribute."""
        self.assertTrue(hasattr(Base, "draw"))
 
    def test_draw_is_callable(self):
        """draw can be called."""
        self.assertTrue(callable(Base.draw))
 
    def test_draw_is_static(self):
        """draw is a static method."""
        self.assertIsInstance(inspect.getattr_static(Base, "draw"),
                              staticmethod)
 
    def test_draw_signature(self):
        """draw takes a list of rectangles and a list of squares."""
        parameters = inspect.signature(Base.draw).parameters
        self.assertEqual(list(parameters), ["list_rectangles",
                                            "list_squares"])
 
    def test_draw_has_a_docstring(self):
        """draw is documented."""
        self.assertTrue(len(Base.draw.__doc__) > 1)
 
    def test_draw_inherited_by_rectangle(self):
        """Rectangle inherits draw."""
        self.assertTrue(hasattr(Rectangle, "draw"))
 
    def test_draw_inherited_by_square(self):
        """Square inherits draw."""
        self.assertTrue(hasattr(Square, "draw"))
 
 
class TestBaseFiles(unittest.TestCase):
    """Test the JSON and CSV file methods."""
 
    def tearDown(self):
        """Remove any file created by a test."""
        for name in ("Rectangle.json", "Square.json",
                     "Rectangle.csv", "Square.csv", "Base.json"):
            try:
                os.remove(name)
            except IOError:
                pass
            except OSError:
                pass
 
    def test_save_to_file_none(self):
        """None saves an empty list."""
        Rectangle.save_to_file(None)
        with open("Rectangle.json", "r") as f:
            self.assertEqual(f.read(), "[]")
 
    def test_save_to_file_empty_list(self):
        """An empty list saves an empty list."""
        Square.save_to_file([])
        with open("Square.json", "r") as f:
            self.assertEqual(f.read(), "[]")
 
    def test_save_to_file_uses_class_name(self):
        """The file is named after the calling class."""
        Square.save_to_file([Square(1)])
        self.assertTrue(os.path.exists("Square.json"))
 
    def test_save_to_file_overwrites(self):
        """Saving twice overwrites the file."""
        Rectangle.save_to_file([Rectangle(10, 7)])
        Rectangle.save_to_file([Rectangle(1, 1)])
        with open("Rectangle.json", "r") as f:
            self.assertEqual(len(f.read().split("}")), 2)
 
    def test_load_from_file_missing(self):
        """A missing file gives an empty list."""
        self.assertEqual(Rectangle.load_from_file(), [])
 
    def test_load_from_file_returns_list(self):
        """load_from_file returns a list."""
        Rectangle.save_to_file([Rectangle(10, 7)])
        self.assertIs(type(Rectangle.load_from_file()), list)
 
    def test_load_from_file_rectangles(self):
        """Rectangles survive a save and load cycle."""
        r1 = Rectangle(10, 7, 2, 8)
        r2 = Rectangle(2, 4)
        Rectangle.save_to_file([r1, r2])
        loaded = Rectangle.load_from_file()
        self.assertEqual([str(r1), str(r2)], [str(o) for o in loaded])
 
    def test_load_from_file_squares(self):
        """Squares survive a save and load cycle."""
        s1 = Square(5)
        s2 = Square(7, 9, 1)
        Square.save_to_file([s1, s2])
        loaded = Square.load_from_file()
        self.assertEqual([str(s1), str(s2)], [str(o) for o in loaded])
 
    def test_load_from_file_types(self):
        """Loaded objects have the right type."""
        Square.save_to_file([Square(5)])
        self.assertIs(type(Square.load_from_file()[0]), Square)
 
    def test_save_to_file_csv_none(self):
        """None writes an empty CSV file."""
        Rectangle.save_to_file_csv(None)
        with open("Rectangle.csv", "r") as f:
            self.assertEqual(f.read(), "")
 
    def test_save_to_file_csv_rectangle_format(self):
        """A rectangle row holds five fields in order."""
        Rectangle.save_to_file_csv([Rectangle(10, 7, 2, 8, 1)])
        with open("Rectangle.csv", "r") as f:
            self.assertEqual(f.read().strip(), "1,10,7,2,8")
 
    def test_save_to_file_csv_square_format(self):
        """A square row holds four fields in order."""
        Square.save_to_file_csv([Square(7, 9, 1, 6)])
        with open("Square.csv", "r") as f:
            self.assertEqual(f.read().strip(), "6,7,9,1")
 
    def test_load_from_file_csv_missing(self):
        """A missing CSV file gives an empty list."""
        self.assertEqual(Square.load_from_file_csv(), [])
 
    def test_load_from_file_csv_rectangles(self):
        """Rectangles survive a CSV round trip."""
        r1 = Rectangle(10, 7, 2, 8)
        r2 = Rectangle(2, 4)
        Rectangle.save_to_file_csv([r1, r2])
        loaded = Rectangle.load_from_file_csv()
        self.assertEqual([str(r1), str(r2)], [str(o) for o in loaded])
 
    def test_load_from_file_csv_squares(self):
        """Squares survive a CSV round trip."""
        s1 = Square(5)
        s2 = Square(7, 9, 1)
        Square.save_to_file_csv([s1, s2])
        loaded = Square.load_from_file_csv()
        self.assertEqual([str(s1), str(s2)], [str(o) for o in loaded])
 
    def test_load_from_file_csv_types(self):
        """Loaded CSV objects have the right type."""
        Rectangle.save_to_file_csv([Rectangle(10, 7)])
        self.assertIs(type(Rectangle.load_from_file_csv()[0]), Rectangle)
 
 
if __name__ == "__main__":
    unittest.main()
SETEOF
 
cat > tests/test_models/test_rectangle.py << 'SETEOF'
#!/usr/bin/python3
"""Unittests for models/rectangle.py."""
import io
import os
import sys
import unittest
from models.base import Base
from models.rectangle import Rectangle
 
 
class TestRectangleInstantiation(unittest.TestCase):
    """Test the creation of Rectangle instances."""
 
    def setUp(self):
        """Reset the object counter before each test."""
        Base._Base__nb_objects = 0
 
    def test_is_a_base(self):
        """A Rectangle is a Base."""
        self.assertIsInstance(Rectangle(10, 2), Base)
 
    def test_two_arguments(self):
        """Width and height are enough to build a rectangle."""
        r = Rectangle(10, 2)
        self.assertEqual((r.width, r.height, r.x, r.y), (10, 2, 0, 0))
 
    def test_three_arguments(self):
        """The third argument is x."""
        self.assertEqual(Rectangle(10, 2, 3).x, 3)
 
    def test_four_arguments(self):
        """The fourth argument is y."""
        self.assertEqual(Rectangle(10, 2, 3, 4).y, 4)
 
    def test_five_arguments(self):
        """The fifth argument is the id."""
        self.assertEqual(Rectangle(10, 2, 3, 4, 89).id, 89)
 
    def test_auto_id(self):
        """Ids are assigned in order when not given."""
        self.assertEqual(Rectangle(10, 2).id, 1)
        self.assertEqual(Rectangle(10, 2).id, 2)
 
    def test_no_arguments(self):
        """Width and height are mandatory."""
        with self.assertRaises(TypeError):
            Rectangle()
 
    def test_one_argument(self):
        """Height is mandatory."""
        with self.assertRaises(TypeError):
            Rectangle(10)
 
    def test_width_is_private(self):
        """The width attribute is private."""
        with self.assertRaises(AttributeError):
            Rectangle(10, 2).__width
 
    def test_height_is_private(self):
        """The height attribute is private."""
        with self.assertRaises(AttributeError):
            Rectangle(10, 2).__height
 
 
class TestRectangleValidation(unittest.TestCase):
    """Test the validation done by the setters."""
 
    def test_width_string(self):
        """A string width is rejected."""
        with self.assertRaisesRegex(TypeError, "width must be an integer"):
            Rectangle("10", 2)
 
    def test_width_float(self):
        """A float width is rejected."""
        with self.assertRaisesRegex(TypeError, "width must be an integer"):
            Rectangle(10.5, 2)
 
    def test_width_none(self):
        """A None width is rejected."""
        with self.assertRaisesRegex(TypeError, "width must be an integer"):
            Rectangle(None, 2)
 
    def test_width_zero(self):
        """A zero width is rejected."""
        with self.assertRaisesRegex(ValueError, "width must be > 0"):
            Rectangle(0, 2)
 
    def test_width_negative(self):
        """A negative width is rejected."""
        with self.assertRaisesRegex(ValueError, "width must be > 0"):
            Rectangle(-10, 2)
 
    def test_height_string(self):
        """A string height is rejected."""
        with self.assertRaisesRegex(TypeError, "height must be an integer"):
            Rectangle(10, "2")
 
    def test_height_zero(self):
        """A zero height is rejected."""
        with self.assertRaisesRegex(ValueError, "height must be > 0"):
            Rectangle(10, 0)
 
    def test_height_negative(self):
        """A negative height is rejected."""
        with self.assertRaisesRegex(ValueError, "height must be > 0"):
            Rectangle(10, -2)
 
    def test_x_dictionary(self):
        """A dictionary x is rejected."""
        with self.assertRaisesRegex(TypeError, "x must be an integer"):
            Rectangle(10, 2, {})
 
    def test_x_negative(self):
        """A negative x is rejected."""
        with self.assertRaisesRegex(ValueError, "x must be >= 0"):
            Rectangle(10, 2, -3)
 
    def test_x_zero_allowed(self):
        """A zero x is accepted."""
        self.assertEqual(Rectangle(10, 2, 0).x, 0)
 
    def test_y_list(self):
        """A list y is rejected."""
        with self.assertRaisesRegex(TypeError, "y must be an integer"):
            Rectangle(10, 2, 3, [])
 
    def test_y_negative(self):
        """A negative y is rejected."""
        with self.assertRaisesRegex(ValueError, "y must be >= 0"):
            Rectangle(10, 2, 3, -1)
 
    def test_y_zero_allowed(self):
        """A zero y is accepted."""
        self.assertEqual(Rectangle(10, 2, 3, 0).y, 0)
 
    def test_width_setter(self):
        """The width setter validates too."""
        r = Rectangle(10, 2)
        with self.assertRaisesRegex(ValueError, "width must be > 0"):
            r.width = -10
 
    def test_height_setter(self):
        """The height setter validates too."""
        r = Rectangle(10, 2)
        with self.assertRaisesRegex(TypeError, "height must be an integer"):
            r.height = "2"
 
    def test_x_setter(self):
        """The x setter validates too."""
        r = Rectangle(10, 2)
        with self.assertRaisesRegex(TypeError, "x must be an integer"):
            r.x = {}
 
    def test_y_setter(self):
        """The y setter validates too."""
        r = Rectangle(10, 2)
        with self.assertRaisesRegex(ValueError, "y must be >= 0"):
            r.y = -1
 
    def test_setters_assign(self):
        """Valid values are assigned by the setters."""
        r = Rectangle(10, 2)
        r.width, r.height, r.x, r.y = 5, 6, 7, 8
        self.assertEqual((r.width, r.height, r.x, r.y), (5, 6, 7, 8))
 
    def test_width_checked_first(self):
        """Width is validated before height."""
        with self.assertRaisesRegex(TypeError, "width must be an integer"):
            Rectangle("10", "2")
 
 
class TestRectangleArea(unittest.TestCase):
    """Test the area method."""
 
    def test_small_area(self):
        """The area of a small rectangle."""
        self.assertEqual(Rectangle(3, 2).area(), 6)
 
    def test_larger_area(self):
        """The area of a larger rectangle."""
        self.assertEqual(Rectangle(8, 7, 0, 0, 12).area(), 56)
 
    def test_square_area(self):
        """The area of a rectangle with equal sides."""
        self.assertEqual(Rectangle(5, 5).area(), 25)
 
    def test_area_ignores_offsets(self):
        """x and y do not change the area."""
        self.assertEqual(Rectangle(2, 10, 5, 5).area(), 20)
 
    def test_area_takes_no_argument(self):
        """area accepts no argument."""
        with self.assertRaises(TypeError):
            Rectangle(3, 2).area(1)
 
 
class TestRectangleDisplay(unittest.TestCase):
    """Test the display method."""
 
    def capture(self, rectangle):
        """Return what display prints for a rectangle."""
        captured = io.StringIO()
        sys.stdout = captured
        rectangle.display()
        sys.stdout = sys.__stdout__
        return captured.getvalue()
 
    def test_display_simple(self):
        """A rectangle without offsets."""
        self.assertEqual(self.capture(Rectangle(2, 2)), "##\n##\n")
 
    def test_display_one_by_one(self):
        """The smallest rectangle."""
        self.assertEqual(self.capture(Rectangle(1, 1)), "#\n")
 
    def test_display_wide(self):
        """A wide rectangle."""
        self.assertEqual(self.capture(Rectangle(4, 1)), "####\n")
 
    def test_display_with_x(self):
        """x indents every row."""
        self.assertEqual(self.capture(Rectangle(3, 2, 1)), " ###\n ###\n")
 
    def test_display_with_y(self):
        """y prints blank lines first."""
        self.assertEqual(self.capture(Rectangle(2, 1, 0, 2)), "\n\n##\n")
 
    def test_display_with_x_and_y(self):
        """x and y are combined."""
        self.assertEqual(self.capture(Rectangle(2, 3, 2, 2)),
                         "\n\n  ##\n  ##\n  ##\n")
 
    def test_display_takes_no_argument(self):
        """display accepts no argument."""
        with self.assertRaises(TypeError):
            Rectangle(2, 2).display(1)
 
 
class TestRectangleStr(unittest.TestCase):
    """Test the __str__ method."""
 
    def setUp(self):
        """Reset the object counter before each test."""
        Base._Base__nb_objects = 0
 
    def test_str_with_id(self):
        """The full string representation."""
        self.assertEqual(str(Rectangle(4, 6, 2, 1, 12)),
                         "[Rectangle] (12) 2/1 - 4/6")
 
    def test_str_auto_id(self):
        """The id comes from the counter when not given."""
        self.assertEqual(str(Rectangle(5, 5, 1)), "[Rectangle] (1) 1/0 - 5/5")
 
    def test_str_after_update(self):
        """The string reflects updated values."""
        r = Rectangle(10, 2, 3, 4, 5)
        r.width = 1
        self.assertEqual(str(r), "[Rectangle] (5) 3/4 - 1/2")
 
 
class TestRectangleUpdate(unittest.TestCase):
    """Test the update method."""
 
    def setUp(self):
        """Build a rectangle to update."""
        Base._Base__nb_objects = 0
        self.r = Rectangle(10, 10, 10, 10)
 
    def test_update_nothing(self):
        """Without arguments nothing changes."""
        self.r.update()
        self.assertEqual(str(self.r), "[Rectangle] (1) 10/10 - 10/10")
 
    def test_update_id(self):
        """The first argument is the id."""
        self.r.update(89)
        self.assertEqual(str(self.r), "[Rectangle] (89) 10/10 - 10/10")
 
    def test_update_width(self):
        """The second argument is the width."""
        self.r.update(89, 2)
        self.assertEqual(str(self.r), "[Rectangle] (89) 10/10 - 2/10")
 
    def test_update_height(self):
        """The third argument is the height."""
        self.r.update(89, 2, 3)
        self.assertEqual(str(self.r), "[Rectangle] (89) 10/10 - 2/3")
 
    def test_update_x(self):
        """The fourth argument is x."""
        self.r.update(89, 2, 3, 4)
        self.assertEqual(str(self.r), "[Rectangle] (89) 4/10 - 2/3")
 
    def test_update_y(self):
        """The fifth argument is y."""
        self.r.update(89, 2, 3, 4, 5)
        self.assertEqual(str(self.r), "[Rectangle] (89) 4/5 - 2/3")
 
    def test_update_extra_arguments(self):
        """Extra arguments are ignored."""
        self.r.update(89, 2, 3, 4, 5, 6)
        self.assertEqual(str(self.r), "[Rectangle] (89) 4/5 - 2/3")
 
    def test_update_validates(self):
        """update validates its values."""
        with self.assertRaisesRegex(ValueError, "width must be > 0"):
            self.r.update(89, -2)
 
    def test_update_kwargs(self):
        """Keyword arguments are applied by name."""
        self.r.update(height=1)
        self.assertEqual(str(self.r), "[Rectangle] (1) 10/10 - 10/1")
 
    def test_update_several_kwargs(self):
        """Several keyword arguments are applied at once."""
        self.r.update(y=1, width=2, x=3, id=89)
        self.assertEqual(str(self.r), "[Rectangle] (89) 3/1 - 2/10")
 
    def test_update_kwargs_order(self):
        """The order of keyword arguments does not matter."""
        self.r.update(x=1, height=2, y=3, width=4)
        self.assertEqual(str(self.r), "[Rectangle] (1) 1/3 - 4/2")
 
    def test_update_unknown_kwarg(self):
        """An unknown key is ignored."""
        self.r.update(colour="red")
        self.assertEqual(str(self.r), "[Rectangle] (1) 10/10 - 10/10")
 
    def test_args_beats_kwargs(self):
        """kwargs are skipped when args is given."""
        self.r.update(89, 2, width=7)
        self.assertEqual(str(self.r), "[Rectangle] (89) 10/10 - 2/10")
 
    def test_update_kwargs_validates(self):
        """Keyword arguments are validated too."""
        with self.assertRaisesRegex(TypeError, "height must be an integer"):
            self.r.update(height="2")
 
 
class TestRectangleToDictionary(unittest.TestCase):
    """Test the to_dictionary method."""
 
    def test_type(self):
        """to_dictionary returns a dictionary."""
        self.assertIs(type(Rectangle(10, 2, 1, 9).to_dictionary()), dict)
 
    def test_keys(self):
        """The dictionary holds exactly five keys."""
        result = Rectangle(10, 2, 1, 9, 1).to_dictionary()
        self.assertEqual(sorted(result.keys()),
                         ["height", "id", "width", "x", "y"])
 
    def test_values(self):
        """The dictionary holds the current values."""
        result = Rectangle(10, 2, 1, 9, 5).to_dictionary()
        self.assertEqual(result, {"id": 5, "width": 10, "height": 2,
                                  "x": 1, "y": 9})
 
    def test_used_by_update(self):
        """A dictionary can be fed back into update."""
        r1 = Rectangle(10, 2, 1, 9, 5)
        r2 = Rectangle(1, 1)
        r2.update(**r1.to_dictionary())
        self.assertEqual(str(r1), str(r2))
 
    def test_objects_stay_different(self):
        """Two rectangles with equal values are not the same object."""
        r1 = Rectangle(10, 2, 1, 9, 5)
        r2 = Rectangle(1, 1)
        r2.update(**r1.to_dictionary())
        self.assertIsNot(r1, r2)
 
 
class TestRectangleFiles(unittest.TestCase):
    """Test the Base file methods as used by Rectangle."""
 
    def tearDown(self):
        """Remove any file created by a test."""
        for name in ("Rectangle.json", "Rectangle.csv"):
            try:
                os.remove(name)
            except OSError:
                pass
 
    def test_save_to_file_none(self):
        """Rectangle.save_to_file(None) writes an empty list."""
        Rectangle.save_to_file(None)
        with open("Rectangle.json", "r") as f:
            self.assertEqual(f.read(), "[]")
 
    def test_save_to_file_empty_list(self):
        """Rectangle.save_to_file([]) writes an empty list."""
        Rectangle.save_to_file([])
        with open("Rectangle.json", "r") as f:
            self.assertEqual(f.read(), "[]")
 
    def test_save_to_file_one_rectangle(self):
        """One rectangle is written as one JSON object."""
        Rectangle.save_to_file([Rectangle(10, 7, 2, 8, 1)])
        with open("Rectangle.json", "r") as f:
            self.assertEqual(
                Rectangle.from_json_string(f.read()),
                [{"id": 1, "width": 10, "height": 7, "x": 2, "y": 8}])
 
    def test_save_to_file_two_rectangles(self):
        """Two rectangles are written as two JSON objects."""
        Rectangle.save_to_file([Rectangle(10, 7), Rectangle(2, 4)])
        with open("Rectangle.json", "r") as f:
            self.assertEqual(len(Rectangle.from_json_string(f.read())), 2)
 
    def test_save_to_file_overwrites(self):
        """Saving twice overwrites the file."""
        Rectangle.save_to_file([Rectangle(10, 7), Rectangle(2, 4)])
        Rectangle.save_to_file([Rectangle(1, 1)])
        with open("Rectangle.json", "r") as f:
            self.assertEqual(len(Rectangle.from_json_string(f.read())), 1)
 
    def test_save_to_file_creates_the_file(self):
        """The file is named after the class."""
        Rectangle.save_to_file([Rectangle(1, 1)])
        self.assertTrue(os.path.exists("Rectangle.json"))
 
    def test_load_from_file_missing(self):
        """A missing file gives an empty list."""
        self.assertEqual(Rectangle.load_from_file(), [])
 
    def test_load_from_file_after_none(self):
        """Saving None then loading gives an empty list."""
        Rectangle.save_to_file(None)
        self.assertEqual(Rectangle.load_from_file(), [])
 
    def test_load_from_file_type(self):
        """load_from_file returns a list."""
        Rectangle.save_to_file([Rectangle(10, 7)])
        self.assertIs(type(Rectangle.load_from_file()), list)
 
    def test_load_from_file_instance_type(self):
        """Loaded objects are Rectangles."""
        Rectangle.save_to_file([Rectangle(10, 7)])
        self.assertIs(type(Rectangle.load_from_file()[0]), Rectangle)
 
    def test_load_from_file_values(self):
        """Rectangles survive a save and load cycle."""
        r1 = Rectangle(10, 7, 2, 8)
        r2 = Rectangle(2, 4)
        Rectangle.save_to_file([r1, r2])
        loaded = Rectangle.load_from_file()
        self.assertEqual([str(r1), str(r2)], [str(o) for o in loaded])
 
    def test_load_from_file_new_objects(self):
        """Loading builds new objects."""
        r1 = Rectangle(10, 7)
        Rectangle.save_to_file([r1])
        self.assertIsNot(Rectangle.load_from_file()[0], r1)
 
    def test_save_to_file_csv_none(self):
        """Rectangle.save_to_file_csv(None) writes an empty file."""
        Rectangle.save_to_file_csv(None)
        with open("Rectangle.csv", "r") as f:
            self.assertEqual(f.read(), "")
 
    def test_save_to_file_csv_empty_list(self):
        """Rectangle.save_to_file_csv([]) writes an empty file."""
        Rectangle.save_to_file_csv([])
        with open("Rectangle.csv", "r") as f:
            self.assertEqual(f.read(), "")
 
    def test_save_to_file_csv_format(self):
        """A row is id,width,height,x,y."""
        Rectangle.save_to_file_csv([Rectangle(10, 7, 2, 8, 1)])
        with open("Rectangle.csv", "r") as f:
            self.assertEqual(f.read().strip(), "1,10,7,2,8")
 
    def test_save_to_file_csv_overwrites(self):
        """Saving twice overwrites the file."""
        Rectangle.save_to_file_csv([Rectangle(10, 7), Rectangle(2, 4)])
        Rectangle.save_to_file_csv([Rectangle(1, 1, 0, 0, 9)])
        with open("Rectangle.csv", "r") as f:
            self.assertEqual(f.read().strip(), "9,1,1,0,0")
 
    def test_load_from_file_csv_missing(self):
        """A missing CSV file gives an empty list."""
        self.assertEqual(Rectangle.load_from_file_csv(), [])
 
    def test_load_from_file_csv_type(self):
        """Loaded CSV objects are Rectangles."""
        Rectangle.save_to_file_csv([Rectangle(10, 7)])
        self.assertIs(type(Rectangle.load_from_file_csv()[0]), Rectangle)
 
    def test_load_from_file_csv_values(self):
        """Rectangles survive a CSV round trip."""
        r1 = Rectangle(10, 7, 2, 8)
        r2 = Rectangle(2, 4)
        Rectangle.save_to_file_csv([r1, r2])
        loaded = Rectangle.load_from_file_csv()
        self.assertEqual([str(r1), str(r2)], [str(o) for o in loaded])
 
 
class TestRectangleJsonAndCreate(unittest.TestCase):
    """Test the Base JSON helpers and create as used by Rectangle."""
 
    def test_to_json_string_none(self):
        """None gives an empty list string."""
        self.assertEqual(Rectangle.to_json_string(None), "[]")
 
    def test_to_json_string_empty_list(self):
        """An empty list gives an empty list string."""
        self.assertEqual(Rectangle.to_json_string([]), "[]")
 
    def test_to_json_string_type(self):
        """to_json_string returns a string."""
        r = Rectangle(10, 7, 2, 8, 1)
        self.assertIs(type(Rectangle.to_json_string([r.to_dictionary()])), str)
 
    def test_to_json_string_one_rectangle(self):
        """A rectangle dictionary is serialized."""
        r = Rectangle(10, 7, 2, 8, 1)
        result = Rectangle.to_json_string([r.to_dictionary()])
        self.assertEqual(Rectangle.from_json_string(result),
                         [r.to_dictionary()])
 
    def test_from_json_string_none(self):
        """None gives an empty list."""
        self.assertEqual(Rectangle.from_json_string(None), [])
 
    def test_from_json_string_empty(self):
        """An empty string gives an empty list."""
        self.assertEqual(Rectangle.from_json_string(""), [])
 
    def test_from_json_string_type(self):
        """from_json_string returns a list."""
        self.assertIs(type(Rectangle.from_json_string('[{"id": 1}]')), list)
 
    def test_create_values(self):
        """create rebuilds a rectangle from its dictionary."""
        r1 = Rectangle(3, 5, 1, 0, 7)
        r2 = Rectangle.create(**r1.to_dictionary())
        self.assertEqual(str(r1), str(r2))
 
    def test_create_type(self):
        """create returns a Rectangle."""
        self.assertIs(type(Rectangle.create(**{"id": 1, "width": 2,
                                               "height": 3})), Rectangle)
 
    def test_create_is_a_new_object(self):
        """create returns a different object."""
        r1 = Rectangle(3, 5, 1)
        self.assertIsNot(Rectangle.create(**r1.to_dictionary()), r1)
 
 
if __name__ == "__main__":
    unittest.main()
SETEOF
 
cat > tests/test_models/test_square.py << 'SETEOF'
#!/usr/bin/python3
"""Unittests for models/square.py."""
import io
import os
import sys
import unittest
from models.base import Base
from models.rectangle import Rectangle
from models.square import Square
 
 
class TestSquareInstantiation(unittest.TestCase):
    """Test the creation of Square instances."""
 
    def setUp(self):
        """Reset the object counter before each test."""
        Base._Base__nb_objects = 0
 
    def test_is_a_rectangle(self):
        """A Square is a Rectangle."""
        self.assertIsInstance(Square(5), Rectangle)
 
    def test_is_a_base(self):
        """A Square is a Base."""
        self.assertIsInstance(Square(5), Base)
 
    def test_one_argument(self):
        """Size alone is enough to build a square."""
        s = Square(5)
        self.assertEqual((s.width, s.height, s.x, s.y), (5, 5, 0, 0))
 
    def test_two_arguments(self):
        """The second argument is x."""
        self.assertEqual(Square(5, 2).x, 2)
 
    def test_three_arguments(self):
        """The third argument is y."""
        self.assertEqual(Square(5, 2, 3).y, 3)
 
    def test_four_arguments(self):
        """The fourth argument is the id."""
        self.assertEqual(Square(5, 2, 3, 89).id, 89)
 
    def test_auto_id(self):
        """Ids are assigned in order when not given."""
        self.assertEqual(Square(5).id, 1)
        self.assertEqual(Square(5).id, 2)
 
    def test_no_arguments(self):
        """Size is mandatory."""
        with self.assertRaises(TypeError):
            Square()
 
    def test_no_new_attributes(self):
        """A square adds no attribute of its own."""
        self.assertEqual(sorted(vars(Square(5)).keys()),
                         ["_Rectangle__height", "_Rectangle__width",
                          "_Rectangle__x", "_Rectangle__y", "id"])
 
 
class TestSquareValidation(unittest.TestCase):
    """Test that a Square validates like a Rectangle."""
 
    def test_size_string(self):
        """A string size is rejected with the width message."""
        with self.assertRaisesRegex(TypeError, "width must be an integer"):
            Square("5")
 
    def test_size_float(self):
        """A float size is rejected."""
        with self.assertRaisesRegex(TypeError, "width must be an integer"):
            Square(5.5)
 
    def test_size_zero(self):
        """A zero size is rejected."""
        with self.assertRaisesRegex(ValueError, "width must be > 0"):
            Square(0)
 
    def test_size_negative(self):
        """A negative size is rejected."""
        with self.assertRaisesRegex(ValueError, "width must be > 0"):
            Square(-5)
 
    def test_x_string(self):
        """A string x is rejected."""
        with self.assertRaisesRegex(TypeError, "x must be an integer"):
            Square(5, "2")
 
    def test_x_negative(self):
        """A negative x is rejected."""
        with self.assertRaisesRegex(ValueError, "x must be >= 0"):
            Square(5, -2)
 
    def test_y_string(self):
        """A string y is rejected."""
        with self.assertRaisesRegex(TypeError, "y must be an integer"):
            Square(5, 2, "3")
 
    def test_y_negative(self):
        """A negative y is rejected."""
        with self.assertRaisesRegex(ValueError, "y must be >= 0"):
            Square(5, 2, -3)
 
 
class TestSquareSize(unittest.TestCase):
    """Test the size getter and setter."""
 
    def test_getter(self):
        """size returns the width."""
        self.assertEqual(Square(5).size, 5)
 
    def test_setter_sets_both_sides(self):
        """Setting size sets width and height."""
        s = Square(5)
        s.size = 10
        self.assertEqual((s.width, s.height), (10, 10))
 
    def test_setter_string(self):
        """A string size is rejected with the width message."""
        s = Square(5)
        with self.assertRaisesRegex(TypeError, "width must be an integer"):
            s.size = "9"
 
    def test_setter_zero(self):
        """A zero size is rejected."""
        s = Square(5)
        with self.assertRaisesRegex(ValueError, "width must be > 0"):
            s.size = 0
 
    def test_setter_negative(self):
        """A negative size is rejected."""
        s = Square(5)
        with self.assertRaisesRegex(ValueError, "width must be > 0"):
            s.size = -1
 
 
class TestSquareAreaAndDisplay(unittest.TestCase):
    """Test the inherited area and display methods."""
 
    def capture(self, square):
        """Return what display prints for a square."""
        captured = io.StringIO()
        sys.stdout = captured
        square.display()
        sys.stdout = sys.__stdout__
        return captured.getvalue()
 
    def test_area(self):
        """The area of a square is its size squared."""
        self.assertEqual(Square(5).area(), 25)
 
    def test_area_after_resize(self):
        """The area follows the size."""
        s = Square(2)
        s.size = 3
        self.assertEqual(s.area(), 9)
 
    def test_display_simple(self):
        """A square without offsets."""
        self.assertEqual(self.capture(Square(2)), "##\n##\n")
 
    def test_display_with_x(self):
        """x indents every row."""
        self.assertEqual(self.capture(Square(2, 2)), "  ##\n  ##\n")
 
    def test_display_with_x_and_y(self):
        """x and y are combined."""
        self.assertEqual(self.capture(Square(3, 1, 3)),
                         "\n\n\n ###\n ###\n ###\n")
 
 
class TestSquareStr(unittest.TestCase):
    """Test the __str__ method."""
 
    def setUp(self):
        """Reset the object counter before each test."""
        Base._Base__nb_objects = 0
 
    def test_str_auto_id(self):
        """The full string representation."""
        self.assertEqual(str(Square(5)), "[Square] (1) 0/0 - 5")
 
    def test_str_with_offsets(self):
        """Offsets appear in the string."""
        self.assertEqual(str(Square(3, 1, 3)), "[Square] (1) 1/3 - 3")
 
    def test_str_with_id(self):
        """A given id appears in the string."""
        self.assertEqual(str(Square(7, 9, 1, 89)), "[Square] (89) 9/1 - 7")
 
 
class TestSquareUpdate(unittest.TestCase):
    """Test the update method."""
 
    def setUp(self):
        """Build a square to update."""
        Base._Base__nb_objects = 0
        self.s = Square(5)
 
    def test_update_nothing(self):
        """Without arguments nothing changes."""
        self.s.update()
        self.assertEqual(str(self.s), "[Square] (1) 0/0 - 5")
 
    def test_update_id(self):
        """The first argument is the id."""
        self.s.update(10)
        self.assertEqual(str(self.s), "[Square] (10) 0/0 - 5")
 
    def test_update_size(self):
        """The second argument is the size."""
        self.s.update(1, 2)
        self.assertEqual(str(self.s), "[Square] (1) 0/0 - 2")
 
    def test_update_x(self):
        """The third argument is x."""
        self.s.update(1, 2, 3)
        self.assertEqual(str(self.s), "[Square] (1) 3/0 - 2")
 
    def test_update_y(self):
        """The fourth argument is y."""
        self.s.update(1, 2, 3, 4)
        self.assertEqual(str(self.s), "[Square] (1) 3/4 - 2")
 
    def test_update_extra_arguments(self):
        """Extra arguments are ignored."""
        self.s.update(1, 2, 3, 4, 5)
        self.assertEqual(str(self.s), "[Square] (1) 3/4 - 2")
 
    def test_update_kwargs(self):
        """Keyword arguments are applied by name."""
        self.s.update(x=12)
        self.assertEqual(str(self.s), "[Square] (1) 12/0 - 5")
 
    def test_update_several_kwargs(self):
        """Several keyword arguments are applied at once."""
        self.s.update(size=7, y=1)
        self.assertEqual(str(self.s), "[Square] (1) 0/1 - 7")
 
    def test_update_kwargs_with_id(self):
        """The id can be updated by keyword."""
        self.s.update(size=7, id=89, y=1)
        self.assertEqual(str(self.s), "[Square] (89) 0/1 - 7")
 
    def test_update_unknown_kwarg(self):
        """An unknown key is ignored."""
        self.s.update(colour="red")
        self.assertEqual(str(self.s), "[Square] (1) 0/0 - 5")
 
    def test_args_beats_kwargs(self):
        """kwargs are skipped when args is given."""
        self.s.update(89, 2, size=7)
        self.assertEqual(str(self.s), "[Square] (89) 0/0 - 2")
 
    def test_update_validates(self):
        """update validates its values."""
        with self.assertRaisesRegex(ValueError, "width must be > 0"):
            self.s.update(1, -2)
 
 
class TestSquareToDictionary(unittest.TestCase):
    """Test the to_dictionary method."""
 
    def test_type(self):
        """to_dictionary returns a dictionary."""
        self.assertIs(type(Square(10, 2, 1).to_dictionary()), dict)
 
    def test_keys(self):
        """The dictionary holds exactly four keys."""
        result = Square(10, 2, 1, 1).to_dictionary()
        self.assertEqual(sorted(result.keys()), ["id", "size", "x", "y"])
 
    def test_values(self):
        """The dictionary holds the current values."""
        result = Square(10, 2, 1, 5).to_dictionary()
        self.assertEqual(result, {"id": 5, "size": 10, "x": 2, "y": 1})
 
    def test_used_by_update(self):
        """A dictionary can be fed back into update."""
        s1 = Square(10, 2, 1, 5)
        s2 = Square(1, 1)
        s2.update(**s1.to_dictionary())
        self.assertEqual(str(s1), str(s2))
 
    def test_objects_stay_different(self):
        """Two squares with equal values are not the same object."""
        s1 = Square(10, 2, 1, 5)
        s2 = Square(1, 1)
        s2.update(**s1.to_dictionary())
        self.assertIsNot(s1, s2)
 
 
class TestSquareFiles(unittest.TestCase):
    """Test the Base file methods as used by Square."""
 
    def tearDown(self):
        """Remove any file created by a test."""
        for name in ("Square.json", "Square.csv"):
            try:
                os.remove(name)
            except OSError:
                pass
 
    def test_save_to_file_none(self):
        """Square.save_to_file(None) writes an empty list."""
        Square.save_to_file(None)
        with open("Square.json", "r") as f:
            self.assertEqual(f.read(), "[]")
 
    def test_save_to_file_empty_list(self):
        """Square.save_to_file([]) writes an empty list."""
        Square.save_to_file([])
        with open("Square.json", "r") as f:
            self.assertEqual(f.read(), "[]")
 
    def test_save_to_file_one_square(self):
        """One square is written as one JSON object."""
        Square.save_to_file([Square(10, 2, 8, 1)])
        with open("Square.json", "r") as f:
            self.assertEqual(
                Square.from_json_string(f.read()),
                [{"id": 1, "size": 10, "x": 2, "y": 8}])
 
    def test_save_to_file_two_squares(self):
        """Two squares are written as two JSON objects."""
        Square.save_to_file([Square(5), Square(7, 9, 1)])
        with open("Square.json", "r") as f:
            self.assertEqual(len(Square.from_json_string(f.read())), 2)
 
    def test_save_to_file_overwrites(self):
        """Saving twice overwrites the file."""
        Square.save_to_file([Square(5), Square(7, 9, 1)])
        Square.save_to_file([Square(1)])
        with open("Square.json", "r") as f:
            self.assertEqual(len(Square.from_json_string(f.read())), 1)
 
    def test_save_to_file_creates_the_file(self):
        """The file is named after the class."""
        Square.save_to_file([Square(1)])
        self.assertTrue(os.path.exists("Square.json"))
 
    def test_load_from_file_missing(self):
        """A missing file gives an empty list."""
        self.assertEqual(Square.load_from_file(), [])
 
    def test_load_from_file_after_none(self):
        """Saving None then loading gives an empty list."""
        Square.save_to_file(None)
        self.assertEqual(Square.load_from_file(), [])
 
    def test_load_from_file_type(self):
        """load_from_file returns a list."""
        Square.save_to_file([Square(5)])
        self.assertIs(type(Square.load_from_file()), list)
 
    def test_load_from_file_instance_type(self):
        """Loaded objects are Squares."""
        Square.save_to_file([Square(5)])
        self.assertIs(type(Square.load_from_file()[0]), Square)
 
    def test_load_from_file_values(self):
        """Squares survive a save and load cycle."""
        r1 = Square(10, 7, 2, 8)
        r2 = Square(7, 9, 1)
        Square.save_to_file([r1, r2])
        loaded = Square.load_from_file()
        self.assertEqual([str(r1), str(r2)], [str(o) for o in loaded])
 
    def test_load_from_file_new_objects(self):
        """Loading builds new objects."""
        r1 = Square(5)
        Square.save_to_file([r1])
        self.assertIsNot(Square.load_from_file()[0], r1)
 
    def test_save_to_file_csv_none(self):
        """Square.save_to_file_csv(None) writes an empty file."""
        Square.save_to_file_csv(None)
        with open("Square.csv", "r") as f:
            self.assertEqual(f.read(), "")
 
    def test_save_to_file_csv_empty_list(self):
        """Square.save_to_file_csv([]) writes an empty file."""
        Square.save_to_file_csv([])
        with open("Square.csv", "r") as f:
            self.assertEqual(f.read(), "")
 
    def test_save_to_file_csv_format(self):
        """A row is id,size,x,y."""
        Square.save_to_file_csv([Square(10, 2, 8, 1)])
        with open("Square.csv", "r") as f:
            self.assertEqual(f.read().strip(), "1,10,2,8")
 
    def test_save_to_file_csv_overwrites(self):
        """Saving twice overwrites the file."""
        Square.save_to_file_csv([Square(5), Square(7, 9, 1)])
        Square.save_to_file_csv([Square(1, 0, 0, 9)])
        with open("Square.csv", "r") as f:
            self.assertEqual(f.read().strip(), "9,1,0,0")
 
    def test_load_from_file_csv_missing(self):
        """A missing CSV file gives an empty list."""
        self.assertEqual(Square.load_from_file_csv(), [])
 
    def test_load_from_file_csv_type(self):
        """Loaded CSV objects are Squares."""
        Square.save_to_file_csv([Square(5)])
        self.assertIs(type(Square.load_from_file_csv()[0]), Square)
 
    def test_load_from_file_csv_values(self):
        """Squares survive a CSV round trip."""
        r1 = Square(10, 7, 2, 8)
        r2 = Square(7, 9, 1)
        Square.save_to_file_csv([r1, r2])
        loaded = Square.load_from_file_csv()
        self.assertEqual([str(r1), str(r2)], [str(o) for o in loaded])
 
 
class TestSquareJsonAndCreate(unittest.TestCase):
    """Test the Base JSON helpers and create as used by Square."""
 
    def test_to_json_string_none(self):
        """None gives an empty list string."""
        self.assertEqual(Square.to_json_string(None), "[]")
 
    def test_to_json_string_empty_list(self):
        """An empty list gives an empty list string."""
        self.assertEqual(Square.to_json_string([]), "[]")
 
    def test_to_json_string_type(self):
        """to_json_string returns a string."""
        r = Square(10, 2, 8, 1)
        self.assertIs(type(Square.to_json_string([r.to_dictionary()])), str)
 
    def test_to_json_string_one_square(self):
        """A square dictionary is serialized."""
        r = Square(10, 2, 8, 1)
        result = Square.to_json_string([r.to_dictionary()])
        self.assertEqual(Square.from_json_string(result),
                         [r.to_dictionary()])
 
    def test_from_json_string_none(self):
        """None gives an empty list."""
        self.assertEqual(Square.from_json_string(None), [])
 
    def test_from_json_string_empty(self):
        """An empty string gives an empty list."""
        self.assertEqual(Square.from_json_string(""), [])
 
    def test_from_json_string_type(self):
        """from_json_string returns a list."""
        self.assertIs(type(Square.from_json_string('[{"id": 1}]')), list)
 
    def test_create_values(self):
        """create rebuilds a square from its dictionary."""
        r1 = Square(3, 5, 1, 7)
        r2 = Square.create(**r1.to_dictionary())
        self.assertEqual(str(r1), str(r2))
 
    def test_create_type(self):
        """create returns a Square."""
        self.assertIs(type(Square.create(**{"id": 1, "size": 2})), Square)
 
    def test_create_is_a_new_object(self):
        """create returns a different object."""
        r1 = Square(3, 5, 1)
        self.assertIsNot(Square.create(**r1.to_dictionary()), r1)
 
 
if __name__ == "__main__":
    unittest.main()
SETEOF
 
# --- 3. Clean whitespace, force trailing newline -----------------
for f in $ALL_FILES; do
    [ -s "$f" ] || continue
    TMPF="$(mktemp)"
    sed -e 's/\r$//' -e 's/[[:space:]]*$//' "$f" > "$TMPF"
    cat "$TMPF" > "$f"
    rm -f "$TMPF"
    if [ -n "$(tail -c 1 "$f")" ]; then
        printf '\n' >> "$f"
    fi
done
 
# all files must be executable for this project
chmod +x 101-main.py models/*.py tests/*.py tests/test_models/*.py
 
echo
echo "Files created:"
find . -name "*.py" -o -name "*.md" | sort
 
if [ "${2:-}" = "--no-test" ]; then
    echo
    echo "Done (tests skipped)."
    exit 0
fi
 
# --- 4. Style check ----------------------------------------------
echo
echo "--- pycodestyle ---"
if command -v pycodestyle > /dev/null 2>&1; then
    pycodestyle 101-main.py models/*.py tests/*.py \
        tests/test_models/*.py &&
        echo "PEP8: OK (0 errors)"
else
    echo "pycodestyle not installed, skipping (pip3 install pycodestyle)"
fi
 
# --- 5. Documentation check --------------------------------------
echo
echo "--- docstrings ---"
python3 - << 'PYEOF'
import inspect
from models.base import Base
from models.rectangle import Rectangle
from models.square import Square
import models.base
import models.rectangle
import models.square
 
MISSING = []
for module in (models.base, models.rectangle, models.square):
    if not module.__doc__:
        MISSING.append(module.__name__)
for cls in (Base, Rectangle, Square):
    if not cls.__doc__:
        MISSING.append(cls.__name__)
    for name, member in inspect.getmembers(cls):
        if name.startswith("__") and name != "__init__" and name != "__str__":
            continue
        if inspect.isfunction(member) and not member.__doc__:
            MISSING.append("{}.{}".format(cls.__name__, name))
 
if MISSING:
    print("missing docstrings: {}".format(", ".join(MISSING)))
else:
    print("every module, class and method has a docstring")
PYEOF
 
# --- 6. Unittests ------------------------------------------------
echo
echo "--- unittest discover tests ---"
python3 -m unittest discover tests 2>&1 | tail -4
 
# --- 7. Behaviour against the task examples ----------------------
echo
echo "--- sample output ---"
python3 - << 'PYEOF'
from models.base import Base
from models.rectangle import Rectangle
from models.square import Square
 
print("ids:", Base().id, Base().id, Base(12).id, Base().id)
r = Rectangle(2, 3, 2, 2, 12)
print(r)
r.display()
r.update(89, 2, 3, 4, 5)
print(r, "area", r.area())
s = Square(3, 1, 3, 7)
print(s, s.to_dictionary())
PYEOF
 
find . -name __pycache__ -type d -exec rm -rf {} + 2> /dev/null || true
rm -f Rectangle.json Square.json Base.json Rectangle.csv Square.csv
 
echo
echo "--- done ---"