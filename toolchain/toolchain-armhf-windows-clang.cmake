# Toolchain-File für Windows Host mit Clang und Buildroot-Sysroot (ARMv7)
SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_PROCESSOR arm)

SET(CMAKE_C_COMPILER clang.exe)
SET(CMAKE_CXX_COMPILER clang++.exe)

IF(NOT DEFINED ENV{{SYSROOT}})
  MESSAGE(FATAL_ERROR "SYSROOT environment variable is not set")
ENDIF()

FILE(TO_CMAKE_PATH "$ENV{{SYSROOT}}" SYSROOT_PATH)
SET(CMAKE_SYSROOT {{SYSROOT_PATH}})
SET(CMAKE_FIND_ROOT_PATH {{SYSROOT_PATH}})

SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

SET(CMAKE_C_COMPILER_TARGET armv7a-linux-gnueabihf)
SET(CMAKE_CXX_COMPILER_TARGET armv7a-linux-gnueabihf)
