#include "count_exchange.h"

//ʮ����������ƻ���ת��

void ex_2_to_10()
{

 cout<<"������һ������������";
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
 cout<<"�ö�������ת��Ϊʮ������Ϊ��"<<sum;
}

void ex_10_to_2()
{
  int num;
  cout<<"������һ��ʮ��������";
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
  cout<<"��ʮ������ת��Ϊ��������Ϊ��";
  for(int i=0;i<=n;i++)
  cout<<a[i];
}
