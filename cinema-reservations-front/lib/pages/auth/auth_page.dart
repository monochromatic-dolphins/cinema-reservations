import 'package:cinema_reservations/app/routes.dart';
import 'package:cinema_reservations/app/theme.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class AuthMode {
  static const signInMode = true;
  static const signUpMode = false;
}

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool mode = AuthMode.signInMode;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) => Scaffold(
        body: Center(
          child: Container(
            width: 500,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    mode ? 'Sign in' : 'Sign up',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: AppTheme.defaultTextInputStyle('Email'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: AppTheme.defaultTextInputStyle('Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => mode ? _login(context) : _register(context),
                    child: Text(mode ? 'Login' : 'Register'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => _changeMode(),
                    child: Text(mode ? 'Register a new account' : 'Login with an existing account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    print('logging in');
    Provider.of<AppState>(context, listen: false).logIn();
    context.vRouter.to(Routes.main);
  }

  void _register(BuildContext context) {
    print('register');
    Provider.of<AppState>(context, listen: false).logIn();
    context.vRouter.to(Routes.main);
  }

  void _changeMode() {
    setState(() {
      mode = !mode;
    });
  }
}
