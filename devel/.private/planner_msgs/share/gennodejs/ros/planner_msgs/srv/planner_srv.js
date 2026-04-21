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
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class planner_srvRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.bound_mode = null;
      this.root_pose = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('bound_mode')) {
        this.bound_mode = initObj.bound_mode
      }
      else {
        this.bound_mode = 0;
      }
      if (initObj.hasOwnProperty('root_pose')) {
        this.root_pose = initObj.root_pose
      }
      else {
        this.root_pose = new geometry_msgs.msg.Pose();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_srvRequest
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [bound_mode]
    bufferOffset = _serializer.int32(obj.bound_mode, buffer, bufferOffset);
    // Serialize message field [root_pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.root_pose, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_srvRequest
    let len;
    let data = new planner_srvRequest(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [bound_mode]
    data.bound_mode = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [root_pose]
    data.root_pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 60;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_srvRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '173b25791b1e0a7f0498fdd54b227c88';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Request the planner to run and return a path
    Header header
    
    # Set the bound mode of the robot to use in planner.
    # Use extension to actual size. (default)
    int32 kExtendedBound = 0
    int32 kRelaxedBound = 1
    int32 kMinBound = 2
    int32 kExactBound = 3
    int32 kNoBound = 4
    # Can only be used with one of above values. Check Params/BoundModeType for more details.
    int32 bound_mode
    
    # Set root pose if requires the planner starts planning from this root.
    # Otherwise, set all to zero, planner will start at robot's current state.
    geometry_msgs/Pose root_pose
    
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
    const resolved = new planner_srvRequest(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.bound_mode !== undefined) {
      resolved.bound_mode = msg.bound_mode;
    }
    else {
      resolved.bound_mode = 0
    }

    if (msg.root_pose !== undefined) {
      resolved.root_pose = geometry_msgs.msg.Pose.Resolve(msg.root_pose)
    }
    else {
      resolved.root_pose = new geometry_msgs.msg.Pose()
    }

    return resolved;
    }
};

// Constants for message
planner_srvRequest.Constants = {
  KEXTENDEDBOUND: 0,
  KRELAXEDBOUND: 1,
  KMINBOUND: 2,
  KEXACTBOUND: 3,
  KNOBOUND: 4,
}

class planner_srvResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.status = null;
      this.planning_bound_mode = null;
      this.path = null;
    }
    else {
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = 0;
      }
      if (initObj.hasOwnProperty('planning_bound_mode')) {
        this.planning_bound_mode = initObj.planning_bound_mode
      }
      else {
        this.planning_bound_mode = 0;
      }
      if (initObj.hasOwnProperty('path')) {
        this.path = initObj.path
      }
      else {
        this.path = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type planner_srvResponse
    // Serialize message field [status]
    bufferOffset = _serializer.int32(obj.status, buffer, bufferOffset);
    // Serialize message field [planning_bound_mode]
    bufferOffset = _serializer.int32(obj.planning_bound_mode, buffer, bufferOffset);
    // Serialize message field [path]
    // Serialize the length for message field [path]
    bufferOffset = _serializer.uint32(obj.path.length, buffer, bufferOffset);
    obj.path.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Pose.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type planner_srvResponse
    let len;
    let data = new planner_srvResponse(null);
    // Deserialize message field [status]
    data.status = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [planning_bound_mode]
    data.planning_bound_mode = _deserializer.int32(buffer, bufferOffset);
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
    return length + 12;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/planner_srvResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0d92f8e1aaba13be2917646209d77e2a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 kForward = 0
    int32 kBackward = 1
    int32 kHoming = 2
    int32 kRepositioning = 3
    # Status of the best path, take one of the above values.
    int32 status
    
    # Return actual bound mode used for planning
    int32 planning_bound_mode
    
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
    const resolved = new planner_srvResponse(null);
    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = 0
    }

    if (msg.planning_bound_mode !== undefined) {
      resolved.planning_bound_mode = msg.planning_bound_mode;
    }
    else {
      resolved.planning_bound_mode = 0
    }

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

// Constants for message
planner_srvResponse.Constants = {
  KFORWARD: 0,
  KBACKWARD: 1,
  KHOMING: 2,
  KREPOSITIONING: 3,
}

module.exports = {
  Request: planner_srvRequest,
  Response: planner_srvResponse,
  md5sum() { return 'a3f85517a01be073ddd96543af02aefb'; },
  datatype() { return 'planner_msgs/planner_srv'; }
};
