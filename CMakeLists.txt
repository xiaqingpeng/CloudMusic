cmake_minimum_required(VERSION 3.16)

project(CloudMusic 
    VERSION 1.0.0
    DESCRIPTION "CloudMusic - A Modern Qt-based Music Player"
    LANGUAGES CXX
)

# ============================================================================
# Project Options
# ============================================================================
option(BUILD_TESTS "Build unit tests" OFF)
option(BUILD_DOCS "Build documentation" OFF)
option(ENABLE_LOGGING "Enable logging system" ON)
option(ENABLE_ANALYTICS "Enable analytics" OFF)

# ============================================================================
# C++ Standard and Compiler Settings
# ============================================================================
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Set default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type" FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# ============================================================================
# CMake Policies
# ============================================================================
if(POLICY CMP0071)
    cmake_policy(SET CMP0071 NEW)
endif()
if(POLICY CMP0100)
    cmake_policy(SET CMP0100 NEW)
endif()

# ============================================================================
# CMake Modules
# ============================================================================
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")
include(GNUInstallDirs)

# ============================================================================
# Qt Configuration
# ============================================================================
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS 
    Core
    Quick
    Qml
    Gui
    Network
    Multimedia
)

# Set Qt QML policies
if(COMMAND qt_policy)
    qt_policy(SET QTP0001 NEW)
    qt_policy(SET QTP0004 NEW)
endif()

# ============================================================================
# Project Configuration
# ============================================================================
configure_file(
    "${CMAKE_SOURCE_DIR}/src/core/Version.h.in"
    "${CMAKE_BINARY_DIR}/generated/Version.h"
    @ONLY
)

# ============================================================================
# Source Files
# ============================================================================
set(PROJECT_SOURCES
    src/main.cpp
)

set(PROJECT_HEADERS
    "${CMAKE_BINARY_DIR}/generated/Version.h"
)

# Core module
set(CORE_SOURCES
    src/core/Application.cpp
    src/core/Config.cpp
    src/core/Logger.cpp
)

set(CORE_HEADERS
    src/core/Application.h
    src/core/Config.h
    src/core/Logger.h
)

# ============================================================================
# QML Files Organization
# ============================================================================
set(QML_PAGES
    src/ui/Main.qml
    src/ui/leftpage/MyLeftRect.qml
    src/ui/leftpage/MyLeftTopRect.qml
    src/ui/leftpage/MyLeftBottomRect.qml
    src/ui/righpage/MyRightRect.qml
    src/ui/righpage/MyRightTopRect.qml
    src/ui/righpage/MyRightBottomRect.qml
    src/ui/bottompage/MyBottomRect.qml
)

set(QML_COMPONENTS_COMMON
    src/ui/commonui/MyWindowRect.qml
    src/ui/commonui/MyImageRect.qml
)

set(QML_COMPONENTS_LEFT
    src/ui/leftpage/components/MenuItem.qml
    src/ui/leftpage/components/SectionHeader.qml
    src/ui/leftpage/components/Divider.qml
)

set(QML_COMPONENTS_RIGHT_TOPBAR
    src/ui/righpage/components/topbar/WindowControl.qml
    src/ui/righpage/components/topbar/SearchBar.qml
    src/ui/righpage/components/topbar/IconButton.qml
    src/ui/righpage/components/topbar/TextButton.qml
    src/ui/righpage/components/topbar/RankingCard.qml
    src/ui/righpage/components/topbar/SearchSuggestionPopup.qml
    src/ui/righpage/components/topbar/HotSearchPopup.qml
    src/ui/righpage/components/topbar/LoginPopup.qml
)

set(QML_COMPONENTS_RIGHT_CONTENT
    src/ui/righpage/components/bannerswiper/BannerSwiper.qml
    src/ui/righpage/components/songlist/SongListCard.qml
    src/ui/righpage/components/audiobook/AudioBookCard.qml
)

set(QML_COMPONENTS_BOTTOM
    src/ui/bottompage/components/AlbumCover.qml
    src/ui/bottompage/components/SongInfo.qml
    src/ui/bottompage/components/ActionButton.qml
    src/ui/bottompage/components/PlayButton.qml
    src/ui/bottompage/components/ControlButton.qml
    src/ui/bottompage/components/ProgressBar.qml
    src/ui/bottompage/components/PlaylistDrawer.qml
    src/ui/bottompage/components/QualityMenu.qml
    src/ui/bottompage/components/QualityItem.qml
    src/ui/bottompage/components/MoreMenu.qml
    src/ui/bottompage/components/MoreMenuItem.qml
)

