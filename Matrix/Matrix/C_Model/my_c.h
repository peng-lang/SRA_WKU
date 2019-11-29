//
//  my_c.h
//  Matrix
//
//  Created by Wendell Wang on 2019/11/28.
//  Copyright © 2019 Wendell Wang. All rights reserved.
//

#ifndef my_c_h
#define my_c_h

void *my_malloc(size_t size) {
    void *new_place = malloc(size);
    if (new_place == NULL) {
        printf("Error: malloc failed in %s\n", __FUNCTION__);
        exit(EXIT_FAILURE);
    }
    return new_place;
}

#endif /* my_c_h */
