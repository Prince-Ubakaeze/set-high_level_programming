#!/usr/bin/python3
"""Unittests for models/rectangle.py."""
import io
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


if __name__ == "__main__":
    unittest.main()
