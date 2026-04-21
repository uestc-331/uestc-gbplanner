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

class PlanningMode {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.mode = null;
    }
    else {
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PlanningMode
    // Serialize message field [mode]
    bufferOffset = _serializer.int32(obj.mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PlanningMode
    let len;
    let data = new PlanningMode(null);
    // Deserialize message field [mode]
    data.mode = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner_msgs/PlanningMode';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '565e7cf808eefb4996657b401755699b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new PlanningMode(null);
    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = 0
    }

    return resolved;
    }
};

// Constants for message
PlanningMode.Constants = {
  KBASICEXPLORATION: 0,
  KNARROWENVEXPLORATION: 1,
  KADAPTIVEEXPLORATION: 2,
}

module.exports = PlanningMode;
