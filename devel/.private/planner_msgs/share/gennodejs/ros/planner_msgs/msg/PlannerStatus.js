// Auto-generated. Do not edit!

// (in-package planner_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let TriggerMode = require('./TriggerMode.js');
let BoundMode = require('./BoundMode.js');
let PlanningMode = require('./PlanningMode.js');
let ExecutionPathMode = require('./ExecutionPathMode.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class PlannerStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.success = null;
      this.trigger_mode = null;
      this.bound_mode = null;
      this.planning_mode = null;
      this.exe_path_mode = null;
      this.max_vel = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('trigger_mode')) {
        this.trigger_mode = initObj.trigger_mode
      }
      else {
        this.trigger_mode = new TriggerMode();
      }
      if (initObj.hasOwnProperty('bound_mode')) {
        this.bound_mode = initObj.bound_mode
      }
      else {
        this.bound_mode = new BoundMode();
      }
      if (initObj.hasOwnProperty('planning_mode')) {
        this.planning_mode = initObj.planning_mode
      }
      else {
        this.planning_mode = new PlanningMode();
      }
      if (initObj.hasOwnProperty('exe_path_mode')) {
        this.exe_path_mode = initObj.exe_path_mode
      }
      else {
        this.exe_path_mode = new ExecutionPathMode();
      }
      if (initObj.hasOwnProperty('max_vel')) {
        this.max_vel = initObj.max_vel
      }
      else {
        this.max_vel = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PlannerStatus
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [trigger_mode]
    bufferOffset = TriggerMode.serialize(obj.trigger_mode, buffer, bufferOffset);
    // Serialize message field [bound_mode]
    bufferOffset = BoundMode.serialize(obj.bound_mode, buffer, bufferOffset);
    // Serialize message field [planning_mode]
    bufferOffset = PlanningMode.serialize(obj.planning_mode, buffer, bufferOffset);
    // Serialize message field [exe_path_mode]
    bufferOffset = ExecutionPathMode.serialize(obj.exe_path_mode, buffer, bufferOffset);
    // Serialize message field [max_vel]
    bufferOffset = _serializer.float32(obj.max_vel, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PlannerStatus
    let len;
    let data = new PlannerStatus(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [trigger_mode]
    data.trigger_mode = TriggerMode.deserialize(buffer, bufferOffset);
    // Deserialize message field [bound_mode]
    data.bound_mode = BoundMode.deserialize(buffer, bufferOffset);
    // Deserialize message field [planning_mode]
    data.planning_mode = PlanningMode.deserialize(buffer, bufferOffset);
    // Deserialize message field [exe_path_mode]
    data.exe_path_mode = ExecutionPathMode.deserialize(buffer, bufferOffset);
    // Deserialize message field [max_vel]
    data.max_vel = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 22;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner_msgs/PlannerStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '457dd68e31cf1be9ac36510d1cf7cba5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool success
    planner_msgs/TriggerMode trigger_mode
    planner_msgs/BoundMode bound_mode
    planner_msgs/PlanningMode planning_mode
    planner_msgs/ExecutionPathMode exe_path_mode
    float32 max_vel
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    ================================================================================
    MSG: planner_msgs/TriggerMode
    # Trigger mode of planner control interface, defined in PlannerTriggerModeType.
    int32 kManual = 0
    int32 kAuto = 1
    
    # Set one of above values.
    int32 mode
    ================================================================================
    MSG: planner_msgs/BoundMode
    # Bound mode of the robot for collision checking, defined in Params/BoundModeType.
    int32 kExtendedBound = 0
    int32 kRelaxedBound = 1
    int32 kMinBound = 2
    int32 kExactBound = 3
    int32 kNoBound = 4
    
    # Set one of above values.
    int32 mode
    ================================================================================
    MSG: planner_msgs/PlanningMode
    # Planning mode for exploration, defined in Params/PlanningModeType.
    int32 kBasicExploration = 0
    int32 kNarrowEnvExploration = 1
    int32 kAdaptiveExploration = 2
    
    # Set one of above values.
    int32 mode
    ================================================================================
    MSG: planner_msgs/ExecutionPathMode
    # Execution path mode, defined in ExecutionPathType.
    int32 kLocalPath = 0
    int32 kHomingPath = 1
    int32 kGlobalPath = 2
    
    # Set one of above values.
    int32 mode
    
    # The path is in forward direction compared to current exploration direction or not
    bool is_forward
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PlannerStatus(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.trigger_mode !== undefined) {
      resolved.trigger_mode = TriggerMode.Resolve(msg.trigger_mode)
    }
    else {
      resolved.trigger_mode = new TriggerMode()
    }

    if (msg.bound_mode !== undefined) {
      resolved.bound_mode = BoundMode.Resolve(msg.bound_mode)
    }
    else {
      resolved.bound_mode = new BoundMode()
    }

    if (msg.planning_mode !== undefined) {
      resolved.planning_mode = PlanningMode.Resolve(msg.planning_mode)
    }
    else {
      resolved.planning_mode = new PlanningMode()
    }

    if (msg.exe_path_mode !== undefined) {
      resolved.exe_path_mode = ExecutionPathMode.Resolve(msg.exe_path_mode)
    }
    else {
      resolved.exe_path_mode = new ExecutionPathMode()
    }

    if (msg.max_vel !== undefined) {
      resolved.max_vel = msg.max_vel;
    }
    else {
      resolved.max_vel = 0.0
    }

    return resolved;
    }
};

module.exports = PlannerStatus;
