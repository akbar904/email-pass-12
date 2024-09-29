
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:my_flutter_app/widgets/login_form.dart';
import 'package:my_flutter_app/cubits/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// Mock classes
class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		late LoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		testWidgets('renders email and password TextFields and login Button', (tester) async {
			await tester.pumpWidget(MaterialApp(
				home: BlocProvider.value(
					value: loginCubit,
					child: LoginForm(),
				),
			));

			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
		});

		testWidgets('calls login on login button tap', (tester) async {
			await tester.pumpWidget(MaterialApp(
				home: BlocProvider.value(
					value: loginCubit,
					child: LoginForm(),
				),
			));

			final emailField = find.byKey(Key('email'));
			final passwordField = find.byKey(Key('password'));
			final loginButton = find.widgetWithText(ElevatedButton, 'Login');

			await tester.enterText(emailField, 'test@example.com');
			await tester.enterText(passwordField, 'password123');
			await tester.tap(loginButton);

			verify(() => loginCubit.login('test@example.com', 'password123')).called(1);
		});

		testWidgets('shows error message when login fails', (tester) async {
			whenListen(
				loginCubit,
				Stream.fromIterable([LoginFailure('Login Failed')]),
				initialState: LoginInitial(),
			);

			await tester.pumpWidget(MaterialApp(
				home: BlocProvider.value(
					value: loginCubit,
					child: LoginForm(),
				),
			));

			await tester.pump(); // Rebuild with new state

			expect(find.text('Login Failed'), findsOneWidget);
		});
	});
}
