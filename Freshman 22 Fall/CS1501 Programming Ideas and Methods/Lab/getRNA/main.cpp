//�˴����Ϊα���룬���д��������ִ���
//�����޷�ʵ�ֵĴ����Ѿ��á�//����ȥ
//���ڲ�ͬ�˵Ŀ�ǻ��С��ͬ
//�����������ܵ�ѹ��Ϊ��׼��Ϊ�����������

#include <iostream>

using namespace std;

//double stdF=IDontKnow;//��ɲ����ı�׼ѹ��
//double minLocation=IDontKnow;//������Сǰ����λ
//double maxLocation=IDontKnow;//��������ֵ

bool LocateHead();
//��λͷ����signal��Ϊtrue

bool LocateCube(double F,double GetLocation);
//��λ�����ӣ�F��ʾ��

bool CubeBack();
//�˻ػ���

int main()
{
 double F;//��ʾ�������ܵ�ѹ���Ĵ�С
 double GetLocation;//��ʾС�����ڹ���ϵ�����

 while(//power on)//����
    {
     if (LocateHead)//ȷ��ͷ��λ��û
      {
       //get F and GetLocate from sensors;
       while (LocateCube(F,GetLocation)) break;//ȷ�ϻ��鵽λ��û
      }
     //�ж�������
     if (CubeBack())
      {
       //lights on;//ָʾ��������ʾ���
       //change stick;//��������
      }
    }
}

bool LocateHead()
{
 //get signal from sensors;
  if (signal)
    return true;
}

bool LocateCube(double F,double GetLocation)
{
 double SetLocation;//�������û�������
 while (F<stdF&&GetLocation<maxLocation)
  {
   SetLocation+=minLocation;
   //Slide cube to SetLocation;//�����黬������λ��
   //get F and GetLocation from sensors;
  }
 return true;
}

bool CubeBack()
{
 double GetLocation;
 double InitializeLocation=0;//��ʼ������λ��
 //get GetLocation from sensors;
 while(GetLocation)
 //set Cube's Location to InitializeLocation;
 return true;
}
