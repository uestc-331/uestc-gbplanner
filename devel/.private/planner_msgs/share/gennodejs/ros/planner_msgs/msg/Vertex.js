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

class Vertex {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.pose = null;
      this.num_unknown_voxels = null;
      this.num_occupied_voxels = null;
      this.num_free_voxels = null;
      this.is_frontier = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('num_unknown_voxels')) {
        this.num_unknown_voxels = initObj.num_unknown_voxels
      }
      else {
        this.num_unknown_voxels = 0;
      }
      if (initObj.hasOwnProperty('num_occupied_voxels')) {
        this.num_occupied_voxels = initObj.num_occupied_voxels
      }
      else {
        this.num_occupied_voxels = 0;
      }
      if (initObj.hasOwnProperty('num_free_voxels')) {
        this.num_free_voxels = initObj.num_free_voxels
      }
      else {
        this.num_free_voxels = 0;
      }
      if (initObj.hasOwnProperty('is_frontier')) {
        this.is_frontier = initObj.is_frontier
      }
      else {
        this.is_frontier = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Vertex
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [num_unknown_voxels]
    bufferOffset = _serializer.int32(obj.num_unknown_voxels, buffer, bufferOffset);
    // Serialize message field [num_occupied_voxels]
    bufferOffset = _serializer.int32(obj.num_occupied_voxels, buffer, bufferOffset);
    // Serialize message field [num_free_voxels]
    bufferOffset = _serializer.int32(obj.num_free_voxels, buffer, bufferOffset);
    // Serialize message field [is_frontier]
    bufferOffset = _serializer.bool(obj.is_frontier, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Vertex
    let len;
    let data = new Vertex(null);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [num_unknown_voxels]
    data.num_unknown_voxels = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [num_occupied_voxels]
    data.num_occupied_voxels = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [num_free_voxels]
    data.num_free_voxels = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [is_frontier]
    data.is_frontier = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 73;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner_msgs/Vertex';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '663034a815fe27eaa71d6d6b0f8b9b78';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 id
    geometry_msgs/Pose pose
    
    # For volumetric gain
    int32 num_unknown_voxels
    int32 num_occupied_voxels
    int32 num_free_voxels
    bool is_frontier
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of position and orientation. 
    Point position
    Quaternion orientation
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Vertex(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.pose !== undefined) {
      resolved.pose = geometry_msgs.msg.Pose.Resolve(msg.pose)
    }
    else {
      resolved.pose = new geometry_msgs.msg.Pose()
    }

    if (msg.num_unknown_voxels !== undefined) {
      resolved.num_unknown_voxels = msg.num_unknown_voxels;
    }
    else {
      resolved.num_unknown_voxels = 0
    }

    if (msg.num_occupied_voxels !== undefined) {
      resolved.num_occupied_voxels = msg.num_occupied_voxels;
    }
    else {
      resolved.num_occupied_voxels = 0
    }

    if (msg.num_free_voxels !== undefined) {
      resolved.num_free_voxels = msg.num_free_voxels;
    }
    else {
      resolved.num_free_voxels = 0
    }

    if (msg.is_frontier !== undefined) {
      resolved.is_frontier = msg.is_frontier;
    }
    else {
      resolved.is_frontier = false
    }

    return resolved;
    }
};

module.exports = Vertex;
