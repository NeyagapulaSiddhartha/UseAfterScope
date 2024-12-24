void fun(int *i){
    return ;
}
int foo(){

    int i=6;
    int *ip=&i;
    (*ip)++;
    int *k;
    k=ip;
    (*k)++;

    int t=0;
    if(t*2>23)
    {
            int f=9; 
            f++;
            float g=6;
            float *pg=&g;
            (*pg)++;
        
        }
    fun(&i);
    return 1;
}