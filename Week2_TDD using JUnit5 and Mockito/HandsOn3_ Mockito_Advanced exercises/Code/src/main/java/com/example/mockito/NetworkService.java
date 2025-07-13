package com.example.mockito;

public class NetworkService {
    private final NetworkClient networkClient;

    public NetworkService(NetworkClient networkClient) {
        this.networkClient = networkClient;
    }

    public String connectToServer() {
        String connectionStatus = networkClient.connect();
        return "Connected to " + connectionStatus;
    }
}