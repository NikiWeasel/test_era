import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:test_project/common/domain/entities/post.dart';
import 'package:test_project/features/posts_feed/domain/repositories/i_posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final IPostsRepository postsRepository;

  PostsBloc(this.postsRepository) : super(PostsInitial()) {
    List<Post> posts = [];

    on<FetchPosts>((event, emit) async {
      emit(PostsLoading());
      try {
         posts = await postsRepository.fetchPosts();
        emit(PostsLoaded(posts));
      } catch (e) {
        debugPrint(e.toString());
        emit(PostsError(e.toString()));
      }
    });
    on<FilterPosts>((event, emit) async {
      emit(PostsLoading());
      try {
         posts = postsRepository.filterPosts(posts, event.searchString);
        emit(PostsLoaded(posts));
      } catch (e) {
        debugPrint(e.toString());
        emit(PostsError(e.toString()));
      }
    });
  }
}
