#include<iostream>

using namespace std;


int main() {
    int quantity, yuan, jiao;
    double charge;

    //cout<<"�����뱾���õ�������λ���ȣ���";
    cin>>quantity;

    charge = 0.6*quantity;
    cout<<"������Ҫ֧����ѣ�"<<charge<<"Ԫ"<<endl;

    yuan = charge;

    jiao = (charge-yuan)*10;
    cout<<"����Ҫ"<<yuan<<"��1Ԫ��"<<jiao<<"��1��Ӳ��"<<endl;
    return 0 ;

    return 0;
}
