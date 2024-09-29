
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_flutter_app/main.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

class MockLogoutCubit extends MockCubit<LogoutState> implements LogoutCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('displays LoginScreen initially', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});

	group('LoginCubit', () {
		late LoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		blocTest<LoginCubit, LoginState>(
			'emits [] when nothing is added',
			build: () => loginCubit,
			expect: () => [],
		);

		blocTest<LoginCubit, LoginState>(
			'emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => loginCubit,
			act: (cubit) => cubit.login('email@example.com', 'password'),
			expect: () => [LoginLoading(), LoginSuccess()],
		);
	});

	group('LogoutCubit', () {
		late LogoutCubit logoutCubit;

		setUp(() {
			logoutCubit = MockLogoutCubit();
		});

		blocTest<LogoutCubit, LogoutState>(
			'emits [] when nothing is added',
			build: () => logoutCubit,
			expect: () => [],
		);

		blocTest<LogoutCubit, LogoutState>(
			'emits [LogoutLoading, LogoutSuccess] when logout is successful',
			build: () => logoutCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [LogoutLoading(), LogoutSuccess()],
		);
	});
}
