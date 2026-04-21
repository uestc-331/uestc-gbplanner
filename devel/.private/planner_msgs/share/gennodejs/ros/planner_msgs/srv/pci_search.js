// Auto-generated. Do not edit!

// (in-package planner_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class pci_searchRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.use_current_state = null;
      this.not_exe_path = null;
      this.bound_mode = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('use_current_state')) {
        this.use_current_state = initObj.use_current_state
      }
      else {
        this.use_current_state = false;
      }
      if (initObj.hasOwnProperty('not_exe_path')) {
        this.not_exe_path = initObj.not_exe_path
      }
      else {
        this.not_exe_path = false;
      }
      if (initObj.hasOwnProperty('bound_mode')) {
        this.bound_mode = initObj.bound_mode
      }
      else {
        this.bound_mode = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type pci_searchRequest
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [use_current_state]
    bufferOffset = _serializer.bool(obj.use_current_state, buffer, bufferOffset);
    // Serialize message field [not_exe_path]
    bufferOffset = _serializer.bool(obj.not_exe_path, buffer, bufferOffset);
    // Serialize message field [bound_mode]
    bufferOffset = _serializer.int32(obj.bound_mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type pci_searchRequest
    let len;
    let data = new pci_searchRequest(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [use_current_state]
    data.use_current_state = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [not_exe_path]
    data.not_exe_path = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [bound_mode]
    data.bound_mode = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 6;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/pci_searchRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1853bf2c89b9dd526853f80fd427e36f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Request the planning through the planner control interface node.
    Header header
    # Set True if want to set source pose at current robot's state;
    # otherwise, get from inter=active marker
    bool use_current_state
    bool not_exe_path
    
    # Set the bound mode of the robot to use in planner.
    # Use extension to actual size. (default)
    int32 kExtendedBound = 0
    int32 kRelaxedBound = 1
    int32 kMinBound = 2
    int32 kExactBound = 3
    int32 kNoBound = 4
    # Can only be used with one of above values. Check Params/BoundModeType for more details.
    int32 bound_mode
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new pci_searchRequest(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.use_current_state !== undefined) {
      resolved.use_current_state = msg.use_current_state;
    }
    else {
      resolved.use_current_state = false
    }

    if (msg.not_exe_path !== undefined) {
      resolved.not_exe_path = msg.not_exe_path;
    }
    else {
      resolved.not_exe_path = false
    }

    if (msg.bound_mode !== undefined) {
      resolved.bound_mode = msg.bound_mode;
    }
    else {
      resolved.bound_mode = 0
    }

    return resolved;
    }
};

// Constants for message
pci_searchRequest.Constants = {
  KEXTENDEDBOUND: 0,
  KRELAXEDBOUND: 1,
  KMINBOUND: 2,
  KEXACTBOUND: 3,
  KNOBOUND: 4,
}

class pci_searchResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.path = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
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
    // Serializes a message object of type pci_searchResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [path]
    // Serialize the length for message field [path]
    bufferOffset = _serializer.uint32(obj.path.length, buffer, bufferOffset);
    obj.path.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Pose.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type pci_searchResponse
    let len;
    let data = new pci_searchResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
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
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'planner_msgs/pci_searchResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '62748822dcefeab180ca55bb32576dd6';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success
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
    const resolved = new pci_searchResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
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

module.exports = {
  Request: pci_searchRequest,
  Response: pci_searchResponse,
  md5sum() { return 'f1ece3929bac9df7327e2d5bd5fa9145'; },
  datatype() { return 'planner_msgs/pci_search'; }
};
