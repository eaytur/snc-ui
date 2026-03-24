qt_add_executable(snc_ui_gallery
    main.cpp
)

qt_add_qml_module(snc_ui_gallery
    URI SncUiGallery
    VERSION 1.0
    QML_FILES
        Main.qml
)

target_link_libraries(snc_ui_gallery
    PRIVATE
        Qt6::Quick
        Qt6::QuickControls2
        snc_ui_qml
)