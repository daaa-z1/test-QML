import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: appHeader
    color: "#3498db"
    height: 30

    Text {
        id: titleHeader
        text: "Test Bench Expert"
        font.pixelSize: 16
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: 10
    }

    Text {
        text: "V 1.0.1"
        font.pixelSize: 14
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
    }

    // Tombol untuk menutup aplikasi
    Rectangle {
        id: closeButton
        width: 30
        height: parent.height
        radius: 15
        color: "red"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: Qt.quit() // Menutup aplikasi saat tombol diklik
        }
    }
}
