import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Rectangle {
    width: parent.width
    height: parent.height
    color: "#1E2C3C" // Warna biru gelap

    Text {
        text: "Aplikasi Uji Servo Valve Hydraulic"
        font.pixelSize: 24
        color: "white"
        anchors.centerIn: parent
    }

    ProgressBar {
        width: parent.width * 0.8
        height: 20
        anchors.centerIn: parent
        from: 0
        to: 100
        value: 0
    }
}
