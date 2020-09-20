cmake_minimum_required(VERSION 3.10.2)
cmake_policy(VERSION 3.10.2...3.10.2)

include(cmake/project_config.cmake)

project(CPP_TEMPLATE_PROJECT_NAME)

set(CMAKE_DISABLE_SOURCE_CHANGES ON)

list(APPEND CMAKE_FIND_ROOT_PATH "${CMAKE_CURRENT_BINARY_DIR}/local")
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_CURRENT_BINARY_DIR}/local")

include(CMakePackageConfigHelpers)
include(cmake/install_external_project.cmake)
include(cmake/build_config.cmake)

if(BUILD_TESTING)
    enable_testing()
    install_external_project(cmake/external_projects/doctest.cmake)
    find_package(doctest REQUIRED)
    include(doctest)
endif()

add_subdirectory(lib)

if(BUILD_TESTING)
    add_subdirectory(test)

    if((${CMAKE_SYSTEM_NAME} MATCHES "Android") OR (${CMAKE_SYSTEM_NAME} MATCHES "iOS"))
        # message(STATUS "CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME} matches 'Android' or 'iOS', so it won't build the test executable but builds a library.")
        # add_subdirectory(etc/test/hosted)
    elseif(TIDY_MODE)
        # add_subdirectory(etc/test/hosted)
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
    "${CMAKE_CURRENT_BINARY_DIR}/${CPP_TEMPLATE_PACKAGE_NAME}/${CPP_TEMPLATE_PACKAGE_NAME}-config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/${CPP_TEMPLATE_PACKAGE_NAME}/${CPP_TEMPLATE_PACKAGE_NAME}-config-version.cmake"
    DESTINATION
    ${config_package_location}
    )
