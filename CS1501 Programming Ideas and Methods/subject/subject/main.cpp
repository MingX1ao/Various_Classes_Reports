#include "count_exchange.h"

int main()
{
    opening_scene();//��ʾ��ʼ����
    int judge;
    while(true)
    {
        cout<<"������1��2��0"<<endl;
        cin>>judge;
//�жϲ���
        if(judge==1)//����
        {
            deal();
            break;
        }
        if(judge==2)//��ʾ���ܺ����
        {
            introduction();
            continue;
        }
        if(judge==0)
        {
            cout<<"��л����ʹ��"<<endl;
            cout<<"�������ⰴ�������˳�����"<<endl;
            exit(1);
        }
    }

    return 0;
}
