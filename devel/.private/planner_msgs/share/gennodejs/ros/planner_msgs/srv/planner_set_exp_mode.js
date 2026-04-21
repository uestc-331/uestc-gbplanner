// Auto-generated. Do not edit!

// (in-package planner_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let PlanningMode = require('../msg/PlanningMode.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class planner_set_exp_modeRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.exp_mode = null;
    }
    else {
      if (initObj.hasOwnProperty('exp_mode')) {
        this.exp_mode = initObj.exp_mode
      }
      else {
        this.exp_mode = new PlanningMode();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_set_exp_modeRequest
    // Serialize message field [exp_mode]
    bufferOffset = PlanningMode.serialize(obj.exp_mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_set_exp_modeRequest
    let len;
    let data = new planner_set_exp_modeRequest(null);
    // Deserialize message field [exp_mode]
    data.exp_mode = PlanningMode.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_set_exp_modeRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '457ee7e10e6806d9611a5398a52a6b78';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    planner_msgs/PlanningMode exp_mode
    
    ================================================================================
    MSG: planner_msgs/PlanningMode
    # Planning mode for exploration, defined in Params/PlanningModeType.
    int32 kBasicExploration = 0
    int32 kNarrowEnvExploration = 1
    int32 kAdaptiveExploration = 2
    
    # Set one of above values.
    int32 mode
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new planner_set_exp_modeRequest(null);
    if (msg.exp_mode !== undefined) {
      resolved.exp_mode = PlanningMode.Resolve(msg.exp_mode)
    }
    else {
      resolved.exp_mode = new PlanningMode()
    }

    return resolved;
    }
};

class planner_set_exp_modeResponse {
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
    // Serializes a message object of type planner_set_exp_modeResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_set_exp_modeResponse
    let len;
    let data = new planner_set_exp_modeResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_set_exp_modeResponse';
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
    const resolved = new planner_set_exp_modeResponse(null);
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
  Request: planner_set_exp_modeRequest,
  Response: planner_set_exp_modeResponse,
  md5sum() { return '77df73f792ae041f34f0514a2cf99738'; },
  datatype() { return 'planner_msgs/planner_set_exp_mode'; }
};
