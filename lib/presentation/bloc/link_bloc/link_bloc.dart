// features/links/presentation/bloc/link_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/link_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../domain/entities/link_entity.dart';
part 'link_event.dart';
part 'link_state.dart';

class LinkBloc extends Bloc<LinkEvent, LinkState> {
  final LinkRepository repo;

  LinkBloc(this.repo) : super(LinkInitial()) {
    on<LoadLinks>(_onLoadLinks);
    on<AddLink>(_onAddLink);
    on<UpdateLink>(_onUpdateLink);
    on<DeleteLink>(_onDeleteLink);
    on<SearchLinks>(_onSearchLinks);
  }

  Future<void> _onLoadLinks(LoadLinks event, Emitter<LinkState> emit) async {
    emit(LinkLoading());
    final result = await repo.getAllLinks();
    result.fold(
      (failure) => emit(LinkError(_mapFailure(failure))),
      (links) => emit(LinkLoaded(links)),
    );
  }

  Future<void> _onAddLink(AddLink event, Emitter<LinkState> emit) async {
    final result = await repo.addLink(event.link);
    result.fold(
      (failure) {
        emit(LinkError(_mapFailure(failure)));
      },
      (success) {
        add(LoadLinks());
      },
    );
  }

  Future<void> _onUpdateLink(UpdateLink event, Emitter<LinkState> emit) async {
    final result = await repo.updateLink(event.link);
    result.fold(
      (failure) {
        emit(LinkError(_mapFailure(failure)));
      },
      (success) {
        add(LoadLinks());
      },
    );
  }

  Future<void> _onDeleteLink(DeleteLink event, Emitter<LinkState> emit) async {
    await repo.deleteLink(event.id);
  }

  Future<void> _onSearchLinks(
    SearchLinks event,
    Emitter<LinkState> emit,
  ) async {
    emit(LinkLoading());
    final result = await repo.searchLinks(event.query);
    result.fold(
      (failure) => emit(LinkError(_mapFailure(failure))),
      (links) => emit(SearchLinkLoaded(links)),
    );
  }

  String _mapFailure(Failure failure) {
    return failure.message;
  }
}
