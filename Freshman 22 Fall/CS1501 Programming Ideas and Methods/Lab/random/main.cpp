#include <iostream>
#include <ctime>
#include <cstdlib>
using namespace std;

int main()
{int j=0;
 while (j<=10000){
 int i=1,result=0,count=0,a=0,b=0,c=0;       //i���ڼ�����result������������count������,
                                             //a,b���������Χ,c���ڷ�ֹ@����@����С
 char nex;
 cout<<"����Ҫ�鼸����"<<endl;               //��ʾ���룬���ù�
 cin>>count;                                 //��������count
 cout<<"�����ȡ��Χ������ֵ֮���ÿո������"<<endl;
 cin>>a>>b;                                  //��������a b
 cout<<"�������н�����"<<endl;
 if (a>b)
  {
     c=a,a=b,b=c;                            //�������ݣ���֤a<b
  }
 srand(time(NULL));                          //����������ӣ�����Ӧ�ÿ�����
 for (;i<=count;i++)                         //����Ϊ��������
  {
   result=(rand()%(b-a+1))+a;                //����һ�������[a,b](��Χ)
   cout<<result<<endl;
  }
 cout<<"��ϲ���ǣ������ܺ�"<<endl;
 cout<<"����/�ٴ� �齱�����롰Y��,����N��(ע���Ǵ�д)"<<endl;
 cout<<"���ˡ�N���ٰ�һ�λس�������������Զ��ر�"<<endl;
 cin>>nex;
 if (nex=='Y') j++;                            //�ж��Ƿ�����齱
 else   break;
}
return 0;
}
