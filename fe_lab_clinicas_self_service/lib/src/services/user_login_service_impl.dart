import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositores/user/user_repository.dart';
import './user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  UserLoginServiceImpl({
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Future<Either<ServiceException, Unit>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Left(value: AuthError()):
        return Left(ServiceException(message: 'Erro ao realizar login'));
      case Left(value: AuthUnauthorizedException()):
        return Left(ServiceException(message: 'Login ou senha inválidos'));
      case Rigth(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageConstants.accessToken, accessToken);
        return Rigth(unit);
    }
  }
}
