//
//  main.m
//  link
//
//  Created by valyn on 15/10/19.
//  Copyright © 2015年 valyn. All rights reserved.
//
#import <arpa/inet.h>
#import <Foundation/Foundation.h>

#pragma mark - LinkList
typedef struct node{
    int data;
    struct node *next;
}LNode, *LinkList;

#pragma mark - 从头部插入结点
LinkList creatLinkList()
{
    LinkList link = NULL;
    LNode *s;
    int i = 5;
    while (i) {
        s = malloc(sizeof(LNode));
        s -> data = i;
        s -> next = link;
        link = s;
        i--;
    }
    return link;
}

//从尾部插入结点
LinkList creatLinkList2()
{
    LinkList link = NULL;
    LNode *s, *r = NULL;
    int i = 4;
    while (i) {
        s = malloc(sizeof(LNode));
        s -> data = i;
        if (!link) {
            link = s; //对一个结点进行处理
        }else{
            r -> next = s;  //对其他结点进行处理
        }
        r = s; //r指向尾结点
        i --;
    }
    if (r) {
        r -> next = NULL;
    }
    return link;
}

int length_Linklist(LinkList link)
{
    LNode *p = link;
    int j = 0;
    while (p -> next) {
        p = p -> next;
        j ++;
    }
    return j;
    //时间算法复杂度为O（n）
}

int length_Linklist2(LinkList link)
{
    LNode *p = link;
    int j = 0;
    if (!p) {  // 空表的情况
        return 0;
    }
    j = 1;  //非空表的情况下，p所指的是第一个结点
    while (p -> next) {
        p = p -> next;
        j ++;
    }
    return j;
    //时间算法复杂度为O（n）
}

LNode *findNodeByIndex(NSInteger index, LinkList link)
{
    LNode *p = link;//在单链表中查找第i个元素结点。找到返回其指针，否则返回空
    NSInteger j = 1;
    while(p -> next && j < index){
        p = p -> next;
        j++;
    }
    if (j == index) {
        return p;
    }
    return NULL;
    //时间算法复杂度为O（n）
}

LNode *findNode(int s, LinkList link)
{
    LNode *p = link;
    while (p && p -> data != s) {
        p = p -> next;
    }
    return p;
    //时间算法复杂度为O（n）
}

int insert_Linklist(LinkList link, int i, int x)
{
    LNode *p, *s;
    p = findNode(i - 1, link);
    if (p == NULL) {
        printf("参数i错"); //不存在第i - 1个
        return 0;
    }else{
        s = malloc(sizeof(LNode)); //申请、装填结点
        s -> data = x;
        s -> next = p -> next; //新结点插入在第i - 1个结点后面
        p -> next = s;
        return 1;
    }
    //时间算法复杂度为O（n）
}

//insert p behind s
void insertIntoLinkList(LNode *s, LNode *p)
{
    s -> next = p -> next;
    p -> next = s;
    //两个指针操作顺序不能调换
    //时间算法复杂度为O（1）
}

//insert p in front s
void insertIntoLinkList2(LNode *s, LNode *p, LinkList link)
{
    LNode *temp = link;
    while(temp -> next != p){
        temp = temp -> next; // 找到*p的直接前驱
    }
    temp -> next = s;
    s -> next = p;
    //时间算法复杂度为O（n）
}

int delete(LinkList l, int i)
{
    LNode *p, *s;
    p = findNode(i - 1, l);
    if (!p) {
        printf("i - 1 not exist");
        return -1;
    }else{
        if (!p -> next) {
            printf("i not exist");
            return 0;
        }else{
            s = p -> next;
            p -> next = s -> next;
            free(s);
            return 1;
        }
    }
    //时间算法复杂度为O（n）
}

#pragma mark - 链实例
void reverse (LinkList H)
{
    LNode *p, *q;
    p = H -> next; /*p指向第一个数据结点*/
    H -> next = NULL; /*将原链表置为空表H*/
    while (p)
    {
        q = p;
        p = p -> next;
        q -> next = H -> next; /*将当前结点插到头结点的后面*/
        H -> next = q;
    }
    //该算法时间性能为O（n）
}

