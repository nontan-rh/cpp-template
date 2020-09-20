
function(install_external_project project_def_path)
    get_filename_component(project_name ${project_def_path} NAME_WE)
    configure_file(${project_def_path} ${project_name}-build/CMakeLists.txt @ONLY)

    if(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
        set(wrapped_cmake_command "emcmake" ${CMAKE_COMMAND})
    else()
        set(wrapped_cmake_command ${CMAKE_COMMAND})
    endif()

    execute_process(COMMAND ${wrapped_cmake_command} . -G "${CMAKE_GENERATOR}"
        RESULT_VARIABLE result
        OUTPUT_VARIABLE stdout
        ERROR_VARIABLE stderr
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${project_name}-build)
    if(result)
        message(FATAL_ERROR "CMake step for ${project_name} failed\n${result}\nstdout:\n${stdout}\n\nstderr:\n${stderr}")
    else()
        message(STATUS "CMake step for ${project_name} done\nstdout:\n${stdout}\nstderr:\n${stderr}")
    endif()

    execute_process(COMMAND ${CMAKE_COMMAND} --build .
        RESULT_VARIABLE result
        OUTPUT_VARIABLE stdout
        ERROR_VARIABLE stderr
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${project_name}-build)
    if(result)
        message(FATAL_ERROR "Build step for ${project_name} failed\n${result}\nstdout:\n${stdout}\n\nstderr:\n${stderr}")
    else()
        message(STATUS "Build step for ${project_name} done\nstdout:\n${stdout}\nstderr:\n${stderr}")
    endif()
endfunction()
