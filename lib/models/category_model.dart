class Category {
  final String name;
  final String? imageUrl;

  Category({required this.name, this.imageUrl});

  factory Category.fromJson(String name) {
    return Category(name: name);
  }
}
