#!/usr/bin/python3
"""Unittests for models/square.py."""
import io
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


if __name__ == "__main__":
    unittest.main()
