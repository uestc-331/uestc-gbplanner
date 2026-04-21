// Auto-generated. Do not edit!

// (in-package planner_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class planner_dynamic_global_boundRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.reset_to_default = null;
      this.header = null;
      this.center = null;
      this.left = null;
      this.front = null;
      this.up = null;
    }
    else {
      if (initObj.hasOwnProperty('reset_to_default')) {
        this.reset_to_default = initObj.reset_to_default
      }
      else {
        this.reset_to_default = false;
      }
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('center')) {
        this.center = initObj.center
      }
      else {
        this.center = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('left')) {
        this.left = initObj.left
      }
      else {
        this.left = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('front')) {
        this.front = initObj.front
      }
      else {
        this.front = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('up')) {
        this.up = initObj.up
      }
      else {
        this.up = new geometry_msgs.msg.Point();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_dynamic_global_boundRequest
    // Serialize message field [reset_to_default]
    bufferOffset = _serializer.bool(obj.reset_to_default, buffer, bufferOffset);
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [center]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.center, buffer, bufferOffset);
    // Serialize message field [left]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.left, buffer, bufferOffset);
    // Serialize message field [front]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.front, buffer, bufferOffset);
    // Serialize message field [up]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.up, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_dynamic_global_boundRequest
    let len;
    let data = new planner_dynamic_global_boundRequest(null);
    // Deserialize message field [reset_to_default]
    data.reset_to_default = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [center]
    data.center = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [left]
    data.left = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [front]
    data.front = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [up]
    data.up = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 97;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_dynamic_global_boundRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '77084cd2fbed3f310ab736521dfcf7b1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # reset_to_default:
    #   true:  reset to the default bounding box
    #   false: set new bounding box
    bool reset_to_default
    
    # Header contains the frame in which the bounding box is expressed
    std_msgs/Header header
    
    # All coordinates are absolute and expressed in global frame (as set in the header)
    geometry_msgs/Point center  # Origin of bounding box
    geometry_msgs/Point left    # Vertex on the left of center when looking along the vector of the bb
    geometry_msgs/Point front   # Vertex in the front of center when looking along the vector of the bb
    geometry_msgs/Point up      # Vertex above center when looking along the vector of the bb
    
    
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
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new planner_dynamic_global_boundRequest(null);
    if (msg.reset_to_default !== undefined) {
      resolved.reset_to_default = msg.reset_to_default;
    }
    else {
      resolved.reset_to_default = false
    }

    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.center !== undefined) {
      resolved.center = geometry_msgs.msg.Point.Resolve(msg.center)
    }
    else {
      resolved.center = new geometry_msgs.msg.Point()
    }

    if (msg.left !== undefined) {
      resolved.left = geometry_msgs.msg.Point.Resolve(msg.left)
    }
    else {
      resolved.left = new geometry_msgs.msg.Point()
    }

    if (msg.front !== undefined) {
      resolved.front = geometry_msgs.msg.Point.Resolve(msg.front)
    }
    else {
      resolved.front = new geometry_msgs.msg.Point()
    }

    if (msg.up !== undefined) {
      resolved.up = geometry_msgs.msg.Point.Resolve(msg.up)
    }
    else {
      resolved.up = new geometry_msgs.msg.Point()
    }

    return resolved;
    }
};

class planner_dynamic_global_boundResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_dynamic_global_boundResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_dynamic_global_boundResponse
    let len;
    let data = new planner_dynamic_global_boundResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_dynamic_global_boundResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '358e233cde0c8a8bcfea4ce193f8fc15';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    bool success
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new planner_dynamic_global_boundResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    return resolved;
    }
};

module.exports = {
  Request: planner_dynamic_global_boundRequest,
  Response: planner_dynamic_global_boundResponse,
  md5sum() { return '31ef93df2f4c5feda83abcda3ab1ffb3'; },
  datatype() { return 'planner_msgs/planner_dynamic_global_bound'; }
};
