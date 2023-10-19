import QtQuick 2.11
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Contoh GUI QML"

    Rectangle {
        width: parent.width
        height: parent.height

        Text {
            text: "Selamat datang di GUI QML!"
            anchors.centerIn: parent
        }
    }
}
