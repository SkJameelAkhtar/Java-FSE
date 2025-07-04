package com.example.mockito;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.mockito.InOrder;
import org.mockito.ArgumentMatchers;

class MockitoExercisesTest {

    // Exercise 1: Mocking and Stubbing
    @Test
    public void testExternalApi() {
        ExternalApi mockApi = mock(ExternalApi.class);
        
        when(mockApi.getData()).thenReturn("Mock Data");
        
        MyService service = new MyService(mockApi);
        String result = service.fetchData();
        
        assertEquals("Mock Data", result);
    }

    // Exercise 2: Verifying Interactions
    @Test
    public void testVerifyInteraction() {

        ExternalApi mockApi = mock(ExternalApi.class);
        
        MyService service = new MyService(mockApi);
        service.fetchData();
        
        verify(mockApi).getData();
    }

    // Exercise 3: Argument Matching
    @Test
    public void testArgumentMatching() {

        ExternalApi mockApi = mock(ExternalApi.class);
        
        when(mockApi.getDataById("123")).thenReturn("Data for ID 123");
        
        MyService service = new MyService(mockApi);
        String result = service.fetchDataById("123");
        
        assertEquals("Data for ID 123", result);
        
        verify(mockApi).getDataById("123");
        
        verify(mockApi).getDataById(eq("123"));
        verify(mockApi).getDataById(ArgumentMatchers.anyString());
    }

    // Exercise 4: Handling Void Methods
    @Test
    public void testVoidMethod() {

        ExternalApi mockApi = mock(ExternalApi.class);
        
        doNothing().when(mockApi).saveData("test data");
        
        MyService service = new MyService(mockApi);
        service.saveData("test data");
        
        verify(mockApi).saveData("test data");
    }

    // Exercise 5: Mocking and Stubbing with Multiple Returns
    @Test
    public void testMultipleReturns() {

        ExternalApi mockApi = mock(ExternalApi.class);
        
        when(mockApi.getData())
            .thenReturn("First Call")
            .thenReturn("Second Call")
            .thenReturn("Third Call");
        
        MyService service = new MyService(mockApi);
        String result = service.fetchMultipleData();
        
        assertEquals("First Call-Second Call-Third Call", result);
        
        verify(mockApi, times(3)).getData();
    }

    // Exercise 6: Verifying Interaction Order
    @Test
    public void testInteractionOrder() {

        ExternalApi mockApi = mock(ExternalApi.class);
        
        MyService service = new MyService(mockApi);
        
        service.performSequentialOperations("test data");
        
        InOrder inOrder = inOrder(mockApi);
        inOrder.verify(mockApi).saveData("test data");
        inOrder.verify(mockApi).processData("test data", 1);
        inOrder.verify(mockApi).getData();
    }

    // Exercise 7: Handling Void Methods with Exceptions
    @Test
    public void testVoidMethodWithException() {

        ExternalApi mockApi = mock(ExternalApi.class);
        
        doThrow(new RuntimeException("Save failed"))
            .when(mockApi).saveData("invalid data");
        
        MyService service = new MyService(mockApi);
        
        assertThrows(RuntimeException.class, () -> {
            service.saveData("invalid data");
        });
        
        verify(mockApi).saveData("invalid data");
    }
}