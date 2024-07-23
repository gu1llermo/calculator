import 'package:calculator_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: HomeScreen.path,
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  ),
]);
