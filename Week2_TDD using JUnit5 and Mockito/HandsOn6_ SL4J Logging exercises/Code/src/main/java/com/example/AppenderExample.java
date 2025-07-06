package com.example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AppenderExample {

    private static final Logger logger = LoggerFactory.getLogger(AppenderExample.class);

    public static void main(String[] args) {
        logger.debug("This is a debug message for startup configuration.");
        logger.info("Application is starting up.");
        logger.warn("A configuration value is missing, using default.");
        logger.error("Failed to connect to the database.", new IllegalStateException("DB connection timeout"));
        logger.info("Application has finished processing.");
    }
}