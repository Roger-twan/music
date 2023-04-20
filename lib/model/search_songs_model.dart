import 'package:json_annotation/json_annotation.dart';

part 'search_songs_model.g.dart';

@JsonSerializable()
class SearchSongsModel {
  List<SongModel> result;

  SearchSongsModel(this.result);

  factory SearchSongsModel.fromJson(Map<String, dynamic> json) =>
      _$SearchSongsModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchSongsModelToJson(this);
}

@JsonSerializable()
class SongModel {
  final int id;
  final String name;
  final String artist;
  String? url;
  final String source;
  final String duration;
  String? lyric;
  @JsonKey(name: 'origin_id')
  String? originId;
  String? key;

  SongModel({
    required this.id,
    required this.name,
    required this.artist,
    this.url,
    required this.source,
    required this.duration,
    this.lyric,
    this.originId,
    this.key,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) =>
      _$SongModelFromJson(json);
  Map<String, dynamic> toJson() => _$SongModelToJson(this);
}
