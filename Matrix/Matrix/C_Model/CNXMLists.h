//
//  CNXMLists.h
//  Matrix
//
//  Created by Wendell Wang on 2019/11/28.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//

#ifndef CNXMLists_h
#define CNXMLists_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include "LinkedList.h"
#include "CReal.h"

struct CNXMLists;
typedef struct CNXMLists *Ptr2Matrix;
typedef Ptr2Matrix Matrix;
typedef Ptr2Matrix Row;
typedef Ptr2Matrix Entry;
typedef Matrix CMatrix;

Row m_initRow(ElementType list[], int length);
Entry m_blankEntry_sub(CReal real);
Entry m_blankEntry(ElementType numerator, ElementType denomiator);

//int m_rowsNumber(Matrix matrix);
//int m_colsNumber(Matrix matrix);

//void m_forceEqualedRows(Matrix matrix);
/// TODO: this function will be deleted in the future
Matrix m_swapRows(int first, int second, Matrix matrix);
/// TODO: this function will be renamed as m_swapRows in the futrue
Matrix swapNodePointer(Matrix matrix, int x, int y);
//void m_append(Row row, Matrix matrix);
//void m_appendlist(ElementType list[], int length, Matrix matrix);

//Row m_findRowAt(int index, Matrix matrix);

//void m_row2Opposite(int index, Matrix matrix);
//void m_rowMultiply(int index, CReal cof, Matrix matrix);
//void m_rowDivide(int index, CReal cof, Matrix matrix);
//void m_rowPlus(int first, int second, CReal cof, Matrix matrix);
//void m_rowMinus(int first, int second, CReal cof, Matrix matrix);

//CReal m_findFirstNonzeroNum(Row row);
//int m_findIndexOfNonzeroNum(Row row);
//int m_checkIfNoneZeroRow(int index, Matrix matrix);
//Entry m_findEntryAt(int i, int j, Matrix matrix);
//CReal m_findEntryAt_v(int i, int j, Matrix matrix);

//void m_simplifyRows(int index, Matrix matrix);
void m_conert2UTMatrix(int ifForceCal, Matrix matrix);
void m_convert2ReducedForm(int ifForCal, Matrix matrix);

void m_printFormattedMatrix(Matrix matrix);
Matrix getInput(void);

#endif /* CNXMLists_h */
