#include <iostream>
#include<cstring>
using namespace std;

int main()
{// int a=0, b=0 ,c=0 ,d=0;       代码一，求数字
//  cin>>a;
  // b=a/100,c=(a/10)%10,d=a%10;
//cout<<b<<endl;
//cout<<c<<endl;
//cout<<d<<endl;



//int  a=0,b=0,c=0,d=0,e=0;                           代码二，加密
 //char f=' ',g=' ', h=' ', i=' ';
  //cin>>a;
//  b=a/1000,c=(a/100)%10,d=(a/10)%10,e=a%10;
  //b=b+13,c=c+13,d=d+13,e=e+13;
  //f=b+64;
  //g=c+64;
  //h=d+64;
  //i=e+64;

//cout<<f<<g<<h<<i<<endl;

int a=0,i=0;                     //代码二的改进，更加简洁
char b='';//c='';
cin>>a;
while (i<=3){
//c=a;
b=a.substr(i,1);//整型可以直接当成字符串吗？
b=b+77;
cout<<b<<endl;




 }










    return 0;
}
