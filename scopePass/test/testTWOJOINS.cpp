#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

void* threadFunction2(void* arg) {
    printf("Hello from Thread 2! ID:\n");
    return NULL;
}
// Function for Thread 2
void fun3(int **i){

    int *a ;
    a=*i;
            pthread_t thread2;
     pthread_create(&thread2, NULL, threadFunction2, *i);
    return ;
}


void fun(int *i){

    int *a ;
    a=i;

    return ;
}

void fun2(int **i){

    int *a ;
    a=*i;
          
    fun3(i);
    return ;
}








int main() {
    pthread_t thread1,thread2; // Thread identifiers
int c=9;

int **a,*b;

b=&c;
a=&b;

(**a)++;



int **d;

d=a;
fun2(a);
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
