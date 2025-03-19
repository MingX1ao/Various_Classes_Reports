#include <iostream>
#include <ctime>
#include <cstdlib>
using namespace std;

int main()
{int j=0;
 while (j<=10000){
 int i=1,result=0,count=0,a=0,b=0,c=0;       //i用于计数，result用于输出结果，count是人数,
                                             //a,b是随机数范围,c用于防止@笨猪@输错大小
 char nex;
 cout<<"输入要抽几个人"<<endl;               //提示输入，不用管
 cin>>count;                                 //键盘输入count
 cout<<"输入抽取范围（两个值之间用空格隔开）"<<endl;
 cin>>a>>b;                                  //键盘输入a b
 cout<<"以下是中奖名单"<<endl;
 if (a>b)
  {
     c=a,a=b,b=c;                            //交换数据，保证a<b
  }
 srand(time(NULL));                          //重生随机种子，笨猪应该看不懂
 for (;i<=count;i++)                         //以下为程序主体
  {
   result=(rand()%(b-a+1))+a;                //生成一个随机数[a,b](范围)
   cout<<result<<endl;
  }
 cout<<"恭喜你们，运气很好"<<endl;
 cout<<"重新/再次 抽奖请输入“Y”,否则“N”(注意是大写)"<<endl;
 cout<<"按了“N”再按一次回车，程序结束，自动关闭"<<endl;
 cin>>nex;
 if (nex=='Y') j++;                            //判断是否继续抽奖
 else   break;
}
return 0;
}
