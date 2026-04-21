// Auto-generated. Do not edit!

// (in-package planner_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class planner_globalRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.not_check_frontier = null;
      this.ignore_time = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('not_check_frontier')) {
        this.not_check_frontier = initObj.not_check_frontier
      }
      else {
        this.not_check_frontier = false;
      }
      if (initObj.hasOwnProperty('ignore_time')) {
        this.ignore_time = initObj.ignore_time
      }
      else {
        this.ignore_time = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_globalRequest
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [not_check_frontier]
    bufferOffset = _serializer.bool(obj.not_check_frontier, buffer, bufferOffset);
    // Serialize message field [ignore_time]
    bufferOffset = _serializer.bool(obj.ignore_time, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_globalRequest
    let len;
    let data = new planner_globalRequest(null);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [not_check_frontier]
    data.not_check_frontier = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [ignore_time]
    data.ignore_time = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 6;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_globalRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'adaa0993f3517b8220218b80eee72946';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Request the planner to run and return a path
    # Since the global planner solution is almost deterministic,
    # we could choose which frontier (using its id) from the best one to execute.
    # By default, id 0 means selecting the best one.
    int32 id
    # Don't check for frontier properties (e.g. leaf vertex, gain, ...)
    # This could be used to find a path to any vertex in the graph
    bool not_check_frontier
    # Force the planner to provide the path regardless the time budget.
    bool ignore_time
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new planner_globalRequest(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.not_check_frontier !== undefined) {
      resolved.not_check_frontier = msg.not_check_frontier;
    }
    else {
      resolved.not_check_frontier = false
    }

    if (msg.ignore_time !== undefined) {
      resolved.ignore_time = msg.ignore_time;
    }
    else {
      resolved.ignore_time = false
    }

    return resolved;
    }
};

class planner_globalResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.path = null;
    }
    else {
      if (initObj.hasOwnProperty('path')) {
        this.path = initObj.path
      }
      else {
        this.path = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_globalResponse
    // Serialize message field [path]
    // Serialize the length for message field [path]
    bufferOffset = _serializer.uint32(obj.path.length, buffer, bufferOffset);
    obj.path.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Pose.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_globalResponse
    let len;
    let data = new planner_globalResponse(null);
    // Deserialize message field [path]
    // Deserialize array length for message field [path]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.path = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.path[i] = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 56 * object.path.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_globalResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3672a680f9a8e1a187c20ffb2e3a206b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Return best path.
    geometry_msgs/Pose[] path
    
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of position and orientation. 
    Point position
    Quaternion orientation
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new planner_globalResponse(null);
    if (msg.path !== undefined) {
      resolved.path = new Array(msg.path.length);
      for (let i = 0; i < resolved.path.length; ++i) {
        resolved.path[i] = geometry_msgs.msg.Pose.Resolve(msg.path[i]);
      }
    }
    else {
      resolved.path = []
    }

    return resolved;
    }
};

module.exports = {
  Request: planner_globalRequest,
  Response: planner_globalResponse,
  md5sum() { return '3275d6e0291e4113fe8f0b4224d6de5a'; },
  datatype() { return 'planner_msgs/planner_global'; }
};
