import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: appHeader
    color: "#3498db"
    height: 30

    RowLayout {
        anchors.fill: parent

        Text {
            id: titleHeader
            text: "Test Bench Expert"
            font.pixelSize: 16
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            leftPadding: 10
        }

        Text {
            id: versionLabel
            text: "V 1.0.1"
            font.pixelSize: 14
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            leftPadding: 10
        }

        // Dropdown untuk memilih konfigurasi
        ComboBox {
            id: configDropdown
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            model: parameterModel
            textRole: "display"

            onActivated: {
                var selectedParameter = configDropdown.model.get(activatedIndex).display
                mainApp.parameterSelected(selectedParameter)
            }
        }

        Button {
            text: "Apply"
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            onClicked: {
                var selectedParameter = configDropdown.model.get(configDropdown.currentIndex).display
                mainApp.parameterSelected(selectedParameter)
            }
        }

        // Tombol untuk menutup aplikasi
        MouseArea {
            id: closeButtonArea
            anchors.fill: parent
            onClicked: {
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
}
