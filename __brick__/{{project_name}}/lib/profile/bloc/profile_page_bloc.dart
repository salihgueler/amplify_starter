import 'package:bloc/bloc.dart';
import 'package:{{project_name.snakeCase()}}/profile/bloc/profile_page_events.dart';
import 'package:{{project_name.snakeCase()}}/profile/bloc/profile_page_state.dart';
import 'package:{{project_name.snakeCase()}}/profile/domain/user_repository.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvents, ProfilePageState> {
  ProfilePageBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const ProfilePageState()) {
    on<UserRequested>(_onUserReceived);
  }

  final UserRepository _userRepository;

  Future<void> _onUserReceived(
    UserRequested event,
    Emitter<ProfilePageState> emit,
  ) async {
    emit(state.copyWith(status: () => ProfilePageStatus.loading));
    try {
      final user = await _userRepository.getCurrentUser();
      emit(state.copyWith(
        user: user,
        status: () => ProfilePageStatus.success,
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: () => ProfilePageStatus.failure));
    }
  }
}
