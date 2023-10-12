class Book {
  String? id, title, author, category;
  num? price;
  int? copies;
  Book({this.id, this.title, this.author, this.category, this.price, this.copies});

  listAllBooks() {
    print(
        "ID: $id, Title: $title, Category: $category, Author: $author, Copies: $copies, Price: $price");
  }
}
