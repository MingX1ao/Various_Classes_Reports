#include <iostream>

using namespace std;

int main()
{
 int i, j, n, sum=0;
 int date[7]={0,0,0,0,0,0,0};
 cin>>n;
 for (i=1;i<=n;i++)
  {
   sum=(i-1)*365+(i-2)/4;
   if ((1900+i-1)%4==0&&(i+1900-1)%100!=0)
    {
     for (j=1;j<=366;j++)
      {
       switch (j)
        {
         case 13 :date[(sum+13-1)%7]+=1 ;break;
         case 44 :date[(sum+44-1)%7]+=1 ;break;
         case 73 :date[(sum+73-1)%7]+=1 ;break;
         case 104:date[(sum+104-1)%7]+=1;break;
         case 134:date[(sum+134-1)%7]+=1;break;
         case 165:date[(sum+165-1)%7]+=1;break;
         case 195:date[(sum+195-1)%7]+=1;break;
         case 226:date[(sum+226-1)%7]+=1;break;
         case 257:date[(sum+257-1)%7]+=1;break;
         case 287:date[(sum+287-1)%7]+=1;break;
         case 318:date[(sum+318-1)%7]+=1;break;
         case 348:date[(sum+348-1)%7]+=1;break;
        }
      }
    }
   else
    for (j=1;j<=365;j++)
     {
      switch (j)
       {
         case 13 :date[(sum+13-1)%7]+=1 ;break;
         case 44 :date[(sum+44-1)%7]+=1 ;break;
         case 72 :date[(sum+72-1)%7]+=1 ;break;
         case 103:date[(sum+103-1)%7]+=1;break;
         case 133:date[(sum+133-1)%7]+=1;break;
         case 164:date[(sum+164-1)%7]+=1;break;
         case 194:date[(sum+194-1)%7]+=1;break;
         case 225:date[(sum+225-1)%7]+=1;break;
         case 256:date[(sum+256-1)%7]+=1;break;
         case 286:date[(sum+286-1)%7]+=1;break;
         case 317:date[(sum+317-1)%7]+=1;break;
         case 347:date[(sum+347-1)%7]+=1;break;
       }
     }
  }
 for (i=0;i<=6;i++)
  cout<<date[i]<<" ";
}
