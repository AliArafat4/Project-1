import '../classes/book.dart';
import 'dart:io';

import '../functions/book_operation_exports.dart';

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
    print("Press 8 to display report");
    print("Press 9 to edit books");
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
        Book book = Book();
        bool found = false;
        purchaseBooks(allBooks: allBooks).map((e) => book = e).toList();
        // check if book in the purchase list to add copies or add new item
        //TODO: FIX IF LESS THAN 0 ENTERED
        purchasedBooks.where((element) {
          if (element.id == book.id) {
            element.copies = element.copies! + book.copies!;
            found = true;
            return true;
          }
          return true;
        }).toList();
        if (!found) {
          purchasedBooks.add(book);
        }

        break;
      case "4": //add books
        addNewBooks(allBooks: allBooks);
        break;

      case "5": //delete book
        deleteBook(allBooks: allBooks);
        break;

      case "6": //display invoice
        displayInvoice(purchasedBooks: purchasedBooks);
        break;

      case "7": //display categories
        listAllCategoriesForSearch(allBooks: allBooks);
        break;

      case "8": //reporting
        reporting(purchasedBooks: purchasedBooks);
        break;

      case "9": //edit book information
        editBookInformation(allBooks: allBooks);
        break;

      default:
        print("--Program Ended--");
        exit(0);
    }
  }
}
