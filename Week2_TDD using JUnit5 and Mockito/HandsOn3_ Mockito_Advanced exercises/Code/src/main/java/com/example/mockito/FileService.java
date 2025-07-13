package com.example.mockito;

public class FileService {
    private final IFileReader fileReader;
    private final IFileWriter fileWriter;

    public FileService(IFileReader fileReader, IFileWriter fileWriter) {
        this.fileReader = fileReader;
        this.fileWriter = fileWriter;
    }

    public String processFile() {
        String content = fileReader.read();
        String processedContent = "Processed " + content;
        fileWriter.write(processedContent);
        return processedContent;
    }
}