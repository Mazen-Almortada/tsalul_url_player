// core/database/database_helper.dart
abstract class DatabaseHelper<T> {
  Future<int> insert(T item);
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<int> update(T item);
  Future<int> delete(int id);
  Future<List<T>> query(bool Function(T) condition);
}
