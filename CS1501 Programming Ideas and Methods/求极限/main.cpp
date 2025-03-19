#include <iostream>
#include<cmath>
using namespace std;

int main()
{double i=1,a=0,b=0;
   while (i>=1){
   b=i*i*i*i*(i-1);
   a=i-pow(b,1.0/5);
   i=i+1;
   cout<<a<<endl;
   }
   return 0;


}
