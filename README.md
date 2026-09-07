# LOTO Safety Simulator

A Flutter app that simulates a Lockout-Tagout (LOTO) procedure — the
standard industrial process for safely isolating equipment from every
energy source before maintenance work begins.

It's built as a portfolio piece demonstrating **"safe electrical power
switching and isolation"** as a practical, working state machine rather
than just a line on a CV.

## What it does

The app walks through the six real LOTO steps in strict order:

1. Identify Energy Sources
2. Notify Affected Personnel
3. Shut Down Equipment
4. Isolate Energy Source
5. Apply Lock & Tag
6. Verify Zero Energy

Only one step is ever active at a time — you can't skip ahead. The status
banner at the top only turns green ("SAFE TO WORK") once all six are
complete. There's also an **"Attempt to Start Equipment"** button that
simulates what happens if someone tries to start the equipment before
isolation is finished — it shows a hazard warning, since that's exactly
the failure mode LOTO exists to prevent.

## Project structure

```
loto_simulator/
├── pubspec.yaml
├── README.md
└── lib/
    ├── main.dart                 # App entry point, theme
    ├── models/
    │   └── loto_step.dart        # LotoStep data model + the 6 step definitions
    ├── widgets/
    │   ├── status_banner.dart    # Top banner: SAFE / NOT SAFE
    │   └── step_card.dart        # One card per step (locked/active/completed)
    └── screens/
        └── home_screen.dart      # State machine driving the whole simulation
```

The core logic lives in `home_screen.dart`:
- `completedCount` / `isSafe` — derived from the step list, not stored
  separately, so the UI can never get out of sync with the actual state.
- `activeIndex` — finds the first incomplete step; that's the only step
  the UI lets you interact with, which is what enforces the ordering.

## How to run it

You'll need the Flutter SDK installed (you already have this from your
DEPI track). From inside the `loto_simulator` folder:

```bash
flutter pub get
flutter run
```

Pick any connected device, emulator, or Chrome when prompted.

## Ideas to extend it

- **Multiple equipment items** — turn `steps` into a list of equipment,
  each with its own 6-step sequence, to simulate isolating several
  circuits at once (closer to a real multi-source system).
- **Persistence** — save progress with `shared_preferences` so a
  half-finished sequence survives an app restart.
- **Simulated sensor input** — replace the "Verify Zero Energy" button
  with a mock voltage reading that has to drop below a threshold before
  the step can be marked complete.
- **Audit log** — timestamp each step completion and show a summary at
  the end, similar to a real LOTO permit sign-off sheet.
