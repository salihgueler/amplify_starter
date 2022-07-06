import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:{{project_name.snakeCase()}}/profile/domain/user_repository.dart';

class RemoteUserRepository extends UserRepository {
  @override
  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }
}
