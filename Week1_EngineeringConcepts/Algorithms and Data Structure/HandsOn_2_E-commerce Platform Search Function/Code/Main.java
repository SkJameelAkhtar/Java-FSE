package EcomPlatformSearchFunction;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        // Sample products hardcoded
        Product[] products = {
            new Product("P005", "Smartwatch", "Electronics"),
            new Product("P002", "Laptop", "Electronics"),
            new Product("P004", "Coffee Maker", "Appliances"),
            new Product("P001", "T-Shirt", "Apparel"),
            new Product("P003", "Book", "Books")
        };

        System.out.println("Linear Search");
        Product foundProduct1 = SearchAlgorithms.linearSearch(products, "P003");
        System.out.println("Searching for P003...");
        System.out.println(foundProduct1 != null ? "Found: " + foundProduct1 : "Product not found.");

        Product foundProduct2 = SearchAlgorithms.linearSearch(products, "P006");
        System.out.println("\nSearching for P006...");
        System.out.println(foundProduct2 != null ? "Found: " + foundProduct2 : "Product not found.");


        System.out.println("Binary Search");
        
        Arrays.sort(products); 
        
        System.out.println("Array after sorting (required for binary search):");
        for (Product p : products) {
            System.out.println(p);
        }

        Product foundProduct3 = SearchAlgorithms.binarySearch(products, "P004");
        System.out.println("\nSearching for P004...");
        System.out.println(foundProduct3 != null ? "Found: " + foundProduct3 : "Product not found.");
        
        Product foundProduct4 = SearchAlgorithms.binarySearch(products, "P006");
        System.out.println("\nSearching for P006...");
        System.out.println(foundProduct4 != null ? "Found: " + foundProduct4 : "Product not found.");
    }
}