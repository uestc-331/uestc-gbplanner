// Auto-generated. Do not edit!

// (in-package planner_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class PlanningBound {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.use_z_val = null;
      this.min_val = null;
      this.max_val = null;
    }
    else {
      if (initObj.hasOwnProperty('use_z_val')) {
        this.use_z_val = initObj.use_z_val
      }
      else {
        this.use_z_val = false;
      }
      if (initObj.hasOwnProperty('min_val')) {
        this.min_val = initObj.min_val
      }
      else {
        this.min_val = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('max_val')) {
        this.max_val = initObj.max_val
      }
      else {
        this.max_val = new geometry_msgs.msg.Point();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PlanningBound
    // Serialize message field [use_z_val]
    bufferOffset = _serializer.bool(obj.use_z_val, buffer, bufferOffset);
    // Serialize message field [min_val]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.min_val, buffer, bufferOffset);
    // Serialize message field [max_val]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.max_val, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PlanningBound
    let len;
    let data = new PlanningBound(null);
    // Deserialize message field [use_z_val]
    data.use_z_val = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [min_val]
    data.min_val = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [max_val]
    data.max_val = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 49;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner_msgs/PlanningBound';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9946f675c617611331fb20682325fff7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # use_z_val
    #    true:  all x, y, z coordinate
    #    false: change only x, y coodinates
    bool use_z_val
    
    # Bottom left corner
    geometry_msgs/Point min_val
    
    # Top right corner
    geometry_msgs/Point max_val
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
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
    const resolved = new PlanningBound(null);
    if (msg.use_z_val !== undefined) {
      resolved.use_z_val = msg.use_z_val;
    }
    else {
      resolved.use_z_val = false
    }

    if (msg.min_val !== undefined) {
      resolved.min_val = geometry_msgs.msg.Point.Resolve(msg.min_val)
    }
    else {
      resolved.min_val = new geometry_msgs.msg.Point()
    }

    if (msg.max_val !== undefined) {
      resolved.max_val = geometry_msgs.msg.Point.Resolve(msg.max_val)
    }
    else {
      resolved.max_val = new geometry_msgs.msg.Point()
    }

    return resolved;
    }
};

module.exports = PlanningBound;
