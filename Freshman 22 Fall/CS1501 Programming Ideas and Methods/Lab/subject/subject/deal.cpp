#include "count_exchange.h"

void deal()//������
{
    int pre,aft;
    while(true)
    {
        cout<<"������ת��ǰ���ƣ�2/8/10/16����"<<endl;
        cin>>pre;
        if(pre==2||pre==8||pre==10||pre==16)
            break;
        else
        {
            cout<<"���ݲ��Ϸ�������������"<<endl;
            continue;
        }
    }
    while(true)
    {
        cout<<"������ת������ƣ�2/8/10/16����"<<endl;
        cin>>aft;
        if(aft==2||aft==8||aft==10||aft==16)
            break;
        else
        {
            cout<<"���ݲ��Ϸ�������������"<<endl;
            continue;
        }
    }
    if(pre==2&&aft==10)
    {
        ex_2_to_10();
    }
    else if(pre==8&&aft==10)
    {
        ex_8_to_10();
    }
    else if(pre==16&&aft==10)
    {
        char number[100]={0};
        int num=0;
        int choice;
        int digits=0;

        for (int i=0;i<100;i++)
            number[i]='@';

        cout<<"������һ��ʮ����������"<<endl;
        cin>>number;

        while (number[digits]!='@')
            digits++;

        digits--;

        for (int i=0;i<digits;i++)
            num+=pow(10,digits-i-1)*(int(number[i])-48);

        ex_16_to_10(number,digits);
    }
    else if(pre==10&&aft==2)
    {
        ex_10_to_2();
    }
    else if(pre==10&&aft==8)
    {
        ex_10_to_8();
    }
    else if(pre==10&&aft==16)
    {
        int num;
        cout<<"������һ��ʮ��������";
        cin>>num;
        ex_10_to_16(num);
    }
}
