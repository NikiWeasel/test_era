import 'package:json_annotation/json_annotation.dart';

part 'post_dto.g.dart';

@JsonSerializable()
class PostDTO {
  final int userId;
  final int id;
  final String title;
  final String body;

  const PostDTO({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostDTO.fromJson(Map<String, dynamic> json) =>
      _$PostDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PostDTOToJson(this);
}
