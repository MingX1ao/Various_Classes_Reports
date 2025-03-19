
#include <iostream>

using namespace std;

/*
class CSet
{
 private:
    int n;
    int *data;
 public:

   CSet(){};
   CSet(int num,int *shu)
    {
      n=num;
      data=new int[n];
      for (int i=0;i<n;i++)
        *(data+i)=shu[i];
    }

   void display()
    {
     for (int i=0;i<n;i++)
       cout<<*(data+i)<<" ";
     cout<<endl;
    }




    CSet operator+(const CSet &B)
      {
       bool flag;
       int num=0;
       CSet C;
       C.data=new int[n+B.n];
       for (int i=0;i<n;i++)
          *(C.data+i)=*(data+i);
       for (int j=0;j<B.n;j++)
         {
          flag=1;
          for (int i=0;i<n;i++)
             {
              if (*(C.data+i)==*(B.data+j))
                 flag=0;
             }
          if(flag)
            *(C.data+n+num)=*(B.data+j),num++;
         }
        C.n=n+num;
      return C;
      }

  CSet operator-(const CSet &B)
   {
       bool flag;
       int num=0;
       CSet C;
       C.data=new int[n+B.n];
       for (int j=0;j<n;j++)
         {
          flag=1;
          for (int i=0;i<B.n;i++)
             {
              if (*(data+j)==*(B.data+i))
                 flag=0;
             }
          if (flag)
          *(C.data+num)=*(data+j),num++;
         }
        C.n=num;
      return C;
    }


   CSet operator*(const CSet B)
    {
       int num=0;
       CSet C;
       C.data=new int[n+B.n];
       for (#include <iostream>
#include <string>
#include <sstream>
using namespace std;
class MyShape {
protected:
  int R_ , G_ , B_;
  string colorToString() {
    stringstream ss;
    ss << R_ << " " << G_ << " " << B_;
    return ss.str();
  }
public:
  void setColor(int R , int G , int B) {
    R_ = R; G_ = G , B_ = B;
  }
  int getR() {
    return R_;
  }
  int getG() {
    return G_;
  }
  int getB() {
    return B_;
  }
  virtual void Draw() = 0;
  MyShape() {
    R_ = 255; G_ = 255 , B_ = 255;
  }
};
class MyCircle : public MyShape {
private:
  int x_ = 200 , y_ = 200 , radius_ = 200;
public:
  MyCircle(int x , int y , int radius) {
    x_ = x;
    y_ = y;
    radius_ = radius;
  }
  MyCircle() = default;
  MyCircle(MyCircle& aCircle) {
    x_ = aCircle.x_;
    y_ = aCircle.y_;
    radius_ = aCircle.radius_;
    R_ = aCircle.getR();
    G_ = aCircle.getG();
    B_ = aCircle.getB();
  }
  void setCenter(int x , int y) {
    x_ = x;
    y_ = y;
  }
  void setRadius(int radius) {
    radius_ = radius;
  }
  void Draw() {
  }
  //----在此处添加数组下标运算符的重载函数原型声明
};
//----在此处添加关系数组下标运算符的重载定义
int main() {
  int x , y , r = 0;
  cin >> x >> y >> r;
  MyCircle c1(x , y , r);
  MyCircle c2;
  c2[ 2 ] = x;
  for (int i = 0; i <= 3; i++) {
    cout << c1[ i ] << endl;
    cout << c2[ i - 1 ] << endl;
  }
  return 0;
}int j=0;j<n;j++)
         {
          for (int i=0;i<B.n;i++)
             {
              if (*(data+j)==*(B.data+i))
                *(C.data+num)=*(data+j),num++;
             }
         }
      C.n=num;
      return C;
    }

};





int main()
{
 int zu;

 cin>>zu;
 while(zu--)
 {

  CSet C;
  int An;
  cin>>An;
  int *pa=new int[An];
  for (int i=0;i<An;i++)
   cin>>*(pa+i);
  CSet A(An,pa);

  int Bn;
  cin>>Bn;
  int *pb=new int[Bn];
  for (int i=0;i<Bn;i++)
   cin>>*(pb+i);
  CSet B(Bn,pb);

  cout<<"A:";
  A.display();
  cout<<"B:";
  B.display();

  cout<<"A+B:";
  C=A+B;
  C.display();

  cout<<"A*B:";
  C=A*B;
  C.display();

  cout<<"(A-B)+(B-A):";
  C=(A-B)+(B-A);
  C.display();

  cout<<endl;
 }

}
*/


