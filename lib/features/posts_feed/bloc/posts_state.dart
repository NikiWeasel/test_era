part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PostsLoaded extends PostsState {
  final List<Post> posts;

  PostsLoaded(this.posts);
}

final class PostsError extends PostsState {
  final String errorMsg;

  PostsError(this.errorMsg);
}
