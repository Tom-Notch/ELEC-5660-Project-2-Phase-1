USER_LOCAL_PATH:=$(LOCAL_PATH)
LOCAL_PATH:=$(call my-dir)
### GLOBAL VARIABLES
ARUCO_STATIC_LIBRARIES:= aruco
ARUCO_C_INCLUDES:= $(LOCAL_PATH)/include

##ADD THE MODULE TO THE PROJECT
include $(CLEAR_VARS)
LOCAL_MODULE:= aruco
LOCAL_SRC_FILES:=libs/$(TARGET_ARCH_ABI)/libaruco.a
include $(PREBUILT_STATIC_LIBRARY)

LOCAL_PATH:=$(USER_LOCAL_PATH)
