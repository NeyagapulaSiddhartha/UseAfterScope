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

// Function for Thread 1
void* threadFunction1(void* arg) {
     pthread_t  thread2; 
     int a=10;
     int x;
    printf("Hello from Thread 1! ID: \n");
    pthread_create(&thread2, NULL, threadFunction2, &a);

    pthread_join(x, NULL);

    return NULL;
}


int main() {
    pthread_t thread1; // Thread identifiers

int *p;
    // Create Thread 1
      fun(p);
    int c=9;
    if(c>0){
        pthread_create(&thread1, NULL, threadFunction1, NULL);

    }

    // Create Thread 2
// pthread_create(&thread2, NULL, threadFunction2, NULL);

pthread_join(thread1, NULL);




    return EXIT_SUCCESS;
}
