# Python - Almost a circle

Project files for `python-almost_a_circle` in the `set-high_level_programming` repository.

## Package

| File | Contents |
| --- | --- |
| `models/__init__.py` | Makes `models` a package |
| `models/base.py` | `Base`: id management, JSON and CSV serialization |
| `models/rectangle.py` | `Rectangle`: validation, `area`, `display`, `update`, `to_dictionary` |
| `models/square.py` | `Square`: `size` property, `update`, `to_dictionary` |

## Tests

Run the whole suite from the project root:

```
python3 -m unittest discover tests
```

| File | Covers |
| --- | --- |
| `tests/test_models/test_base.py` | id handling, JSON strings, files, CSV, `create` |
| `tests/test_models/test_rectangle.py` | instantiation, validation, area, display, str, update, dictionary |
| `tests/test_models/test_square.py` | inheritance, size, validation, display, str, update, dictionary |
