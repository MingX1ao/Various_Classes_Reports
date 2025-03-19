#include <iostream>
#include<string>
using namespace std;

int main(){
 string  a("SJTU");
    int  i=0;
while(i<4){
  i=i+1;
  cout<<a.substr(0,i)<<endl;

    }
    return 0;
}

