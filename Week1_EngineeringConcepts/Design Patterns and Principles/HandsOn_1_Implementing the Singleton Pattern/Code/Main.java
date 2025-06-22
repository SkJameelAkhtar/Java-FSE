package singletonPattern;

public class Main {
    public static void main(String[] args) {
        System.out.println("Singleton Pattern Test");
        
        System.out.println("Requesting logger instance 1...");
        Logger logger1 = Logger.getInstance();
        System.out.println("Requesting logger instance 2...");
        Logger logger2 = Logger.getInstance();

        if (logger1 == logger2) {
            System.out.println("\nVerification successful: logger1 and logger2 are the SAME instance.");
        } else {
            System.out.println("\nVerification failed: logger1 and logger2 are DIFFERENT instances.");
        }

        System.out.println("Logger 1 HashCode: " + logger1.hashCode());
        System.out.println("Logger 2 HashCode: " + logger2.hashCode());
        
        System.out.println("\n--- Using the Logger ---");
        logger1.log("This is the first log message.");
        logger2.log("This is the second log message.");
    }
}