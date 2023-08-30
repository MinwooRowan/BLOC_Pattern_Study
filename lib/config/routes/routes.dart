import 'package:bloc_pattern_study/presentation/screens/home_bloc_screen.dart';
import 'package:bloc_pattern_study/presentation/screens/home_cubit_screen.dart';
import 'package:bloc_pattern_study/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'bloc',
          builder: (context, state) => const HomeBlocScreen(),
        ),
        GoRoute(
          path: 'cubit',
          builder: (context, state) => const HomeCubitScreen(),
        ),
      ],
    ),
  ],
);