set(QML_VIEWMODELS
    src/ui/viewmodels/SearchViewModel.qml
    src/ui/viewmodels/MusicPlayerViewModel.qml
    src/ui/viewmodels/ContentViewModel.qml
)

set(QML_THEME
    src/ui/theme/Theme.qml
)

# ============================================================================
# Resource Files
# ============================================================================
set(QML_RESOURCES
    src/ui/theme/qmldir
    src/ui/righpage/components/topbar/qmldir
    src/ui/viewmodels/qmldir
)

set(ICON_RESOURCES
    src/resources/icons/left.svg
    src/resources/icons/down.svg
    src/resources/icons/down_s.svg
    src/resources/icons/people.svg
    src/resources/icons/mic.svg
    src/resources/icons/setting.svg
    src/resources/icons/music.svg
)

# ============================================================================
# Executable Target
# ============================================================================
qt_add_executable(appCloudMusic
    ${PROJECT_SOURCES}
    ${PROJECT_HEADERS}
    ${CORE_SOURCES}
    ${CORE_HEADERS}
)

# Set singleton properties for ViewModels
set_source_files_properties(
    ${QML_VIEWMODELS}
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)

# ============================================================================
# QML Module
# ============================================================================
qt_add_qml_module(appCloudMusic
    URI CloudMusic
    VERSION 1.0
    QML_FILES
        ${QML_PAGES}
        ${QML_COMPONENTS_COMMON}
        ${QML_COMPONENTS_LEFT}
        ${QML_COMPONENTS_RIGHT_TOPBAR}
        ${QML_COMPONENTS_RIGHT_CONTENT}
        ${QML_COMPONENTS_BOTTOM}
        ${QML_VIEWMODELS}
        ${QML_THEME}
    RESOURCES
        ${QML_RESOURCES}
        ${ICON_RESOURCES}
        RESOURCES src/img.qrc
)

# ============================================================================
# Include Directories
# ============================================================================
target_include_directories(appCloudMusic PRIVATE
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_BINARY_DIR}/generated
)

# ============================================================================
# Compile Definitions
# ============================================================================
target_compile_definitions(appCloudMusic PRIVATE
    QT_DEPRECATED_WARNINGS
    QT_DISABLE_DEPRECATED_BEFORE=0x060000
    $<$<CONFIG:Debug>:QT_QML_DEBUG>
)

if(ENABLE_LOGGING)
    target_compile_definitions(appCloudMusic PRIVATE ENABLE_LOGGING)
endif()

if(ENABLE_ANALYTICS)
    target_compile_definitions(appCloudMusic PRIVATE ENABLE_ANALYTICS)
endif()

# ============================================================================
# Compiler Warnings
# ============================================================================
if(MSVC)
    target_compile_options(appCloudMusic PRIVATE /W4)
else()
    target_compile_options(appCloudMusic PRIVATE 
        -Wall -Wextra -Wpedantic
        $<$<CONFIG:Debug>:-g>
        $<$<CONFIG:Release>:-O3>
    )
endif()

# ============================================================================
# App Icon Generation (macOS)
# ============================================================================
set(APP_ICON_PNG "${CMAKE_SOURCE_DIR}/src/resources/images/appicon.png")
set(APP_ICON_ICNS "${CMAKE_BINARY_DIR}/AppIcon.icns")

if(APPLE AND EXISTS "${APP_ICON_PNG}")
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/icon_temp"
    )
    
    add_custom_command(
        OUTPUT "${APP_ICON_ICNS}"
        COMMAND ${CMAKE_SOURCE_DIR}/scripts/create-icns-from-png.sh "${APP_ICON_PNG}" "${APP_ICON_ICNS}"
        DEPENDS "${APP_ICON_PNG}" "${CMAKE_SOURCE_DIR}/scripts/create-icns-from-png.sh"
        COMMENT "Generating app icon from appicon.png..."
        VERBATIM
    )
    add_custom_target(generate_icon ALL DEPENDS "${APP_ICON_ICNS}")
    add_dependencies(appCloudMusic generate_icon)
    
    set_source_files_properties("${APP_ICON_ICNS}" PROPERTIES
        MACOSX_PACKAGE_LOCATION Resources
        GENERATED TRUE
    )
    target_sources(appCloudMusic PRIVATE "${APP_ICON_ICNS}")
