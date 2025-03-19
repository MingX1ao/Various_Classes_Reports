#include <iostream>

using namespace std;

class tire
{
 friend class car;
 private:
   double pressure;//气压
   double d;
 public:
   double addpressure(double setPressure);//加气
};

class engine
{
 friend class car;
 private:
   double n;//转速
   double size;//油门
 public:
   void burnOil(double*);//oil-k*size，模拟烧油
};

class car
{
 friend class engine;
 private:
   tire t1,t2,t3,t4;//四个轮胎
   engine obj;//引擎
   double speed;//当前速度
   double angle;//前轮与x轴正方向所成角
   double oil;//油量
 public:

   car(double d,double p,double n,double size,//d直径，p气压，n转速，size油门
       double spd,double drc,double amount)  //spd速度，drc方向,amount油量
    {
     t1.d=d,t1.pressure=p,t2.d=d,t2.pressure=p,
     t3.d=d,t3.pressure=p,t4.d=d,t4.pressure=p,
     speed=spd,angle=drc,oil=amount,
     obj.n=n,obj.size=size;

     cout<<"车轮直径"<<d<<"  "<<"气压"<<p<<endl;
     cout<<"引擎转速"<<n<<"  "<<"油门"<<size<<endl;
     cout<<"当前速度"<<spd<<"  "<<"前进方向"<<drc
         <<"  "<<"油量"<<amount<<endl;
    }

   double accelerate(double setSpeed);//输入，加速或减速;事先显示当前速度
   double addoil(double add);//输入，加油（可是加油不应该是加油站馆的吗）
   double turn(double setAngle);//输入，改角度;事先显示当前方向
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

