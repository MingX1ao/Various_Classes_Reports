#include<iostream>
#include<cmath>
using namespace std;
int main(){
   int a=0,b=0,c=0;
   double x1=0,x2=0,y=0;
   cin>>a>>b>>c;
   y=c;
   if (b*b-4*a*c<0){
     cout<<"\n"<<endl;
     cout<<int(y)<<endl;
     }
   if (b*b-4*a*c==0){
     x1=(-b+sqrt(b*b-4*a*c))/2/a;
     cout<<int(x1)<<endl;
     cout<<int(y)<<endl;
     }
   if (b*b-4*a*c>0){
     x1=(-b+sqrt(b*b-4*a*c))/2/a,x2=(-b-sqrt(b*b-4*a*c))/2/a;
     cout<<int(x2)<<"  "<<int(x1)<<endl;
     cout<<int(y)<<endl;
     }



}