void pur_LinkList(LinkList H)
{
    LNode *p, *q, *r;
    p = H -> next; /*p指向第一个结点*/
    if(p == NULL) return;
    while (p -> next)
    {
        q = p;
        while (q -> next) /* 从*p的后继开始找重复结点*/
        {
            if (q -> next -> data == p -> data)
            {
                r = q -> next; /*找到重复结点，用r指向，删除*r */
                q -> next = r -> next;
                free(r);
            } /*if*/
            else {
                q = q -> next;
            }
        } /*while(q->next)*/
        p = p -> next; /*p指向下一个，继续*/
    }//该算法时间性能为O（n2）
} /*while(p->next)*/

LinkList merge(LinkList A,LinkList B)/*设A、B均为带头结点的单链表*/
{
    LinkList C;
    LNode *p, *q, *s;
    p = A -> next;
    q = B -> next;
    C = A; /*C表的头结点*/
    C -> next = NULL;
    free(B);
    while (p&&q){
        if (p->data<q->data){
            s = p;
            p = p -> next;
        }else{
            s = q;
            q = q -> next;
        } /*从原AB表上摘下较小者*/
        s -> next = C -> next; /*插入到C表的头部*/
        C -> next = s;
    } /*while */
    if (p == NULL){
        p = q;
    }
    while (p) /* 将剩余的结点一个个摘下，插入到C表的头部*/
    {
        s = p;
        p = p -> next;
        s -> next = C -> next;
        C -> next = s;
    }
    return C;
    //该算法时间性能为O（m+n）
}


#pragma mark - 顺序栈stack
#define MAXSIZE 1024
typedef struct{
    int data[MAXSIZE];
    int top;
}myStack;

myStack *initStack()
{
    myStack *stack;
    stack = malloc(sizeof(myStack));
    stack -> top = -1;
    return stack;
}

int isEmptyStack(myStack *stack)
{
    if (stack -> top == -1) {
        return 1;
    }
    return 0;
}

//入栈
int pushStack(myStack *stack, int x)
{
    if (stack -> top == MAXSIZE - 1) {
        return 0;// full stack, cannot push
    }
    stack -> top ++;
    stack -> data[stack -> top] = x;
    return 1;
}

//出栈
int popStack(myStack *stack, int *x)
{
    if(isEmptyStack(stack)){
        return 0; //empty stack
    }
    *x = stack -> data[stack -> top];
    stack -> top --;
    return 1;    //栈顶元素存入x，并返回s
    
}

//取栈顶元素
int topStack(myStack *stack)
{
    if (isEmptyStack(stack)) {
        return 0; //empty stack
    }
    return stack -> data[stack -> top];
}

#pragma mark - 链栈
typedef struct StackNode{
    int data;
    struct StackNode *next;
}StackNode, *LinkStack;

LinkStack initLinkStack()
{
    return NULL;
}

int IsEmptyLinkStack(LinkStack top)
{
    //    if(top == -1)
    //        return 1;
    return 0;
}

//入栈
LinkStack pushLinkStack(LinkStack top, int x)
{
    StackNode *s;
    s = malloc(sizeof(StackNode));
    s -> data = x;
    s -> next = top;
    top = s;
    return top;
}

//出栈
LinkStack popLinkStack(LinkStack top, int *x)
{
    StackNode *p;
    if (top == NULL) {
        return NULL;
    }
    *x = top -> data;
    p = top;
    top = top -> next;
    free(p);
    return top;
}

#pragma mark - 栈实例
//进制转换
typedef int datatype;
void conversion(int N, int r)
{
    myStack *s;
    datatype x;
    s = initStack();
    while (N) {
        pushStack(s, N % r);
        N = N / r;
    }
    while (!isEmptyStack(s)) {
        popStack(s, &x);
        printf("%d", x);
    }
    printf("\n");
}

//迷宫问题
typedef struct{
    int x, y;
}item;

typedef struct{
    int x;
    int y;
    int d;
}point;

