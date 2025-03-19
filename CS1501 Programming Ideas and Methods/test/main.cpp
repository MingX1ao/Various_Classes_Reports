#include <iostream>
#include <cmath>
#include <string.h>
#include <vector>
#include <cstring>
#include <cstdlib>
#include <ctime>
#include <algorithm>

using namespace std;






/*
class doublearray
{
 private:
   int low;
 public:
   doublearray(int x): low(x)
    {
     cout<<"Create"<<low<<endl;
    }
   ~doublearray()
    {
     cout<<"Destroy"<<low<<endl;
    }
};

doublearray globa(0);

void f()
{
 cout<<"in f"<<endl;
 static doublearray int1(1);
 doublearray int2(2);
}



int main()
{

 f();
 f();
doublearray main(4);

 int i=0;
 i=++i+i++;
 cout<<i;
}
*/
/*
class d_2
{
 private:
    double x;
    double y;

 public:
    d_2(double x,double y)
    : x(x),y(y){}

    double dst()
     {
       return pow(x*x+y*y,0.5);
     }
    void display()
      {
        cout<<"X"<<x<<"  "<<"Y"<<y<<"  ";
      }

};


class d_3:public d_2
{
 protected:
    double z;
 public:
    d_3(double a,double x,double y): d_2(x,y)
    {z=a;}

    void display()
     {
      d_2::display();
      cout<<"Z"<<z;
     }

};


int main()
{
 double x,y,z;
 cin>>x>>y>>z;
 d_3 xyz(x,y,z);
 cout<<xyz.dst();
 xyz.display();
}
*/

/*
class point
{
 int x,y;
 public:
   point(int x=0,int y=0)
     :x(x),y(y)
      {
          cout<<"point create"<<x<<","<<y<<endl;
      }
   ~point(){cout<<"point destroy"<<x<<","<<y<<endl;}

};


class shape
{
 public:
    static int id;
    shape(){id++;cout<<"shape create"<<id<<endl;}
    ~shape(){cout<<"shape destroy"<<id<<endl;}
};


int shape::id=0;

class e:public shape
{
  point f1,f2;
  double a;
public:
  e(){cout<<"e create"<<id<<endl;}
  e(int x1,int y1,int x2,int y2,double aa)
  :f2(x2,y2),f1(x1,y1)
  {
      cout<<"e create"<<id<<endl;
  }
  ~e(){cout<<"e destroy"<<id<<endl;}

};


int main()
{
 e *p,a;
 p=new e(0,0,0,10,30);
 delete p;
}



int main()
{
  cout<<"nb";


}

*/
/*
#include <iostream>
#include <cmath>
#include <iomanip>
using namespace std;

template<class T>
int find(T* a,int b,T c )
{
 int low=0,high=b;
 int mid=(low+high)/2;
 while (low<=high)
  {
    mid=(low+high)/2;
    if (*(a+mid)==c)
      return mid;
    if (*(a+mid)>c)
      high=mid-1;
    else low=mid+1;
  }
  if(low>high) return -1;
}




int main(){
    int a[10] = {0,1,2,3,4,5,6,7,8,9};
    char b[10] = {'a','b','c','d','e','f','g','h','i','j'};
    double c[10] = {1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2};

    cout<<find(a, 10, 10)<<endl;
    cout<<find(a, 10, 0)<<endl;
    cout<<find(b, 10, 'a')<<endl;
    cout<<find(b, 10, 'k')<<endl;
    cout<<find(c, 10, 1.0)<<endl;
    cout<<find(c, 10, 1.1)<<endl;

    return 0;
}
*/


int swap(int &x, int *y, int z=1)
{   int *a = &x;
    static int b=x;
    b+=2;
    *a=(*a)-z+b;
    return b;  }





class myString
{
  private:
      char *p;
      int len;
  public:
      myString(char*ex)
      {
        len=strlen(ex);
        p=new char[len];
        for (int i=0;i<len;i++)
          *(p+i)=*(ex+i);
        p[len]='\0';
      }


       int getLen(){return len;}

       void stringCat(const myString &astring)
       {
         *(p+len)=*(astring.p);
         for (int i=1;i<astring.len;i++)
            *(p+len+i)=*(astring.p+i);
         *(p+len+astring.len)=('\0');
         len+=astring.len;
       }

       void disp()
       {
          for (int i=0;i<len;i++)
            cout<<*(p+i);
       }

};



void testFucn(int,char);//your defination

void testFucn(int ,char)
{

    //your realizion
}


class test
{
    int n;
    public:
       test(int i): n(i){};

        int get()
         {
             return n;
         }
       test operator++()
       {
          n+1;
          return n;
       }

