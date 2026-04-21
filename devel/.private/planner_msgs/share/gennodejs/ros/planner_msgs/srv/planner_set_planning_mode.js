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

class planner_set_planning_modeRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.planning_mode = null;
    }
    else {
      if (initObj.hasOwnProperty('planning_mode')) {
        this.planning_mode = initObj.planning_mode
      }
      else {
        this.planning_mode = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_set_planning_modeRequest
    // Serialize message field [planning_mode]
    bufferOffset = _serializer.int32(obj.planning_mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_set_planning_modeRequest
    let len;
    let data = new planner_set_planning_modeRequest(null);
    // Deserialize message field [planning_mode]
    data.planning_mode = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_set_planning_modeRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '34a950857eb720557b21b9222e4269ae';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Set the planning mode of the robot to use in planner.
    int32 kManual = 0
    int32 kAuto = 1
    # Can only be used with one of above values. Check Params/BoundModeType for more details.
    int32 planning_mode
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new planner_set_planning_modeRequest(null);
    if (msg.planning_mode !== undefined) {
      resolved.planning_mode = msg.planning_mode;
    }
    else {
      resolved.planning_mode = 0
    }

    return resolved;
    }
};

// Constants for message
planner_set_planning_modeRequest.Constants = {
  KMANUAL: 0,
  KAUTO: 1,
}

class planner_set_planning_modeResponse {
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
    // Serializes a message object of type planner_set_planning_modeResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_set_planning_modeResponse
    let len;
    let data = new planner_set_planning_modeResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_set_planning_modeResponse';
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
    const resolved = new planner_set_planning_modeResponse(null);
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
  Request: planner_set_planning_modeRequest,
  Response: planner_set_planning_modeResponse,
  md5sum() { return 'f5c508faaff06b83ff7d994be5342caa'; },
  datatype() { return 'planner_msgs/planner_set_planning_mode'; }
};
