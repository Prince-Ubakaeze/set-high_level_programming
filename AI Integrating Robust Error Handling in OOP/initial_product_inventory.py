#!/usr/bin/python3
"""Initial Product Inventory Manager without data validation."""


class Product:
    """Represents a product with a name, price, and quantity."""

    def __init__(self, name, price, quantity):
        self.name = name
        self.price = price
        self.quantity = quantity


class InventoryManager:
    """Manages the collection of products and inventory operations."""

    def __init__(self, inventory=None):
        self.inventory = inventory if inventory is not None else []

    def add_product(self, product):
        """Add a product object to the inventory list."""
        self.inventory.append(product)

    def update_quantity(self, name, new_quantity):
        """Update the quantity of a product by name."""
        for product in self.inventory:
            if product.name == name:
                product.quantity = new_quantity
                break

    def calculate_total_value(self):
        """Calculate the total monetary value of the inventory."""
        total = 0

        for product in self.inventory:
            total += product.price * product.quantity

        return total

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
