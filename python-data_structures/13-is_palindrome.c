#include "lists.h"

/**
 * reverse_list - reverses a singly linked list
 * @head: pointer to the first node
 *
 * Return: pointer to the new first node
 */
static listint_t *reverse_list(listint_t *head)
{
	listint_t *previous;
	listint_t *next;

	previous = NULL;
	while (head != NULL)
	{
		next = head->next;
		head->next = previous;
		previous = head;
		head = next;
	}

	return (previous);
}

/**
 * is_palindrome - checks whether a singly linked list is a palindrome
 * @head: address of the pointer to the first node
 *
 * Return: 1 if the list is a palindrome, otherwise 0
 */
int is_palindrome(listint_t **head)
{
	listint_t *slow;
	listint_t *fast;
	listint_t *previous_slow;
	listint_t *middle;
	listint_t *second_half;
	listint_t *second_half_copy;
	listint_t *first_half;
	int result;

	if (head == NULL || *head == NULL || (*head)->next == NULL)
		return (1);

	slow = *head;
	fast = *head;
	previous_slow = NULL;
	while (fast != NULL && fast->next != NULL)
	{
		previous_slow = slow;
		slow = slow->next;
		fast = fast->next->next;
	}

	middle = NULL;
	if (fast != NULL)
	{
		middle = slow;
		second_half = slow->next;
	}
	else
		second_half = slow;

	previous_slow->next = NULL;
	second_half = reverse_list(second_half);
	second_half_copy = second_half;
	first_half = *head;
	result = 1;

	while (first_half != NULL && second_half != NULL)
	{
		if (first_half->n != second_half->n)
		{
			result = 0;
			break;
		}
		first_half = first_half->next;
		second_half = second_half->next;
	}

	second_half = reverse_list(second_half_copy);
	if (middle != NULL)
	{
		previous_slow->next = middle;
		middle->next = second_half;
	}
	else
		previous_slow->next = second_half;

	return (result);
}
