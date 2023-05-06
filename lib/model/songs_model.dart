import 'package:json_annotation/json_annotation.dart';

part 'songs_model.g.dart';

@JsonSerializable()
class SongListModel {
  List<SongModel?> result;

  SongListModel(this.result);

  factory SongListModel.fromJson(Map<String, dynamic> json) =>
      _$SongListModelFromJson(json);
  Map<String, dynamic> toJson() => _$SongListModelToJson(this);
}

@JsonSerializable()
class SongModel {
  final int id;
  final String name;
  final String artist;
  String? url;
  final String source;
  int? duration;
  String? lyric;
  @JsonKey(name: 'origin_id')
  int? originId;
  int? like;

  SongModel(
      {required this.id,
      required this.name,
      required this.artist,
      this.url,
      required this.source,
      this.duration,
      this.originId,
      this.lyric,
      this.like});

  factory SongModel.fromJson(Map<String, dynamic> json) =>
      _$SongModelFromJson(json);
  Map<String, dynamic> toJson() => _$SongModelToJson(this);
}