        int operator++(int)
       {
          this->n++;
          return n;
       }

};

  void fun1(int (*p)[5])
  {

    cout<<p[2][4];
    cout<<"succeed1"<<endl;
  }

  void fun2(int *p[])
  {
    cout<<"succeed2"<<endl;
  }


   vector<long long> maximumEvenSplit(long long finalSum)
   {
       int times=finalSum/2;
        vector<long long> rst;
        if (finalSum%2!=0) return rst;
        //vector<int> rstTimes;
        //rstTimes.push_back(0);
        int tmp=times;
        for (int i=1;i<2*tmp;i++)
        {
            if (times-i>=0)
            {
                rst.push_back(2*i);
                times-=i;
                continue;
            }
            if (times-i<0)
            {
                rst[i-2]+=2*times;
                break;
            }
        }
        //for (int i=1;i<rstTimes.size();i++)
        //   rst.push_back(2*rstTimes[i]);
        return rst;
   }




/*
int main()
{
        /*
        while (1)
        {


        int finalSum;
        cin>>finalSum;

        vector<long long>rst=maximumEvenSplit(finalSum);
        for (int i=0;i<rst.size();i++)
            cout<<rst[i]<<'\t';

        cout<<'\n';
        }
*/
/*
char * p;
cin>>p;
cout<<p<<endl<<strlen(p);
*/
 /*
 test i=0;
 test  a(++i);

  int x[3][5];
  x[3][5]=3;

 fun1(x);
 //fun2(x);

 //cout<<a.get();

 char s[]="d:\\\x30.txt";
 cout<<strlen(s);
*/

/*
int main()
{
  myString A("SJTU"),B("SB");
  cout<<A.getLen();
  A.stringCat(B);
  A.disp();cout<<A.getLen();

   char str[10] = "2019\t";
   cout<<strlen(str)+sizeof(str);
}

*/
vector<int> str2Int(string aStr);

int captureForts(vector<int>& forts)
    {
        int i = 0;
        int cnt = 0;
        int tmp = 0;
        while (i<forts.size())
        {
            if (forts[i]==1)
            {
                while (forts[i+cnt+1]==0)
                    cnt++;
                if (forts[i+cnt+1]==1)
                    cnt = 0;
                else
                    if (tmp<cnt)
                        tmp=cnt;
                i += cnt+1;
                cnt = 0;
                continue;
            }

            if (forts[i]==-1)
            {
                while (forts[i+cnt+1]==0)
                    cnt++;
                if (forts[i+cnt+1]==-1)
                    cnt = 0;
                else
                    if (tmp<cnt)
                        tmp=cnt;
                i += cnt+1;
                cnt = 0;
                continue;
            }
        }
        return tmp;
    }
int getRand(int Size)                                     //È¡Ëæ»úÊý
{

    return rand()%Size;
}
int binarySearch(vector<int>& nums,int low,int high,int target)
    {
        int mid = (low + high) / 2;
        while (low<=high)
        {
            if (nums[mid]>target)
            {
                high = mid - 1;
                mid = (low + high) / 2;
                continue;
            }
            if (nums[mid]<target)
            {
                low = mid + 1;
                mid = (low + high) / 2;
                continue;
            }
            if (nums[mid]==target)
                return mid;
        }
        return -1;
    }


struct TreeNode
{
      int val;
      TreeNode *left;
      TreeNode *right;
      TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};






    TreeNode* _deserialize(vector<int> post,vector<int> mid,
                           int postStart,int postEnd,
                           int midStart,int midEnd)
    {
        if (postStart>postEnd) return NULL;
        TreeNode* p = new TreeNode(post[postStart]);

        int i;
        for (i=midStart;i<=midEnd;i++)
        {
            if (mid[i]==post[postStart])
                break;
        }

            int j;
            for (j=postStart;j<=postEnd;j++)
            {
                if (mid[i+1]==post[j])
                    break;
            }
            if (postStart==postEnd) return NULL;

            p->left = _deserialize(post,mid,postStart+1,j-1,0,i-1);
            p->right = _deserialize(post,mid,j+1,post.size()-1,i+1,post.size()-1);

        return p;
    }



    // Decodes your encoded data to tree.
    TreeNode* deserialize(string data)
    {
        if (data.empty()) return NULL;

        vector<int> postOrder = str2Int(data);
        vector<int> midOrder = postOrder;
        sort(midOrder.begin(),midOrder.end());
        int end = postOrder.size()-1;
        return _deserialize(postOrder,midOrder,0,end,0,end);
    }



vector<int> str2Int(string aStr)
    {
        vector<int> rst;
        for (int i=0;i<aStr.length();i++)
        {
            if (aStr[i]>=48 && aStr[i]<=57)
                rst.push_back(int(aStr[i])-48);
        }
        return rst;
    }





int main()
{
    cout<<-1%4;



}

