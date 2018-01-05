#include<stdio.h>
#include<stdlib.h>
int main()
{
	char *arr;

	arr=(char*)malloc(sizeof(char));
	printf("Enter the name:");
	scanf("%[^\n]s",arr);

	printf("\nYour name is :%s",arr);
	return 0;
}
