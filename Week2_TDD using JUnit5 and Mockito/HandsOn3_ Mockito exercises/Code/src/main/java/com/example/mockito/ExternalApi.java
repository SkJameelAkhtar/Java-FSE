package com.example.mockito;

public interface ExternalApi {
    String getData();
    String getDataById(String id);
    void saveData(String data);
    void processData(String data, int priority);
}