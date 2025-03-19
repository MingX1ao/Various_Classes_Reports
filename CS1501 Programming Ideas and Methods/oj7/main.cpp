#include <iostream>
#include <cstring>
#include <cmath>
using namespace std;

bool iscount(int num[])
{
 int a=0;
 for (int i=0;i<1000;i++)
  {
   if (num[i]!=0) a++;
  }
 if (a==1) return false;
 else return true;
}


int main()
 {
  int n,num[1000]={0},a=0;
  int *p=num;
  cin>>n;
  for (int i=0;i<n;i++)
    num[i]=i+1;
  for (int j=0;iscount(num);j++)
   {
    if (*(p+j%n)!=0)
     {
      a++;
      if (a%3==0)
      *(p+j%n)=0;
     }
   }
  for (int i=0;i<1000;i++)
   {
    if (num[i]!=0) cout<<num[i];
   }
 }











//int main()
//{
// int a[50]={0},b[50]={0},c[51]={0},max=0;
// char text1[50]={' '},text2[50]={' '};
// cin.getline(text1,50);
// cin.getline(text2,50);
// max=(strlen(text1)>strlen(text2)? strlen(text1):strlen(text2));
// for (int i=0;i<strlen(text1);i++)
//  {
//   a[strlen(text1)-i-1]=(text1[i]-48);
//  }
// for (int i=0;i<strlen(text2);i++)
//  {
//   b[strlen(text2)-i-1]=(text2[i]-48);
//  }
// for (int i=0;i<max+1;i++)
// {
//  c[i]=c[i]+(a[i]+b[i])%10;
//  if ((a[i]+b[i])>=10)
//  c[i+1]=1;
// }
// if (c[max]==0)
//  {
//   for (int i=max-1;i>=0;i--)
//     cout<<c[i];
//  }
// else
//  {
//   for (int i=max;i>=0;i--)
//     cout<<c[i];
//  }
//}










//int Count_substring(char* text, char* pattern)
//{
// bool flag=true;int num=0;
// for (int i=0;i<strlen(text);i++)
//  {
//   if (*(text+i)!=*(pattern)) continue;
//   else
//    {
//     flag=true;
//     for (int j=0;j<strlen(pattern);j++)
//      {
//       if (*(text+i+j)!=*(pattern+j))
//         {flag=false;break;}
//      }
//      if (flag) num++;
//    }

//  }

// return (num);
//}


//int main()
//{
// int k=0;
// char text1[100]={'0'},text2[100]={'0'},text[100]={' '};
// cin.getline(text1,100,'\n');
// cin.getline(text2,100,'\n');
// for (int i=0;i<strlen(text1);i++){if(text1[i]>='A'&&text1[i]<='Z') text1[i]=text1[i]+32;}
// for (int i=0;i<strlen(text2);i++){if(text2[i]>='A'&&text2[i]<='Z') text2[i]=text2[i]+32;}
// for (int i=0;i<strlen(text1);i++){if(text1[i]>='a'&&text1[i]<='z'){text[k]=text1[i],k++;}}
// cout<<Count_substring(text,text2);
//}
