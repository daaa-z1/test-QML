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
    MouseArea {
        id: closeButtonArea
        anchors {
            right: parent.right + 0.3
            verticalCenter: parent.verticalCenter
        }
        width: 30
        height: 30
        onClicked:{
            Qt.quit();
        }

        Rectangle {
            width: parent.width
            height: parent.height

            radius: width / 2
            color: "#e74c3c" // Warna merah
            border.color: "#c0392b"
            border.width: 1
        }
    }
}
