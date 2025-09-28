import 'package:flutter_absensi_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLocalDataSource _authLocalDataSource;

  AuthBloc(this._authLocalDataSource) : super(const _Initial()) {
    on<_IsLoggedIn>((event, emit) async {
      final isLoggedIn = await _authLocalDataSource.isLoggedIn();

      if (isLoggedIn) {
        emit(const AuthState.authenticated());
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }
}
