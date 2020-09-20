cmake_minimum_required(VERSION 3.10.2)
cmake_policy(VERSION 3.10.2...3.10.2)

set(libraries doctest::doctest ${CPP_TEMPLATE_LIBRARY_NAME})
# In some environments, libgcc and libstdc++ are not in the search paths
# and ctest fails with an exit code 0xc0000139 (entry point not found)
if((NOT MSVC) AND WIN32)
    list(APPEND libraries -static-libgcc -static-libstdc++ -static)
endif()

add_executable(standalone_test
    src/standalone.cpp
    $<TARGET_OBJECTS:integration_test_object>)
target_setup_compile_options(standalone_test)
target_link_libraries(standalone_test PRIVATE ${libraries})

if(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
    set_property(TARGET standalone_test PROPERTY OUTPUT_NAME "index")
    set_property(TARGET standalone_test PROPERTY SUFFIX ".html")
else()
    doctest_discover_tests(standalone_test)
endif()
