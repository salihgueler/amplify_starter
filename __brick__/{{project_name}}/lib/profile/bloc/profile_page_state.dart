import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:equatable/equatable.dart';

enum ProfilePageStatus { initial, loading, success, failure }

class ProfilePageState extends Equatable {
  const ProfilePageState({
    this.status = ProfilePageStatus.initial,
    this.user,
  });

  final ProfilePageStatus status;
  final AuthUser? user;

  ProfilePageState copyWith({
    ProfilePageStatus Function()? status,
    AuthUser? user,
  }) =>
      ProfilePageState(
        status: status != null ? status() : this.status,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [
        status,
        user,
      ];
}
