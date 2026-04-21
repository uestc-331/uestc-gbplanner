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


//-----------------------------------------------------------

class pci_globalRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.not_exe_path = null;
      this.set_auto = null;
      this.bound_mode = null;
      this.vel_max = null;
      this.id = null;
      this.not_check_frontier = null;
      this.ignore_time = null;
    }
    else {
      if (initObj.hasOwnProperty('not_exe_path')) {
        this.not_exe_path = initObj.not_exe_path
      }
      else {
        this.not_exe_path = false;
      }
      if (initObj.hasOwnProperty('set_auto')) {
        this.set_auto = initObj.set_auto
      }
      else {
        this.set_auto = false;
      }
      if (initObj.hasOwnProperty('bound_mode')) {
        this.bound_mode = initObj.bound_mode
      }
      else {
        this.bound_mode = 0;
      }
      if (initObj.hasOwnProperty('vel_max')) {
        this.vel_max = initObj.vel_max
      }
      else {
        this.vel_max = 0.0;
      }
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
    // Serializes a message object of type pci_globalRequest
    // Serialize message field [not_exe_path]
    bufferOffset = _serializer.bool(obj.not_exe_path, buffer, bufferOffset);
    // Serialize message field [set_auto]
    bufferOffset = _serializer.bool(obj.set_auto, buffer, bufferOffset);
    // Serialize message field [bound_mode]
    bufferOffset = _serializer.uint8(obj.bound_mode, buffer, bufferOffset);
    // Serialize message field [vel_max]
    bufferOffset = _serializer.float32(obj.vel_max, buffer, bufferOffset);
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [not_check_frontier]
    bufferOffset = _serializer.bool(obj.not_check_frontier, buffer, bufferOffset);
    // Serialize message field [ignore_time]
    bufferOffset = _serializer.bool(obj.ignore_time, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type pci_globalRequest
    let len;
    let data = new pci_globalRequest(null);
    // Deserialize message field [not_exe_path]
    data.not_exe_path = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [set_auto]
    data.set_auto = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [bound_mode]
    data.bound_mode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [vel_max]
    data.vel_max = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [not_check_frontier]
    data.not_check_frontier = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [ignore_time]
    data.ignore_time = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 13;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/pci_globalRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5b7aecbe90c397a53b27664f48377146';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Request the planning through the planner control interface node.
    
    ## Params for planner-control-interface
    # Set not_exe_path to true if don't want the robot to execute the path.
    bool not_exe_path
    # Set set_auto to true to change to auto mode and vice versa.
    bool set_auto
    uint8 bound_mode
    # Max velocity allowed.
    float32 vel_max
    
    ## Params for planner
    # id of the frontier:
    # --> default is 0: auto-select the best frontier.
    # --> other than 0: manual select with feasibility check.
    int32 id
    # Don't check for frontier properties (e.g. leaf vertex, gain, ...).
    # This could be used to find a path to any vertex in the graph.
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
    const resolved = new pci_globalRequest(null);
    if (msg.not_exe_path !== undefined) {
      resolved.not_exe_path = msg.not_exe_path;
    }
    else {
      resolved.not_exe_path = false
    }

    if (msg.set_auto !== undefined) {
      resolved.set_auto = msg.set_auto;
    }
    else {
      resolved.set_auto = false
    }

    if (msg.bound_mode !== undefined) {
      resolved.bound_mode = msg.bound_mode;
    }
    else {
      resolved.bound_mode = 0
    }

    if (msg.vel_max !== undefined) {
      resolved.vel_max = msg.vel_max;
    }
    else {
      resolved.vel_max = 0.0
    }

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

class pci_globalResponse {
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
    // Serializes a message object of type pci_globalResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type pci_globalResponse
    let len;
    let data = new pci_globalResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/pci_globalResponse';
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
    const resolved = new pci_globalResponse(null);
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
  Request: pci_globalRequest,
  Response: pci_globalResponse,
  md5sum() { return 'b813db86654aa005e1e7d2d2ea812561'; },
  datatype() { return 'planner_msgs/pci_global'; }
};
