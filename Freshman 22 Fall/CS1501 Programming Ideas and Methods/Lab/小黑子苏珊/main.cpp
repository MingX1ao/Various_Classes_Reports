#include <iostream>
using namespace std;

int main()
{
 double delta,constantA,constantB;//deltaΪ���ȣ�CAΪ��Сֵ��CBΪ���ֵ
 double results[1000],CDF=0,a;//results[1000]��������a,b�����޶�CDF�Ա�����Χ
 int n,i,j,PDF[1000]={0};
 //����results��min=constantA��max=constantB;
 cin>>delta;
 n=(constantB-constantA)/delta+1;
 for (i=0;i<=n-1;i++)
  {
   for (j=0;j<=999;j++)
    if (results[j]<constantA+(i+1)*delta&&results[j]>=constantA+i*delta) PDF[i]++; //PDF�Ѿ�����
  }
 for (;true;)
  {
   cin>>i;              //��ѯPDF[i]
   if (i>=1000) break;
   else cout<<PDF[i];
  }
 for (;1;)
  {
   cin>>a>>j;
   if (j>1000) break;
   else                 //��CDF
   {
    for (i=0;i<=(a-constantA)/delta+1;i++)
     CDF+=PDF[i];
     CDF=CDF/n;
   }
  }
}
