package com.example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ParameterizedLoggingExample {

    private static final Logger logger = LoggerFactory.getLogger(ParameterizedLoggingExample.class);

    public static void main(String[] args) {
        String username = "admin";
        int attemptCount = 3;
        String operation = "login";

        logger.info("User {} failed to {} after {} attempts.", username, operation, attemptCount);
        logger.warn("Security warning: multiple failed login attempts for user: {}", username);
        try {
            int result = 10 / 0;
        } catch (Exception e) {
            logger.error("An error occurred during operation '{}' for user {}", operation, username, e);
        }
    }
}