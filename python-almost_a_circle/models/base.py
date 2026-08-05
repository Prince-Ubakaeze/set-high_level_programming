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
