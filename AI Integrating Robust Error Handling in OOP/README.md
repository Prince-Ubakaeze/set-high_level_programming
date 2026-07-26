# AI: Integrating Robust Error Handling in OOP

## Objective

This task improves a Product Inventory Manager by introducing robust
data validation, property setters, private backing attributes, and a custom
exception.

The refactoring prevents products from entering invalid states, such as
having a negative price or negative quantity.

## AI Tool Used

Gemini Code Assist in Visual Studio Code.

## Files

| File | Description |
|---|---|
| `initial_product_inventory.py` | Original inventory program without property-based validation |
| `refactored_product_inventory.py` | Final program with properties and a custom exception |
| `README.md` | Documentation for the task |

## Identified Problems

The original Product class allowed direct assignment to its attributes.

For example:

```python
product.quantity = -5
class InvalidProductDataError(ValueError):
    """Raised when invalid product information is assigned."""
product.quantity = -5
