import 'package:test_project/common/domain/entities/post.dart';

abstract interface class IPostsRepository {
  Future<List<Post>> fetchPosts();

  List<Post> filterPosts(List<Post> posts, String searchString);
}
