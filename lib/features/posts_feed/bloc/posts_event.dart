part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

class FetchPosts extends PostsEvent {}

class FilterPosts extends PostsEvent {
  final String searchString;

  FilterPosts(this.searchString);
}
