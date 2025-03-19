//#include <iostream>

//using namespace std;

//int main()                           //Ñî»ÔÈý½Ç
//{int n,i,j,a[1000]={1,1,1,0,0};
// cin>>n;
// for (i=1;i<=n;i++)
//  {
//   if (i==1)
//    cout<<a[i-1]<<endl;
//   else
//    {
//     for (j=1;j<=i;j++)
//      {
//       if (j==1||j==i) a[(i-1)*i/2+j-1]=1;
//       else a[(i-1)*i/2+j-1]=a[(i-1)*(i-2)/2+j-1]+a[(i-1)*(i-2)/2+j-2];
//       if (j==i) cout<<a[(i-1)*i/2+j-1]<<endl;
//       else cout<<a[(i-1)*i/2+j-1]<<" ";
//
//      }
//
//    }
//  }
//    return 0;
//}





//int main()                                     //ÕÒ¾ØÕóµÄÃªµã
//{
// int m,n,i,j,k,max=0,min=10000,r=0,c=0,s=0;
// int a[10][10]={0},jieguo[20]={0};
// cin>>m>>n;
// for (i=0;i<m;i++)
//  {
//   for (j=0;j<n;j++)
//     cin>>a[i][j];
//  }
// for (i=0;i<m;i++)
//  { max=0,min=1000;
//   for (j=0;j<n;j++)
//    {
//     if (a[i][j]>=max) {max=a[i][j],r=i,c=j;}
//    }
//     for (k=0;k<m;k++) {if(a[k][c]<=min) min=a[k][c];}
//      if (max==min) {s=s+2,jieguo[s-2]=r,jieguo[s-1]=c;}
//  }
//  if (s==0) cout<<"Not Found"<<endl;
//  else {for (i=0;i<s;i=i+2){cout<<jieguo[i]<<" "<<jieguo[i+1]<<endl;}}
//  }





//#include <iostream>
//using namespace std;


//const int MAXSIZE=10;


//int main()
//{
//    int i,j,m,n;
//    int mat[MAXSIZE+1][MAXSIZE],MAT[10][10];
//
//    cin>>m>>n;
//   for (i=0; i<m; i++)
//        for (j=0; j<n; j++)
//            cin>>mat[i][j];


//    for (i=0; i<m; i++)
//        for (j=0; j<n; j++)
//            MAT[(i+1)%m][j]=mat[i][j];



//    for (i=0; i<m; i++)
//    {

//        for (j=0; j<n; j++)
//            cout<<MAT[i][j]<<'\t';
//        cout<<endl;
//    }
//    return 0;
//}
