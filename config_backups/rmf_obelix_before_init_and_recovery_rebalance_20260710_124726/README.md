# Backup before init motion and start recovery rebalance

Created: 2026-07-10 12:47:26

Purpose:
- Preserve current rmf_obelix simulation config and RRG source before enabling PCI init motion and making start recovery prefer a longer/cleaner escape from dirty start.

Files:
- planner_control_interface_sim_config.yaml
- gbplanner_config.yaml
- rrg.cpp
