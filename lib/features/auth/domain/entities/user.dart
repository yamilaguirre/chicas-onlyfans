import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String phone,
    String? username,
    String? name,
    String? email,
    String? profileImageUrl,
    String? bio,
    DateTime? birthDate,
    @Default(false) bool isVerified,
    @Default([]) List<String> interests,
    @Default([]) List<String> followers,
    @Default([]) List<String> following,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
