package factoryMethodPattern;

public class Main {

    public static void main(String[] args) {
        System.out.println("Factory Method Pattern Test");

        DocumentFactory wordFactory = new WordDocumentFactory();
        DocumentFactory pdfFactory = new PdfDocumentFactory();
        DocumentFactory excelFactory = new ExcelDocumentFactory();

        System.out.println("\nCreating and opening a Word document...");
        Document wordDoc = wordFactory.createDocument();
        wordDoc.open();
        wordDoc.save();
        wordDoc.close();

        System.out.println("\nCreating and opening a PDF document...");
        Document pdfDoc = pdfFactory.createDocument();
        pdfDoc.open();
        pdfDoc.close();

        System.out.println("\nCreating and opening an Excel document...");
        Document excelDoc = excelFactory.createDocument();
        excelFactory.openDocument(); 
//        excelDoc.open();
        excelDoc.close();
    }
}