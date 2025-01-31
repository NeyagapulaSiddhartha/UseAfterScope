void f2(int *i){

    (*i)++;
   
}

void f1(int *i){

    (*i)++;


    f2(i);
}


int main (){
int a1;
int c=9;

int **a,*b;

b=&c;
a=&b;

(**a)++;


int **d;

d=a;

c++;



    return 0;

}