typedef struct{
    point data[MAXSIZE];
    int top;
}Stack2;

Stack2 *initStack2()
{
    Stack2 *stack;
    stack = malloc(sizeof(Stack2));
    stack -> top = -1;
    return stack;
}

int isEmptyStack2(Stack2 *stack)
{
    if (stack -> top == -1) {
        return 1;
    }
    return 0;
}

//入栈
int pushStack2(Stack2 *stack, point x)
{
    if (stack -> top == MAXSIZE - 1) {
        return 0;// full stack, cannot push
    }
    stack -> top ++;
    stack -> data[stack -> top] = x;
    return 1;
}

//出栈
int popStack2(Stack2 *stack, point *x)
{
    if(isEmptyStack2(stack)){
        return 0; //empty stack
    }
    *x = stack -> data[stack -> top];
    stack -> top --;
    return 1;    //栈顶元素存入x，并返回s
}

//取栈顶元素
point topStack2(Stack2 *stack)
{
    //    if (isEmptyStack2(stack)) {
    //        return {0, 0, 0}; //empty stack
    //    }
    return stack -> data[stack -> top];
}

int path(int maze[8][10], item moving[])
{
    int m = 6;
    int n = 8;
    Stack2 *s;
    point temp;
    int x = 0, y = 0, d = 0, i, j;
    temp.x = 1;
    temp.y = 1;
    temp.d = -1;
    s = initStack2();
    pushStack2(s, temp);
    while (x < m || y < n) {
        temp = topStack2(s);
        x = temp.x;
        y = temp.y;
        while (d < 8) {
            i = moving[d].x + x;
            j = moving[d].y + y;
            if (maze[i][j] == 0) {
                maze[i][j] = -1;
                x = temp.x = i;
                y = temp.y = j;
                temp.d = d;
                pushStack2(s, temp);
                printf("%d, %d\n", temp.x, temp.y);
                if (x == m && y == n) {
                    return 1; /* 迷宫有路 */
                }
                break;
            }else{
                d++;
            }
            if (d == 8) {
                maze[x][y] = -1;
                popStack2(s, &temp);
            }
        }
        d = 0;
    }
    
    return 0; /* 迷宫无路 */
}

#pragma mark - 队列
#define MAXSIZE 1024 /*队列的最大容量*/
typedef struct {
    int data[MAXSIZE];
    int rear, front; /*队头队尾指针*/
}SeQueue;

#pragma mark - 顺序队列
typedef struct{
    int data[MAXSIZE]; /* data */
    int front, rear; /* 队头、队尾指针 */
    int num; /* 队中元素的个数 */
}c_SeQueue;

//置空队
c_SeQueue* initSeQueue()
{
    c_SeQueue *q = malloc(sizeof(c_SeQueue));
    q -> front = q -> rear = MAXSIZE - 1;
    q -> num = 0;
    return q;
}

int in_SeQueue(c_SeQueue *q, int x)
{
    if (q -> num == MAXSIZE) {
        printf("队满");
        return -1;
    }
    q -> rear = (q -> rear + 1) % MAXSIZE;
    q -> data[q -> rear] = x;
    q -> num ++;
    return 1;/* 入队完成 */
}

int out_SeQueue(c_SeQueue *q, int *x)
{
    if (q -> num == 0) {
        printf("队空");
        return -1;
    }
    /*
     * 队空时，front == -1，即指向第一个元素，
     * 也就是front不是第一个元素的地址
     */
    q -> front = (q -> front + 1) % MAXSIZE;
    *x = q -> data[q -> front]; /* 读出队头元素 */
    q -> num --;
    return 1; /* 出队完成 */
}

int isEmptySeQueue(c_SeQueue *q)
{
    if (q -> num == 0) {
        return 1;
    }
    return 0;
}

#pragma mark - 链队
typedef struct Qnode{
    int data;
    struct Qnode *next;
}LQNode; /* 链队结点的类型 */

typedef struct{
    LQNode *front, *rear;
}LQueue; /* 将头尾指针封装在一起的链队 */

