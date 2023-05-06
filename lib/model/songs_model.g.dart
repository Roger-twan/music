// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongListModel _$SongListModelFromJson(Map<String, dynamic> json) =>
    SongListModel(
      (json['result'] as List<dynamic>)
          .map((e) =>
              e == null ? null : SongModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SongListModelToJson(SongListModel instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

SongModel _$SongModelFromJson(Map<String, dynamic> json) => SongModel(
      id: json['id'] as int,
      name: json['name'] as String,
      artist: json['artist'] as String,
      url: json['url'] as String?,
      source: json['source'] as String,
      duration: json['duration'] as int?,
      originId: json['origin_id'] as int?,
      lyric: json['lyric'] as String?,
      like: json['like'] as int?,
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
      'like': instance.like,
    };
