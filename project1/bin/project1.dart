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
    print("Press 8 to display report");
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
        Book b = Book();
        List<Book> tmp = [];
        purchaseBooks(allBooks: allBooks).map((e) => b = e).toList();
        if (purchasedBooks.isEmpty) {
          purchasedBooks.add(b);
        } else {
          for (var element in purchasedBooks) {
            if (element.title == b.title!) {
              element.copies = element.copies! + b.copies!;
              print("here");
            }
            //TODO: FIX
            // else {
            //   tmp.add(b);
            //   print("object");
            // }
          }
        }
        // for (var item in tmp) {
        //   purchasedBooks.add(item);
        //   print("item");
        // }
        // tmp.clear();
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
      default:
        print("--Program Ended--");
        exit(0);
    }
  }
}
