class CategoryModel {
  String id;
  String name;
  String imageName;

  CategoryModel({
    required this.id,
    required this.imageName,
    required this.name,
  });
  static List<CategoryModel> categories = [
    CategoryModel(id: 'general', imageName: 'general', name: 'General'),
    CategoryModel(id: 'business', imageName: 'busniess', name: 'Busniess'),
    CategoryModel(
      id: 'entertainment',
      imageName: 'entertainment',
      name: 'Entertainment',
    ),
    CategoryModel(id: 'health', imageName: 'health', name: 'Health'),
    CategoryModel(id: 'science', imageName: 'science', name: 'Science'),
    CategoryModel(id: 'sports', imageName: 'sport', name: 'Sport'),
    CategoryModel(
      id: 'technology',
      imageName: 'technology',
      name: 'Technology',
    ),
  ];
}