endif()

# ============================================================================
# Target Properties
# ============================================================================
set_target_properties(appCloudMusic PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.cloudmusic.app
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE_BUNDLE_NAME "CloudMusic"
    MACOSX_BUNDLE_INFO_STRING "CloudMusic - A Modern Qt-based Music Player"
    MACOSX_BUNDLE_ICON_FILE AppIcon
    MACOSX_BUNDLE_COPYRIGHT "Copyright © 2026 CloudMusic Team"
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "-"
    XCODE_ATTRIBUTE_CODE_SIGN_ENTITLEMENTS ""
    XCODE_ATTRIBUTE_ENABLE_HARDENED_RUNTIME YES
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "com.cloudmusic.app"
)

# ============================================================================
# Link Libraries
# ============================================================================
target_link_libraries(appCloudMusic PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::Qml
    Qt6::Gui
    Qt6::Network
    Qt6::Multimedia
)

# ============================================================================
# Installation
# ============================================================================
install(TARGETS appCloudMusic
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# ============================================================================
# Platform-Specific: macOS Code Signing
# ============================================================================
if(APPLE)
    add_custom_command(TARGET appCloudMusic POST_BUILD
        COMMAND codesign --force --deep --sign - "$<TARGET_BUNDLE_DIR:appCloudMusic>"
        COMMENT "Ad-hoc signing the application bundle..."
        VERBATIM
    )
endif()

# ============================================================================
# Platform-Specific: macOS DMG Packaging
# ============================================================================
if(APPLE)
    find_program(MACDEPLOYQT_EXECUTABLE macdeployqt HINTS "${Qt6_DIR}/../../../bin")
    
    if(MACDEPLOYQT_EXECUTABLE)
        add_custom_target(deploy
            COMMAND "${MACDEPLOYQT_EXECUTABLE}" 
                "$<TARGET_BUNDLE_DIR:appCloudMusic>" 
                -qmldir="${CMAKE_SOURCE_DIR}/src/ui" 
                -codesign=-
            DEPENDS appCloudMusic
            COMMENT "Running macdeployqt to bundle Qt dependencies..."
        )
        
        add_custom_target(packageDmg
            COMMAND ${CMAKE_COMMAND} -E echo "Creating DMG package..."
            COMMAND ${CMAKE_SOURCE_DIR}/scripts/create-dmg.sh 
                "$<TARGET_BUNDLE_DIR:appCloudMusic>"
                "${CMAKE_BINARY_DIR}/CloudMusic-${PROJECT_VERSION}.dmg"
                "CloudMusic"
            DEPENDS deploy
            COMMENT "Creating DMG installer..."
        )
    else()
        message(WARNING "macdeployqt not found. DMG packaging will not be available.")
    endif()
endif()

# ============================================================================
# Testing
# ============================================================================
if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

# ============================================================================
# Documentation
# ============================================================================
if(BUILD_DOCS)
    find_package(Doxygen)
    if(DOXYGEN_FOUND)
        add_subdirectory(docs)
    else()
        message(WARNING "Doxygen not found. Documentation will not be built.")
    endif()
endif()

# ============================================================================
# Print Configuration Summary
# ============================================================================
message(STATUS "")
message(STATUS "CloudMusic Configuration Summary")
message(STATUS "================================")
message(STATUS "Version:           ${PROJECT_VERSION}")
message(STATUS "Build Type:        ${CMAKE_BUILD_TYPE}")
message(STATUS "C++ Standard:      ${CMAKE_CXX_STANDARD}")
message(STATUS "Qt Version:        ${Qt6_VERSION}")
message(STATUS "Build Tests:       ${BUILD_TESTS}")
message(STATUS "Build Docs:        ${BUILD_DOCS}")
message(STATUS "Enable Logging:    ${ENABLE_LOGGING}")
message(STATUS "Enable Analytics:  ${ENABLE_ANALYTICS}")
message(STATUS "Install Prefix:    ${CMAKE_INSTALL_PREFIX}")
message(STATUS "================================")
message(STATUS "")
