#!/usr/bin/python3
"""Product Inventory Manager with robust validation and exceptions."""


class InvalidProductDataError(ValueError):
    """Raised when invalid product information is assigned."""


class Product:
    """Represents a product with validated price and quantity values."""

    def __init__(self, name, price, quantity):
        self.name = name
        self.price = price
        self.quantity = quantity

    @property
    def price(self):
        """Return the product price."""
        return self.__price

    @price.setter
    def price(self, value):
        """Validate and assign the product price."""
        if isinstance(value, bool) or not isinstance(value, (int, float)):
            raise InvalidProductDataError(
                "Price must be a number."
            )

        if value < 0:
            raise InvalidProductDataError(
                "Price cannot be negative."
            )

        self.__price = float(value)

    @property
    def quantity(self):
        """Return the product quantity."""
        return self.__quantity

    @quantity.setter
    def quantity(self, value):
        """Validate and assign the product quantity."""
        if isinstance(value, bool) or not isinstance(value, int):
            raise InvalidProductDataError(
                "Quantity must be an integer."
            )

        if value < 0:
            raise InvalidProductDataError(
                "Quantity cannot be negative."
            )

        self.__quantity = value


class InventoryManager:
    """Manages the collection of products and inventory operations."""

    def __init__(self, inventory=None):
        self.inventory = inventory if inventory is not None else []

    def add_product(self, product):
        """Add a product object to the inventory list."""
        if not isinstance(product, Product):
            raise TypeError(
                "product must be a Product instance"
            )

        self.inventory.append(product)

    def update_quantity(self, name, new_quantity):
        """Update quantity through the Product property setter."""
        for product in self.inventory:
            if product.name == name:
                product.quantity = new_quantity
                return True

        return False

    def calculate_total_value(self):
        """Calculate the total monetary value of the inventory."""
        return sum(
            product.price * product.quantity
            for product in self.inventory
        )

    def display_inventory(self):
        """Print the current inventory list."""
        for product in self.inventory:
            print(
                f"{product.name} - "
                f"${product.price:.2f} x {product.quantity}"
            )


manager = InventoryManager()
manager.add_product(Product("Laptop", 1200.00, 5))
manager.add_product(Product("Mouse", 25.00, 20))
manager.update_quantity("Mouse", 18)

print("Current Inventory:")
manager.display_inventory()

print(
    f"\nTotal Inventory Value: "
    f"${manager.calculate_total_value():.2f}"
)

print("\n--- Testing Invalid Input ---")

try:
    manager.inventory[0].quantity = -5
except Exception as error:
    print(f"Test result: {error}")
