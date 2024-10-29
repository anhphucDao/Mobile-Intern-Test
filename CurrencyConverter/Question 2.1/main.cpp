#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Product
{
public:
    string name;
    double price;
    int quantity;

    Product(string name, double price, int quantity)
        : name(name), price(price), quantity(quantity) {}
};

// Calculates the total price of all products in the vector
// @param products: the vector of products to calculate the total price
// @return the total price of all products

double calculateTotalPrice(vector<Product> products)
{
    double total = 0;
    for (Product product : products)
    {
        total += product.price * product.quantity;
    }
    return total;
}


// Finds the most expensive product in the vector
// @param products: the vector of products to search
// @return the name of the most expensive product, or an empty string if the vector is empty

string findMostExpensiveProduct(const vector<Product>& products) {
    if (products.empty()) return "";
    const Product* mostExpensive = &products[0];
    for (const auto& product : products) {
        if (product.price > mostExpensive->price) {
            mostExpensive = &product;
        }
    }
    return mostExpensive->name;
}

// Checks if a product with the given name is in stock
// @param products: the vector of products to search
// @param name: the name of the product to search for
// @return true if the product is in stock, false otherwise

bool isProductInStock( const vector<Product>& products, const string& name) {
    for (const auto& product : products) {
        if (product.name == name && product.quantity > 0) {
            return true;
        }
    }
    return false;
}

// Sorts the products by price in ascending order by default
// @param products: the vector of products to sort
// @param ascending: if true, sorts in ascending order, otherwise in descending order

void sortProductsByPrice(vector<Product>& products, bool ascending = true) {
    sort(products.begin(), products.end(), [ascending](const Product& a, const Product& b) {
        return ascending ? a.price < b.price : a.price > b.price;
    });
}

// Sorts the products by quantity in ascending order
// @param products: the vector of products to sort
// @param ascending: if true, sorts in ascending order, otherwise in descending order

void sortProductsByQuantity(std::vector<Product>& products, bool ascending = true) {
    sort(products.begin(), products.end(), [ascending](const Product& a, const Product& b) {
        return ascending ? a.quantity < b.quantity : a.quantity > b.quantity;
    });
}

// Print the products in the vector
// @param products: the vector of products to print

void printProducts(const vector<Product>& products) {
    for (const auto& product : products) {
        cout << product.name << " - " << product.price << " - " << product.quantity << endl;
    }
}

int main()
{
    vector<Product> products = {
        Product("Laptop", 999.99, 5),
        Product("Smartphone", 499.99, 10),
        Product("Tablet", 299.99, 7),
        Product("Smartwatch", 100.00, 3)
    };

    cout << "Total price: " << calculateTotalPrice(products) << endl;

    cout << "Most expensive product: " << findMostExpensiveProduct(products) << endl;

    cout << "Is Headphones in stock? " << (isProductInStock(products, "Headphones") ? "Yes" : "No") << endl;

    cout << endl;

    //Sort products by price in ascending order
    sortProductsByPrice(products, true);
    cout << "Products sorted by price in ascending order:" << endl;
    printProducts(products);

    cout << endl;

    //Sort products by price in descending order
    sortProductsByPrice(products, false);
    cout << "Products sorted by price in descending order:" << endl;
    printProducts(products);

    cout << endl;

    //Sort products by quantity in ascending order
    sortProductsByQuantity(products, true);
    cout << "Products sorted by quantity in ascending order:" << endl;
    printProducts(products);

    cout << endl;

    //Sort products by quantity in descending order
    sortProductsByQuantity(products, false);
    cout << "Products sorted by quantity in descending order:" << endl;
    printProducts(products);

    return 0;
}