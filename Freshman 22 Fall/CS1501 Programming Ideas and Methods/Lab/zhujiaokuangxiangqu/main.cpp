#include <iostream>
#include <cstring>
using namespace std;


int max(int shu[],int n)
 {
  int a=0;
  for (int i=0;i<n;i++)
    if (shu[i]>a)
      a=shu[i];
  return (a);
 }


//int pa(int n,int arr[n][n],int rst)
//{
// if (n>1)
//  {
//   rst+=pa(n-1,arr[n-1][n-1],rst);
//   return rst;
//  }
// else return arr[0][0];
// ;
//}


int main()
{
 int n=0,shu[100][100]={{0},{0}},rst=0;
 cin>>n;
 for (int i=0;i<n;i++)
  {
   for (int j=0;j<=i;j++)
     cin>>shu[i][j];
  }
 for(int i=n-2;i>=0;i--)
    for(int j=0;j<=i;j++)
       shu[i][j]=shu[i][j]+(shu[i+1][j]>shu[i+1][j+1]? shu[i+1][j]:shu[i+1][j+1]);
    cout<<shu[0][0]<<endl;



}