/*
#include <iostream>
#include <string>
#include <sstream>
using namespace std;
class MyShape {
protected:
  int R_ , G_ , B_;
  string colorToString() {
    stringstream ss;
    ss << R_ << " " << G_ << " " << B_;
    return ss.str();
  }
public:
  void setColor(int R , int G , int B) {
    R_ = R; G_ = G , B_ = B;
  }
  int getR() {
    return R_;
  }
  int getG() {
    return G_;
  }
  int getB() {
    return B_;
  }
  virtual void Draw() = 0;
  MyShape() {
    R_ = 255; G_ = 255 , B_ = 255;
  }
};
class MyCircle : public MyShape {
private:
  int x_ , y_ , radius_ ;
public:
  MyCircle(int x , int y , int radius ) {
    x_ = x;
    y_ = y;
    radius_ = radius;
  }
  MyCircle() = default;
  MyCircle(MyCircle& aCircle) {
    x_ = aCircle.x_;
    y_ = aCircle.y_;
    radius_ = aCircle.radius_;
    R_ = aCircle.getR();
    G_ = aCircle.getG();
    B_ = aCircle.getB();
  }
  void setCenter(int x , int y) {
    x_ = x;
    y_ = y;
  }
  void setRadius(int radius) {
    radius_ = radius;
  }
  void Draw() {
  }
  //----在此处添加关系运算符  >、<、>=、<=、==、!=  的重载原型声明

  bool operator>(const MyCircle &B)
   {
    if (radius_>B.radius_)
       return 1;
    else return 0;
   }

  bool operator<(const MyCircle &B)
   {
    if (radius_<B.radius_)
       return 1;
    else return 0;
   }

  bool operator>=(const MyCircle &B)
   {
    if (radius_>=B.radius_)
       return 1;
    else return 0;
   }

  bool operator<=(const MyCircle &B)
   {
    if (radius_<=B.radius_)
       return 1;
    else return 0;
   }

  bool operator==(const MyCircle &B)
   {
    if (radius_==B.radius_)
       return 1;
    else return 0;
   }

  bool operator!=(const MyCircle &B);
};
//----在此处添加关系运算符的重载定义

  bool MyCircle::operator!=(const MyCircle &B)
    {
     if (radius_!=B.radius_)
       return 1;
    else return 0;
    }
//其他都一样，当时忘了要写外面，就写一个了
int main() {
  int r1 , r2 , r3 = 0;
  cin >> r1 >> r2 >> r3;
  MyCircle c1 , c2 , c3;
  c1.setRadius(r1);
  c2.setRadius(r2);
  c3.setRadius(r3);
  cout << (c1 > c2) << endl;
  cout << (c1 < c2) << endl;
  cout << (c2 >= c3) << endl;
  cout << (c2 <= c3) << endl;
  cout << (c1 == c3) << endl;
  cout << (c1 != c3) << endl;
  return 0;
}
*/

template <class T>
class cmp
{
  private:
    T a,b;

  public:
    cmp(T x,T y):
    a(x),b(y){}

    void display();


};


template <class T>
void cmp<T>::display()
   {
     if (a>b)
       cout<<a<<" "<<b<<endl;
     else cout<<b<<" "<<a<<endl;
   }


int main()
{
 int a,b;
 double x,y;
 char m,n;
 cin>>a>>b>>x>>y>>m>>n;
 cmp<int> A(a,b);
   A.display();
 cmp<double> B(x,y);
   B.display();
 cmp<char> C(m,n);
   C.display();

}



