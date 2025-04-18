// core/database/objectbox_database_helper.dart
import 'package:objectbox/objectbox.dart';
import 'database_helper.dart';

class ObjectBoxDatabaseHelper<T> implements DatabaseHelper<T> {
  final Store store;
  final Box<T> box;

  ObjectBoxDatabaseHelper._(this.store, this.box);

  static Future<ObjectBoxDatabaseHelper<T>> create<T>(
    Store store,
    Type type,
  ) async {
    final box = store.box<T>();
    return ObjectBoxDatabaseHelper._(store, box);
  }

  @override
  Future<int> insert(T item) async {
    return box.put(item);
  }

  @override
  Future<List<T>> getAll() async {
    return box.getAll();
  }

  @override
  Future<T?> getById(int id) async {
    return box.get(id);
  }

  @override
  Future<int> update(T item) async {
    return box.put(item);
  }

  @override
  Future<int> delete(int id) async {
    box.remove(id);
    return id;
  }

  @override
  Future<List<T>> query(bool Function(T) condition) async {
    return box.getAll().where(condition).toList();
  }
}
