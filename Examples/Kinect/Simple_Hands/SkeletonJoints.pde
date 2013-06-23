int uid = 1;

boolean autoCalib = true;

PVector jointPos = new PVector();
PVector jointPos2D = new PVector();

PVector SKEL_HEAD = new PVector();
PVector SKEL_NECK = new PVector();
PVector SKEL_LEFT_SHOULDER = new PVector();
PVector SKEL_LEFT_ELBOW = new PVector();
PVector SKEL_LEFT_HAND = new PVector();
PVector SKEL_RIGHT_SHOULDER = new PVector();
PVector SKEL_RIGHT_ELBOW = new PVector();
PVector SKEL_RIGHT_HAND = new PVector();
PVector SKEL_TORSO = new PVector();
PVector SKEL_LEFT_HIP = new PVector();
PVector SKEL_LEFT_KNEE = new PVector();
PVector SKEL_LEFT_FOOT = new PVector();
PVector SKEL_RIGHT_HIP = new PVector();
PVector SKEL_RIGHT_KNEE = new PVector();
PVector SKEL_RIGHT_FOOT = new PVector();

boolean updateSketeton()
{
  // if a skeleton is tracked
  if (context.isCalibratedSkeleton(uid))
  {
    try {
      // joints to track:
      // SKEL_HEAD, SKEL_NECK
      // SKEL_LEFT_SHOULDER, SKEL_LEFT_ELBOW, SKEL_LEFT_HAND
      // SKEL_RIGHT_SHOULDER, SKEL_RIGHT_ELBOW, SKEL_RIGHT_HAND
      // SKEL_TORSO
      // SKEL_LEFT_HIP, SKEL_LEFT_KNEE, SKEL_LEFT_FOOT
      // SKEL_RIGHT_HIP, SKEL_RIGHT_KNEE, SKEL_RIGHT_FOOT
            
      // get position of the head
      float confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_HEAD, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_HEAD.x = jointPos2D.x;
      SKEL_HEAD.y = jointPos2D.y;
      SKEL_HEAD.z = jointPos2D.z;

      // get position of the neck
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_NECK, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_NECK.x = jointPos2D.x;
      SKEL_NECK.y = jointPos2D.y;
      SKEL_NECK.z = jointPos2D.z;
      
      // get position of the left shoulder
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_LEFT_SHOULDER, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_LEFT_SHOULDER.x = jointPos2D.x;
      SKEL_LEFT_SHOULDER.y = jointPos2D.y;
      SKEL_LEFT_SHOULDER.z = jointPos2D.z;
      
      // get position of the left elbow
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_LEFT_ELBOW, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_LEFT_ELBOW.x = jointPos2D.x;
      SKEL_LEFT_ELBOW.y = jointPos2D.y;
      SKEL_LEFT_ELBOW.z = jointPos2D.z;
      
      // get position of the left hand
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_LEFT_HAND, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_LEFT_HAND.x = jointPos2D.x;
      SKEL_LEFT_HAND.y = jointPos2D.y;
      SKEL_LEFT_HAND.z = jointPos2D.z;
      
      // get position of the right shoulder
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_RIGHT_SHOULDER, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_RIGHT_SHOULDER.x = jointPos2D.x;
      SKEL_RIGHT_SHOULDER.y = jointPos2D.y;
      SKEL_RIGHT_SHOULDER.z = jointPos2D.z;
      
      // get position of the right elbow
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_RIGHT_ELBOW, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_RIGHT_ELBOW.x = jointPos2D.x;
      SKEL_RIGHT_ELBOW.y = jointPos2D.y;
      SKEL_RIGHT_ELBOW.z = jointPos2D.z;
      
      // get position of the right hand
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_RIGHT_HAND, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_RIGHT_HAND.x = jointPos2D.x;
      SKEL_RIGHT_HAND.y = jointPos2D.y;
      SKEL_RIGHT_HAND.z = jointPos2D.z;
      
      // get position of the torso
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_TORSO, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_TORSO.x = jointPos2D.x;
      SKEL_TORSO.y = jointPos2D.y;
      SKEL_TORSO.z = jointPos2D.z;
      
      // get position of the left hip
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_LEFT_HIP, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_LEFT_HIP.x = jointPos2D.x;
      SKEL_LEFT_HIP.y = jointPos2D.y;
      SKEL_LEFT_HIP.z = jointPos2D.z;
      
      // get position of the left knee
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_LEFT_KNEE, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_LEFT_KNEE.x = jointPos2D.x;
      SKEL_LEFT_KNEE.y = jointPos2D.y;
      SKEL_LEFT_KNEE.z = jointPos2D.z;
      
      // get position of the left foot
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_LEFT_FOOT, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_LEFT_FOOT.x = jointPos2D.x;
      SKEL_LEFT_FOOT.y = jointPos2D.y;
      SKEL_LEFT_FOOT.z = jointPos2D.z;
      
      // get position of the right hip
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_RIGHT_HIP, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_RIGHT_HIP.x = jointPos2D.x;
      SKEL_RIGHT_HIP.y = jointPos2D.y;
      SKEL_RIGHT_HIP.z = jointPos2D.z;
      
      // get position of the right knee
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_RIGHT_KNEE, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_RIGHT_KNEE.x = jointPos2D.x;
      SKEL_RIGHT_KNEE.y = jointPos2D.y;
      SKEL_RIGHT_KNEE.z = jointPos2D.z;
      
      // get position of the right knee
      confidence = context.getJointPositionSkeleton(uid, SimpleOpenNI.SKEL_RIGHT_FOOT, jointPos);
      context.convertRealWorldToProjective(jointPos, jointPos2D);

      SKEL_RIGHT_FOOT.x = jointPos2D.x;
      SKEL_RIGHT_FOOT.y = jointPos2D.y;
      SKEL_RIGHT_FOOT.z = jointPos2D.z;
      
      return true;
    }
    catch (Error e)
    {
      println(e);
      return false;
    }
  }
  else
  {
    return false;
  }
}



// -----------------------------------------------------------------
// SimpleOpenNI user events

void onNewUser(int userId)
{
  uid = userId;
  println("onNewUser - userId: " + userId);
  //println("  start pose detection");

  if (autoCalib)
    context.requestCalibrationSkeleton(userId, true);
  else    
    context.startPoseDetection("Psi", userId);
}

void onLostUser(int userId)
{
  uid = userId;
  println("onLostUser - userId: " + userId);
}

void onStartCalibration(int userId)
{
  uid = userId;
  println("onStartCalibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successfull)
{
  uid = userId;
  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);

  if (successfull) 
  { 
    println("  User calibrated !!!");
    context.startTrackingSkeleton(userId);
  } 
  else 
  { 
    println("  Failed to calibrate user !!!");
    //println("  Start pose detection");
    context.startPoseDetection("Psi", userId);
  }
}

void onStartPose(String pose, int userId)
{
  uid = userId;
  println("onStartdPose - userId: " + userId + ", pose: " + pose);
  //println(" stop pose detection");

  context.stopPoseDetection(userId); 
  context.requestCalibrationSkeleton(userId, true);
}

void onEndPose(String pose, int userId)
{
  uid = userId;
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}
