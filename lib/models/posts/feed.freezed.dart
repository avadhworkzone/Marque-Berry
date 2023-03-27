// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Feed _$FeedFromJson(Map<String, dynamic> json) {
  return _Feed.fromJson(json);
}

/// @nodoc
mixin _$Feed {
  int? get post_id => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get content_type => throw _privateConstructorUsedError;
  String? get content_url => throw _privateConstructorUsedError;
  String? get created_on => throw _privateConstructorUsedError;
  @JsonKey(fromJson: getLikesfromJson)
  int? get noOfLikes => throw _privateConstructorUsedError;
  List<Followers> get likedByPeople => throw _privateConstructorUsedError;
  bool? get likedByMe => throw _privateConstructorUsedError;
  List<Followers> get author => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedCopyWith<Feed> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedCopyWith<$Res> {
  factory $FeedCopyWith(Feed value, $Res Function(Feed) then) =
      _$FeedCopyWithImpl<$Res, Feed>;
  @useResult
  $Res call(
      {int? post_id,
      int? id,
      String? content,
      String? content_type,
      String? content_url,
      String? created_on,
      @JsonKey(fromJson: getLikesfromJson) int? noOfLikes,
      List<Followers> likedByPeople,
      bool? likedByMe,
      List<Followers> author});
}

/// @nodoc
class _$FeedCopyWithImpl<$Res, $Val extends Feed>
    implements $FeedCopyWith<$Res> {
  _$FeedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post_id = freezed,
    Object? id = freezed,
    Object? content = freezed,
    Object? content_type = freezed,
    Object? content_url = freezed,
    Object? created_on = freezed,
    Object? noOfLikes = freezed,
    Object? likedByPeople = null,
    Object? likedByMe = freezed,
    Object? author = null,
  }) {
    return _then(_value.copyWith(
      post_id: freezed == post_id
          ? _value.post_id
          : post_id // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      content_type: freezed == content_type
          ? _value.content_type
          : content_type // ignore: cast_nullable_to_non_nullable
              as String?,
      content_url: freezed == content_url
          ? _value.content_url
          : content_url // ignore: cast_nullable_to_non_nullable
              as String?,
      created_on: freezed == created_on
          ? _value.created_on
          : created_on // ignore: cast_nullable_to_non_nullable
              as String?,
      noOfLikes: freezed == noOfLikes
          ? _value.noOfLikes
          : noOfLikes // ignore: cast_nullable_to_non_nullable
              as int?,
      likedByPeople: null == likedByPeople
          ? _value.likedByPeople
          : likedByPeople // ignore: cast_nullable_to_non_nullable
              as List<Followers>,
      likedByMe: freezed == likedByMe
          ? _value.likedByMe
          : likedByMe // ignore: cast_nullable_to_non_nullable
              as bool?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as List<Followers>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FeedCopyWith<$Res> implements $FeedCopyWith<$Res> {
  factory _$$_FeedCopyWith(_$_Feed value, $Res Function(_$_Feed) then) =
      __$$_FeedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? post_id,
      int? id,
      String? content,
      String? content_type,
      String? content_url,
      String? created_on,
      @JsonKey(fromJson: getLikesfromJson) int? noOfLikes,
      List<Followers> likedByPeople,
      bool? likedByMe,
      List<Followers> author});
}

/// @nodoc
class __$$_FeedCopyWithImpl<$Res> extends _$FeedCopyWithImpl<$Res, _$_Feed>
    implements _$$_FeedCopyWith<$Res> {
  __$$_FeedCopyWithImpl(_$_Feed _value, $Res Function(_$_Feed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post_id = freezed,
    Object? id = freezed,
    Object? content = freezed,
    Object? content_type = freezed,
    Object? content_url = freezed,
    Object? created_on = freezed,
    Object? noOfLikes = freezed,
    Object? likedByPeople = null,
    Object? likedByMe = freezed,
    Object? author = null,
  }) {
    return _then(_$_Feed(
      post_id: freezed == post_id
          ? _value.post_id
          : post_id // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      content_type: freezed == content_type
          ? _value.content_type
          : content_type // ignore: cast_nullable_to_non_nullable
              as String?,
      content_url: freezed == content_url
          ? _value.content_url
          : content_url // ignore: cast_nullable_to_non_nullable
              as String?,
      created_on: freezed == created_on
          ? _value.created_on
          : created_on // ignore: cast_nullable_to_non_nullable
              as String?,
      noOfLikes: freezed == noOfLikes
          ? _value.noOfLikes
          : noOfLikes // ignore: cast_nullable_to_non_nullable
              as int?,
      likedByPeople: null == likedByPeople
          ? _value._likedByPeople
          : likedByPeople // ignore: cast_nullable_to_non_nullable
              as List<Followers>,
      likedByMe: freezed == likedByMe
          ? _value.likedByMe
          : likedByMe // ignore: cast_nullable_to_non_nullable
              as bool?,
      author: null == author
          ? _value._author
          : author // ignore: cast_nullable_to_non_nullable
              as List<Followers>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Feed extends _Feed {
  const _$_Feed(
      {required this.post_id,
      required this.id,
      required this.content,
      required this.content_type,
      required this.content_url,
      required this.created_on,
      @JsonKey(fromJson: getLikesfromJson) required this.noOfLikes,
      required final List<Followers> likedByPeople,
      required this.likedByMe,
      required final List<Followers> author})
      : _likedByPeople = likedByPeople,
        _author = author,
        super._();

  factory _$_Feed.fromJson(Map<String, dynamic> json) => _$$_FeedFromJson(json);

  @override
  final int? post_id;
  @override
  final int? id;
  @override
  final String? content;
  @override
  final String? content_type;
  @override
  final String? content_url;
  @override
  final String? created_on;
  @override
  @JsonKey(fromJson: getLikesfromJson)
  final int? noOfLikes;
  final List<Followers> _likedByPeople;
  @override
  List<Followers> get likedByPeople {
    if (_likedByPeople is EqualUnmodifiableListView) return _likedByPeople;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likedByPeople);
  }

  @override
  final bool? likedByMe;
  final List<Followers> _author;
  @override
  List<Followers> get author {
    if (_author is EqualUnmodifiableListView) return _author;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_author);
  }

  @override
  String toString() {
    return 'Feed(post_id: $post_id, id: $id, content: $content, content_type: $content_type, content_url: $content_url, created_on: $created_on, noOfLikes: $noOfLikes, likedByPeople: $likedByPeople, likedByMe: $likedByMe, author: $author)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Feed &&
            (identical(other.post_id, post_id) || other.post_id == post_id) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.content_type, content_type) ||
                other.content_type == content_type) &&
            (identical(other.content_url, content_url) ||
                other.content_url == content_url) &&
            (identical(other.created_on, created_on) ||
                other.created_on == created_on) &&
            (identical(other.noOfLikes, noOfLikes) ||
                other.noOfLikes == noOfLikes) &&
            const DeepCollectionEquality()
                .equals(other._likedByPeople, _likedByPeople) &&
            (identical(other.likedByMe, likedByMe) ||
                other.likedByMe == likedByMe) &&
            const DeepCollectionEquality().equals(other._author, _author));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      post_id,
      id,
      content,
      content_type,
      content_url,
      created_on,
      noOfLikes,
      const DeepCollectionEquality().hash(_likedByPeople),
      likedByMe,
      const DeepCollectionEquality().hash(_author));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FeedCopyWith<_$_Feed> get copyWith =>
      __$$_FeedCopyWithImpl<_$_Feed>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeedToJson(
      this,
    );
  }
}

abstract class _Feed extends Feed {
  const factory _Feed(
      {required final int? post_id,
      required final int? id,
      required final String? content,
      required final String? content_type,
      required final String? content_url,
      required final String? created_on,
      @JsonKey(fromJson: getLikesfromJson) required final int? noOfLikes,
      required final List<Followers> likedByPeople,
      required final bool? likedByMe,
      required final List<Followers> author}) = _$_Feed;
  const _Feed._() : super._();

  factory _Feed.fromJson(Map<String, dynamic> json) = _$_Feed.fromJson;

  @override
  int? get post_id;
  @override
  int? get id;
  @override
  String? get content;
  @override
  String? get content_type;
  @override
  String? get content_url;
  @override
  String? get created_on;
  @override
  @JsonKey(fromJson: getLikesfromJson)
  int? get noOfLikes;
  @override
  List<Followers> get likedByPeople;
  @override
  bool? get likedByMe;
  @override
  List<Followers> get author;
  @override
  @JsonKey(ignore: true)
  _$$_FeedCopyWith<_$_Feed> get copyWith => throw _privateConstructorUsedError;
}