//创建一个带头结点的空队：
LQueue *initLQueue()
{
    LQueue *q;
    LQNode *p;
    q = malloc(sizeof(LQueue));
    p = malloc(sizeof(LQNode));
    p -> next = NULL;
    q -> front = q -> rear = p;
    return q;
}

//入队
void inLQueue(LQueue *q, int x)
{
    LQNode *p;
    p = malloc(sizeof(LQNode));
    p -> data = x;
    p -> next = NULL;
    q -> rear -> next = p; /* 先指明最后一个元素的下一个元素是新结点 */
    q -> rear = p; /* 再将新结点设为队尾 */
}

//判队空
int isEmptyLQueue(LQueue *q)
{
    if (q -> front == q -> rear) {
        return 1;
    }
    return 0;
}

//出队
int OutLQueue(LQueue *q, int *x)
{
    LQNode *p;
    if (isEmptyLQueue(q)) {
        printf("队空");
        return 0;
    }
    p = q -> front -> next;
    q -> front -> next = p -> next;/* 移动front指针后还需支出front后继指针 */
    *x = p -> data;
    free(p);
    
    //自己写的出队语句，没有释放动作不是很好
    //    *x = q -> front -> next -> data;
    //    q -> front = q -> front -> next;
    
    if (q -> front -> next == NULL) {
        q -> rear = q -> front; /* 只有一个元素时，出队后队空，此时还要修改队尾指针 */
    }
    return 1;
}

#pragma mark - queue example
typedef struct
{
    int x, y;
    int pre;
}sqtype;

int pp(sqtype sq[], int rear)
{
    int i = rear;
    do {
        printf("(%d, %d)", sq[i].x, sq[i].y);
        i = sq[i].pre; /* 从出口一点一点往回倒到起点 */
    } while (i != -1);
    printf("\n");
    printf("\n");
    return 0;
}

int queuePath(int maze[8][10], item moving[])
{
    int m = 6, n = 8;
    sqtype sq[8 * 10];
    int front, rear;
    int x, y, i, j;
    front = rear = 0;
    sq[0].x = 1;
    sq[0].y = 1;
    sq[0].pre = -1; /* 入口点入队 */
    maze[1][1] = -1;
    while (front <= rear) { /* 队列不空 */
        x = sq[front].x;
        y = sq[front].y;
        for (int d = 0; d < 8; d++) {
            i = x + moving[d].x;
            j = y + moving[d].y;
            if (maze[i][j] == 0) {
                rear ++;
                sq[rear].x = i;
                sq[rear].y = j;
                sq[rear].pre = front;
                maze[i][j] = -1;
            }
            if (i == m && j == n) {
                pp(sq, rear); /* rear 指向迷宫的出口 */
                return 1;
            }
        }
        front ++;
    }
    return 0;
}


#pragma mark - 二叉树
#define MAXNODE 100/*二叉树的最大结点数*/
typedef int SqBiTree[MAXNODE]; /*0 号单元存放根结点*/
//SqBiTree bt;
//即将bt定义为含有MAXNODE个int类型元素的一维数组。

//链二叉树
typedef struct BiTNode{
    int data;
    struct BiTNode *lChild, *rChild; /*左右孩子指针*/
}BiTNode, *BiTree; //即将BiTree定义为指向二叉链表结点结构的指针类型

int initiate(BiTree bt)
{
    /* 初始化建立二叉树bt的头结点 */
    if ((bt = malloc(sizeof(BiTNode))) == NULL) {
        return 0;
    }
    bt -> lChild = NULL;
    bt -> rChild = NULL;
    return 1;
}

BiTree creatTree(int x,BiTree lbt,BiTree rbt)
{
    /* 生成一棵以x为根结点得数据域值以lbt和rbt为左右子树的二叉树 */
    BiTree p;
    if ((p = malloc(sizeof(BiTNode))) == NULL) {
        return NULL;
    }
    p -> data = x;
    p -> lChild = lbt;
    p -> rChild = rbt;
    return p;
}

