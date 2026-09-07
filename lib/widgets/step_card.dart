
import 'package:flutter/material.dart';
import '../models/loto_step.dart';

/// Visual state of a step card. Only one step is ever [active] at a time —
/// this is what enforces the ordered nature of a real LOTO procedure: you
/// cannot complete step 5 before step 4 has a "Mark Step Complete" button.
enum StepStatus { completed, active, locked }

class StepCard extends StatelessWidget {
  final LotoStep step;
  final StepStatus status;
  final VoidCallback onComplete;

  const StepCard({
    super.key,
    required this.step,
    required this.status,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = status == StepStatus.completed;
    final bool isActive = status == StepStatus.active;
    final bool isLocked = status == StepStatus.locked;

    final Color accent = isCompleted
        ? const Color(0xFF1B7A43) // green — done
        : isActive
        ? const Color(0xFFC7861B) // amber — action required now
        : const Color(0xFF5B6472); // grey — not yet reachable

    return AnimatedOpacity(
      opacity: isLocked ? 0.5 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2530),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? accent : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted ? Icons.check : step.icon,
                color: accent,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step ${step.id} · ${step.title}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.65),
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                  if (isActive) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onComplete,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Mark Step Complete'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}