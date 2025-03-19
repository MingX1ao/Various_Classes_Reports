#include <iostream>
#include <cmath>
using namespace std;


int main()
{int k,i,a[5],b=0,c=0,d=0;
cin>>k;
for (i=1;i<=5;i++){
  a[i-1]=(k/int(pow(10,i-1)))%10;
}
for (i=1;i<=5;i++){
   if (a[i-1]<b) continue;
   b=a[i-1],d=i-1;
   c=a[0],a[0]=b,a[d]=c;
}
for (b=0,c=0,d=0,i=1;i<=4;i++){
   if (a[i]<b) continue;
   b=a[i],d=i;
   c=a[1],a[1]=b,a[d]=c;
}
for (b=0,c=0,d=0,i=1;i<=3;i++){
   if (a[i+1]<b) continue;
   b=a[i+1],d=i+1;
   c=a[2],a[2]=b,a[d]=c;
}
cout<<100*a[0]+10*a[1]+a[2];
}
