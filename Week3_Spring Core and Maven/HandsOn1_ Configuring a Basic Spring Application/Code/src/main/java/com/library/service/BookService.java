package com.library.service;

import com.library.repository.BookRepository;

public class BookService {

    private BookRepository bookRepository;

    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void searchForBook() {
        System.out.println("BookService is searching for a book.");
        bookRepository.findBook();
    }
}