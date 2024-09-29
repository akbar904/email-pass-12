
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/login_cubit.dart';
import 'cubits/logout_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MultiBlocProvider(
			providers: [
				BlocProvider<LoginCubit>(
					create: (context) => LoginCubit(),
				),
				BlocProvider<LogoutCubit>(
					create: (context) => LogoutCubit(),
				),
			],
			child: MaterialApp(
				title: 'My Flutter App',
				theme: ThemeData(
					primarySwatch: Colors.blue,
				),
				home: LoginScreen(),
			),
		);
	}
}
