import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: appHeader
    color: "#2c3e50"
    height: 30

    RowLayout {
        anchors.fill: parent

        Text {
            id: titleHeader
            text: "Test Bench Expert"
            font.pixelSize: 16
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            color: "white"
        }

        Text {
            id: versionLabel
            text: "V 1.0.1"
            font.pixelSize: 14
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        // Tombol untuk menutup aplikasi
        MouseArea {
            id: closeButtonArea
            width: 30
            height: 30
            onClicked: {
                Qt.quit();
            }

            Rectangle {
                width: 30
                height: 30
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                radius: width / 2
                color: "#e74c3c"
                border.color: "#c0392b"
                border.width: 1
            }
        }
    }
}
