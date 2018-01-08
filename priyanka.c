#include<stdio.h>
#include<stdlib.h>
int main()
{
char string1;
char *mem;
int i=1;
mem=(void*)malloc(1);
scanf("%c",&string1);
*(mem)=string1;
while(name!='\n')

{

scanf("%c",&string1);
	mem =(void*)realloc(mem,1);
	*(mem+i)=name;
	i=i+1;
}
	mem =(void*)realloc(mem,1);

	*(mem+i+1)='\0';
printf("%s",mem);
return 0;	
}
