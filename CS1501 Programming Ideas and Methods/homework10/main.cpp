#include <iostream>

using namespace std;

class tire
{
 friend class car;
 private:
   double pressure;//��ѹ
   double d;
 public:
   double addpressure(double setPressure);//����
};

class engine
{
 friend class car;
 private:
   double n;//ת��
   double size;//����
 public:
   void burnOil(double*);//oil-k*size��ģ������
};

class car
{
 friend class engine;
 private:
   tire t1,t2,t3,t4;//�ĸ���̥
   engine obj;//����
   double speed;//��ǰ�ٶ�
   double angle;//ǰ����x�����������ɽ�
   double oil;//����
 public:

   car(double d,double p,double n,double size,//dֱ����p��ѹ��nת�٣�size����
       double spd,double drc,double amount)  //spd�ٶȣ�drc����,amount����
    {
     t1.d=d,t1.pressure=p,t2.d=d,t2.pressure=p,
     t3.d=d,t3.pressure=p,t4.d=d,t4.pressure=p,
     speed=spd,angle=drc,oil=amount,
     obj.n=n,obj.size=size;

     cout<<"����ֱ��"<<d<<"  "<<"��ѹ"<<p<<endl;
     cout<<"����ת��"<<n<<"  "<<"����"<<size<<endl;
     cout<<"��ǰ�ٶ�"<<spd<<"  "<<"ǰ������"<<drc
         <<"  "<<"����"<<amount<<endl;
    }

   double accelerate(double setSpeed);//���룬���ٻ����;������ʾ��ǰ�ٶ�
   double addoil(double add);//���룬���ͣ����Ǽ��Ͳ�Ӧ���Ǽ���վ�ݵ���
   double turn(double setAngle);//���룬�ĽǶ�;������ʾ��ǰ����
};

void engine::burnOil(&car.oil)
{
  car.oil-=size;
}

int main()
{
 double d,p,n,size,spd,drc,amount;
 cin>>d>>p>>n>>size>>spd>>drc>>amount;
 car car1(d,p,n,size,spd,drc,amount);

}

