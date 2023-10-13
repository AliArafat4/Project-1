import 'dart:io';
import 'book.dart';
import 'data.dart';

//This file store all the functions for the [list of books]
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

void searchMethodSelection({required List<Book> allBooks}) {
  bool active = true;
  String? userInput;
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

    if (userInput.toUpperCase() == "C") {
      print("Enter the book's category");
      userInput = stdin.readLineSync();
      searchForBook(
          allBooks: allBooks,
          query: userInput![0].toUpperCase() + userInput.substring(1).toLowerCase(),
          type: "category");
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

List<Book> purchaseBooks({required List<Book> allBooks}) {
  List<Book> toPurchase = [];
  Book bookInfo = Book();
  bool enoughCopies = true;
  int availableCopies = -1;

  print("You can purchase a book by entering its ID or title");
  String? userInput = stdin.readLineSync();

  allBooks.map((e) {
    if (e.id == userInput || e.title == userInput) {
      availableCopies = e.copies!;
      if (availableCopies == 0) {
        return toPurchase;
      }

      print("How many copies are you purchasing ?");
      int numberOfPurchasedCopies = int.parse(stdin.readLineSync()!);

      if (numberOfPurchasedCopies > e.copies!) {
        print("Sorry we don't have that amount of copies at the moment");
        enoughCopies = false;
        return toPurchase;
      } else {
        bookInfo = e;
        final int remainingCopies = e.copies! - numberOfPurchasedCopies;
        bookInfo.copies = numberOfPurchasedCopies;
        print("You purchased ($numberOfPurchasedCopies) copies of (${e.title}) successfully");
        toPurchase.add(bookInfo);
        e.copies = remainingCopies;
        return toPurchase;
      }
    }
  }).toList();

  if (availableCopies == 0) {
    print("Sorry but the book with the ID or name ($userInput) is not available at the moment");
  } else if (toPurchase.isEmpty && enoughCopies) {
    print("Book with the ID or name ($userInput) does not exist");
  }
  return toPurchase;
}

void addNewBooks({required List<Book> allBooks}) {
  print("Enter the title for the book");
  String? userInput = stdin.readLineSync();
  final title = userInput;

  final int id = int.parse(allBooks.last.id!) + 1;

  print("Enter the category for the book");
  userInput = stdin.readLineSync();
  final category = userInput;

  print("Enter the name of the author for the book");
  userInput = stdin.readLineSync();
  final authorName = userInput;

  bool active = true;
  while (active) {
    try {
      print("Enter the price for the book");
      userInput = stdin.readLineSync();
      final int price = int.parse(userInput!);

      print("Enter the number of copies for the book");
      userInput = stdin.readLineSync();
      final int numberOfCopies = int.parse(userInput!);

      Book addedBook = Book(
        id: "$id",
        title: title,
        author: authorName,
        category: category,
        price: price,
        copies: numberOfCopies,
      );
      allBooks.add(addedBook);
      print("Your have successfully added (${addedBook.title}) book");
      active = false;
    } on Exception catch (e) {
      print("Please enter a valid number for the price and/or copies");
    }
  }
}

void deleteBook({required List<Book> allBooks}) {
  print("Delete a book by entering its ID or title");
  String? userInput = stdin.readLineSync();
  Book toRemove = Book();
  allBooks.map((e) {
    if (e.id == userInput || e.title == userInput) {
      toRemove = e;
    }
  }).toList();

  if (toRemove.id != null) {
    allBooks.remove(toRemove);
    print("You have successfully removed (${toRemove.title})");
    return;
  }
  print("Book with the ID or name ($userInput) does not exist");
}

// displayInvoice({required List<Book> purchasedBooks}) {
//   purchasedBooks.map((e) => e.price)
// }
