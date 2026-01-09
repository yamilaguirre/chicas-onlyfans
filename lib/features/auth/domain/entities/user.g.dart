// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  phone: json['phone'] as String,
  username: json['username'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  profileImageUrl: json['profileImageUrl'] as String?,
  bio: json['bio'] as String?,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  isVerified: json['isVerified'] as bool? ?? false,
  interests:
      (json['interests'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  followers:
      (json['followers'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  following:
      (json['following'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'username': instance.username,
      'name': instance.name,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'bio': instance.bio,
      'birthDate': instance.birthDate?.toIso8601String(),
      'isVerified': instance.isVerified,
      'interests': instance.interests,
      'followers': instance.followers,
      'following': instance.following,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
