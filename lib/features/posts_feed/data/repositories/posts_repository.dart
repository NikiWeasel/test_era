import 'package:test_project/common/domain/entities/post.dart';
import 'package:test_project/common/mappers/post_mapper.dart';
import 'package:test_project/features/posts_feed/domain/repositories/i_posts_repository.dart';
import 'package:test_project/features/posts_feed/data/services/rest_client.dart';

class PostsRepository implements IPostsRepository {
  final RestClient _restClient;

  PostsRepository(this._restClient);

  @override
  Future<List<Post>> fetchPosts() async {
    final list = await _restClient.getPosts();
    final postsList = <Post>[];
    for (final e in list) {
      postsList.add(mapPostDtoToEntity(e));
    }
    return postsList;
  }

  @override
  List<Post> filterPosts(List<Post> posts, String searchString) {
    List<Post> filteredPosts = [];
    for (var i in posts) {
      var s = i.title;
      if (s.contains(searchString)) {
        filteredPosts.add(i);
      }
    }
    return filteredPosts;
  }
}
