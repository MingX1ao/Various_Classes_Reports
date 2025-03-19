#include<iostream>

using namespace std;


int main() {
    int quantity, yuan, jiao;
    double charge;

    //cout<<"请输入本月用电量（单位：度）：";
    cin>>quantity;

    charge = 0.6*quantity;
    cout<<"本月需要支付电费："<<charge<<"元"<<endl;

    yuan = charge;

    jiao = (charge-yuan)*10;
    cout<<"共需要"<<yuan<<"个1元和"<<jiao<<"个1角硬币"<<endl;
    return 0 ;

    return 0;
}
