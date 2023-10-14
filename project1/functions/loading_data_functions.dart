import '../constants/data.dart';
import '../classes/book.dart';

//load all books from [books] list
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
