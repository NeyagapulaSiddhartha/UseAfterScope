#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
  pthread_t thread1,thread2;
void* threadFunction2(void* arg) {
    printf("Hello from Thread 2! ID:\n");
    return NULL;
}
void fun5(int *fun5_i){

    int *fun4_a ;
    fun4_a=fun5_i;
    return ;
}

void fun4(int *fun4_i){

    int *fun4_a ;
    fun4_a=fun4_i;
    fun5(fun4_i);
    return ;
}

// Function for Thread 2
void fun3(int **fun3_i){

    int *fun3_a ;
    fun3_a=*fun3_i;
            pthread_t thread2;
     fun4(*fun3_i);
    return ;
}

void fun2(int **fun2_i){

    int *fun2_a ;

          
    fun3(fun2_i);

        fun2_a=*fun2_i;
    fun3(fun2_i);
    return ;
}

void fun(int *fun_i){

    int *fun_a ;
    fun_a=fun_i;
    fun2(&fun_a);
    return ;
}


int main() {
    int a=18;
   fun(&a);
}
