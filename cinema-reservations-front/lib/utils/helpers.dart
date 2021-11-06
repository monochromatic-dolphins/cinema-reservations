import 'package:flutter/material.dart';

void runPostFrame(Function function) => WidgetsBinding.instance?.addPostFrameCallback((_) => function());
