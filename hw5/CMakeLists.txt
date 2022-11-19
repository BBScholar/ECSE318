cmake_minimum_required(VERSION 3.10)
project(verilog_sim)

set(CMAKE_CXX_STANDARD 17)

include_directories(include)

file(GLOB_RECURSE include_files
  include/*.h
)

add_executable(verilog_sim
   src/sim.cpp
   src/gate.cpp 
   src/simulator.cpp
)

add_executable(verilog_parser src/parser.cpp)
