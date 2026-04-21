// Auto-generated. Do not edit!

// (in-package planner_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class BehaviourPlannerLogger {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.total_time = null;
      this.planner = null;
      this.current_seen_ratio = null;
      this.exploration_cost = null;
      this.coverage_cost = null;
      this.room_belief = null;
      this.tunnel_belief = null;
      this.perf_exp = null;
      this.perf_cov = null;
      this.delta_seen_surf = null;
      this.delta_seen_vol = null;
      this.image_brightness_utility = null;
      this.utility_sparse = null;
      this.utility_dense = null;
      this.utility_corridor = null;
      this.final_scores = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('total_time')) {
        this.total_time = initObj.total_time
      }
      else {
        this.total_time = 0.0;
      }
      if (initObj.hasOwnProperty('planner')) {
        this.planner = initObj.planner
      }
      else {
        this.planner = false;
      }
      if (initObj.hasOwnProperty('current_seen_ratio')) {
        this.current_seen_ratio = initObj.current_seen_ratio
      }
      else {
        this.current_seen_ratio = 0.0;
      }
      if (initObj.hasOwnProperty('exploration_cost')) {
        this.exploration_cost = initObj.exploration_cost
      }
      else {
        this.exploration_cost = 0.0;
      }
      if (initObj.hasOwnProperty('coverage_cost')) {
        this.coverage_cost = initObj.coverage_cost
      }
      else {
        this.coverage_cost = 0.0;
      }
      if (initObj.hasOwnProperty('room_belief')) {
        this.room_belief = initObj.room_belief
      }
      else {
        this.room_belief = 0.0;
      }
      if (initObj.hasOwnProperty('tunnel_belief')) {
        this.tunnel_belief = initObj.tunnel_belief
      }
      else {
        this.tunnel_belief = 0.0;
      }
      if (initObj.hasOwnProperty('perf_exp')) {
        this.perf_exp = initObj.perf_exp
      }
      else {
        this.perf_exp = 0.0;
      }
      if (initObj.hasOwnProperty('perf_cov')) {
        this.perf_cov = initObj.perf_cov
      }
      else {
        this.perf_cov = 0.0;
      }
      if (initObj.hasOwnProperty('delta_seen_surf')) {
        this.delta_seen_surf = initObj.delta_seen_surf
      }
      else {
        this.delta_seen_surf = 0.0;
      }
      if (initObj.hasOwnProperty('delta_seen_vol')) {
        this.delta_seen_vol = initObj.delta_seen_vol
      }
      else {
        this.delta_seen_vol = 0.0;
      }
      if (initObj.hasOwnProperty('image_brightness_utility')) {
        this.image_brightness_utility = initObj.image_brightness_utility
      }
      else {
        this.image_brightness_utility = [];
      }
      if (initObj.hasOwnProperty('utility_sparse')) {
        this.utility_sparse = initObj.utility_sparse
      }
      else {
        this.utility_sparse = [];
      }
      if (initObj.hasOwnProperty('utility_dense')) {
        this.utility_dense = initObj.utility_dense
      }
      else {
        this.utility_dense = [];
      }
      if (initObj.hasOwnProperty('utility_corridor')) {
        this.utility_corridor = initObj.utility_corridor
      }
      else {
        this.utility_corridor = [];
      }
      if (initObj.hasOwnProperty('final_scores')) {
        this.final_scores = initObj.final_scores
      }
      else {
        this.final_scores = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BehaviourPlannerLogger
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [total_time]
    bufferOffset = _serializer.float32(obj.total_time, buffer, bufferOffset);
    // Serialize message field [planner]
    bufferOffset = _serializer.bool(obj.planner, buffer, bufferOffset);
    // Serialize message field [current_seen_ratio]
    bufferOffset = _serializer.float32(obj.current_seen_ratio, buffer, bufferOffset);
    // Serialize message field [exploration_cost]
    bufferOffset = _serializer.float32(obj.exploration_cost, buffer, bufferOffset);
    // Serialize message field [coverage_cost]
    bufferOffset = _serializer.float32(obj.coverage_cost, buffer, bufferOffset);
    // Serialize message field [room_belief]
    bufferOffset = _serializer.float32(obj.room_belief, buffer, bufferOffset);
    // Serialize message field [tunnel_belief]
    bufferOffset = _serializer.float32(obj.tunnel_belief, buffer, bufferOffset);
    // Serialize message field [perf_exp]
    bufferOffset = _serializer.float32(obj.perf_exp, buffer, bufferOffset);
    // Serialize message field [perf_cov]
    bufferOffset = _serializer.float32(obj.perf_cov, buffer, bufferOffset);
    // Serialize message field [delta_seen_surf]
    bufferOffset = _serializer.float32(obj.delta_seen_surf, buffer, bufferOffset);
    // Serialize message field [delta_seen_vol]
    bufferOffset = _serializer.float32(obj.delta_seen_vol, buffer, bufferOffset);
    // Serialize message field [image_brightness_utility]
    bufferOffset = _arraySerializer.float32(obj.image_brightness_utility, buffer, bufferOffset, null);
    // Serialize message field [utility_sparse]
    bufferOffset = _arraySerializer.float32(obj.utility_sparse, buffer, bufferOffset, null);
    // Serialize message field [utility_dense]
    bufferOffset = _arraySerializer.float32(obj.utility_dense, buffer, bufferOffset, null);
    // Serialize message field [utility_corridor]
    bufferOffset = _arraySerializer.float32(obj.utility_corridor, buffer, bufferOffset, null);
    // Serialize message field [final_scores]
    bufferOffset = _arraySerializer.float32(obj.final_scores, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BehaviourPlannerLogger
    let len;
    let data = new BehaviourPlannerLogger(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [total_time]
    data.total_time = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [planner]
    data.planner = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [current_seen_ratio]
    data.current_seen_ratio = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [exploration_cost]
    data.exploration_cost = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [coverage_cost]
    data.coverage_cost = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [room_belief]
    data.room_belief = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [tunnel_belief]
    data.tunnel_belief = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [perf_exp]
    data.perf_exp = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [perf_cov]
    data.perf_cov = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [delta_seen_surf]
    data.delta_seen_surf = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [delta_seen_vol]
    data.delta_seen_vol = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [image_brightness_utility]
    data.image_brightness_utility = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [utility_sparse]
    data.utility_sparse = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [utility_dense]
    data.utility_dense = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [utility_corridor]
    data.utility_corridor = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [final_scores]
    data.final_scores = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.image_brightness_utility.length;
    length += 4 * object.utility_sparse.length;
    length += 4 * object.utility_dense.length;
    length += 4 * object.utility_corridor.length;
    length += 4 * object.final_scores.length;
    return length + 61;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner_msgs/BehaviourPlannerLogger';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c3c9c34a8a3952fd0863b37239f93bdd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 total_time
    bool planner
    float32 current_seen_ratio 
    float32 exploration_cost
    float32 coverage_cost 
    float32 room_belief
    float32 tunnel_belief
    float32 perf_exp
    float32 perf_cov
    float32 delta_seen_surf
    float32 delta_seen_vol
    
    #Hypergame log
    float32[] image_brightness_utility
    float32[] utility_sparse
    float32[] utility_dense
    float32[] utility_corridor
    float32[] final_scores
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BehaviourPlannerLogger(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.total_time !== undefined) {
      resolved.total_time = msg.total_time;
    }
    else {
      resolved.total_time = 0.0
    }

    if (msg.planner !== undefined) {
      resolved.planner = msg.planner;
    }
    else {
      resolved.planner = false
    }

    if (msg.current_seen_ratio !== undefined) {
      resolved.current_seen_ratio = msg.current_seen_ratio;
    }
    else {
      resolved.current_seen_ratio = 0.0
    }

    if (msg.exploration_cost !== undefined) {
      resolved.exploration_cost = msg.exploration_cost;
    }
    else {
      resolved.exploration_cost = 0.0
    }

    if (msg.coverage_cost !== undefined) {
      resolved.coverage_cost = msg.coverage_cost;
    }
    else {
      resolved.coverage_cost = 0.0
    }

    if (msg.room_belief !== undefined) {
      resolved.room_belief = msg.room_belief;
    }
    else {
      resolved.room_belief = 0.0
    }

    if (msg.tunnel_belief !== undefined) {
      resolved.tunnel_belief = msg.tunnel_belief;
    }
    else {
      resolved.tunnel_belief = 0.0
    }

    if (msg.perf_exp !== undefined) {
      resolved.perf_exp = msg.perf_exp;
    }
    else {
      resolved.perf_exp = 0.0
    }

    if (msg.perf_cov !== undefined) {
      resolved.perf_cov = msg.perf_cov;
    }
    else {
      resolved.perf_cov = 0.0
    }

    if (msg.delta_seen_surf !== undefined) {
      resolved.delta_seen_surf = msg.delta_seen_surf;
    }
    else {
      resolved.delta_seen_surf = 0.0
    }

    if (msg.delta_seen_vol !== undefined) {
      resolved.delta_seen_vol = msg.delta_seen_vol;
    }
    else {
      resolved.delta_seen_vol = 0.0
    }

    if (msg.image_brightness_utility !== undefined) {
      resolved.image_brightness_utility = msg.image_brightness_utility;
    }
    else {
      resolved.image_brightness_utility = []
    }

    if (msg.utility_sparse !== undefined) {
      resolved.utility_sparse = msg.utility_sparse;
    }
    else {
      resolved.utility_sparse = []
    }

    if (msg.utility_dense !== undefined) {
      resolved.utility_dense = msg.utility_dense;
    }
    else {
      resolved.utility_dense = []
    }

    if (msg.utility_corridor !== undefined) {
      resolved.utility_corridor = msg.utility_corridor;
    }
    else {
      resolved.utility_corridor = []
    }

    if (msg.final_scores !== undefined) {
      resolved.final_scores = msg.final_scores;
    }
    else {
      resolved.final_scores = []
    }

    return resolved;
    }
};

module.exports = BehaviourPlannerLogger;