BiTree InsertL(BiTree bt, int x, BiTree parent)
{
    /* 在二叉树bt的结点parent的左子树插入结点数据元素 */
    BiTree p;
    if (parent == NULL) {
        printf("\n insert wrong... \n");
        return NULL;
    }
    if ((p = malloc(sizeof(BiTNode))) == NULL) {
        return NULL;
    }
    p -> data = x;
    p -> lChild = NULL;
    p -> rChild = NULL;
    if (parent -> lChild == NULL) {
        parent -> lChild = p;
    }else{
        p -> lChild = parent -> lChild;
        parent -> lChild = p;
    }
    return bt;
}

BiTree DeleteL(BiTree bt, BiTree parent)
{
    /* 在二叉树bt中删除结点parent的左子树 */
    BiTree p;
    if (parent == NULL || parent -> lChild == NULL) {
        printf("\n delete wrong... \n");
        return NULL;
    }
    p = parent -> lChild;
    parent -> lChild = NULL;
    free(p);
    /*
     当p为非叶子结点时，这样删除仅释放了所删除子树根结点得空间，
     若要删除子树分支中的结点，需用后面介绍的遍历操作来实现。
     */
    return bt;
}

void Visit(int data)
{
    
}

void preOrder(BiTree bt)
{
    /* 先序遍历二叉树bt */
    if (bt == NULL) {
        return;
    }
    Visit(bt -> data);
    preOrder(bt -> lChild);
    preOrder(bt -> rChild);
}

void InOrder(BiTree bt)
{
    if (bt == NULL) {
        return;
    }
    InOrder(bt -> lChild);
    Visit(bt -> data);
    InOrder(bt -> rChild);
}

void PostOrder(BiTree bt)
{
    if (bt == NULL) {
        return;
    }
    PostOrder(bt -> lChild);
    PostOrder(bt -> rChild);
    //    Visit(bt -> data);
}

void levelOrder(BiTree bt)
{
    /* 层次遍历二叉树 */
    /*
     在本算法中，二叉树以二叉链表存放，一维数组Queue[MAXNODE]用以实现队列，变量front和rear分别表示队首元素和队尾元素在数组中的位置。
     */
    BiTree queue[MAXNODE];
    int front, rear;
    if (bt == NULL) {
        return ;
    }
    front = -1;
    rear = 0;
    queue[rear] = bt;
    while (front != rear) {
        front ++;
        //        Visit(queue[front] -> data);
        if (queue[front] -> lChild) {
            rear++;
            queue[rear] = queue[front] -> lChild;
        }
        if (queue[rear] -> rChild) {
            rear++;
            queue[rear] = queue[front] -> rChild;
        }
    }
}

//1）先序遍历的非递归实现
void NRPreOrder(BiTree bt)
{
    BiTree stack[MAXNODE], p;
    int top;
    if (!bt) {
        return;
    }
    top = 0;
    p = bt;
    while (!(p == NULL && top == 0)) {
        
        while(p){
            Visit(stack[top] -> data);
            if (top < MAXNODE - 1) { /* 将当前指针压栈 */
                stack[top] = p;
                top ++;
            }else{
                printf("溢出");
                return;
            }
            p = p -> lChild;
        }
        
        if (top <= 0) {
            return;
        }
        top --;
        p = stack[top]; /* 从栈中弹出栈顶元素 */
        p = p -> rChild; /*   并指向右子树   */
        
        /*
         继续外部循环，到内部循环时，若右子树不存在，
         则再返回栈顶子树的右子树，不断循环直到结束。
         */
        
    }
}

typedef struct {
    BiTree link;
    int flag;
}stacktype;

/*非递归后序遍历二叉树bt*/
void NRPostOrder(BiTree bt)
{
    stacktype stack[MAXNODE];
    BiTree p;
    int top,sign;
    if (bt == NULL){
        return;
    }
    top = -1;/*栈顶位置初始化*/
    p = bt;
    
    while (!(p == NULL && top == -1)){
        
        /*结点第一次进栈*/
        if (p != NULL) {
            top ++;
            stack[top].link = p;
            stack[top].flag = 1;
            p = p -> lChild; /*找该结点的左孩子*/
        } else {
            p = stack[top].link;
            sign = stack[top].flag;
            top --;
            
            /*结点第二次进栈*/
            if (sign == 1) {
                top ++;
                stack[top].link = p;
                stack[top].flag = 2; /*标记第二次出栈*/
                p = p -> rChild;
            } else {
                Visit(p->data); /*访问该结点数据域值*/
            }
        }
    }
}

