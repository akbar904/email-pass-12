
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/cubits/login_cubit.dart';
import 'package:my_flutter_app/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: BlocProvider(
					create: (context) => LoginCubit(),
					child: LoginForm(),
				),
			),
		);
	}
}
