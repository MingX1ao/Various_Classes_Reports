#include <iostream>

using namespace std;


class matrix
{
  friend istream & operator>>(istream & cin,matrix & A);

  private:

     double ** mat;
     double ** Pmat;
     double ** matQ;
     double ** invmat;
     double trace;
     int rank;
     int m;//行数
     int n;//列数

  public:

     matrix(int m,int n) : m(m),n(n),trace(0),rank(0)
     {
       mat=new double *[m];
       for (int i=0;i<m;i++)
          mat[i]=new double[n];
       for (int i=0;i<m;i++)
         for (int j=0;j<n;j++)
           mat[i][j]=0;

       Pmat=new double *[m];
       for (int i=0;i<m;i++)
          Pmat[i]=new double[n];
       for (int i=0;i<m;i++)
         for (int j=0;j<n;j++)
           Pmat[i][j]=0;

       matQ=new double *[m];
       for (int i=0;i<m;i++)
          matQ[i]=new double[n];
       for (int i=0;i<m;i++)
         for (int j=0;j<n;j++)
           matQ[i][j]=0;

       invmat=new double *[m];
       for (int i=0;i<m;i++)
          invmat[i]=new double[n];
       for (int i=0;i<m;i++)
         for (int j=0;j<n;j++)
           invmat[i][j]=0;
     }

      matrix(const matrix & src)
      {
        m=src.m,n=src.n;
        mat=new double *[m];
        for (int i=0;i<m;i++)
         {
            mat[i]=new double[n];
            for (int j=0;j<n;j++)
               mat[i][j]=src.mat[i][j];
         }
      }

      ~matrix()
      {
        for (int i=0;i<m;i++)
           delete [] mat[i];
      }

     void display()
     {
        for (int i=0;i<m;i++)
         {
          for (int j=0;j<n;j++)
            cout<<mat[i][j]<<" ";
          cout<<endl;
         }
     }

     void operator+(const matrix & b);

     void operator-(const matrix & b);

     void operator*(const matrix & b);

     void PA();//行变换

     void AQ();//列变换

     void inv();//求逆

     void rank();//求秩

     void trace();//求迹

};

istream & operator>>(istream & cin,matrix & A)
{
 for (int i=0;i<A.m;i++)
   for (int j=0;j<A.n;j++)
     cin>>A.mat[i][j];
 return cin;
}

 void matrix::operator+(const matrix &b)
{
 if (m!=b.m||n!=b.n)
  cout<<"no match"<<endl;
 else
  {
    for (int i=0;i<m;i++)
     {
       for (int j=0;j<n;j++)
         cout<<mat[i][j]+b.mat[i][j]<<" ";
       cout<<endl;
     }
  }
}

void matrix::operator-(const matrix &b)
{
 if (m!=b.m||n!=b.n)
  cout<<"no match"<<endl;
 else
  {
    for (int i=0;i<m;i++)
     {
       for (int j=0;j<n;j++)
         cout<<mat[i][j]-b.mat[i][j]<<" ";
       cout<<endl;
     }
  }
}

void matrix::operator*(const matrix &b)
{
  double tmp=0;
  if (n!=b.m)
    cout<<"no match"<<endl;
  else
   {
     for (int i=0;i<m;i++)
      {
        for (int j=0;j<b.n;j++)
          {
           tmp=0;
           for (int k=0;k<n;k++)
             tmp+=mat[i][k]*b.mat[k][j];
           cout<<tmp<<" ";
          }
        cout<<endl;
      }
   }
}


void matrix::PA()
{
 double tmp[n];
 for (int k=0;k<m;k++)
 {
  while (mat[k][k-1]==0)
    i++;
  for (int j=0;j<n;j++)
    tmp[j]=mat[1][j],mat[1][j]=mat[i][j],mat[i][j]=tmp[j];
  for (int i=0;i<n;i++)
    mat[0][i]/=mat[0][0];
  for (int i=1;i<m;i++)
    for (int j=0;j<n;j++)
      mat[i][j]=mat[i][j]-mat[0][j]*(mat[i][0]/mat[0][0]);



 }
}





int main()
{
 int m,n;
 cin>>m>>n;
 matrix A(m,n);
 cin>>A;
 A.display();
 matrix B(A);
 A-B;



 return 0;
}