void PreInOd(char preOd[], char inOd[], int i, int j, int k, int h, BiTree t)
{
    t = (BiTNode *)malloc(sizeof(BiTNode));
    t -> data = preOd[i];
    int m = k;
    while (inOd[m] != preOd[i]) {
        m++;
    }
    
    if (m == k) {
        t -> lChild = NULL;
    }else{
        PreInOd(preOd, inOd, i + 1, i + m - k, k, m - 1, t -> lChild);
    }
    if (m == h) {
        t -> rChild = NULL;
    }else{
        PreInOd(preOd, inOd, i + m - k + 1, j, m + 1, h, t -> rChild);
    }
}

/* 由先序序列和中序序列求唯一的二叉树 */
void ReBiTree(char preOd[], char inOd[], int n, BiTree root)
{
    /* n为二叉树的结点个数，root为二叉树根结点的存储地址 */
    if (n <= 0) {
        root = NULL;
    }else{
        PreInOd(preOd, inOd, 0, n - 1, 0, n - 1, root);
    }
}

#pragma mark - 线索二叉树
typedef char elemtype;
typedef struct thrNode{
    elemtype data;
    struct thrNode *lChild, *rChild;
    unsigned lTag:1;
    unsigned rTag:1;
}BiThrNode, *BiThrTree;

BiThrNode *pre;
void InThreading();

//1.建立一棵中序线索二叉树
int InOrderThr(BiThrTree *head, BiThrTree T)
{
    /* 中序遍历二叉树T，并将其中序线索化，*head指向头结点 */
    if(!(*head = malloc(sizeof(BiThrNode)))){
        return 0;
    }
    (*head) -> lTag = 0;
    (*head) -> rTag = 1;          /*        建立头结点       */
    (*head) -> rChild = *head;     /*        右指针回指       */
    if (!T) {
        (*head) -> lChild = *head; /* 若二叉树为空，则左指针回指 */
    }else{
        (*head) -> lChild = T;
        pre = *head;
        InThreading(T);        /*   中序遍历进行中序线索化  */
        pre -> rChild = *head;  /*    最后一个结点线索化    */
        pre -> rTag = 1;
        (*head) -> rChild = pre;
    }
    return 1;
}

void InThreading(BiThrTree p)
{
    if(p){                         /* 中序遍历进行中序线索化 */
        InThreading(p -> lChild); /*      左子树线索化    */
        if (!p -> lChild) {       /*        前驱线索     */
            p -> lTag = 1;
            p -> lChild = pre;
        }
        if (!pre -> rChild) {     /*       后继线索     */
            pre -> rTag = 1;
            pre -> rChild = p;
        }
        pre = p;
        InThreading(p -> rChild); /*     右子树线索化    */
    }
}

//在中序线索二叉树上寻找结点p的中序前驱结点的算法如下：
BiThrNode inPreNode(BiThrNode *p)
{
    BiThrNode *pre;
    pre = p -> lChild;
    if (p -> lTag != 1) {
        while (pre -> rTag == 0) {
            pre = pre -> rChild;
        }
    }
    return *pre;
}

//在中序线索二叉树上寻找结点p的中序后继结点
BiThrNode* inPostNode(BiThrNode *p)
{
    BiThrNode *post;
    post = p -> rChild;
    if (p -> rTag != 1) {
        if (post) {
            while (post -> lTag == 0) {
                post = post -> lChild;
            }
        }
    }
    return post;
}

