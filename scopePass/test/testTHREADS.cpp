#include <iostream>
#include <thread>

// fun5 prints the value.
void fun5(int* fun5_i) {
    std::cout << "In fun5: value = " << *fun5_i << std::endl;


    fun5(fun5_i);
}

// fun4 creates a thread to run fun5.
void fun4(int* fun4_i) {
    std::cout << "In fun4: value = " << *fun4_i << std::endl;

    std::thread t(fun5, fun4_i);
    t.join();
}

// fun3 takes an int** and creates a thread for fun4.
void fun3(int** fun3_i) {
    std::cout << "In fun3: value = " << **fun3_i << std::endl;

    std::thread t(fun4, *fun3_i);
    t.join();
}

// fun2 takes an int** and creates two threads for fun3.
void fun2(int** fun2_i) {
    std::cout << "In fun2: value = " << **fun2_i << std::endl;

    std::thread t1(fun3, fun2_i);
    std::thread t2(fun3, fun2_i);

    t1.join();
    t2.join();
}

// fun spawns a thread for fun2.
void fun(int* fun_i) {
    std::cout << "In fun: value = " << *fun_i << std::endl;

    std::thread t(fun2, &fun_i);
    t.join();
}

int main() {
    int a = 18;
    
    std::thread t(fun, &a);
    t.join();

    return 0;
}
