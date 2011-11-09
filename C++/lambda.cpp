#include <algorithm>
#include <iostream>
#include <vector>
#include <list>

int main(){
	std::list<int> l;

	for(int i=0; i<100; ++i){
		l.push_back(i);
	}

	l.remove_if([](int i){return  i%2 == 0;});
	std::vector<int> v(l.begin(), l.end());

	for(auto it=v.begin(); it!=v.end(); ++it){
		std::cout << *it << " ";
	}

	return 0;
}
