#include <iostream>
#include <iomanip>
#include <cstring>
using namespace std;


int main()
{
 /*char *a;
 int n;
 a=new char[80]();
 cin.getline(a,80);
 cin>>n;
 a=a+n;
 for (int i=0;;i++)
 if (*(a+i)=='\0') break;
 else
 cout<<*(a+i);*/
int x=5;
double y = 3.14;
int *p = &x;
*(p+1)=1;
*(p+2)=-5;
cout<<y;



}
