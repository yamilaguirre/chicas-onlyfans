// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  DateTime? get birthDate => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  List<String> get interests => throw _privateConstructorUsedError;
  List<String> get followers => throw _privateConstructorUsedError;
  List<String> get following => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    String id,
    String phone,
    String? username,
    String? name,
    String? email,
    String? profileImageUrl,
    String? bio,
    DateTime? birthDate,
    bool isVerified,
    List<String> interests,
    List<String> followers,
    List<String> following,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? username = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? profileImageUrl = freezed,
    Object? bio = freezed,
    Object? birthDate = freezed,
    Object? isVerified = null,
    Object? interests = null,
    Object? followers = null,
    Object? following = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            profileImageUrl: freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            birthDate: freezed == birthDate
                ? _value.birthDate
                : birthDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            interests: null == interests
                ? _value.interests
                : interests // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            followers: null == followers
                ? _value.followers
                : followers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            following: null == following
                ? _value.following
                : following // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String phone,
    String? username,
    String? name,
    String? email,
    String? profileImageUrl,
    String? bio,
    DateTime? birthDate,
    bool isVerified,
    List<String> interests,
    List<String> followers,
    List<String> following,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? username = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? profileImageUrl = freezed,
    Object? bio = freezed,
    Object? birthDate = freezed,
    Object? isVerified = null,
    Object? interests = null,
    Object? followers = null,
    Object? following = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$UserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        profileImageUrl: freezed == profileImageUrl
            ? _value.profileImageUrl
            : profileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        birthDate: freezed == birthDate
            ? _value.birthDate
            : birthDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        interests: null == interests
            ? _value._interests
            : interests // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        followers: null == followers
            ? _value._followers
            : followers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        following: null == following
            ? _value._following
            : following // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl({
    required this.id,
    required this.phone,
    this.username,
    this.name,
    this.email,
    this.profileImageUrl,
    this.bio,
    this.birthDate,
    this.isVerified = false,
    final List<String> interests = const [],
    final List<String> followers = const [],
    final List<String> following = const [],
    this.createdAt,
    this.updatedAt,
  }) : _interests = interests,
       _followers = followers,
       _following = following;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String phone;
  @override
  final String? username;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? profileImageUrl;
  @override
  final String? bio;
  @override
  final DateTime? birthDate;
  @override
  @JsonKey()
  final bool isVerified;
  final List<String> _interests;
  @override
  @JsonKey()
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  final List<String> _followers;
  @override
  @JsonKey()
  List<String> get followers {
    if (_followers is EqualUnmodifiableListView) return _followers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_followers);
  }

  final List<String> _following;
  @override
  @JsonKey()
  List<String> get following {
    if (_following is EqualUnmodifiableListView) return _following;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_following);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'User(id: $id, phone: $phone, username: $username, name: $name, email: $email, profileImageUrl: $profileImageUrl, bio: $bio, birthDate: $birthDate, isVerified: $isVerified, interests: $interests, followers: $followers, following: $following, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            const DeepCollectionEquality().equals(
              other._interests,
              _interests,
            ) &&
            const DeepCollectionEquality().equals(
              other._followers,
              _followers,
            ) &&
            const DeepCollectionEquality().equals(
              other._following,
              _following,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    phone,
    username,
    name,
    email,
    profileImageUrl,
    bio,
    birthDate,
    isVerified,
    const DeepCollectionEquality().hash(_interests),
    const DeepCollectionEquality().hash(_followers),
    const DeepCollectionEquality().hash(_following),
    createdAt,
    updatedAt,
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User implements User {
  const factory _User({
    required final String id,
    required final String phone,
    final String? username,
    final String? name,
    final String? email,
    final String? profileImageUrl,
    final String? bio,
    final DateTime? birthDate,
    final bool isVerified,
    final List<String> interests,
    final List<String> followers,
    final List<String> following,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get phone;
  @override
  String? get username;
  @override
  String? get name;
  @override
  String? get email;
  @override
  String? get profileImageUrl;
  @override
  String? get bio;
  @override
  DateTime? get birthDate;
  @override
  bool get isVerified;
  @override
  List<String> get interests;
  @override
  List<String> get followers;
  @override
  List<String> get following;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
