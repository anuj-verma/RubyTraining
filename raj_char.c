#include<stdio.h>
int main()
{
	int i=1;
	char *name=NULL,x;
	name=(char*)malloc(sizeof(char));
	printf("Enter name : ");
	while(scanf("%c",&x),x=='\n');
	name[0]=x;
	while(x!='\n')
	{
		scanf("%c",&x);
		name[i++]=x;
	}
	name[i]='\0';
	printf("\nName = %s",name);
}
