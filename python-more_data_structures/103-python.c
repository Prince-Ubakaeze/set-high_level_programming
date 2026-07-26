#include <Python.h>
#include <stdio.h>

/**
 * print_python_bytes - prints information about a Python bytes object
 * @p: pointer to a Python object
 *
 * Return: nothing
 */
void print_python_bytes(PyObject *p)
{
	PyBytesObject *bytes;
	Py_ssize_t size;
	Py_ssize_t limit;
	Py_ssize_t index;
	unsigned char value;

	printf("[.] bytes object info\n");

	if (p == NULL || p->ob_type != &PyBytes_Type)
	{
		printf("  [ERROR] Invalid Bytes Object\n");
		return;
	}

	bytes = (PyBytesObject *)p;
	size = ((PyVarObject *)p)->ob_size;

	printf("  size: %ld\n", (long)size);
	printf("  trying string: %s\n", bytes->ob_sval);

	limit = size + 1;
	if (limit > 10)
		limit = 10;

	printf("  first %ld bytes:", (long)limit);
	for (index = 0; index < limit; index++)
	{
		value = (unsigned char)bytes->ob_sval[index];
		printf(" %02x", value);
	}
	printf("\n");
}

/**
 * print_python_list - prints information about a Python list
 * @p: pointer to a Python list object
 *
 * Return: nothing
 */
void print_python_list(PyObject *p)
{
	PyListObject *list;
	PyObject *item;
	Py_ssize_t size;
	Py_ssize_t index;

	list = (PyListObject *)p;
	size = ((PyVarObject *)p)->ob_size;

	printf("[*] Python list info\n");
	printf("[*] Size of the Python List = %ld\n", (long)size);
	printf("[*] Allocated = %ld\n", (long)list->allocated);

	for (index = 0; index < size; index++)
	{
		item = list->ob_item[index];
		printf("Element %ld: %s\n", (long)index,
		       item->ob_type->tp_name);

		if (item->ob_type == &PyBytes_Type)
			print_python_bytes(item);
	}
}
