cmake_minimum_required(VERSION 3.16)

project(CloudMusic VERSION 0.1 LANGUAGES CXX)

# Set default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Build type" FORCE)
endif()

# Set Qt policies
if(POLICY CMP0071)
    cmake_policy(SET CMP0071 NEW)
endif()
if(POLICY CMP0100)
    cmake_policy(SET CMP0100 NEW)
endif()

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)

find_package(Qt6 REQUIRED COMPONENTS Quick)

# Set Qt QML policies (must be after find_package)
if(COMMAND qt_policy)
    qt_policy(SET QTP0001 NEW)
    qt_policy(SET QTP0004 NEW)
endif()


qt_add_executable(appCloudMusic
    main.cpp
)

# Set singleton property before adding to module
set_source_files_properties(
    resources/qml/src/viewmodels/SearchViewModel.qml
    resources/qml/src/viewmodels/MusicPlayerViewModel.qml  
    resources/qml/src/viewmodels/ContentViewModel.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(appCloudMusic
    URI CloudMusic
    VERSION 1.0
    QML_FILES
        resources/qml/src/Main.qml
        resources/qml/src/leftpage/MyLeftRect.qml
        resources/qml/src/righpage/MyRightRect.qml
        resources/qml/src/bottompage/MyBottomRect.qml
        resources/qml/src/leftpage/MyLeftTopRect.qml
        resources/qml/src/leftpage/MyLeftBottomRect.qml
        resources/qml/src/righpage/MyRightTopRect.qml
        resources/qml/src/righpage/MyRightBottomRect.qml
        resources/qml/src/commonui/MyWindowRect.qml
        resources/qml/src/commonui/MyImageRect.qml
        resources/qml/src/leftpage/components/MenuItem.qml
        resources/qml/src/leftpage/components/SectionHeader.qml
        resources/qml/src/leftpage/components/Divider.qml
        resources/qml/src/righpage/components/topbar/WindowControl.qml
        resources/qml/src/righpage/components/topbar/SearchBar.qml
        resources/qml/src/righpage/components/topbar/IconButton.qml
        resources/qml/src/righpage/components/topbar/TextButton.qml
        resources/qml/src/righpage/components/topbar/RankingCard.qml
        resources/qml/src/righpage/components/topbar/SearchSuggestionPopup.qml
        resources/qml/src/righpage/components/topbar/HotSearchPopup.qml
        resources/qml/src/righpage/components/topbar/LoginPopup.qml
        resources/qml/src/viewmodels/SearchViewModel.qml
        resources/qml/src/viewmodels/MusicPlayerViewModel.qml
        resources/qml/src/viewmodels/ContentViewModel.qml
        resources/qml/src/righpage/components/bannerswiper/BannerSwiper.qml
        resources/qml/src/righpage/components/songlist/SongListCard.qml
        resources/qml/src/righpage/components/audiobook/AudioBookCard.qml
        resources/qml/src/bottompage/components/AlbumCover.qml
        resources/qml/src/bottompage/components/SongInfo.qml
        resources/qml/src/bottompage/components/ActionButton.qml
        resources/qml/src/bottompage/components/PlayButton.qml
        resources/qml/src/bottompage/components/ControlButton.qml
        resources/qml/src/bottompage/components/ProgressBar.qml
        resources/qml/src/bottompage/components/PlaylistDrawer.qml
        resources/qml/src/theme/Theme.qml
    RESOURCES
        resources/qml/src/theme/qmldir
        resources/qml/src/righpage/components/topbar/qmldir
        resources/qrc/icon/left.svg
        resources/qrc/icon/down.svg
        resources/qrc/icon/down_s.svg
        resources/qrc/icon/people.svg
        resources/qrc/icon/mic.svg
        resources/qrc/icon/setting.svg
        resources/qrc/icon/music.svg
)

# Generate app icon from PNG
set(APP_ICON_PNG "${CMAKE_SOURCE_DIR}/resources/image/appicon.png")
set(APP_ICON_ICNS "${CMAKE_BINARY_DIR}/AppIcon.icns")

if(APPLE AND EXISTS "${APP_ICON_PNG}")
    # Always generate icon at configure time for development builds
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
    
    # Set app icon for macOS bundle
    set_source_files_properties("${APP_ICON_ICNS}" PROPERTIES
        MACOSX_PACKAGE_LOCATION Resources
        GENERATED TRUE
    )
    target_sources(appCloudMusic PRIVATE "${APP_ICON_ICNS}")
endif()

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appCloudMusic PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.cloudmusic.app
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE_BUNDLE_NAME "CloudMusic"
    MACOSX_BUNDLE_INFO_STRING "CloudMusic - A Qt-based Music Player"
    MACOSX_BUNDLE_ICON_FILE AppIcon
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "-"
    XCODE_ATTRIBUTE_CODE_SIGN_ENTITLEMENTS ""
    XCODE_ATTRIBUTE_ENABLE_HARDENED_RUNTIME YES
)

target_link_libraries(appCloudMusic
    PRIVATE 
    Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appCloudMusic
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# macOS code signing
if(APPLE)
    # Ad-hoc code signing for development
    add_custom_command(TARGET appCloudMusic POST_BUILD
        COMMAND codesign --force --deep --sign - "$<TARGET_BUNDLE_DIR:appCloudMusic>"
        COMMENT "Ad-hoc signing the application bundle..."
        VERBATIM
    )
endif()

# macOS DMG packaging
if(APPLE)
    # Deploy Qt dependencies
    find_program(MACDEPLOYQT_EXECUTABLE macdeployqt HINTS "${Qt6_DIR}/../../../bin")
    
    if(MACDEPLOYQT_EXECUTABLE)
        add_custom_target(deploy
            COMMAND "${MACDEPLOYQT_EXECUTABLE}" "$<TARGET_BUNDLE_DIR:appCloudMusic>" -qmldir="${CMAKE_SOURCE_DIR}/resources/qml/src" -codesign=-
            DEPENDS appCloudMusic
            COMMENT "Running macdeployqt to bundle Qt dependencies..."
        )
        
        # Create DMG
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
