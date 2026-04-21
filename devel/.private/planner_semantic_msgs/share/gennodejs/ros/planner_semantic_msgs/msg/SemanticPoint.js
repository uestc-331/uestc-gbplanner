// Auto-generated. Do not edit!

// (in-package planner_semantic_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let SemanticClass = require('./SemanticClass.js');
let std_msgs = _finder('std_msgs');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class SemanticPoint {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.type = null;
      this.description = null;
      this.point = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = new SemanticClass();
      }
      if (initObj.hasOwnProperty('description')) {
        this.description = initObj.description
      }
      else {
        this.description = new std_msgs.msg.String();
      }
      if (initObj.hasOwnProperty('point')) {
        this.point = initObj.point
      }
      else {
        this.point = new geometry_msgs.msg.Point32();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SemanticPoint
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = SemanticClass.serialize(obj.type, buffer, bufferOffset);
    // Serialize message field [description]
    bufferOffset = std_msgs.msg.String.serialize(obj.description, buffer, bufferOffset);
    // Serialize message field [point]
    bufferOffset = geometry_msgs.msg.Point32.serialize(obj.point, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SemanticPoint
    let len;
    let data = new SemanticPoint(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = SemanticClass.deserialize(buffer, bufferOffset);
    // Deserialize message field [description]
    data.description = std_msgs.msg.String.deserialize(buffer, bufferOffset);
    // Deserialize message field [point]
    data.point = geometry_msgs.msg.Point32.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += std_msgs.msg.String.getMessageSize(object.description);
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner_semantic_msgs/SemanticPoint';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b4e8d6f91194ca358a218194b2f66232';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Represent semantics as a 3D point
    std_msgs/Header header
    
    # Class of semantics
    planner_semantic_msgs/SemanticClass type
    
    # Further info if needed
    std_msgs/String description
    
    # Coordinate of the semantics
    geometry_msgs/Point32 point
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
    MSG: planner_semantic_msgs/SemanticClass
    # Semantic classes
    int32 kNone = 0
    int32 kStaircase = 1
    int32 kDoor = 2
    
    # Can only choose one of the above
    int32 value
    
    ================================================================================
    MSG: std_msgs/String
    string data
    
    ================================================================================
    MSG: geometry_msgs/Point32
    # This contains the position of a point in free space(with 32 bits of precision).
    # It is recommeded to use Point wherever possible instead of Point32.  
    # 
    # This recommendation is to promote interoperability.  
    #
    # This message is designed to take up less space when sending
    # lots of points at once, as in the case of a PointCloud.  
    
    float32 x
    float32 y
    float32 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SemanticPoint(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.type !== undefined) {
      resolved.type = SemanticClass.Resolve(msg.type)
    }
    else {
      resolved.type = new SemanticClass()
    }

    if (msg.description !== undefined) {
      resolved.description = std_msgs.msg.String.Resolve(msg.description)
    }
    else {
      resolved.description = new std_msgs.msg.String()
    }

    if (msg.point !== undefined) {
      resolved.point = geometry_msgs.msg.Point32.Resolve(msg.point)
    }
    else {
      resolved.point = new geometry_msgs.msg.Point32()
    }

    return resolved;
    }
};

module.exports = SemanticPoint;
