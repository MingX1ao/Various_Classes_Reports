#include <iostream>
#include <cmath>
using namespace std;

int main()

{


int a=2 ,n=0,k=3,x=0;//a为一个数，n为起始烟数，k为3个烟蒂换一个传统烟，x为总共吸得烟数
cout<<"输入n"<<endl;
cin>>n;
x=n;
a=n;
if (x<3)
 cout<<"才抽了"<<x<<"只烟，烟都换不了，远远不及格啊"<<endl;
else
  while (a>=1){a=a/k ; x=x+a;}
  if (x>100)
  cout<<"抽了"<<x<<"支烟,王源丁真给你点赞"<<endl;
  else
  cout<<"才抽了"<<x<<"只烟，不及格啊"<<endl;

   return 0;

}
