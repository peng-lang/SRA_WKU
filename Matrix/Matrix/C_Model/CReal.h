//
//  CReal.h
//  Matrix
//
//  Created by Wendell Wang on 2019/11/28.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//

#ifndef CReal_h
#define CReal_h

#include <stdio.h>
#include <stdlib.h>

#define ElementType int

struct My_Real {
    ElementType numerator;
    ElementType denomiator;
    double value;
};

typedef struct My_Real Real;
typedef Real CReal;
void cr_printFV(CReal x);
CReal cr_init(ElementType numerator, ElementType denomiator);
CReal cr_abs(CReal x);
CReal cr_opposite(CReal x);
CReal cr_negative(CReal x);
CReal cr_reciprocal(CReal x);
CReal cr_plus(CReal x, CReal y);
CReal cr_minus(CReal x, CReal y);
CReal cr_multiply(CReal x, CReal y);
CReal cr_divide(CReal x, CReal y);


#endif /* CReal_h */
