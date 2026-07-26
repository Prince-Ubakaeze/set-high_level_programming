#!/usr/bin/python3
"""Defines a sorted singly linked list."""


class Node:
    """Represents a node in a singly linked list."""

    def __init__(self, data, next_node=None):
        self.data = data
        self.next_node = next_node

    @property
    def data(self):
        """Return the node data."""
        return self.__data

    @data.setter
    def data(self, value):
        """Set and validate the node data."""
        if not isinstance(value, int):
            raise TypeError("data must be an integer")
        self.__data = value

    @property
    def next_node(self):
        """Return the next node."""
        return self.__next_node

    @next_node.setter
    def next_node(self, value):
        """Set and validate the next node."""
        if value is not None and not isinstance(value, Node):
            raise TypeError("next_node must be a Node object")
        self.__next_node = value


class SinglyLinkedList:
    """Represents a sorted singly linked list."""

    def __init__(self):
        self.__head = None

    def __str__(self):
        values = []
        current = self.__head

        while current is not None:
            values.append(str(current.data))
            current = current.next_node

        return "\n".join(values)

    def sorted_insert(self, value):
        """Insert a value in increasing order."""
        new_node = Node(value)

        if self.__head is None or value < self.__head.data:
            new_node.next_node = self.__head
            self.__head = new_node
            return

        current = self.__head
        while (
            current.next_node is not None
            and current.next_node.data < value
        ):
            current = current.next_node

        new_node.next_node = current.next_node
        current.next_node = new_node
