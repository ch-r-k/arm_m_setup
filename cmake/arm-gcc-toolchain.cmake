set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR ARM)

if(MINGW OR CYGWIN OR WIN32)
    set(UTIL_SEARCH_CMD where)
elseif(UNIX OR APPLE)
    set(UTIL_SEARCH_CMD which)
endif()

set(TOOLCHAIN_PREFIX "arm-none-eabi-")

set(SPECS "-lc -lm -lnosys -specs=nosys.specs -specs=nano.specs")

# Without that flag CMake is not able to pass test compilation check
if (${CMAKE_VERSION} VERSION_EQUAL "3.6.0" OR ${CMAKE_VERSION} VERSION_GREATER "3.6")
    set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
endif ()

set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc CACHE STRING "")
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER} CACHE STRING "")
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++ CACHE STRING "")

# Default C compiler flags
set(CMAKE_C_FLAGS_DEBUG_INIT "-g3 -Og -Wall -DDEBUG ${SPECS}")
set(CMAKE_C_FLAGS_RELEASE_INIT "-O3 -Wall ${SPECS}")
set(CMAKE_C_FLAGS_MINSIZEREL_INIT "-Os -Wall ${SPECS}")
set(CMAKE_C_FLAGS_RELWITHDEBINFO_INIT  "-O2 -g -Wall ${SPECS}")
# Default C++ compiler flags
set(CMAKE_CXX_FLAGS_DEBUG_INIT "-g3 -Og -Wall -DDEBUG ${SPECS}")
set(CMAKE_CXX_FLAGS_RELEASE_INIT "-O3 -Wall ${SPECS}")
set(CMAKE_CXX_FLAGS_MINSIZEREL_INIT "-Os -Wall ${SPECS}")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT  "-O2 -g -Wall ${SPECS}")

find_program(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy DOC "objcopy tool")
find_program(CMAKE_SIZE_UTIL ${TOOLCHAIN_PREFIX}size DOC "size tool")