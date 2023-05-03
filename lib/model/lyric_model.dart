import 'package:json_annotation/json_annotation.dart';

part 'lyric_model.g.dart';

@JsonSerializable()
class LyricModel {
  String? lyric;
  String? source;

  LyricModel(this.lyric, this.source);

  factory LyricModel.fromJson(Map<String, dynamic> json) =>
      _$LyricModelFromJson(json);
  Map<String, dynamic> toJson() => _$LyricModelToJson(this);
}
