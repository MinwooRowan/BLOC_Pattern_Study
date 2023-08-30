import 'package:bloc_pattern_study/presentation/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              context.push('/bloc');
            },
            child: const Text('BLOC'),
          ),
          ElevatedButton(
            onPressed: () {
              context.push('/cubit');
            },
            child: const Text('CUBIT'),
          ),
        ],
      ),
    ));
  }
}
