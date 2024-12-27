#include <iostream>
#include <thread>

// Function for Thread 1
void threadFunction1() {
    std::cout << "Hello from Thread 1! ID: " ;
}

// Function for Thread 2
void threadFunction2() {
    std::cout << "Hello from Thread 2! ID: " ;
}

int main() {
    // Create Thread 1
    std::thread thread1(threadFunction1);

    // Create Thread 2
    std::thread thread2(threadFunction2);

    // Wait for Thread 1 to complete
    thread1.join();

    // Wait for Thread 2 to complete
    thread2.join();

    return EXIT_SUCCESS;
}
