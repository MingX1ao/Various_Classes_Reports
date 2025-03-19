#include <iostream>
#include <cstring>

using namespace std;

/*
class BirthDate
{
    private:
       int year;
       int month;
       int day;
    public:
       BirthDate(int a,int b,int c)
       :year(a),month(b),day(c){}

       void display()
       {
        cout<<"birthday:"<<year<<"/"
            <<month<<"/"<<day;
       }

       void change_birthday(int a,int b,int c)
       {
        year=a,month=b,day=c;
       }
};

class People
{
    private:
       int id;
       char *name;
       char sex;
    public:
       People(int Id,char *Name,char Sex)
       :id(Id),sex(Sex)
       {
        name=new char[strlen(Name)];
        strcpy(name,Name);
       }

       void display()
       {
        cout<<"num:"<<id<<endl;
        cout<<"name:";
        for (int i=0;i<strlen(name);i++)
          cout<<*(name+i);
        cout<<endl;
        cout<<"sex:"<<sex<<endl;
       }

};

class Teacher:public People
{
    public:
       BirthDate btd;

    public:
       Teacher(int a,char* b,char c,
               int d,int e,int f)
       :People(a,b,c),btd(d,e,f){}

       void display()
       {
         People::display();
         btd.display();
       }
};


int main()
{
    int year,month,day;
    int num;
    char name[50],sex;
    for (int i=0;i<50;i++) name[i]='/0';
    cin>>num;
    cin>>name;
    cin>>sex>>year>>month>>day;
    //cout<<name<<sex<<endl;
    Teacher aTeacher(num,name,sex,
                     year,month,day);
    cin>>year>>month>>day;
    aTeacher.btd.change_birthday(year,month,day);
    aTeacher.display();
}
*/


class Geometry
{
  private:
     double len;
     double aera;
  public:
     virtual int calc_len()
       {
         return 1;
       }
     virtual int calc_area()
       {
         return 1;
       }
     virtual void display()
       {
           cout<<" ";
       }
};


class Circle:public Geometry
{
 private:
    double r;
 public:
    Circle(double a):r(a){}
    int calc_len()
     {
       return r*2*3.14;
     }

    int calc_area()
     {
       return r*r*3.14;
     }

    void display()
     {
       cout<<"Circle"<<" "<<calc_len()
           <<" "<<calc_area()<<endl;
     }

};

class Rectangle:public Geometry
{
 private:
    double length,width;
 public:
    Rectangle(double a,double b)
    :length(a),width(b){}
    int calc_len()
      {
        return (length+width)*2;
      }
    int calc_area()
      {
         return length*width;
      }
    void display()
      {
        cout<<"Rectangle"<<" "<<calc_len()
           <<" "<<calc_area()<<endl;
      }
};


class Square:public Rectangle
{
  public:
     Square(double w):Rectangle(w,w){}
      void display()
      {
        cout<<"Square"<<" "<<Rectangle::calc_len()
           <<" "<<Rectangle::calc_area()<<endl;
      }
};


int main()
{
  int n;
  cin>>n;
  Geometry *p;
  while (n)
   {
    char shape;
    cin>>shape;
    if (shape=='C')
    {
      double r;
      cin>>r;
      Circle C(r);
      p=&C;
      p->display();
    }

    if (shape=='R')
     {
        int a,b;
        cin>>a>>b;
        Rectangle R(a,b);
        p=&R;
        p->display();
     }
    if (shape=='S')
     {
        int a;
        cin>>a;
        Square S(a);
        p=&S;
        p->display();
     }
    n--;
   }
}





