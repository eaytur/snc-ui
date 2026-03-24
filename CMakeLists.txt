cmake_minimum_required(VERSION 3.16)

project(snc_ui LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.5)
qt_policy(SET QTP0004 NEW)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

set(SNCUI_QML_INSTALL_DIR "${CMAKE_INSTALL_DATADIR}/SncUi/qml")

add_subdirectory(qml)
add_subdirectory(examples/gallery)

configure_package_config_file(
    cmake/SncUiConfig.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/SncUiConfig.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/SncUi"
)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/SncUiConfigVersion.cmake"
    VERSION 1.0.0
    COMPATIBILITY SameMajorVersion
)

install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/SncUiConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/SncUiConfigVersion.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/SncUi"
)
