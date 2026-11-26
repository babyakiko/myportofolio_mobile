import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

/// Portfolio experience synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    required this.title,
    required this.description,
    this.category = 'full-time',
    this.thumbnail = '',
    this.endedAt,
    this.id,
    this.startedAt,
    this.isOngoing = true,
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  static const Map<String, String> categoryLabels = {
    'internship': 'Internship',
    'research': 'Research',
    'volunteer': 'Volunteer',
    'part-time': 'Part-Time',
    'full-time': 'Full-Time',
    'freelance': 'Freelance',
  };

  @JsonKey(includeToJson: false)
  final String? id;

  @JsonKey(defaultValue: '')
  final String title;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: 'full-time')
  final String category;

  @JsonKey(defaultValue: '')
  final String thumbnail;

  @JsonKey(includeToJson: false)
  final DateTime? startedAt;

  final DateTime? endedAt;

  @JsonKey(includeToJson: false, defaultValue: true)
  final bool isOngoing;

  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  String get categoryLabel => categoryLabels[category] ?? category;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
