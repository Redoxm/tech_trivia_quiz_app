import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'views/welcome_screen.dart';
import 'views/question_screen.dart';
import 'views/result_screen.dart';
import 'views/review_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: TechTriviaApp()));
}

class TechTriviaApp extends ConsumerWidget {
  const TechTriviaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
        GoRoute(
          path: '/question/:index',
          builder: (context, state) {
            final idx = int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
            return QuestionScreen(index: idx);
          },
        ),
        GoRoute(
          path: '/result',
          builder: (context, state) => const ResultScreen(),
        ),
        GoRoute(
          path: '/review',
          builder: (context, state) => const ReviewScreen(),
        ),
        // no-op: root handled above as welcome screen
      ],
    );

    final seed = Colors.indigo;
    final baseScheme = ColorScheme.fromSeed(seedColor: seed);
    final textTheme = GoogleFonts.interTextTheme();

    final theme = ThemeData(
      colorScheme: baseScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: AppBarTheme(
        backgroundColor: baseScheme.primary,
        foregroundColor: baseScheme.onPrimary,
        elevation: 2,
        centerTitle: true,
      ),
      textTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: baseScheme.primary,
          foregroundColor: baseScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
      ),
      // cardTheme removed for SDK compatibility; default card styling will be used
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: baseScheme.primary,
      ),
    );

    return MaterialApp.router(
      title: 'Tech Trivia Quiz',
      theme: theme,
      routerConfig: _router,
    );
  }
}
