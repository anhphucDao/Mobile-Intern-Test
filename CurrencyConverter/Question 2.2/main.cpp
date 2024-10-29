#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

// Finds the missing number in the sequence of numbers
// @param numbers: the vector of numbers to search

// @return the missing number in the sequence

int findMissingNumber(vector<int> &numbers)
{
    size_t n = numbers.size();
    unordered_set<int> s;
    for (size_t i = 0; i < n; i++)
    {
        s.insert(numbers[i]);
    }

    int missingNumber = 1;

    while (s.find(missingNumber) != s.end())
    {
        missingNumber++;
    }

    return missingNumber;
}

int main()
{
    vector<int> numbers = {3, 7, 1, 2, 6, 4};

    cout << findMissingNumber(numbers) << endl;

    return 0;
}