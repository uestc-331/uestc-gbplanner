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

class pci_homing_triggerRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.not_exe_path = null;
    }
    else {
      if (initObj.hasOwnProperty('not_exe_path')) {
        this.not_exe_path = initObj.not_exe_path
      }
      else {
        this.not_exe_path = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type pci_homing_triggerRequest
    // Serialize message field [not_exe_path]
    bufferOffset = _serializer.bool(obj.not_exe_path, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type pci_homing_triggerRequest
    let len;
    let data = new pci_homing_triggerRequest(null);
    // Deserialize message field [not_exe_path]
    data.not_exe_path = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/pci_homing_triggerRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b4fae9aecc7f1b253efbd8f8ea1e6d4b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Request the planner control interface to guide the robot go home.
    # Set true if don't want to execute path.
    bool not_exe_path
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new pci_homing_triggerRequest(null);
    if (msg.not_exe_path !== undefined) {
      resolved.not_exe_path = msg.not_exe_path;
    }
    else {
      resolved.not_exe_path = false
    }

    return resolved;
    }
};

class pci_homing_triggerResponse {
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
    // Serializes a message object of type pci_homing_triggerResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type pci_homing_triggerResponse
    let len;
    let data = new pci_homing_triggerResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/pci_homing_triggerResponse';
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
    const resolved = new pci_homing_triggerResponse(null);
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
  Request: pci_homing_triggerRequest,
  Response: pci_homing_triggerResponse,
  md5sum() { return '9ac7156ead9cf693072fe52aad9e8e2c'; },
  datatype() { return 'planner_msgs/pci_homing_trigger'; }
};
