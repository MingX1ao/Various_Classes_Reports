#include <iostream>

using namespace std;

int main()
{double a, b, c, d, e,f,g;//定义了五个整型(a~e),f为和，g为平均
    cout<<"输入五个数的值"<<endl;
    cin>>a>>b>>c>>d>>e;
    f=a+b+c+d+e;
    g=f/5;
    cout<<"和为"<<f<<endl;
    cout<<"平均数为"<<g<<endl;
    return 0;
}
