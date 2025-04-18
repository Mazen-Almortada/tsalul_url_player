part of "link_bloc.dart";

abstract class LinkState {
  const LinkState();
}

class LinkInitial extends LinkState {}

class LinkLoading extends LinkState {}

class LinkLoaded extends LinkState {
  final List<LinkEntity> links;
  const LinkLoaded(this.links);
}

class SearchLinkLoaded extends LinkState {
  final List<LinkEntity> links;
  const SearchLinkLoaded(this.links);
}

class LinkError extends LinkState {
  final String message;
  const LinkError(this.message);
}
