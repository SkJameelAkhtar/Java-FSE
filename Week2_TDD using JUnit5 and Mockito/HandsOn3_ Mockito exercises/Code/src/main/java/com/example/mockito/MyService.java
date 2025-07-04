package com.example.mockito;

public class MyService {
    private final ExternalApi externalApi;
    
    public MyService(ExternalApi externalApi) {
        this.externalApi = externalApi;
    }
    
    public String fetchData() {
        return externalApi.getData();
    }
    
    public String fetchDataById(String id) {
        return externalApi.getDataById(id);
    }
    
    public void saveData(String data) {
        externalApi.saveData(data);
    }
    
    public void processWithPriority(String data, int priority) {
        externalApi.processData(data, priority);
    }
    
    public String fetchMultipleData() {
        StringBuilder result = new StringBuilder();
        result.append(externalApi.getData()).append("-");
        result.append(externalApi.getData()).append("-");
        result.append(externalApi.getData());
        return result.toString();
    }
    
    public void performSequentialOperations(String data) {
        externalApi.saveData(data);
        externalApi.processData(data, 1);
        externalApi.getData();
    }
}