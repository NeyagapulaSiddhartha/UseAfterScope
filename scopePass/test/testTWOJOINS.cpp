#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
  pthread_t thread1,thread2;
void* threadFunction2(void* arg) {
    printf("Hello from Thread 2! ID:\n");
    return NULL;
}


void fun4(int *i){

    int *a ;
    a=i;
    return ;
}

// Function for Thread 2
void fun3(int **i){

    int *a ;
    a=*i;
            pthread_t thread2;
     fun4(*i);
    return ;
}

void fun2(int **i){

    int *a ;
    a=*i;
          
    fun3(i);
    fun3(i);
    return ;
}

void fun(int *i){

    int *a ;
    a=i;
    fun2(&a);
    return ;
}


int main() {
    int a=18;
   fun(&a);
}
