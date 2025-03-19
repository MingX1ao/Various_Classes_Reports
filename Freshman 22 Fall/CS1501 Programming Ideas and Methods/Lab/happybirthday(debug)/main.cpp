#include <iostream>
#include <ctime>
#include <cstdlib>
using namespace std;

int main()
{
 int n=0,i=0,j=0,b=0;
 srand(time(NULL));
 cin>>n;
 for (i=1;i<=n;i++)
  {
   for (j=1;j<=n-i;j++)
    {cout<<"   ";}
   for (j=n-i+1;j<=n+i-1;j++)
    {
     b=rand()%2;
     switch (b)
      {
       case 0:cout<<"[&]";break;
       case 1:cout<<"[*]";break;
      }
    }
   cout<<"[#]"<<endl;
  }
}
