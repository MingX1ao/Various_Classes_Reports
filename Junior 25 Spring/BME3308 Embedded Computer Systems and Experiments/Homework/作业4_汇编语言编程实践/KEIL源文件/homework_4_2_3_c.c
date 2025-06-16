#include<reg51.h>

extern int SQR(int a, int b);	

int main()
{
	int a = 255;
	int b = 254;
	int c = SQR(a, b);
	return 0;
}