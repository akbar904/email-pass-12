
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_flutter_app/screens/login_screen.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginScreen', () {
		late MockLoginCubit mockLoginCubit;

		setUp(() {
			mockLoginCubit = MockLoginCubit();
		});

		testWidgets('should display login form', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: mockLoginCubit,
						child: LoginScreen(),
					),
				),
			);

			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});

		blocTest<MockLoginCubit, LoginState>(
			'emits [] when nothing is added',
			build: () => mockLoginCubit,
			expect: () => [],
		);

		blocTest<MockLoginCubit, LoginState>(
			'emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => mockLoginCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [
				LoginLoading(),
				LoginSuccess(),
			],
		);

		blocTest<MockLoginCubit, LoginState>(
			'emits [LoginLoading, LoginFailure] when login fails',
			build: () => mockLoginCubit,
			act: (cubit) => cubit.login('test@example.com', 'wrong_password'),
			expect: () => [
				LoginLoading(),
				LoginFailure('Invalid credentials'),
			],
		);
	});
}
