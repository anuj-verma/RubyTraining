//fails
#include<iostream> 
 
using namespace std;

class Car{

public:
	int first(int in)
	{
		return in+1;
	}

	int second(int in)
	{
		return in+1;
	}

};

class check{
check()
	{
		Car testObj1 = new Car();

		cout<<testObj1.first(1);
	}
};
