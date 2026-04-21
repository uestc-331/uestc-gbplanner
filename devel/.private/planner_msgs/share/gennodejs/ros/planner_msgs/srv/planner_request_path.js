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

let BoundMode = require('../msg/BoundMode.js');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class planner_request_pathRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_request_pathRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_request_pathRequest
    let len;
    let data = new planner_request_pathRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_request_pathRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # A generic service to request a path from gbplanner
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new planner_request_pathRequest(null);
    return resolved;
    }
};

class planner_request_pathResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.bound = null;
      this.path = null;
    }
    else {
      if (initObj.hasOwnProperty('bound')) {
        this.bound = initObj.bound
      }
      else {
        this.bound = new BoundMode();
      }
      if (initObj.hasOwnProperty('path')) {
        this.path = initObj.path
      }
      else {
        this.path = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_request_pathResponse
    // Serialize message field [bound]
    bufferOffset = BoundMode.serialize(obj.bound, buffer, bufferOffset);
    // Serialize message field [path]
    // Serialize the length for message field [path]
    bufferOffset = _serializer.uint32(obj.path.length, buffer, bufferOffset);
    obj.path.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Pose.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_request_pathResponse
    let len;
    let data = new planner_request_pathResponse(null);
    // Deserialize message field [bound]
    data.bound = BoundMode.deserialize(buffer, bufferOffset);
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
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_request_pathResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1dad867088c8c204d2077d3355d04150';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Return actual bound mode used in planner.
    BoundMode bound
    
    # Return path.
    geometry_msgs/Pose[] path
    
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
    const resolved = new planner_request_pathResponse(null);
    if (msg.bound !== undefined) {
      resolved.bound = BoundMode.Resolve(msg.bound)
    }
    else {
      resolved.bound = new BoundMode()
    }

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
  Request: planner_request_pathRequest,
  Response: planner_request_pathResponse,
  md5sum() { return '1dad867088c8c204d2077d3355d04150'; },
  datatype() { return 'planner_msgs/planner_request_path'; }
};