//在中序线索二叉树上寻找结点p的先序后继结点的算法如下：
BiThrNode IPrePostNode(BiThrTree head, BiThrNode *p)
{
    /* 在中序线索二叉树上寻找结点p的先序和后继结点，head为线索树的头结点 */
    BiThrNode *post;
    if (p -> lTag == 0) {
        post = p -> lChild;
    }else{
        post = p;
        while (post -> rTag == 1 && post -> rChild != head) {
            post = post -> rChild;
        }
        post = post -> rChild;
    }
    return *post;
}

//在中序线索二叉树上寻找结点p 的后序前驱结点的算法如下：
BiThrNode* IPostPretNode(BiThrNode* head, BiThrNode *p)
{
    /*在中序线索二叉树上寻找结点p 的先序的后继结点，head 为线索树的头结点*/
    BiThrNode *post;
    BiThrNode *pre;
    if (p -> rTag == 0){
        pre = p -> rChild;
    }else {
        pre = p;
        while (pre -> lTag == 1 && post -> rChild != head) {
            pre = pre -> lChild;
        }
        pre = pre -> lChild;
    }
    return pre;
}

/* 在以head为头结点的中序线索二叉树中查找值为x的结点 */
BiThrNode Search(BiThrTree head, elemtype x)
{
    BiThrNode *p;
    if (head -> lTag == 0) {
        p = head -> lChild;
    }
    while (p -> lTag == 0 && p != head) {
        p = p -> lChild;
    }
    while (p != head && p -> data != x) {
        p = inPostNode(p);
    }
    if (p == head) {
        printf("Not Found \n");
    }
    return *p;
}

/* 在bt为根结点指针的二叉树中查找数据元素 */
BiTNode* search(BiTree bt, int x)
{
    if (bt -> data == x) {
        /* 查找成功，返回 */
        return bt;
    }
    if (bt -> lChild != NULL) {
        /* 在bt -> lChild为根结点指针的二叉树中查找数据元素 */
        return search(bt -> lChild, x);
    }
    if (bt -> rChild != NULL) {
        /* 在bt -> rChild为根结点指针的二叉树中查找数据元素 */
        return search(bt -> rChild, x);
    }
    return NULL;
}

void InsertThrRight(BiThrTree s,BiThrTree p)
{
    /*在中序线索二叉树中插入结点p 使其成为结点s 的右孩子*/
    BiThrTree w;
    p -> rChild = s -> rChild;
    p -> rTag = s -> rTag;
    p -> lChild = s;
    p -> lTag = 1; /*将s 变为p 的中序前驱*/
    s -> rChild = p;
    s -> rTag = 0; /*p 成为s 的右孩子*/
    if(p -> rTag == 0) /*当s 原来右子树不空时，找到s 的后继w，变w 为p 的后继，p 为w 的前驱*/
    {
        w = inPostNode(p);
        w -> lChild = p;
    }
}

/* 顺序结构情况下：统计给定二叉树叶子结点的数目 */
int countLeaf1(SqBiTree bt, int k)
{
    /* 一位数组bt[2k - 1]为二叉树存储结构，k为二叉树深度，函数值为叶子数,结点总数为2的k次方-1 */
    int total = 0;
    int num = 1;
    for (int i = 1; i < k; i++) {
        num = 2 * num;
    }
    for (int i = 1; i < num - 1; i ++) {
        if (bt[i] != 0) {
            if ((bt[2 * i] == 0 && bt[2 * i + 1] == 0) || i > (num - 1) / 2) {
                total ++;
            }
        }
    }
    return total;
}

/* 二叉链表存储结构情况下：统计给定二叉树叶子结点的数目 */
int countLeaf2(BiTree bt)
{
    /* 开始时，bt为根结点所在链结点的指针，返回值为bt的叶子数 */
    if (bt == NULL) {
        return 0;
    }
    if (bt -> lChild == NULL && bt -> rChild == NULL) {
        return 1;
    }
    return (countLeaf2(bt -> lChild) + countLeaf2(bt -> rChild));
}

