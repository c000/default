#include <tuple>
#include <iostream>
#include <string>

int main(){
	auto t1 = std::tuple<std::string,int,int>("hoge", 2, 3);
	std::string s1;
	int i1, i2;
	std::tie(s1,i1,i2) = t1;

	std::cout << s1 << i1 << i2 << std::endl;
	return 0;
}
