import 'package:flutter/material.dart';
import '../models/loto_step.dart';
import '../widgets/step_card.dart';
import '../widgets/status_banner.dart';

/// The whole simulator is a single 6-state state machine: each LotoStep is
/// either completed or not, and exactly one incomplete step is "active"
/// (the next one in order). isSafe becomes true only when every step is
/// completed — that single boolean is what the rest of the app trusts.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<LotoStep> steps;

  @override
  void initState() {
    super.initState();
    steps = buildLotoSteps();
  }

  int get completedCount => steps.where((s) => s.isCompleted).length;

  bool get isSafe => completedCount == steps.length;

  /// Index of the first incomplete step, i.e. the one the user must do
  /// next. Returns steps.length (out of range) once everything is done,
  /// which is fine since nothing indexes into it at that point.
  int get activeIndex {
    final index = steps.indexWhere((s) => !s.isCompleted);
    return index == -1 ? steps.length : index;
  }

  void _completeStep(int index) {
    setState(() {
      steps[index].isCompleted = true;
    });
  }

  void _reset() {
    setState(() {
      steps = buildLotoSteps();
    });
  }

  /// Simulates someone trying to start the equipment. In a real system this
  /// would read a physical zero-energy verification; here it just checks
  /// [isSafe] and shows the outcome, including the danger case.
  void _attemptStart() {
    final String message = isSafe
        ? 'Equipment start confirmed de-energized. Safe to proceed.'
        : 'DANGER: Equipment is not fully isolated. Do not attempt to start.';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2530),
        icon: Icon(
          isSafe ? Icons.check_circle : Icons.dangerous,
          color: isSafe ? const Color(0xFF1B7A43) : const Color(0xFFC0392B),
          size: 40,
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF14181F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF14181F),
        elevation: 0,
        title: const Text(
          'LOTO Safety Simulator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset simulation',
            onPressed: _reset,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              StatusBanner(
                isSafe: isSafe,
                completedCount: completedCount,
                totalCount: steps.length,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    final StepStatus status = steps[index].isCompleted
                        ? StepStatus.completed
                        : index == activeIndex
                        ? StepStatus.active
                        : StepStatus.locked;
                    return StepCard(
                      step: steps[index],
                      status: status,
                      onComplete: () => _completeStep(index),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _attemptStart,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Attempt to Start Equipment'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withOpacity(0.3)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}