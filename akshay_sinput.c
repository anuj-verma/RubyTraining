#include<stdio.h>
#include<stdlib.h>
int main()
{
    char *name;
    //scanf("%ms",name);
    //printf("%s",name);
    char *name=(char*)calloc(1,sizeof(char));
    int len =0;
    char c;
    while(1){
        c = getchar();
        if(c == '\n')
            break;
        *(name+len)=c;
        *(name+len+1)='\0';
        name=(char *) realloc(str, len+1);
        len+=1;
        
    }
    printf("%s %lld",name,sizeof(name));
    return 0;
}
