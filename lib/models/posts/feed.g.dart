// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Feed _$$_FeedFromJson(Map<String, dynamic> json) => _$_Feed(
      post_id: json['post_id'] as int?,
      id: json['id'] as int?,
      content: json['content'] as String?,
      content_type: json['content_type'] as String?,
      content_url: json['content_url'] as String?,
      created_on: json['created_on'] as String?,
      noOfLikes: getLikesfromJson(json['noOfLikes']),
      likedByPeople: (json['likedByPeople'] as List<dynamic>)
          .map((e) => Followers.fromJson(e as Map<String, dynamic>))
          .toList(),
      likedByMe: json['likedByMe'] as bool?,
      author: (json['author'] as List<dynamic>)
          .map((e) => Followers.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_FeedToJson(_$_Feed instance) => <String, dynamic>{
      'post_id': instance.post_id,
      'id': instance.id,
      'content': instance.content,
      'content_type': instance.content_type,
      'content_url': instance.content_url,
      'created_on': instance.created_on,
      'noOfLikes': instance.noOfLikes,
      'likedByPeople': instance.likedByPeople,
      'likedByMe': instance.likedByMe,
      'author': instance.author,
    };
