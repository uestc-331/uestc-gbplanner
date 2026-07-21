# Backup before blocked-root recovery and aerial global-height fix

Created on 2026-07-17 after a runtime stall with repeated RRG graphs containing
one vertex and zero edges.

The same run showed global paths starting 0.20 m above the current aerial
state because ground-height projection was also applied to aerial robots. The
resulting first segment was rejected by the reduced Global height bound.
