import 'package:project1/book.dart';
import 'package:project1/book_operation.dart';
import 'dart:io';

void main(List<String> arguments) {
  List<Book> allBooks = [];
  allBooks = loadBooks();
  bool running = true;

  while (running) {
    print("");
    print("Press 1 to list all books");
    print("Press 2 to search for books");
    print("Press 3 to purchase a book");
    print("Press 4 to delete a book");
    print("Press 5 to display invoice");
    print("Press 6 to display categories");
    print("--Press any other key to exit--");
    String? userInput = stdin.readLineSync();

    switch (userInput) {
      case "1":
        listAllBooks(allBooks: allBooks);
        break;
      case "2":
        searchMethodSelection(userInput: userInput, allBooks: allBooks);
        break;
      case "3":
        break;
      case "4":
        break;
      case "5":
        break;
      case "6":
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
