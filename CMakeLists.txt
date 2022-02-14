cmake_minimum_required(VERSION 3.20)

project("or-tools-boilerplate")

if (MSVC AND CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 19.29.30129 AND CMAKE_VERSION VERSION_GREATER 3.20.3)
    # this change happened in CMake 3.20.4
    set(CMAKE_CXX_STANDARD 23) # /std:c++latest - unlocks the non stable cpp20 features. For new 16.11 versions
else ()
    set(CMAKE_CXX_STANDARD 20) # /std:c++latest for msvc and -std=c++20 for everyone else.
endif ()

set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(ortools STATIC IMPORTED)

# set_property(TARGET ortools PROPERTY
#  MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
  
set_property(
  TARGET ortools APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG
)

set_target_properties(ortools PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${OR_TOOLS_ROOT}/lib/ortools.lib"
)

set_property(
  TARGET ortools APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE
)

set_target_properties(ortools PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${OR_TOOLS_ROOT}/lib/ortools.lib"
)
  
set_target_properties(ortools PROPERTIES
  MAP_IMPORTED_CONFIG_MINSIZEREL Release
  MAP_IMPORTED_CONFIG_RELWITHDEBINFO Release
)

target_include_directories(ortools INTERFACE "${OR_TOOLS_ROOT}/include")

target_compile_definitions(ortools INTERFACE
  _SILENCE_STDEXT_HASH_DEPRECATION_WARNINGS
  __WIN32__
  NOMINMAX
  WIN32_LEAN_AND_MEAN=1
  _CRT_SECURE_NO_WARNING
  USE_BOP
  USE_GLOP
  USE_CBC
  USE_CLP
  USE_SCIP
  GOOGLE_GLOG_DLL_DECL=
  PSAPI_VERSION=1
)



add_executable(${PROJECT_NAME} 
    "src/main.cpp"
)

# t_property(TARGET ${PROJECT_NAME} PROPERTY
#  MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

target_link_libraries(${PROJECT_NAME} psapi ws2_32 ortools)
