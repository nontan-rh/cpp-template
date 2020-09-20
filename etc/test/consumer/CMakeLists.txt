cmake_minimum_required(VERSION 3.10.2)
cmake_policy(VERSION 3.10.2...3.10.2)

include(../../../cmake/project_config.cmake)

project(cpptemplate_consumer)

find_package(${CPP_TEMPLATE_PACKAGE_NAME} REQUIRED)

add_executable(consumer main.c)
target_link_libraries(consumer ${CPP_TEMPLATE_PACKAGE_NAME}::${CPP_TEMPLATE_LIBRARY_NAME})
