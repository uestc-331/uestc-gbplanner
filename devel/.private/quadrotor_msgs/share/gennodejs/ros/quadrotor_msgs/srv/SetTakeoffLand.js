// Auto-generated. Do not edit!

// (in-package quadrotor_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class SetTakeoffLandRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.takeoff = null;
      this.takeoff_altitude = null;
    }
    else {
      if (initObj.hasOwnProperty('takeoff')) {
        this.takeoff = initObj.takeoff
      }
      else {
        this.takeoff = false;
      }
      if (initObj.hasOwnProperty('takeoff_altitude')) {
        this.takeoff_altitude = initObj.takeoff_altitude
      }
      else {
        this.takeoff_altitude = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetTakeoffLandRequest
    // Serialize message field [takeoff]
    bufferOffset = _serializer.bool(obj.takeoff, buffer, bufferOffset);
    // Serialize message field [takeoff_altitude]
    bufferOffset = _serializer.float32(obj.takeoff_altitude, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetTakeoffLandRequest
    let len;
    let data = new SetTakeoffLandRequest(null);
    // Deserialize message field [takeoff]
    data.takeoff = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [takeoff_altitude]
    data.takeoff_altitude = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'quadrotor_msgs/SetTakeoffLandRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9d3afacfc61178581ac9f0737ea6f094';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool takeoff 
    float32 takeoff_altitude
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetTakeoffLandRequest(null);
    if (msg.takeoff !== undefined) {
      resolved.takeoff = msg.takeoff;
    }
    else {
      resolved.takeoff = false
    }

    if (msg.takeoff_altitude !== undefined) {
      resolved.takeoff_altitude = msg.takeoff_altitude;
    }
    else {
      resolved.takeoff_altitude = 0.0
    }

    return resolved;
    }
};

class SetTakeoffLandResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.res = null;
    }
    else {
      if (initObj.hasOwnProperty('res')) {
        this.res = initObj.res
      }
      else {
        this.res = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetTakeoffLandResponse
    // Serialize message field [res]
    bufferOffset = _serializer.bool(obj.res, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetTakeoffLandResponse
    let len;
    let data = new SetTakeoffLandResponse(null);
    // Deserialize message field [res]
    data.res = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'quadrotor_msgs/SetTakeoffLandResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e27848a10f8e7e4030443887dfea101b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool res
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetTakeoffLandResponse(null);
    if (msg.res !== undefined) {
      resolved.res = msg.res;
    }
    else {
      resolved.res = false
    }

    return resolved;
    }
};

module.exports = {
  Request: SetTakeoffLandRequest,
  Response: SetTakeoffLandResponse,
  md5sum() { return '34300860f54be45144752987f014ec7e'; },
  datatype() { return 'quadrotor_msgs/SetTakeoffLand'; }
};
