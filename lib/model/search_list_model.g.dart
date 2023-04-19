// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchListModel _$SearchListModelFromJson(Map<String, dynamic> json) =>
    SearchListModel(
      (json['result'] as List<dynamic>)
          .map((e) => SongModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchListModelToJson(SearchListModel instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

SongModel _$SongModelFromJson(Map<String, dynamic> json) => SongModel(
      id: json['id'] as int,
      name: json['name'] as String,
      artist: json['artist'] as String,
      url: json['url'] as String?,
      source: json['source'] as String,
      duration: json['duration'] as String,
      lyric: json['lyric'] as String?,
      originId: json['origin_id'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$SongModelToJson(SongModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artist': instance.artist,
      'url': instance.url,
      'source': instance.source,
      'duration': instance.duration,
      'lyric': instance.lyric,
      'origin_id': instance.originId,
      'key': instance.key,
    };
