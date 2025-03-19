#include <iostream>

using namespace std;

int main()
{
  int  table[3][3]={{0,0,0}};
  bool flag=true;
  int cnt=0;
  while (flag)
    {
     cnt++;
     for (int i=0;i<3;i++)
      {
       for (int j=0;j<3;j++)
         cout<<table[i][j]<<" ";
       cout<<endl;
      }
     int m=0,n=0;
     cin>>m>>n;
     if (cnt%2==0)
       table[m][n]=2;
     else table[m][n]=1;
     if (table[0][1]==table[0][2]&&table[0][1]==table[0][0]&&table[0][1]!=0||
         table[1][1]==table[1][2]&&table[1][1]==table[1][0]&&table[1][1]!=0||
         table[2][1]==table[2][2]&&table[2][1]==table[2][0]&&table[2][1]!=0||
         table[0][0]==table[1][0]&&table[1][0]==table[2][0]&&table[0][0]!=0||
         table[0][1]==table[1][1]&&table[1][1]==table[2][1]&&table[0][1]!=0||
         table[0][2]==table[1][2]&&table[1][2]==table[2][2]&&table[0][2]!=0||
         table[0][0]==table[1][1]&&table[1][1]==table[2][2]&&table[0][0]!=0||
         table[0][2]==table[1][1]&&table[1][1]==table[2][0]&&table[0][2]!=0)
        flag=false;
    }
    for (int i=0;i<3;i++)
      {
       for (int j=0;j<3;j++)
         cout<<table[i][j]<<" ";
       cout<<endl;
      }

   cout<<cnt%2<<"win";


    return 0;
}
