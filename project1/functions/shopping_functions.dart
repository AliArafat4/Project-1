import 'dart:io';

import '../classes/book.dart';

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
          try {
            if (e.id == userInput) {
              availableCopies = e.copies!;

              if (availableCopies == 0) {
                inSelection = true;
                return toPurchase;
              }

              print("How many copies are you purchasing ?");

              numberOfPurchasedCopies = int.parse(stdin.readLineSync()!);

              if (numberOfPurchasedCopies > e.copies!) {
                print("Sorry we don't have that amount of copies at the moment");
                enoughCopies = false;
                inSelection = true;
                return toPurchase;
              } else if (numberOfPurchasedCopies <= 0) {
                print("Please enter a valid number greater than 0");
                inSelection = true;
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
                print(
                    "You purchased ($numberOfPurchasedCopies) copies of (${e.title}) successfully");
                toPurchase.add(bookInfo);
                e.copies = remainingCopies;
                return toPurchase;
              }
            } else {
              inSelection = true;
            }
          } on Exception catch (e) {
            print("Please enter a valid number");
            inSelection = true;
          }
        }).toList();
        break;

      case "B":
        inSelection = false;
        print("Enter book's title");
        String? userInput = stdin.readLineSync();
        allBooks.map((e) {
          try {
            if (e.title == userInput) {
              availableCopies = e.copies!;
              if (availableCopies == 0) {
                inSelection = true;
                return toPurchase;
              }

              print("How many copies are you purchasing ?");

              numberOfPurchasedCopies = int.parse(stdin.readLineSync()!);

              if (numberOfPurchasedCopies > e.copies!) {
                print("Sorry we don't have that amount of copies at the moment");
                enoughCopies = false;
                inSelection = true;
                return toPurchase;
              } else if (numberOfPurchasedCopies <= 0) {
                print("Please enter a valid number greater than 0");
                inSelection = true;
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
                print(
                    "You purchased ($numberOfPurchasedCopies) copies of (${e.title}) successfully");
                toPurchase.add(bookInfo);
                e.copies = remainingCopies;
                return toPurchase;
              }
            } else {
              inSelection = true;
            }
          } on Exception catch (e) {
            print("Please enter a valid number");
            inSelection = true;
          }
        }).toList();
        break;
    }
  }

  if (numberOfPurchasedCopies <= 0) {
    inSelection = true;
    return toPurchase;
  } else if (availableCopies == 0) {
    inSelection = true;
    print("Sorry but the book with the ID or name ($userInput) is not available at the moment");
  } else if (toPurchase.isEmpty && enoughCopies) {
    inSelection = true;
    print("Book with the ID or name ($userInput) does not exist");
  }
  return toPurchase;
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
