cmake_minimum_required(VERSION 3.10.2)
cmake_policy(VERSION 3.10.2...3.10.2)

add_executable(standalone_test
    src/standalone.cpp
    $<TARGET_OBJECTS:unit_test_object>
    $<TARGET_OBJECTS:integration_test_object>)
target_setup_compile_options(standalone_test)
target_link_libraries(standalone_test PRIVATE gtest_main ${CPP_TEMPLATE_LIBRARY_NAME})

if(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
    set_property(TARGET standalone_test PROPERTY OUTPUT_NAME "index")
    set_property(TARGET standalone_test PROPERTY SUFFIX ".html")
else()
    gtest_discover_tests(standalone_test)
endif()
