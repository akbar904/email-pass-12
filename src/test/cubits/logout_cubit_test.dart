
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_flutter_app/cubits/logout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Mocking the LogoutCubit
class MockLogoutCubit extends MockCubit<void> implements LogoutCubit {}

void main() {
	group('LogoutCubit', () {
		late LogoutCubit logoutCubit;

		setUp(() {
			logoutCubit = LogoutCubit();
		});

		tearDown(() {
			logoutCubit.close();
		});

		test('initial state is correct', () {
			expect(logoutCubit.state, equals(null));
		});

		blocTest<LogoutCubit, void>(
			'emits nothing when logout is called',
			build: () => logoutCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [],
		);
	});
}
