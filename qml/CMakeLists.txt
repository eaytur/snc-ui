set_source_files_properties(ThemeMode.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

set(SNC_QML_FILES
    ThemeMode.qml
    Theme.qml
    SncPanel.qml
    SncButton.qml
    SncLabel.qml
    SncSlider.qml
    SncStatusBadge.qml
    SncStatCard.qml
    SncTextField.qml
    SncComboBox.qml
    SncSwitch.qml
    SncCircularProgress.qml
    SncLedIndicator.qml
    SncConsole.qml
    SncCoordinateDisplay.qml
    SncJogButton.qml
    SncNumberInput.qml
    SncTabBar.qml
    SncDivider.qml
    SncToolCard.qml
    SncSparkline.qml
    SncGauge.qml
)

qt_add_qml_module(snc_ui_qml
    URI Snc.Ui
    VERSION 1.0
    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml/Snc/Ui
    QML_FILES ${SNC_QML_FILES}
)

install(TARGETS snc_ui_qml snc_ui_qmlplugin
    EXPORT SncUiTargets
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
)

install(EXPORT SncUiTargets
    FILE SncUiTargets.cmake
    NAMESPACE SncUi::
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/SncUi"
)

install(FILES ${SNC_QML_FILES}
    "${CMAKE_BINARY_DIR}/qml/Snc/Ui/qmldir"
    DESTINATION "${SNCUI_QML_INSTALL_DIR}/Snc/Ui"
)

install(TARGETS snc_ui_qmlplugin
    RUNTIME DESTINATION "${SNCUI_QML_INSTALL_DIR}/Snc/Ui"
    LIBRARY DESTINATION "${SNCUI_QML_INSTALL_DIR}/Snc/Ui"
)
