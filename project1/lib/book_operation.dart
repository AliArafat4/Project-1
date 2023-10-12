import 'dart:io';
import 'book.dart';
import 'data.dart';

List<Book> loadBooks() {
  List<Book> allBooks = [];
  for (var books in booksList) {
    allBooks.add(Book(
        id: books['id'],
        title: books['title'],
        author: books['author'],
        category: books['category'],
        copies: books['copies'],
        price: books['price']));
  }
  return allBooks;
}

void listAllBooks({required List<Book> allBooks}) {
  (allBooks.map((e) {
    e.listAllBooks();
  }).toList());
}

void searchMethodSelection({String? userInput, required List<Book> allBooks}) {
  bool active = true;
  while (active) {
    print("A: Search by ID");
    print("B: Search by title");
    print("C: Search by category");
    print("--Press Q to go back--");

    userInput = stdin.readLineSync();
    if (userInput!.toUpperCase() == "A") {
      print("Enter the book's ID");
      userInput = stdin.readLineSync();
      searchForBook(allBooks: allBooks, query: userInput!, type: "id");
    }

    if (userInput.toUpperCase() == "B") {
      print("Enter the book's title");
      userInput = stdin.readLineSync();
      searchForBook(allBooks: allBooks, query: userInput!, type: "title");
    }

    //TODO: FIX
    if (userInput.toUpperCase() == "C") {
      print("Enter the book's category");
      userInput = stdin.readLineSync();
      searchForBook(allBooks: allBooks, query: userInput!.toUpperCase(), type: "category");
    }

    if (userInput.toUpperCase() == "Q") {
      active = false;
    }
  }
}

void searchForBook({required List<Book> allBooks, required String query, required String type}) {
  switch (type) {
    case "id":
      allBooks.where((element) {
        if (element.id == query) {
          element.listAllBooks();
        }
        return true;
      }).toList();
      break;

    case "title":
      allBooks.where((element) {
        if (element.title == query) {
          element.listAllBooks();
        }
        return true;
      }).toList();
      break;

    case "category":
      allBooks.where((element) {
        if (element.category == query) {
          element.listAllBooks();
        }
        return true;
      }).toList();
      break;
  }
}
