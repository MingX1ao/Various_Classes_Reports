#include <iostream>
#include <cstring>
using namespace std;

/*
struct date
{
 int year;
 int month;
 int day;
};

struct studentI
{
 char name[21];
 date birthday;
 char number[12];
 char address[100];
};


int main()
{
 int n;
 cin>>n;
 studentI *stda=new studentI[n];
 studentI tmp;
 for (int i=0;i<n;i++)
 {
  cin>>(stda+i)->name>>(stda+i)->birthday.year
     >>(stda+i)->birthday.month>>(stda+i)->birthday.day
     >>(stda+i)->number;
  cin.getline((stda+i)->address,100);
 }
 for (int i=0;i<n;i++)
 {
  for (int j=0;j<n-i;j++)
  {

   if (((stda+j)->birthday.year)<((stda+j+1)->birthday.year)||((stda+j)->birthday.year)==((stda+j+1)->birthday.year)&&((stda+j)->birthday.month)<((stda+j+1)->birthday.month)||((stda+j)->birthday.year)==((stda+j+1)->birthday.year)&&((stda+j)->birthday.month)==((stda+j+1)->birthday.month)&&((stda+j)->birthday.day)<((stda+j+1)->birthday.day))
   {
    tmp=*(stda+j),*(stda+j)=*(stda+j+1),*(stda+j+1)=tmp;
   }
  }
 }

 for (int i=0;i<n;i++)
 cout<<(stda+i)->name<<" "<<(stda+i)->birthday.year
     <<"/"<<(stda+i)->birthday.month<<"/"<<(stda+i)->birthday.day
     <<" "<<(stda+i)->number<<(stda+i)->address<<endl;
}
*/

struct linkNode
{
 char no[4];
 char name[21];
 char sex[7];
 int age;
 int cls;
 int ENG;
 int MAT;
 int PHY;
 int sum;
 int rank;
 linkNode *next;
};




void  a(linkNode *head,int n)
{
 linkNode *p;
 p=head->next;
 for (int i=0;i<n;i++)
 {
 cout<<p->no<<" "
     <<p->name<<" "
     <<p->sex<<" "
     <<p->age<<" "<<p->cls<<" "
     <<p->ENG<<" "<<p->MAT<<" "<<p->PHY<<endl;
  p=p->next;
 }
}

/*
linkNode *b(linkNode *p)
{
 linkNode *tmp=new linkNode;
 tmp->data=x//输入新结点的数据
 tmp->next=p->next;
 p->next=tmp;
}


linkNode *c(linkNode *p)
{
 linkNode *delp=p->next;
 p->next=delp->next;
 delete delp;
}

*/


void d(linkNode *head,int n)
{
 linkNode *p;
 p=head->next;
 for (int i=0;i<n;i++)
 {
  p->sum=p->ENG+p->MAT+p->PHY;
  p=p->next;
 }
 p=head->next;
 for (int i=0;i<n;i++)
 {
 cout<<p->no<<" "
     <<p->name<<" "
     <<p->sex<<" "
     <<p->age<<" "<<p->cls<<" "
     <<p->ENG<<" "<<p->MAT<<" "<<p->PHY<<" "<<p->sum<<endl;
  p=p->next;
 }
}




void e(linkNode *head,int n)
{
 int a=1,b=0,num[100]={0},k=0;
 linkNode *p;
 p=head->next;
 int mark[100]={0};
 for (int i=0;i<n;i++)
 {
  mark[i]=p->ENG;
  p=p->next;
 }
 p=head;
 while (a!=0)
{
 for (int i=0;i<n;i++)
 {
  if (a<mark[i])
   b=i,a=mark[i];
 }
  mark[b]=0,a=1;
  num[k]=b;
  k++;
}
for (int i=0;i<=k;i++)
 {
  for (int j=0;j<=num[i];j++)
   {
    p=p->next;
   }
  cout<<p->no<<" "
     <<p->name<<" "
     <<p->sex<<" "
     <<p->age<<" "<<p->cls<<" "
     <<p->ENG<<" "<<p->MAT<<" "<<p->PHY<<endl;
  p=head;
 }
}





void f(linkNode *head,int n)
{
 int a=1,b=0,num[100]={0},k=0;int mark[100]={0};
 linkNode *p;
 linkNode tmp;
 p=head->next;
 for (int i=0;i<n;i++)
 {
  p->sum=p->ENG+p->MAT+p->PHY;
  p=p->next;
 }
 p=head->next;

for (int i=0;i<n;i++)
 {
  mark[i]=p->ENG;
  p=p->next;
 }
 p=head;
 while (k<n)
{
 for (int i=0;i<n;i++)
 {
  if (a<mark[i])
   b=i,a=mark[i];
 }
  mark[b]=0;
  num[k]=b,a=1;
  k++;
}
for (int i=0;i<=k;i++)
 {
  for (int j=0;j<=num[i];j++)
   {
    p=p->next;
   }
  p->rank=i+1;
  p=head;
 }
 p=head->next;
 for (int i=1;i<=n;i++)
 {
  p->rank=i;
 }
 p=head->next;
 for (int i=0;i<n;i++)
 {
 cout<<p->no<<" "
     <<p->name<<" "
     <<p->sex<<" "
     <<p->age<<" "<<p->cls<<" "
     <<p->ENG<<" "<<p->MAT<<" "<<p->PHY<<" "<<p->rank<<endl;
  p=p->next;
 }



}




int main()
{
 int n;char x;
 cin>>n;
 linkNode *head,*tail,*p;
 head=tail=new linkNode;
 for (int i=0;i<n;i++)
 {
  p=new linkNode;
  cin>>p->no
     >>p->name
     >>p->sex
     >>p->age>>p->cls
     >>p->ENG>>p->MAT>>p->PHY;
  tail->next=p;
  tail=p;
 }
 tail->next=NULL;
 cin>>x;
 if (x=='a') a(head,n);
/* if (x=='b') b(p);
   if (x=='c') c(p); */
 if (x=='d') d(head,n);
 if (x=='e') e(head,n);
 if (x=='f') f(head,n);
 }













