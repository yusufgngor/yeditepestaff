#include "myDebugHdr.h"
int main()
{
	int a, b;
	@set a // variable “a” will be traced
	@set b // variable “b” will be traced
	b = 0;
	a = 1;
	while (b < 10)
	{
		a = a + b;
		b = b + 1;
		@breakpoint b 1 // display the last value of variable “b”
	}
	@breakpoint a 10 // display last 10 values of variable “a”
	return 0;
}
