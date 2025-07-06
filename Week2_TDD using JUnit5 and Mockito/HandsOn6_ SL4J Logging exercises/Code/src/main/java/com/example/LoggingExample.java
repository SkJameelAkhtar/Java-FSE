package com.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingExample {

    private static final Logger logger = LoggerFactory.getLogger(LoggingExample.class);

    public static void main(String[] args) {
        logger.error("This is an error message");
        logger.warn("This is a warning message");
        logger.info("This is an info message.");   // General operational information
        logger.debug("This is a debug message."); // Fine-grained information for debugging
        logger.trace("This is a trace message."); // Most detailed information
    }
}