#include "count_exchange.h"

//this part's function is to change 10 to 16
void ex_10_to_16(int num)
{
 char extra[7]={"ABCDEF"};
 int op=0;//最高位次数
 char rst[100]={0};

 while (num>=int(pow(16,op+1)))
   op++;


 for (int i=0;i<=op;i++)
  {
   if (num/(int(pow(16,op-i)))>=10)
     rst[i]=extra[num/(int(pow(16,op-i)))-10];
   else
     rst[i]=num/(int(pow(16,op-i)))+48;
   num=num-pow(16,op-i)*(num/(int(pow(16,op-i))));
  }
    cout<<"该十进制数转化为十六进制数为：";
 for (int i=0;i<=op;i++)
  cout<<rst[i];
}


//this part's function is to change 16 to 10
void ex_16_to_10(char *number,int digits)
{
 int rst;
 for (int i=0;i<digits+1;i++)
  {
   if (number[i]=='A') rst+=pow(16,digits-i-1)*10;
   if (number[i]=='B') rst+=pow(16,digits-i-1)*11;
   if (number[i]=='C') rst+=pow(16,digits-i-1)*12;
   if (number[i]=='D') rst+=pow(16,digits-i-1)*13;
   if (number[i]=='E') rst+=pow(16,digits-i-1)*14;
   if (number[i]=='F') rst+=pow(16,digits-i-1)*15;
   if (number[i]>='0'&&number[i]<='9') rst+=pow(16,digits-i-1)*(int(number[i])-48);
  }
  cout<<"该十六进制数转化为十进制数为：";
 cout<<rst;
}






/*int main()
{
 char number[100]={0};
 int num=0;
 int choice;
 int digits=0;

 for (int i=0;i<100;i++)
  number[i]='@';

 cout<<"what are you want to do, if change 10 to 16,press 16, if change 16 to 10, press 10"<<endl;
 cin>>choice;

 if (choice!=10&&choice!=16) {cout<<"WRONG NUMBER";return -1;}

 cout<<"now input original number"<<endl;
 cin>>number;

 while (number[digits]!='@')
  digits++;

 digits--;

 for (int i=0;i<digits;i++)
   num+=pow(10,digits-i-1)*(int(number[i])-48);


 if (choice==16)
 ex_10_to_16(num);

 if (choice==10)
 ex_16_to_10(number,digits);
 return 0;
}*/










