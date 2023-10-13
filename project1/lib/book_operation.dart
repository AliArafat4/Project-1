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

List<Book> purchaseBooks({required List<Book> allBooks}) {
  List<Book> toPurchase = [];
  Book bookInfo = Book();
  bool enoughCopies = true;
  int availableCopies = -1;
  bool inSelection = true;
  String? userInput;
  int numberOfPurchasedCopies = 0;

  while (inSelection) {
    print("A: You can purchase a book by entering its ID");
    print("B: You can purchase a book by entering its title");
    userInput = stdin.readLineSync();
    switch (userInput!.toUpperCase()) {
      case "A":
        inSelection = false;
        print("Enter book's ID");
        String? userInput = stdin.readLineSync();
        allBooks.map((e) {
          if (e.id == userInput) {
            availableCopies = e.copies!;
            if (availableCopies == 0) {
              return toPurchase;
            }

            print("How many copies are you purchasing ?");
            numberOfPurchasedCopies = int.parse(stdin.readLineSync()!);

            if (numberOfPurchasedCopies > e.copies!) {
              print("Sorry we don't have that amount of copies at the moment");
              enoughCopies = false;
              return toPurchase;
            } else if (numberOfPurchasedCopies <= 0) {
              print("Please enter a valid number greater than 0");
            } else {
              bookInfo
                ..copies = e.copies
                ..category = e.category
                ..price = e.price
                ..title = e.title
                ..id = e.id
                ..author = e.author;
              final int remainingCopies = e.copies! - numberOfPurchasedCopies;
              bookInfo.copies = numberOfPurchasedCopies;
              print("You purchased ($numberOfPurchasedCopies) copies of (${e.title}) successfully");
              toPurchase.add(bookInfo);
              e.copies = remainingCopies;
              return toPurchase;
            }
          }
        }).toList();
        break;

      case "B":
        inSelection = false;
        print("Enter book's title");
        String? userInput = stdin.readLineSync();
        allBooks.map((e) {
          if (e.title == userInput) {
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
            } else if (numberOfPurchasedCopies <= 0) {
              print("Please enter a valid number greater than 0");
            } else {
              bookInfo
                ..copies = e.copies
                ..category = e.category
                ..price = e.price
                ..title = e.title
                ..id = e.id
                ..author = e.author;
              final int remainingCopies = e.copies! - numberOfPurchasedCopies;
              bookInfo.copies = numberOfPurchasedCopies;
              print("You purchased ($numberOfPurchasedCopies) copies of (${e.title}) successfully");
              toPurchase.add(bookInfo);
              e.copies = remainingCopies;
              return toPurchase;
            }
          }
        }).toList();
        break;
    }
  }

  if (numberOfPurchasedCopies <= 0) {
    return toPurchase;
  } else if (availableCopies == 0) {
    print("Sorry but the book with the ID or name ($userInput) is not available at the moment");
  } else if (toPurchase.isEmpty && enoughCopies) {
    print("Book with the ID or name ($userInput) does not exist");
  }
  return toPurchase;
}

void addNewBooks({required List<Book> allBooks}) {
  bool isExist = false;
  String? userInput;
  String? title;
  while (!isExist) {
    print("Enter a title for the book");
    userInput = stdin.readLineSync();
    title = userInput;
    allBooks.map((e) {
      if (e.title == title) {
        isExist = true;
      }
    }).toString();
    if (isExist) {
      print("($userInput) already exists in our library");
      isExist = false;
    } else {
      isExist = true;
    }
  }

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
  bool inSelection = true;
  Book toRemove = Book();
  String? userInput;
  while (inSelection) {
    print("A: You can delete a book by entering its ID");
    print("B: You can delete a book by entering its title");
    userInput = stdin.readLineSync();
    switch (userInput!.toUpperCase()) {
      case "A":
        inSelection = false;
        print("Enter book's ID");
        userInput = stdin.readLineSync();
        allBooks.map((e) {
          if (e.id == userInput) {
            toRemove = e;
          }
        }).toList();
        break;
      case "B":
        inSelection = false;
        print("Enter book's title");
        userInput = stdin.readLineSync();
        allBooks.map((e) {
          if (e.title == userInput) {
            toRemove = e;
            inSelection = false;
          }
        }).toList();
        break;
    }
  }

  if (toRemove.id != null) {
    allBooks.remove(toRemove);
    print("You have successfully removed (${toRemove.title})");
    return;
  }
  print("Book with the ID or name ($userInput) does not exist");
}

void displayInvoice({required List<Book> purchasedBooks}) {
  num totalPrice = 0;
  purchasedBooks.map((e) {
    try {
      print(
          "You have purchased (${e.title}) books\nNumber of copies: ${e.copies}\nPrice: ${e.price! * e.copies!}\$");
      totalPrice += e.price! * e.copies!;
    } on Exception catch (e) {
      print(e);
    }
  }).toList();
  print("Total price is = $totalPrice\$");
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

void reporting({required List<Book> purchasedBooks}) {
  num totalPrice = 0;
  num copies = 0;
  List purchasedBooksList = [];
  purchasedBooks.map((e) {
    purchasedBooksList.add(e.id);
    copies = e.copies!;
    totalPrice += e.price! * e.copies!;
  }).toList();
  print("Number of purchased books = ${purchasedBooksList.length * copies}");
  print("Total price is = $totalPrice\$");
}
