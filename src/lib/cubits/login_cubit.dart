
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:com.example.my_flutter_app/models/user_model.dart';

// States
abstract class LoginState extends Equatable {
	const LoginState();

	@override
	List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
	final User user;

	const LoginSuccess(this.user);

	@override
	List<Object> get props => [user];
}

class LoginFailure extends LoginState {
	final String error;

	const LoginFailure(this.error);

	@override
	List<Object> get props => [error];
}

// Cubit
class LoginCubit extends Cubit<LoginState> {
	LoginCubit() : super(LoginInitial());

	void login(String email, String password) async {
		try {
			emit(LoginLoading());

			// Simulate a network call
			await Future.delayed(Duration(seconds: 2));

			// Simulated user data for success scenario
			if (email == 'test@example.com' && password == 'password') {
				final user = User(id: '1', name: 'Test User', email: email);
				emit(LoginSuccess(user));
			} else {
				emit(LoginFailure('Invalid email or password'));
			}
		} catch (e) {
			emit(LoginFailure(e.toString()));
		}
	}
}
