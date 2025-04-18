// features/links/presentation/bloc/link_event.dart
part of 'link_bloc.dart';

abstract class LinkEvent {
  const LinkEvent();
}

class LoadLinks extends LinkEvent {}

class AddLink extends LinkEvent {
  final LinkEntity link;
  const AddLink(this.link);
}

class UpdateLink extends LinkEvent {
  final LinkEntity link;
  const UpdateLink(this.link);
}

class DeleteLink extends LinkEvent {
  final int id;
  const DeleteLink(this.id);
}

class SearchLinks extends LinkEvent {
  final String query;
  const SearchLinks(this.query);
}
