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
            height: 30
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            model: parameterModel
            textRole: "display"

            onActivated: {
                var selectedParameter = configDropdown.model.get(currentIndex).display
                mainApp.parameterSelected(selectedParameter)
            }
        }

        Button {
            height: 30
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
            width: 30
            height: 30
            onClicked: {
                Qt.quit();
            }

            Rectangle {
                width: 30
                height: 30
                radius: width / 2
                color: "#e74c3c" // Warna merah
                border.color: "#c0392b"
                border.width: 1
            }
        }
    }
}
