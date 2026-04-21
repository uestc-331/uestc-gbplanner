// Auto-generated. Do not edit!

// (in-package planner_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ExecutionPathMode {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.mode = null;
      this.is_forward = null;
    }
    else {
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = 0;
      }
      if (initObj.hasOwnProperty('is_forward')) {
        this.is_forward = initObj.is_forward
      }
      else {
        this.is_forward = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ExecutionPathMode
    // Serialize message field [mode]
    bufferOffset = _serializer.int32(obj.mode, buffer, bufferOffset);
    // Serialize message field [is_forward]
    bufferOffset = _serializer.bool(obj.is_forward, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ExecutionPathMode
    let len;
    let data = new ExecutionPathMode(null);
    // Deserialize message field [mode]
    data.mode = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [is_forward]
    data.is_forward = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner_msgs/ExecutionPathMode';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9e0ca27c7cff652c41de65686e5ccf7d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new ExecutionPathMode(null);
    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = 0
    }

    if (msg.is_forward !== undefined) {
      resolved.is_forward = msg.is_forward;
    }
    else {
      resolved.is_forward = false
    }

    return resolved;
    }
};

// Constants for message
ExecutionPathMode.Constants = {
  KLOCALPATH: 0,
  KHOMINGPATH: 1,
  KGLOBALPATH: 2,
}

module.exports = ExecutionPathMode;
