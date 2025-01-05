cmake_minimum_required(VERSION 3.10)

project(gst_mobile_library VERSION 0.0.1 LANGUAGES C CXX)

if(DEFINED ENV{GSTREAMER_ROOT_ANDROID})
    set(GSTREAMER_ROOT_ANDROID $ENV{GSTREAMER_ROOT_ANDROID})
endif()

if(NOT DEFINED GSTREAMER_ROOT_ANDROID)
    message(FATAL_ERROR "GSTREAMER_ROOT_ANDROID is not defined!")
endif()

if(ANDROID_ABI STREQUAL "armeabi")
    set(GSTREAMER_ROOT "${GSTREAMER_ROOT_ANDROID}/arm")
elseif(ANDROID_ABI STREQUAL "armeabi-v7a")
    set(GSTREAMER_ROOT "${GSTREAMER_ROOT_ANDROID}/armv7")
elseif(ANDROID_ABI STREQUAL "arm64-v8a")
    set(GSTREAMER_ROOT "${GSTREAMER_ROOT_ANDROID}/arm64")
elseif(ANDROID_ABI STREQUAL "x86")
    set(GSTREAMER_ROOT "${GSTREAMER_ROOT_ANDROID}/x86")
elseif(ANDROID_ABI STREQUAL "x86_64")
    set(GSTREAMER_ROOT "${GSTREAMER_ROOT_ANDROID}/x86_64")
else()
    message(FATAL_ERROR "Target arch ABI not supported: ${ANDROID_ABI}")
endif()

list(APPEND CMAKE_MODULE_PATH "${GSTREAMER_ROOT}/share/cmake")
set(GSTREAMER_NDK_BUILD_PATH  "${GSTREAMER_ROOT}/share/gst-android/ndk-build/")
set(GSTREAMER_PLUGINS         coreelements)
find_library(LOG_LIB log REQUIRED)
find_package(GStreamerMobile COMPONENTS ${GSTREAMER_PLUGINS} REQUIRED)


add_library(gst_mobile SHARED
  "gst_mobile.c"
)
target_link_libraries(gst_mobile
    PUBLIC
        GStreamer::mobile
        ${ANDROID_LIB}
        ${LOG_LIB}
)
set_target_properties(gst_mobile 
  PROPERTIES
    PUBLIC_HEADER gst_mobile.h
    OUTPUT_NAME "gst_mobile"
)
target_compile_definitions(gst_mobile PUBLIC DART_SHARED_LIB)
