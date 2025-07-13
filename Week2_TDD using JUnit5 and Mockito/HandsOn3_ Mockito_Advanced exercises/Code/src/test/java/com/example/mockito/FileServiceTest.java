package com.example.mockito;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class FileServiceTest {
    @Test
    public void testServiceWithMockFileIO() {

        IFileReader mockFileReader = mock(IFileReader.class);
        IFileWriter mockFileWriter = mock(IFileWriter.class);
        when(mockFileReader.read()).thenReturn("Mock File Content");
        FileService fileService = new FileService(mockFileReader, mockFileWriter);

        String result = fileService.processFile();

        assertEquals("Processed Mock File Content", result);

        verify(mockFileWriter, times(1)).write("Processed Mock File Content");
    }
}