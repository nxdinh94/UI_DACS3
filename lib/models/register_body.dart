class RegisterReqBody {
  String name;
  String email;
  String password;
  String confirmPassword;

  RegisterReqBody({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
