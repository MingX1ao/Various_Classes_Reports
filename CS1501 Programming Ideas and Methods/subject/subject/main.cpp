#include "count_exchange.h"

int main()
{
    opening_scene();//显示开始界面
    int judge;
    while(true)
    {
        cout<<"请输入1、2或0"<<endl;
        cin>>judge;
//判断操作
        if(judge==1)//计算
        {
            deal();
            break;
        }
        if(judge==2)//显示介绍后计算
        {
            introduction();
            continue;
        }
        if(judge==0)
        {
            cout<<"感谢您的使用"<<endl;
            cout<<"按下任意按键即可退出程序"<<endl;
            exit(1);
        }
    }

    return 0;
}
