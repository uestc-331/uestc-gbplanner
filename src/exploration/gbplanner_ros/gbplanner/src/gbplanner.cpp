#include "gbplanner/gbplanner.h"

#include <nav_msgs/Path.h>

namespace explorer {

Gbplanner::Gbplanner(const ros::NodeHandle& nh,
                     const ros::NodeHandle& nh_private)
    : nh_(nh), nh_private_(nh_private) {
  ROS_INFO("[GBPLANNER] ========================================");
  ROS_INFO("[GBPLANNER] Initializing Gbplanner...");
  ROS_INFO("[GBPLANNER] ========================================");
  
  planner_status_ = Gbplanner::PlannerStatus::NOT_READY;
  ROS_INFO("[GBPLANNER] Planner status set to NOT_READY");

  ROS_INFO("[GBPLANNER] Creating RRG planner...");
  rrg_ = new Rrg(nh, nh_private);
  ROS_INFO("[GBPLANNER] RRG planner created successfully");
  
  ROS_INFO("[GBPLANNER] Loading parameters...");
  if (!(rrg_->loadParams(false))) {
    ROS_ERROR("[GBPLANNER] ERROR: Could not load all required parameters. Shutting down ROS node.");
    ros::shutdown();
    return;
  }
  ROS_INFO("[GBPLANNER] Parameters loaded successfully");

  ROS_INFO("[GBPLANNER] Initializing attributes (services and subscribers)...");
  initializeAttributes();
  ROS_INFO("[GBPLANNER] ========================================");
  ROS_INFO("[GBPLANNER] Gbplanner initialization completed!");
  ROS_INFO("[GBPLANNER] ========================================");
}

Gbplanner::Gbplanner(const ros::NodeHandle& nh,
                     const ros::NodeHandle& nh_private,
                     MapManagerVoxblox<MapManagerVoxbloxServer,
                                       MapManagerVoxbloxVoxel>* map_manager)
    : nh_(nh), nh_private_(nh_private) {
  ROS_INFO("[GBPLANNER] ========================================");
  ROS_INFO("[GBPLANNER] Initializing Gbplanner (with external map_manager)...");
  ROS_INFO("[GBPLANNER] ========================================");
  
  planner_status_ = Gbplanner::PlannerStatus::NOT_READY;
  ROS_INFO("[GBPLANNER] Planner status set to NOT_READY");

  ROS_INFO("[GBPLANNER] Creating RRG planner with external map_manager...");
  rrg_ = new Rrg(nh, nh_private, map_manager);
  ROS_INFO("[GBPLANNER] RRG planner created successfully");

  ROS_INFO("[GBPLANNER] Loading parameters (skip_map_manager=true)...");
  if (!(rrg_->loadParams(true))) {
    ROS_ERROR("[GBPLANNER] ERROR: Could not load all required parameters. Shutting down ROS node.");
    ros::shutdown();
    return;
  }
  ROS_INFO("[GBPLANNER] Parameters loaded successfully");

  ROS_INFO("[GBPLANNER] Initializing attributes (services and subscribers)...");
  initializeAttributes();
  ROS_INFO("[GBPLANNER] ========================================");
  ROS_INFO("[GBPLANNER] Gbplanner initialization completed!");
  ROS_INFO("[GBPLANNER] ========================================");
}

void Gbplanner::initializeAttributes() {
  ROS_INFO("[GBPLANNER] Registering services...");
  
  planner_service_ = nh_.advertiseService(
      "gbplanner", &Gbplanner::plannerServiceCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner (main planning service)");
  
  global_planner_service_ = nh_.advertiseService(
      "gbplanner/global", &Gbplanner::globalPlannerServiceCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/global");
  
  planner_homing_service_ = nh_.advertiseService(
      "gbplanner/homing", &Gbplanner::homingServiceCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/homing");
  
  planner_set_homing_pos_service_ =
      nh_.advertiseService("gbplanner/set_homing_pos",
                           &Gbplanner::setHomingPosServiceCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/set_homing_pos");
  
  planner_search_service_ = nh_.advertiseService(
      "gbplanner/search", &Gbplanner::plannerSearchServiceCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/search");
  
  planner_passing_gate_service_ = nh_.advertiseService(
      "gbplanner/passing_gate", &Gbplanner::passingGateCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/passing_gate");
  
  planner_set_global_bound_service_ = nh_.advertiseService(
      "gbplanner/set_global_bound", &Gbplanner::setGlobalBound, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/set_global_bound");
  
  planner_set_dynamic_global_bound_service_ =
      nh_.advertiseService("gbplanner/set_dynamic_global_bound",
                           &Gbplanner::setDynamicGlobalBound, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/set_dynamic_global_bound");
  
  planner_clear_untraversable_zones_service_ =
      nh_.advertiseService("gbplanner/clear_untraversable_zones",
                           &Gbplanner::clearUntraversableZones, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/clear_untraversable_zones");
  
  planner_load_graph_service_ = nh_.advertiseService(
      "gbplanner/load_graph", &Gbplanner::plannerLoadGraphCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/load_graph");
  
  planner_save_graph_service_ = nh_.advertiseService(
      "gbplanner/save_graph", &Gbplanner::plannerSaveGraphCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/save_graph");
  
  planner_goto_wp_service_ =
      nh_.advertiseService("gbplanner/go_to_waypoint",
                           &Gbplanner::plannerGotoWaypointCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/go_to_waypoint");
  
  planner_enable_untraversable_polygon_subscriber_service_ =
      nh_.advertiseService(
          "gbplanner/enable_untraversable_polygon_subscriber",
          &Gbplanner::plannerEnableUntraversablePolygonSubscriberCallback,
          this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/enable_untraversable_polygon_subscriber");
  
  planner_set_planning_trigger_mode_service_ = nh_.advertiseService(
      "gbplanner/set_planning_trigger_mode",
      &Gbplanner::plannerSetPlanningTriggerModeCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Service registered: gbplanner/set_planning_trigger_mode");

  ROS_INFO("[GBPLANNER] Subscribing to topics...");
  pose_subscriber_ = nh_.subscribe("pose", 100, &Gbplanner::poseCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Subscribed to: pose");
  
  pose_stamped_subscriber_ =
      nh_.subscribe("pose_stamped", 100, &Gbplanner::poseStampedCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Subscribed to: pose_stamped");
  
  odometry_subscriber_ =
      nh_.subscribe("odometry", 100, &Gbplanner::odometryCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Subscribed to: odometry");
  
  robot_status_subcriber_ =
      nh_.subscribe("/robot_status", 1, &Gbplanner::robotStatusCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Subscribed to: /robot_status");
  
  untraversable_polygon_subscriber_ =
      nh_.subscribe("/traversability_estimation/untraversable_polygon", 100,
                    &Gbplanner::untraversablePolygonCallback, this);
  ROS_INFO("[GBPLANNER]   ✓ Subscribed to: /traversability_estimation/untraversable_polygon");
  
  ROS_INFO("[GBPLANNER] All services and subscribers registered successfully!");
}

bool Gbplanner::plannerGotoWaypointCallback(
    planner_msgs::planner_go_to_waypoint::Request& req,
    planner_msgs::planner_go_to_waypoint::Response& res) {
  ROS_INFO("[GBPLANNER] ========== Go To Waypoint Service Called ==========");
  ROS_INFO("[GBPLANNER] Target waypoint: (%.2f, %.2f, %.2f), frame: %s", 
            req.waypoint.pose.position.x, req.waypoint.pose.position.y, 
            req.waypoint.pose.position.z, req.waypoint.header.frame_id.c_str());
  
  res.path.clear();
  res.path = rrg_->getGlobalPath(req.waypoint);
  
  ROS_INFO("[GBPLANNER] Path generated with %zu waypoints", res.path.size());
  ROS_INFO("[GBPLANNER] ========== Go To Waypoint Service Completed ==========");
  return true;
}

bool Gbplanner::plannerEnableUntraversablePolygonSubscriberCallback(
    std_srvs::SetBool::Request& request,
    std_srvs::SetBool::Response& response) {
  ROS_INFO("[GBPLANNER] ========== Enable Untraversable Polygon Subscriber Service Called ==========");
  ROS_INFO("[GBPLANNER] Request: enable = %s", request.data ? "true" : "false");
  
  if (static_cast<bool>(request.data)) {
    ROS_INFO("[GBPLANNER] Enabling traversability checking...");
    untraversable_polygon_subscriber_ =
        nh_.subscribe("/traversability_estimation/untraversable_polygon", 100,
                      &Gbplanner::untraversablePolygonCallback, this);
    ROS_INFO("[GBPLANNER] Subscribed to: /traversability_estimation/untraversable_polygon");
    ROS_INFO("[GBPLANNER] Gbplanner will now check traversability");
  } else {
    ROS_INFO("[GBPLANNER] Disabling traversability checking...");
    untraversable_polygon_subscriber_.shutdown();
    ROS_INFO("[GBPLANNER] Unsubscribed from: /traversability_estimation/untraversable_polygon");
    ROS_INFO("[GBPLANNER] Gbplanner stops checking traversability");
  }
  response.success = static_cast<unsigned char>(true);
  ROS_INFO("[GBPLANNER] ========== Enable Untraversable Polygon Subscriber Service Completed ==========");
  return true;
}

bool Gbplanner::plannerLoadGraphCallback(
    planner_msgs::planner_string_trigger::Request& req,
    planner_msgs::planner_string_trigger::Response& res) {
  ROS_INFO("[GBPLANNER] ========== Load Graph Service Called ==========");
  ROS_INFO("[GBPLANNER] Loading graph from: %s", req.message.c_str());
  
  res.success = rrg_->loadGraph(req.message);
  
  if (res.success) {
    ROS_INFO("[GBPLANNER] Graph loaded successfully from: %s", req.message.c_str());
  } else {
    ROS_WARN("[GBPLANNER] Failed to load graph from: %s", req.message.c_str());
  }
  ROS_INFO("[GBPLANNER] ========== Load Graph Service Completed ==========");
  return true;
}

bool Gbplanner::plannerSaveGraphCallback(
    planner_msgs::planner_string_trigger::Request& req,
    planner_msgs::planner_string_trigger::Response& res) {
  ROS_INFO("[GBPLANNER] ========== Save Graph Service Called ==========");
  ROS_INFO("[GBPLANNER] Saving graph to: %s", req.message.c_str());
  
  res.success = rrg_->saveGraph(req.message);
  
  if (res.success) {
    ROS_INFO("[GBPLANNER] Graph saved successfully to: %s", req.message.c_str());
  } else {
    ROS_WARN("[GBPLANNER] Failed to save graph to: %s", req.message.c_str());
  }
  ROS_INFO("[GBPLANNER] ========== Save Graph Service Completed ==========");
  return true;
}

bool Gbplanner::setGlobalBound(
    planner_msgs::planner_set_global_bound::Request& req,
    planner_msgs::planner_set_global_bound::Response& res) {
  ROS_INFO("[GBPLANNER] ========== Set Global Bound Service Called ==========");
  ROS_INFO("[GBPLANNER] Get current bound: %s, Reset to default: %s", 
            req.get_current_bound ? "true" : "false",
            req.reset_to_default ? "true" : "false");
  
  if (!req.get_current_bound) {
    ROS_INFO("[GBPLANNER] Setting new global bound...");
    res.success = rrg_->setGlobalBound(req.bound, req.reset_to_default);
    if (res.success) {
      ROS_INFO("[GBPLANNER] Global bound set successfully");
    } else {
      ROS_WARN("[GBPLANNER] Failed to set global bound");
    }
  } else {
    ROS_INFO("[GBPLANNER] Only getting current bound (not setting)");
    res.success = true;
  }

  rrg_->getGlobalBound(res.bound_ret);
  ROS_INFO("[GBPLANNER] Current bound: min=(%.2f, %.2f, %.2f), max=(%.2f, %.2f, %.2f), use_z=%s", 
            res.bound_ret.min_val.x, res.bound_ret.min_val.y, res.bound_ret.min_val.z,
            res.bound_ret.max_val.x, res.bound_ret.max_val.y, res.bound_ret.max_val.z,
            res.bound_ret.use_z_val ? "true" : "false");
  ROS_INFO("[GBPLANNER] ========== Set Global Bound Service Completed ==========");
  return true;
}

bool Gbplanner::setDynamicGlobalBound(
    planner_msgs::planner_dynamic_global_bound::Request& req,
    planner_msgs::planner_dynamic_global_bound::Response& res) {
  ROS_INFO("[GBPLANNER] ========== Set Dynamic Global Bound Service Called ==========");
  ROS_INFO("[GBPLANNER] Calling RRG set dynamic global bound...");
  
  res.success = rrg_->setGlobalBound(req);
  
  if (res.success) {
    ROS_INFO("[GBPLANNER] Dynamic global bound set successfully");
  } else {
    ROS_WARN("[GBPLANNER] Failed to set dynamic global bound");
  }
  ROS_INFO("[GBPLANNER] ========== Set Dynamic Global Bound Service Completed ==========");
  return true;
}

void Gbplanner::setGeofenceManager(
    std::shared_ptr<GeofenceManager> geofence_manager) {
  rrg_->setGeofenceManager(geofence_manager);
}

void Gbplanner::setSharedParams(const RobotParams& robot_params,
                                const BoundedSpaceParams& global_space_params) {
  rrg_->setSharedParams(robot_params, global_space_params);
}

void Gbplanner::setSharedParams(const RobotParams& robot_params,
                                const BoundedSpaceParams& global_space_params,
                                const BoundedSpaceParams& local_space_params) {
  rrg_->setSharedParams(robot_params, global_space_params, local_space_params);
}

bool Gbplanner::passingGateCallback(
    planner_msgs::planner_request_path::Request& req,
    planner_msgs::planner_request_path::Response& res) {
  ROS_INFO("[GBPLANNER] ========== Passing Gate Service Called ==========");
  ROS_INFO("[GBPLANNER] Searching path to pass gate...");
  
  res.path = rrg_->searchPathToPassGate();
  res.bound.mode = res.bound.kExtendedBound;
  
  ROS_INFO("[GBPLANNER] Path generated with %zu waypoints", res.path.size());
  ROS_INFO("[GBPLANNER] Bound mode set to: ExtendedBound");
  ROS_INFO("[GBPLANNER] ========== Passing Gate Service Completed ==========");
  return true;
}

bool Gbplanner::plannerServiceCallback(
    planner_msgs::planner_srv::Request& req,
    planner_msgs::planner_srv::Response& res) {
  ROS_INFO_COND(global_verbosity >= Verbosity::INFO, 
                "[GBPLANNER] ========== Planning Service Called ==========");
  ROS_INFO_COND(global_verbosity >= Verbosity::INFO, 
                "[GBPLANNER] Frame: %s, Bound Mode: %d", 
                req.header.frame_id.c_str(), req.bound_mode);
  ROS_INFO_COND(global_verbosity >= Verbosity::INFO, 
                "[GBPLANNER] Root pose: (%.2f, %.2f, %.2f)", 
                req.root_pose.position.x, req.root_pose.position.y, req.root_pose.position.z);
  
  // Extract setting from the request.
  ROS_INFO("[GBPLANNER] Setting planning parameters...");
  rrg_->setGlobalFrame(req.header.frame_id);
  ROS_INFO("[GBPLANNER]   ✓ Global frame set to: %s", req.header.frame_id.c_str());
  
  rrg_->setBoundMode(static_cast<BoundModeType>(req.bound_mode));
  ROS_INFO("[GBPLANNER]   ✓ Bound mode set to: %d", req.bound_mode);
  
  rrg_->setRootStateForPlanning(req.root_pose);
  ROS_INFO("[GBPLANNER]   ✓ Root state set to: (%.2f, %.2f, %.2f)", 
            req.root_pose.position.x, req.root_pose.position.y, req.root_pose.position.z);

  // Start the planner.
  res.path.clear();
  ROS_INFO("[GBPLANNER] Checking planner status...");
  if (getPlannerStatus() == Gbplanner::PlannerStatus::NOT_READY) {
    ROS_WARN("[GBPLANNER] ERROR: The planner is not ready. Cannot proceed with planning.");
    return false;
  }
  ROS_INFO("[GBPLANNER] Planner status: READY");

  ROS_INFO("[GBPLANNER] Step 1/3: Resetting graph...");
  rrg_->reset();
  ROS_INFO("[GBPLANNER] Graph reset completed");
  
  ROS_INFO("[GBPLANNER] Step 2/3: Building graph (this may take a while)...");
  ros::Time build_start = ros::Time::now();
  Rrg::GraphStatus status = rrg_->buildGraph();
  ros::Time build_end = ros::Time::now();
  double build_duration = (build_end - build_start).toSec();
  ROS_INFO("[GBPLANNER] buildGraph() completed in %.3f seconds with status: %d", 
            build_duration, (int)status);
  switch (status) {
    case Rrg::GraphStatus::OK:
      break;
    case Rrg::GraphStatus::ERR_KDTREE:
      ROS_WARN_COND(global_verbosity >= Verbosity::WARN, "[PLANNER_ERROR] An issue occurred with kdtree data.");
      break;
    case Rrg::GraphStatus::ERR_NO_FEASIBLE_PATH:
      ROS_WARN_COND(global_verbosity >= Verbosity::WARN, "[PLANNER_ERROR] No feasible path was found.");
      break;
    case Rrg::GraphStatus::NOT_OK:
      ROS_WARN_COND(global_verbosity >= Verbosity::WARN, "[GBPLANNER] Resending global path");
      res.path = rrg_->reRunGlobalPlanner();
      break;
    default:
      ROS_WARN_COND(global_verbosity >= Verbosity::WARN, "[PLANNER_ERROR] Error occurred in building graph.");
      break;
  }

  bool global_planner_trig = false;
  if (status == Rrg::GraphStatus::OK) {
    ROS_INFO("[GBPLANNER] Graph built successfully!");
    ROS_INFO("[GBPLANNER] Step 3/3: Evaluating graph (computing exploration gains)...");
    ros::Time eval_start = ros::Time::now();
    status = rrg_->evaluateGraph();
    ros::Time eval_end = ros::Time::now();
    double eval_duration = (eval_end - eval_start).toSec();
    ROS_INFO("[GBPLANNER] evaluateGraph() completed in %.3f seconds with status: %d", 
              eval_duration, (int)status);
    switch (status) {
      case Rrg::GraphStatus::OK:
        break;
      case Rrg::GraphStatus::NO_GAIN:
        ROS_WARN_COND(global_verbosity >= Verbosity::WARN, "[PLANNER_ERROR] No positive gain was found.");
        break;
      case Rrg::GraphStatus::NOT_OK:
        ROS_WARN_COND(global_verbosity >= Verbosity::PLANNER_STATUS, "[GBPLANNER] Very low local gain. Triggering global planner");
        res.path = rrg_->runGlobalPlanner(0, false, false);
        res.status = planner_msgs::planner_srv::Response::kRepositioning;
        break;
      default:
        ROS_WARN_COND(global_verbosity >= Verbosity::WARN, "[PLANNER_ERROR] Error occurred in gain calculation.");
        break;
    }
  }
  if (global_planner_trig) return true;

  if (status == Rrg::GraphStatus::OK) {
    ROS_INFO("[GBPLANNER] Graph evaluation successful!");
    ROS_INFO("[GBPLANNER] Extracting best path...");
    ros::Time path_start = ros::Time::now();
    res.path = rrg_->getBestPath(req.header.frame_id, res.status);
    ros::Time path_end = ros::Time::now();
    double path_duration = (path_end - path_start).toSec();
    
    ROS_INFO("[GBPLANNER] Best path extracted in %.3f seconds", path_duration);
    ROS_INFO("[GBPLANNER] Path details:");
    ROS_INFO("[GBPLANNER]   - Number of waypoints: %zu", res.path.size());
    ROS_INFO("[GBPLANNER]   - Path status: %d", res.status);
    ROS_INFO("[GBPLANNER]   - Planning bound mode: %d", res.planning_bound_mode);
    if (res.path.size() > 0) {
      ROS_INFO("[GBPLANNER]   - First waypoint: (%.2f, %.2f, %.2f)", 
                res.path[0].position.x, 
                res.path[0].position.y, 
                res.path[0].position.z);
      if (res.path.size() > 1) {
        ROS_INFO("[GBPLANNER]   - Last waypoint: (%.2f, %.2f, %.2f)", 
                  res.path[res.path.size()-1].position.x, 
                  res.path[res.path.size()-1].position.y, 
                  res.path[res.path.size()-1].position.z);
      }
    }
  } else {
    ROS_WARN("[GBPLANNER] Planning completed with non-OK status: %d", (int)status);
    ROS_WARN("[GBPLANNER] No path will be returned");
  }
  
  ros::Time total_end = ros::Time::now();
  double total_duration = (total_end - build_start).toSec();
  ROS_INFO("[GBPLANNER] ========== Planning Service Completed ==========");
  ROS_INFO("[GBPLANNER] Total planning time: %.3f seconds", total_duration);
  return true;
}

bool Gbplanner::homingServiceCallback(
    planner_msgs::planner_homing::Request& req,
    planner_msgs::planner_homing::Response& res) {
  ROS_INFO("[GBPLANNER] ========== Homing Service Called ==========");
  ROS_INFO("[GBPLANNER] Frame ID: %s", req.header.frame_id.c_str());
  
  res.path.clear();
  if (getPlannerStatus() == Gbplanner::PlannerStatus::NOT_READY) {
    ROS_WARN("[GBPLANNER] ERROR: The planner is not ready. Cannot generate homing path.");
    return false;
  }
  
  ROS_INFO("[GBPLANNER] Generating homing path...");
  res.path = rrg_->getHomingPath(req.header.frame_id);
  
  ROS_INFO("[GBPLANNER] Homing path generated with %zu waypoints", res.path.size());
  ROS_INFO("[GBPLANNER] ========== Homing Service Completed ==========");
  return true;
}

bool Gbplanner::globalPlannerServiceCallback(
    planner_msgs::planner_global::Request& req,
    planner_msgs::planner_global::Response& res) {
  ROS_INFO("[GBPLANNER] ========== Global Planner Service Called ==========");
  ROS_INFO("[GBPLANNER] Request parameters:");
  ROS_INFO("[GBPLANNER]   - ID: %d", req.id);
  ROS_INFO("[GBPLANNER]   - Not check frontier: %s", req.not_check_frontier ? "true" : "false");
  ROS_INFO("[GBPLANNER]   - Ignore time: %s", req.ignore_time ? "true" : "false");
  
  res.path.clear();
  if (getPlannerStatus() == Gbplanner::PlannerStatus::NOT_READY) {
    ROS_WARN("[GBPLANNER] ERROR: The planner is not ready. Cannot run global planner.");
    return false;
  }
  
  ROS_INFO("[GBPLANNER] Running global planner...");
  res.path =
      rrg_->runGlobalPlanner(req.id, req.not_check_frontier, req.ignore_time);
  
  ROS_INFO("[GBPLANNER] Global path generated with %zu waypoints", res.path.size());
  ROS_INFO("[GBPLANNER] ========== Global Planner Service Completed ==========");
  return true;
}

bool Gbplanner::setHomingPosServiceCallback(
    planner_msgs::planner_set_homing_pos::Request& req,
    planner_msgs::planner_set_homing_pos::Response& res) {
  ROS_INFO("[GBPLANNER] ========== Set Homing Position Service Called ==========");
  
  if (getPlannerStatus() == Gbplanner::PlannerStatus::NOT_READY) {
    ROS_WARN("[GBPLANNER] ERROR: The planner is not ready. Cannot set homing position.");
    return false;
  }
  
  ROS_INFO("[GBPLANNER] Setting current position as homing position...");
  res.success = rrg_->setHomingPos();
  
  if (res.success) {
    ROS_INFO("[GBPLANNER] Homing position set successfully");
  } else {
    ROS_WARN("[GBPLANNER] Failed to set homing position");
  }
  ROS_INFO("[GBPLANNER] ========== Set Homing Position Service Completed ==========");
  return true;
}

bool Gbplanner::plannerSearchServiceCallback(
    planner_msgs::planner_search::Request& req,
    planner_msgs::planner_search::Response& res) {
  ROS_INFO("[GBPLANNER] ========== Search Service Called ==========");
  ROS_INFO("[GBPLANNER] Request parameters:");
  ROS_INFO("[GBPLANNER]   - Bound mode: %d", req.bound_mode);
  ROS_INFO("[GBPLANNER]   - Source: (%.2f, %.2f, %.2f)", 
            req.source.position.x, req.source.position.y, req.source.position.z);
  ROS_INFO("[GBPLANNER]   - Target: (%.2f, %.2f, %.2f)", 
            req.target.position.x, req.target.position.y, req.target.position.z);
  ROS_INFO("[GBPLANNER]   - Use current state: %s", req.use_current_state ? "true" : "false");
  
  rrg_->setBoundMode(static_cast<BoundModeType>(req.bound_mode));
  ROS_INFO("[GBPLANNER] Searching path from source to target...");
  
  res.success =
      rrg_->search(req.source, req.target, req.use_current_state, res.path);
  
  if (res.success) {
    ROS_INFO("[GBPLANNER] Path found with %zu waypoints", res.path.size());
  } else {
    ROS_WARN("[GBPLANNER] Failed to find path from source to target");
  }
  ROS_INFO("[GBPLANNER] ========== Search Service Completed ==========");
  return true;
}

bool Gbplanner::plannerSetPlanningTriggerModeCallback(
    planner_msgs::planner_set_planning_mode::Request& request,
    planner_msgs::planner_set_planning_mode::Response& response) {
  ROS_INFO("[GBPLANNER] ========== Set Planning Trigger Mode Service Called ==========");
  
  PlannerTriggerModeType in_trig_mode;
  if (request.planning_mode == request.kAuto) {
    in_trig_mode = PlannerTriggerModeType::kAuto;
    ROS_INFO("[GBPLANNER] Setting planning trigger mode to: AUTO");
  } else if (request.planning_mode == request.kManual) {
    in_trig_mode = PlannerTriggerModeType::kManual;
    ROS_INFO("[GBPLANNER] Setting planning trigger mode to: MANUAL");
  } else {
    ROS_WARN("[GBPLANNER] Unknown planning mode: %d, defaulting to MANUAL", request.planning_mode);
    in_trig_mode = PlannerTriggerModeType::kManual;
  }
  
  rrg_->setPlannerTriggerMode(in_trig_mode);
  response.success = true;
  
  ROS_INFO("[GBPLANNER] Planning trigger mode set successfully");
  ROS_INFO("[GBPLANNER] ========== Set Planning Trigger Mode Service Completed ==========");
  return true;
}

bool Gbplanner::clearUntraversableZones(std_srvs::Trigger::Request& req,
                                        std_srvs::Trigger::Response& res) {
  ROS_INFO("[GBPLANNER] ========== Clear Untraversable Zones Service Called ==========");
  ROS_INFO("[GBPLANNER] Clearing all untraversable zones...");
  
  rrg_->clearUntraversableZones();
  res.success = true;
  
  ROS_INFO("[GBPLANNER] All untraversable zones cleared successfully");
  ROS_INFO("[GBPLANNER] ========== Clear Untraversable Zones Service Completed ==========");
  return true;
}

void Gbplanner::untraversablePolygonCallback(
    const geometry_msgs::PolygonStamped& polygon_msgs) {
  // Add the new polygon into geofence list
  if (!polygon_msgs.polygon.points.empty()) {
    ROS_WARN("[GBPLANNER] ========== Untraversable Polygon Detected ==========");
    ROS_WARN("[GBPLANNER] Frame: %s", polygon_msgs.header.frame_id.c_str());
    ROS_WARN("[GBPLANNER] Polygon has %zu points", polygon_msgs.polygon.points.size());
    ROS_WARN("[GBPLANNER] Adding to geofence list...");
    
    // Add this to the list
    rrg_->addGeofenceAreas(polygon_msgs);
    
    ROS_WARN("[GBPLANNER] Untraversable polygon added to geofence successfully");
  } else {
    ROS_DEBUG("[GBPLANNER] Received empty untraversable polygon, ignoring");
  }
}

void Gbplanner::setUntraversablePolygon(
    const geometry_msgs::PolygonStamped& polygon_msgs) {
  std::cout << "Untraversable polygon size: "
            << polygon_msgs.polygon.points.size() << std::endl;
  if (!polygon_msgs.polygon.points.empty()) {
    ROS_WARN_COND(global_verbosity >= Verbosity::WARN, "Detected untraversable area");
    // Add this to the list
    rrg_->addGeofenceAreas(polygon_msgs);
  }
}

void Gbplanner::poseCallback(
    const geometry_msgs::PoseWithCovarianceStamped& pose) {
  ROS_DEBUG("[GBPLANNER] Received pose (with covariance) from frame: %s", 
            pose.header.frame_id.c_str());
  processPose(pose.pose.pose);
}

void Gbplanner::poseStampedCallback(const geometry_msgs::PoseStamped& pose) {
  ROS_DEBUG("[GBPLANNER] Received pose_stamped from frame: %s", 
            pose.header.frame_id.c_str());
  processPose(pose.pose);
}

void Gbplanner::processPose(const geometry_msgs::Pose& pose) {
  static int pose_count = 0;
  static ros::Time last_log_time = ros::Time(0);
  ros::Time current_time = ros::Time::now();
  
  StateVec state;
  state[0] = pose.position.x;
  state[1] = pose.position.y;
  state[2] = pose.position.z;
  state[3] = tf::getYaw(pose.orientation);
  rrg_->setState(state);
  
  // Log pose every 5 seconds to avoid spam
  if ((current_time - last_log_time).toSec() > 5.0) {
    ROS_DEBUG("[GBPLANNER] Pose updated: pos=(%.2f, %.2f, %.2f), yaw=%.2f", 
              state[0], state[1], state[2], state[3]);
    last_log_time = current_time;
    pose_count++;
    if (pose_count == 1) {
      ROS_INFO("[GBPLANNER] First pose message received, state updated");
    }
  }
}

void Gbplanner::odometryCallback(const nav_msgs::Odometry& odo) {
  static int odom_count = 0;
  static ros::Time last_log_time = ros::Time(0);
  ros::Time current_time = ros::Time::now();
  
  StateVec state;
  state[0] = odo.pose.pose.position.x;
  state[1] = odo.pose.pose.position.y;
  state[2] = odo.pose.pose.position.z;
  state[3] = tf::getYaw(odo.pose.pose.orientation);
  rrg_->setState(state);
  
  // Log odometry every 5 seconds to avoid spam
  if ((current_time - last_log_time).toSec() > 5.0) {
    ROS_INFO_COND(global_verbosity >= Verbosity::INFO, 
                  "[GBPLANNER] Odometry received: pos=(%.2f, %.2f, %.2f), yaw=%.2f, frame_id=%s", 
                  state[0], state[1], state[2], state[3], odo.header.frame_id.c_str());
    last_log_time = current_time;
    odom_count++;
    if (odom_count == 1) {
      ROS_INFO_COND(global_verbosity >= Verbosity::INFO, 
                    "[GBPLANNER] First odometry message received, planner should be ready now");
    }
  }
}

void Gbplanner::robotStatusCallback(const planner_msgs::RobotStatus& status) {
  static ros::Time last_log_time = ros::Time(0);
  ros::Time current_time = ros::Time::now();
  
  rrg_->setTimeRemaining(status.time_remaining);
  
  // Log robot status every 10 seconds to avoid spam
  if ((current_time - last_log_time).toSec() > 10.0) {
    ROS_INFO("[GBPLANNER] Robot status updated: time_remaining=%.2f seconds", 
              status.time_remaining);
    last_log_time = current_time;
  }
}

Gbplanner::PlannerStatus Gbplanner::getPlannerStatus() {
  // if (!ros::ok()) {
  //   ROS_ERROR("[GBPLANNER] ERROR: ROS node failed.");
  //   return false;
  // }

  // Should have a list of checking conditions to set the planner as ready.
  // For examples:
  // + ROS ok
  // + All params loaded properly
  // + Map is ready to use
  if (planner_status_ == Gbplanner::PlannerStatus::READY) {
    ROS_DEBUG("[GBPLANNER] Planner status: READY");
    return Gbplanner::PlannerStatus::READY;
  }

  ROS_DEBUG("[GBPLANNER] Planner status: READY (default)");
  return Gbplanner::PlannerStatus::READY;
}

}  // namespace explorer
