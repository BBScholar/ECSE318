# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/bscholar/Documents/ECSE318/hw5

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/bscholar/Documents/ECSE318/hw5/build

# Include any dependencies generated for this target.
include CMakeFiles/verilog_parser.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/verilog_parser.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/verilog_parser.dir/flags.make

CMakeFiles/verilog_parser.dir/src/parser.cpp.o: CMakeFiles/verilog_parser.dir/flags.make
CMakeFiles/verilog_parser.dir/src/parser.cpp.o: ../src/parser.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bscholar/Documents/ECSE318/hw5/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/verilog_parser.dir/src/parser.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/verilog_parser.dir/src/parser.cpp.o -c /home/bscholar/Documents/ECSE318/hw5/src/parser.cpp

CMakeFiles/verilog_parser.dir/src/parser.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/verilog_parser.dir/src/parser.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/bscholar/Documents/ECSE318/hw5/src/parser.cpp > CMakeFiles/verilog_parser.dir/src/parser.cpp.i

CMakeFiles/verilog_parser.dir/src/parser.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/verilog_parser.dir/src/parser.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/bscholar/Documents/ECSE318/hw5/src/parser.cpp -o CMakeFiles/verilog_parser.dir/src/parser.cpp.s

CMakeFiles/verilog_parser.dir/src/gate.cpp.o: CMakeFiles/verilog_parser.dir/flags.make
CMakeFiles/verilog_parser.dir/src/gate.cpp.o: ../src/gate.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bscholar/Documents/ECSE318/hw5/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/verilog_parser.dir/src/gate.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/verilog_parser.dir/src/gate.cpp.o -c /home/bscholar/Documents/ECSE318/hw5/src/gate.cpp

CMakeFiles/verilog_parser.dir/src/gate.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/verilog_parser.dir/src/gate.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/bscholar/Documents/ECSE318/hw5/src/gate.cpp > CMakeFiles/verilog_parser.dir/src/gate.cpp.i

CMakeFiles/verilog_parser.dir/src/gate.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/verilog_parser.dir/src/gate.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/bscholar/Documents/ECSE318/hw5/src/gate.cpp -o CMakeFiles/verilog_parser.dir/src/gate.cpp.s

# Object files for target verilog_parser
verilog_parser_OBJECTS = \
"CMakeFiles/verilog_parser.dir/src/parser.cpp.o" \
"CMakeFiles/verilog_parser.dir/src/gate.cpp.o"

# External object files for target verilog_parser
verilog_parser_EXTERNAL_OBJECTS =

verilog_parser: CMakeFiles/verilog_parser.dir/src/parser.cpp.o
verilog_parser: CMakeFiles/verilog_parser.dir/src/gate.cpp.o
verilog_parser: CMakeFiles/verilog_parser.dir/build.make
verilog_parser: /usr/lib/x86_64-linux-gnu/libspdlog.so.1.5.0
verilog_parser: CMakeFiles/verilog_parser.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/bscholar/Documents/ECSE318/hw5/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable verilog_parser"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/verilog_parser.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/verilog_parser.dir/build: verilog_parser

.PHONY : CMakeFiles/verilog_parser.dir/build

CMakeFiles/verilog_parser.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/verilog_parser.dir/cmake_clean.cmake
.PHONY : CMakeFiles/verilog_parser.dir/clean

CMakeFiles/verilog_parser.dir/depend:
	cd /home/bscholar/Documents/ECSE318/hw5/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/bscholar/Documents/ECSE318/hw5 /home/bscholar/Documents/ECSE318/hw5 /home/bscholar/Documents/ECSE318/hw5/build /home/bscholar/Documents/ECSE318/hw5/build /home/bscholar/Documents/ECSE318/hw5/build/CMakeFiles/verilog_parser.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/verilog_parser.dir/depend

