cmake_minimum_required(VERSION 3.14)

project("or-tools-boilerplate")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(ortools STATIC IMPORTED)

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

add_executable(${PROJECT_NAME} 
    "src/main.cpp"
)

target_link_libraries(${PROJECT_NAME} ortools)