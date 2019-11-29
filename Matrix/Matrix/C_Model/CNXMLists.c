//
//  CNXMLists.c
//  Matrix
//
//  Created by Wendell Wang on 2019/11/28.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//

#include "CNXMLists.h"

struct CNXMLists {
    CReal element;
    struct CNXMLists *right;
    struct CNXMLists *down;
};

Row m_initRow(ElementType list[], int length) {
    Row row = m_blankEntry(0, 1);
    Entry entry = row;
    for(int i = 0; i < length; i++) {
        entry -> element = cr_init(list[i], 1);
        entry = entry -> right;
    }
    entry = row;
    row = row ->right;
    free(entry);
    return row;
}

/// initialize a black entry
Entry m_blankEntry_sub(CReal real) {
    Entry newEntry = malloc(sizeof(struct CNXMLists));
    if (newEntry == NULL) {
        printf("");
        exit(EXIT_FAILURE);
    }
    newEntry -> element = real;
    newEntry -> right = NULL;
    newEntry -> down = NULL;
    
    return newEntry;
}

/// initialize a black entry
Entry m_blankEntry(ElementType numerator, ElementType denomiator) {
    return m_blankEntry_sub(cr_init(numerator, denomiator));
}

int m_rowsNumber(Matrix matrix) {
    Row row = matrix;
    int rowNumber = 1;
    while (row -> down != NULL) {
        row = row -> down;
        rowNumber++;
    }
    return rowNumber;
}

/// return the number of columns of the matrix
/// and also, it can be consider as the max lengh of a row, if these rows are different
int m_colsNumber(Matrix matrix) {
    int maxLength = 0;
    Row row = matrix;
    Entry entry = row;
    while (row != NULL) {
        int tmp = 0;
        while (entry != NULL) {
            entry = entry -> right;
            tmp++;
        }
        if (tmp > maxLength)
            maxLength = tmp;
        row = row -> down;
        entry = row;
    }
    return maxLength;
}

/// if the rows of the matrix are not equal to each other,  make all of the rows have the same length as the longest row,
/// by appending zero entry for the rows
void m_forceEqualedRows(Matrix matrix) {
    int maxLength = m_colsNumber(matrix);
    Row row = matrix;
    Entry entry = row;
    Entry prentry = NULL;
    
    int rowNum = 0;
    while (row != NULL) {
        for (int i = 0; i < maxLength - 1; i++) {
            if (entry -> right == NULL) {
                Entry newEntry = m_blankEntry(0, 1);
                entry -> right = newEntry;
                if (rowNum != 0)
                    prentry -> right -> down = newEntry;
            }
            if (rowNum != 0)
                 prentry = prentry -> right;
            entry = entry -> right;
        }
        prentry = row;
        row = row-> down;
        entry = row;
        rowNum++;
    }
}

/// second must greater than first!!!
Matrix m_swapRows(int first, int second, Matrix matrix) {
    int rows = m_rowsNumber(matrix);
    if (first > rows - 1 || second > rows - 1 || first < 0 || second < 0) {
        printf("the index is too big, first: %d, second: %d\n", first, second);
        exit(EXIT_FAILURE);
    }
    if (first == second) return matrix;
    if (first > second) {
        printf("second must geater than second, first: %d, second: %d\n", first, second);
        exit(EXIT_FAILURE);
    }
    // init a temporary header
    Row header = m_blankEntry(0, 1);
    header -> down = matrix;
    
    Row beforef = header;
    Row firstRow = NULL;
    Row befores = NULL;
    Row secondRow = NULL;
    
    Row ptr = matrix;
    for (int i = 0; i <= second && (firstRow == NULL || secondRow == NULL); i++) {
        if (i == first - 1) beforef = ptr;
        if (i == first) firstRow = ptr;
        if (i == second - 1) {
            befores = ptr;
            secondRow = ptr -> down;
        }
        
    }
    
    /// Consideration:
    /// for matrix, it seems not use to let every entries pointer another entry below,
    /// so here, I do not let every entry points the down entry.
    // before should point the "up" of firstRow, and then the firstRow point
    // the "down" entry of second row, and secondRow should point to before
    if (abs(second - first) == 1) {
        beforef -> down = secondRow;
        firstRow -> down = secondRow -> down;
        secondRow -> down = firstRow;
    } else {
        Row afters = secondRow -> down;
        beforef -> down = secondRow;
        befores -> down = firstRow;
        secondRow -> down = firstRow -> down;
        firstRow -> down = afters;
    }
    // remember to free header
    matrix = header -> down;
    free(header);
    return matrix;
}

