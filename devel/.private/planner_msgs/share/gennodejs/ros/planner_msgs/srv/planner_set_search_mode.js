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

class planner_set_search_modeRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.search_mode = null;
    }
    else {
      if (initObj.hasOwnProperty('search_mode')) {
        this.search_mode = initObj.search_mode
      }
      else {
        this.search_mode = new PlanningMode();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_set_search_modeRequest
    // Serialize message field [search_mode]
    bufferOffset = PlanningMode.serialize(obj.search_mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_set_search_modeRequest
    let len;
    let data = new planner_set_search_modeRequest(null);
    // Deserialize message field [search_mode]
    data.search_mode = PlanningMode.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_set_search_modeRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4180db9c78f33b1af4f1ec158a3d4244';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    planner_msgs/PlanningMode search_mode
    
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
    const resolved = new planner_set_search_modeRequest(null);
    if (msg.search_mode !== undefined) {
      resolved.search_mode = PlanningMode.Resolve(msg.search_mode)
    }
    else {
      resolved.search_mode = new PlanningMode()
    }

    return resolved;
    }
};

class planner_set_search_modeResponse {
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
    // Serializes a message object of type planner_set_search_modeResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_set_search_modeResponse
    let len;
    let data = new planner_set_search_modeResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_set_search_modeResponse';
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
    const resolved = new planner_set_search_modeResponse(null);
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
  Request: planner_set_search_modeRequest,
  Response: planner_set_search_modeResponse,
  md5sum() { return '7dd8f9262ed5f0e5ecceeb616f68053b'; },
  datatype() { return 'planner_msgs/planner_set_search_mode'; }
};
