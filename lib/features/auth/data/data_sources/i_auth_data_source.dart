import 'package:peanut_app/features/auth/data/models/login_model.dart';

abstract class IAuthDataSource {

  Future<LoginModel> login({
    required int userId,
    required String password,
  });
}
