import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

/// Repository to do all the user related operations
///
/// The abstract class here will help you out with testing and mocking
/// When you write tests, if you want to mock a function, you can extend this
/// class on the mock class
abstract class UserRepository {
  /// Gets the current [AuthUser] object for the signed in user
  Future<AuthUser> getCurrentUser();
}