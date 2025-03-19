#include <iostream>
using namespace std;

int jisuan1(int a,int b,int c);
int jisuan2(int a,int b,int c);
int main()
{
 int tmp=0;
 bool flag=false;
 int n,time[100],sum1=0,sum2=0;
 cin>>n;
 for (int i=0;i<n;i++)
 cin>>time[i];

 for (int i=1;i<n;i++)
  {
   flag=false;
   for (int j=0;j<n-i;j++)
     if (time[j]>time[j+1]) tmp=time[j],time[j]=time[j+1],time[j+1]=tmp,flag=true;
   if (flag!=true) break;
  }



 if (n%2==0)
 {
  for (int i=n-1;i>=2;i=i-2)
   {
    sum1+=time[0]+2*time[1]+time[i];
    sum2+=2*time[0]+time[i-1]+time[i];
   }
  sum1+=time[1],sum2+=time[1];
 }



 if (n%2==1)
  {
   for (int i=n-1;i>2;i=i-2)
   {
    sum1+=time[0]+2*time[1]+time[i];
    sum2+=2*time[0]+time[i-1]+time[i];
   }
  sum1+=time[1]+time[0]+time[2],sum2+=time[1]+time[0]+time[2];
  }



cout<<((sum1<sum2)? sum1:sum2);
}






int jisuan1(int a,int b,int c)
 {
  int t=0;
  t=2*b+a+c;
  return (t);
 }






int jisuan2(int a,int b,int c)
 {
  int t=0;
  t=2*a+c+b;
  return (t);
 }


