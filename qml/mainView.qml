import QtQuick 2.0
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    visibility: "FullScreen"

    Loader {
        id: pageLoader
        anchors.fill: parent
        sourceComponent: Qt.createComponent("main0.qml")
    }

    Timer {
        interval: 5010
        running: true
        repeat: false
        onTriggered: pageLoader.sourceComponent = Qt.createComponent("main.qml")
    }
}
