import 'package:flutter/material.dart';
import 'package:quiosque/app/core/config/env/env.dart';
import 'package:quiosque/app/quiosque.dart';

Future<void> main() async {
  await Env.i.load();
  runApp(Quiosque());
}
