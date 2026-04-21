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

//-----------------------------------------------------------


//-----------------------------------------------------------

class planner_set_velRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.root_vel = null;
      this.set = null;
    }
    else {
      if (initObj.hasOwnProperty('root_vel')) {
        this.root_vel = initObj.root_vel
      }
      else {
        this.root_vel = new geometry_msgs.msg.Twist();
      }
      if (initObj.hasOwnProperty('set')) {
        this.set = initObj.set
      }
      else {
        this.set = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_set_velRequest
    // Serialize message field [root_vel]
    bufferOffset = geometry_msgs.msg.Twist.serialize(obj.root_vel, buffer, bufferOffset);
    // Serialize message field [set]
    bufferOffset = _serializer.bool(obj.set, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_set_velRequest
    let len;
    let data = new planner_set_velRequest(null);
    // Deserialize message field [root_vel]
    data.root_vel = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset);
    // Deserialize message field [set]
    data.set = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 49;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_set_velRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '668284c624216ebac50e28208e8f15b7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    geometry_msgs/Twist root_vel
    bool set
    
    ================================================================================
    MSG: geometry_msgs/Twist
    # This expresses velocity in free space broken into its linear and angular parts.
    Vector3 linear
    Vector3 angular
    
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
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
    const resolved = new planner_set_velRequest(null);
    if (msg.root_vel !== undefined) {
      resolved.root_vel = geometry_msgs.msg.Twist.Resolve(msg.root_vel)
    }
    else {
      resolved.root_vel = new geometry_msgs.msg.Twist()
    }

    if (msg.set !== undefined) {
      resolved.set = msg.set;
    }
    else {
      resolved.set = false
    }

    return resolved;
    }
};

class planner_set_velResponse {
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
    // Serializes a message object of type planner_set_velResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_set_velResponse
    let len;
    let data = new planner_set_velResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_set_velResponse';
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
    const resolved = new planner_set_velResponse(null);
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
  Request: planner_set_velRequest,
  Response: planner_set_velResponse,
  md5sum() { return 'f45ed41d58956a227be4845c1fe6bd6d'; },
  datatype() { return 'planner_msgs/planner_set_vel'; }
};
