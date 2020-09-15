cmake_minimum_required(VERSION 3.10.2)
cmake_policy(VERSION 3.10.2...3.10.2)

set(CPP_TEMPLATE_PROJECT_NAME          sample_project)
set(CPP_TEMPLATE_PACKAGE_NAME          sample)
set(CPP_TEMPLATE_PACKAGE_VERSION       0.0.1)
set(CPP_TEMPLATE_PACKAGE_COMPATIBILITY AnyNewerVersion)
set(CPP_TEMPLATE_LIBRARY_NAME          sample)

project(CPP_TEMPLATE_PROJECT_NAME)

set(CMAKE_DISABLE_SOURCE_CHANGES ON)

include(CMakePackageConfigHelpers)
include(cmake/load_external_project.cmake)
include(cmake/build_config.cmake)

if(BUILD_TESTING)
    enable_testing()
    include(GoogleTest)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    load_external_project(cmake/external_projects/googletest.cmake)
endif()

add_subdirectory(lib)

if(BUILD_TESTING)
    add_subdirectory(test)

    if((${CMAKE_SYSTEM_NAME} MATCHES "Android") OR (${CMAKE_SYSTEM_NAME} MATCHES "iOS"))
        message(STATUS "CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME} matches 'Android' or 'iOS', so it won't build the test executable but builds a library.")
        add_subdirectory(etc/test/hosted)
    elseif(TIDY_MODE)
        add_subdirectory(etc/test/hosted)
        add_subdirectory(etc/test/standalone)
    else()
        add_subdirectory(etc/test/standalone)
    endif()
endif()

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${CPP_TEMPLATE_PACKAGE_NAME}/${CPP_TEMPLATE_PACKAGE_NAME}-config-version.cmake"
    VERSION "${CPP_TEMPLATE_PACKAGE_VERSION}"
    COMPATIBILITY "${CPP_TEMPLATE_PACKAGE_COMPATIBILITY}"
    )

export(
    EXPORT package_file_targets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/${CPP_TEMPLATE_PACKAGE_NAME}/${CPP_TEMPLATE_PACKAGE_NAME}-targets.cmake"
    NAMESPACE "${CPP_TEMPLATE_PACKAGE_NAME}::"
    )
configure_file(cmake/package/config.cmake
    "${CMAKE_CURRENT_BINARY_DIR}/${CPP_TEMPLATE_PACKAGE_NAME}/${CPP_TEMPLATE_PACKAGE_NAME}-config.cmake"
    @ONLY
    )

set(config_package_location "lib/cmake/${CPP_TEMPLATE_PACKAGE_NAME}")
install(EXPORT package_file_targets
    FILE
    "${CPP_TEMPLATE_PACKAGE_NAME}-targets.cmake"
    NAMESPACE
    "${CPP_TEMPLATE_PACKAGE_NAME}::"
    DESTINATION
    ${config_package_location}
    )
install(
    FILES
    cmake/package/config.cmake
    "${CMAKE_CURRENT_BINARY_DIR}/${CPP_TEMPLATE_PACKAGE_NAME}/${CPP_TEMPLATE_PACKAGE_NAME}-config-version.cmake"
    DESTINATION
    ${config_package_location}
    )
