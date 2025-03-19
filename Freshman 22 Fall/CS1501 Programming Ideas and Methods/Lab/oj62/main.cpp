//#include <iostream>
//#include <cstring>
//using namespace std;

//int kaolazi(int n,int num);

//int main()
//{
// int n,a=0,num=0,b=0;
// int zhi[1000000]={0};
// cin>>n;


// for (int i=1;i<=n;i++)
//  {
//   zhi[i-1]=kaolazi(i,num);
//  }

// a=0,b=0;
// for (int i=0;i<=n;i++)
//  {
//   if (zhi[i]>a) a=zhi[i],b=i+1;
//  }
// cout<<b;
//}


//int kaolazi(int n,int num)
// {
//  while (n>1)
//   {
//    ++num;
//    if (n%2==0) return(kaolazi(n/2,num));
//    else return(kaolazi(3*n+1,num));
//   }
//  return (num);
// }




#include <iostream>
#include <cstring>
using namespace std;
int Julian_Convert(int year, int day, char *s)
{
 int tian=0;
 if ((year%4==0&&year%100!=0)||year%400==0)
  {
   if (day>366) s[0]='N',s[1]='U',s[2]='L',s[3]='L',s[4]='\0';
   else
    {
     if (day>=1&&day<=31)
      {
       s[0]='J' ,s[1]='u',s[2]='a',s[3]='n',s[4]='a',s[5]='r',s[6]='y',s[7]=' ';
       if (day<=9) s[8]=day+48;
       else s[8]=day/10+48,s[9]=(day%10)+48;
      }
     if (day>=32&&day<=60)
      {
       s[0]='F',s[1]='e',s[2]='b',s[3]='r',s[4]='u',s[5]='a',s[6]='r',s[7]='y',s[8]=' ';
       if ((day-31)<=9) s[9]=(day-31)+48;
       else s[9]=(day-31)/10+48,s[10]=((day-31)%10)+48;
      }
     if (day>=61&&day<=91)
      {
       s[0]='M',s[1]='a',s[2]='r',s[3]='c',s[4]='h',s[5]=' ';
       if (day-60<=9) s[6]=day-60+48;
       else s[6]=(day-60)/10+48,s[7]=((day-60)%10)+48;
      }
     if (day>=92&&day<=121)
      {
       s[0]='A',s[1]='p',s[2]='r',s[3]='i',s[4]='l',s[5]=' ';
       if (day-91<=9) s[6]=day-91+48;
       else s[6]=(day-91)/10+48,s[7]=((day-91)%10)+48;
      }
     if (day>=122&&day<=152)
      {
       s[0]='M',s[1]='a',s[2]='y',s[3]=' ';
       if (day-121<=9) s[4]=day-121+48;
       else s[4]=(day-121)/10+48,s[5]=((day-121)%10)+48;
      }
     if (day>=153&&day<=182)
      {
       s[0]='J',s[1]='u',s[2]='n',s[3]='e',s[4]=' ';
       if (day-152<=9) s[5]=day-152+48;
       else s[5]=(day-152)/10+48,s[6]=((day-152)%10)+48;
      }
     if (day>=183&&day<=213)
      {
       s[0]='J',s[1]='u',s[2]='l',s[3]='y',s[4]=' ';
       if (day-182<=9) s[5]=day-182+48;
       else s[5]=(day-182)/10+48,s[6]=((day-182)%10)+48;
      }
     if (day>=214&&day<=244)
      {
       s[0]='A',s[1]='u',s[2]='g',s[3]='u',s[4]='s',s[5]='t',s[6]=' ';
       if (day-213<=9) s[7]=day-213+48;
       else s[7]=(day-213)/10+48,s[8]=((day-213)%10)+48;
      }
     if (day>=245&&day<=274)
      {
       s[0]='S',s[1]='e',s[2]='p',s[3]='t',s[4]='e',s[5]='m',s[6]='b',s[7]='e',s[8]='r',s[9]=' ';
       if (day-244<=9) s[10]=day-244+48;
       else s[10]=(day-244)/10+48,s[11]=((day-244)%10)+48;
      }
     if (day>=275&&day<=305)
      {
       s[0]='O',s[1]='c',s[2]='t',s[3]='o',s[4]='b',s[5]='e',s[6]='r',s[7]=' ';
       if (day-274<=9) s[8]=day-274+48;
       else s[8]=(day-274)/10+48,s[9]=((day-274)%10)+48;
      }
     if (day>=306&&day<=335)
      {
       s[0]='N',s[1]='o',s[2]='v',s[3]='e',s[4]='m',s[5]='b',s[6]='e',s[7]='r',s[8]=' ';
       if (day-305<=9) s[9]=day-305+48;
       else s[9]=(day-305)/10+48,s[10]=((day-305)%10)+48;
      }
     if (day>=336&&day<=366)
      {
       s[0]='D',s[1]='e',s[2]='c',s[3]='e',s[4]='m',s[5]='b',s[6]='e',s[7]='r',s[8]=' ';
       if (day-335<=9) s[9]=day-335+48;
       else s[9]=(day-335)/10+48,s[10]=((day-335)%10)+48;
      }
    }
  }
 else
  {
   if (day>365) s[0]='N',s[1]='U',s[2]='L',s[3]='L',s[4]='\0';
   else
    {
     if (day>=1&&day<=31)
      {
       s[0]='J' ,s[1]='u',s[2]='a',s[3]='n',s[4]='a',s[5]='r',s[6]='y',s[7]=' ';
       if (day<=9) s[8]=day+48;
       else s[8]=day/10+48,s[9]=(day%10)+48;
      }
     if (day>=32&&day<=59)
      {
       s[0]='F',s[1]='e',s[2]='b',s[3]='r',s[4]='u',s[5]='a',s[6]='r',s[7]='y',s[8]=' ';
       if ((day-31)<=9) s[9]=(day-31)+48;
       else s[9]=(day-31)/10+48,s[10]=((day-31)%10)+48;
      }
     if (day>=60&&day<=90)
      {
       s[0]='M',s[1]='a',s[2]='r',s[3]='c',s[4]='h',s[5]=' ';
       if (day-59<=9) s[6]=day-60+1+48;
       else s[6]=(day-60+1)/10+48,s[7]=((day-60+1)%10)+48;
      }
     if (day>=92-1&&day<=121-1)
      {
       s[0]='A',s[1]='p',s[2]='r',s[3]='i',s[4]='l',s[5]=' ';
       if (day-91+1<=9) s[6]=day-91+1+48;
       else s[6]=(day-91+1)/10+48,s[7]=((day-91+1)%10)+48;
      }
     if (day>=122-1&&day<=152-1)
      {
       s[0]='M',s[1]='a',s[2]='y',s[3]=' ';
       if (day-121+1<=9) s[4]=day-121+1+48;
       else s[4]=(day-121+1)/10+48,s[5]=((day-121+1)%10)+48;
      }
     if (day>=153-1&&day<=182-1)
      {
       s[0]='J',s[1]='u',s[2]='n',s[3]='e',s[4]=' ';
       if (day-152+1<=9) s[5]=day-152+1+48;
       else s[5]=(day-152+1)/10+48,s[6]=((day-152+1)%10)+48;
      }
     if (day>=183-1&&day<=213-1)
      {
       s[0]='J',s[1]='u',s[2]='l',s[3]='y',s[4]=' ';
       if (day-182+1<=9) s[5]=day-182+1+48;
       else s[5]=(day-182+1)/10+48,s[6]=((day-182+1)%10)+48;
      }
     if (day>=214-1&&day<=244-1)
      {
       s[0]='A',s[1]='u',s[2]='g',s[3]='u',s[4]='s',s[5]='t',s[6]=' ';
       if (day-213+1<=9) s[7]=day-213+1+48;
       else s[7]=(day-213+1)/10+48,s[8]=((day-213+1)%10)+48;
      }
     if (day>=245-1&&day<=274-1)
      {
       s[0]='S',s[1]='e',s[2]='p',s[3]='t',s[4]='e',s[5]='m',s[6]='b',s[7]='e',s[8]='r',s[9]=' ';
       if (day-244+1<=9) s[10]=day-244+1+48;
       else s[10]=(day-244+1)/10+48,s[11]=((day-244+1)%10)+48;
      }
     if (day>=275-1&&day<=305-1)
      {
       s[0]='O',s[1]='c',s[2]='t',s[3]='o',s[4]='b',s[5]='e',s[6]='r',s[7]=' ';
       if (day-274+1<=9) s[8]=day-274+1+48;
       else s[8]=(day-274+1)/10+48,s[9]=((day-274+1)%10)+48;
      }
     if (day>=306-1&&day<=335-1)
      {
       s[0]='N',s[1]='o',s[2]='v',s[3]='e',s[4]='m',s[5]='b',s[6]='e',s[7]='r',s[8]=' ';
       if (day-305+1<=9) s[9]=day-305+1+48;
       else s[9]=(day-305+1)/10+48,s[10]=((day-305+1)%10)+48;
      }
     if (day>=336-1&&day<=366-1)
      {
       s[0]='D',s[1]='e',s[2]='c',s[3]='e',s[4]='m',s[5]='b',s[6]='e',s[7]='r',s[8]=' ';
       if (day-335+1<=9) s[9]=day-335+1+48;
       else s[9]=(day-335+1)/10+48,s[10]=((day-335+1)%10)+48;
      }
    }
  }
 return (*s);
}
int main()
{
    int year,day;
    char ch[80]="0";
    cin>>year>>day;
    Julian_Convert(year, day, ch);
    cout<<ch;
    return 0;
}






