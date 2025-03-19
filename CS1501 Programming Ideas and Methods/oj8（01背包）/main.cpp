#include <iostream>
#include <stdlib.h>
using namespace std;

/*
int main()
{
 int n,t;
 int *p,*a;
 cin>>n>>t;
 p=new int[n];
 for (int i=0;i<n;i++)
   cin>>*(p+i);
 int *q=(p+n-1);
 a=p;
 while (*q+*p!=t)
 {
  if (*q+*p>t)
   q--;
  if (*q+*p<t)
   p++;
 }
 cout<<p-a<<" "<<q-a;

}
*/

int main()
{
 int v,n,a=0,tmp=0,num=0,x=100;
 int tiji[30]={0},cha[30]={0};
 cin>>v>>n;
 for (int i=0;i<n;i++)
  cin>>tiji[i];

 for (int i=0;i<n;i++)
 {
  if (tiji[i]>v) tiji[i]=0,num++;
 }

 n-=num;

 while (v>0&&n>0)
 {
  x=100;
  for (int i=0;i<n;i++)
   {
    for (int j=0;j<n-i;j++)
     if (tiji[j]<tiji[j+1])
     {tmp=tiji[j],tiji[j]=tiji[j+1],tiji[j+1]=tmp;}
   }
  for (int i=0;i<n;i++)
    cha[i]=abs(v-tiji[i]);

  for (int i=0;i<n;i++)
  {
   if (cha[i]<x)
    x=cha[i],a=i;
  }
  v-=tiji[a];
  tiji[a]=0;
  for (int i=0;i<n;i++)
   {
    for (int j=0;j<n-i;j++)
     if (tiji[j]<tiji[j+1])
     {tmp=tiji[j],tiji[j]=tiji[j+1],tiji[j+1]=tmp;}
   }
  n--,tmp=tiji[a];
 }


 if (v>=0) cout<<v;
 else cout<<v+tmp;

}