/// Adds new rpw add the end of matrix
/// - Parameter row: The row to append to the matrix
void m_append(Row row, Matrix matrix) {
    Row ptr = matrix;
    while (ptr -> down != NULL)
        ptr = ptr -> down;
    ptr -> down = row;
}

/// Adds new rpw add the end of matrix
/// - Parameter list: The int array to append to the matrix
void m_appemdlist(ElementType list[], int length, Matrix matrix) {
    // row is just a header, so it need to free at the end of the function
    Row row = m_blankEntry(0, 1);
    Entry entry = row;
    for (int i = 0; i < length; i++) {
        entry -> right = m_blankEntry(list[0], 1);
        entry = entry -> right;
    }
    free(row);
}

/// this function do not make sure that index is less than the count of cols
Row m_findRowAt(int index, Matrix matrix) {
    Row row = matrix;
    for (int i = 0; i < index; i++)
        row = row -> down;
    return row;
}

/// make every entry to its opposite number for row index
void m_row2Opposite(int index, Matrix matrix) {
    Row row = m_findRowAt(index, matrix);
    
    // make all entries in the row to opposite number
    while (row != NULL) {
        row -> element = cr_opposite((row -> element));
        row = row -> right;
    }
}

void m_rowMultiply(int index, CReal cof, Matrix matrix) {
    Row row = m_findRowAt(index, matrix);
    
    while (row != NULL) {
        row -> element = cr_multiply(row -> element, cof);
        row = row -> right;
    }
}

void m_rowDivide(int index, CReal cof, Matrix matrix) {
    return m_rowMultiply(index, cr_reciprocal(cof), matrix);
}

void m_rowPlus(int first, int second, CReal cof, Matrix matrix) {
    if (first == second) return;
    
    m_rowMultiply(second, cof, matrix);
    
    Row firstRow = m_findRowAt(first, matrix);
    Row secondRow = m_findRowAt(second, matrix);
    
    while (firstRow != NULL) {
        firstRow -> element = cr_plus(firstRow -> element, secondRow -> element);
        firstRow = firstRow -> right;
        secondRow = secondRow -> right;
    }
    // recover secondRow
    m_rowDivide(second, cof, matrix); // FIXME: this is not efficient
}

void m_rowMinus(int first, int second, CReal cof, Matrix matrix) {
    return m_rowPlus(first, second, cr_opposite(cof), matrix);
}

CReal m_findFirstNonzeroNum(Row row) {
    Row ptr = row;
    while (ptr != NULL) {
        if ((ptr -> element).numerator != 0)
            return ptr -> element;
        ptr = ptr -> right;
    }
    return cr_init(0, 1);
}

int m_findIndexOfNonzeroNum(Row row) {
    int index = 0;
    Row ptr = row;
    while (ptr != NULL) {
        if ((ptr -> element).numerator != 0)
            return index;
        ptr = ptr -> right;
        index++;
    }
    return index;
}

int m_checkIfNoneZeroRow(int index, Matrix matrix) {
    Row row = m_findRowAt(index, matrix);
    
    while (row != NULL) {
        if ((row -> element).numerator != 0)
            return 1;
        row = row -> right;
    }
    return 0;
}

Entry m_findEntryAt(int i, int j, Matrix matrix) {
    Row row = matrix;
    Entry entry;
    for(int a = 0; a < i; a++)
        row = row -> down;
    entry = row;
    for(int a = 0; a < j; a++)
        entry = entry -> right;
    return entry;
}

CReal m_findEntryAt_v(int i, int j, Matrix matrix) {
    return m_findEntryAt(i, j, matrix) -> element;
}

