import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/quiz_viewmodel.dart';

class QuestionScreen extends ConsumerStatefulWidget {
  final int index;
  final int secondsPerQuestion;
  const QuestionScreen({
    super.key,
    required this.index,
    this.secondsPerQuestion = 20,
  });

  @override
  ConsumerState<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends ConsumerState<QuestionScreen> {
  Timer? _timer;
  late int _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = widget.secondsPerQuestion;
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant QuestionScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index ||
        oldWidget.secondsPerQuestion != widget.secondsPerQuestion) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _remaining = widget.secondsPerQuestion;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _remaining--;
      });
      if (_remaining <= 0) {
        t.cancel();
        _onTimeout();
      }
    });
  }

  void _onTimeout() {
    // On timeout: if not last question, advance; otherwise go to results.
    final questions = ref.read(questionsProvider);
    if (widget.index < questions.length - 1) {
      // leave answer as-is (unanswered if none selected)
      context.go('/question/${widget.index + 1}');
    } else {
      context.go('/result');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(quizViewModelProvider);
    final questions = ref.watch(questionsProvider);

    final index = widget.index;
    if (index < 0 || index >= questions.length) {
      return Scaffold(body: Center(child: Text('Question not found')));
    }

    final q = questions[index];
    final selected = ref.watch(selectedAnswersProvider)[q.id];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${index + 1} / ${questions.length}'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text('$_remaining', style: const TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(q.question, style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 20),
            ...List.generate(q.options.length, (i) {
              final opt = q.options[i];
              final isSelected = selected == i;
              return Card(
                color: isSelected ? Colors.indigo.shade50 : Colors.white,
                child: ListTile(
                  title: Text(opt),
                  leading: Radio<int>(
                    value: i,
                    // ignore: deprecated_member_use
                    groupValue: selected,
                    // ignore: deprecated_member_use
                    onChanged: (v) {
                      viewModel.selectAnswer(q.id, v!);
                    },
                  ),
                  onTap: () => viewModel.selectAnswer(q.id, i),
                ),
              );
            }),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (index > 0) {
                      context.go('/question/${index - 1}');
                    }
                  },
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (index < questions.length - 1) {
                      context.go('/question/${index + 1}');
                    } else {
                      context.go('/result');
                    }
                  },
                  child: Text(index < questions.length - 1 ? 'Next' : 'Finish'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
