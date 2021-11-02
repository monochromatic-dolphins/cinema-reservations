import 'package:cinema_reservations/app/custom_app_bar.dart';
import 'package:cinema_reservations/app/theme.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MovieCrudPage extends StatefulWidget {
  const MovieCrudPage({Key? key}) : super(key: key);

  @override
  _MovieCrudPageState createState() => _MovieCrudPageState();
}

class _MovieCrudPageState extends State<MovieCrudPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Add new movie',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 36),
                  TextFormField(
                    controller: _titleController,
                    decoration: AppTheme.defaultTextInputStyle('Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _durationController,
                    decoration: AppTheme.defaultTextInputStyle('Duration'),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value cannot be empty';
                      }
                      try {
                        final result = int.parse(value);
                        if (result < 1 || result > 15) {
                          return 'Value must be between 1 and 450';
                        }
                      } catch (e) {
                        return 'Value must be a number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _validateAndCreate(),
                    child: Text('Create'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndCreate() {
    if (_formKey.currentState?.validate() == false) {
      return;
    }
    Provider.of<AppState>(context, listen: false).createMovie(_titleController.text, _durationController.text);
  }
}
