#include <iostream>
#include <bitset>
using namespace std;



/*
char *strncpy(char *dest,const char* src,int n)
{
 for (int i=0;i<n;i++)
 {
  if (*(src+i)!='\0')
   *(dest+i)=*(src+i);
  else *(dest+i)='e'; //e±íÊ¾'\0';
 }
 return dest;
}

int main()
{
 char pattern[100]={'S','J','T','U','n','b','B','u','t','F','D','n','b','e','r'};
 char destinaton[100]={' '};
 int n;
 cin>>n;
 strncpy(destinaton,pattern,n);
 for (int i=0;i<n;i++)
 cout<<destinaton[i];
}

*/




/*
int &squarex(int x)
{
 int *p=new int;
 *p=x*x;
 return *p;
}

int main()
{
 int x=0;
 cin>>x;
 cout<<squarex(x)<<endl;
 cout<<++squarex(x);
}
*/



int main(int argc,char *argv[])
{
 if (argc<2)
  {
   cout<<"obh2dec.exe [-o][-b][-h] target"<<endl;
   cout<<"-o the target is an octal number"<<endl;
   cout<<"-b the target is a binary number"<<endl;
   cout<<"-h the target is a hexadecimal number"<<endl;
   cout<<"If all optional parameters are omitted, by default,"<<endl;
   cout<<"the target is a hexadecimal number."<<endl;
  }
 else
 {
  int n;
  cin>>n;

  if (*(argv+1)=="[-o]")
   cout<<oct<<n;
  if ((*argv+1)=="[-b]")
   cout<<bitset<8>(n);
  if ((*argv+1)=="[-h]")
   cout<<hex<<n;
 }




}













