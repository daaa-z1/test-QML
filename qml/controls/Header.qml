import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: appHeader
    color: "#3498db"
    height: 30

    Text {
        text: "Aplikasi Servo Valve"
        font.pixelSize: 18
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: 10
    }

    Text {
        text: "V 1.0.1"
        font.pixelSize: 15
        anchors.right: closeButton.left
        anchors.verticalCenter: parent.verticalCenter
        rightPadding: 10
    }

    // Tombol untuk menutup aplikasi
    Rectangle {
        width: 15
        height: parent.height
        color: "red"
        MouseArea {
            anchors.fill: parent
            onClicked: Qt.quit() // Menutup aplikasi saat tombol diklik
        }
    }
}
