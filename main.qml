import QtQuick 2.11
import QtQuick.Controls 2.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Baca AIN0 LabJack"

    Rectangle {
        width: parent.width
        height: parent.height

        Text {
            text: "Nilai AIN0 dari LabJack:"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: labjackReader.read_ain0().toFixed(2)
            font.pixelSize: 24
            anchors.centerIn: parent
        }
    }
}
