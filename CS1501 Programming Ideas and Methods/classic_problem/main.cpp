#include <iostream>
#include <cmath>
#include <fstream>

using namespace std;
double Vt=100,V=150,
       L=1000,totle_time=1000000,
       delta_t=0.1;
struct point
{
  double x;
  double y;
};


int main()
{
  point UFO,rocket;
  double t=0;
  double tmp;
  UFO.x=L;
  rocket.x=0,rocket.y=0;
  for (double i=0;i<totle_time;i++)
    {
     tmp=rocket.y;
     t+=delta_t;
     UFO.y=Vt*t;
     rocket.y+=((UFO.y-tmp)/pow(pow(UFO.y-tmp,2)+pow(UFO.x-rocket.x,2),0.5))*V*delta_t;
     rocket.x+=((UFO.x-rocket.x)/pow(pow(UFO.y-tmp,2)+pow(UFO.x-rocket.x,2),0.5))*V*delta_t;

     //cout<<t<<"  "<<"UFO="<<UFO.x<<"  "<<UFO.y<<"  "<<"rocket="<<rocket.x<<"  "<<rocket.y<<endl;
     cout<<rocket.y<<endl;
    }
    return 0;
}
