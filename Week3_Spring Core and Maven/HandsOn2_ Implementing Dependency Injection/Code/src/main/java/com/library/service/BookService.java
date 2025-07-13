package com.library.service;

import com.library.repository.BookRepository;

public class BookService {

    private BookRepository bookRepository;

    public void setBookRepository(BookRepository bookRepository) {
        System.out.println("Spring is injecting the BookRepository dependency via the setter method.");
        this.bookRepository = bookRepository;
    }

    public void searchForBook() {
        System.out.println("BookService is searching for a book.");
        bookRepository.findBook();
    }
}