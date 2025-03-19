//此代码仅为伪代码，故有大量的文字代替
//部分无法实现的代码已经用“//”隐去
//由于不同人的口腔大小不同
//故以咽拭子受到压力为标准作为采样完成依据

#include <iostream>

using namespace std;

//double stdF=IDontKnow;//完成采样的标准压力
//double minLocation=IDontKnow;//滑块最小前进单位
//double maxLocation=IDontKnow;//坐标的最大值

bool LocateHead();
//定位头部，signal变为true

bool LocateCube(double F,double GetLocation);
//定位咽拭子，F表示力

bool CubeBack();
//退回滑块

int main()
{
 double F;//表示咽拭子受到压力的大小
 double GetLocation;//表示小滑块在轨道上的坐标

 while(//power on)//开机
    {
     if (LocateHead)//确认头到位了没
      {
       //get F and GetLocate from sensors;
       while (LocateCube(F,GetLocation)) break;//确认滑块到位了没
      }
     //切断咽拭子
     if (CubeBack())
      {
       //lights on;//指示灯亮起，提示完成
       //change stick;//换咽拭子
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
 double SetLocation;//用于设置滑块坐标
 while (F<stdF&&GetLocation<maxLocation)
  {
   SetLocation+=minLocation;
   //Slide cube to SetLocation;//将滑块滑到设置位置
   //get F and GetLocation from sensors;
  }
 return true;
}

bool CubeBack()
{
 double GetLocation;
 double InitializeLocation=0;//初始化滑块位置
 //get GetLocation from sensors;
 while(GetLocation)
 //set Cube's Location to InitializeLocation;
 return true;
}
