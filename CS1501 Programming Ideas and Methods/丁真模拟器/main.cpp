#include <iostream>
#include <cmath>
using namespace std;

int main()

{


int a=2 ,n=0,k=3,x=0;//aΪһ������nΪ��ʼ������kΪ3���̵ٻ�һ����ͳ�̣�xΪ�ܹ���������
cout<<"����n"<<endl;
cin>>n;
x=n;
a=n;
if (x<3)
 cout<<"�ų���"<<x<<"ֻ�̣��̶������ˣ�ԶԶ������"<<endl;
else
  while (a>=1){a=a/k ; x=x+a;}
  if (x>100)
  cout<<"����"<<x<<"֧��,��Դ����������"<<endl;
  else
  cout<<"�ų���"<<x<<"ֻ�̣�������"<<endl;

   return 0;

}
