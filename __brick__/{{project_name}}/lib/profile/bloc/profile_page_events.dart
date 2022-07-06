import 'package:equatable/equatable.dart';

abstract class ProfilePageEvents extends Equatable {
  const ProfilePageEvents();

  @override
  List<Object> get props => [];
}

class UserRequested extends ProfilePageEvents {
  const UserRequested();
}
