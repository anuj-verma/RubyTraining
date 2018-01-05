#include<stdio.h>
#include<stdlib.h>
int main()
{
	int i=1;
	char string1, *new;
	new=(void*)malloc(1);
	scanf("%c",&string1);
	*(new)=string1;
	while(string1!='\n')
	{
		scanf("%c",&string1);
		new =(void*)realloc(new,1);
		*(new+i)=string1;
		i=i+1;
	}
	new =(void*)realloc(new,1);
	*(new+i+1)='\0';
	printf("%s",new);
return 0;	
}
