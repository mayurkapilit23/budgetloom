import 'package:budgetloom/features/auth/bloc/auth_event.dart';
import 'package:budgetloom/features/auth/bloc/auth_state.dart';
import 'package:budgetloom/features/auth/repositories/firebase_auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthRepo firebaseAuthRepo;
  AuthBloc(this.firebaseAuthRepo) : super(AuthInitial()) {
    // on<CheckAuthEvent>((event, emit) {
    //   emit(Authenticated());
    // });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      final userCredential = firebaseAuthRepo.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      // Get the UID
      final uid = await userCredential;

      emit(Authenticated(userId: uid ?? 'unknown_user'));
    });
    on<LogoutEvent>((event, emit) {
      emit(Unauthenticated());
    });
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      final userCredential = firebaseAuthRepo.registerWithEmailAndPassword(
        event.email,
        event.password,
      );

      // Get the UID
      final uid = await userCredential;

      emit(Authenticated(userId: uid ?? 'unknown_user'));
      emit(AuthInitial());
    });
  }
}