/// Make the pivot entry to 1, by deviding each item with the pivot entry
///
/// for example, with this method:
///
///     [3,1,2,0]  -> [1,1/3,2/3,0]
///     //[3,1,2,0] will become [1,1/3,2/3,0]
///
/// - Parameter i: index of the row in the matrix
void m_simplifyRows(int index, Matrix matrix) {
    Row row = m_findRowAt(index, matrix);
    CReal real = m_findFirstNonzeroNum(row);
    if (real.numerator == 0)
        return;
    m_rowDivide(index, real, matrix);
    row = row -> right;
}

/// convert the matrix to unpper triangle matrix
/// - Parameter ifForceCal: if true, then force to make all of the rows have the same length as the longest row,
/// by appending zero entry for the rows
void m_conert2UTMatrix(int ifForceCal, Matrix matrix) {
    if (ifForceCal){
        // then force to make all of the rows have the same length as the longest row,
        // by appending zero entry for thne rows
        m_forceEqualedRows(matrix);
    }
    // Converts to UT matrix
    int cols = m_colsNumber(matrix);
    int rows = m_rowsNumber(matrix);
    // the "start" variable is to indicate the pivot entry of a row
    for(int i = 0, start = 0; i < cols && i < rows; i++) {
        int hasFound = 0;
        // Put the main row to the i-th row
        for(int j = start; j < rows; j++) {
            if (m_findEntryAt_v(j, i, matrix).numerator != 0) {
//                matrix = m_swapRows(start, j, matrix);
                matrix = swapNodePointer(matrix, start, j);
                hasFound = 1;
                break;
            }
        }
        // if not find the nonzero entry, go to the next loop
        // it exits, for example, the matrix: [[1, 0, 1], [0, 0, 1]]
        // the second row is blank(all entries are 0 entry)
        if (!hasFound) {
            continue;
        }
        // Then reduce the row from 0 to start(make the first nonzero entry to one)
//        m_printFormattedMatrix(matrix);
        m_simplifyRows(start, matrix);
        
        // for the rows below i-th row, cancels the i-th entry
        for(int j = start + 1; j < rows; j++) {
            if (m_findEntryAt_v(j, i, matrix).numerator == 0) {
                continue;
            }
            CReal num = m_findEntryAt_v(j, i, matrix);
            m_rowMinus(j, i, num, matrix);
        }
        start++;
    }
    // and the matrix had also been arranged
}

/// convert the matrix to reduced row echelon form matrix by Gaussian Elimination
/// - Parameter ifForceCel: if true, then force to make all of the rows have the same length as the longest row,
/// by appending zero entry for the rows
void m_convert2ReducedForm(int ifForCal, Matrix matrix) {
    m_conert2UTMatrix(ifForCal, matrix);
    // To cal reduced form, we should start from the bottom(nonzero row)
    // Find last non-zero row
    int index = -1;
    for(int row = m_rowsNumber(matrix) - 1; row >= 0; row--) {
        if (m_checkIfNoneZeroRow(row, matrix)) {
            index = row;
            break;
        }
    }
    // if index == 0, which means the matrix only have one non-zero row, or
    // the matrix is fulll of zero row
    if (index <= 0) return;
    // Make sure each column only has one nonzero value(except the last col)
    while (index > 0) {
        // We have checked if the row is nonzero before, the i must have value
        int i = m_findIndexOfNonzeroNum(m_findRowAt(index, matrix));
        if (i == -1) {
            index--;
            continue;
        }
        // add multiple of the row to another row
        // using Gaussian Elimination
        for(int j = 0; j < index; j++) {
            CReal num = m_findEntryAt_v(j, i, matrix);
            m_rowMinus(j, index, num, matrix);
        }
        index--;
    }
}


