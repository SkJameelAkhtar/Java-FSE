package com.example.mockito;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class MultiReturnServiceTest {
    @Test
    public void testServiceWithMultipleReturnValues() {

        Repository mockRepository = mock(Repository.class);
        Service service = new Service(mockRepository);

        when(mockRepository.getData())
                .thenReturn("First Mock Data")
                .thenReturn("Second Mock Data");

        String firstResult = service.processData();
        assertEquals("Processed First Mock Data", firstResult);

        String secondResult = service.processData();
        assertEquals("Processed Second Mock Data", secondResult);
    }
}