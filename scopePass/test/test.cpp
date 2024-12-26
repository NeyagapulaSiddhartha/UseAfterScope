void fun(int *i){
    return ;
}
int foo(){

    int i=6;
    int j=8;

   int * p=&i;

   int *q=&j;

   (*p)++;
   (*q)++;

    p=&j;

    (*p)++;

    fun(p);
    return 1;
}