//
//  main.cpp
//  Huffman
//
//  Created by Hong-Ming on 2018/6/6.
//  Copyright © 2018年 HongMing. All rights reserved.
//

#include <functional>
#include <queue>
#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
#include <limits>
#include <iomanip>
#include <vector>
using namespace std;
int i;
string name[6];
string code[6];

struct MinHeapNode {
    char data;
    unsigned freq;
    MinHeapNode *left, *right;
    MinHeapNode(char data, unsigned freq)
    {
        left = right = NULL;
        this->data = data;
        this->freq = freq;
    }
};
struct compare {
    bool operator()(MinHeapNode* l, MinHeapNode* r)
    {
        if(l->freq == r->freq){
            return(l->data < r->data);
        }
        return (l->freq > r->freq);
    }
};
void printCodes(struct MinHeapNode* root, string str)
{
    if (!root)
        return;
    if (root->data < 'A'){
        name[i]=root->data;
        code[i]=str;
        i=i+1;
    }
    printCodes(root->right, str + "1");
    printCodes(root->left, str + "0");
}
void HuffmanCodes(char data[], int freq[], int size)
{
    struct MinHeapNode *left, *right, *top;
    priority_queue<MinHeapNode*,vector<MinHeapNode*>,compare>     minHeap;
    for (int i = 0; i < size; ++i)
        minHeap.push(new MinHeapNode(data[i], freq[i]));
    
    while (minHeap.size() != 1) {
        cout<<minHeap.top()->data<<":"<<minHeap.top()->freq<<endl;
        right = minHeap.top();
        minHeap.pop();
        cout<<minHeap.top()->data<<":"<<minHeap.top()->freq<<endl;
        left = minHeap.top();
        minHeap.pop();
        top = new MinHeapNode('H'-minHeap.size(), left->freq + right->freq);
        top->left = left;
        top->right = right;
        minHeap.push(top);
    }
    printCodes(minHeap.top(), "");
}
int main(int argc,char* argv[])
{
    string temp_name;
    string temp_code;
    i=0;
    /*int graycode;
     int seed=591519;
     srand(seed);
     int freq[6]={0};
     for(int j=0;j<100;++j){
     
     graycode=rand()%6;
     if(graycode==0)freq[0]=freq[0]+1;
     if(graycode==1)freq[1]=freq[1]+1;
     if(graycode==2)freq[2]=freq[2]+1;
     if(graycode==3)freq[3]=freq[3]+1;
     if(graycode==4)freq[4]=freq[4]+1;
     if(graycode==5)freq[5]=freq[5]+1;
     fout2<<graycode<<endl;
     }*/
    
    while(true){
        i=0;
        int freq[6]={31,5,6,25,28,5};
        char arr[6] = { '0', '1', '2', '3', '4', '5' };
        for(int j=0;j<6;++j){
            cout<<"CNT"<<j<<":";
            cin>>freq[j];
            arr[i]=i+48;
        }
        cout<<"END OF INPUT"<<endl;
        for(int j=0;j<6;++j){
            cout<<arr[j]<<" "<<freq[j]<<endl;
        }
        int size = sizeof(arr) / sizeof(arr[0]);
        HuffmanCodes(arr, freq, size);
        cout<<"ANSWER:"<<endl;
        for(int j=0;j<6;++j){
            for(int k=0;k<6;++k){
                if(name[k][0]-48==j)cout<<(name[k][0])<<" "<<code[k]<<endl;
            }
        }
    }
//    system("PAUSE");
    return 0;
}

