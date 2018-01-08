#include<iostream>
using namespace std;
class Box{
int size;
string colour;
public:
    Box(){
        size = 0;
        colour = "red";
    }
    Box give_size(){
        cout<<size<<"\n";
        return *this; 
    }
    Box give_colour(){
        cout<<colour<<"\n";
        return *this;
    }
};

int main(){
Box blackbox;
Box tryBox=(blackbox.give_size()).give_colour();
return 0;
}
