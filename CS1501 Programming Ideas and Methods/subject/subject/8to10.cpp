#include "count_exchange.h"

void ex_10_to_8()
{
    cout<<"������һ��ʮ������";
    int num;
    cin>>num;
    int tmp = 1;
    int len = 0;
    while (tmp <= num)
    {
        tmp *= 8;
        len++;
    }
    //cout << len << endl;
    int* result = new int[len];
    int tra = num;
    int max = 1;
    for (int i = 0; i < len - 1; i++)
        max *= 8;
    //cout << max;
    for (int i = 0; i < len; i++)
    {
        result[i] = tra / max;
        tra %= max;
        max /= 8;
    }
    cout<<"��ʮ������ת��Ϊ�˽�����Ϊ��";
    for (int i = 0; i < len; i++)
        cout << result[i];
   cout << endl;
    return;
}
void ex_8_to_10()
{
    cout<<"������һ���˽�������";
    char num[10000];
    cin>>num;
    int len = strlen(num);
    int result = 0;
    int tmp = 1;
    for (int i = len - 1; i >= 0; i--)
    {
        result += (num[i] - '0') * tmp;
        tmp *= 8;
    }
    cout<<"�ð˽�����ת��Ϊʮ������Ϊ��";
    cout << result << endl;
}
