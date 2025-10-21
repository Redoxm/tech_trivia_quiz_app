import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/quiz_viewmodel.dart';

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionsProvider);
    final selected = ref.watch(selectedAnswersProvider);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Review'),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                // Start a fresh quiz (invalidate questions so they reshuffle)
                ref.invalidate(questionsProvider);
                ref.read(selectedAnswersProvider.notifier).state = {};
                ref.read(currentIndexProvider.notifier).state = 0;
                context.go('/question/0');
              },
              child: const Text(
                'New Quiz',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                context.go('/result');
              },
              child: const Text('Done', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: questions.length,
          itemBuilder: (context, i) {
            final q = questions[i];
            final sel = selected[q.id];
            final correct = q.correctIndex;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Q${i + 1}. ${q.question}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(q.options.length, (idx) {
                      final option = q.options[idx];
                      final isUser = sel == idx;
                      final isCorrect = correct == idx;
                      Color? bg;
                      if (isCorrect) bg = Colors.green.shade50;
                      if (isUser && !isCorrect) bg = Colors.red.shade50;
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        color: bg,
                        child: ListTile(
                          title: Text(option),
                          leading: isCorrect
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : isUser
                              ? const Icon(
                                  Icons.radio_button_checked,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.circle_outlined),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
