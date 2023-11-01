import QtQuick 2.15
import QtQuick.Controls 2.15

// Definisi Footer
Item {
    id: appFooter
    height: 30

    Rectangle {
        color: "#2c3e50" // Ganti dengan warna latar belakang yang Anda inginkan
        anchors.fill: parent
    }

    Text {
        text: "© 2023 Nama Anda"
        color: "white" // Ganti dengan warna teks yang sesuai
        anchors.centerIn: parent
    }
}
