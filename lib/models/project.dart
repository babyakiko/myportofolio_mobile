import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Portfolio project synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    required this.title,
    required this.role,
    required this.description,
    required this.techStack,
    this.imageUrl = '',
    this.id,
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;

  @JsonKey(defaultValue: '')
  final String title;

  @JsonKey(defaultValue: '')
  final String role;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: '')
  final String techStack;

  @JsonKey(defaultValue: '')
  final String imageUrl;

  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
