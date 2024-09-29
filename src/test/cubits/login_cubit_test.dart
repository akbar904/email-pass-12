
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.my_flutter_app/cubits/login_cubit.dart';

// Mocking dependencies if any, used directly within login_cubit.dart
class MockUserModel extends Mock implements User {}

void main() {
	group('LoginCubit Tests', () {
		late LoginCubit loginCubit;
		late MockUserModel mockUser;

		setUp(() {
			loginCubit = LoginCubit();
			mockUser = MockUserModel();
		});

		tearDown(() {
			loginCubit.close();
		});

		blocTest<LoginCubit, LoginState>(
			'emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => loginCubit,
			act: (cubit) {
				when(() => mockUser.email).thenReturn('test@example.com');
				when(() => mockUser.password).thenReturn('password');
				cubit.login(mockUser.email, mockUser.password);
			},
			expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()],
		);

		blocTest<LoginCubit, LoginState>(
			'emits [LoginLoading, LoginFailure] when login fails',
			build: () => loginCubit,
			act: (cubit) {
				when(() => mockUser.email).thenReturn('wrong@example.com');
				when(() => mockUser.password).thenReturn('wrongpassword');
				cubit.login(mockUser.email, mockUser.password);
			},
			expect: () => [isA<LoginLoading>(), isA<LoginFailure>()],
		);
	});
}
