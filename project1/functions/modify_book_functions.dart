import 'dart:io';

import '../classes/book.dart';

void addNewBooks({required List<Book> allBooks}) {
  bool isExist = false;
  bool isNewBook = false;
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
      print("How many copies do u want to add");
      try {
        int added = int.parse(stdin.readLineSync()!);
        if (added <= 0) {
          print("Please enter a valid number greater than 0");
          isExist = false;
        } else {
          allBooks.where((element) {
            if (element.title == userInput) {
              element.copies = element.copies! + added;
              print("You have added ($added) copies to (${element.title})");
              isExist = true;
              isNewBook = false;
              return true;
            }
            return false;
          }).toList();
        }
      } on Exception catch (e) {
        print("Please enter a valid number");
        isExist = false;
      }
    } else {
      isExist = true;
      isNewBook = true;
    }
  }
  if (isNewBook) {
    bool active = true;
    while (active) {
      try {
        final int id = int.parse(allBooks.last.id!) + 1;

        print("Enter the category for the book");
        userInput = stdin.readLineSync();
        final category = userInput;

        print("Enter the name of the author for the book");
        userInput = stdin.readLineSync();
        final authorName = userInput;

        print("Enter the price for the book");
        userInput = stdin.readLineSync();
        final int price = int.parse(userInput!);

        print("Enter the number of copies for the book");
        userInput = stdin.readLineSync();
        final int numberOfCopies = int.parse(userInput!);
        if (numberOfCopies <= 0 && price <= 0) {
          print("Please enter a valid number greater than 0");
        } else {
          Book addedBook = Book(
            id: "$id",
            title: title,
            author: authorName,
            category: category![0].toUpperCase() + category.substring(1),
            price: price,
            copies: numberOfCopies,
          );
          allBooks.add(addedBook);
          print("Your have successfully added (${addedBook.title}) book");
          active = false;
        }
      } on Exception catch (e) {
        print("Please enter a valid number for the price and/or copies");
      }
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

void editBookInformation({required List<Book> allBooks}) {
  String? userInput;
  bool inSelection = true;
  bool correctID = false;
  var bookID;
  while (inSelection) {
    print("Enter the ID of the book you want to modify");
    userInput = stdin.readLineSync();
    for (var element in allBooks) {
      if (element.id == userInput) {
        bookID = element.id;
        correctID = true;
      }
    }

    if (correctID) {
      print("A: Modify the title of the book");
      print("B: Modify the author of the book");
      print("C: Modify the price of the book");
      userInput = stdin.readLineSync();
      correctID = false;

      switch (userInput!.toUpperCase()) {
        case "A": // modify title
          allBooks.map((e) {
            if (e.id == bookID) {
              print("Enter the new title for the book");
              userInput = stdin.readLineSync();
              var oldName = e.title;
              e.title = userInput;
              print(
                  "You have successfully change the name of the book from ($oldName) to (${e.title})");
              inSelection = false;
            }
          }).toList();
          break;

        case "B": // modify author
          allBooks.map((e) {
            if (e.id == bookID) {
              print("Enter the new author name for the book");
              userInput = stdin.readLineSync();
              var oldName = e.author;
              e.author = userInput;
              print(
                  "You have successfully change the name of the author from ($oldName) to (${e.author})");
              inSelection = false;
            }
          }).toList();
          break;

        case "C": // modify price
          allBooks.map((e) {
            if (e.id == bookID) {
              print("Enter the new price for the book");
              userInput = stdin.readLineSync();
              var oldPrice = e.price;
              try {
                e.price = int.parse(userInput!);
                print(
                    "You have successfully change the price of the book from ($oldPrice\$) to (${e.price}\$)");
                inSelection = false;
              } on Exception catch (e) {
                print("The value you have entered is not a number");
              }
            }
          }).toList();
          break;
      }
    } else {
      print("The ID you have entered does not belong to any book");
    }
  }
}
