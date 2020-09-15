cmake_minimum_required(VERSION 3.10.2)
cmake_policy(VERSION 3.10.2...3.10.2)

add_library(integration_test_object OBJECT
    src/sample.cpp
    )
target_setup_compile_options(integration_test_object)
# Use $<TARGET_PROPERTY:*,INTERFACE_INCLUDE_DIRECTORIES> instead of
# target_link_libraries because Linking Object Library feature is not
# available before version 3.12.0
target_include_directories(integration_test_object
    PRIVATE
    $<TARGET_PROPERTY:gtest_main,INTERFACE_INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:${CPP_TEMPLATE_LIBRARY_NAME},INTERFACE_INCLUDE_DIRECTORIES>)
