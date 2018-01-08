#include<iostream>
#include<string>
using namespace std;

class Car
{
	int car_size;
	string car_colour;
public:
	Car &colour(string const &color)
	{
		this->car_colour=color;
		return *this;
	}
	
	Car &size1(int const &size)
	{
		this->car_size=size;
		return *this;
	}
};

int main()
{
	Car first_car;
	//cout<< first_car.size1(60)<<endl;
	cout<< first_car.size1(60).colour("BLUE")<<endl;
	return 0;
}

