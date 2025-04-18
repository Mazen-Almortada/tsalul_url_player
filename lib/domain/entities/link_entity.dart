class LinkEntity {
  int id;
  final String title;
  final String url;
  final DateTime createdAt;

  LinkEntity({
    this.id = 0,
    required this.title,
    required this.url,
    required this.createdAt,
  });
}
