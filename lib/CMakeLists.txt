cmake_minimum_required(VERSION 3.10.2)
cmake_policy(VERSION 3.10.2...3.10.2)

add_library(library_objects OBJECT
    src/internal.cpp
    src/public.cpp
    )
target_setup_compile_options(library_objects)
# Use $<TARGET_PROPERTY:*,INTERFACE_INCLUDE_DIRECTORIES> instead of
# target_link_libraries because Linking Object Library feature is not
# available before version 3.12.0
target_include_directories(library_objects PRIVATE include $<TARGET_PROPERTY:doctest::doctest,INTERFACE_INCLUDE_DIRECTORIES>)

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
