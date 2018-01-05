#include<stdio.h>
#include<stdlib.h>
int main()
{
  char *name;
  //scanf("%ms",&name);
  //printf("%s",name);
  name = (char*)calloc(1,sizeof(char));
  int len = 0;
  char c;
  while(1){
    c = getchar();
    if(c == '\n')
      break;
    len = sizeof(name);
    name = realloc(name,len+1);
    *(name+len)=c;
    *(name+len+1)='\0';
    printf("%d%s",len,name);
  }
  printf("%d%s",len,name);
  free(name);
  return 0;  
}
