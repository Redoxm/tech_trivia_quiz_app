import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/quiz_viewmodel.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(scoreProvider);
    final total = ref.watch(questionsProvider).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'You scored',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Text(
                '$score / $total',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.go('/review');
                },
                child: const Text('Review Answers'),
              ),
              SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  // reset answers, reset index, refresh questions and go to start
                  ref.invalidate(questionsProvider);
                  ref.read(selectedAnswersProvider.notifier).state = {};
                  ref.read(currentIndexProvider.notifier).state = 0;
                  context.go('/question/0');
                },
                child: const Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
