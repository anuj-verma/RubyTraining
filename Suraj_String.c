// Suraj S Jagtap.
//C program To read a string without memory wastage..
// 5th Jan 2018

#include<stdio.h>
#include<malloc.h>

int main()
{
char *ptr=NULL;


ptr=(char *)malloc(sizeof(char));

printf("Enter Name: ");
scanf("%[^\n]s",ptr);

printf("%s",ptr);
return 0;
}
