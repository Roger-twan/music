import 'package:json_annotation/json_annotation.dart';

part 'search_list_model.g.dart';

@JsonSerializable()
class SearchListModel {
  final List<SongModel> result;
  SearchListModel(this.result);

  factory SearchListModel.fromJson(Map<String, dynamic> json) =>
      _$SearchListModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchListModelToJson(this);
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
