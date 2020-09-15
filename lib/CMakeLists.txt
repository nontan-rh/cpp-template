cmake_minimum_required(VERSION 3.10.2)
cmake_policy(VERSION 3.10.2...3.10.2)

add_library(library_objects OBJECT
    src/sample.cpp
    src/sample2.cpp
    )
target_setup_compile_options(library_objects)
target_include_directories(library_objects PRIVATE include)

if(BUILD_TESTING)
    add_library(unit_test_object OBJECT
        src/sample2.test.cpp
        )
    target_setup_compile_options(unit_test_object)
    target_include_directories(unit_test_object PRIVATE include $<TARGET_PROPERTY:gtest_main,INTERFACE_INCLUDE_DIRECTORIES>)
endif()

add_library(${CPP_TEMPLATE_LIBRARY_NAME} $<TARGET_OBJECTS:library_objects>)
add_library(${CPP_TEMPLATE_PACKAGE_NAME}::${CPP_TEMPLATE_LIBRARY_NAME} ALIAS ${CPP_TEMPLATE_LIBRARY_NAME})
target_setup_compile_options(${CPP_TEMPLATE_LIBRARY_NAME})

target_include_directories(${CPP_TEMPLATE_LIBRARY_NAME}
    INTERFACE 
    $<INSTALL_INTERFACE:include>    
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    )

install(
    TARGETS ${CPP_TEMPLATE_LIBRARY_NAME}
    EXPORT package_file_targets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION include
    )
install(DIRECTORY include/ DESTINATION include)
