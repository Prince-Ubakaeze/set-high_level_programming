#include "lists.h"

/**
 * check_cycle - checks if a singly linked list contains a cycle
 * @list: pointer to the first node
 *
 * Return: 1 if there is a cycle, otherwise 0
 */
int check_cycle(listint_t *list)
{
	listint_t *slow;
	listint_t *fast;

	slow = list;
	fast = list;

	while (fast != NULL && fast->next != NULL)
	{
		slow = slow->next;
		fast = fast->next->next;

		if (slow == fast)
			return (1);
	}

	return (0);
}