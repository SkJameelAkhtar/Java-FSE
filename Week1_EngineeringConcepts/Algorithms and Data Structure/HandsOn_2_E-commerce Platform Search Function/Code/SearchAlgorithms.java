package EcomPlatformSearchFunction;

public class SearchAlgorithms {

    public static Product linearSearch(Product[] products, String targetProductId) {
        for (Product product : products) {
            if (product.getProductId().equals(targetProductId)) {
                return product; // Found the product
            }
        }
        return null; // Product not found
    }

    public static Product binarySearch(Product[] sortedProducts, String targetProductId) {
        int left = 0;
        int right = sortedProducts.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            int comparison = sortedProducts[mid].getProductId().compareTo(targetProductId);

            if (comparison == 0) {
                return sortedProducts[mid]; // Product found
            } else if (comparison < 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null; // Product not found
    }
}