
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/screens/home_screen.dart';
import 'package:my_flutter_app/cubits/logout_cubit.dart';

// Mock LogoutCubit
class MockLogoutCubit extends MockCubit<void> implements LogoutCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('should display "Home Screen" text', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider<LogoutCubit>(
					create: (_) => MockLogoutCubit(),
					child: const HomeScreen(),
				),
			);

			expect(find.text('Home Screen'), findsOneWidget);
		});

		testWidgets('should display logout button', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider<LogoutCubit>(
					create: (_) => MockLogoutCubit(),
					child: const HomeScreen(),
				),
			);

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('should call logout when logout button is pressed', (WidgetTester tester) async {
			final mockLogoutCubit = MockLogoutCubit();

			await tester.pumpWidget(
				BlocProvider<LogoutCubit>(
					create: (_) => mockLogoutCubit,
					child: const HomeScreen(),
				),
			);

			await tester.tap(find.byType(ElevatedButton));
			verify(() => mockLogoutCubit.logout()).called(1);
		});
	});
}
