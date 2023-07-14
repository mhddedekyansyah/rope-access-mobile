import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rope_access/models/login_form_model.dart';
import 'package:rope_access/models/register_form_model.dart';
import 'package:rope_access/models/user_model.dart';
import 'package:rope_access/repositories/auth/auth_repository.dart';
import 'package:rope_access/storage/app_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(UnAuthenthicated()) {
    on<RegisterEvent>((event, emit) async {
      try {
        emit(AuthLoading());

        final UserModel user = await _authRepository.register(event.data);
        await AppStorage().write('password', event.data.password);
        await AppStorage().write('email', event.data.email);
        await AppStorage().write('token', user.token);

        emit(Authenthicated(user: user));
      } catch (e) {
        emit(AuthFailed(message: e.toString()));
      }
    });
    on<LoginEvent>((event, emit) async {
      try {
        emit(AuthLoading());

        final UserModel user = await _authRepository.login(event.data);
        await AppStorage().write('password', event.data.password);
        await AppStorage().write('email', event.data.email);
        await AppStorage().write('token', user.token);

        emit(Authenthicated(user: user));
      } catch (e) {
        emit(AuthFailed(message: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(UnAuthenthicated());
      await _authRepository.logout(event.token);
      await AppStorage().clear();
    });

    on<GetCurrentUser>((event, emit) async {
      try {
        final String password = await AppStorage().read('password');
        final String email = await AppStorage().read('email');
        final UserModel user = await _authRepository
            .login(LoginFormModel(email: email, password: password));

        emit(Authenthicated(user: user));
      } catch (e) {
        emit(UnAuthenthicated());
        emit(AuthFailed(message: e.toString()));
      }
    });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    UserModel user = UserModel.fromJson(json);
    return Authenthicated(user: user);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is Authenthicated) {
      // print('user from hydrated ${state.user.toJson()}');

      return state.user.toJson();
    } else {
      return null;
    }
  }
}
