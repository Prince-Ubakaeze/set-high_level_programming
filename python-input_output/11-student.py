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
