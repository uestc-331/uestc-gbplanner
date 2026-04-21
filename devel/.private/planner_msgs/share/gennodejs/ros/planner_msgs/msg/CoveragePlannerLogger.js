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

class CoveragePlannerLogger {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.graph_build_time = null;
      this.total_time = null;
      this.path_length = null;
      this.tsp_path_time = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('graph_build_time')) {
        this.graph_build_time = initObj.graph_build_time
      }
      else {
        this.graph_build_time = 0.0;
      }
      if (initObj.hasOwnProperty('total_time')) {
        this.total_time = initObj.total_time
      }
      else {
        this.total_time = 0.0;
      }
      if (initObj.hasOwnProperty('path_length')) {
        this.path_length = initObj.path_length
      }
      else {
        this.path_length = 0.0;
      }
      if (initObj.hasOwnProperty('tsp_path_time')) {
        this.tsp_path_time = initObj.tsp_path_time
      }
      else {
        this.tsp_path_time = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CoveragePlannerLogger
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [graph_build_time]
    bufferOffset = _serializer.float32(obj.graph_build_time, buffer, bufferOffset);
    // Serialize message field [total_time]
    bufferOffset = _serializer.float32(obj.total_time, buffer, bufferOffset);
    // Serialize message field [path_length]
    bufferOffset = _serializer.float32(obj.path_length, buffer, bufferOffset);
    // Serialize message field [tsp_path_time]
    bufferOffset = _serializer.float32(obj.tsp_path_time, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CoveragePlannerLogger
    let len;
    let data = new CoveragePlannerLogger(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [graph_build_time]
    data.graph_build_time = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [total_time]
    data.total_time = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [path_length]
    data.path_length = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [tsp_path_time]
    data.tsp_path_time = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner_msgs/CoveragePlannerLogger';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4af5c001f0e3078a457323f300d3ce22';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 graph_build_time
    float32 total_time
    float32 path_length
    float32 tsp_path_time
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
    const resolved = new CoveragePlannerLogger(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.graph_build_time !== undefined) {
      resolved.graph_build_time = msg.graph_build_time;
    }
    else {
      resolved.graph_build_time = 0.0
    }

    if (msg.total_time !== undefined) {
      resolved.total_time = msg.total_time;
    }
    else {
      resolved.total_time = 0.0
    }

    if (msg.path_length !== undefined) {
      resolved.path_length = msg.path_length;
    }
    else {
      resolved.path_length = 0.0
    }

    if (msg.tsp_path_time !== undefined) {
      resolved.tsp_path_time = msg.tsp_path_time;
    }
    else {
      resolved.tsp_path_time = 0.0
    }

    return resolved;
    }
};

module.exports = CoveragePlannerLogger;
