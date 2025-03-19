#include <iostream>
#include <cmath>
using namespace std;

int main()

{double a=1;
while (a>=1){
 a=a+1;
 if (a<2000)
 cout<<"丁真吸了"<<a<<"支传统烟，远远不够嘛"<<endl;
 if (2000<=a and a<10000)
 cout<<"丁真吸了"<<a<<"支传统烟，有点爽，叫上王源一起"<<endl;
 if (10000<=a and a<20000)
 cout<<"丁真吸了"<<a<<"支传统烟，感觉传统烟不够爽了，准备掏出电子烟"<<endl;
 if (20000<=a and a<30000)
 cout<<"丁真吸了"<<a-29999<<"支电子烟，吸爽了开始摁造"<<endl;
 if (30000<=a)
 cout<<"丁真吸了"<<a-29999<<"支电子烟，吸爽了开始摁造,并表示”1！5！电子烟我只抽锐刻五"<<endl;
}

   return 0;

}
