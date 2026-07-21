# Backup before clearance-gated optimizer

Created on 2026-07-17 after reviewing runtime `[RRG][OPT]` logs.

The saved version used always-active normalized ESDF force and enabled final
shortcutting. Runtime logs showed frequent `fallback=no_improvement` because
the ESDF force increased path curvature, while shortcutting sometimes reduced
routes from 9 or 11 vertices to only 3 vertices.
