import 'package:cinema_reservations/app/routes.dart';
import 'package:cinema_reservations/app/theme.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';
import 'package:string_validator/string_validator.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text='admin';
    _passwordController.text='admin';
  }

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
                    decoration: AppTheme.defaultTextInputStyle('Login'),
                    validator: (value) => _validateEmail(value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: AppTheme.defaultTextInputStyle('Password'),
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    validator: (value) => _validatePassword(value),
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

  void _login(BuildContext context) async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    final result = await Provider.of<AppState>(context, listen: false).logIn(_emailController.text, _passwordController.text);
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign in. Email and/or password are invalid.')));
      return;
    }
    context.vRouter.to(Routes.main);
  }

  void _register(BuildContext context) async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    final result = await Provider.of<AppState>(context, listen: false).logIn(_emailController.text, _passwordController.text);
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign up. Change email or try again later. If you already have an account, sign in.')));
      return;
    }
    context.vRouter.to(Routes.main);
  }

  void _changeMode() {
    setState(() {
      mode = !mode;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!isAlphanumeric(value)) {
      return 'This is not a valid login';
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (!isAlphanumeric(value)) {
      return 'Password can contain only letters and numbers';
    }
    return null;
  }
}
