project(HelloWorld C CXX)
cmake_minimum_required(VERSION 3.0)

add_executable(hello_world_cpp main.cpp)
set_target_properties(hello_world_cpp PROPERTIES POSITION_INDEPENDENT_CODE ON)

add_executable(hello_world_c main.c)
set_target_properties(hello_world_c PROPERTIES POSITION_INDEPENDENT_CODE ON)
