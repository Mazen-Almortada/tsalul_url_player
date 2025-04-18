// domain/repositories/link_repository.dart
import '../../core/either/either.dart';
import '../../core/error/failure.dart';
import '../entities/link_entity.dart';

abstract class LinkRepository {
  Future<Either<Failure, void>> addLink(LinkEntity link);
  Future<Either<Failure, List<LinkEntity>>> getAllLinks();
  Future<Either<Failure, LinkEntity?>> getLinkById(int id);
  Future<Either<Failure, void>> updateLink(LinkEntity link);
  Future<Either<Failure, void>> deleteLink(int id);
  Future<Either<Failure, List<LinkEntity>>> searchLinks(String query);
}
