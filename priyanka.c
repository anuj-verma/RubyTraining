#include<stdio.h>
#include<stdlib.h>
int main()
{
 char name;
char *mem;
int i=1;
mem=(void*)malloc(1);
scanf("%c",&name);
*(mem)=name;
while(name!='\n')

{

scanf("%c",&name);
	mem =(void*)realloc(mem,1);
	*(mem+i)=name;
	i=i+1;
}
	mem =(void*)realloc(mem,1);

	*(mem+i+1)='\0';
printf("%s",mem);
return 0;	
}
