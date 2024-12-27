#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>



void fun(int *i){
    return ;
}


// Function for Thread 2
void* threadFunction2(void* arg) {
    printf("Hello from Thread 2! ID:\n");
    return NULL;
}




int main() {
    pthread_t thread1,thread2; // Thread identifiers
int c=9;

    // Create Thread 1

    pthread_create(&thread1, NULL, threadFunction2, NULL);


    pthread_create(&thread2, NULL, threadFunction2, &c);

    if(c*c>c-1){


        pthread_join(thread1, NULL);
        pthread_join(thread2, NULL);


    }


    else{
     pthread_join(thread1, NULL);

    }

    // Create Thread 2
// pthread_create(&thread2, NULL, threadFunction2, NULL);






    return EXIT_SUCCESS;
}
