import 'package:flutter/material.dart';

/// Prominent banner at the top of the screen showing whether the equipment
/// is currently safe to work on. This is the single source of truth the
/// user should trust — it only turns green when every isolation step is
/// verified complete.
class StatusBanner extends StatelessWidget {
  final bool isSafe;
  final int completedCount;
  final int totalCount;

  const StatusBanner({
    super.key,
    required this.isSafe,
    required this.completedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final Color color =
    isSafe ? const Color(0xFF1B7A43) : const Color(0xFF8A1F1F);
    final String label = isSafe ? 'SAFE TO WORK' : 'NOT SAFE — DO NOT WORK';
    final IconData icon =
    isSafe ? Icons.check_circle : Icons.warning_amber_rounded;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$completedCount of $totalCount isolation steps complete',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}