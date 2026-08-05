#!/usr/bin/python3
"""Unittests for models/base.py."""
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
