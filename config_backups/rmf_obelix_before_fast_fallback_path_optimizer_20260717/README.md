# Backup before fast fallback path optimizer

Created on 2026-07-17 from the safe background-preplanning version without
latest-map commit recheck.

This backup contains the RRG, planning parameters, RMF Obelix configuration,
and RViz files immediately before adding:

- collision-checked path shortcutting;
- bounded ESDF local-path smoothing;
- strict optimization time and deviation limits;
- automatic fallback to the pre-optimizer path;
- `/vis/optimized_path` visualization.
