
# Platforms

if(CMAKE_C_COMPILER_ID MATCHES "Clang" OR CMAKE_C_COMPILER_ID MATCHES "GNU")
    # GCC-like
elseif(CMAKE_C_COMPILER_ID MATCHES "MSVC")
    # MSVC
endif()

if(CMAKE_SYSTEM_NAME MATCHES "Windows")
    # Windows
else()
    # Unix-like
endif()

# Options

option(BUILD_TESTING "Build test" ON)
option(CPP_TEMPLATE_ENABLE_ASAN "Build with ASAN support (GCC/clang and *nix required)")

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CPP_TEMPLATE_COMPILE_OPTIONS "")
set(CPP_TEMPLATE_COMPILE_DEFINITIONS "")

if(CPP_TEMPLATE_ENABLE_ASAN)
    # Use directly instead of target_compile_options, LINK_OPTIONS, add_link_options
    # or target_link_options because it's not available before version 3.13.0
    # list(APPEND CPP_TEMPLATE_COMPILE_OPTIONS -fsanitize=address)
    list(APPEND CMAKE_C_FLAGS -fsanitize=address)
    list(APPEND CMAKE_CXX_FLAGS -fsanitize=address)
endif()

if(MSVC)
    list(APPEND CPP_TEMPLATE_COMPILE_OPTIONS /W4 /WX)
else()
    list(APPEND CPP_TEMPLATE_COMPILE_OPTIONS -Wall -Wextra -pedantic -Werror)
endif()

if(CMAKE_SYSTEM_NAME MATCHES "Windows")
    list(APPEND CPP_TEMPLATE_COMPILE_DEFINITIONS _WIN32_WINNT=_WIN32_WINNT_WIN8)
elseif(CMAKE_SYSTEM_NAME MATCHES "Emscripten")
    set(CPP_TEMPLATE_EMSCRIPTEN_FLAGS "-s USE_PTHREADS=1 -s PROXY_TO_PTHREAD=1 -s EXIT_RUNTIME=1 --shell-file ${CMAKE_CURRENT_SOURCE_DIR}/etc/test/wasm/shell.html")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CPP_TEMPLATE_EMSCRIPTEN_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CPP_TEMPLATE_EMSCRIPTEN_FLAGS}")
endif()

function(target_setup_compile_options target)
    set_property(TARGET ${target} PROPERTY POSITION_INDEPENDENT_CODE ON)
    target_compile_options(${target} PRIVATE ${CPP_TEMPLATE_COMPILE_OPTIONS})
    target_compile_definitions(${target} PRIVATE ${CPP_TEMPLATE_COMPILE_DEFINITIONS})
endfunction()
