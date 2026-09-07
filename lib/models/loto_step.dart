import 'package:flutter/material.dart';

/// A single step in a Lockout-Tagout (LOTO) isolation procedure.
///
/// Each real LOTO program follows a fixed, ordered sequence — you cannot
/// isolate before you've identified the energy sources, and you cannot
/// verify zero energy before the lock and tag are applied. The [id] field
/// preserves that order; the UI enforces it (see HomeScreen.activeIndex).
class LotoStep {
  final int id;
  final String title;
  final String description;
  final IconData icon;
  bool isCompleted;

  LotoStep({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.isCompleted = false,
  });
}

/// Returns a fresh, uncompleted set of the six standard LOTO steps.
///
/// Called on app start and on reset — returning a new list (rather than
/// mutating a shared one) avoids stale `isCompleted` state leaking into
/// a new simulation run.
List<LotoStep> buildLotoSteps() {
  return [
    LotoStep(
      id: 1,
      title: 'Identify Energy Sources',
      description:
      'Locate every electrical, mechanical, hydraulic, or stored energy '
          'source feeding the equipment. Missing one is the most common '
          'cause of LOTO failures in the field.',
      icon: Icons.bolt,
    ),
    LotoStep(
      id: 2,
      title: 'Notify Affected Personnel',
      description:
      'Inform everyone who works with or near the equipment that it is '
          'about to be shut down and locked out, before you touch anything.',
      icon: Icons.campaign,
    ),
    LotoStep(
      id: 3,
      title: 'Shut Down Equipment',
      description:
      'Turn off the equipment using its normal stopping procedure — '
          'switch, button, or valve — not by pulling the isolation point.',
      icon: Icons.power_settings_new,
    ),
    LotoStep(
      id: 4,
      title: 'Isolate Energy Source',
      description:
      'Open the disconnect switch, circuit breaker, or valve so the '
          'equipment is physically separated from every energy source.',
      icon: Icons.link_off,
    ),
    LotoStep(
      id: 5,
      title: 'Apply Lock & Tag',
      description:
      'Attach your personal lock and a warning tag to the isolation '
          'point so it cannot be re-energized without your knowledge.',
      icon: Icons.lock,
    ),
    LotoStep(
      id: 6,
      title: 'Verify Zero Energy',
      description:
      'Test with a calibrated meter and try the start control to '
          'confirm the equipment is truly de-energized before work begins.',
      icon: Icons.fact_check,
    ),
  ];
}