#pragma mark - main
int main(int argc, const char * argv[])
{
    @autoreleasepool {
        // insert code here...
        
        //        LinkList l = creatLinkList();
        //        //       LinkList *l = creatLinkList2();
        //        int j = 0;
        //        //        j = length_Linklist(l);
        //        j = length_Linklist2(l);
        //
        //        NSLog(@"%d" ,j);
        //        LNode *node = malloc(sizeof(LNode));
        //        node -> data = 444;
        //        LNode *p = l;
        //        p = p -> next;
        //        insertIntoLinkList2(node, p, l);
        //        NSLog(@"%d", length_Linklist2(l));
        //        insert_Linklist(l, 3, 333);
        //        NSLog(@"%d", length_Linklist2(l));
        
        //        //stack
        //        LinkStack linkS = initLinkStack();
        //        linkS -> next = NULL;
        
        //mystack
        //        myStack *myS = initStack();
        //        conversion(3443, 8);
        
        //        item moving[8] = {
        //            { 1,  0},
        //            { 1,  1},
        //            { 0,  1},
        //            { 1, -1},
        //            {-1,  0},
        //            {-1, -1},
        //            { 0, -1},
        //            {-1,  1},
        //        };
        
        /*
         item moving[8] = {
         {0, 1},
         {1, 1},
         {1, 0},
         {1, -1},
         {0, -1},
         {-1, -1},
         {-1, 0},
         {-1, 1},
         };
         int maze[8][10] = {
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 0, 1, 1, 1, 0, 1, 1, 1, 1},
         {1, 1, 0, 1, 0, 1, 1, 1, 1, 1},
         {1, 0, 1, 0, 0, 1, 1, 1, 1, 1},
         {1, 0, 1, 1, 1, 0, 0, 1, 1, 1},
         {1, 1, 0, 0, 1, 1, 0, 0, 0, 1},
         {1, 0, 1, 1, 0, 0, 1, 1, 0, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         };
         path(maze, moving);
         
         //还原迷宫
         for (int i = 0; i < 6; i ++) {
         for (int j = 0; j < 8; j++) {
         if (maze[i][j] == -1) {
         maze[i][j] = 0;
         }
         printf("% 2d ", maze[i][j]);
         }
         printf("\n");
         }
         
         queuePath(maze, moving);
         */
        
        //tree
        //        SqBiTree tree = {1,2};
        //        SqBiTree bt = {3,4};
        //        printf("%d \n", bt[0]);
        //        printf("%d \n", tree[1]);
        
        //        //queue
        //        c_SeQueue *q = initSeQueue();
        //        int outNum = 0;
        //        in_SeQueue(q, 2);
        //        in_SeQueue(q, 3);
        //        in_SeQueue(q, 4);
        //        out_SeQueue(q, &outNum);
        //        printf("%d \n", outNum);
        //        out_SeQueue(q, &outNum);
        //        printf("%d \n", outNum);
        
        //        LQueue *q = initLQueue();
        //        int outNum = 0;
        //        inLQueue(q, 2);
        //        inLQueue(q, 3);
        //        inLQueue(q, 4);
        //        OutLQueue(q, &outNum);
        //        printf("%d \n", outNum);
        //        OutLQueue(q, &outNum);
        //        printf("%d \n", outNum);
        
        
        /*
         //代码右问题
         BiTree bt;
         //        initiate(bt);
         char preOd[9] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'};
         char inOd[9] = {'B', 'C', 'A', 'E', 'D', 'G', 'H', 'F', 'I'};
         ReBiTree(preOd, inOd, 9, bt);
         //        printf("%d", bt -> data);
         */
        BiThrTree head;
        head = (BiThrNode *)malloc(sizeof(BiThrNode));
        head -> data = 'A';
        BiThrNode *l = (BiThrNode *)malloc(sizeof(BiThrNode));
        l -> data = 'B';
        BiThrNode *r = (BiThrNode *)malloc(sizeof(BiThrNode));
        r -> data = 'C';
        head -> lChild = l;
//        head -> rChild = r;
        BiThrTree new;
        InOrderThr(&new, head);
//        InsertThrRight(head, r);
        elemtype myChar = 'C';
        BiThrNode found = Search(new, myChar);
        printf("%c ---- \n", found.data);
    }
    return 0;
}
