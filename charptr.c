#include<malloc.h>
#include<stdio.h>
#include<string.h>
main()
{
  char* nm = calloc(1,sizeof(char));
  char c;
  int len;
printf("\nEnter Name : ");
  while(scanf("%c", &c)==1)
  {  
   if(c== '\n')     
    break;   
   len = strlen(nm); 
//   printf("Length : %d",len);
   nm= realloc(nm,len+1);   
   *(nm+len) = c;   
   *(nm+len+1) = '\0'; 
  }
  printf("\nName : %s\n",nm);
}
