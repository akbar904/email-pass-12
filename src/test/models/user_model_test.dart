
import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_app/models/user_model.dart';

void main() {
	group('User Model', () {
		test('should correctly serialize from JSON', () {
			final json = {
				'id': '123',
				'name': 'John Doe',
				'email': 'john.doe@example.com',
			};

			final user = User.fromJson(json);

			expect(user.id, '123');
			expect(user.name, 'John Doe');
			expect(user.email, 'john.doe@example.com');
		});

		test('should correctly deserialize to JSON', () {
			final user = User(
				id: '123',
				name: 'John Doe',
				email: 'john.doe@example.com',
			);

			final json = user.toJson();

			expect(json, {
				'id': '123',
				'name': 'John Doe',
				'email': 'john.doe@example.com',
			});
		});
	});
}
