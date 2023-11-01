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
        id: closeArea
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        width: 30
        height: 30
        onClicked: Qt.quit()
        onPressed: {
                    closeEffect.source = closeArea
                    closeEffect.start()
        }

        Rectangle {
            width: 30
            height: 30
            radius: 15
        }

        DropShadow {
                id: closeEffect
                horizontalOffset: 2
                verticalOffset: 2
                radius: 10
                samples: 16
                color: "red"
                source: null
            }
    }
}
