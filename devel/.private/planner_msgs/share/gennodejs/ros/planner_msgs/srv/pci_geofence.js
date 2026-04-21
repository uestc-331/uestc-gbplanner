// Auto-generated. Do not edit!

// (in-package planner_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let RectangleShape = require('../msg/RectangleShape.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class pci_geofenceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.rectangles = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('rectangles')) {
        this.rectangles = initObj.rectangles
      }
      else {
        this.rectangles = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type pci_geofenceRequest
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [rectangles]
    // Serialize the length for message field [rectangles]
    bufferOffset = _serializer.uint32(obj.rectangles.length, buffer, bufferOffset);
    obj.rectangles.forEach((val) => {
      bufferOffset = RectangleShape.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type pci_geofenceRequest
    let len;
    let data = new pci_geofenceRequest(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [rectangles]
    // Deserialize array length for message field [rectangles]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.rectangles = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.rectangles[i] = RectangleShape.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 48 * object.rectangles.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/pci_geofenceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '925603c266f1903d5583d7c2444661b9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Add a rectangle to the geofence list.
    Header header
    
    planner_msgs/RectangleShape[] rectangles
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    ================================================================================
    MSG: planner_msgs/RectangleShape
    geometry_msgs/Vector3 center
    geometry_msgs/Vector3 size
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new pci_geofenceRequest(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.rectangles !== undefined) {
      resolved.rectangles = new Array(msg.rectangles.length);
      for (let i = 0; i < resolved.rectangles.length; ++i) {
        resolved.rectangles[i] = RectangleShape.Resolve(msg.rectangles[i]);
      }
    }
    else {
      resolved.rectangles = []
    }

    return resolved;
    }
};

class pci_geofenceResponse {
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
    // Serializes a message object of type pci_geofenceResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type pci_geofenceResponse
    let len;
    let data = new pci_geofenceResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/pci_geofenceResponse';
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
    const resolved = new pci_geofenceResponse(null);
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
  Request: pci_geofenceRequest,
  Response: pci_geofenceResponse,
  md5sum() { return 'dc6345ad327f5b0036d6747623b84599'; },
  datatype() { return 'planner_msgs/pci_geofence'; }
};
