class BookList {
  final String url;
  final String title;
  final String author;
  final String id;
  final int cost;
  final String description;
  final String category;

  BookList(
      {required this.url,
        required this.id,
        required this.title,
        required this.author,
        required this.cost,
        required this.description,
        required this.category});
}
