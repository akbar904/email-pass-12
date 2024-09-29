
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/cubits/login_cubit.dart';

class LoginForm extends StatefulWidget {
	@override
	_LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();

	@override
	void dispose() {
		_emailController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return BlocListener<LoginCubit, LoginState>(
			listener: (context, state) {
				if (state is LoginFailure) {
					ScaffoldMessenger.of(context).showSnackBar(
						SnackBar(
							content: Text(state.error),
						),
					);
				}
			},
			child: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					children: [
						TextField(
							key: Key('email'),
							controller: _emailController,
							decoration: InputDecoration(
								labelText: 'Email',
							),
						),
						TextField(
							key: Key('password'),
							controller: _passwordController,
							obscureText: true,
							decoration: InputDecoration(
								labelText: 'Password',
							),
						),
						SizedBox(height: 16.0),
						ElevatedButton(
							onPressed: () {
								final email = _emailController.text;
								final password = _passwordController.text;
								context.read<LoginCubit>().login(email, password);
							},
							child: Text('Login'),
						),
					],
				),
			),
		);
	}
}
