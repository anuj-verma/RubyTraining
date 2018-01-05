#include<stdio.h>
#include<stdlib.h>
void main()
{
 char name;
char *mem=(void*)malloc(1);
char *mem_new;
scanf("%c",&name);
printf("%c",name);
*mem=name;
printf("%s",mem);
int i=1;
while(name!='\n')
{
	

scanf("%c",&name);
i++;
mem=(char*)realloc(mem,sizeof(char)+i);
*(mem+i)=name;
}
printf("%s",*mem);
}
