cmake_minimum_required(VERSION 3.10.2)
cmake_policy(VERSION 3.10.2...3.10.2)

if(${CMAKE_SYSTEM_NAME} MATCHES "Android")
    message(STATUS "CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME} matches 'Android', so it will build the library as shared library.")
    set(TEST_LIBRARY_TYPE SHARED)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "iOS")
    message(STATUS "CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME} matches 'iOS', so it will build the library as static library.")
    set(TEST_LIBRARY_TYPE STATIC)
elseif(TIDY_MODE)
    set(TEST_LIBRARY_TYPE STATIC)
else()
    message(FATAL_ERROR "Unknown CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}")
endif()

add_library(hosted_test_library ${TEST_LIBRARY_TYPE}
    src/hosted.cpp
    $<TARGET_OBJECTS:unit_test_object>
    $<TARGET_OBJECTS:integration_test_object>)

target_setup_compile_options(hosted_test_library)
target_link_libraries(hosted_test_library PRIVATE gtest_main ${CPP_TEMPLATE_LIBRARY_NAME})
target_include_directories(hosted_test_library PUBLIC include)
