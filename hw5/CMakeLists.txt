cmake_minimum_required(VERSION 3.10)
project(verilog_sim)

include(CheckIPOSupported)

set(CMAKE_CXX_STANDARD 20)

include_directories(include)

file(GLOB_RECURSE include_files
  include/*.h
)

add_executable(verilog_sim
   src/sim.cpp
   src/gate.cpp 
   src/simulator.cpp
   src/string_util.cpp
)

add_executable(verilog_parser
  src/parser.cpp
  src/top.cpp
  src/gate.cpp
  src/string_util.cpp
)

check_ipo_supported(RESULT supported OUTPUT error)

if(supported)
  message(STATUS "LTO supported")
  set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
else()
  message(STATUS "LTO not supported")
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -s")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -s")
