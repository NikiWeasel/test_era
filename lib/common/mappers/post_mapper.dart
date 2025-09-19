import 'package:test_project/common/data/dto/post_dto.dart';
import 'package:test_project/common/domain/entities/post.dart';

Post mapPostDtoToEntity(PostDTO dto) {
  return Post(userId: dto.userId, id: dto.id, title: dto.title, body: dto.body);
}

PostDTO mapPostEntityToDto(Post entity) {
  return PostDTO(
    userId: entity.userId,
    id: entity.id,
    title: entity.title,
    body: entity.body,
  );
}
