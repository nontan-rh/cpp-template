cmake_minimum_required(VERSION 3.10.2)
cmake_policy(VERSION 3.10.2...3.10.2)

project(doctest-download NONE)

include(ExternalProject)

set(child_cmake_args
    "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
    )

if(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
    set(child_cmake_command "emcmake")
    list(INSERT child_cmake_args 0 "cmake")
else()
    set(child_cmake_command ${CMAKE_COMMAND})
endif()

ExternalProject_Add(
    doctest
    PREFIX "@CMAKE_CURRENT_BINARY_DIR@/local"
    GIT_REPOSITORY https://github.com/onqtam/doctest.git
    GIT_TAG 2.4.0
    GIT_SHALLOW ON
    CMAKE_COMMAND "${child_cmake_command}"
    CMAKE_ARGS ${child_cmake_args}
)
