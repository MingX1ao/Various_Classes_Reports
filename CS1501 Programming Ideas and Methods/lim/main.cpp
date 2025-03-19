#include <iostream>
#include <cmath>
using namespace std;

int main()
{
 int i=1;
 long double e=2.718281828459045,jieguo=0,b=0;

 while(1){
 b=pow(1+1.0/i,i);
 jieguo=i*i*(pow(e,b)-pow(b,e));
 cout<<jieguo<<endl;
 i++;
 }
}
