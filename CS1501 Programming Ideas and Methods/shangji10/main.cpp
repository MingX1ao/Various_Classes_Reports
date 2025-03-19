#include <iostream>
#include <cmath>

using namespace std;

class four
{
 private:
    int sh[50];
    int wei;

 public:
    four (int p)
      {
       for (int j=0;j<50;j++) sh[j]=0;
       int i=0;
       while (p/int(pow(10,i))!=0)
          i++;
       wei=i;
       for (int j=0;j<wei;j++)
        {

        sh[j]=(p/int(pow(10,j)))%10;
        //cout<<sh[j];
        }//cout<<wei<<endl;
      }
    four operator+ (four &b)
      {
       int min=0;
       int max=0;
       min=(wei>b.wei? b.wei:wei);
       max=(wei>b.wei? wei:b.wei);
        for (int i=0;i<min;i++)
         {
          if ((b.sh[i]+sh[i])>=4)
           {
            sh[i]=(b.sh[i]+sh[i])%4;
            sh[i+1]=sh[i+1]+1;
           }
          else sh[i]=b.sh[i]+sh[i];
         }
       for (int i=0;i<max;i++) //cout<<sh[i]<<b.sh[i];
        if (sh[max]==0) wei=max;
        else wei=max+1;cout<<wei<<"  wa"<<endl;
       return *this;
      }


    void dip()
     {
      for (int i=wei-1;i>=0;i--)
        cout<<sh[i];
     }

};


int main()
{
 int n;
 int shu;
 four tmp(0);
 cin>>n;
 four sp(1);
  tmp=tmp+sp;
 while (n--)
  {
   cin>>shu;
   four number(shu);
   tmp=tmp+number;
  tmp.dip();}


}
