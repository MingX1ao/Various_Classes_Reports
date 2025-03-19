#include <iostream>
#include <string>
#include <cstring>
#include <algorithm>
using namespace std;




int days1[12]={31,28,31,30,31,30,31,31,30,31,30,31};
int days2[12]={31,29,31,30,31,30,31,31,30,31,30,31};
class Date
{
 friend ostream& operator <<(ostream&, const Date&);
 friend istream& operator >>(istream&,  Date&);

public:
    Date(int year=1900 , int month=1 , int day=1 )
    {
        _year=year;
        _month=month;
        _day=day;
    }

    Date add_year(int y)//返回年份加y之后的日期
    {
        _year+=y;

if (_year%4==0&&_year%100!=0||_year%400==0)
  {
   if (_month==2) {if(_day>29) _day=29;  }
  }

else{if (_month==2) {if(_day>28) _day=28;  }}}

    Date sub_year(int y)//返回年份减y之后的日期
    {
        _year-=y;

if (_year%4==0&&_year%100!=0||_year%400==0)
  {
   if (_month==2) {if(_day>29) _day=29;  }
  }

else{if (_month==2) {if(_day>28) _day=28;  }}}

    Date add_month(int m)//返回月份加m的日期
    {
      if (_month==12&&m%12==0)_year+=(m)/12;
      else
       {
        _year+=(_month+m)/12;
        _month=(_month+m-1)%12+1;
       }
if (_year%4==0&&_year%100!=0||_year%400==0)
  {
   if (_month==2) {if(_day>29) _day=29;  }
  }

else{if (_month==2) {if(_day>28) _day=28;  }}}

    Date sub_month(int m)//返回月份减m的日期
    {
      if (m<_month) _month-=m;
      else
      {
       _year=_year-(m-_month)/12-1;
       _month=11-((m-_month-1)%12);
      }

if (_year%4==0&&_year%100!=0||_year%400==0)
  {
   if (_month==2) {if(_day>29) _day=29;  }
  }

else{if (_month==2) {if(_day>28) _day=28;  }}}


    Date add_day(int d)//返回加d天的日期
    {
        int totleday=_day+d;
        while(totleday>days2[(_month-1)%12])
         {
          if (_year%100!=0&&_year%4==0||_year%400==0)
           {
            _month++;
            totleday-=days2[(_month-1)%12];
           }
          else
           {
            _month++;
            totleday-=days1[(_month-1)%12];
           }
          if (_month>12) _month=1 ,_year++;

         }
        _day=totleday;
    }

    void sub_day()//返回减d天的日期
     {
      if (_day-1!=0)
        _day-=1;
      if (_day-1==0)
       {
        if (_month-1!=0)
         {
           _month-=1;
           _day=days1[_month-1];
         }
        else
         {
          _year-=1;
          _month=12;
          _day=31;
         }
       }
     }

  int operator-(Date &b)
   {
    int i=0;
    while (!(_year==b._year&&_month==b._month&&_day==b._day))
       {
        b.add_day(1);
        i++;
       }
    return  i;
   }

    void Display()
    {
        cout << _year << "-" << _month << "-" << _day << endl;
    }
private:
    int _year;
    int _month;
    int _day;
};


ostream& operator <<(ostream&, const Date& b)
      {
       if (!(b._year%4==0&&b._year%100!=0||b._year%400==0)&&b._month==2&&b._day==29)
        cout<<"invalid date!"<<endl<<"1900-1-1"<<endl;

       if ((b._year%4==0&&b._year%100!=0||b._year%400==0)&&b._month==2&&b._day>29)
        cout<<"invalid date!"<<endl<<"1900-1-1"<<endl;

       if (b._month>12)
       cout<<"invalid date!"<<endl<<"1900-1-1"<<endl;

       if (b._day>days1[b._month-1]&&b._month!=2&&b._month<=12)
        cout<<"invalid date!"<<endl<<"1900-1-1"<<endl;

       if (b._year%1000==0&&b._month<=12&&b._day<=days2[b._month-1])
       cout << b._year << "-" << b._month << "-" << b._day << endl;

      }


istream& operator >>(istream&input, Date&b)
    {
     char d1[50];
     input>>d1;
     int i=0,j=0;
    b._year=(d1[0]-48)*1000+(d1[1]-48)*100+(d1[2]-48)*10+d1[3]-48;
    while (*(d1+i+5)!='-')
      i++;
     if (i==1) b._month=d1[5]-48;
     if (i==2) b._month=(d1[5]-48)*10+d1[6]-48;
    while (*(d1+i+6+j)!=0)
     j++;
     if (j==1) b._day=d1[6+i]-48;
     if (j==2) b._day=(d1[6+i]-48)*10+d1[7+i]-48;

    }



int main(){
   /*
    Date d3 = Date(2015, 12, 3);
    d3.add_day(10000);
    d3.Display();


    char d1[50], d2[50];
    for (int s=0;s<50;s++) d1[s]=d2[s]='/0';
    int year,month,day;
    cin>>d1>>d2;
    int i=0,j=0;
    year=(d1[0]-48)*1000+(d1[1]-48)*100+(d1[2]-48)*10+d1[3]-48;
    while (*(d1+i+5)!='-')
      i++;
     if (i==1) month=d1[5]-48;
     if (i==2) month=(d1[5]-48)*10+d1[6]-48;
    while (*(d1+i+6+j)!=0)
     j++;
     if (j==1) day=d1[6+i]-48;
     if (j==2) day=(d1[6+i]-48)*10+d1[7+i]-48;
    Date date1(year,month,day);
    //cout<<d1<<"nsa "<<d1[i+5+j]<<i<<"  "<<j<<endl;
    //cout<<year<<"  "<<month<<"  "<<day<<endl;
    i=0,j=0;
    year=(d2[0]-48)*1000+(d2[1]-48)*100+(d2[2]-48)*10+d2[3]-48;
    while (*(d2+i+5)!='-')
      i++;
     if (i==1) month=d2[5]-48;
     if (i==2) month=(d2[5]-48)*10+d2[6]-48;
    while (*(d2+i+6+j)!=0)
     j++;
     if (j==1) day=d2[6+i]-48;
     if (j==2) day=(d2[6+i]-48)*10+d2[7+i]-48;
    Date date2(year,month,day);
   // cout<<year<<"  "<<month<<"  "<<day<<endl;


    //date1.Display();date2.Display();
    cout<<date1-date2<<endl;
    date1.sub_day();
    date1.Display();
    Date date3(year,month,day);
    cout<<date1-date3<<endl;
   */


    Date d;
    cin >> d; cout<<d;
    cin >> d; cout<<d;
    cin >> d; cout<<d;
    cin >> d; cout<<d;
    cin >> d; cout<<d;

}




