#include <iostream>
#include <cstring>
using namespace std;

//int main()                                      //
//{
// int n=0,numOfNum=0,numOfWord=0,numOfOther=0;
// char text[11][80];
// cin>>n;
// for (int i=0;i<=n;i++)
//   cin.getline(text[i],80,'\n');
// for (int j=1;j<=n;j++)
//  {
//     for (int i=0;i<strlen(text[j]);i++)
//      {
//       if ((text[j][i]>='a'&&text[j][i]<='z')||(text[j][i]>='A'&&text[j][i]<='Z'))
//         numOfWord++;
//       if ((text[j][i]>='0'&&text[j][i]<='9'))
//         numOfNum++;
//       if (text[j][i]>=':'&&text[j][i]<='@'||text[j][i]>='['&&text[j][i]<=96||text[j][i]>=123&&text[j][i]<=126||text[j][i]>=33&&text[j][i]<=47)
//         numOfOther++;
//      }
//  }
// cout<<numOfWord<<" "<<numOfNum<<" "<<numOfOther;
// return 0;
//}



//int main()
//{
// bool flag=false;
// char text[80]={0},after[80]={0},tmp;
// cin.getline(text,80);
// for (int i=0;i<80;i++)
//  {
//   for (int j=0;j<80;j++)
//    {
//     if ((text[i]==text[j])&&(i!=j)) text[j]=0;
//    }
//  }
// for (int i=0;i<80;i++)
//  after[i]=text[i];
// for (int i=1;i<80;i++)
//  {
//   flag=false;
//   for (int j=0;j<80-i;j++)
//     if (after[j]<after[j+1]) tmp=after[j],after[j]=after[j+1],after[j+1]=tmp,flag=true;
//   if (flag!=true) break;
//  }
// for (int i=0;i<80;i++)
//  {
//   if (after[i]!=0)
//   cout<<after[i];
//  }
//}

//int main()
//{
// bool flag=false;
// int num;
// char text[80]={'\0'},word;
// cin.getline(text,80,'\n');
// cin>>word;
// for (int i=0;i<80;i++)
//  {
//   if (text[i]==word)
//    {num=i;
//    flag=true;}
//  }
// if (flag==true) cout<<num;
// else cout<<"Not Found";
//}



int main()
{
 bool flag;
 int r=0,c=0,num[41]={0},shu=0;
 char text1[50]={'0'},text2[50]={'0'},word[41][12]={' '};
 cin.getline(text1,100,'\n');
 cin.getline(text2,100,'\n');
 for (int i=0;i<50;i++){if(text1[i]>='A'&&text1[i]<='Z') text1[i]=text1[i]+32;}
 for (int i=0;i<50;i++){if(text2[i]>='A'&&text2[i]<='Z') text2[i]=text2[i]+32;}
 for (int i=0;i<50;i++)                     //录入单词
  {
   if ((text1[i]>='a'&&text1[i]<='z')||(text1[i]=='\''))
     word[r][c]=text1[i],c++;
   if (text1[i]==' ') ++r,c=0;
   if (text1[i]==','||text1[i]=='.'||text1[i]==':') c=0;
  }
 r++,c=0;
 for (int i=0;i<50;i++)                     //录入单词
  {
   if ((text2[i]>='a'&&text2[i]<='z')||(text2[i]=='\''))
     word[r][c]=text2[i],c++;
   if (text2[i]==' ') ++r,c=0;
   if (text2[i]==','||text2[i]=='.'||text2[i]==':') c=0;
  }
 for (int i=0;i<=r;i++)               //以实现查重，计数
  {
   for (int j=1;j<=r-i;j++)
    {
     flag=false;
     for (int k=0;k<12;k++)
      {
       if (word[i][k]!=word[i+j][k])
         flag=true;
      }
      if(!flag)
        word[i+j][0]='@',num[shu]++;
    }
   if (word[i][0]!='@') word[i][10]=num+48;
  }
  for (int i=0;i<=r;i++)
   {
    if (word[i][10])
     {
      for (int j=0;j<11;j++)
      if(j!=10) cout<<word[i][j];
      else cout<<word[i][j]<<endl;
     }
   }
}











