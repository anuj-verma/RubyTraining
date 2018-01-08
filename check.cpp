#include<iostream>
#include<cstring>
using namespace std;

class car
{
	string colour;
	int size;
	public:
	car car_colour()
	{
		this->colour="red";
		return *this;
	}
	car car_size()
	{
		this->size=123;
		return *this;
	}
	void print()
	{
		cout<<"colour : "<<this->colour<<" "<<"size : "<<this->size;
	}
};
int main()
{
	car benz;
	benz.car_colour().car_size().print();
	return 0;
}

