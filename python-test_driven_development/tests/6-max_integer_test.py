#!/usr/bin/python3
"""Unittest for max_integer([..])
"""
import unittest
max_integer = __import__('6-max_integer').max_integer


class TestMaxInteger(unittest.TestCase):
    """Test cases for the max_integer function."""

    def test_ordered_list(self):
        """A list already sorted in ascending order."""
        self.assertEqual(max_integer([1, 2, 3, 4]), 4)

    def test_unordered_list(self):
        """A list where the max is in the middle."""
        self.assertEqual(max_integer([1, 3, 4, 2]), 4)

    def test_max_at_beginning(self):
        """A list where the max is the first element."""
        self.assertEqual(max_integer([4, 3, 2, 1]), 4)

    def test_empty_list(self):
        """An empty list returns None."""
        self.assertIsNone(max_integer([]))

    def test_no_argument(self):
        """No argument uses the default empty list."""
        self.assertIsNone(max_integer())

    def test_one_element(self):
        """A list with a single element."""
        self.assertEqual(max_integer([7]), 7)

    def test_negative_numbers(self):
        """A list of negative integers."""
        self.assertEqual(max_integer([-4, -3, -7, -1]), -1)

    def test_mixed_signs(self):
        """A list mixing negative and positive integers."""
        self.assertEqual(max_integer([-10, 0, 5, -2]), 5)

    def test_duplicates(self):
        """A list where the max value appears more than once."""
        self.assertEqual(max_integer([2, 9, 9, 3]), 9)

    def test_floats(self):
        """A list of floats."""
        self.assertEqual(max_integer([1.5, 2.5, 0.5]), 2.5)

    def test_ints_and_floats(self):
        """A list mixing integers and floats."""
        self.assertEqual(max_integer([1, 2.5, 2, 0]), 2.5)

    def test_strings(self):
        """A list of strings is compared alphabetically."""
        self.assertEqual(max_integer(["Bob", "Alice", "Zoe"]), "Zoe")

    def test_single_string(self):
        """A string is treated as a list of characters."""
        self.assertEqual(max_integer("hello"), "o")

    def test_none_raises(self):
        """None has no length."""
        with self.assertRaises(TypeError):
            max_integer(None)

    def test_mixed_types_raises(self):
        """Comparing a string with an integer raises a TypeError."""
        with self.assertRaises(TypeError):
            max_integer([1, "2", 3])


if __name__ == '__main__':
    unittest.main()
