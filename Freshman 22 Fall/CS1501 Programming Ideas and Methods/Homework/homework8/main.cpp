#include <iostream>
#include <cstring>
#include <typeinfo>

using namespace std;


//˫����ڵ�ṹ�嶨��
struct DuallistNode {
void * datap;
struct DuallistNode * prev; //ָ����һ���ڵ��ָ��
struct DuallistNode * next; //ָ����һ���ڵ��ָ��
};



//˫����ṹ�嶨�壬������������ͷ�ڵ�ָ�������β�ڵ�ָ��
struct Duallist {
struct DuallistNode *head; //ָ�������һ���ڵ�
struct DuallistNode *tail; //ָ���������һ���ڵ�
};


//b ���ͱȽ�
int cmp_int(const int* aInt, const int*bInt)
 {
  if (*aInt>*bInt) return 1;
  if (*aInt<*bInt) return -1;
  if (*aInt==*bInt) return 0;
 }

//c �ַ����Ƚ�
int cmp_str(const char* aStr, const char* bStr)
 {
  return strcmp(aStr,bStr);
 }


//d ɾ���ڵ�
void* delete_node(struct Duallist *aDuallist,
struct DuallistNode *p)
 {
  void *data;
  p->prev->next=p->next,p->next->prev=p->prev;
  data=p->datap;
  delete p;
  return data;
 }
//��p��ǰһ���ڵ�ͺ�һ�����Ӳ�ɾ��p�Ϳ����˰ɣ�
//Ϊʲô��Ҫ����һ��˫����Duallist *aDuallist��




//a ��������
int  cmp (const void* x, const void* y)
{
 if (typeid(x)==typeid(int*))
  return cmp_int((int*)x,(int*)y);
 else return cmp_str((char *)x,(char*)y);
}

struct DuallistNode* find_data(struct Duallist *aDuallist,
void* data, int(*cmp)(const void*, const void*))
 {
  DuallistNode *p;
  bool flag=false;
  p=aDuallist->head;
  while (p)
   {
    if (p->datap==data)
     {
      *((int*)(p->datap))=(*cmp)(p->datap,data);
      break;
     }
    p=p->next;
   }
  if (flag) return p;
  else
   {
    p->next=NULL,p->prev=NULL;
    return p;
   }
 }



//e ��hello word
int  main()
{
 bool flag=false;
 Duallist *aDuallist;
 //cin>>aDuallist  ��������
 char pettern[]="hello world!";
 DuallistNode *p;
 p=aDuallist->head;
 while (p)
 {
  if ((char*)(p->datap)==pettern)
   flag=true;
  else p=p->next;
 }
 if (flag) cout<<"Found";
 else cout<<"Not Found";
}
