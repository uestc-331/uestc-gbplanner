// Auto-generated. Do not edit!

// (in-package planner_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Vertex = require('./Vertex.js');
let Edge = require('./Edge.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Graph {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.vertices = null;
      this.edges = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('vertices')) {
        this.vertices = initObj.vertices
      }
      else {
        this.vertices = [];
      }
      if (initObj.hasOwnProperty('edges')) {
        this.edges = initObj.edges
      }
      else {
        this.edges = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Graph
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [vertices]
    // Serialize the length for message field [vertices]
    bufferOffset = _serializer.uint32(obj.vertices.length, buffer, bufferOffset);
    obj.vertices.forEach((val) => {
      bufferOffset = Vertex.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [edges]
    // Serialize the length for message field [edges]
    bufferOffset = _serializer.uint32(obj.edges.length, buffer, bufferOffset);
    obj.edges.forEach((val) => {
      bufferOffset = Edge.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Graph
    let len;
    let data = new Graph(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [vertices]
    // Deserialize array length for message field [vertices]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.vertices = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.vertices[i] = Vertex.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [edges]
    // Deserialize array length for message field [edges]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.edges = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.edges[i] = Edge.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 73 * object.vertices.length;
    length += 12 * object.edges.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'planner_msgs/Graph';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0f1eb1d0b23f9055c17c609dc10e68a8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    planner_msgs/Vertex[] vertices
    planner_msgs/Edge[] edges
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
    MSG: planner_msgs/Vertex
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
    
    ================================================================================
    MSG: planner_msgs/Edge
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
    const resolved = new Graph(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.vertices !== undefined) {
      resolved.vertices = new Array(msg.vertices.length);
      for (let i = 0; i < resolved.vertices.length; ++i) {
        resolved.vertices[i] = Vertex.Resolve(msg.vertices[i]);
      }
    }
    else {
      resolved.vertices = []
    }

    if (msg.edges !== undefined) {
      resolved.edges = new Array(msg.edges.length);
      for (let i = 0; i < resolved.edges.length; ++i) {
        resolved.edges[i] = Edge.Resolve(msg.edges[i]);
      }
    }
    else {
      resolved.edges = []
    }

    return resolved;
    }
};

module.exports = Graph;
