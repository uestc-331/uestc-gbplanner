// Auto-generated. Do not edit!

// (in-package planner_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class planner_go_to_waypointRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.check_collision = null;
      this.waypoint = null;
    }
    else {
      if (initObj.hasOwnProperty('check_collision')) {
        this.check_collision = initObj.check_collision
      }
      else {
        this.check_collision = false;
      }
      if (initObj.hasOwnProperty('waypoint')) {
        this.waypoint = initObj.waypoint
      }
      else {
        this.waypoint = new geometry_msgs.msg.PoseStamped();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_go_to_waypointRequest
    // Serialize message field [check_collision]
    bufferOffset = _serializer.bool(obj.check_collision, buffer, bufferOffset);
    // Serialize message field [waypoint]
    bufferOffset = geometry_msgs.msg.PoseStamped.serialize(obj.waypoint, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_go_to_waypointRequest
    let len;
    let data = new planner_go_to_waypointRequest(null);
    // Deserialize message field [check_collision]
    data.check_collision = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [waypoint]
    data.waypoint = geometry_msgs.msg.PoseStamped.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += geometry_msgs.msg.PoseStamped.getMessageSize(object.waypoint);
    return length + 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_go_to_waypointRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3e8a9f6eb12a0c008e39a6c36756eccc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool check_collision
    geometry_msgs/PoseStamped waypoint
    
    ================================================================================
    MSG: geometry_msgs/PoseStamped
    # A Pose with reference coordinate frame and timestamp
    Header header
    Pose pose
    
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
    const resolved = new planner_go_to_waypointRequest(null);
    if (msg.check_collision !== undefined) {
      resolved.check_collision = msg.check_collision;
    }
    else {
      resolved.check_collision = false
    }

    if (msg.waypoint !== undefined) {
      resolved.waypoint = geometry_msgs.msg.PoseStamped.Resolve(msg.waypoint)
    }
    else {
      resolved.waypoint = new geometry_msgs.msg.PoseStamped()
    }

    return resolved;
    }
};

class planner_go_to_waypointResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.path = null;
    }
    else {
      if (initObj.hasOwnProperty('path')) {
        this.path = initObj.path
      }
      else {
        this.path = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_go_to_waypointResponse
    // Serialize message field [path]
    // Serialize the length for message field [path]
    bufferOffset = _serializer.uint32(obj.path.length, buffer, bufferOffset);
    obj.path.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Pose.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_go_to_waypointResponse
    let len;
    let data = new planner_go_to_waypointResponse(null);
    // Deserialize message field [path]
    // Deserialize array length for message field [path]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.path = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.path[i] = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 56 * object.path.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_go_to_waypointResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3672a680f9a8e1a187c20ffb2e3a206b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Return best path.
    geometry_msgs/Pose[] path
    
    
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
    const resolved = new planner_go_to_waypointResponse(null);
    if (msg.path !== undefined) {
      resolved.path = new Array(msg.path.length);
      for (let i = 0; i < resolved.path.length; ++i) {
        resolved.path[i] = geometry_msgs.msg.Pose.Resolve(msg.path[i]);
      }
    }
    else {
      resolved.path = []
    }

    return resolved;
    }
};

module.exports = {
  Request: planner_go_to_waypointRequest,
  Response: planner_go_to_waypointResponse,
  md5sum() { return 'a26081f4c02132c8e0c868df86f2d5fe'; },
  datatype() { return 'planner_msgs/planner_go_to_waypoint'; }
};
