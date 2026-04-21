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

class Edge {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.source_id = null;
      this.target_id = null;
      this.weight = null;
    }
    else {
      if (initObj.hasOwnProperty('source_id')) {
        this.source_id = initObj.source_id
      }
      else {
        this.source_id = 0;
      }
      if (initObj.hasOwnProperty('target_id')) {
        this.target_id = initObj.target_id
      }
      else {
        this.target_id = 0;
      }
      if (initObj.hasOwnProperty('weight')) {
        this.weight = initObj.weight
      }
      else {
        this.weight = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Edge
    // Serialize message field [source_id]
    bufferOffset = _serializer.int32(obj.source_id, buffer, bufferOffset);
    // Serialize message field [target_id]
    bufferOffset = _serializer.int32(obj.target_id, buffer, bufferOffset);
    // Serialize message field [weight]
    bufferOffset = _serializer.float32(obj.weight, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Edge
    let len;
    let data = new Edge(null);
    // Deserialize message field [source_id]
    data.source_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [target_id]
    data.target_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [weight]
    data.weight = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner_msgs/Edge';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4f0bbb1b628ed8cf4b65bbaa06d6225d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 source_id
    int32 target_id
    float32 weight
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Edge(null);
    if (msg.source_id !== undefined) {
      resolved.source_id = msg.source_id;
    }
    else {
      resolved.source_id = 0
    }

    if (msg.target_id !== undefined) {
      resolved.target_id = msg.target_id;
    }
    else {
      resolved.target_id = 0
    }

    if (msg.weight !== undefined) {
      resolved.weight = msg.weight;
    }
    else {
      resolved.weight = 0.0
    }

    return resolved;
    }
};

module.exports = Edge;
