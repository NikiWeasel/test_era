
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_project/common/data/dto/post_dto.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/posts')
  Future<List<PostDTO>> getPosts();
}
