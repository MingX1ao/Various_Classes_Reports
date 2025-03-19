#include <iostream>

using namespace std;

int main(){
 int i=0,j=0,n=0;
 cin>>n;
 for (i=1;i<=(n+1)/2;i++){
    for(j=1;j<=(n+1)/2-i;j++){cout<<" ";}
    for(j=(n+1)/2-i+1;j<=i+(n-1)/2-1;j++){cout<<"*";}
     cout<<"*"<<endl;
 }
 for (i=(n+1)/2+1;i>(n+1)/2&&i<=n;i++){
    for(j=1;j<=(n+1)/2-(n+1-i);j++){cout<<" ";}
    for(j=(n+1)/2-(n+1-i)+1;j<=(n+1-i)+(n-1)/2-1;j++){cout<<"*";}
     cout<<"*"<<endl;
 }
return 0;
}
