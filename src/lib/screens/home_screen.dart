
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/cubits/logout_cubit.dart';

class HomeScreen extends StatelessWidget {
	const HomeScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Home Screen'),
			),
			body: Center(
				child: ElevatedButton(
					onPressed: () {
						context.read<LogoutCubit>().logout();
					},
					child: const Text('Logout'),
				),
			),
		);
	}
}
