import QtQuick 2.0
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    flags: Qt.FramelessWindowHint
    width: 640
    height: 480

    StackView {
        id: stackView
        initialItem: "main0.qml"
        anchors.fill: parent
    }

    Timer {
        interval: 5010
        running: true
        onTriggered: stackView.push("main.qml")
    }
}
