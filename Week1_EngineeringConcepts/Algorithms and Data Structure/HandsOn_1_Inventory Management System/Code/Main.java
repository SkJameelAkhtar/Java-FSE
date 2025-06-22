package inventory;

public class Main {
    public static void main(String[] args) {
        InventoryManager manager = new InventoryManager();

        System.out.println("Step 1: Adding Products");
        manager.addProduct(new Product("P001", "Laptop", 50, 1200.00));
        manager.addProduct(new Product("P002", "Mouse", 200, 25.00));
        manager.addProduct(new Product("P003", "Keyboard", 150, 75.00));
        manager.displayInventory();

        System.out.println("\nStep 2: Updating a Product ");
        manager.updateProduct("P001", 45, 1150.00);
        manager.displayInventory();

        System.out.println("\nStep 3: Deleting a Product ");
        manager.deleteProduct("P002");
        manager.displayInventory();

        System.out.println("\nStep 4: Handling Edge Cases ");
        manager.addProduct(new Product("P001", "Gaming Laptop", 10, 1500.00));
        manager.updateProduct("P004", 10, 10.00);
        manager.deleteProduct("P005");
        manager.displayInventory();
    }
}