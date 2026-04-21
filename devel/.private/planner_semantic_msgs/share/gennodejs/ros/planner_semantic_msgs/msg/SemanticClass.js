// Auto-generated. Do not edit!

// (in-package planner_semantic_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class SemanticClass {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.value = null;
    }
    else {
      if (initObj.hasOwnProperty('value')) {
        this.value = initObj.value
      }
      else {
        this.value = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SemanticClass
    // Serialize message field [value]
    bufferOffset = _serializer.int32(obj.value, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SemanticClass
    let len;
    let data = new SemanticClass(null);
    // Deserialize message field [value]
    data.value = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner_semantic_msgs/SemanticClass';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9ed3cb55cfdae37517f1354dd57dbaba';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Semantic classes
    int32 kNone = 0
    int32 kStaircase = 1
    int32 kDoor = 2
    
    # Can only choose one of the above
    int32 value
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SemanticClass(null);
    if (msg.value !== undefined) {
      resolved.value = msg.value;
    }
    else {
      resolved.value = 0
    }

    return resolved;
    }
};

// Constants for message
SemanticClass.Constants = {
  KNONE: 0,
  KSTAIRCASE: 1,
  KDOOR: 2,
}

module.exports = SemanticClass;
