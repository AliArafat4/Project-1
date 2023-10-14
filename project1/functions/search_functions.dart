import 'dart:io';

import '../classes/book.dart';

void searchMethodSelection({required List<Book> allBooks}) {
  bool active = true;
  String? userInput;
  while (active) {
    print("A: Search by ID");
    print("B: Search by title");
    print("C: Search by category");
    print("D: Search by author");
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

    if (userInput.toUpperCase() == "C") {
      print("Enter the book's category");
      userInput = stdin.readLineSync();
      searchForBook(
          allBooks: allBooks,
          query: userInput![0].toUpperCase() + userInput.substring(1).toLowerCase(),
          type: "category");
    }
    if (userInput.toUpperCase() == "D") {
      print("Enter the book's author");
      userInput = stdin.readLineSync();
      searchForBook(allBooks: allBooks, query: userInput!, type: "author");
    }

    if (userInput.toUpperCase() == "Q") {
      active = false;
    }
  }
}

void searchForBook({required List<Book> allBooks, required String query, required String type}) {
  bool foundBook = false;
  switch (type) {
    case "id":
      allBooks.where((element) {
        if (element.id == query) {
          element.listAllBooks();
          foundBook = true;
          return true;
        }
        return false;
      }).toList();
      if (!foundBook) {
        print("Book with the ID ($query) is not found");
      }
      break;

    case "title":
      allBooks.where((element) {
        if (element.title == query) {
          element.listAllBooks();
          foundBook = true;
          return true;
        }
        return false;
      }).toList();
      if (!foundBook) {
        print("Book with the title ($query) is not found");
      }
      break;

    case "category":
      allBooks.where((element) {
        if (element.category == query) {
          element.listAllBooks();
          foundBook = true;
          return true;
        }
        return false;
      }).toList();
      if (!foundBook) {
        print("Books with the category ($query) is not found");
      }
      break;
    case "author":
      allBooks.where((element) {
        if (element.author == query) {
          element.listAllBooks();
          foundBook = true;
          return true;
        }
        return false;
      }).toList();
      if (!foundBook) {
        print("Books with the author ($query) is not found");
      }
      break;
  }
}

void listAllCategoriesForSearch({required List<Book> allBooks}) {
  List<String> categories = [];
  allBooks.map((e) {
    if (!categories.contains(e.category!)) {
      categories.add(e.category!);
    }
  }).toList();
  print(categories);
  print("Enter the category to search");
  String? userInput = stdin.readLineSync();
  searchForBook(
      allBooks: allBooks,
      query: userInput![0].toUpperCase() + userInput.substring(1).toLowerCase(),
      type: "category");
}

void listAllBooks({required List<Book> allBooks}) {
  (allBooks.map((e) {
    e.listAllBooks();
  }).toList());
}
