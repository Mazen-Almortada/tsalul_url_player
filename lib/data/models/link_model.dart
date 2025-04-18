// data/models/link_model.dart
import 'package:objectbox/objectbox.dart';
import '../../domain/entities/link_entity.dart';

@Entity()
class LinkModel {
  @Id()
  int id;

  String title;
  String url;
  DateTime createdAt;

  LinkModel({
    this.id = 0,
    required this.title,
    required this.url,
    required this.createdAt,
  });

  factory LinkModel.fromEntity(LinkEntity entity) {
    return LinkModel(
      id: entity.id,
      title: entity.title,
      url: entity.url,
      createdAt: entity.createdAt,
    );
  }

  LinkEntity toEntity() =>
      LinkEntity(id: id, title: title, url: url, createdAt: createdAt);
}
