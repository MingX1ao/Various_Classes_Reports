#include <iostream>
#include <cmath>

using namespace std;

int main()
{double a ,b,c,dlt,x1,x2;
 cout<<"ϵ��"<<a<<b<<c<<endl;
 cin>>a>>b>>c;
 dlt=b*b-4*a*c;

 if (dlt<0)   cout<<"�����޽�"<<endl;
   else
   x1=(-b+sqrt(dlt))/2/a;
   x2=(-b-sqrt(dlt))/2/a;
   cout<<"x1="<<x1<<"���ǿո�"<<x2="<<x2;


    return 0;
}
