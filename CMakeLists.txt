cmake_minimum_required(VERSION 3.31)

project(NitroCalc VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)

message(NOTICE "----- Qt version: ${QT_VERSION} -----")
file(WRITE .github/workflows/qt/VERSION ${QT_VERSION})

qt_standard_project_setup()
set(CMAKE_AUTORCC ON)


file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS src/*.cpp)
qt_add_executable(${PROJECT_NAME} ${SOURCES})

target_include_directories(${PROJECT_NAME} PRIVATE
    src
)

target_link_libraries(${PROJECT_NAME} PRIVATE Qt${QT_VERSION_MAJOR}::Widgets)

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE ON
    WIN32_EXECUTABLE ON
    RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin$<0:>
)
