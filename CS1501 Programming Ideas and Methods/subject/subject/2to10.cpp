#include "count_exchange.h"

//十进制与二进制互相转化

void ex_2_to_10()
{

 cout<<"请输入一个二进制数：";
 char a[10000];
 cin>>a;

 int n=strlen(a);

 int sum=0;
 for(int i=0;i<n;i++)
 {
  if(a[i]=='1')
  sum+=pow(2,n-i-1);
  else
  sum+=0;

 }
 cout<<"该二进制数转化为十进制数为："<<sum;
}

void ex_10_to_2()
{
  int num;
  cout<<"请输入一个十进制数：";
  cin>>num;
  int n=0;



  while(num-pow(2,n)>=0)
  {
   n++;
  }


  n-=1;

  int a[n];


  for(int i=0;i<=n;)
  {
   if(num-pow(2,n-i)>=0)
   {
    a[i]=1;
    num-=pow(2,n-i);
    i++;
   }
   else
   {
    a[i]=0;
    i++;
   }
  }
  cout<<"该十进制数转化为二进制数为：";
  for(int i=0;i<=n;i++)
  cout<<a[i];
}
