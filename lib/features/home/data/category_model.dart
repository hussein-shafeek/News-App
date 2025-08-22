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
    CategoryModel(id: '', imageName: 'general', name: 'General'),
    CategoryModel(id: '', imageName: 'busniess', name: 'Busniess'),
    CategoryModel(id: '', imageName: 'entertainment', name: 'Entertainment'),
    CategoryModel(id: '', imageName: 'health', name: 'Health'),
    CategoryModel(id: '', imageName: 'science', name: 'Science'),
    CategoryModel(id: '', imageName: 'sport', name: 'Sport'),
    CategoryModel(id: '', imageName: 'technology', name: 'Technology'),
  ];
}
