#include <iostream>
using namespace std;

void remote_function(char s[]) { cout << "[ remote_func ] " << s; }

int main() {
	FILE *f = fopen("addr.txt", "w");
	fprintf(f, "%p", remote_function);
	fclose(f);
	while (true) {}
}

