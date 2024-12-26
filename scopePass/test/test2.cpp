#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

// Function for Thread 1
void* threadFunction1(void* arg) {
    printf("Hello from Thread 1! ID: %lu\n", pthread_self());
    return NULL;
}

// Function for Thread 2
void* threadFunction2(void* arg) {
    printf("Hello from Thread 2! ID: %lu\n", pthread_self());
    return NULL;
}

int main() {
    pthread_t thread1, thread2; // Thread identifiers

    // Create Thread 1
pthread_create(&thread1, NULL, threadFunction1, NULL);


    // Create Thread 2
pthread_create(&thread2, NULL, threadFunction2, NULL);

pthread_join(thread1, NULL);

pthread_join(thread2, NULL);


    return EXIT_SUCCESS;
}
