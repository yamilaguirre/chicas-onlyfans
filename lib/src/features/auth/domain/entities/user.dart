import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String phone,
    String? email,
    String? profileImage,
    required DateTime birthDate,
    @Default(false) bool isVerified,
    @Default([]) List<String> interests,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}