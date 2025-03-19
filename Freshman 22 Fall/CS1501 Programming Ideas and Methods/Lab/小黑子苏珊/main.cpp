#include <iostream>
using namespace std;

int main()
{
 double delta,constantA,constantB;//delta为粒度，CA为最小值，CB为最大值
 double results[1000],CDF=0,a;//results[1000]储存结果，a,b用于限定CDF自变量范围
 int n,i,j,PDF[1000]={0};
 //输入results，min=constantA，max=constantB;
 cin>>delta;
 n=(constantB-constantA)/delta+1;
 for (i=0;i<=n-1;i++)
  {
   for (j=0;j<=999;j++)
    if (results[j]<constantA+(i+1)*delta&&results[j]>=constantA+i*delta) PDF[i]++; //PDF已经生成
  }
 for (;true;)
  {
   cin>>i;              //查询PDF[i]
   if (i>=1000) break;
   else cout<<PDF[i];
  }
 for (;1;)
  {
   cin>>a>>j;
   if (j>1000) break;
   else                 //求CDF
   {
    for (i=0;i<=(a-constantA)/delta+1;i++)
     CDF+=PDF[i];
     CDF=CDF/n;
   }
  }
}
