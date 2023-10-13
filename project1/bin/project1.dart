import 'package:project1/book.dart';
import 'package:project1/book_operation.dart';
import 'dart:io';

void main(List<String> arguments) {
  List<Book> allBooks = [];
  allBooks = loadBooks();
  bool running = true;
  List<Book> purchasedBooks = [];

  while (running) {
    print("");
    print("Press 1 to list all books");
    print("Press 2 to search for books");
    print("Press 3 to purchase a book");
    print("Press 4 to add a book");
    print("Press 5 to delete a book");
    print("Press 6 to display invoice");
    print("Press 7 to display all categories");
    print("--Press any other key to exit--");
    String? userInput = stdin.readLineSync();

    switch (userInput) {
      case "1": //list all books
        listAllBooks(allBooks: allBooks);
        break;
      case "2": //search for books
        searchMethodSelection(allBooks: allBooks);
        break;
      case "3": //purchase books
        purchasedBooks = purchaseBooks(allBooks: allBooks);
        break;
      case "4": //add books
        addNewBooks(allBooks: allBooks);
        break;
      case "5": //delete book
        deleteBook(allBooks: allBooks);
        break;
      case "6": //display invoice
        //  displayInvoice(purchasedBooks: purchasedBooks);
        break;
      case "7": //display categories
        print("Enter the category");
        userInput = stdin.readLineSync();
        searchForBook(
            allBooks: allBooks,
            query: userInput![0].toUpperCase() + userInput.substring(1).toLowerCase(),
            type: "category");
        break;
      default:
        print("--Program Ended--");
        exit(0);
    }
  }
}
