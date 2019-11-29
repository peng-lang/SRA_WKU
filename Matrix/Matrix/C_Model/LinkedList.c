//
//  LinkedList.c
//  Matrix
//
//  Created by Wendell Wang on 2019/11/27.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//

#include "LinkedList.h"

void *my_malloc(size_t size) {
    void *new_place = malloc(size);
    if (new_place == NULL) {
        printf("Error: malloc failed in %s\n", __FUNCTION__);
        exit(EXIT_FAILURE);
    }
    return new_place;
}

struct Node {
    ElementType Element;
    Position Next;
};

/* create a empty list */
LinkedList CreateEmptyList(void) {
    LinkedList new_list = my_malloc(sizeof(struct Node));
    new_list -> Element = 0;
    new_list -> Next = NULL;
    return new_list;
}

/* return true if L is empty */
int IsEmpty(LinkedList L) {
    return L -> Next == NULL;
}

/* return true if P is the last positiono in list L*/
/* parameter L is unused in this implementation */
int IsLast(Position P, LinkedList L) {
    return P -> Next == NULL;
}

/* return Position of X in L; NULL if not found */
Position Find(ElementType X, LinkedList L) {
    Position P;
    
    P = L -> Next;
    while (P != NULL && P -> Element != X) {
        P = P -> Next;
    }
    return P;
}

/* if X is not found, then next field of returned */
/* Position is NULL */
Position FindPrevious(ElementType X, LinkedList L) {
    Position P;
    
    P = L;
    while (P -> Next != NULL && P -> Next -> Element != X) {
        P = P -> Next;
    }
    return P;
}

/* delete first occurrence of X from a list */
void Delete(ElementType X, LinkedList L) {
    Position P, TmpCell;
    
    P = FindPrevious(X, L);
    
    if (!IsLast(P, L)) {
        TmpCell = P -> Next;
        P -> Next = TmpCell -> Next;
        free(TmpCell);
    }
}

/* insert after position P */
void Insert(ElementType X, LinkedList L, Position P) {
    Position TmpCell;
    
    TmpCell = my_malloc(sizeof(struct Node));
    TmpCell -> Element = X;
    TmpCell -> Next = P -> Next;
    P -> Next = TmpCell;
}

/* delete a list */
void DeleteList(LinkedList L) {
    Position P, Tmp;
    
    P = L -> Next;
    L -> Next = NULL;
    while (P != NULL) {
        Tmp = P -> Next;
        free(P);
        P = Tmp;
    }
}

/* Insert a node at the end */
void append(ElementType X, LinkedList L) {
    Position P = L;
    while (P -> Next != NULL) {
        P = P -> Next;
    }
    
    LinkedList new_list = my_malloc(sizeof(struct Node));
    new_list -> Element = X;
    P -> Next = new_list;
}

/* Insert a list at the end */
void appendList(LinkedList X, LinkedList L) {
    Position P = L;
    while (P -> Next != NULL) {
        P = P -> Next;
    }
    P -> Next = X;
}

/* get value from position P*/
ElementType Retrieve(Position P) {
    return P -> Element;
}

LinkedList NextNode(LinkedList L) {
    return L -> Next;
}

ElementType ElementOfNode(LinkedList L) {
    return L -> Element;
}
 
