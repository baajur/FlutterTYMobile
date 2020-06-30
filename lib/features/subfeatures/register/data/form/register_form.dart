import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_form.freezed.dart';

@freezed
abstract class RegisterForm with _$RegisterForm {
  const factory RegisterForm({
    @required String username,
    @required String password,
    @required String confirmPassword,
    String intro,
    String mobileno,
    String code,
  }) = _RegisterForm;
}

extension RegisterFormExtension on RegisterForm {
  /// This method is not reversible
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': this.username,
      'password': this.password,
      'confirmPassword': this.confirmPassword,
      'intro': this.intro ?? '',
      'mobileno': this.mobileno ?? '',
      'code': this.code ?? '',
    };
  }

  bool get isValid =>
      username.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      password == confirmPassword;
}
