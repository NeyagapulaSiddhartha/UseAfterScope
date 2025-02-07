#include <iostream>
#include <thread>
#include <chrono> // For sleep

using namespace std;

// Thread function
void thread_function() {
    cout << "Thread started, processing...\n";
    this_thread::sleep_for(chrono::seconds(2)); // Simulate work
    cout << "Thread finished execution\n";
}

// Function to join the thread (takes thread handle as reference)
void join_thread(thread& t) {
    if (t.joinable()) { // Check if the thread can be joined
        t.join();
        cout << "Thread successfully joined\n";
    } else {
        cerr << "Error: Thread is not joinable\n";
    }
}

int main() {
    // Create a thread
    thread t(thread_function);
    cout << "Thread created in main\n";

    // Simulate some work in main before joining
    this_thread::sleep_for(chrono::seconds(1));

    // Join the thread by passing the handle to a function
    join_thread(t);

    return 0;
}
