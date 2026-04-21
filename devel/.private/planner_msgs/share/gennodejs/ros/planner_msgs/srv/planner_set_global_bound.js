// Auto-generated. Do not edit!

// (in-package planner_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let PlanningBound = require('../msg/PlanningBound.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class planner_set_global_boundRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.get_current_bound = null;
      this.reset_to_default = null;
      this.bound = null;
    }
    else {
      if (initObj.hasOwnProperty('get_current_bound')) {
        this.get_current_bound = initObj.get_current_bound
      }
      else {
        this.get_current_bound = false;
      }
      if (initObj.hasOwnProperty('reset_to_default')) {
        this.reset_to_default = initObj.reset_to_default
      }
      else {
        this.reset_to_default = false;
      }
      if (initObj.hasOwnProperty('bound')) {
        this.bound = initObj.bound
      }
      else {
        this.bound = new PlanningBound();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_set_global_boundRequest
    // Serialize message field [get_current_bound]
    bufferOffset = _serializer.bool(obj.get_current_bound, buffer, bufferOffset);
    // Serialize message field [reset_to_default]
    bufferOffset = _serializer.bool(obj.reset_to_default, buffer, bufferOffset);
    // Serialize message field [bound]
    bufferOffset = PlanningBound.serialize(obj.bound, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_set_global_boundRequest
    let len;
    let data = new planner_set_global_boundRequest(null);
    // Deserialize message field [get_current_bound]
    data.get_current_bound = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [reset_to_default]
    data.reset_to_default = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [bound]
    data.bound = PlanningBound.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 51;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_set_global_boundRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '38c5d4237e29fac0ecaa633679ffb75a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # get_current_bound:
    #   true: get current bound, nothing to set
    #   false: set bound then returns the latest bound
    bool get_current_bound
    
    # reset_to_default:
    #   true:  reset to the default bounding box
    #   false: set new bounding box
    bool reset_to_default
    
    planner_msgs/PlanningBound bound
    
    ================================================================================
    MSG: planner_msgs/PlanningBound
    # use_z_val
    #    true:  all x, y, z coordinate
    #    false: change only x, y coodinates
    bool use_z_val
    
    # Bottom left corner
    geometry_msgs/Point min_val
    
    # Top right corner
    geometry_msgs/Point max_val
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
    const resolved = new planner_set_global_boundRequest(null);
    if (msg.get_current_bound !== undefined) {
      resolved.get_current_bound = msg.get_current_bound;
    }
    else {
      resolved.get_current_bound = false
    }

    if (msg.reset_to_default !== undefined) {
      resolved.reset_to_default = msg.reset_to_default;
    }
    else {
      resolved.reset_to_default = false
    }

    if (msg.bound !== undefined) {
      resolved.bound = PlanningBound.Resolve(msg.bound)
    }
    else {
      resolved.bound = new PlanningBound()
    }

    return resolved;
    }
};

class planner_set_global_boundResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.bound_ret = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('bound_ret')) {
        this.bound_ret = initObj.bound_ret
      }
      else {
        this.bound_ret = new PlanningBound();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_set_global_boundResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [bound_ret]
    bufferOffset = PlanningBound.serialize(obj.bound_ret, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_set_global_boundResponse
    let len;
    let data = new planner_set_global_boundResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [bound_ret]
    data.bound_ret = PlanningBound.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 50;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_set_global_boundResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2619ee9b517b3d6cb4eca38a7120d19d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success
    
    # Return the actual value inside planner after calling this service
    planner_msgs/PlanningBound bound_ret
    
    ================================================================================
    MSG: planner_msgs/PlanningBound
    # use_z_val
    #    true:  all x, y, z coordinate
    #    false: change only x, y coodinates
    bool use_z_val
    
    # Bottom left corner
    geometry_msgs/Point min_val
    
    # Top right corner
    geometry_msgs/Point max_val
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
    const resolved = new planner_set_global_boundResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.bound_ret !== undefined) {
      resolved.bound_ret = PlanningBound.Resolve(msg.bound_ret)
    }
    else {
      resolved.bound_ret = new PlanningBound()
    }

    return resolved;
    }
};

module.exports = {
  Request: planner_set_global_boundRequest,
  Response: planner_set_global_boundResponse,
  md5sum() { return '1aed38fc3ce6d17635872f522b7dea8f'; },
  datatype() { return 'planner_msgs/planner_set_global_bound'; }
};
