// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String?,
  profileImage: json['profileImage'] as String?,
  birthDate: DateTime.parse(json['birthDate'] as String),
  isVerified: json['isVerified'] as bool? ?? false,
  interests:
      (json['interests'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'birthDate': instance.birthDate.toIso8601String(),
      'isVerified': instance.isVerified,
      'interests': instance.interests,
    };
