#include<reg51.h>

int RM(int A, int B){
	int C = A*A + B*B;
	return C;
}

int main(){
	int A = 3;
	int B = 4;
	int C = 0;
	C = RM(A, B);
	return 0;
}