/// formatted matrix string to make it easy to see
///
///     print(matrix.formattedMatrix)
///     // prints like below
///     // [1.0, 0.0, 0.0, 1.0]
///     // [0.0, 1.0, 0.0, 1.0]
///     // [0.0, 0.0, 1.0, 1.0]
///
/// this variable can make the console more beautiful
/// for float number, this `formattedMatrixStr` will return like below
///
///     [ 1.0,-1.5, 3.0, 2.5]
///     [ 0.0, 0.0, 1.0, 1/3]
///     [ 0.0, 0.0, 0.0, 3.0]
///     [ 0.0, 0.0, 0.0, 0.0]
///     [ 0.0, 0.0, 0.0, 0.0]
///
/// rather than (uses `upwrappedMatrixStr`)
///
///     [1.0, -1.5, 3.0, 1.0, 2.5]
///     [0.0, 0.0, 1.0, -0.3333333333333333, 0.3333333333333333]
///     [0.0, 0.0, 0.0, 1.0, 3.0]
///     [0.0, 0.0, 0.0, 0.0, 0.0]
///     [0.0, 0.0, 0.0, 0.0, 0.0]
///
void m_printFormattedMatrix(Matrix matrix) {
    Row row = matrix;
    Entry entry = row;
    printf("\n");
    while (row != NULL) {
        printf("[");
        while(entry != NULL) {
            cr_printFV(entry -> element);
            printf(entry -> right != NULL ? "," : "");
            entry = entry -> right;
        }
        printf("]\n");
        row = row -> down;
        entry = row;
    }
}

// FIXME: if last row is a number, the function can't stop
// FIXME: if entered one row, the function will break
Matrix getInput(void) {
    Matrix matrix = m_blankEntry(0, 1);
    Row row = matrix;
    Entry entry = row;
    
    printf("Enter your row below:\n");
    char str[11];
    char c;
    
    for (;;) {
       do {
            int num;
            scanf("%d", &num);
            
            entry -> right = m_blankEntry(num, 1);
            entry = entry -> right;
        } while ((c = getchar()) != '\n');
        
        if ((c = getchar()) == '\n')
            break;
        for(int i = 0; c != ' '; i++, c = getchar())
            str[i] = c;
        
        row -> down = m_blankEntry(0, 1);
        row = row -> down;
        entry = row;
        entry -> right = m_blankEntry(atoi(str), 1);
        entry = entry -> right;
    }
    row = matrix;
    Entry ptr = matrix -> right;
    matrix -> right -> down = matrix -> down -> right;
    matrix = matrix -> right;
    do {
        // free all header entry for the matrix
        // from the first one to the last one
        entry = row;
        // conect new "header"(the real first entry) to the next real entry
        row = entry -> down;
        ptr -> down = row -> right;
        ptr = ptr -> down;
        // free previous header
        free(entry);
    } while (row -> down != NULL);
    printf("this matrix has been put in buffer\n");
    // free last header
    free(row);
    return matrix;
}

Matrix swapNodePointer(Matrix matrix, int x, int y) {
    // make sure x < y
    if (x > y) {
        // swap x, and y
        int tmp = x;
        x = y;
        y = tmp;
    } else if ( x == y) {
        // if x == y, then return original list
        return matrix;
    }

    // if we want to swap two node, we could need four pointers, but I have used five /sad
    // maybe I will optimize it in the future
    // TODO: optimize the function
    Entry a = matrix, b = matrix, c = matrix, d = matrix, e = matrix;

    // For convenience, we could add a node before the list
    // and after finish swap, then delete it
    Entry new_node = m_blankEntry(0, 1);
    new_node -> down = matrix;

    // init three pointers
    for (int i = 0; matrix != NULL && i <= y; ++i, matrix = matrix -> down) {
        if (i == x - 1 && x > 0) {
            a = matrix;
            e = matrix -> down;
        }
        if (i == y - 1) {
            d = matrix;
            b = matrix -> down;
            c = matrix -> down -> down;
        }
    }
    // if x is equal to 0, pointer a will point at the first node(we've created before)
    // and pointer e will pointer at the second node
    if (x == 0) {
        a = new_node;
        e = a -> down;
    }
    if (y - x > 1) {
        // the x should not equal to 0
        // the statement make sense when the B -> down is NULL
        // in normal, like ...->A->...->B->...
        b -> down = a -> down -> down;
        a -> down -> down = c;
        a -> down = b;
        d -> down = e;
        e -> down = c;
    } else if (y - x == 1) {
        // if A and B are neighbors, like ...->A->B->...
        // the statement also make sense when the B -> down is NULL
        a -> down -> down = c; // actually you can use b -> down instead of c here
        b -> down = a -> down;
        a -> down = b;
    }
    // if we free the new_node, we will lost the first node,
    // so we need a pointer point the first node
     Entry result = new_node -> down;
    // the new_node is what we created for convenience before
    free(new_node);
    return result;
}
