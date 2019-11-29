//
//  LinkedList.h
//  Matrix
//
//  Created by Wendell Wang on 2019/11/27.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//

#ifndef LinkedList_h
#define LinkedList_h

#include <stdio.h>
#include <stdlib.h>

#define ElementType int

struct Node;
typedef struct Node *Ptr2Node;
typedef Ptr2Node LinkedList;
typedef Ptr2Node Position;
LinkedList CreateEmptyList(void);
//LinkedList MakeEmpty(LinkedList L);
int IsEmpty(LinkedList L);
int IsLast(Position P, LinkedList L);
Position Find(ElementType X, LinkedList L);
void Delete(ElementType X, LinkedList L);
Position FindPrevious(ElementType X, LinkedList L);
void Insert(ElementType X, LinkedList L, Position P);
void append(ElementType X, LinkedList L);
void appendList(LinkedList X, LinkedList L);
void DeleteList(LinkedList L);
ElementType Retrieve(Position P);

ElementType ElementOfNode(LinkedList L);
LinkedList NextNode(LinkedList L);

#endif /* LinkedList_h */
